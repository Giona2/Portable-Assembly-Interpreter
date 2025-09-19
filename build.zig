const std = @import("std");


pub fn build(b: *std.Build) void {
    // Declare the target and optimization mode
    const target = b.standardTargetOptions(.{});
    const optimize = std.builtin.OptimizeMode.ReleaseFast;

    // Create the executable reference
    const exe_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
        .root_source_file = b.path("src/main.zig"),
    });
    const exe = b.addExecutable(.{
        .name = "pai",
        .root_module = exe_mod,
    });

    // Expose the global variables to the executable
    include_globals(b, exe, &target, &optimize);

    // Compile the executable
    b.installArtifact(exe);
}

/// Compiles the global variables as a static library and links them to the main executable
fn include_globals(b: *std.Build, exe: *std.Build.Step.Compile, target: *const std.Build.ResolvedTarget, optimize: *const std.builtin.OptimizeMode) void {
    // Create the globals reference
    const globals_mod = b.createModule(.{
        .target = target.*,
        .optimize = optimize.*,

        .root_source_file = b.path("src/globals.zig"),
    });
    const globals = b.addLibrary(.{
        .name = "globals",
        .root_module = globals_mod,
    });

    // Compile the globals
    b.installArtifact(globals);

    // Link the global variables to the executable
    exe.linkLibrary(globals);
}
