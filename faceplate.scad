include <speedo_config.scad>

module faceplate_cutout() {
    minkowski() {
        linear_extrude(4, center=false)
            square([faceplate_display_width-2,    faceplate_display_height-2], center=true);
        cylinder(r=2, h=4);
    }
}

module faceplate_highbeam() {
    translate([0, -32, -1])
        cylinder(4, 3, 3, center=false);
}

module faceplate_hole() {
    cylinder(4, faceplate_attach_hole_r, faceplate_attach_hole_r, center=false);
}

module faceplate_holes() {
    union() {
        translate([-faceplate_attach_hole_span/2, 0, -1])
            faceplate_hole();
        translate([faceplate_attach_hole_span/2, 0, -1])
            faceplate_hole();
    }
}

module faceplate() {
    color("Black")
        difference() {
            linear_extrude(2, center=false)
                circle(d=80);
            union() {
                translate([0, 10, -1])
                    faceplate_cutout();
                faceplate_highbeam();
                faceplate_holes();
            }
        }
}

faceplate();