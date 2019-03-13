$fn=100;
include <manchons_common.scad>;

// setup
brackets_distance = 34.5;
slots_distance = 25.25;

slots_shift_to_right = 0.25;

// computed
slot_left_position  = slots_distance/2 - slots_shift_to_right;
slot_right_position = slots_distance/2 + slots_shift_to_right;

slot_left_length  = brackets_distance/2 - slot_left_position;
slot_right_length = brackets_distance/2 - slot_right_position;

echo(slot_left_length);
echo(slot_right_length);

module axis() {
    difference() {
        half_chamfered_cylinder(d=Daxis, h=brackets_distance+0.01, center=true);
        // axis slots
        difference() {
            union() {
                mirror([0,1])
                translate([0, slot_right_position])
                half_chamfered_cylinder(h=slot_right_length, d=Daxis+1);
                translate([0, slot_left_position])
                half_chamfered_cylinder(h=slot_left_length, d=Daxis+1);
            }
            half_chamfered_cylinder(h=100, d=Dmin, center=true);
        }
    }
}

module manchon_roue() {
    screws_pos =  (brackets_distance-Dflat)/2;
    difference() { // central hole
        union() {
            tubeA(length = brackets_distance, center=true);

            translate([0,  screws_pos, 0]) screw_holder("L");
            translate([0, -screws_pos, 0]) screw_holder("R");
        }
        union() {
            // central hole
            axis();
            // Screws
            translate([0,  screws_pos, 10.7]) screws(nut=true);
            translate([0, -screws_pos, 10.7]) screws(nut=true);
            // cuts the cylinder in 2
            translate([0, 0, 50-0.5]) cube(size=[100, 100, 100],center=true);
        }
    }
}

manchon_roue();
// %translate([0, -slots_shift_to_right, 0]) cube([100, slots_distance, 100], center=true);