$fn=60;

horrot = [90, 0, 0];

roulement6_h = 6;
roulement6_d = 19;
module roulement6() {
    rotate(-horrot) difference() {
        translate([0,0,0])    cylinder(h = roulement6_h,     d = roulement6_d);
        translate([0,0,-0.1]) cylinder(h = roulement6_h+0.2, d = 6);
    }
}

rouemotrice_diam = 70;
rouemotrice_epai = 15;
module rouemotrice() {
    rotate(horrot) difference() {
        translate([0,0,0])    cylinder(d = rouemotrice_diam, h = rouemotrice_epai);
        translate([0,0,-0.1]) cylinder(h = rouemotrice_diam+0.2, d = 6);
    }

}

moteur_diam = 26;
moteur_leng = 90;
moteur_axe1_diam =  5;
moteur_axe1_leng = 14;
moteur_axe2_diam =  2;
moteur_axe2_leng = 14;
module moteur() {
    rotate(horrot) {
    translate([0,0,0])
        cylinder(d = moteur_diam, h = moteur_leng);
    translate([0,0,40])
        #cylinder(d = moteur_diam+0.1, h = 1);
    translate([0, 0, moteur_leng])
        cylinder(d = moteur_axe2_diam, h = moteur_axe2_leng);
    translate([0, 0, -moteur_axe1_leng])
        cylinder(d = moteur_axe1_diam, h = moteur_axe1_leng);
    }
}

engr_diamext = 26;
engr_diamint = 14;
engr_diamscr = 12;
engr_leng    = 20;
engr_lengext = 16;
engr_lengscr = 4;
module engrenage() {
    rotate(horrot) difference() {
        union() {
        translate([0,0,0]) cylinder(d = engr_diamint, h = engr_lengext);
        translate([0,0,0  ])                    cylinder(d = engr_diamext, h = 1.2);
        translate([0,0,1.2])                    cylinder(d1= engr_diamext, d2= engr_diamint, h = 2);
        translate([0,0,engr_lengext - 1.2 - 2]) cylinder(d2= engr_diamext, d1= engr_diamint, h = 2);
        translate([0,0,engr_lengext - 1.2    ]) cylinder(d = engr_diamext, h = 1.2);
        translate([0,0,engr_lengext]) cylinder(d = engr_diamscr, h = engr_lengscr);
        }
        translate([0,0,-0.1]) cylinder(d = moteur_axe1_diam, h = engr_leng+0.2);
    }
}
