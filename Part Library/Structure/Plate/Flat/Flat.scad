/*  
        Flat.scad
        M3Z core library 1.0.0
*/

//BEGIN OPTIONS - edit these parameters to generate custom parts of this form.

N = 5; //whole number of 10mm units along the X axis
M = 5; //whole number of 10mm units along the Y axis

THICKNESS = 2.5; //Nominal 2.5mm - thickness of the walls of the part

CHAMFER_DEPTH = 0.75; //Default 0.75mm

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

bodyWidth = N * 10;
bodyLength = M * 10;
bodyHeight = THICKNESS;
bodyDims = [bodyWidth,bodyLength,bodyHeight];

//Part Generating Code
difference(){
    chamferCube(bodyDims,CHAMFER_DEPTH);
    for(i = [0:N-1]){
        for(j = [0:M-1]){
            translate([5+(10*i),5+(10*j),0]){
                cylinder(h = 10, d = HOLE_DIAMETER, center = true, $fn = 20);
            }
        }
    }
}
