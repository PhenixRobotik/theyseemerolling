$fn=100;
include <manchons_common.scad>;

wheel_pos = 27.25;

// Left side
slot_position = 5.5;
slot_length = 5.5;

// Right side
// slot_position = 5.5;
// slot_length = 5.5;


module axis() {
    rotate([-90,0,0])
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
            
            translate([0, Dflat/2, 0]) screw_holder();
        }
        union() {
            // Screws
            translate([0, Dflat/2, 0]) screws();

            //central hole
            translate([0, slot_position]) axis();
            
            translate([0, Dflat/2,-(Daxis/2+ep)]) linear_extrude(height = 0.2) rotate([180, 0, -90])
                text("L",
                font = "Liberation Sans:style=Bold", size = 2.5, valign="center", halign="center");

            //cuts the cylinder in 2
            translate([0,0,50-0.5]) cube(size=[100,100,100],center=true);
        }
    }
}

manchon_roue();
