const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "spectre",
        .root_source_file = .{ .cwd_relative = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    exe.addLibraryPath(.{ .cwd_relative = "/opt/homebrew/lib" });
    exe.addIncludePath(.{ .cwd_relative = "/opt/homebrew/include" });

    exe.linkSystemLibrary("glfw");
    exe.linkFramework("OpenGL");
    exe.linkFramework("Cocoa");
    exe.linkFramework("IOKit");
    exe.linkFramework("CoreVideo");

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
