$fn=15;

PLATE_THICKNESS = 5;

SCREW_SPACING = 27.5; //center-to-center dist. between servo mounting holes.

AXLE_POSITION = 8.25; //distance from servo output axis to center of nearest
                      //mounting hole. Aligned to part grid.
SHOW_AXLE_POSITION = false;
                      
SERVO_BOXWIDTH = 12.11;
SERVO_BOXLENGTH = 22.53;

cutout_width = SERVO_BOXWIDTH + 1;
cutout_length = SERVO_BOXLENGTH + 1;
MOUNTHOLE_D = 2.1;

GRIDHOLE_D = 3.2;

N = 4;
M = 4;

P = 3;
Q = 2;

AXLE_X_POS = (P*10)-5;
AXLE_Y_POS = (Q*10)-5;

if(SHOW_AXLE_POSITION == true){
    translate([AXLE_X_POS,AXLE_Y_POS,0]){
        color("red")
        cylinder(h=100,d=2,center=true);
}
}


difference(){
    
    union(){
        cube([N*10,M*10,PLATE_THICKNESS]);
        translate([0,20,0])cube([40,20,20]);
    }
    translate([-1,AXLE_Y_POS-cutout_width/2,PLATE_THICKNESS]){
        cube([100,cutout_width,100]);
    }
    for(i=[0:1]){
        translate([5+i*10*(N-1),0,15])
        rotate(90,[1,0,0])
        cylinder(h=200,d=GRIDHOLE_D,center=true);
    }
    translate([AXLE_X_POS,AXLE_Y_POS,0]){
        
        translate([AXLE_POSITION,0,0]){
            cylinder(d=MOUNTHOLE_D, h=100, center=true);
        }
        translate([AXLE_POSITION - SCREW_SPACING,0,0]){
            cylinder(d=MOUNTHOLE_D, h=100, center=true);
        }
        translate([AXLE_POSITION - (SCREW_SPACING/2),0,0]){
            cube([cutout_length,cutout_width,100], center=true);
        }
    }
    
    for(i = [0:N-1]){
        for(j = [0:M-1]){
            if(!(((i==((AXLE_X_POS-5)/10)-2)&&(j==(AXLE_Y_POS-5)/10))||((i==((AXLE_X_POS-5)/10)+1)&&(j==(AXLE_Y_POS-5)/10)))){
                translate([5+i*10,5+j*10,0]){
                    cylinder(d=GRIDHOLE_D,h=100,center=true);
                }
            }
        }
    }
}