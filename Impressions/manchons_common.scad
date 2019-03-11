Daxis= 8; // diametre axe
Dmin = 6; // diametre dans l'encoche

ep = 1.8; // epaisseur du manchon

Dholes = 2.5; // diametre des trous de fixation
Dflat = Dholes*2; // longueur plate a cote des trous

module half_chamfered_cylinder(d=1, h=1, center=false) {
    hull() {
        cylinder(d=d, h=h, center=center);
        translate([0, 0, (center ? -h/2 : 0)])
        for(i=[0:1]) mirror([i,0]) {
            translate([d/25, 0])
            translate([d/2, 0]) rotate([0,0,180-45]) cube([d/10, d/10, h]);
        }
    }
}

module screw_holder() {
    cube(size=[Daxis*2.5, Dflat, Daxis + 2*ep], center=true);
}
module screws() {
    for (i=[0:1]) mirror([i, 0, 0]) {
        translate([Daxis*0.9, 0, 0])
            cylinder(h=Daxis*4, d=Dholes, center=true);
    }
}
module tube(length=0, center=true) {
    // rotate([90,0,0])
    // cylinder(h=L_entre_montants-0.001, d=Daxis+ep*2,center=true);
    
    // cube([Daxis+ep*2, L_entre_montants, Daxis+ep*2], center=true);
    a = Daxis/2+ep;
    b = Daxis/2+ep;
    rotate([90, 0, 180])
    translate([0,0, center ? -length/2 : 0])
    linear_extrude(height = length)
    polygon(points = [
        [ a, 0],
        [ (a-b/1.8), -b],
        [-(a-b/1.8), -b],
        [-a, 0],
    ]);
}
