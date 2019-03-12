$fn=100;
include <manchons_common.scad>;

wheel_pos = 23.75;

// Left side
letter = "L";
slot_position = 5.5;
slot_length = 5.5;

// Right side
// letter = "R";
// slot_position = 5.5;
// slot_length = 4.5;


module axis() {
    difference() {
        half_chamfered_cylinder(h=100, d=Daxis, center=true);
        // axis slot
        difference() {
            half_chamfered_cylinder(h=slot_length,  d=Daxis+1);
            half_chamfered_cylinder(h=100,          d=Dmin, center=true);
        }
    }
}

module manchon_roue() {
    difference() { // central hole
        union() {
            tube(length = wheel_pos, center=false);
            translate([0, Dflat/2, 0]) screw_holder(letter);
        }
        union() {
            // central hole
            translate([0, slot_position]) axis();
            // Screws
            translate([0, Dflat/2, 0]) screws();
            // cut the cylinder in 2
            translate([0,0,50-0.5]) cube(size=[100,100,100],center=true);
        }
    }
}

manchon_roue();

%rotate([90, 0,0])cylinder(d=10, h=1000, center=true);