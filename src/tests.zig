const std = @import("std");
const Vec = @import("stdzig/stdzig.zig").collections.Vec;


test "fixed-vec" {
    var msg: Vec(u8) = Vec(u8).init_fixed(3);

    msg.push('h');
    std.debug.print("{s}\n", .{msg.slice_ref()});

    msg.push('i');
    std.debug.print("{s}\n", .{msg.slice_ref()});

    msg.push('\n');
    std.debug.print("{s}\n", .{msg.slice_ref()});

    // This will panic
    msg.push(32);
    std.debug.print("{s}\n", .{msg.slice_ref()});
}
