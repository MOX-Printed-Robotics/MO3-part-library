/*
 
  _   _ ____  ____  ____  _       _                         
 | | | |  _ \|  _ \/ ___|| | __ _| |__   ___ ___  _ __ ___  
 | | | | |_) | |_) \___ \| |/ _` | '_ \ / __/ _ \| '_ ` _ \ 
 | |_| |  __/|  __/ ___) | | (_| | |_) | (_| (_) | | | | | |
  \___/|_|   |_|   |____/|_|\__,_|_.__(_)___\___/|_| |_| |_|
                                                            
          Home of the Universal Printed Part System 

Partform path:          M3_structure_shell_v
Version:                1.0.0
Version notes:          Initial partform with core geometry only. Non-optimized.
Monikers:               "vee" "vee channel" "plain vee" 
contributors:           Alex Penney
*/

// BEGIN OPTIONS- edit these values to generate different parts of this form.

N = 1; //whole number of 10mm units along the X axis
M = 2; //whole number of 10mm units along the Y axis
H = 4; //whole number of 10mm units along the Z axis.

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the two "walls" of the part

HOLE_DIAMETER = 3.0; //Nominal 3.0mm - common diameter of holes throughout

HOLE_FACES = 20; //Default 20 - higher number => slower render, smoother holes

// END OPTIONS- edit what follows at your own risk

width = 10*N + 2*THICKNESS;
length = 10*M + 2*THICKNESS;
tall = 10*H;



difference(){
    cube([width,length,tall]);
    
    translate([0,0,-1]){
        cube([10*N + THICKNESS,10*M + THICKNESS,tall*3],center=false);
    }
    
    for(i = [0:N-1]){
        for(k = [0:H-1]){
            translate([THICKNESS+5+i*10,0,5+k*10]){
                rotate(90,[1,0,0]){
                    cylinder(h = length*4, d = HOLE_DIAMETER,center = true,$fn = HOLE_FACES);
                }
            }
        }
    }
    
    for(j = [0:M-1]){
        for(k = [0:H-1]){
            translate([0,THICKNESS+5+j*10,5+k*10]){
                rotate(90,[0,1,0]){
                    cylinder(h=width*4,d=HOLE_DIAMETER,center=true,$fn=HOLE_FACES);
                }
            }
        }
    }
    translate([-1,-1,-1]){
        cube([THICKNESS+1,length+2,tall+2]);
    }
    translate([-1,-1,-1]){
        cube([width+2,THICKNESS+1,tall+2]);
    }
    
}