const std = @import("std");

const Universe = struct {
    id: u32,
    task: []const u8,
};

pub fn main() !void {
    std.debug.print("D4C activates its ability!\n", .{});

    const universes = [_]Universe{
        .{ .id = 1, .task = "Find the Saint's Corpse Part" },
        .{ .id = 2, .task = "Eliminate the enemy Stand user" },
        .{ .id = 3, .task = "Secure alliance with alternate Valentine" },
    };

    var threads: [universes.len]std.Thread = undefined;

    // create threads for different universes
    for (universes, 0..) |universe, i| {
        threads[i] = try std.Thread.spawn(.{}, exploreUniverse, .{universe});
    }

    // wait for all universe explorations to complete
    for (threads) |thread| {
        thread.join();
    }

    std.debug.print("D4C returns to the base universe. Mission complete!\n", .{});
}

fn exploreUniverse(universe: Universe) void {
    std.debug.print("Entering Universe {d}...\n", .{universe.id});
    std.debug.print("Task in Universe {d}: {s}\n", .{ universe.id, universe.task });

    const exploration_time_ms = universe.id * 500;
    std.time.sleep(exploration_time_ms * std.time.ns_per_ms);

    std.debug.print("Exiting Universe {d}. Task completed.\n", .{universe.id});
}
