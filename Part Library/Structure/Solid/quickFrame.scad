

//EDITABLE PARAMETERS:

N = 8; // The number of 10mm length segments (and the number of holes) along the x-axis dimension.
M = 5; // same as above for y-axis dimension

HOLE_DIAMETER = 3.0; //Default 3.0 Nominal diameter of all through-holes. Adjustable to suit different printers, print settings, fasteners. 

NUT_THICKNESS = 2.5; // The nominal thickness of the nuts used in the rectangular nut pockets at the ends. Determines the shorter dimension of the rectangle that defines the pocket shape.

NUT_MIN_WIDTH = 5.5; // The inscribed diameter of the nuts used, or in other words the perpendicular distance between two opposite sides of the hexagon. Determines the longer dimension of the rectangle that defines the pocket shape.

NUT_MAX_WIDTH = 6.22; // The circumscribed diameter of the nuts used, or in other words the distance between two opposite corners of the hexagon. Determines the depth of the nut pocket, and therefore the alignment of the nut in line with the end holes.

CHAMFER = 1.0; // The length of the legs of the triangle that defines the edge chamfer profile.

DO_NUT_POCKETS = false; //set to false if no nut pockets desired.

//modules

module chamferFrame(dimensions,frameThickness,depth){
    //where dimensions is a vector e.g. [10,20,30], frameThickness specifies how many mm thick the outer frame is, and depth is the depth of the chamfer.
    
    f=2*depth;
    g=2*frameThickness;
    
    octaPoints = [ 
                    [1,0,0],
                    [0,1,0],
                    [-1,0,0],
                    [0,-1,0],
                    [0,0,1],
                    [0,0,-1]
                ];

    octaFaces = [   
                    [0,4,1],
                    [1,4,2],
                    [2,4,3],
                    [3,4,0],
                    [0,1,5],
                    [1,2,5],
                    [2,3,5],
                    [3,0,5] 
                ];
    translate([depth,depth,depth])
    minkowski(){
        difference(){
            cube([dimensions[0]-f,dimensions[1]-f,dimensions[2]-f]);
            translate([frameThickness-f,frameThickness-f,-10])
            cube([dimensions[0]-g+f,dimensions[1]-g+f,100]);
        }
        polyhedron(octaPoints*depth, octaFaces);
    }
}

//variables (derived and not to be edited)

h = 1;
bodyWidth = N * 10; 
bodyLength = M * 10; 
bodyHeight = h * 10;
bodyDims = [bodyWidth,bodyLength,bodyHeight];

// Part Generating Code

difference(){
    chamferFrame(bodyDims,10,1);
    
    for(i = [0:N-1]){ // hole pattern || to Z near XZ plane
        translate([5+10*i,5,0])
        cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
    }
    
    for(i = [0:N-1]){ // hole pattern || to Z across from XZ plane
        translate([5+10*i,bodyLength-5,0])
        cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
    }
    
    for(i = [0:M-3]){ // hole pattern || to Z near YZ plane
        translate([5,15+10*i,0])
        cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
    }
    
    for(i = [0:M-3]){ // hole pattern || to Z across from YZ plane
        translate([bodyWidth-5,15+10*i,0])
        cylinder(h=30,d=HOLE_DIAMETER,center=true,$fn=20);
    }
    
    for(i = [0:N-1]){ // hole pattern || to Y axis
        translate([5+10*i,0,5]){
            rotate(90,[1,0,0]){
                cylinder(h=bodyLength*3,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    for(i = [0:M-1]){ // hole pattern || to X axis
        translate([0,5+10*i,5]){
            rotate(90,[0,1,0]){
                cylinder(h=bodyWidth*3,d=HOLE_DIAMETER,center=true,$fn=20);
            }
        }
    }
    if(DO_NUT_POCKETS ==true){
        translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+bodyLength - 20,5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2) + bodyWidth - 10,10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([5-(NUT_MIN_WIDTH / 2) + bodyWidth - 10,10-(NUT_THICKNESS / 2)+bodyLength - 20,5-(NUT_MAX_WIDTH / 2)]){
            cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
        }
        translate([0,10,0]){
            rotate(90,[0,0,-1]){
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+bodyWidth - 20,5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
            }
        }
        translate([0,bodyLength,0]){
            rotate(90,[0,0,-1]){
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
                translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+bodyWidth - 20,5-(NUT_MAX_WIDTH / 2)]){
                    cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
                }
            }
        }
    }
    
}





