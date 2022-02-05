/*                             
Partform path:          M3_structure_shell_cee
Version:                1.0.0
Version notes:          Initial partform with core geometry only. Non-optimized.
Monikers:               "cee" "cee channel" "plain cee" 
contributors:           Alex Penney
*/

//BEGIN OPTIONS - edit these parameters to generate custom parts of this form.

N = 2; //whole number of 10mm units along the X axis
M = 2; //whole number of 10mm units along the Y axis
H = 4; //whole number of 10mm units along the Z axis.

$fn=20;

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the two "walls" of the part

HOLE_DIAMETER = 3.0; //Nominal 3.0mm - common diameter of holes throughout

HOLE_FACES = 20; //Default 20 - higher number => slower render, smoother holes

//END OPTIONS - edit all else at your own risk


overall_width = 10*N + THICKNESS;
overall_length = 10*M + 2*THICKNESS;
overall_height = 10*H;

difference(){
    //main cube
    cube([overall_width,overall_length,overall_height]);
    
    //inner cutting cube
    translate([0,THICKNESS,-5]){
        cube([10*N,10*M,overall_height+10]);
    }
    
    //holes parallel to x-axis
    for(i=[0:M-1]){
        for(j=[0:H-1]){
            translate([0,THICKNESS+5+(10*i),5+(10*j)])
            rotate(90,[0,1,0])
            cylinder(h=overall_width*3,d=HOLE_DIAMETER,center=true);
        }
    }
    
    //holes parallel to y-axis
    for(p=[0:N-1]){
        for(q=[0:H-1]){
            translate([5+(10*p),0,5+(10*q)])
            rotate(90,[1,0,0])
            cylinder(h=overall_length*3,d=HOLE_DIAMETER,center=true);
        }
    }
    
}