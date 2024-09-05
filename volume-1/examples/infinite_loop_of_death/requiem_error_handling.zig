const std = @import("std");

// define an error set for diavolo's actions
const DiavoloError = error{
    TimeErased,
    FutureSeen,
    TruthUnreached,
};

// function representing diavolo's attempts to reach the truth
fn diavoloAction() DiavoloError!void {
    // simulate diavolo's actions
    const random_number = std.crypto.random.intRangeAtMost(u8, 0, 2);

    return switch (random_number) {
        0 => DiavoloError.TimeErased,
        1 => DiavoloError.FutureSeen,
        2 => DiavoloError.TruthUnreached,
        else => unreachable,
    };
}

// function representing gold experience requiem's ability
fn goldExperienceRequiem() void {
    std.debug.print("Gold Experience Requiem: Returning to zero...\n", .{});
}

pub fn main() !void {
    var attempts: usize = 0;

    while (true) : (attempts += 1) {
        std.debug.print("Attempt {}: Diavolo tries to reach the truth...\n", .{attempts + 1});

        diavoloAction() catch |err| {
            switch (err) {
                DiavoloError.TimeErased => std.debug.print("King Crimson erased time, but...\n", .{}),
                DiavoloError.FutureSeen => std.debug.print("Epitaph saw the future, but...\n", .{}),
                DiavoloError.TruthUnreached => std.debug.print("Diavolo couldn't reach the truth...\n", .{}),
            }
            goldExperienceRequiem();
            continue;
        };

        // this line will never be reached due to gold experience requiem
        unreachable;
    }
}
