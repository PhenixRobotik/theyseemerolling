$fn=100;


// Dimensions joint torique
joint_diam_ext = 60;
joint_epaisseur= 3;
joint_diam_int = joint_diam_ext - 2 * joint_epaisseur;
joint_diam_mid = (joint_diam_ext + joint_diam_int) / 2;

// Dimensions roue
roue_diam_axis = 2;
roue_epaisseur = 6.5;

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
    
    minkowski() {
        translate([0,0,-hole_h/2])
        difference() {
            cylinder(d=hole_do, h=hole_h);
            union() {
                cylinder(d=hole_di, h=hole_h);
                for (i=[0:nb_trous]) rotate([0,0,360*i/nb_trous]) {
                    translate([-4, -5, 0]) cube([8, 100, hole_h]);
                }
            }
        }
        cylinder(d=hole_dc);
    }
}

module roue_codeuse() {
    difference() {
        union() {
            h_mid = joint_epaisseur - 0.5;
            cylinder(d=joint_diam_mid, h=h_mid, center=true);
            
            h_ext = (roue_epaisseur - h_mid) / 2;

            for (i=[0:1]) mirror([0,0,i])
            translate([0, 0, h_mid/2])
            cylinder(
                d1 = joint_diam_mid,
                d2 = joint_diam_mid - h_ext*2,
                h  = h_ext
            );
            
        } union() {
            axis();
            joint();
            trous();
        }
    }
}
// support();
roue_codeuse();
// trous();
%joint();