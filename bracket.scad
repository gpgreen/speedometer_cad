include <speedo_config.scad>

module sideplate() {
    linear_extrude(25, center=false)
    polygon(points=[
    [-5,0],
    [15,0],
    [25,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    [bracket_faceplate_height,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    [bracket_faceplate_height,(bracket_display_width-bracket_inner_width)/2+2*bracket_thickness],
    [25-1,(bracket_display_width-bracket_inner_width)/2+2*bracket_thickness],
    [15-1,bracket_thickness],
    [-5,bracket_thickness]
    ]);
}
    
module sideplate_trim() {
    linear_extrude(bracket_display_width, center=false)
        polygon(points=[[-2,-2],[8,-2],[-2,8]]);
}

module sideplates() {
    difference() {
        union() {
            translate([0, bracket_inner_width/2-bracket_thickness, 0])
                sideplate();
            translate([0,-bracket_inner_width/2+bracket_thickness, 25])
                rotate(a=[180,0,0])
                    sideplate();
        }
        translate([-5,bracket_display_width/2,25])
            rotate(a=[90,90,0])
                sideplate_trim();
    }
}

module display_post() {
    union() {
        cylinder(2, 2, 2, center=false);
        translate([0, 0, 2])
            cylinder(1, 1.5, 1.5, center=false);
    }
}

module display_posts() {
    union() {
        translate([-44.5 / 2.0, -37.5 / 2.0, 0]) display_post();
        translate([-44.5 / 2.0, 37.5 / 2.0, 0]) display_post();
        translate([44.5 / 2.0, -37.5 / 2.0, 0]) display_post();
        translate([44.5 / 2.0, 37.5 / 2.0, 0]) display_post();
    }
}

module display_hole() {
    cylinder(4, faceplate_attach_hole_r, faceplate_attach_hole_r, center=false);
}

module display_holes() {
    union() {
        translate([-faceplate_attach_hole_span/2, 0, -1])
            display_hole();
        translate([faceplate_attach_hole_span/2, 0, -1])
            display_hole();
    }
}

module faceplate_cutout() {
    minkowski() {
        linear_extrude(6, center=true)
            square([25, 25], center=true);
        cylinder(r=2,h=6);
    }
}

module displayplate() {
    difference() {
        union() {
            linear_extrude(bracket_thickness, center=false)
                square([48, bracket_display_width], center=true);
            translate([1.5, 0, 2])
                rotate([0, 0, 90])
                    display_posts();
        }
        translate([-20,0,0])
            faceplate_cutout();
    }
}

module display_ear() {
    linear_extrude(bracket_thickness, center=false)
        polygon(points=[[-10,0],[10,0],[5,5],[-5,5]]);
}

module display_ears() {
    difference() {
        union() {
            translate([0, 
            bracket_display_width/2+bracket_thickness, 0]) 
                display_ear();
            translate([0, 
            -bracket_display_width/2-bracket_thickness, bracket_thickness])
                rotate([180,0,0])
                    display_ear();
        }
        rotate([0, 0, 90])
            display_holes();
    }
}

module pcb_ear() {
    linear_extrude(bracket_thickness, center=false)
        polygon(points=[[-5,0],[10,0],[10,5],[0,5]]);
}

module pcb_ears() {
    translate([0, bracket_display_width/2+bracket_thickness, 0]) 
           pcb_ear();
    translate([0, 
            -bracket_display_width/2-bracket_thickness, bracket_thickness])
        rotate([180,0,0])
            pcb_ear();
}

module bracket() {
    union() {
        translate([25/2,0,0])
            rotate(a=[0,-90,0])
                sideplates();
        translate([11.5, 0, 42-5-bracket_thickness-2])
            displayplate();
        translate([-25/2+bracket_thickness, 0, bracket_faceplate_height-10]) 
            rotate(a=[0,-90,0])
                pcb_ears();
        translate([0, 0, bracket_faceplate_height-bracket_thickness])
            display_ears();
    }
}

bracket();