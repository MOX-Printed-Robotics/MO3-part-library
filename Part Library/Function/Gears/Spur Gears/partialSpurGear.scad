include <spurgearlib.scad>

SIZE = 2;
cylheight=10;
pd = SIZE * 10;
chamdepth=2;

chamrad = 1.5+ (pd / 2);
cutcyl_diameter = pd-8;
hub_diameter = 10;
cutcyl_height = cylheight *3;
spokes = 4;
spoke_width = 10;

inc=360/spokes;
cd = cutcyl_diameter;
ch = cutcyl_height;
sw = spoke_width;

CAP_D = 5.6;

FUDGE_FACTOR = 0.1;
NUT_MIN_WIDTH = 5.5;
NUT_MAX_WIDTH = 6.2;
NUT_THICKNESS = 2.25;

BORE_DIAMETER = 3;


//The meat of the codes:
missing_teeth = 7;
cutout_angle = missing_teeth * 360 / (SIZE*10);
triangle_points = [[0,0],[150,0],[150*cos(cutout_angle),150*sin(cutout_angle)]];
difference(){
    spur_gear (modul=1, tooth_number=SIZE*10, width=cylheight, bore=BORE_DIAMETER, pressure_angle=25, helix_angle=0, optimized=false);
    if(SIZE > 8){
        difference(){
        cylinder(d=cd,h=ch,$fn=50,center=true);
        cylinder(d=hub_diameter, h=ch, $fn=50, center=true);
        for(i = [0:spokes-1]){
            rotate(i*inc,[0,0,1]){
                translate([cd/2,0,0]){
                    cube([cd,sw,ch+1],center=true);
                }
            }
        }
    }
    }
    
    translate([0,0,cylheight-chamdepth]){
        difference(){
            cylinder(r=chamrad,h=cylheight);
            cylinder(r1=chamrad,r2=0,h=chamrad);
        }
    }
    translate([0,0,0-cylheight+chamdepth]){
        difference(){
            cylinder(r=chamrad,h=cylheight);
            translate([0,0,0-chamrad+cylheight])
            cylinder(r1=0, r2=chamrad, h=chamrad);
        }
    }
    rotate(360/(SIZE*10)/2 +45){
        translate([0,0,cylheight/2]){
            rotate(90,[0,1,0]){
                cylinder(h=100,d=BORE_DIAMETER);
            }
        }
        translate([2.2,-(NUT_MIN_WIDTH+FUDGE_FACTOR)/2, cylheight-(cylheight/2+NUT_MAX_WIDTH/2)]){
            cube([NUT_THICKNESS+FUDGE_FACTOR,NUT_MIN_WIDTH+FUDGE_FACTOR,cylheight/2+NUT_MAX_WIDTH/2]);
        }
    }
    rotate(360/(SIZE*10)/2){
        difference(){
            linear_extrude(h=100,center=true){
                polygon(points=triangle_points);
            }
            cylinder(h=200,d=SIZE*10 -3.5, center=true);
        }
    }
    
}


