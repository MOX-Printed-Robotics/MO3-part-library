include <spurgearlib.scad>;

//MAIN PARAMETERS
SIZE = 3;
OVERALL_HEIGHT=10;
AXIS_BORE_DIAMETER = 3.0;

//CHAMFER PARAMETERS
CHAMFER_DEPTH=2;

//NUT POCKET AND LOCKSCREW HOLE PARAMETERS
FUDGE_FACTOR = 0.1;
NUT_MIN_WIDTH = 5.5;
NUT_MAX_WIDTH = 6.2;
NUT_THICKNESS = 2.25;

LOCK_BORE_DIAMETER = 3.2;

//SPOKE PARAMETERS
HUB_DIAMETER = 20;
OUTER_THICKNESS = 10;
SPOKE_COUNT = 4;
SPOKE_WIDTH = 10;





//DERIVED VALUES (NO TOUCHY)
    //main
    pitch_diameter = SIZE*10;
    //chamfer
    chamrad = 1.5+ (pitch_diameter / 2);
    //spokes
    cutcyl_diameter = pitch_diameter-OUTER_THICKNESS;
    cutcyl_height = OVERALL_HEIGHT *3;
    inc=360/SPOKE_COUNT;
    cd = cutcyl_diameter;
    ch = cutcyl_height;
    sw = SPOKE_WIDTH;




//The meat of the codes:

difference(){
    spur_gear (modul=1, tooth_number=SIZE*10, width=OVERALL_HEIGHT, bore=AXIS_BORE_DIAMETER, pressure_angle=25, helix_angle=0, optimized=false);
    if(SIZE > 3){
        difference(){
        cylinder(d=cd,h=ch,$fn=50,center=true);
        cylinder(d=HUB_DIAMETER, h=ch, $fn=50, center=true);
        for(i = [0:SPOKE_COUNT-1]){
            rotate(i*inc,[0,0,1]){
                translate([cd/2,0,0]){
                    cube([cd,sw,ch+1],center=true);
                }
            }
        }
    }
    }
    
    translate([0,0,OVERALL_HEIGHT-CHAMFER_DEPTH]){
        difference(){
            cylinder(r=chamrad,h=OVERALL_HEIGHT);
            cylinder(r1=chamrad,r2=0,h=chamrad);
        }
    }
    translate([0,0,0-OVERALL_HEIGHT+CHAMFER_DEPTH]){
        difference(){
            cylinder(r=chamrad,h=OVERALL_HEIGHT);
            translate([0,0,0-chamrad+OVERALL_HEIGHT])
            cylinder(r1=0, r2=chamrad, h=chamrad);
        }
    }
    rotate(floor(pitch_diameter/(2*SPOKE_COUNT))*(360/pitch_diameter) + (360/pitch_diameter)/2){
        translate([0,0,OVERALL_HEIGHT/2]){
            rotate(90,[0,1,0]){
                cylinder(h=100,d=LOCK_BORE_DIAMETER);
            }
        }
        translate([2.2,-(NUT_MIN_WIDTH+FUDGE_FACTOR)/2, OVERALL_HEIGHT-(OVERALL_HEIGHT/2+NUT_MAX_WIDTH/2)]){
            cube([NUT_THICKNESS+FUDGE_FACTOR,NUT_MIN_WIDTH+FUDGE_FACTOR,OVERALL_HEIGHT/2+NUT_MAX_WIDTH/2]);
        }
    }
    
    //gridholes
    for(i=[0:90:270]){
        rotate(i){
            for(j=[1:floor(SIZE/2) - (1-(SIZE%2)) ]){
                translate([j*10,0,0]){
                    cylinder(h=100,d=3.2,center=true);
                }
            }
        }
        
    }
    
    
}


