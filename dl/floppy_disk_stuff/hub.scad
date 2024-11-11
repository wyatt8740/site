flange_radius=15.33;
flange_height=0.3; /* might be wrong!!! standard does not define */
disk_surface_height=0.08;
height_above_disk_surface=1.36;
hub_center_radius=12.5;
center_cutout_side_len=4;
difference() {
   group() {
            color("#80d0d0")
            scale([1/10,1/10,1/10])
            cylinder(h=flange_height*10, r=flange_radius*10);
            translate([0,0,flange_height])
            scale([1/10,1/10,1/10])
            cylinder(h=(disk_surface_height + height_above_disk_surface) * 10, 
                     r=hub_center_radius * 10);
        }
    group() {
        /* underside cutout */
        color("#50d090")
        translate([0,0,-1])
        scale([1/10,1/10,1/10])
        cylinder(h=(flange_height + 1.5) * 10,
                 r=(hub_center_radius - 1) * 10);
 
        /* Primary spindle hole */
        color("#50d090")
        translate([0,0,4])
        rotate([0,0,0])
        hull() {
            translate([-2,-2,-5])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
            
            translate([2,-2,-5])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
            
            translate([-2, 2,-5])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
            
            translate([2,2,-5])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
        };
        /*
        Secondary orientation slot,
        10mm by 4.5mm with rounded corners.
   
        The highest Y-coordinate corner of slot
        has a different radius.*/
        rotate([0,0,15])
        translate([-2,4.5,-1])
        color("#f000f0")
        hull() {
            translate([6,2.5,-1])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=2 * 10,center=false);
        
            translate([7,1,-1])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
            
            translate([-1,1,-1])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
    
            translate([-1,3.5,-1])
            scale([1/10,1/10,1/10])
            cylinder(h=11 * 10,r=1 * 10,center=false);
        };
        
        
    };
}