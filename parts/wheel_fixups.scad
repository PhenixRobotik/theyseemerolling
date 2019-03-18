$fn=200;

function in(inches) = inches *25.4;

height_bottom = (in(0.3) - in(0.15))/2;
height_pulley = 10-in(0.3)-0.0;
height_out = 1.1;

diam_bearing = 16.2;
diam_in1 = in(0.8)+0.6;
diam_in2 = 22+0.6+0;

diam_pos_screw = 10.75;
diam_screw = 4.2;

diam_pulley_out = 31.5;

screws_positions_left = [
    [  0, 10.75],
    [120, 11.25],
    [230, 11.25],
];
screws_positions_right = [
    [  0, 10.75],
    [120, 11.5],
    [235, 11.25],
];


module fixup_wheel(
    height=0,
    diam_in=diam_bearing,
    diam_out=diam_pulley_out,
    screws_positions) {
    translate([0,0,height_bottom + height])
    rotate([180,0])
    difference() {
        union() {
            cylinder(d=diam_out, h=height_bottom);
            
            translate([0, 0, height_bottom])
            cylinder(d=diam_out, h=height);
        }
        union() {
            // Wheel
            translate([0,0,-0.005])
            cylinder(d1=diam_in2, d2=diam_in1, h=height_bottom+0.002);
            
            // Bearing
            cylinder(d=diam_in, h=10);

            // zero index
            rotate([0, 0, screws_positions[0][0]+25])
            translate([11.7,0,-0.01])
            cylinder(d=2);
            
            // Screws
            for(i=[0:2])
            rotate([0, 0, screws_positions[i][0]])
            translate([screws_positions[i][1], 0, 0]) {
                cylinder(center=true, d=diam_screw, h=20);
            }
        }
    }
}


// Top levels

module fixup_pulley_ring() {
    height_fixup_pulley = 4;
    difference() {
        cylinder(h=height_fixup_pulley,   d=diam_pulley_out + 2.5);
        translate([0,0,-1])
        cylinder(h=height_fixup_pulley+2, d=diam_pulley_out + 0.5);
    }
}
module fixup_pulley_left() {
    fixup_wheel(
        height = height_pulley,
        screws_positions = screws_positions_left
    );
}
module fixup_pulley_right() {
    fixup_wheel(
        height = height_pulley,
        screws_positions = screws_positions_right
    );
}

module fixup_out_left() {
    mirror([0,0,1])fixup_wheel(
        height = height_out,
        screws_positions = screws_positions_left
    );
}
module fixup_out_right() {
    mirror([0,0,1])fixup_wheel(
        height = height_out,
        screws_positions = screws_positions_right
    );
}


fixup_pulley_right();
