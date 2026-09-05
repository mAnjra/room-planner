# Baby Dragon Poo

A room planner that runs from a single HTML file. Download it, double-click it,
and it works — no install, no server, no internet.

It started as a way to plan one awkward storage room: 203×203cm with a ceiling
sloping from 190cm down to 54cm. That constraint shaped the whole thing. Most
planners assume a flat ceiling and a rectangular room, which is exactly what a
loft, an eaves cupboard or an under-stairs space is not.

**[Download the latest release](../../releases/latest)** — grab
`room-planner_v4.html` and open it in any browser.

## What it does

**Any room shape.** Rectangles and L-shapes from a preset, or drag corners
around to draw whatever you actually have. Walls can sit at any angle, and
doors, windows, swing arcs and headroom all follow.

**Ceilings that slope.** Flat, sloping one way, peaked in the middle, or a
custom profile where you set the height at points across the room. A colour map
on the floor shows where you can stand, stoop, crouch, kneel or only crawl.

**Two views over one plan.** Work in the top-down **Plan** view, where you can
place things precisely — drag to move, hold Shift to raise and lower instead,
drag the handle to turn to any angle,
snap flush against walls and against each other, box-select several at once,
line them up. Check your work in the **Model** view, because headroom is the
whole point and you cannot see it from above.

**Shelving with real boards.** A shelving bay is a frame with boards in it, not
a solid block. Set how many boards and where, put boxes on a named board, and
the contents move, turn and lift with the bay. Each board tells you how easy it
is to reach and how much space is above it.

**An inventory, not just shapes.** Every item carries a link, price, quantity,
category, code, notes and a photo. The register searches, sorts, totals and
exports to CSV.

**Labels you can switch off.** Give an item any labels you like — `fragile`,
`winter`, whatever you use — and they show on its tag in both views. One switch
on the bottom bar takes them all off and back; individual labels sit under the
Show menu. Switching one off stops it being drawn, without moving or hiding
anything in the room.

**It tells you what will not work.** Anything that does not fit under the
ceiling, will not go through the door, stands in the door's swing, sticks
through a wall, or is too tall for the shelf above it. Anything it marks red
will tell you which of those it is if you hover it in the list.

**And what is left, and what would go in it.** How much floor is clear and how
much you can actually store in it, allowing for the ceiling; the biggest empty
rectangles with the headroom over each; and, for every one of them, what would
fit — from the built-in items, from your own saved ones, and from another of
whatever is already in the room. One click puts it there.

**And whether you can get round.** The floor is rasterised, every free spot
measured for clearance, and a person flooded in from the doorway and widened
until something stops being reachable. That gives you the tightest squeeze on
your route, and names anything you cannot get to at all. Sockets, switches and
radiators warn you when something is parked in front of them.

**Tools.** A tape measure that snaps to corners, dimension lines everywhere,
undo and redo, and a **Save a picture** button that flattens the drawing,
measurements and labels into one PNG.

Everything is saved in your browser as you go, and projects can be exported to
JSON to move between machines.

## How the file is put together

The thing you open is **built**, not hand-edited. three.js is pasted into it so
it works offline, which makes the built file ~770KB and not much fun to edit.

| File | What it is |
| --- | --- |
| `room-planner_v4.html` | The app. Built. This is what you open and what ships in a release. |
| `room-planner_v4.src.html` | **The source. Edit this one.** Same file with a `<!--INLINE_THREE-->` marker instead of the library. |
| `build-planner.sh` | Splices the library into the source to produce the app. |
| `vendor/three.min.js` | three.js r128, MIT licensed, vendored so builds never need the network. |
| `room-planner_v3.html` | The previous version, kept as a fallback. Opens v3 files; v4 imports them too. |

To make a change:

```sh
# edit room-planner_v4.src.html, then
./build-planner.sh
```

## Checking it still works

The geometry is where a silent mistake would put things in the wrong place
without ever looking wrong, so it carries its own checks. Open the built file
with `#selftest` on the end of the address:

```
room-planner_v4.html#selftest
```

116 assertions covering which side of a wall is "inside", point-in-polygon on
L-shaped rooms, overlap between turned rectangles, ceiling heights, shelf
boards and what rides on them, what a bay is solid at and where you can click
it, labels, floor access, the space-left figures, link validation and CSV
escaping. All of them should pass.

## Known limits

- **Saving in the browser may be blocked when you open the file straight off
  disk.** Some browsers refuse storage to `file://` pages. The app tests for
  this on startup and shows a red note in the Projects panel if it happens —
  export to a JSON file to keep your work. Serving the file over `http://`
  always works.
- **Most shops refuse to be shown inside another page.** The item link field
  opens in a new tab, which always works. The in-page preview only works for
  sites that permit framing, which most retailers do not.
- Photos are scaled to 360px and re-encoded, because a browser only gives the
  page a few megabytes to store everything in.

## Credits

[three.js](https://threejs.org) r128, MIT licensed, is vendored in `vendor/`
and inlined into the built file; its licence header travels with it.
