const std = @import("std");


pub fn build(b: *std.Build) void {
    // Declare the target and optimization mode
    const target = b.standardTargetOptions(.{});
    const optimize = std.builtin.OptimizeMode.ReleaseFast;

    // Create the executable reference
    const exe = b.addExecutable(.{
        .target = target,
        .optimize = optimize,

        .name = "pai",
        .root_source_file = b.path("src/main.zig")
    });

    // Expose the global variables to the executable
    include_globals(b, exe, &target, &optimize);

    // Compile the executable
    b.installArtifact(exe);
}

/// Compiles the global variables as a static library and links them to the main executable
fn include_globals(b: *std.Build, exe: *std.Build.Step.Compile, target: *const std.Build.ResolvedTarget, optimize: *const std.builtin.OptimizeMode) void {
    // Create the globals reference
    const globals = b.addStaticLibrary(.{
        .target = target.*,
        .optimize = optimize.*,

        .name = "globals",
        .root_source_file = b.path("src/globals.zig"),
    });

    // Compile the globals
    b.installArtifact(globals);

    // Link the global variables to the executable
    exe.linkLibrary(globals);
}
