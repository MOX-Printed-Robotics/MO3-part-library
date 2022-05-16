
//EDITABLE PARAMETERS:

$fn=20; //number of faces on hole cylinders; higher number -> slower render.

/*
N, M, and H define the overall dimensions of the part. Use whole numbers;
each represents a number of whole 10mm standard units. 
N: X-axis, width
M: Y-axis, length
H: Z-axis, height
*/

N = 5; 
M = 2;
H = 2;

DO_NUT_POCKETS = false; //set to true or false depending on whether nut pockets are desired.

HOLE_DIAMETER = 3.2; //Default 3.2 - Diameter of all through-holes. 
NUT_THICKNESS = 2.5; // The thickness of the nuts used.

NUT_MIN_WIDTH = 5.5; // The inscribed diameter of the nuts used.
NUT_MAX_WIDTH = 6.22; // The circumscribed diameter of the nuts used.

NUT_CLEARANCE = 0.2;

CHAMFER_DEPTH = 1.0; // The length of the legs of the triangle that defines the edge chamfer profile.

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
bodyWidth = N*10;
bodyLength = M*10;
bodyHeight = H*10;
bodyDims = [bodyWidth, bodyLength, bodyHeight];

nutPocketWidth = NUT_THICKNESS + NUT_CLEARANCE;
nutPocketLength = NUT_MIN_WIDTH + NUT_CLEARANCE;
nutPocketHeight = 5 + NUT_MAX_WIDTH/2 + 1;
nutPocketDims = [nutPocketWidth, nutPocketLength, nutPocketHeight];

difference(){
    chamferCube(bodyDims,CHAMFER_DEPTH);
    
    //hole pattern along XZ plane
    for(i = [0:N-1]){
        for(j = [0:H-1]){
            translate([5+10*i,0,5+10*j])
            rotate(90,[1,0,0])
            cylinder(h=bodyLength*3,d=HOLE_DIAMETER,center=true);
        }
    }
    
    //hole pattern along XY plane
    for(i = [0:N-1]){
        for(j = [0:M-1]){
            translate([5+10*i,5+10*j,0])
            cylinder(h=bodyHeight*3,d=HOLE_DIAMETER,center=true);
        }
    }
    
    //hole pattern along YZ plane
    for(i = [0:M-1]){
        for(j = [0:H-1]){
            translate([0,5+10*i,5+10*j])
            rotate(90,[0,1,0])
            cylinder(h=bodyWidth*3,d=HOLE_DIAMETER,center=true);
        }
    }
    
    for(i=[0:M-1]){

        translate([ 10-nutPocketWidth/2,
                    5-nutPocketLength/2 + 10*i,
                    -1])
        cube(nutPocketDims);
        
        translate([ 10-nutPocketWidth/2,
                    5-nutPocketLength/2 + 10*i,
                    bodyHeight-nutPocketHeight+1])
        cube(nutPocketDims);
        
        translate([bodyWidth-20,0,0]){
            translate([ 10-nutPocketWidth/2,
                        5-nutPocketLength/2 + 10*i,
                        -1])
            cube(nutPocketDims);
            
            translate([ 10-nutPocketWidth/2,
                        5-nutPocketLength/2 + 10*i,
                        bodyHeight-nutPocketHeight+1])
            cube(nutPocketDims);
        }
            
    }
    
}

