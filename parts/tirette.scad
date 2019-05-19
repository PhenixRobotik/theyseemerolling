$fn=100;

hole_d = 15;
hole_h = 1.5;

bumper_h = 30;
bumper_x_pulled = 20;
bumper_x_pushed = 15;
bumper_y = 10;
bumper_l = bumper_h - 3;

bumper_screw_d = 2;
bumper_screw_x = 5;
bumper_screws_h = [7, 23];

opened = abs($t*2-1);
opened = 0.15;

PCB_thick = 1.6;
PCB_width = 10;

bumper_pos = -bumper_x_pushed - PCB_thick;

module bumper_screws() {
    translate([bumper_pos, 0, -bumper_h-1])
    for(h = bumper_screws_h) {
        translate([bumper_screw_x, 0, h]) rotate([90,0])
        cylinder(d=bumper_screw_d, h=30, center=true);
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
    //plaque();
    PCB();
}


module real() {
    difference() {
        union() {
            translate([-40/2, -20/2, -35])
            cube([40, 20, 35]);
            
        }
        union() {
            translate([bumper_pos, -bumper_y/2, -50])
            cube([-bumper_pos, bumper_y, 51]);
            #bumper_screws();
        }
    }
}
#negative_real();
real();
