pub fn inc_ptr(comptime T: type, ptr: **const T, n: usize) void {
    ptr.* = @ptrFromInt(@intFromPtr(ptr.*) + n);
}

/// Pointer to a type that allows for pointer arithmetic
pub fn Ptr(comptime T: type) type { return struct {
    address: usize,

    /// Wraps the given pointer in this
    pub fn new(ptr: *T) Ptr(T) {
        // Get the address of the given ponter
        const address = @intFromPtr(ptr);

        // Return the constructed object
        return Ptr(T){ .address = address };
    }

    /// Move to the pointer `n` slots away
    pub fn inc(self: *Ptr, n: usize) void {
        self.address += n;
    }

    /// Move to the pointer `n` slots away
    pub fn dec(self: *Ptr, n: usize) void {
        self.address -= n;
    }

    /// Returns an immutable reference to the underlying pointer
    pub fn ptr_ref(self: *Ptr) *const T {
        return @ptrFromInt(self.address);
    }

    /// Gets this as a mutable pointer
    pub fn as_ptr(self: *Ptr) *T {
        return @ptrFromInt(self.address);
    }
};}
