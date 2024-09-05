const std = @import("std");

const Stand = struct {
    name: []const u8,
    ability: []const u8,
};

const GoldExperience = struct {
    const Self = @This();

    // simulate gold experience's life-giving ability at compile-time
    pub fn createLife(comptime object: []const u8) []const u8 {
        return object ++ " transformed into a living organism";
    }
};

const KingCrimson = struct {
    const Self = @This();

    // epitaph: predict future events at compile-time
    pub fn epitaph(comptime action: []const u8) []const u8 {
        return "Epitaph predicts: " ++ action;
    }

    // time erasure: skip to the result of an action
    pub fn eraseTime(comptime result: []const u8) []const u8 {
        return "Time erased, outcome: " ++ result;
    }
};

fn simulateBattle(comptime giorno_action: []const u8, comptime diavolo_reaction: []const u8) []const u8 {
    const giorno_move = GoldExperience.createLife(giorno_action);
    const diavolo_prediction = KingCrimson.epitaph(giorno_move);
    const battle_result = KingCrimson.eraseTime(diavolo_reaction);

    return std.fmt.comptimePrint(
        \\Battle simulation:
        \\1. Giorno: {s}
        \\2. Diavolo: {s}
        \\3. Outcome: {s}
    , .{ giorno_move, diavolo_prediction, battle_result });
}

pub fn main() void {
    const giorno = Stand{ .name = "Gold Experience", .ability = "Give life to inanimate objects" };
    const diavolo = Stand{ .name = "King Crimson", .ability = "Erase time and epitaph" };

    // compile-time battle simulation
    const battle_result = comptime simulateBattle("brick", "avoid the transformed creature");
    std.debug.print("{s}\n", .{battle_result});

    // runtime stand description
    const describeStand = struct {
        fn describe(stand: Stand) void {
            std.debug.print("Stand: {s}, Ability: {s}\n", .{ stand.name, stand.ability });
        }
    }.describe;

    describeStand(giorno);
    describeStand(diavolo);

    // This would cause a compile-time error, as we can't use runtime values in comptime functions
    // Uncomment to see the error:
    // var user_input = "rock";
    // const error_simulation = simulateBattle(user_input, "dodge");
}
