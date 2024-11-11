/* gears library from https://github.com/chrisspen/gears.git */
use <gears.scad>

scale([0.5,0.5,0.5]) {
union(){
/* bevel gear params: */
/* modul, tooth_number,  partial_cone_angle, tooth_width, bore, pressure_angle=20, helix_angle=0 */
/* 37 teeth bevel gear, about 18.75-19mm diameter. maybe 0.8mm tooth width?
   hole in middle maybe 6.55mm diameter in original? randomly guessing 20 degree pressure angle. no helix. */
/*         modul  tooth_number  partial_cone_angle  tooth_width  bore   pressure angle  helix */
bevel_gear(1.007, 37,           70,                 7.55,        13.14, 14.5,             0);


translate([0, 0, -1])
/*        modul  tooth_number  width (really height)   bore  pressure angle  helix_angle   optimized=true */
spur_gear( 1.15,     17,          20,                  13.14,   14.5,             0 );
}
}