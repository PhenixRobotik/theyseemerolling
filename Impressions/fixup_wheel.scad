$fn=200;

function in(inches) = inches *25.4;

height = (in(0.3) - in(0.15))/2;
diam_in1 = in(0.8)+0.5;
diam_in2 = 22+0.5;
diam_out = 30;

diam_pos_screw = 10.75;
diam_screw = 3;

module fixup_wheel() {
    difference() {
        cylinder(center=true, d=diam_out, h=height);
        cylinder(center=true, d1=diam_in2, d2=diam_in1, h=height+0.002);
        
        for(i=[0:2]) rotate([0,0,120*i]) {
            translate([diam_pos_screw, 0, 0]) cylinder(center=true, d=diam_screw, h=10);
        }
    }
}

fixup_wheel();
