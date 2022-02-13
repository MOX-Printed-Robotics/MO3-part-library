/*
    DAEDA_M3_Struct_1x1xN
    "M3 QuickStick" 
    
    The adjustable variable N defines the length of this part. Use this code to generate any length you want by adjusting the value for N and hitting F6 or pressing Render.
    
    Printable in any orientation, but will have highest strength to weight ratio if printed laying flat rather than standing up.
    
*/


//The following variables are adjustable:
N = 5; // The number of 10mm length segments, or the number of holes along one edge. N does not strictly need to be a whole number, e.g. if N is 3.4 the resulting part will be 34 mm long. N can be 1 if a 1x1x1 cube with no nut pockets is desired.
HOLE_DIAMETER = 3.0; //Default 3.0 Nominal diameter of all through-holes. Adjustable to suit different printers, print settings, fasteners. 
NUT_THICKNESS = 2.5; // The nominal thickness of the nuts used in the rectangular nut pockets at the ends. Determines the shorter dimension of the rectangle that defines the pocket shape.
NUT_MIN_WIDTH = 5.5; // The inscribed diameter of the nuts used, or in other words the perpendicular distance between two opposite sides of the hexagon. Determines the longer dimension of the rectangle that defines the pocket shape.
NUT_MAX_WIDTH = 6.22; // The circumscribed diameter of the nuts used, or in other words the distance between two opposite corners of the hexagon. Determines the depth of the nut pocket, and therefore the alignment of the nut in line with the end holes.
CHAMFER = 1.0; // The length of the legs of the triangle that defines the edge chamfer profile.

//DO NOT mess with the following variables. These are non-adjustable for this part.
length = N * 10; // Determined from N.
radius = HOLE_DIAMETER / 2; // Determined from HOLE_DIAMETER.
width = 10; // used only for chamfer generation
tall = 10; // used only for chamfer generation
A= CHAMFER*-1; // derived from CHAMFER.
B= CHAMFER*2;  // derived from CHAMFER

outerpoints = [ //used to generate polyhedra for trimming the corners
[-1,-1,-1],
[CHAMFER,0,CHAMFER],
[0,CHAMFER,CHAMFER],
[CHAMFER,CHAMFER,0]];

outerfaces = [ //used to generate polyhedra for trimming the corners
[0,1,2],
[0,2,3],
[0,3,1],
[1,3,2]];

difference(){
    cube([10,length,10]);
    for (i = [0:N-1]){
        translate([5,5+(i*10),-1]){
            cylinder(h=15, r=radius,center = false,$fn=20);
        }
    }
    for (i = [0:N-1]){
        translate([5,5+(i*10),5]){
             rotate(90,[0,1,0]){
                 cylinder(h=30, r=radius,center = true,$fn=20);
                }
        }
    }
    if(N>=1.5){
    translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
        cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
    }
    translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+length - 20,5-(NUT_MAX_WIDTH / 2)]){
        cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
    }
    }
    translate([5,-1,5]){
        rotate(90,[-1,0,0]){
            cylinder(h=length+2,r=radius,center = false,$fn=20);
        }
    }
    
    width = 10;
    tall = 10;
    
    
    A= CHAMFER*-1;
    B= CHAMFER*2;
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

