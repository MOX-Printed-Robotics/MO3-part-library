
difference(){
    cylinder(h=1,r=5,$fn=160);
    cylinder(h=1.1,r=4.5,$fn=160);
}
difference(){
    cylinder(h=1,r=.6,$fn=16);
    cylinder(h=1.1,r=.4,$fn=16);
        rotate(90,[1,0,0]){
            translate([0,.7,0.2]){
                cylinder(h=.6,r=.1,$fn=60);
        }
    }
}
intersection_for(i=[[0,0,0],
    
])
