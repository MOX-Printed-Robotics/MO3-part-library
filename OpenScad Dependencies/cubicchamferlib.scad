module chamfer(depth, x, y, z){

CHAMFER = depth;
width = x;
tall = z;
length = y;

A= CHAMFER*-1;
B= CHAMFER*2;

outerpoints = [
[-1*CHAMFER,-1*CHAMFER,-1*CHAMFER],
[CHAMFER,0,CHAMFER],
[0,CHAMFER,CHAMFER],
[CHAMFER,CHAMFER,0]];

outerfaces = [
[0,1,2],
[0,2,3],
[0,3,1],
[1,3,2]];
    //CUBIC CHAMFER GEOMETRY
    
    //these first four are the four edges on the XZ plane.
    linear_extrude(height = tall){
        polygon(points=[[A,A],[A,B],[B,A]]);
    }
    translate([width,0,0]){
        rotate(90,[0,-1,0]){
            linear_extrude(height = width){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([0,0,tall]){
        rotate(270,[0,-1,0]){
            linear_extrude(height = width){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([width,0,tall]){
        rotate(180,[0,-1,0]){
            linear_extrude(height = tall){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    //this block mirror-copies the XZ plane edges to the opposite face of the cube.
    translate([width,length,0]){
        rotate(180,[0,0,1]){
                    linear_extrude(height = tall){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
            translate([width,0,0]){
                rotate(90,[0,-1,0]){
                    linear_extrude(height = width){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([0,0,tall]){
                rotate(270,[0,-1,0]){
                    linear_extrude(height = width){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([width,0,tall]){
                rotate(180,[0,-1,0]){
                    linear_extrude(height = tall){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    
    //These two are the remaining edges on the YZ plane.
    translate([0,length,0]){
        rotate(90,[1,0,0]){
            linear_extrude(height = length){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([0,0,tall]){
        rotate(90,[-1,0,0]){
            linear_extrude(height = length){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    //This block mirror-copies the previous YZ plane edges to the opposite side, completing the cube.
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([0,length,0]){
                rotate(90,[1,0,0]){
                    linear_extrude(height = length){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([0,0,tall]){
                rotate(90,[-1,0,0]){
                    linear_extrude(height = length){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    // outer chamfer corners
    polyhedron(outerpoints, outerfaces);
    translate([width,0,0]){
        rotate(90,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([0,length,0]){
        rotate(270,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,0,tall]){
        rotate(180,[0,1,0]){
            polyhedron(outerpoints, outerfaces);
            translate([width,0,0]){
                rotate(90,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([width,length,0]){
                rotate(180,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([0,length,0]){
                rotate(270,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
        }
    }
}

module innerChamfer(depth, x, y, z){
    
    CHAMFER = depth;
    width = x;
    tall = z;
    length = y;

    A= CHAMFER*-1;
    B= CHAMFER*2;

    outerpoints = [
    [-1*CHAMFER,-1*CHAMFER,-1*CHAMFER],
    [CHAMFER,0,CHAMFER],
    [0,CHAMFER,CHAMFER],
    [CHAMFER,CHAMFER,0]];

    outerfaces = [
    [0,1,2],
    [0,2,3],
    [0,3,1],
    [1,3,2]];
    //CUBIC INNER CHAMFER GEOMETRY
    
    translate([width-10,length-10,0]){
        rotate(90,[0,-1,0]){
            linear_extrude(height = width-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([10,length-10,tall]){
        rotate(270,[0,-1,0]){
            linear_extrude(height = width-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([width-10,length-10,0]){
                rotate(90,[0,-1,0]){
                    linear_extrude(height = width-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([10,length-10,tall]){
                rotate(270,[0,-1,0]){
                    linear_extrude(height = width-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    
    translate([width-10,length-10,0]){
        rotate(90,[1,0,0]){
            linear_extrude(height = length-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    translate([width-10,10,tall]){
        rotate(90,[-1,0,0]){
            linear_extrude(height = length-20){
                polygon(points=[[A,A],[A,B],[B,A]]);
            }
        }
    }
    
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            translate([width-10,length-10,0]){
                rotate(90,[1,0,0]){
                    linear_extrude(height = length-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
            translate([width-10,10,tall]){
                rotate(90,[-1,0,0]){
                    linear_extrude(height = length-20){
                        polygon(points=[[A,A],[A,B],[B,A]]);
                    }
                }
            }
        }
    }
    //inner chamfer corners
    translate([width-10,length-10,0]){
        polyhedron(hedrapoints, hedrafaces);
    }
    translate([width-10,10,0]){
        rotate(90,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([10,10,0]){
        rotate(180,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([10,length-10,0]){
        rotate(270,[0,0,-1]){
            polyhedron(hedrapoints, hedrafaces);
        }
    }
    translate([0,length,10]){
        rotate(180,[-1,0,0]){
            translate([width-10,length-10,0]){
                polyhedron(hedrapoints, hedrafaces);
            }
            translate([width-10,10,0]){
                rotate(90,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
            translate([10,10,0]){
                rotate(180,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
            translate([10,length-10,0]){
                rotate(270,[0,0,-1]){
                    polyhedron(hedrapoints, hedrafaces);
                }
            }
        }
    }
    // outer chamfer corners
    polyhedron(outerpoints, outerfaces);
    translate([width,0,0]){
        rotate(90,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,length,0]){
        rotate(180,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([0,length,0]){
        rotate(270,[0,0,1]){
            polyhedron(outerpoints, outerfaces);
        }
    }
    translate([width,0,10]){
        rotate(180,[0,1,0]){
            polyhedron(outerpoints, outerfaces);
            translate([width,0,0]){
                rotate(90,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([width,length,0]){
                rotate(180,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
            translate([0,length,0]){
                rotate(270,[0,0,1]){
                    polyhedron(outerpoints, outerfaces);
                }
            }
        }
    } 
}
