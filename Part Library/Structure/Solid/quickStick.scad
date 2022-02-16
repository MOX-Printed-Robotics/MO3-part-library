/*
    DAEDA_M3_Struct_1x1xN
    "M3 QuickStick" 
    
    The adjustable variable N defines the length of this part. Use this code to generate any length you want by adjusting the value for N and hitting F6 or pressing Render.
    
    Printable in any orientation, but will have highest strength to weight ratio if printed laying flat rather than standing up.
    
*/


//The following variables are adjustable:
N = 5; // The number of 10mm length segments, or the number of holes along one edge. N does not strictly need to be a whole number, e.g. if N is 3.4 the resulting part will be 34 mm long. N can be 1 if a 1x1x1 cube with no nut pockets is desired.
HOLE_DIAMETER = 3.2; //Default 3.0 Nominal diameter of all through-holes. Adjustable to suit different printers, print settings, fasteners. 
NUT_THICKNESS = 2.5; // The nominal thickness of the nuts used in the rectangular nut pockets at the ends. Determines the shorter dimension of the rectangle that defines the pocket shape.
NUT_MIN_WIDTH = 5.5; // The inscribed diameter of the nuts used, or in other words the perpendicular distance between two opposite sides of the hexagon. Determines the longer dimension of the rectangle that defines the pocket shape.
NUT_MAX_WIDTH = 6.22; // The circumscribed diameter of the nuts used, or in other words the distance between two opposite corners of the hexagon. Determines the depth of the nut pocket, and therefore the alignment of the nut in line with the end holes.
CHAMFER = 1.0; // The length of the legs of the triangle that defines the edge chamfer profile.

//modules

module chamferCube(dimensions,depth){
    //where dimensions is a vector e.g. [10,20,30] and depth is the depth of the chamfer.
    
    f=2*depth;
    
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
        cube([dimensions[0]-f,dimensions[1]-f,dimensions[2]-f]);
        polyhedron(octaPoints*depth, octaFaces);
    }
}

//variables (derived and not to be edited)
bodyLength = N*10;


difference(){
    chamferCube([10,bodyLength,10],CHAMFER);
    for (i = [0:N-1]){
        translate([5,5+(i*10),-1]){
            cylinder(h=15, d=HOLE_DIAMETER,center = false,$fn=20);
        }
    }
    for (i = [0:N-1]){
        translate([5,5+(i*10),5]){
             rotate(90,[0,1,0]){
                 cylinder(h=30, d=HOLE_DIAMETER,center = true,$fn=20);
                }
        }
    }
    if(N>=1.5){
    translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2),5-(NUT_MAX_WIDTH / 2)]){
        cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
    }
    translate([5-(NUT_MIN_WIDTH / 2),10-(NUT_THICKNESS / 2)+bodyLength - 20,5-(NUT_MAX_WIDTH / 2)]){
        cube([NUT_MIN_WIDTH,NUT_THICKNESS,9],center = false);
    }
    }
    translate([5,-1,5]){
        rotate(90,[-1,0,0]){
            cylinder(h=bodyLength+2,d=HOLE_DIAMETER,center = false,$fn=20);
        }
    }
    
    
}

