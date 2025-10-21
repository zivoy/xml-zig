const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardOptimizeOption(.{});

    const mod = b.addModule("xml", .{
        .root_source_file = b.path("Xml.zig"),
        .target = target,
        .optimize = mode,
    });

    const exe = b.addExecutable(.{
        .name = "xml",
        .root_module = mod,
    });

    b.installArtifact(exe);

    const main_tests = b.addTest(.{
        .root_module = mod,
    });

    const run_main_tests = b.addRunArtifact(main_tests);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&run_main_tests.step);
}
