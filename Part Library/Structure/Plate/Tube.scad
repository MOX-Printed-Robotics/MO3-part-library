/*  
        Bin.scad
        M3Z core library 1.0.0
*/

//BEGIN OPTIONS - edit these parameters to generate custom parts of this form.

N = 2; //whole number of 10mm units along the X axis
M = 2; //whole number of 10mm units along the Y axis
H = 5; //whole number of 10mm units along the Z axis.

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the walls of the part

CHAMFER_DEPTH = 1.0; //Default 1.0mm

HOLE_DIAMETER = 3.2; //Nominal 3.0mm - common diameter of holes throughout

HOLE_FACES = 15; //Default 20 - higher number => slower render, smoother holes

//END OPTIONS - edit all else at your own risk

//Modules

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

bodyWidth = N * 10 + THICKNESS * 2;
bodyLength = M * 10 + THICKNESS * 2;
bodyHeight = H * 10;
bodyDims = [bodyWidth,bodyLength,bodyHeight];

//Part Generating Code

difference(){
    chamferCube(bodyDims, CHAMFER_DEPTH);
    translate([bodyWidth/2,bodyLength/2,0]){
        cube([10*N,10*M,bodyHeight*3],center=true);
    }
    
    for(i = [0:N-1]){
        for(k = [0:H-1]){
            translate([THICKNESS+5+i*10,0,5+k*10]){
                rotate(90,[1,0,0]){
                    cylinder(h = bodyLength*4, d = HOLE_DIAMETER,center = true,$fn = HOLE_FACES);
                }
            }
        }
    }
    
    for(j = [0:M-1]){
        for(k = [0:H-1]){
            translate([0,THICKNESS+5+j*10,5+k*10]){
                rotate(90,[0,1,0]){
                    cylinder(h=bodyWidth*4,d=HOLE_DIAMETER,center=true,$fn=HOLE_FACES);
                }
            }
        }
    }
    
}