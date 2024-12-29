const std = @import("std");
const ascii = std.ascii;
const mem = std.mem;
const assert = std.debug.assert;

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const file_contents = try readFile("samples/simple.toml", allocator);
    defer allocator.free(file_contents);

    tokenize(file_contents);

    // std.debug.print("{s}\n", .{file_contents});
}

fn tokenize(content: []u8) void {
    var i: u32 = 0;
    while (i < content.len) {
        const character = content[i];
        // Skip whitespaces
        if (ascii.isWhitespace(character)) {
            i += 1;
            continue;
        }

        const is_comment_token = character == '#';
        if (is_comment_token) {
            // Read until the end of a comment
            while (i < content.len and content[i] != '\n') {
                i += 1;
            }
            continue;
        }

        const is_left_bracket_token = character == '[';
        if (is_left_bracket_token) {
            std.debug.print("Found a left bracket\n", .{});
        }

        i += 1;
    }
}

fn readFile(filepath: []const u8, allocator: std.mem.Allocator) ![]u8 {
    const file = try std.fs.cwd().openFile(filepath, .{});
    defer file.close();

    const stat = try file.stat();
    assert(stat.kind == .file);

    const file_contents = try file.readToEndAlloc(allocator, std.math.maxInt(usize));

    return file_contents;
}
