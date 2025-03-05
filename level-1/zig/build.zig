const std = @import("std");
const text = "hello world";

pub fn main() void {
    std.debug.print("{s}\n", .{text});
}
