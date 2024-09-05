# Arrow Through The Heart: Understanding Zig Pointers with JoJo's Bizarre Adventure

## The Power of Pointers in Zig

In Zig, pointers are like the Stand Arrow in JoJo's Bizarre Adventure. They have the power to reference and modify data directly, much like how the Stand Arrow can dramatically change a Stand's abilities. Let's explore this concept using the battle for the Requiem Arrow from Golden Wind.

## The Code: The Requiem Arrow's Journey

```zig
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
```

## Output

```
Polnareff has the arrow, targeting Silver Chariot...
Diavolo attempts to take the arrow, now targeting King Crimson...
The arrow reacts! Silver Chariot becomes Chariot Requiem!
Chariot Requiem swaps souls, the arrow is up for grabs!
Giorno finally obtains the arrow!
Giorno pierces Gold Experience with it.

After the arrow pierces:
- Gold Experience Requiem (Power: 100, Ability: Return to Zero)
```

## Explanation: The Bizarre Adventure of Pointers

1. **Stand and StandArrow Structures**:
   ```zig
   const Stand = struct {
       name: []const u8,
       power: u8,
       ability: []const u8,
   };

   const StandArrow = struct {
       target: ?*Stand,
       fn pierce(self: *StandArrow) void {
           // ...
       }
   };
   ```
   Here, we define two structures: `Stand` and `StandArrow`. The `StandArrow` has a `target` field of type `?*Stand`, which is an optional pointer to a `Stand`. This represents the Arrow's ability to "target" a Stand.

2. **Creating Stands**:
   ```zig
   var goldExperience = createStand("Gold Experience", 80, "Life Creation");
   var kingCrimson = createStand("King Crimson", 90, "Time Erasure");
   var silverChariot = createStand("Silver Chariot", 75, "Sword Mastery");
   ```
   We create three Stands using the `createStand` function. These are stored in variables, which have memory addresses.

3. **Pointer Magic Begins**:
   ```zig
   var requiemArrow = StandArrow{ .target = null };
   requiemArrow.target = &silverChariot;
   ```
   We create a `StandArrow` and set its `target` to the address of `silverChariot`. The `&` operator is used to get the memory address (pointer) of a variable.

4. **Changing Targets**:
   ```zig
   requiemArrow.target = &kingCrimson;
   ```
   We change the `target` of the arrow to `kingCrimson`. This demonstrates how pointers can be reassigned to point to different objects.

5. **Modifying Through Pointers**:
   ```zig
   silverChariot.name = "Chariot Requiem";
   silverChariot.ability = "Soul Manipulation";
   ```
   Even though `silverChariot` is no longer the target of the arrow, we can still modify it directly. This shows that pointers are not necessary for modification if we have direct access to the variable.

6. **Optional Pointers**:
   ```zig
   requiemArrow.target = null;
   ```
   Setting the `target` to `null` demonstrates the use of optional pointers. It's like the arrow is not pointing to any Stand at the moment.

7. **The Pierce Function**:
   ```zig
   fn pierce(self: *StandArrow) void {
       if (self.target) |stand| {
           if (std.mem.eql(u8, stand.name, "Gold Experience")) {
               stand.name = "Gold Experience Requiem";
               stand.power = 100;
               stand.ability = "Return to Zero";
           }
       }
   }
   ```
   This function uses pointer dereferencing. `if (self.target) |stand|` checks if the pointer is not null and if so, gives us direct access to the Stand it points to. We then modify the Stand's properties directly through this dereferenced pointer.

8. **The Final Pierce**:
   ```zig
   requiemArrow.target = &goldExperience;
   requiemArrow.pierce();
   ```
   We set the arrow's target to `goldExperience` and call the `pierce` function. This function modifies the Stand through the pointer, transforming Gold Experience into Gold Experience Requiem.

## The Bizarre Truth of Pointers

1. Pointers hold memory addresses of variables, allowing indirect access and modification.
2. The `&` operator is used to get the address (pointer) of a variable.
3. Optional pointers (`?*Type`) can be `null`, representing the absence of a valid address.
4. Pointers can be reassigned to point to different objects of the same type.
5. Dereferencing a pointer gives direct access to the value it points to, allowing modification.

In this example, pointers act much like the Stand Arrow, having the power to target and fundamentally change Stands. They provide a way to indirectly access and modify data, offering flexibility and power in your Zig programs.

Remember, with great power comes great responsibility. Use pointers wisely in your Zig adventures, and may your code be as bizarre and fascinating as JoJo itself!
