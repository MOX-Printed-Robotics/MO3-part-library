$fn=50;

PROJECTILE_D = 25;
EXTRA_MARGIN = 1;

STRAIGHT_SECTION_LENGTH = 25;
inner_scoop_d = PROJECTILE_D + EXTRA_MARGIN;
outer_scoop_d = inner_scoop_d + 8;
overall_height = outer_scoop_d - 4;
SCOOP_EXTRUDE_R = 50;

union(){
    //scoop
    translate([0,0,overall_height/2])
    difference(){
        //body torus
        rotate_extrude(convexity=10){
            translate([SCOOP_EXTRUDE_R,0,0])circle(d=outer_scoop_d);
        }
        //inner (cutting) cylinder
        cylinder(r=SCOOP_EXTRUDE_R,h=100,center=true);
        //inner (cutting) torus
        rotate_extrude(convexity=10){
            translate([SCOOP_EXTRUDE_R,0,0])circle(d=inner_scoop_d);
        }
        
        //top and bottom surface cuts (to make it printable)
        translate([-100,-100,overall_height/2])cube([200,200,200]);
        translate([-100,-100,-200 - overall_height/2])cube([200,200,200]);
        
        //pie slicing cuts
        translate([-200,-100,-100])cube([200,200,200]);
        translate([0,-200,-100])cube([200,200,200]);
        rotate(45)translate([0,0,-100])cube([200,200,200]);
    }
    
    //straight end-section
    difference(){
        rotate(45)
        translate([SCOOP_EXTRUDE_R,0,overall_height/2])
        rotate(90,[-1,0,0])
        difference(){
            translate([0,0,-0.5])
            cylinder(d=outer_scoop_d,h=STRAIGHT_SECTION_LENGTH+0.5);
            translate([0,0,-2])
            cylinder(d=inner_scoop_d, h=STRAIGHT_SECTION_LENGTH+4);
            translate([-200,-100,-100])cube([200,200,200]);
            
        }
        translate([-100,-100,overall_height])cube([200,200,200]);
        translate([-100,-100,-200])cube([200,200,200]);
    }
    //attaching block
    translate([SCOOP_EXTRUDE_R,-10,0])
    difference(){
        cube([20,10,overall_height]);
        translate([5,-15,overall_height/2 - 5])rotate(90,[-1,0,0])cylinder(h=100,d=3.2);
        translate([5,-15,overall_height/2 + 5])rotate(90,[-1,0,0])cylinder(h=100,d=3.2);
    }
}
