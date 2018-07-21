include <speedo_config.scad>

module sideplate() {
    linear_extrude(25, center=false)
        polygon(points=[
		[-16,0],
    		[15,0],
    		[25,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    		[bracket_faceplate_height,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    		[bracket_faceplate_height,(bracket_display_width-bracket_inner_width)/2+2*bracket_thickness],
    		[25-1,(bracket_display_width-bracket_inner_width)/2+2*bracket_thickness],
    		[15-1,bracket_thickness],
    		[-16,bracket_thickness]]);
}
    
module sideplate_trim() {
    linear_extrude(bracket_display_width, center=false)
        polygon(points=[[-16,0],[-8,15],[-16,15]]);
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
        translate([0,bracket_display_width/2,10])
            rotate(a=[90,0,0])
                sideplate_trim();
    }
}

module reinforcement() {
    linear_extrude(bracket_thickness, center=false)
        polygon(points=[
            [-5,0],
    		[15,0],
    		[25,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    		[bracket_display_plate_height-bracket_thickness,(bracket_display_width-bracket_inner_width)/2+bracket_thickness],
    		[bracket_display_plate_height-bracket_thickness,-3],
    		[25-1,-3],
    		[15-1,-3],
            [0,-3],
    		[-5,0]]);
}

module endplate() {
    linear_extrude(bracket_thickness, center=false)
        square([10,bracket_inner_width],center=false);
}

module reinforcements() {
    union() {
        translate([0, bracket_inner_width/2-bracket_thickness, 0])
            reinforcement();
        translate([0,-bracket_inner_width/2+bracket_thickness, bracket_thickness])
            rotate(a=[180,0,0])
                reinforcement();
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

module plate_radius() {
    difference() {
        translate([8,8,0])
            linear_extrude(6, center=false)
                square(16, center=true);
        cylinder(r=8,h=6);
    }
}

module plate() {
    difference() {
        linear_extrude(bracket_thickness, center=false)
            square([48, bracket_display_width], center=true);
        translate([48/2-8, bracket_display_width/2-8, -2])
            plate_radius();
        translate([48/2-8, -bracket_display_width/2+8, -2])
            rotate(a=[0,0,-90])
                plate_radius();
    }
}

module displayplate() {
    difference() {
        union() {
            plate();
            translate([1.5, 0, 2])
                rotate(a=[0, 0, 90])
                    display_posts();
        }
        translate([-20,0,0])
            faceplate_cutout();
    }
}

module display_ear() {
    linear_extrude(bracket_thickness, center=false)
        polygon(points=[[-12.5,0],[12,0],[12,5],[-12.5,5]]);
}

module display_ears() {
    difference() {
        union() {
            translate([0, bracket_display_width/2+bracket_thickness, 0]) 
                display_ear();
            translate([0, -bracket_display_width/2-bracket_thickness, bracket_thickness])
                rotate(a=[180,0,0])
                    display_ear();
        }
        rotate(a=[0, 0, 90])
            display_holes();
    }
}

module pcb_ear() {
    linear_extrude(bracket_thickness, center=false)
        polygon(points=[[-5,0],[12.5,0],[12.5,5],[-3,5]]);
}

module pcb_ears() {
    translate([0, bracket_display_width/2+bracket_thickness, 0]) 
           pcb_ear();
    translate([0, -bracket_display_width/2-bracket_thickness, bracket_thickness])
        rotate(a=[180,0,0])
            pcb_ear();
    translate([0, bracket_display_width/2+bracket_thickness, 25-bracket_thickness]) 
           pcb_ear();
    translate([0, -bracket_display_width/2-bracket_thickness, 25])
        rotate(a=[180,0,0])
            pcb_ear();
}

module bracket() {
    union() {
        translate([25/2,0,0])
            rotate(a=[0,-90,0])
                sideplates();
        translate([11.5, 0, 42-5-bracket_thickness-2])
            displayplate();
        translate([25/2, 0, bracket_faceplate_height-12.5]) 
            rotate(a=[0,-90,0])
                pcb_ears();
        translate([0, 0, bracket_faceplate_height-bracket_thickness])
            display_ears();
        translate([12.5,0,0])
            rotate(a=[0,-90,0])
                reinforcements();
        translate([2.5,-bracket_inner_width/2,-16])
            rotate(a=[0,0,0])
                endplate();
    }
}

bracket();