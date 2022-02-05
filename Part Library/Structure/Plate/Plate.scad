N = 2;
M = 10;
HOLE_DIAMETER = 3.2;

width = 10*N;
length = 10*M;

CHAMFER = 1;
tall = 2.5;


A= CHAMFER*-1;
B= CHAMFER*2;
difference(){
    cube([width,length, 2.5]);
    for(i = [0:N-1]){
        for(j = [0:M-1]){
            translate([5+(10*i),5+(10*j),0]){
                cylinder(h = 10, d = HOLE_DIAMETER, center = true, $fn = 20);
            }
        }
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
