// Lithophane cover for round wall sconce (200 mm x 20 mm)
// Print orientation: viewing face DOWN on the bed, clips pointing UP. No supports needed.
// Units: mm.  Render with: openscad -o lithophane_cover.stl lithophane_cover.scad

$fn = 180;

// ---- Measured / requested dimensions ----
light_d   = 200;   // sconce diameter
light_h   = 20;    // sconce thickness (depth the cover slides over)
litho_d   = 200;   // lithophane disc diameter
litho_t   = 5;     // lithophane disc thickness
border    = 12;    // cover overlap on lithophane face -> viewable dia = 200 - 2*12 = 176

// ---- Fit / strength tuning ----
clr       = 0.15;  // radial clearance per side (raise to 0.2-0.3 if the lithophane is too tight)
wall      = 1.5;   // skirt wall thickness (outer dia = litho_d + 2*clr + 2*wall = 203.3)
bezel_h   = 8.5;   // side bezel stops here; above this only the clip arms remain
face_t    = 2.0;   // front ring thickness (light shines through the lithophane, not this)

// ---- Clips ----
n_clips   = 3;
clip_w    = 14;    // arm width (mm, along the circumference)
hook_in   = 2.8;   // how far the hook tip reaches in from the arm's inner face
hook_flat = 1.8;   // flat (horizontal) part of the catch = the longest unsupported overhang;
                   // beyond it the underside slopes at 45 deg so it prints without supports
tip_h     = 0.6;   // vertical face at the hook tip
clip_start= 90;    // angle of first clip (deg)

// Show a ghost lithophane + light for visualisation only (never exported)
show_ghosts = false;

// ---- Derived ----
pocket_r  = litho_d/2 + clr;
outer_r   = pocket_r + wall;
open_r    = litho_d/2 - border;          // 88
z_litho   = face_t;                      // lithophane sits on top of the front ring
z_light   = face_t + litho_t + 0.2;      // light body starts here (0.2 slack for litho)
z_back    = z_light + light_h;           // back of the light
zc        = z_back + 0.2;                // catch surface, just behind the light
hook_h    = (hook_in - hook_flat) + tip_h + hook_in;  // 45deg underside + tip + 45deg lead-in
total_h   = zc + hook_h;
arm_a     = clip_w  / pocket_r * 180/PI; // arm angle

module ring(r_in, r_out, z0, z1, a=360) {
    translate([0,0,z0])
        rotate_extrude(angle=a)
            translate([r_in,0]) square([r_out-r_in, z1-z0]);
}

module hook_profile() {
    // (radius, z) polygon: flat catch, 45deg sloped underside at the tip, 45deg lead-in on top
    r = pocket_r;
    polygon([
        [r + 0.01, zc],
        [r - hook_flat, zc],
        [r - hook_in, zc + (hook_in - hook_flat)],
        [r - hook_in, zc + (hook_in - hook_flat) + tip_h],
        [r + 0.01, zc + hook_h]
    ]);
}

module clip_hook() {
    rotate_extrude(angle=arm_a) hook_profile();
}

module cover() {
    // front ring + short side bezel (stops where the clips begin)
    ring(open_r, outer_r, 0, face_t);
    ring(pocket_r, outer_r, 0, bezel_h);
    // clip arms + hooks: the only parts that rise above the bezel
    for (i=[0:n_clips-1])
        rotate([0,0,clip_start + i*360/n_clips - arm_a/2]) {
            ring(pocket_r, outer_r, bezel_h - 0.01, total_h, arm_a);
            clip_hook();
        }
}

cover();

if (show_ghosts) {
    %translate([0,0,z_litho]) cylinder(d=litho_d, h=litho_t);
    %translate([0,0,z_light]) cylinder(d=light_d, h=light_h);
}
