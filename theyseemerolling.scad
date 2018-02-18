include <theyseemerolling_lib.scad>

module mountmot() {
    translate([0, -1, 0]) {
    moteur();
    translate([0, engr_leng + 1.0,0]) engrenage();
    }
}
module mountwheel() {
    translate([0,0,0])
        rouemotrice();
    translate([0, 2, 0])
        roulement6();
    translate([0, 2 + roulement6_h + 1 + engr_leng, 0])
        engrenage();
    translate([0, 2 + roulement6_h + 1 + engr_leng + 1, 0])
        roulement6();
}


//roulement6();
//mountmot();
mountwheel();

