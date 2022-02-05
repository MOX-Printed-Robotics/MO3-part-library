lipl = 1.0; //lip length
lipd = 6.0;
ebl = 5.0; //overall length of the endbody
linkd = 5.0; //link body diameter
linkh = 4.0; //link body height 
splitw = 1.0;
splitl = 4.0;

endbody_points = [
                    [0,0],
                    [0,ebl],
                    [linkd/2,ebl],
                    [linkd/2,lipl],
                    [lipd/2,lipl/2],
                    [lipd/2,0]
                 ];


difference(){
    rotate_extrude($fn=20)
    polygon(endbody_points);
    
    //top and bottom cutting cubes
    translate([-5,linkh/2,0])cube([10,10,10]);
    translate([-5,-10-linkh/2,0])cube([10,10,10]);
    
    //split cutting cube
    translate([-splitw/2,-5,0])cube([splitw,10,splitl]);
    
    //split cutting cylinder
    cylinder(h=splitl, d=linkd-2,$fn=20);
}
