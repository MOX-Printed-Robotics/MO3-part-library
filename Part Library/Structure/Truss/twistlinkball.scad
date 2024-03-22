cube_width = 20;
connection_depth = 3;

side_length = cube_width * tan(22.5);
layer_cutoff = side_length / sqrt(2);

strut_legs_width = 4;
strut_toes_width=5.5;
strut_thickness=3;
leg_separation=0.5;
leg_separation_depth=3;

cylinder_faces = 10;

center_to_center = 100;
leg_strut_length = center_to_center - cube_width + (2 * connection_depth);
hyp_strut_length = (sqrt(2) * center_to_center) - cube_width + (2*connection_depth);

strut_body_width = 5;

module strut(overall_length){
    difference(){
    intersection(){
        cube([strut_body_width+2,strut_thickness,overall_length*2],center=true);
        union(){
        //main cylinder
        translate([0,0,connection_depth + 1])
        cylinder(d=strut_body_width, h=overall_length - 2 - 2*connection_depth, $fn=cylinder_faces);
        //legs cylinder
        cylinder(d=strut_legs_width,h=overall_length, $fn =cylinder_faces );
        //bottom toe cone
        translate([0,0,1])
        cylinder(d1=strut_toes_width,d2=strut_legs_width,h=1, $fn=cylinder_faces);
        //top toe cone
        translate([0,0,overall_length-2])
        cylinder(d1=strut_legs_width,d2=strut_toes_width,h=1,$fn=cylinder_faces);
        
            //bottom toe cylinder
        cylinder(h=1,d=strut_toes_width,$fn=cylinder_faces);
        //top toe cylinder
        translate([0,0,overall_length-1])
        cylinder(h=1,d=strut_toes_width,$fn=cylinder_faces);
        }
        
    }
    
    
    //leg separation cuts
    cube([leg_separation,strut_thickness*2,leg_separation_depth*2],center=true);
    translate([0,0,overall_length])
    cube([leg_separation,strut_thickness*2,leg_separation_depth*2],center=true);
    
    
}
}


module conshaft(){
    translate([0,0,cube_width/2 -connection_depth]){
        cylinder(d=strut_legs_width,h=10,$fn=cylinder_faces);
        cylinder(d=strut_toes_width,h=1,$fn=cylinder_faces);
        translate([0,0,1])
            cylinder(d1 = strut_toes_width,d2 = strut_legs_width,h=1, $fn=cylinder_faces);
        
        //cutting profile of the strut keyway. 
        //allows the strut to enter and exit the connection once aligned.
        intersection(){
            cube([strut_thickness,strut_toes_width,20], center=true);
            cylinder(d=strut_toes_width,h=10,$fn=cylinder_faces);
        }
    }
}

module thruholes (){
    for (i = [0,45,90,135]){
    rotate(i,[1,0,0])
    cylinder(d=3.2,h=cube_width*2,center=true, $fn=cylinder_faces);
    }
    
    for (i = [45,90,135]){
        rotate(i,[0,1,0])
        cylinder(d=3.2,h=cube_width*2,center=true, $fn=cylinder_faces);
    }
    for (i=[45,135]){
        rotate(i,[0,0,1])
        rotate(90,[1,0,0])
        cylinder(d=3.2,h=cube_width*2,center=true, $fn=cylinder_faces);
    }
    
}


