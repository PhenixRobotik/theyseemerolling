$fn=200;

function in(inches) = inches *25.4;

height_bottom = (in(0.3) - in(0.15))/2;
diam_in1 = in(0.8)+0.6;
diam_in2 = 22+0.6;
diam_out = 30;

diam_pos_screw = 10.75;
diam_screw = 3;

module fixup_wheel(height=0) {
    difference() {
        union() {
            cylinder(d=diam_out, h=height_bottom);
            
            translate([0, 0, height_bottom])
            cylinder(d=diam_out, h=height);
        }
        union() {
            // Wheel
            translate([0,0,-0.001])
            cylinder(d1=diam_in2, d2=diam_in1, h=height_bottom+0.002);
            
            // Bearing
            cylinder(d=10+0.5, h=10);
            
            // Screws
            for(i=[0:2]) rotate([0,0,120*i]) {
                translate([diam_pos_screw, 0, 0]) cylinder(center=true, d=diam_screw, h=20);
            }
        }
    }
}


height_in = 10-in(0.3);
height_out= 0.5;

fixup_wheel(height_out);
