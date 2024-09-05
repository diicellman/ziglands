# Running with the Devil: Understanding Zig's `unreachable` with JoJo's Bizarre Adventure

## The Power of `unreachable` in Zig

In Zig, the `unreachable` keyword is like Wonder of U's calamity in JoJo's Bizarre Adventure: once you trigger it, there's no coming back. It's a powerful tool that tells the compiler "this code should never be executed" - much like how pursuing Wonder of U leads to inevitable disaster. Let's explore this concept using the pursuit of Wonder of U from JoJolion.

## The Code: Pursuing the Unpursuable

```zig
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
```

## Output: The Inevitable Calamity

```
Josuke starts pursuing Wonder of U.
Rai is pursuing Wonder of U!
A calamity befalls Rai!
thread 3194429 panic: reached unreachable code
```

## Explanation: The Bizarre Adventure of `unreachable`

1. **The Stand User Structure**:
   ```zig
   const StandUser = struct {
       name: []const u8,
       is_pursued: bool,
   };
   ```
   We define a `StandUser` structure to represent characters like Wonder of U. The `is_pursued` boolean is crucial - once it's true, calamity ensues.

2. **The Pursuit Function**:
   ```zig
   fn pursueTarget(pursuer: []const u8, target: *StandUser) CausalityError!void {
       if (target.is_pursued) {
           std.debug.print("{s} is pursuing {s}!\n", .{ pursuer, target.name });
           return error.Calamity;
       }
       target.is_pursued = true;
       std.debug.print("{s} starts pursuing {s}.\n", .{ pursuer, target.name });
   }
   ```
   This function simulates the act of pursuing Wonder of U. If Wonder of U is already being pursued, it triggers a `Calamity` error.

3. **The Calamity Trigger**:
   ```zig
   fn triggerCalamity(pursuer: []const u8) noreturn {
       std.debug.print("A calamity befalls {s}!\n", .{pursuer});
       unreachable;
   }
   ```
   Here's where `unreachable` comes into play. This function is marked as `noreturn`, indicating it will never return normally. After printing the calamity message, it hits `unreachable`, which is like running headfirst into Wonder of U's ability - there's no coming back.

4. **The Main Function**:
   ```zig
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
   ```
   In the main function, we create Wonder of U and a list of pursuers. Each pursuer attempts to chase Wonder of U. The first one succeeds, but the second triggers a calamity, leading to the `unreachable` code.

## The Bizarre Truth of `unreachable`

1. `unreachable` tells the compiler that this point in the code should never be reached.
2. If `unreachable` is reached at runtime, it causes a panic, crashing the program.
3. It's like pursuing Wonder of U - once you trigger the calamity, there's no turning back.
4. `unreachable` can be used to handle "impossible" situations or to satisfy the compiler in certain scenarios.
5. In our example, it's used to simulate the inevitable disaster of pursuing Wonder of U.

In this example, `unreachable` acts much like Wonder of U's stand ability. It's a point of no return, a line that, once crossed, leads to unavoidable calamity. Just as pursuing Wonder of U is a deadly mistake, reaching `unreachable` code is a critical error in your program.

Remember, with great power comes great responsibility. Use `unreachable` wisely in your Zig adventures, and may your code be as bizarre and fascinating as JoJo itself! After all, when you're running with the devil (or pursuing Wonder of U), you're bound to face some unreachable consequences!
