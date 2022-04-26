$fn=60;
SPHERE_DIAMETER = 25;
FLATCUT_HEIGHT = 1.2;

difference(){
    sphere(d=SPHERE_DIAMETER);
    translate([0,0,-25 -(SPHERE_DIAMETER/2) + FLATCUT_HEIGHT]){
        cube([50,50,50],center=true);
    }
}