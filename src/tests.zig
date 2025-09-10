const std = @import("std");
const incPtr = @import("stdzig/ptr.zig").inc_ptr;


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
    const array = [_]u8{1, 2, 3, 4, 5};
    var first_element = &array[0];

    std.debug.print("First element: {d}\n", .{first_element.*});

    incPtr(u8, &first_element);

    std.debug.print("Next element: {d}\n", .{first_element.*});
}
