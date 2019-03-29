$fn=100;

screw_d = 3.5;

joint_d = 8;
joint_h = 2;

joint_pos = 10 + 3 + 5;
total_height = joint_pos + 5;

width = 20;

module support () {
    difference() {
        union() {
            translate([-width/2,0])
            cube([width, 4, total_height]);
            
            translate([0,0,joint_pos])
            rotate([90,0,0])
            cylinder(d=joint_d, h=joint_h);
        }
        
        #translate([0,0,joint_pos])
        rotate([90,0,0])
        cylinder(d=screw_d, h=50, center=true);
    }
}

rotate([-90,0])
support();

