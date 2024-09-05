const std = @import("std");

const Stand = struct {
    name: []const u8,
    power: u8,
};

const StandUser = struct {
    name: []const u8,
    stand: ?Stand,
};

fn pierceWithArrow(character: *StandUser) void {
    const random = std.crypto.random;
    const stand_chance = random.intRangeAtMost(u8, 1, 100);

    if (stand_chance > 50) {
        const stand_name = if (std.mem.eql(u8, character.name, "Kira"))
            "Killer Queen"
        else
            "New Stand";

        character.stand = Stand{
            .name = stand_name,
            .power = random.intRangeAtMost(u8, 50, 100),
        };
        std.debug.print("{s} developed the Stand '{s}'!\n", .{ character.name, stand_name });
    } else {
        std.debug.print("{s} was unaffected by the arrow.\n", .{character.name});
    }
}

fn useStandPower(character: *const StandUser) void {
    // this use of .? will crash the program if the character has no Stand
    const stand = character.stand.?;
    std.debug.print("{s} uses their Stand '{s}' with power: {}\n", .{ character.name, stand.name, stand.power });
}

pub fn main() !void {
    var characters = [_]StandUser{
        .{ .name = "Jotaro", .stand = Stand{ .name = "Star Platinum", .power = 95 } },
        .{ .name = "Koichi", .stand = null },
        .{ .name = "Kira", .stand = null },
    };

    for (&characters) |*character| {
        if (character.stand == null) {
            std.debug.print("\n{s} encounters the Stand Arrow...\n", .{character.name});
            pierceWithArrow(character);
        }

        std.debug.print("Attempting to use {s}'s Stand power...\n", .{character.name});
        useStandPower(character); // This will crash if the character has no Stand
    }
}
