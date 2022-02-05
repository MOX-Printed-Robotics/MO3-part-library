lipl = 1.0; //lip length
lipd = 6.0;
ebl = 5.0; //overall length of the endbody
linkd = 5.0; //link body diameter
linkh = 3.5; //link body height 
splitw = 1.0;
splitl = 3.5;

POINTS = 60;

mr = lipd/2 +0.2; //max radius of locking cam surface
subt = 0.2;

ia = 360 / POINTS;

    
polypoints =    ([ 
                    for (i = [0 : POINTS-1]) 
                        [(mr-(subt*((sin(4*i*ia)+1))/2))*cos(i*ia),
                         (mr-(subt*((sin(4*i*ia)+1))/2))*sin(i*ia)] 
                ]);


endbody_points = [
                    [0,0],
                    [0,ebl],
                    [linkd/2,ebl],
                    [linkd/2,lipl],
                    [lipd/2,lipl/2],
                    [lipd/2,0]
                 ];
union(){
    translate([0,0,linkh/2])
    rotate(90,[-1,0,0])
    difference(){
        rotate_extrude($fn=20)
        polygon(endbody_points);
        
        //top and bottom cutting cubes
        translate([-5,linkh/2,0])cube([10,10,10]);
        translate([-5,-10-linkh/2,0])cube([10,10,10]);
        
        //split cutting cube
        translate([-splitw/2,-5,0])cube([splitw,10,splitl]);
        
        //split cutting cylinder
        cylinder(h=splitl, d=linkd-2.5,$fn=20);
    }
    translate([-3,4,0])cube([6,6,3.5]);
}
translate([15,0,0]){
    difference(){
        translate([-5,-5,0])
        cube([10,10,4]);
        
        translate([0,0,2])
        union(){
           
            linear_extrude(height=0.5)
            rotate(22.5)
            polygon(polypoints);
                
            
            
            difference(){
                scale([1.03,1.03,1])
                rotate_extrude($fn=20)
                polygon(endbody_points);
                translate([0,0,-5+lipl/2])cube([10,10,10],center=true);
            }
            difference(){
                cylinder(h=ebl,d=lipd+0.2,$fn=30);
                translate([-5,linkh/2,0])cube([10,10,10]);
                translate([-5,-10-linkh/2,0])cube([10,10,10]);
            }
        }
    }
}


