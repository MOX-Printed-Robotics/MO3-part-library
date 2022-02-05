/*
 
  _   _ ____  ____  ____  _       _                         
 | | | |  _ \|  _ \/ ___|| | __ _| |__   ___ ___  _ __ ___  
 | | | | |_) | |_) \___ \| |/ _` | '_ \ / __/ _ \| '_ ` _ \ 
 | |_| |  __/|  __/ ___) | | (_| | |_) | (_| (_) | | | | | |
  \___/|_|   |_|   |____/|_|\__,_|_.__(_)___\___/|_| |_| |_|
                                                            

                             
Partform path:          M3_structure_shell_sofa
Version:                1.0.0
Version notes:          Initial partform with core geometry only. Non-optimized.
Monikers:               "sofa" "endcapped vee" "flanged vee" 
contributors:           Alex Penney
*/

//BEGIN OPTIONS - edit these parameters to generate custom parts of this form.

N = 10; //whole number of 10mm units along the X axis
M = 2; //whole number of 10mm units along the Y axis
H = 2; //whole number of 10mm units along the Z axis.

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the two "walls" of the part

HOLE_DIAMETER = 3.0; //Nominal 3.0mm - common diameter of holes throughout

HOLE_FACES = 20; //Default 20 - higher number => slower render, smoother holes

//END OPTIONS - edit all else at your own risk

width = N * 10 + THICKNESS * 2;
length = M * 10 + THICKNESS * 2;
tall = H * 10 + THICKNESS * 2;

difference(){
    cube([width,length,tall]);
    translate([THICKNESS,THICKNESS,THICKNESS]){
        cube([N*10,M*11,H*11]);
    }
    translate([-1,-1,tall-THICKNESS]){
        cube([width+2,length+2,THICKNESS+2]);
    }
     translate([-1,length-THICKNESS,-1]){
        cube([width+2,THICKNESS+2,tall+2]);
    }
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
    

