SIZE = 2;
cylheight=10;
pd = SIZE * 10;
chamdepth=2;

chamrad = 1.5+ (pd / 2);
cutcyl_diameter = pd-8;
hub_diameter = 10;
cutcyl_height = cylheight *3;
spokes = 4;
spoke_width = 10;

inc=360/spokes;
cd = cutcyl_diameter;
ch = cutcyl_height;
sw = spoke_width;

CAP_D = 5.6;

FUDGE_FACTOR = 0.1;
NUT_MIN_WIDTH = 5.5;
NUT_MAX_WIDTH = 6.2;
NUT_THICKNESS = 2.25;

BORE_DIAMETER = 3;










$fn = 50;
// General Variables
pi = 3.14159;
rad = 57.29578;
clearance = 0.05;   // clearance between teeth

/*  Converts Radians to Degrees */
function grad(pressure_angle) = pressure_angle*rad;

/*  Converts Degrees to Radians */
function radian(pressure_angle) = pressure_angle/rad;

/*  Converts 2D Polar Coordinates to Cartesian
    Format: radius, phi; phi = Angle to x-Axis on xy-Plane */
function polar_to_cartesian(polvect) = [
    polvect[0]*cos(polvect[1]),  
    polvect[0]*sin(polvect[1])
];

/*  Circle Involutes-Function:
    Returns the Polar Coordinates of an Involute Circle
    r = Radius of the Base Circle
    rho = Rolling-angle in Degrees */
function ev(r,rho) = [
    r/cos(rho),
    grad(tan(rho)-radian(rho))
];

/*  Sphere-Involutes-Function
    Returns the Azimuth Angle of an Involute Sphere
    theta0 = Polar Angle of the Cone, where the Cutting Edge of the Large Sphere unrolls the Involute
    theta = Polar Angle for which the Azimuth Angle of the Involute is to be calculated */
function sphere_ev(theta0,theta) = 1/sin(theta0)*acos(cos(theta)/cos(theta0))-acos(tan(theta0)/tan(theta));

/*  Converts Spherical Coordinates to Cartesian
    Format: radius, theta, phi; theta = Angle to z-Axis, phi = Angle to x-Axis on xy-Plane */
function sphere_to_cartesian(vect) = [
    vect[0]*sin(vect[1])*cos(vect[2]),  
    vect[0]*sin(vect[1])*sin(vect[2]),
    vect[0]*cos(vect[1])
];

/*  Check if a Number is even
    = 1, if so
    = 0, if the Number is not even */
function is_even(number) =
    (number == floor(number/2)*2) ? 1 : 0;

/*  greatest common Divisor
    according to Euclidean Algorithm.
    Sorting: a must be greater than b */
function ggt(a,b) = 
    a%b == 0 ? b : ggt(b,a%b);

/*  Polar function with polar angle and two variables */
function spiral(a, r0, phi) =
    a*phi + r0; 

/*  Copy and rotate a Body */
module copier(vect, number, distance, winkel){
    for(i = [0:number-1]){
        translate(v=vect*distance*i)
            rotate(a=i*winkel, v = [0,0,1])
                children(0);
    }
}
/*  Spur gear
    modul = Height of the Tooth Tip beyond the Pitch Circle
    tooth_number = Number of Gear Teeth
    width = tooth_width
    bore = Diameter of the Center Hole
    pressure_angle = Pressure Angle, Standard = 20° according to DIN 867. Should not exceed 45°.
    helix_angle = Helix Angle to the Axis of Rotation; 0° = Spur Teeth
    optimized = Create holes for Material-/Weight-Saving or Surface Enhancements where Geometry allows */
module spur_gear(modul, tooth_number, width, bore, pressure_angle = 20, helix_angle = 0, optimized = true) {

    // Dimension Calculations  
    d = modul * tooth_number;                                           // Pitch Circle Diameter
    r = d / 2;                                                      // Pitch Circle Radius
    alpha_spur = atan(tan(pressure_angle)/cos(helix_angle));// Helix Angle in Transverse Section
    db = d * cos(alpha_spur);                                      // Base Circle Diameter
    rb = db / 2;                                                    // Base Circle Radius
    da = (modul <1)? d + modul * 2.2 : d + modul * 2;               // Tip Diameter according to DIN 58400 or DIN 867
    ra = da / 2;                                                    // Tip Circle Radius
    c =  (tooth_number <3)? 0 : modul/6;                                // Tip Clearance
    df = d - 2 * (modul + c);                                       // Root Circle Diameter
    rf = df / 2;                                                    // Root Radius
    rho_ra = acos(rb/ra);                                           // Maximum Rolling Angle;
                                                                    // Involute begins on the Base Circle and ends at the Tip Circle
    rho_r = acos(rb/r);                                             // Rolling Angle at Pitch Circle;
                                                                    // Involute begins on the Base Circle and ends at the Tip Circle
    phi_r = grad(tan(rho_r)-radian(rho_r));                         // Angle to Point of Involute on Pitch Circle
    gamma = rad*width/(r*tan(90-helix_angle));               // Torsion Angle for Extrusion
    step = rho_ra/16;                                            // Involute is divided into 16 pieces
    tau = 360/tooth_number;                                             // Pitch Angle
    
