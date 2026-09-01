# Changelog

Notable changes to this project. Follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and [semantic versioning](https://semver.org/) — pre-1.0, so anything may still move.

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

[0.0.4]: https://github.com/mAnjra/room-planner/releases/tag/v0.0.4
