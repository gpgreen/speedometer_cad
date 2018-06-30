include <speedo_config.scad>
use <bracket.scad>
use <faceplate.scad>
use <display.scad>

module assembly() {
    bracket();
    translate([13, 0, bracket_faceplate_height-5])
        rotate([0,0,-90])
            nokia_display();
    translate([0, 0, bracket_faceplate_height])
        rotate([0,0,-90])
            faceplate();
}

mod = "bracket";

if (mod == "display")
    nokia_display();
else if (mod == "faceplate") 
    faceplate();
else if (mod == "bracket") 
    translate([0, 0, 12.5])
        rotate([0,-90, 0]) 
            bracket();
else if (mod == "assembly")
    assembly();
