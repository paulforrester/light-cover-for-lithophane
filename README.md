# Lithophane cover for round sconce

Snap-on cover that traps a 200 mm x 5 mm round lithophane against a 200 mm x 20 mm sconce.

- `lithophane_cover.scad` – parametric OpenSCAD source (all dimensions at the top)
- `lithophane_cover.stl` – ready to import into Bambu Studio
- `render_back.png` / `render_front.png` – renders; `clip_section.png` – cross-section of a clip

## Design
- Front ring: 2 mm thick, 12 mm overlap → 176 mm viewable opening
- Lithophane pocket: 200.6 mm bore (0.3 mm clearance per side), 5.2 mm deep
- Side bezel: 1.9 mm wall, only 8.5 mm tall, so it clears the rest of the lamp. Above that only the three clip arms remain, reaching 3 mm past the back edge of the sconce
- 3 flexible clips at 120° (arm 14 mm wide, free-standing above the bezel) with an inward hook that catches behind the back edge of the sconce (hook catch 0.2 mm behind the back face, 1.3 mm engagement)
- Overall: 204.4 mm dia x 30.2 mm tall

## Printing (Bambu H2D)
- Orientation as exported: viewing face on the bed, clips up. No supports.
- White PLA, 0.4 mm nozzle, 0.2 mm layers, 4+ walls (fills the 1.9 mm wall solid), 100% or high-density infill on the clips.
- Print with the outer layers running around the ring so the clip arms flex along, not across, layer lines. PETG is more forgiving if a clip feels brittle.
- Tune `clr`, `hook_in`, `clip_w` in the SCAD file if the first fit is too tight/loose, then re-export.

## Assumptions to check
The sconce's back edge must have an accessible rim (≥1 mm) for the hooks. If it has a wall plate or lip, adjust `overhang`/`hook_in`.
Litho light-shine: the white PLA ring is opaque; only the 176 mm centre is lit.
