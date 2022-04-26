$fn=100;

//MAIN PARAMETERS
SIZE = 7;

OVERALL_HEIGHT = 10;
CURVE_RADIUS = 8;


//NUT POCKET AND LOCKSCREW HOLE PARAMETERS
FUDGE_FACTOR = 0.1;
NUT_MIN_WIDTH = 5.5;
NUT_MAX_WIDTH = 6.2;
NUT_THICKNESS = 2.25;

//HUB PARAMETERS
HUB_DIAMETER = 14;
HOLE_DIAMETER = 3.2;

//SPOKE PARAMETERS
SPOKE_COUNT = 4;
SPOKE_WIDTH = 5;

//Derived Values (no touchy)
torus_diameter = SIZE*10;
inwheel_diameter = torus_diameter - 10;
inc_angle = 360 / SPOKE_COUNT;

difference(){
    union(){
        translate([0,0,OVERALL_HEIGHT/2])
        difference(){
            intersection(){
                rotate_extrude(convexity = 10)
                translate([torus_diameter / 2 - CURVE_RADIUS, 0, 0])
                circle(r = CURVE_RADIUS);
                cylinder(d=torus_diameter, h=OVERALL_HEIGHT, center=true);
            }
            cylinder(d=inwheel_diameter, h=50, center=true);
        }
        for(i = [0:SPOKE_COUNT-1]){
            rotate(a=i*inc_angle)
            translate([0,-SPOKE_WIDTH/2,0])
            cube([(inwheel_diameter/2)+1,SPOKE_WIDTH,OVERALL_HEIGHT/2]);
        }
        cylinder(d=HUB_DIAMETER,h=OVERALL_HEIGHT, center=false);
    }
    cylinder(d=HOLE_DIAMETER,h=100,center=true);
    rotate(360/(2*SPOKE_COUNT)){
        translate([0,0,OVERALL_HEIGHT/2])rotate(90,[0,1,0])cylinder(h=SIZE*10,d=3.2);
        translate([2.2,-(NUT_MIN_WIDTH+FUDGE_FACTOR)/2, OVERALL_HEIGHT-(OVERALL_HEIGHT/2+NUT_MAX_WIDTH/2)]){
            cube([NUT_THICKNESS+FUDGE_FACTOR,NUT_MIN_WIDTH+FUDGE_FACTOR,OVERALL_HEIGHT/2+NUT_MAX_WIDTH/2]);
        }
    }
}
