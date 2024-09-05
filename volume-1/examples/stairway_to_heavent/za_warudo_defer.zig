const std = @import("std");

pub fn main() void {
    std.debug.print("POLNAREFF starts climbing the stairs\n", .{});

    defer std.debug.print("POLNAREFF finds himself at the bottom of the stairs\n", .{});

    std.debug.print("POLNAREFF thinks he's approaching dio.\n", .{});

    // DIO's za warudoo ability
    {
        defer std.debug.print("time resumes.\n", .{});
        std.debug.print("DIO: ZA WARUDO00!!! \n", .{});
        std.debug.print("DIO moves POLNAREFF down the stairs.\n", .{});
    }

    std.debug.print("confused POLNAREFF. \n", .{});
}
