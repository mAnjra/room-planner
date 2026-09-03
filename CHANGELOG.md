# Changelog

Notable changes to this project. Follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and [semantic versioning](https://semver.org/) — pre-1.0, so anything may still move.

## [0.0.8] — 2026-09-04

### Fixed

- **Saving one of your own items threw away everything but its size.** *Use
  selected* filled in the name, size and colour, and Save wrote only those, so
  the labels, notes, category, code, link, price and photo were lost, and a
  shelving bay came back as a plain block. A saved item now keeps all of it,
  remembers it was shelving and how many boards it had, and adding it back to
  the room brings the lot with it. The boards are stored as a count rather than
  fixed heights, so they still come out evenly spaced if you change the height
  on the way through.

  Everything is copied on the way in and on the way out, so a library entry and
  the items made from it can never end up editing one another — the same fault
  that 0.0.7 fixed for *Copy*.

## [0.0.7] — 2026-09-04

### Fixed

- **Editing one item's labels edited its copies too.** *Copy* built the new item
  with a shallow copy, so the original and every copy of it held one and the
  same details between them. Typing a label on either wrote it to both, and the
  same went for notes, category, code, price, quantity and the photo — and a
  copied shelving bay shared its board heights, so moving a board on one moved
  it on the other. A copy is now wholly its own item. Copies made before this
  version separate themselves as soon as the project is reloaded, so existing
  work is not stuck that way.

## [0.0.6] — 2026-09-03

A new name, two things that made shelving painful to use, and three features.

### Changed

- **The app is now called Baby Dragon Poo.** Name only — the file is still
  `room-planner_v4.html`, so existing download links and saved projects are
  untouched.

### Added

- **Labels on items.** Type any labels you like on an item — `fragile, winter` —
  and they appear on its tag in both the plan and the model view. One **Labels**
  switch on the bottom bar takes them all off and puts them all back; the
  individual ones sit under the Show menu, so a roomful of labels can never
  crowd the bar out. Switching a label off only stops it being drawn — nothing
  in the room moves or disappears. Labels are searched by
  the register and carried into the CSV export. This is separate from the
  Numbers / Names / Names and sizes setting next to it, which is unchanged.
- **Shift-drag to raise and lower.** Hold Shift while dragging an item and it
  goes up and down instead of across the floor, in both the plan and the model
  view. Let go of Shift and it carries on sliding from wherever it is, without
  leaping to catch up with the pointer. Lifting something off a shelf board lets
  go of the board rather than being snapped straight back down; lifting a bay
  still carries its contents up with it.
- **Space left.** A panel saying how much floor is clear and how much you can
  store in it, allowing for the ceiling and ignoring floor a door sweeps. It
  names the biggest empty rectangles with the headroom over each, and for every
  one lists what would go there — from the built-in items, from your own saved
  ones, and from another of whatever is already in the room — with a button that
  puts one there. Tick **Biggest gaps** in the Show menu to see them on the plan.

- **Every red item now says why it is red.** Hover it in the list under *In this
  room* and you get the reasons in full. Red means any one of six checks failed —
  too tall for the ceiling, through a wall, inside something, will not fit
  through the door, in the door's swing, or cannot be reached — and it was easy
  to assume it always meant the third. The colour and the problems list are now
  built from the same function, so they can never disagree.

### Fixed

- **A box inside a shelving bay was reported as being inside the bay.** A bay is
  a frame — four corner posts and some boards — but every check treated it as a
  solid crate the full height of the bay. So a box on the floor under the lowest
  board, or set down on a board without having been formally put on it, came up
  as "is inside another item". The bay's posts and boards are now what counts as
  solid, and the air between them is air. A box that really does foul a board or
  a post is still caught.
- **Clicking a box on a shelf in the model view picked up the whole bay.** Each
  bay carried a single invisible box over its entire volume to catch clicks,
  which sat nearer the camera than anything standing inside it and took every
  click aimed there. The bay is now clicked by its actual boards and posts, drawn
  from the same list the collision maths uses, so the two cannot drift apart.
- **Dragging in the model view could move something other than what you grabbed.**
  The drag followed whichever item was primary in the selection rather than the
  one the click landed on, so after picking out several things at once, clicking
  one of them and dragging moved a different one. It now follows what you
  grabbed, the way the plan view already did.

## [0.0.5] — 2026-09-01

Bug fixes, all of them found by using it. The important one is that the app
was quietly damaging its own saved files.

### Fixed

- **Saved files could be corrupted on save, and then would not open.** The item
  palette changed in 0.0.4, so items carrying an older colour no longer matched
  anything in the colour menu and it went blank. Editing any field then read the
  blank menu as `NaN`, which JSON writes as `null`, and the next attempt to open
  the file failed with "Cannot read properties of null". A colour that is not in
  the palette is now shown as "As saved", and every colour read is guarded, so a
  blank menu can never become a colour.
- **Clicks and scrolling stopped working over parts of the drawing.** The title
  block and the item labels sat on top of the canvas and took pointer events for
  themselves, so anything underneath them could not be clicked, dragged or
  zoomed. Because undo moves the labels, it looked like undo was the cause.
  Everything floating over the drawing now lets input through, zoom listens on
  the whole viewport, and labels are hit-tested last so they never hide what is
  beneath them.
- **A new window or door was placed on top of the existing one.** Openings were
  always added to the first wall, dead centre, which put a new window inside the
  door — invisible and impossible to select. New openings and fixtures now find a
  free span of wall, and the panel that edits them opens itself.
- **Save a copy did nothing** if the browser had been told to block dialogs for
  the page, which browsers offer after a couple of them. It uses an inline field
  now, and deleting a project asks in place. Nothing depends on `prompt` or
  `confirm` any more.
- **Opening a bad file loaded it anyway and then complained.** Opening a file is
  now all-or-nothing: it is worked out in full first and the current room is put
  back if anything goes wrong, so a bad file leaves what you had untouched. The
  message says what was actually wrong rather than one line for every failure.
- The preview frame no longer carries `allow-same-origin` alongside
  `allow-scripts`, which together let a framed page escape the sandbox.

### Added

- **Old and damaged saves repair themselves.** Every file is checked field by
  field on the way in and anything missing or unusable is replaced with something
  sensible, rather than the file being refused. Thirteen kinds of damage that
  used to crash or be rejected now open, and you are told how many details were
  filled in. A file written by an older version will always open; it will not
  gain data it never had.
- Doors, windows and wall fixtures can be selected by clicking them in the Plan
  view, not only in the sidebar list.

## [0.0.4] — 2026-09-01

The room stops having to be a rectangle, and the planner starts checking
whether *you* fit rather than only whether the furniture does.

### Added

- **Polygon rooms.** Any number of walls at any angle. Rectangle and L-shape
  presets, or drag the corners. Doors, windows, swing arcs and wall cutouts all
  work on an angled wall.
- **Plan view.** A top-down drafting canvas alongside the 3D model: drag to
  move, a handle to turn to any angle, snapping flush to walls and to other
  items, box-select, and align and space-out controls.
- **Free rotation.** Items turn to any angle, not just 0° and 90°. Overlap
  became a separating-axis test and room containment a corners-and-edges test.
- **Shelving with boards.** Bays carry a list of board heights; items sit on a
  named board and move, turn and lift with the bay. Each board reports its reach
  and the space above it.
- **Item details.** Link, price, quantity, category, code, notes and a photo on
  every item, with a searchable, sortable register, running totals and CSV export.
- **Saved sets.** Turn a selection into one library entry that drops the whole
  arrangement back in, including what sat on which board.
- **Floor access analysis.** Reports the tightest squeeze on your route round
  the room and names anything you cannot reach at all.
- **Wall fixtures.** Sockets, switches, lights, radiators and boxed-in pipes,
  each with a clearance it needs kept free, and a warning when something blocks it.
- **Tape measure** that snaps to corners, and measurements that stay with the project.
- **Save a picture** — flattens the drawing, its measurements and its labels into one PNG.
- **Numbered tags** on every item, matching the register, stacked so they never
  hide each other.
- **Projects and undo.** Named projects saved in the browser, autosaved, with
  undo and redo. Your own item library is kept separately so it survives
  switching between rooms.
- Offline: three.js is vendored and inlined, so the built file never touches the network.
- 55 self-checks, runnable by opening the file with `#selftest`.

### Changed

- Complete visual redesign: one drawing convention — a line with tick serifs and
  the number in a break — used for every measurement in both views.
- Headroom now uses an ordered colour ramp rather than four unrelated hues, which
  frees red to mean only one thing: something is wrong.
- Items are anchored at their centre rather than a corner, which free rotation
  requires. v3 files are converted on import.

### Fixed

- Opening a v3 file: corner-to-centre anchoring, the 0/90 rotation swap, wall
  renumbering, and the flipped position on v3's `far` and `right` walls.
- A rectangular room produced a clearance grid with no blocked cells, so every
  gap measured as infinitely wide.
- Items resting on a shelf were reported both as "inside another item" and as
  unreachable.
- A new project created and closed within 400ms was lost to the save debounce.
- The preview iframe no longer carries both `allow-scripts` and
  `allow-same-origin`, which together let a framed page escape the sandbox.

## Earlier

`room-planner_v3.html` predates this changelog and is kept in the repository as
a fallback. It planned a single rectangular room with a sloped ceiling, and
checked that items fit under it, went through the door and left the door free to
swing. v4 keeps that geometry and builds on it.

[0.0.8]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.8
[0.0.7]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.7
[0.0.6]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.6
[0.0.5]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.5
[0.0.4]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.4