module connector_cube(){
    difference(){
    //starting cube
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting the faces
    for(i = [45:90:315]){
        rotate(i,[0,-1,0])
        translate([cube_width,0,0])
        cube([cube_width,cube_width + 2,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[1,0,0])
        translate([0,cube_width,0])
        cube([cube_width+2,cube_width ,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[0,0,1])
        translate([0,cube_width,0])
        cube([cube_width,cube_width ,cube_width+2],center=true);
    }

    //cutting connection shafts
    for( i = [0:45:315]){
        rotate(i,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }

    for(i = [45,90,135,225,270,315]){
        rotate(i,[1,0,0])
        conshaft();
    }
    for (i = [45,135,225,315]){
        rotate(i,[0,0,1])
        rotate(90,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }
    
    //cutting thruholes
    thruholes();
}
}

module face_connector(){
    difference(){
    //starting cube
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting the faces
    for(i = [45:90:315]){
        rotate(i,[0,-1,0])
        translate([cube_width,0,0])
        cube([cube_width,cube_width + 2,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[1,0,0])
        translate([0,cube_width,0])
        cube([cube_width+2,cube_width ,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[0,0,1])
        translate([0,cube_width,0])
        cube([cube_width,cube_width ,cube_width+2],center=true);
    }
    
    translate([0,0,-(cube_width) + layer_cutoff])
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting connection shafts
    for( i = [0,45,90,-45,-90]){
        rotate(i,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }

    for(i = [45,90,270,315]){
        rotate(i,[1,0,0])
        conshaft();
    }
    for (i = [45,135,225,315]){
        rotate(i,[0,0,1])
        rotate(90,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }
    
    //cutting thruhole
    cylinder(d=3.2,h=cube_width*3,center=true,$fn=cylinder_faces);
   
    
}
}

module plate_connector_A(){
    translate([0,0,side_length/2])
    difference(){
    //starting cube
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting the faces
    for(i = [45:90:315]){
        rotate(i,[0,-1,0])
        translate([cube_width,0,0])
        cube([cube_width,cube_width + 2,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[1,0,0])
        translate([0,cube_width,0])
        cube([cube_width+2,cube_width ,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[0,0,1])
        translate([0,cube_width,0])
        cube([cube_width,cube_width ,cube_width+2],center=true);
    }
    
    translate([0,0,-(cube_width) + layer_cutoff])
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting connection shafts
    for( i = [0,45,-45,-90]){
        rotate(i,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }

    for(i = [45,90,315]){
        rotate(i,[1,0,0])
        conshaft();
    }
    for (i = [135,225,315]){
        rotate(i,[0,0,1])
        rotate(90,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }
    
    //cutting thruhole
    cylinder(d=3.2,h=cube_width*3,center=true,$fn=cylinder_faces);
   
    
}
}

module plate_connector_B(){
    translate([0,0,side_length/2])
    difference(){
    //starting cube
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting the faces
    for(i = [45:90:315]){
        rotate(i,[0,-1,0])
        translate([cube_width,0,0])
        cube([cube_width,cube_width + 2,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[1,0,0])
        translate([0,cube_width,0])
        cube([cube_width+2,cube_width ,cube_width],center=true);
    }

    for(i = [45:90:315]){
        rotate(i,[0,0,1])
        translate([0,cube_width,0])
        cube([cube_width,cube_width ,cube_width+2],center=true);
    }
    
    translate([0,0,-(cube_width) + layer_cutoff])
    cube([cube_width,cube_width,cube_width], center=true);
    
    //cutting connection shafts
    for( i = [0,45,90,-45]){
        rotate(i,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }

    for(i = [45,90,315]){
        rotate(i,[1,0,0])
        conshaft();
    }
    for (i = [45,225,315]){
        rotate(i,[0,0,1])
        rotate(90,[0,1,0])
        rotate(90,[0,0,1])
        conshaft();
    }
    
    //cutting thruhole
    cylinder(d=3.2,h=cube_width*3,center=true,$fn=cylinder_faces);
   
    
}
}

module cutting_cube(){
                rotate(45,[0,0,1])
                translate([-layer_cutoff,0,0])
                cube([cube_width,cube_width,cube_width],center=true);
}
    
module face_plate(xdim,ydim,plate_thickness){
    union(){
        difference(){
            translate([-side_length/2,-side_length/2,0])
            cube([xdim + side_length,ydim + side_length,plate_thickness]);
            
            cutting_cube();
            
            translate([xdim,0,0])
            rotate(90)
            cutting_cube();
            
            translate([0,ydim,0])
            rotate(-90)
            cutting_cube();
            
            translate([xdim,ydim,0])
            rotate(180)
            cutting_cube();
            
            
        }
        plate_connector_A();
        
        translate([xdim,0,0])
        plate_connector_B();
        
        translate([0,ydim,0])
        rotate(180)
        plate_connector_B();
        
        translate([xdim,ydim,0])
        rotate(180)
        plate_connector_A();
    }
}


face_plate(100,100,2.5);





