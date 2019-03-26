$fn=100;

include <arc.scad>;

// Dimensions joint torique
joint_diam_ext = 60;
joint_epaisseur= 3;
joint_diam_int = joint_diam_ext - 2 * joint_epaisseur;
joint_diam_mid = (joint_diam_ext + joint_diam_int) / 2;

// Dimensions roue
roue_diam_axis = 1.5;
roue_epaisseur = 5;

module joint() {
    rotate_extrude(convexity = 10)
    translate([joint_diam_mid/2, 0, 0]) circle(d = joint_epaisseur);
}

module axis() {
    cylinder(d=roue_diam_axis, h=100, center=true);
}
module support() {
    for (i=[0:1]) mirror([0,0,i])%
        translate([-5, -5, roue_epaisseur / 2]) cube([10, 100, 3]);
}


module trous () {
    nb_trous = 5;
    hole_h = roue_epaisseur + 1;
    hole_di = 20;
    hole_do = joint_diam_int - 12;
    hole_dc = 3;
    
    translate([0,0,-hole_h/2])
    difference() {
        for (i=[0:nb_trous]) rotate([0,0,i*360/nb_trous])
            trou(nb_trous);
        cylinder(d=hole_di*0.84, h=hole_h);
    }
}
module trou(nb_trous) {
    hole_h = roue_epaisseur + 1;
    hole_di = 15;
    hole_do = joint_diam_int - 10;
    hole_dc = 3;
    offset = -hole_dc/2-2.5;
    
    hull() {
        translate([hole_di/2+hole_dc/2, offset]) cylinder(d=hole_dc, h=hole_h);
        translate([hole_do/2-hole_dc/2, offset]) cylinder(d=hole_dc, h=hole_h);
        
        rotate([0,0,-360/nb_trous]) {
        translate([hole_di/2+hole_dc/2, -offset]) cylinder(d=hole_dc, h=hole_h);
        translate([hole_do/2-hole_dc/2, -offset]) cylinder(d=hole_dc, h=hole_h);
        }
    }
    // I could do theorical computing… or brute-force the position
    rotate([0,0,-360/nb_trous*0.9])
    arc(hole_do/2-5, hole_do/2+0.395, hole_h, 360/nb_trous*0.7, $fn=100);
}

module roue_codeuse() {
    difference() {
        union() {
            h_mid = joint_epaisseur - 1;
            cylinder(d=joint_diam_mid, h=h_mid, center=true);
            
            h_ext = (roue_epaisseur - h_mid) / 2;

            d1p = 0.6;
            d1 = joint_diam_ext * d1p + joint_diam_int * (1-d1p);

            for (i=[0:1]) mirror([0,0,i])
            translate([0, 0, h_mid/2])
            cylinder(
                d1 = d1,
                d2 = d1- h_ext*1.2,
                h  = h_ext
            );
            
        } union() {
            axis();
            joint();
            trous();
        }
    }
}

module half_roue_codeuse() {
    intersection() {
        roue_codeuse();
        translate([-joint_diam_ext/2, -joint_diam_ext/2, -roue_epaisseur-0.2])
        cube([joint_diam_ext, joint_diam_ext, roue_epaisseur]);
    }
}
// support();
roue_codeuse();
// trous();
// %joint();



