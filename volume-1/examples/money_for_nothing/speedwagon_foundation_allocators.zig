const std = @import("std");

const Transport = struct {
    type: []const u8,
    capacity: u32,
};

const MedicalSupport = struct {
    doctor: []const u8,
    equipment: [][]const u8,
};

const Research = struct {
    subject: []const u8,
    findings: []const u8,
};

fn requestHelicopter(allocator: std.mem.Allocator) !*Transport {
    const helicopter = try allocator.create(Transport);
    helicopter.type = try allocator.dupe(u8, "Helicopter");
    helicopter.capacity = 6;
    return helicopter;
}

fn provideMedicalSupport(allocator: std.mem.Allocator) !*MedicalSupport {
    const support = try allocator.create(MedicalSupport);
    support.doctor = try allocator.dupe(u8, "Dr. Speedwagon");
    support.equipment = try allocator.alloc([]const u8, 3);
    support.equipment[0] = try allocator.dupe(u8, "First Aid Kit");
    support.equipment[1] = try allocator.dupe(u8, "Stand Arrow Removal Tools");
    support.equipment[2] = try allocator.dupe(u8, "Hamon-infused Bandages");
    return support;
}

fn conductResearch(allocator: std.mem.Allocator, subject: []const u8) !*Research {
    const research = try allocator.create(Research);
    research.subject = try allocator.dupe(u8, subject);
    research.findings = try allocator.dupe(u8, "Ongoing - results inconclusive");
    return research;
}

pub fn main() !void {
    // speedwagon foundation's general purpose resource (GPA)
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const gpa_allocator = gpa.allocator();

    std.debug.print("Speedwagon Foundation deploying resources!\n\n", .{});

    // long-term support: general purpose allocator
    // used for ongoing research throughout the series
    const stone_mask_research = try conductResearch(gpa_allocator, "Stone Mask");
    defer {
        gpa_allocator.free(stone_mask_research.subject);
        gpa_allocator.free(stone_mask_research.findings);
        gpa_allocator.destroy(stone_mask_research);
    }

    std.debug.print("Ongoing Research: {s} - {s}\n\n", .{ stone_mask_research.subject, stone_mask_research.findings });

    // speedwagon foundation's temporary mission resource (arena allocator)
    var arena = std.heap.ArenaAllocator.init(gpa_allocator);
    defer arena.deinit();
    const arena_allocator = arena.allocator();

    // used for the journey to egypt in stardust crusaders
    {
        const helicopter = try requestHelicopter(arena_allocator);
        std.debug.print("Deployed: {s} for Joestar group, capacity: {d}\n", .{ helicopter.type, helicopter.capacity });

        var journey_log = std.ArrayList(u8).init(arena_allocator);
        try journey_log.appendSlice("Day 1: Departed Japan. Day 15: Arrived in Egypt.");
        std.debug.print("Journey Log: {s}\n\n", .{journey_log.items});
        // memory automatically freed when arena is deinitialized
    }

    // speedwagon foundation's limited resource operation (fixed buffer allocator)
    var fixed_buffer: [1000]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&fixed_buffer);
    const fba_allocator = fba.allocator();

    // used for quick medical support after a stand battle
    {
        const medical_support = try provideMedicalSupport(fba_allocator);
        std.debug.print("Medical Support Deployed:\n", .{});
        std.debug.print("Doctor: {s}\n", .{medical_support.doctor});
        std.debug.print("Equipment: {s}, {s}, {s}\n\n", .{ medical_support.equipment[0], medical_support.equipment[1], medical_support.equipment[2] });
        // memory automatically reclaimed when fixed_buffer goes out of scope
    }

    std.debug.print("Speedwagon Foundation continues to support the Joestar family!\n", .{});
}
