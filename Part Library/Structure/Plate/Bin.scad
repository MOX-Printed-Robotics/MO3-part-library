/*
 
   __  ______  ____  _____
  / / / / __ \/ __ \/ ___/
 / / / / /_/ / /_/ /\__ \ 
/ /_/ / ____/ ____/___/ / 
\____/_/   /_/    /____/  
                          
                                                            
          Home of the Universal Printed Part System 
                             
Partform path:          M3_structure_shell_bin
Version:                1.0.0
Version notes:          Initial partform with core geometry only. Non-optimized.
Monikers:               "bin" "open-top box" "basket" "endcapped cee" "flanged cee"
contributors:           Alex Penney
*/

include </libraries/cubicchamferlib.scad>;
//BEGIN OPTIONS - edit these parameters to generate custom parts of this form.

N = 2; //whole number of 10mm units along the X axis
M = 20; //whole number of 10mm units along the Y axis
H = 1; //whole number of 10mm units along the Z axis.

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the two "walls" of the part

HOLE_DIAMETER = 3.2; //Nominal 3.0mm - common diameter of holes throughout

HOLE_FACES = 20; //Default 20 - higher number => slower render, smoother holes

//END OPTIONS - edit all else at your own risk

width = N * 10 + THICKNESS * 2;
length = M * 10 + THICKNESS * 2;
tall = H * 10 + THICKNESS * 2;

difference(){
    cube([width,length,tall]);
    translate([THICKNESS,THICKNESS,THICKNESS]){
        cube([N*10,M*10,H*11]);
    }
    translate([-1,-1,tall-THICKNESS]){
        cube([width+2,length+2,THICKNESS+2]);
    }
    
    chamfer(depth=1,x=width,y=M*10+THICKNESS*2,z=(H*10 + THICKNESS));
    
    for(i = [0:N-1]){
        for(j = [0:M-1]){
            translate([THICKNESS+5+10*i, THICKNESS+5+10*j,0]){
                cylinder(h= tall*3, d = HOLE_DIAMETER, center = true, $fn = 20);
            }
        }
    }
    for(i = [0:N-1]){
        for(k = [0:H-1]){
            translate([THICKNESS+5+10*i, 0, THICKNESS+5+10*k]){
                rotate(90,[1,0,0]){
                    cylinder(h=length*3, d=HOLE_DIAMETER, center = true, $fn = 20);
                }
            }
        }
    }
    for(j = [0:M-1]){
        for(k = [0:H-1]){
            translate([0,THICKNESS+5+10*j,THICKNESS+5+10*k]){
                rotate(90,[0,1,0]){
                    cylinder(h=width*3, d=HOLE_DIAMETER, center = true, $fn = 20);
                }
            }
        }
    }
}
    

