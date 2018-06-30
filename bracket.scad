module sideplate1() {
    linear_extrude(2, center=false)
        square([25, 10], center=true);
}

module sideplate2() {
    linear_extrude(2, center=false)
        square([25, 5], center=true);
}
    
module sideplate3() {
    linear_extrude(2, center=false)
        square([25, 30], center=true);
}
    
module frontplate() {
    linear_extrude(2, center=false)
        square([42, 52], center=true);
}

module bracket() {
    union() {
        translate([7.5, 0, 42-5-2])
            frontplate();
        translate([0, 23, 5]) 
            rotate(a=[90,0,0])
                sideplate1();
        translate([0, -23, 5]) 
            rotate(a=[90,0,0])
                sideplate1();
        translate([0, 23.5, 10]) 
            sideplate2();
        translate([0, -25.5, 10]) 
            sideplate2();
        translate([0, 26, 27]) 
            rotate(a=[90,0,0])
                sideplate3();
        translate([0, -26, 27]) 
            rotate(a=[90,0,0])
                sideplate3();
    }
}

module nokia_hole() {
    cylinder(6, 1.5, 1.5, center=false);
} 

module nokia_holes() {
    union() {
        translate([-44.5 / 2.0, -37.5 / 2.0, -2]) nokia_hole();
        translate([-44.5 / 2.0, 37.5 / 2.0, -2]) nokia_hole();
        translate([44.5 / 2.0, -37.5 / 2.0, -2]) nokia_hole();
        translate([44.5 / 2.0, 37.5 / 2.0, -2]) nokia_hole();
    }
}

module nokia_pcb() {
    color("Lime")
        linear_extrude(1, center=false)
            square([50, 42], center=true);
}
    
module nokia_board() {
    difference() {
        nokia_pcb();
        nokia_holes();
    }
}

module nokia_lcd_case() {
    color("LightCyan")
        linear_extrude(4, center=false)
            square([40, 34], center=true);
}

module nokia_lcd_inset() {
    linear_extrude(2, center=false)
        square([36, 25.5], center=true);
}

module nokia_display() {
    nokia_board();
    difference() {
        translate([0, 0, 1]) nokia_lcd_case();
        translate([0, -3, 4.5]) nokia_lcd_inset();
    }
}

module faceplate_cutout() {
    minkowski() {
        linear_extrude(4, center=false)
            square([34, 23], center=true);
        cylinder(r=2, h=4);
    }
}

module faceplate_highbeam() {
    translate([0, -32, -1])
        cylinder(4, 3, 3, center=false);
}

module faceplate() {
    color("Black")
        difference() {
            difference() {
                linear_extrude(2, center=false)
                    circle(d=80);
                translate([0, 10, -1])
                    faceplate_cutout();
            }
            faceplate_highbeam();
        }
}

module assembly() {
    translate([0, 10, 0])
        nokia_display();
    translate([0, 0, 5])
        faceplate();
}

mod = "bracket";

if (mod == "display") nokia_display();
else if (mod == "faceplate") faceplate();
else if (mod == "bracket") bracket();
else if (mod == "assy")
    assembly();
