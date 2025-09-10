const std = @import("std");


const allocator = std.heap.page_allocator;


pub fn Vec(comptime T: type) type { return struct {
    inner: [*]T,
    len: usize,
    capacity: usize,

    /// Create a new empty Vec
    pub fn init() Vec(T) {
        const capacity: usize = 1;
        const inner: [*]T = (allocator.alloc(T, capacity) catch unreachable).ptr;

        return Vec(T){ .inner = inner, .len = 0, .capacity = capacity };
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

    /// Add an element to this Vec
    pub fn push(self: *Vec(T), element: T) void {
        // Increase length by one
        self.len += 1;

        // If the vector's size is larger than its capacity, allocate more space
        if (self.len * @sizeOf(T) > self.capacity) {
            self.capacity *= 2;

            self.inner = @ptrCast(allocator.realloc(self.inner[0..self.len], self.capacity)
                catch unreachable);

            //realloc(self.inner, self.capacity);
        }

        // Add the element
        self.inner[self.len-1] = element;
    }

    /// Get this Vec as a slice of type `T`
    pub fn as_slice(self: *const Vec(T)) []const T {
        return self.inner[0..self.len];
    }

    /// Deinitialize existing Vec
    pub fn deinit(self: *Vec(T)) void {
        allocator.free(self.inner);
    }
};}
