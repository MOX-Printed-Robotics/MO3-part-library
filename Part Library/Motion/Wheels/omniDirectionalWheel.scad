
//Parameters (yes touchy)
SIZE = 7;
BORE_D = 3.0;
BRACKET_HOLE_D = 3.0;

SHOW_ROLLERS = true;

ROLLER_ARC_POINTS = 10;
ROLLER_HEIGHT = 22;
ROLLER_TOP_BTM_D = 11;
ROLLER_COUNT = 5;

BRACKET_THICKNESS = 3.0;

FUDGE_FACTOR = 0.1;
NUT_MIN_WIDTH = 5.5;
NUT_MAX_WIDTH = 6.2;
NUT_THICKNESS = 2.25;
SCREW_CAP_D = 5.5;

//Derived Values (no touchy)
wheel_diameter = SIZE * 10;
wheel_radius = wheel_diameter / 2;
roller_top_btm_r = ROLLER_TOP_BTM_D / 2;

downshift = sqrt(pow(wheel_radius,2)-pow(ROLLER_HEIGHT/2,2));
overall_roller_r = roller_top_btm_r +  wheel_radius - downshift;
overall_roller_d = overall_roller_r * 2;

arc_x_inc = ROLLER_HEIGHT / ROLLER_ARC_POINTS;
arcpoints = ([ for (i = [0 : ROLLER_ARC_POINTS]) [-(ROLLER_HEIGHT/2)+(i*arc_x_inc),roller_top_btm_r -downshift + sqrt(pow(wheel_radius,2)-pow(-(ROLLER_HEIGHT/2)+(i*arc_x_inc),2))] ]);
    
polypoints = concat([[-(ROLLER_HEIGHT/2),0]],arcpoints,[[ROLLER_HEIGHT/2,0]]);

inc_angle = 360/ROLLER_COUNT;


body_cylinder_r = wheel_radius - overall_roller_d - 1.5;

bracket_gap = ROLLER_HEIGHT + 1.2;
bracket_length = 16;
top_bracket_length = 18.5;
bracket_height = ROLLER_TOP_BTM_D -5;
pin_dist_ctr = wheel_radius-overall_roller_r;

body_cylinder_height = ROLLER_TOP_BTM_D*2 + overall_roller_d -ROLLER_TOP_BTM_D-(ROLLER_TOP_BTM_D-bracket_height)-5.5;

difference(){
translate([0,0,-(-roller_top_btm_r+(ROLLER_TOP_BTM_D-bracket_height)/2)]){
union(){
//Brackets

//  Bottom Brackets
for(i=[0:ROLLER_COUNT-1]){
    rotate(i*inc_angle,[0,0,1]){
    translate([-bracket_gap/2,pin_dist_ctr,0])
    rotate(90,[0,-1,0])
    difference(){
        union(){
            cylinder(d=bracket_height,h=BRACKET_THICKNESS, $fn=20);
            translate([-bracket_height/2,-bracket_length,0])
            cube([bracket_height,bracket_length,BRACKET_THICKNESS]);
        }
        cylinder(d=BRACKET_HOLE_D,h=12,center=true,$fn=20);
    }
    translate([bracket_gap/2,pin_dist_ctr,0])
    rotate(90,[0,1,0])
    difference(){
        union(){
            cylinder(d=bracket_height,h=BRACKET_THICKNESS, $fn=20);
            translate([-bracket_height/2,-bracket_length,0])
            cube([bracket_height,bracket_length,BRACKET_THICKNESS]);
        }
        cylinder(d=BRACKET_HOLE_D,h=12,center=true,$fn=20);
    }
}
}

//  Top Brackets

for(i=[0:ROLLER_COUNT-1]){
    rotate(i*inc_angle + inc_angle/2,[0,0,1]){
    translate([-bracket_gap/2,pin_dist_ctr,overall_roller_d])
    rotate(25,[1,0,0])
    rotate(90,[0,-1,0])
    difference(){
        union(){
            cylinder(d=bracket_height,h=BRACKET_THICKNESS, $fn=20);
            translate([-bracket_height/2,-top_bracket_length,0])
            cube([bracket_height,top_bracket_length,BRACKET_THICKNESS]);
        }
        cylinder(d=BRACKET_HOLE_D,h=12,center=true,$fn=20);
    }
    translate([bracket_gap/2,pin_dist_ctr,overall_roller_d])
    rotate(25,[1,0,0])
    rotate(90,[0,1,0])
    difference(){
        union(){
            cylinder(d=bracket_height,h=BRACKET_THICKNESS, $fn=20);
            translate([-bracket_height/2,-top_bracket_length,0])
            cube([bracket_height,top_bracket_length,BRACKET_THICKNESS]);
        }
        cylinder(d=BRACKET_HOLE_D,h=12,center=true,$fn=20);
    }
}
}

//Body Cylinder
difference(){
translate([0,0,-roller_top_btm_r+(ROLLER_TOP_BTM_D-bracket_height)/2])
cylinder(h=body_cylinder_height, r=body_cylinder_r);
translate([0,0,-roller_top_btm_r+(ROLLER_TOP_BTM_D-bracket_height)/2+10])
cylinder(r=body_cylinder_r-4, h=100 );
    
cylinder(d=BORE_D, h=100, center=true, $fn=20);
rotate(){
    translate(){
        rotate(){
            cylinder();
            cylinder();
        }
    }
}
}
//Rollers (for visual only, turn off for STL generation)
if(SHOW_ROLLERS == true){
    for(i = [0:ROLLER_COUNT-1]){
        rotate(i*inc_angle,[0,0,1])
        translate([-ROLLER_HEIGHT/2,pin_dist_ctr,0])
        rotate(90,[0,1,0])
        rotate_extrude($fn=20)
        rotate(180,[0,1,0])
        rotate(90,[0,0,1])
        translate([ROLLER_HEIGHT/2,0,0])
        polygon(polypoints);
    }
    for(i = [0:ROLLER_COUNT-1]){
        rotate(i*inc_angle + inc_angle/2,[0,0,1])
        translate([-ROLLER_HEIGHT/2,pin_dist_ctr,overall_roller_d])
        rotate(90,[0,1,0])
        rotate_extrude($fn=20)
        rotate(180,[0,1,0])
        rotate(90,[0,0,1])
        translate([ROLLER_HEIGHT/2,0,0])
        polygon(polypoints);
    }
}
}
}

}