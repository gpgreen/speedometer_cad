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
  
module mount_ear() {
    linear_extrude(2, center=false)
        polygon(points=[[-10,0],[10,0],[5,5],[-5,5]]);
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

module faceplate_cutout() {
    linear_extrude(6, center=true)
        square([25, 25], center=true);
}

module displayplate() {
    difference() {
        union() {
            linear_extrude(2, center=false)
                square([48, 52], center=true);
            translate([1.5, 0, 2])
                rotate([0, 0, 90])
                    display_posts();
        }
        translate([-20,0,-3])
            faceplate_cutout();
    }
}

module bracket() {
    union() {
        translate([11.5, 0, 42-5-2-2])
            displayplate();
        translate([0, 23, 5]) 
            rotate(a=[90,0,0])
                sideplate1();
        translate([0, -21, 5]) 
            rotate(a=[90,0,0])
                sideplate1();
        translate([0, 23.5, 10]) 
            sideplate2();
        translate([0, -23.5, 10]) 
            sideplate2();
        translate([0, 26, 27]) 
            rotate(a=[90,0,0])
                sideplate3();
        translate([0, -24, 27]) 
            rotate(a=[90,0,0])
                sideplate3();
        translate([0, 26, 40]) 
            mount_ear();
        translate([0, -26, 42])
            rotate([180,0,0])
                mount_ear();
        translate([-12.5, 26, 30]) 
            rotate([0,90,0])
                mount_ear();
        translate([-10.5, -26, 30])
            rotate([180,90,0])
                mount_ear();
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
    bracket();
    translate([13, 0, 42-5])
        rotate([0,0,-90])
            nokia_display();
    translate([0, 0, 42])
        rotate([0,0,-90])
            faceplate();
}

mod = "bracket";

if (mod == "display") nokia_display();
else if (mod == "faceplate") 
    faceplate();
else if (mod == "bracket") 
    translate([0, 0, 12.5])
        rotate([0,-90, 0]) 
        bracket();
else if (mod == "assy")
    assembly();
