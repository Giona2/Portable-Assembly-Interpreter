test "array-manip" {
    var test_array = [5]u8{1, 2, 3, 4, 5};
    std.debug.print("before: {any}\n", .{test_array});

    for (&test_array) |*value| {
        value.* = 0;
    }

    std.debug.print("after: {any}", .{test_array});
}
