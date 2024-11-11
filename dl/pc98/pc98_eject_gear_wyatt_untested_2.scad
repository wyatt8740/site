/* gears library from https://github.com/chrisspen/gears.git */
use <gears.scad>

difference() {



union() {
scale([0.5,0.5,0.5]) {
union(){
/* bevel gear params: */
/* modul, tooth_number,  partial_cone_angle, tooth_width, bore, pressure_angle=20, helix_angle=0 */
/* 37 teeth bevel gear, about 18.75-19mm diameter. maybe 0.8mm tooth width?
   hole in middle maybe 6.55mm diameter in original? randomly guessing 20 degree pressure angle. no helix. */
/*         modul  tooth_number  partial_cone_angle  tooth_width  bore   pressure angle  helix */
bevel_gear(1.007, 37,           70,                 7.55,        13.14, 14.5,             0);


translate([0, 0, -1])
color("#008000")
/*        modul  tooth_number  width (really height)   bore  pressure angle  helix_angle   optimized=true */
spur_gear( 1.15,     17,          20,                  13.14,   14.5,             0 );
}
}
}



union() {
difference() {
/* outside of our tube (to cut off teeth at top of gear) */
translate([0,0,8.5])
color("#004080")
scale([0.25,0.25,0.25]) {
 cylinder(r=23,h=14,center=true);
}
/* inside of our tube (the part that gets subtracted out) */
translate([0,0,8])
color("#800040")
scale([0.25,0.25,0.25]){
    cylinder(r=16.86,h=13,center=true);
//circle(((1.16 * 17) - 2 * (1.16 * (17 <3)? 0: 1.16/6)));
}
}

difference() {
/* outside of our tube (to cut off teeth at top of gear) */
translate([0,0,-1.75])
color("#004080")
scale([0.25,0.25,0.25]) {
 cylinder(r=23,h=14,center=true);
}
/* inside of our tube (the part that gets subtracted out) */
translate([0,0,-1])
color("#800040")
scale([0.25,0.25,0.25]){
    cylinder(r=16.86,h=13,center=true);
//circle(((1.16 * 17) - 2 * (1.16 * (17 <3)? 0: 1.16/6)));
}
}


}




}


