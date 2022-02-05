lipl = 1.0; //lip length
lipd = 6.0;
ebl = 5.0; //overall length of the endbody
linkd = 5.0; //link body diameter
linkh = 3.5; //link body height 
splitw = 1.0;
splitl = 3.5;


SRT = 8.0;
coa = SRT+2.5; //connector octagon apothem (inscribed radius)
cor = coa/(cos(22.5));    //connector octagon radius (circumscribed radius)
coph = cor/(sqrt(1+1/(sqrt(2)))); //connector octagonal prism height

POINTS = 40;

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

module endbody(){
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
}

for(i=70){
translate([40,0,0])
    difference(){
        union(){
            translate([0,0,linkh/2])
            rotate(90,[-1,0,0])
            endbody();
            
            translate([-2.5,ebl-0.1,0])
            cube([5,i-(2*SRT)-(2*ebl)+0.2,linkh]);
            
            translate([0,ebl*2 + i-(2*SRT)-(2*ebl),linkh/2])
            rotate(90,[1,0,0])
            endbody();
        }
        /*
        for(j=[0:(i/10)-3]){
            translate([0,-SRT+20 + j*10,0])
            cylinder(h=20,d=3.2,center=true,$fn=15);
        }
        */
    }
    
translate([50,0,0])
    difference(){
        union(){
            translate([0,0,linkh/2])
            rotate(90,[-1,0,0])
            endbody();
            
            translate([-2.5,ebl-0.1,0])
            cube([5,i*sqrt(2)-(2*SRT)-(2*ebl)+0.2,linkh]);
            
            translate([0,ebl*2 + i*sqrt(2)-(2*SRT)-(2*ebl),linkh/2])
            rotate(90,[1,0,0])
            endbody();
        }
        /*
        for(j=[0:(i/10)-3]){
            translate([0,-SRT+2*10*sqrt(2) + j*10*sqrt(2),0])
            cylinder(h=20,d=3.2,center=true,$fn=15);
        }
        */
    }
}

/*
translate([0,0,coa])
rotate(90,[0,1,0])
difference(){
hull()
    union(){
        rotate(22.5)
        cylinder(r=cor,h=coph,$fn=8, center=true);
        
        rotate(90,[1,0,0])
        rotate(22.5)
        cylinder(r=cor,h=coph,$fn=8, center=true);
        
        rotate(90,[0,1,0])
        rotate(22.5)
        cylinder(r=cor,h=coph,$fn=8, center=true);
    }

for(i=[0:7]){
    rotate(45*i)
    translate([0,-SRT,0])
    rotate(90,[1,0,0])
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

for(i=[0:3]){
    rotate(90*i)
    rotate(45,[1,0,0])
    translate([0,-SRT,0])
    rotate(90,[1,0,0])
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
for(i=[0:3]){
    rotate(90*i)
    rotate(45,[-1,0,0])
    translate([0,-SRT,0])
    rotate(90,[1,0,0])
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
for(i=[0:1]){
    rotate(180*i+90,[1,0,0])
    translate([0,-SRT,0])
    rotate(90,[1,0,0])
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
cylinder(h=30,d=3.2,center=true,$fn=20);
for(i=[0:3]){
    rotate(i*45,[0,0,1])
    rotate(90,[1,0,0])
    cylinder(h=30,d=3.2,center=true,$fn=20);
}
for(i=[0:3]){
    rotate(i*90,[0,0,1])
    rotate(45,[1,0,0])
    cylinder(h=30,d=3.2,center=true,$fn=20);
}
}
*/