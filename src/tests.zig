const std = @import("std");
const Ptr = @import("stdzig/stdzig.zig").ptr.Ptr;


test "array-manip" {
    var test_array = [5]u8{1, 2, 3, 4, 5};
    std.debug.print("before: {any}\n", .{test_array});

    for (&test_array) |*value| {
        value.* = 0;
    }

    std.debug.print("after: {any}\n", .{test_array});
}

test "pointer-arith" {
    const test_array = [5]u8{1, 2, 3, 4, 5};
    const last_element_address: usize = @intFromPtr(&test_array[test_array.len-1]);

    var first_element_address: usize = @intFromPtr(&test_array[0]);
    while (first_element_address <= last_element_address) {
        const first_element: *u8 = @ptrFromInt(first_element_address);

        std.debug.print("{d}\n", .{first_element.*});

        first_element_address += 1;
    }
}

test "manip-ptr" {
    var array = [_]u8{1, 2, 3, 4, 5};
    var first_element: Ptr(u8) = Ptr(u8).new(&array[0]);

    std.debug.print("First element: {d}\n", .{first_element.ptr_ref().*});

    first_element.inc(1);

    std.debug.print("Next element: {d}\n", .{first_element.ptr_ref().*});
}

test "register-state" {
    // Set the r10 register to 1
    asm volatile (
        \\mov $1, %r10
        :
        :
        : "r10"
    );

    const r10_reg_state: i64 = asm("" : [ret] "={r10}" (-> i64));

    std.debug.print("{d}", .{r10_reg_state});
}
