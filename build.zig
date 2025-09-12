const std = @import("std");


pub fn build(b: std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimizations = b.standardOptimizeOption(.{.preferred_optimize_mode = .ReleaseFast});

    const exe = b.addExecutable(.{
        .target = target,
        .optimize = optimizations,
        .root_source_file = b.path("src/main.zig")
    });

    b.installArtifact(exe);
}
