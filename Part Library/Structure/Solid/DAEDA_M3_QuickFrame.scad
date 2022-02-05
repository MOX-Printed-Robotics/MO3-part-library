

//EDITABLE PARAMETERS:

N = 8; // The number of 10mm length segments (and the number of holes) along the x-axis dimension.
M = 5; // same as above for y-axis dimension

HOLE_DIAMETER = 3.0; //Default 3.0 Nominal diameter of all through-holes. Adjustable to suit different printers, print settings, fasteners. 

NUT_THICKNESS = 2.5; // The nominal thickness of the nuts used in the rectangular nut pockets at the ends. Determines the shorter dimension of the rectangle that defines the pocket shape.

NUT_MIN_WIDTH = 5.5; // The inscribed diameter of the nuts used, or in other words the perpendicular distance between two opposite sides of the hexagon. Determines the longer dimension of the rectangle that defines the pocket shape.

NUT_MAX_WIDTH = 6.22; // The circumscribed diameter of the nuts used, or in other words the distance between two opposite corners of the hexagon. Determines the depth of the nut pocket, and therefore the alignment of the nut in line with the end holes.

CHAMFER = 1.0; // The length of the legs of the triangle that defines the edge chamfer profile.

DO_NUT_POCKETS = false; //set to false if no nut pockets desired.


//Derived Values (non-adjustable)

length = M * 10; // Determined from N.
width = N * 10;
radius = HOLE_DIAMETER / 2; // Determined from HOLE_DIAMETER.
tall = 10;

A= CHAMFER*-1;
B= CHAMFER*2;

hedrapoints = [
[-1,-1,-1],
[1,0,0],
[0,1,0],
[0,0,1]];

hedrafaces = [
[0,1,2],
[0,2,3],
[0,3,1],
[1,3,2]];

outerpoints = [
[-1,-1,-1],
[1,0,1],
[0,1,1],
[1,1,0]];

outerfaces = [
[0,1,2],
[0,2,3],
[0,3,1],
[1,3,2]];

difference(){
    cube([width,length,10]); //outermost shell
    translate([10,10,-5]){ //large interior negative space
        cube([width-20,length-20,20]);
    }
    for(i = [0:N-1]){ // hole pattern || to Z near XZ plane
        translate([5+10*i,5,0]){
            rotate(){
                cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:N-1]){ // hole pattern || to Z across from XZ plane
        translate([5+10*i,length-5,0]){
            rotate(){
                cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:M-3]){ // hole pattern || to Z near YZ plane
        translate([5,15+10*i,0]){
            rotate(){
                cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:M-3]){ // hole pattern || to Z across from YZ plane
        translate([width-5,15+10*i,0]){
            rotate(){
                cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:N-1]){ // hole pattern || to Y axis
        translate([5+10*i,0,5]){
            rotate(90,[1,0,0]){
                cylinder(h=length*3,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:M-1]){ // hole pattern || to X axis
        translate([0,5+10*i,5]){
            rotate(90,[0,1,0]){
                cylinder(h=width*3,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    if(DO_NUT_POCKETS ==true){
        translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+length - 20,5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2) + width - 10,10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2) + width - 10,10-(NUT_THICKNESS / 2)+length - 20,5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([0,10,0]){
            rotate(90,[0,0,-1]){
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+width - 20,5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
            }
        }
        translate([0,length,0]){
            rotate(90,[0,0,-1]){
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+width - 20,5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
            }
        }
    }
    //CUBIC CHAMFER GEOMETRY
    
    //these first four are the four edges on the XZ plane.
    linear_extrude(height = tall){
        polygon(points=[[A,A],[A,B],[B,A]]);
    }
    translate([width,0,0]){
        rotate(90,[0,-1,0]){
            linear_extrude(height = width){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([0,0,tall]){
        rotate(270,[0,-1,0]){
            linear_extrude(height = width){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([width,0,tall]){
        rotate(180,[0,-1,0]){
            linear_extrude(height = tall){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    //this block mirror-copies the XZ plane edges to the opposite face of the cube.
    translate([width,length,0]){
        rotate(180,[0,0,1]){
                    linear_extrude(height = tall){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
            translate([width,0,0]){
                rotate(90,[0,-1,0]){
                    linear_extrude(height = width){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([0,0,tall]){
                rotate(270,[0,-1,0]){
                    linear_extrude(height = width){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([width,0,tall]){
                rotate(180,[0,-1,0]){
                    linear_extrude(height = tall){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    
    //These two are the remaining edges on the YZ plane.
    translate([0,length,0]){
        rotate(90,[1,0,0]){
            linear_extrude(height = length){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([0,0,tall]){
        rotate(90,[-1,0,0]){
            linear_extrude(height = length){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    //This block mirror-copies the previous YZ plane edges to the opposite side, completing the cube.
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([0,length,0]){
                rotate(90,[1,0,0]){
                    linear_extrude(height = length){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([0,0,tall]){
                rotate(90,[-1,0,0]){
                    linear_extrude(height = length){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    //CUBIC INNER CHAMFER GEOMETRY
    
    translate([width-10,length-10,0]){
        rotate(90,[0,-1,0]){
            linear_extrude(height = width-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([10,length-10,tall]){
        rotate(270,[0,-1,0]){
            linear_extrude(height = width-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([width-10,length-10,0]){
                rotate(90,[0,-1,0]){
                    linear_extrude(height = width-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([10,length-10,tall]){
                rotate(270,[0,-1,0]){
                    linear_extrude(height = width-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    
    translate([width-10,length-10,0]){
        rotate(90,[1,0,0]){
            linear_extrude(height = length-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([width-10,10,tall]){
        rotate(90,[-1,0,0]){
            linear_extrude(height = length-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([width-10,length-10,0]){
                rotate(90,[1,0,0]){
                    linear_extrude(height = length-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([width-10,10,tall]){
                rotate(90,[-1,0,0]){
                    linear_extrude(height = length-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    //inner chamfer corners
    translate([width-10,length-10,0]){
        polyhedron(hedrapoints, hedrafaces);
    }
    translate([width-10,10,0]){
        rotate(90,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([10,10,0]){
        rotate(180,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([10,length-10,0]){
        rotate(270,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([0,length,10]){
        rotate(180,[-1,0,0]){
            translate([width-10,length-10,0]){
                polyhedron(hedrapoints, hedrafaces);
            }
            translate([width-10,10,0]){
                rotate(90,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
            translate([10,10,0]){
                rotate(180,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
            translate([10,length-10,0]){
                rotate(270,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
        }
    }
    // outer chamfer corners
    polyhedron(outerpoints, outerfaces);
    translate([width,0,0]){
        rotate(90,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([0,length,0]){
        rotate(270,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,0,10]){
        rotate(180,[0,1,0]){
            polyhedron(outerpoints, outerfaces);
            translate([width,0,0]){
                rotate(90,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([width,length,0]){
                rotate(180,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([0,length,0]){
                rotate(270,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
        }
    }          
}





