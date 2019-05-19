$fn=100;


plaque_t = 3.3;
plaque_h = 50;
plaque_l = 200;

banana_d = 12;
banana_spacing = 18;

switch_l = 29.5;
switch_w = 21.5;

screws_d = 3;
screws_toborder = 5;
screws_pos = [ 
    [           screws_toborder,            screws_toborder],
    [           screws_toborder, plaque_h - screws_toborder],

    [plaque_l - screws_toborder,            screws_toborder],
    [plaque_l - screws_toborder, plaque_h - screws_toborder],
];


// Positions :
battery_switch_pos = 30;
supply_switch_pos = 120;
supply_banana_plugs_pos = supply_switch_pos+40;

logos_t = 0.15*5;

module logo_battery() {
    linear_extrude(height=logos_t) scale([0.05, 0.05]) translate([-150, -100])
        import("facade_supports_logo_battery.dxf");
}
module logo_supply() { 
    linear_extrude(height=logos_t) scale([0.05, 0.05]) translate([-150, -180])
        import("facade_supports_logo_supply.dxf");
}


module plaque() {
    difference() {
    union() {
        translate([0, -plaque_h/2]) cube([plaque_l, plaque_h, plaque_t]);

        // Battery Switch Logo
        translate([battery_switch_pos + (switch_w/2+10), 0, plaque_t])
            rotate([0, 0, 90]) logo_battery();

        // Supply Switch Logo
        translate([supply_switch_pos - (switch_w/2+11), 0, plaque_t])
            logo_supply();
    }
    union() {
        // Power Supply Banana Plugs
        for(i=[1, -1]) translate([supply_banana_plugs_pos, i*banana_spacing/2, -1])
            cylinder(d=banana_d, h=plaque_t+2);

        // Power Supply Switch
        translate([supply_switch_pos, 0, plaque_t/2])
            cube([switch_w, switch_l, plaque_t+3], center=true);

        // Battery Switch
        translate([battery_switch_pos, 0, plaque_t/2])
            cube([switch_w, switch_l, plaque_t+3], center=true);

        // Mounting screws
        for(pos=screws_pos)
            translate(pos + [0, -plaque_h/2, -1])
                cylinder(d=screws_d, h=plaque_t+2);
    }
    }
}

plaque();

%translate([0,   -71+plaque_h/2, -10]) cube([10,  71, 10]);
%translate([190, -71+plaque_h/2, -10]) cube([10,  71, 10]);
