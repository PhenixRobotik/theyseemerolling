/*
    Working for figures over 180º
    modified 1st parameter name to innerradius
    modifier parameters order
    modified parameter name depth -> height
    
     Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
     
     by Carles Oriol  March 2015
*/

/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/

module arc(innerradius, radius, height, startdegrees, enddegrees)
{
    rotate([0,0,startdegrees])
        arc(innerradius, radius, height, enddegrees-startdegrees);
}

module arc(innerradius, radius, height, degrees)
{
    render() {
        if (degrees > 180) {
            difference() {
              difference() {
                    cylinder( r=radius, h=height );
                    cylinder( r=innerradius*1.0001, h=height );
                }
                rotate([0,0,-degrees]) arc( innerradius,radius*1.0001, height*1.0001,  360-degrees);
            }
        } else {
            difference() {
                // Outer ring
                rotate_extrude()
                    translate([innerradius, 0, 0])
                        square([radius - innerradius,height]);

                // Cut half off
                translate([0,-(radius+1),-.5]) 
                    cube ([radius+1,(radius+1)*2,height+1]);

                // Cover the other half as necessary
                rotate([0,0,180-degrees])
                translate([0,-(radius+1),-.5]) 
                    cube ([radius+1,(radius+1)*2,height+1]);
            }
        }
    }
}