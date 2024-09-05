const std = @import("std");

const StandUser = struct {
    name: []const u8,
    is_pursued: bool,
};

const CausalityError = error{
    Calamity,
};

fn pursueTarget(pursuer: []const u8, target: *StandUser) CausalityError!void {
    if (target.is_pursued) {
        std.debug.print("{s} is pursuing {s}!\n", .{ pursuer, target.name });
        return error.Calamity;
    }

    target.is_pursued = true;
    std.debug.print("{s} starts pursuing {s}.\n", .{ pursuer, target.name });
}

fn triggerCalamity(pursuer: []const u8) noreturn {
    std.debug.print("A calamity befalls {s}!\n", .{pursuer});
    unreachable;
}

pub fn main() !void {
    var wonder_of_u = StandUser{ .name = "Wonder of U", .is_pursued = false };

    const pursuers = [_][]const u8{ "Josuke", "Rai", "Yasuho" };

    for (pursuers) |pursuer| {
        pursueTarget(pursuer, &wonder_of_u) catch |err| {
            switch (err) {
                error.Calamity => triggerCalamity(pursuer),
            }
        };
    }
}
