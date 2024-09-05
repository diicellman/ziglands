const std = @import("std");

const Stand = struct {
    name: []const u8,
    power: u8,
    ability: []const u8,
};

const StandArrow = struct {
    target: ?*Stand,

    fn pierce(self: *StandArrow) void {
        if (self.target) |stand| {
            if (std.mem.eql(u8, stand.name, "Gold Experience")) {
                stand.name = "Gold Experience Requiem";
                stand.power = 100;
                stand.ability = "Return to Zero";
            }
        }
    }
};

fn createStand(name: []const u8, power: u8, ability: []const u8) Stand {
    return Stand{ .name = name, .power = power, .ability = ability };
}

pub fn main() void {
    var goldExperience = createStand("Gold Experience", 80, "Life Creation");
    var kingCrimson = createStand("King Crimson", 90, "Time Erasure");
    var silverChariot = createStand("Silver Chariot", 75, "Sword Mastery");

    // requiem Arrow
    var requiemArrow = StandArrow{ .target = null };

    // polnareff has the arrow
    requiemArrow.target = &silverChariot;
    std.debug.print("Polnareff has the arrow, targeting Silver Chariot...\n", .{});

    // diavolo tries to take the arrow
    requiemArrow.target = &kingCrimson;
    std.debug.print("Diavolo attempts to take the arrow, now targeting King Crimson...\n", .{});

    // silver chariot becomes chariot requiem
    silverChariot.name = "Chariot Requiem";
    silverChariot.ability = "Soul Manipulation";
    std.debug.print("The arrow reacts! Silver Chariot becomes {s}!\n", .{silverChariot.name});

    // chariot requiem swaps souls, the arrow is free
    requiemArrow.target = null;
    std.debug.print("Chariot Requiem swaps souls, the arrow is up for grabs!\n", .{});

    // giorno eventually gets the arrow
    requiemArrow.target = &goldExperience;
    std.debug.print("Giorno finally obtains the arrow!\n", .{});

    // pierce gold experience with the arrow
    std.debug.print("Giorno pierces Gold Experience with it.\n", .{});
    requiemArrow.pierce();

    // print the final state
    std.debug.print("\nAfter the arrow pierces:\n", .{});
    std.debug.print("- {s} (Power: {}, Ability: {s})\n", .{ goldExperience.name, goldExperience.power, goldExperience.ability });
}