    r_hole = (2*rf - bore)/8;                                    // Radius of Holes for Material-/Weight-Saving
    rm = bore/2+2*r_hole;                                        // Distance of the Axes of the Holes from the Main Axis
    z_hole = floor(2*pi*rm/(3*r_hole));                             // Number of Holes for Material-/Weight-Saving
    
    optimized = (optimized && r >= width*1.5 && d > 2*bore);    // is Optimization useful?

    // Drawing
    union(){
        rotate([0,0,-phi_r-90*(1-clearance)/tooth_number]){                     // Center Tooth on X-Axis;
                                                                        // Makes Alignment with other Gears easier

            linear_extrude(height = width, twist = gamma){
                difference(){
                    union(){
                        tooth_width = (180*(1-clearance))/tooth_number+2*phi_r;
                        circle(rf);                                     // Root Circle 
                        for (rot = [0:tau:360]){
                            rotate (rot){                               // Copy and Rotate "Number of Teeth"
                                polygon(concat(                         // Tooth
                                    [[0,0]],                            // Tooth Segment starts and ends at Origin
                                    [for (rho = [0:step:rho_ra])     // From zero Degrees (Base Circle)
                                                                        // To Maximum Involute Angle (Tip Circle)
                                        polar_to_cartesian(ev(rb,rho))],       // First Involute Flank

                                    [polar_to_cartesian(ev(rb,rho_ra))],       // Point of Involute on Tip Circle

                                    [for (rho = [rho_ra:-step:0])    // of Maximum Involute Angle (Tip Circle)
                                                                        // to zero Degrees (Base Circle)
                                        polar_to_cartesian([ev(rb,rho)[0], tooth_width-ev(rb,rho)[1]])]
                                                                        // Second Involute Flank
                                                                        // (180*(1-clearance)) instead of 180 Degrees,
                                                                        // to allow clearance of the Flanks
                                    )
                                );
                            }
                        }
                    }           
                    circle(r = rm+r_hole*1.49);                         // "bore"
                }
            }
        }
        // with Material Savings
        if (optimized) {
            linear_extrude(height = width){
                difference(){
                        circle(r = (bore+r_hole)/2);
                        circle(r = bore/2);                          // bore
                    }
                }
            linear_extrude(height = (width-r_hole/2 < width*2/3) ? width*2/3 : width-r_hole/2){
                difference(){
                    circle(r=rm+r_hole*1.51);
                    union(){
                        circle(r=(bore+r_hole)/2);
                        for (i = [0:1:z_hole]){
                            translate(sphere_to_cartesian([rm,90,i*360/z_hole]))
                                circle(r = r_hole);
                        }
                    }
                }
            }
        }
        // without Material Savings
        else {
            linear_extrude(height = width){
                difference(){
                    circle(r = rm+r_hole*1.51);
                    circle(r = bore/2);
                }
            }
        }
    }
}





//The meat of the codes:
missing_teeth = 7;
cutout_angle = missing_teeth * 360 / (SIZE*10);
triangle_points = [[0,0],[150,0],[150*cos(cutout_angle),150*sin(cutout_angle)]];
difference(){
    spur_gear (modul=1, tooth_number=SIZE*10, width=cylheight, bore=BORE_DIAMETER, pressure_angle=25, helix_angle=0, optimized=false);
    if(SIZE > 8){
        difference(){
        cylinder(d=cd,h=ch,$fn=50,center=true);
        cylinder(d=hub_diameter, h=ch, $fn=50, center=true);
        for(i = [0:spokes-1]){
            rotate(i*inc,[0,0,1]){
                translate([cd/2,0,0]){
                    cube([cd,sw,ch+1],center=true);
                }
            }
        }
    }
    }
    
    translate([0,0,cylheight-chamdepth]){
        difference(){
            cylinder(r=chamrad,h=cylheight);
            cylinder(r1=chamrad,r2=0,h=chamrad);
        }
    }
    translate([0,0,0-cylheight+chamdepth]){
        difference(){
            cylinder(r=chamrad,h=cylheight);
            translate([0,0,0-chamrad+cylheight])
            cylinder(r1=0, r2=chamrad, h=chamrad);
        }
    }
    rotate(360/(SIZE*10)/2 +45){
        translate([0,0,cylheight/2]){
            rotate(90,[0,1,0]){
                cylinder(h=100,d=BORE_DIAMETER);
            }
        }
        translate([2.2,-(NUT_MIN_WIDTH+FUDGE_FACTOR)/2, cylheight-(cylheight/2+NUT_MAX_WIDTH/2)]){
            cube([NUT_THICKNESS+FUDGE_FACTOR,NUT_MIN_WIDTH+FUDGE_FACTOR,cylheight/2+NUT_MAX_WIDTH/2]);
        }
    }
    rotate(360/(SIZE*10)/2){
        difference(){
            linear_extrude(h=100,center=true){
                polygon(points=triangle_points);
            }
            cylinder(h=200,d=SIZE*10 -3.5, center=true);
        }
    }
    
}


