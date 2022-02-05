octapoints = [
                [0,-1,0],
                [1,0,0],
                [0,1,0],
                [-1,0,0],
                [0,0,1],
                [0,0,-1]
             ];

octafaces = [
                [0,4,1],
                [1,4,2],
                [2,4,3],
                [3,4,0],
                [0,1,5],
                [1,2,5],
                [2,3,5],
                [3,0,5]          
            ];

minkowski(){
polyhedron(octapoints,octafaces);
union(){
    cube([10,10,30]);
    translate([-10,0,10])cube([30,10,10]);
    translate([0,-10,10])cube([10,30,10]);
}
}