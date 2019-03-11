$fn=100;
include <manchons_common.scad>;

L_entre_montants = 34.5;
L_entre_encoches = 25.0;
L_encoche_left = L_entre_montants - 29.5;
L_encoche_right = L_entre_montants - 30;

echo(L_entre_encoches + L_encoche_left + L_encoche_right);


module axis() {
    rotate([-90,0,0])
    difference() {
        half_chamfered_cylinder(d=Daxis, h=L_entre_montants, center=true);
        // axis slots
        difference() {
            union() {
                translate([0, 0, L_entre_montants/2 - L_encoche_right])
                half_chamfered_cylinder(h=L_encoche_right+0.01, d=Daxis+1);
                translate([0, 0, -L_entre_montants/2-0.01])
                half_chamfered_cylinder(h=L_encoche_left+0.01, d=Daxis+1);
            }
            half_chamfered_cylinder(h=100,      d=Dmin, center=true);
        }
    }
}

module manchon_roue() {
    difference() { // central hole
        union() {
            tube(length = L_entre_montants, center=true);

            translate([0,  (L_entre_montants-0.001-Dflat)/2, 0]) screw_holder();
            translate([0, -(L_entre_montants-0.001-Dflat)/2, 0]) screw_holder();
        }
        union() {
            //central hole
            axis();

            translate([0,  (L_entre_montants-Dflat)/2, 0]) screws();
            translate([0, -(L_entre_montants-Dflat)/2, 0]) screws();

            translate([0, +14,-(Daxis/2+ep)]) linear_extrude(height = 0.2) rotate([180, 0, -90])
                text("L",
                font = "Liberation Sans:style=Bold", size = 2.5, valign="center", halign="center");

            translate([0, -14,-(Daxis/2+ep)]) linear_extrude(height = 0.2) rotate([180, 0, -90])
                text("R",
                font = "Liberation Sans:style=Bold", size = 2.5, valign="center", halign="center");

            //cuts the cylinder in 2
            translate([0, 0, 50-0.5]) cube(size=[100, 100, 100],center=true);
        }
    }
}

manchon_roue();
