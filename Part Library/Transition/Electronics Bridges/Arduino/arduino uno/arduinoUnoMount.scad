$fn=20;
N = 9;
M = 6;
HOLE_DIAMETER = 3.0;

width = 10*N;
length = 10*M;

CHAMFER = 1;
tall = 2.5;


A= CHAMFER*-1;
B= CHAMFER*2;
difference(){
    cube([width,length, 2.5]);
    for(i = [0:1]){
        for(j = [0:M-1]){
            translate([5+(10*i*(N-1)),5+(10*j),0]){
                cylinder(h = 10, d = HOLE_DIAMETER, center = true);
            }
        }
    }
    translate([(90-68.68)/2,(60-53.27)/2,0]){
        translate([13.97,2.54,0])cylinder(d=3.0,h=100,center=true);
        translate([15.24,50.8,0])cylinder(d=3.0,h=100,center=true);
        translate([66.04,7.62,0])cylinder(d=3.0,h=100,center=true);
        translate([66.04,35.56,0])cylinder(d=3.0,h=100,center=true);
    }
    linear_extrude(height = tall*2, center = true){
        polygon(points=[[A,A],[A,B],[B,A]]);
    }
    
    
    translate([width,0,tall]){
        rotate(180,[0,-1,0]){
            linear_extrude(height = tall*2,center = true){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            linear_extrude(height = tall*2,center = true){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
            
            translate([width,0,tall]){
                rotate(180,[0,-1,0]){
                    linear_extrude(height = tall*2, center = true){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }

}
