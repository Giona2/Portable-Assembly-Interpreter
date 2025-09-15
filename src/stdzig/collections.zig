const std = @import("std");


const allocator = std.heap.page_allocator;


pub const VecError = error {
    InvalidIndexGiven,
};


/// Heap allocated slice
///
/// Defer this with deinit()
pub fn Vec(comptime T: type) type { return extern struct {
    inner: [*]T,
    len: usize,
    capacity: usize,

    /// Create a new empty Vec
    pub fn init() Vec(T) {
        const capacity: usize = 1;
        const inner: [*]T = (allocator.alloc(T, capacity) catch unreachable).ptr;

        return Vec(T){ .inner = inner, .len = 0, .capacity = capacity };
    }

    /// Creates a new Vec and sets the first `n` elements to `value`
    pub fn init_predef(n: usize, value: T) Vec(T) {
        // Allocate the vector
        const capaticy: usize = n;
        var inner: [*]T = (allocator.alloc(T, capaticy) catch unreachable).ptr;

        // Fill the vector with the predefined value
        for (inner[0..n]) |*_value| {
            _value.* = value;
        }

        // Return the vector
        return Vec(T){ .inner = inner, .len = n, .capacity = capaticy };
    }

    /// Gets the pointer to the `n`th element in this Vec
    ///
    /// Returns an error if `n` is invalid
    pub fn get(self: *Vec(T), n: usize) VecError! *T {
        // Ensure the given index is valid
        if (n > self.len-1) return VecError.InvalidIndexGiven;

        // Return the pointer to `n`th element
        return &self.inner[n];
    }

    /// Construct a Vec(T) from the given value
    pub fn from(_from: []const T) Vec(T) {
        // Construct the result
        var result = Vec(T).init();

        // Push each value from `_from`
        for (_from) |value| {
            result.push(value);
        }

        // Return the result
        return result;
    }

    /// Creates a new Vec around an existing pointer
    ///
    /// Please ensure _from is heap allocated
    pub fn inherit(_from: []T) Vec(T) {
        return Vec(T){ .inner = _from.ptr, .len = _from.len, .capacity = _from.len };
    }

    /// Copy the content from and existing slice to the end of this Vec
    pub fn append(self: *Vec(T), _from: []const T) void {
        for (_from) |value| {
            self.push(value);
        }
    }

    /// Add an element to this Vec
    pub fn push(self: *Vec(T), element: T) void {
        // Increase length by one
        self.len += 1;

        // If the vector's size is larger than its capacity, allocate more space
        if (self.len >= self.capacity) {
            self.capacity *= 2;

            self.inner = @ptrCast(allocator.realloc(self.inner[0..self.len], self.capacity)
                catch unreachable);
        }

        // Add the element
        self.inner[self.len-1] = element;
    }

    /// Removes the last element from the Vec
    ///
    /// This does not overwrite the last element of the Vec
    pub fn shave(self: *Vec(T)) void {
        self.len -= 1;
    }

    /// Gets the last element of this vector
    pub fn last(self: *Vec(T)) VecError! *T {
        return (try self.get(self.len-1));
    }

    /// Returns a reference to this Vec as an immutable slice
    pub fn slice_ref(self: *const Vec(T)) []const T {
        return self.inner[0..self.len];
    }

    /// Gets this Vec as a mutable slice
    pub fn as_slice(self: *Vec(T)) []T {
        return self.inner[0..self.len];
    }

    /// Deinitialize existing Vec
    pub fn deinit(self: *const Vec(T)) void {
        allocator.free(self.inner[0..self.len]);
    }
};}
