$fn=100;

hole_d = 15;
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

opened = abs($t*2-1);
opened = 1;

PCB_thick = 1.6;
PCB_width = 6;

bumper_pos = -bumper_x_pushed - PCB_thick/2;

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
            rotate([0, 0, 360/12])
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
module PCB() {
    translate([0, 0, -10])
    cube([PCB_thick, PCB_width, 50], center=true);
}

module negative_real() {
    bumper();
    plaque();
    PCB();
}


module real() {
    difference() {
        union() {
            translate([bumper_pos+0.02, -(hole_d+2)/2, -(bumper_h+2)])
                cube([-bumper_pos-0.02, hole_d+2, bumper_h + 2]);
            translate([0, 0, -(bumper_h + 2)/2])
                cylinder(d=hole_d+2, h=bumper_h + 2, center=true);
            
            cylinder(d=hole_d, h=hole_h);
        }
        union() {
            bumper_screws();
            
            translate([bumper_pos+0.01, -bumper_y/2, -30])
            cube([-bumper_pos, bumper_y, 30.01]);
            
            translate([-2+0.01, -bumper_y/2, -30])
            cube([3, bumper_y, 50]);
        }
    }
}
%negative_real();

intersection() {
    real();
    // translate([-50, 00, -50]) cube([100, 100, 100]);
}

