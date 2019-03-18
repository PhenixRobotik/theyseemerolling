$fn=100;




module bride(diam_motor = 0) {
    hauteur_bride = 4;
    diam_bride = diam_motor + 2*hauteur_bride;

    largeur_bride = 44;
    epaisseur_bride = 10;
    v_spacing = 1;

    spacing_vis = 33;
    diam_vis = 1.5*2;
    diam_nut = 6.01; // M3
   
    
    difference() {
    union() {
        
        cylinder(d=diam_bride, h = epaisseur_bride);
        
        for(i=[0, 1]) mirror([i, 0, 0]) {
            translate([diam_motor/2, 0])
                cube([(largeur_bride - diam_motor)/2, 10, epaisseur_bride]);
        }
    }
    #union() {
        cylinder(d=diam_motor, h = epaisseur_bride);
        translate([-largeur_bride/2, - diam_bride/2,0])
            cube([largeur_bride, diam_bride/2 + v_spacing, epaisseur_bride*2]);
        
        for(i=[0,1]) mirror([i, 0, 0]) {
            translate([spacing_vis/2, 0, epaisseur_bride/2]) rotate([-90, 0, 0]) {
                cylinder(d=diam_vis, h=20);
                translate([0, 0, 7]) rotate([0,0,360/12])cylinder(d=diam_nut, h=20, $fn=6);
            }
        }
            
    }
    }
    
}

//bride(26);
bride(26);
