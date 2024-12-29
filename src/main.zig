const std = @import("std");
const expect = std.testing.expect;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const file_contents = try read_file("samples/pyproject.toml", allocator);
    defer allocator.free(file_contents);

    std.debug.print("{s}\n", .{file_contents});
}

fn read_file(filepath: []const u8, allocator: std.mem.Allocator) ![]u8 {
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();

    const stat = try file.stat();
    try expect(stat.kind == .file);

    const file_contents = try file.readToEndAlloc(allocator, std.math.maxInt(usize));

    return file_contents;
}
