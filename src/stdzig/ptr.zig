pub inline fn ptrFromAddr(comptime T: type, address: usize) *T {
    return @ptrFromInt(address);
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
    pub fn inc(self: *Ptr(T), n: usize) void {
        self.address += (n * @sizeOf(T));
    }

    /// Move to the pointer `n` slots away
    pub fn dec(self: *Ptr(T), n: usize) void {
        self.address -= (n * @sizeOf(T));
    }

    /// Get the address of this pointer
    pub fn addr(self: *const Ptr(T)) usize {
        return self.address;
    }

    /// Returns an immutable reference to the underlying pointer
    pub fn ptr_ref(self: *const Ptr(T)) *const T {
        return @ptrFromInt(self.address);
    }

    /// Gets this as a mutable pointer
    pub fn as_ptr(self: *Ptr(T)) *T {
        return @ptrFromInt(self.address);
    }
};}
