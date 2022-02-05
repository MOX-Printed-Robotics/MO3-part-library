NUT_ID = 5.4;
FUDGE_ADDENDUM = 0.4;

nut_cd = NUT_ID / cos(30);
socket_d = nut_cd + FUDGE_ADDENDUM;

difference(){
    union(){
        cylinder(d=9, h=10, $fn=50);
        translate([0,-4.5,0])cube([40,9,5]);
    }
    cylinder(d=socket_d, h=10, $fn=6);
}

