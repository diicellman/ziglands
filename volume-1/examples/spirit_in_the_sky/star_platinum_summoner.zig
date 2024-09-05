const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    std.debug.print("Stand User: Jotaro Kujo\n", .{});

    // initialize the child process to summon Star Platinum
    var stand_summoner = std.process.Child.init(&[_][]const u8{
        "echo",
        "ORA ORA ORA! Star Platinum has been summoned!",
    }, allocator);

    std.debug.print("Attempting to summon Stand...\n", .{});

    // spawn the child process and wait for it to complete
    const result = try stand_summoner.spawnAndWait();

    switch (result) {
        .Exited => |code| {
            if (code == 0) {
                std.debug.print("Stand summoned successfully!\n", .{});
            } else {
                std.debug.print("Failed to summon Stand. Exit code: {}\n", .{code});
            }
        },
        else => std.debug.print("An unexpected error occurred while summoning the Stand.\n", .{}),
    }

    std.debug.print("Yare yare daze...\n", .{});
}
