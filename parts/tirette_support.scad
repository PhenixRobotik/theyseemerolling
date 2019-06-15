$fn=100;

mode = 1;

hole_d = 14.85;
hole_h = 3;

bumper_h = 19.8;
bumper_x_pulled = 13.2;
bumper_x_pushed = 11.4; // 1.8mm
bumper_y = 6.4;
bumper_l = bumper_h - 3;

bumper_screw_d = 2.2;
bumper_screw_x = 2.9;
bumper_screws_h = [
    bumper_h / 2 + 9.5 /2,
    bumper_h / 2 - 9.5 /2,
];

bumper_contacts_l = 6.4 - bumper_screw_x;
bumper_contacts_y = 3.2;
bumper_contacts_t = 0.5;
bumper_contacts_h = [
    bumper_h - 1.6,
    bumper_h - 1.6 - 8.8,
    bumper_h - 1.6 - 8.8 - 7.3,
];


// opened = abs($t*2-1);
opened = 1;

tirette_thick = 1.6;
tirette_width = 6;

bumper_pos = -bumper_x_pushed - tirette_thick/2;

module bumper_screws() {
    screw_l = 25;
    screw_m = hole_d+2; // Distance entre tête et (presque) écrou
    screw_head_l = 3;

    translate([bumper_pos, 0, -bumper_h-1])
    for(h = bumper_screws_h) {
        translate([bumper_screw_x, 0, h])
        translate([0, screw_head_l + screw_m/2])
        rotate([90,0]) {
            cylinder(d=5, h=screw_head_l);
            cylinder(d=bumper_screw_d, h=screw_l);
            translate([0, 0, screw_m+ screw_head_l-1])
            // rotate([0, 0, 360/12])
            cylinder(d=4.32, h=2, $fn=6);
        }
    }
}

module bumper() {
    difference() {
        translate([bumper_pos, -bumper_y/2, -bumper_h-1])
        union() {
            cube([bumper_x_pushed, bumper_y, bumper_h]);
            
            translate([bumper_x_pushed, bumper_y *0.1, bumper_h-2])
            rotate([
                0, 
                opened*asin((bumper_x_pushed-bumper_x_pulled)/bumper_l), 
            ]) 
            translate([-1,0, -bumper_l])
            cube([1, bumper_y *0.8, bumper_l]);
            for(h = bumper_contacts_h) {
                translate([-bumper_contacts_l, bumper_contacts_y/2, h-bumper_contacts_t/2])
                    cube([bumper_contacts_l, bumper_contacts_y, bumper_contacts_t]);
            }
        }
        bumper_screws();
    }
}

module plaque() {
    difference() {
        translate([0, 0, hole_h/2]) cube([80, 80, hole_h], center=true);
        translate([0, 0, -1]) cylinder(d=hole_d, h=10);
    }
}
module tirette() {
    offset = 3.3;
    difference() {
        union() {
            translate([-tirette_thick/2, -tirette_width/2, -23])
                cube([tirette_thick, tirette_width, 30]);

            translate([0, 0, offset]) {
                translate([-tirette_thick/2, -15/2])
                    cube([tirette_thick, 15, 15/2]);
                translate([0, 0, 15/2])
                rotate([0, 90, 0])
                    cylinder(d = 15, h = tirette_thick, center=true);
            }
        }
        union() {
            translate([0, 0, 15/2 + offset])
            rotate([0, 90, 0])
                cylinder(d = 10, h = tirette_thick+1, center=true);
            
        }
    }
}

module negative_real() {
    bumper();
    plaque();
}


module support() {
    difference() {
        union() {
            size = -bumper_pos-0.02 + bumper_contacts_l + 4;
            translate([-size, -(hole_d+2)/2, -(bumper_h+2)])
                cube([size, hole_d+2, bumper_h + 2]);
            translate([0, 0, -(bumper_h + 2)/2])
                cylinder(d=hole_d+2, h=bumper_h + 2, center=true);
            
            cylinder(d=hole_d, h=hole_h);
        }
        union() {
            bumper_screws();
            
            // Bumper
            translate([bumper_pos+0.01, -bumper_y/2, -30])
                cube([-bumper_pos, bumper_y, 30.01]);
            
            // Tirette
            translate([-2+0.01, -bumper_y/2, -30])
                cube([3, bumper_y, 50]);

            // Contacts
            translate([bumper_pos - bumper_contacts_l -4+ 0.01, -bumper_y/2, -30])
                cube([-bumper_pos, bumper_y, 30.01]);
        }
    }
}


if (mode == 0) {
    %negative_real();
    %tirette();
    support();
} else if (mode == 1) {
    rotate([0,90,0])
    tirette();    
} else if (mode == 2) {
    support();
} else  {}

