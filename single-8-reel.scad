//
//  The reel for a film cartridge to fit Single 8 cameras
//  Version 1.1
//  Copyright (c) Jenny List 2023,2024.
//
//  Released under the CERN-OHL-S 2.0
//  When distributing this file, its derivatives, or products made from it or them
//  you MUST include the URL of the original distribution
//  at https://github.com/JennyList/Single-8-cartridge
//

//distance between spindles is 45 mm
//Maximum reel size to fit the space is 24.5mm radius
//Maximum reel size without overlap is 22mm radius

// A boilerplate function for making circular arcs.
module CircularArc(InnerRadius,OuterRadius,ArkHeight,CentreAngle,AngleSubtended){
    //Do intersection of ring and triangle
    intersection() {
        rotate(CentreAngle,[0,0,1]){  //Make triangle
            linear_extrude(ArkHeight){
                polygon([[0,0],[OuterRadius,(-1*OuterRadius * tan(AngleSubtended/2))],[OuterRadius,OuterRadius * tan(AngleSubtended/2)]]);
            }
        }
        difference(){ //make ring
            cylinder(ArkHeight,OuterRadius,OuterRadius,$fn=90);
            cylinder(ArkHeight,InnerRadius,InnerRadius,$fn=90);
        }
    }
}

//This function creates a film reel to fit my single 8 compatible cartridge
module Reel(){
    difference(){
        union(){
            cylinder(9,10.5,10.5,$fn=90);//spindle
            cylinder(11,2.65,2.65,$fn=90);//protrusion
        }
        translate([0,0,5.5]) cylinder(3.5,5.3,0.5,$fn=90);//centre hole
        cylinder(5.5,5.3,5.3,$fn=90);//centre hole
        translate([0,0,10]) cube([1.2,5.3,3],true); //flat bade rewind slot
        translate([0,0,6]) difference(){ //space for top light blocker flange
            cylinder(3,8.5,8.5,$fn=90); 
            cylinder(3,5.9,5.9,$fn=90);
        }
        difference(){ //space for bottom light blocker flange
            cylinder(3,8.5,8.5,$fn=90); 
            cylinder(3,5.9,5.9,$fn=90);
        }
        translate([0,0,0.5]) CircularArc(9.25,9.75,8.6,135,90); //place for RH film end to be in
        translate([-9.75,-10,0.5]) cube([0.5,10,8.5]); // lead in
        translate([0,9.25,0.5]) cube([10,0.5,8.5]); // lead out
    }
    difference(){ //knurling for camera spindle
        union(){
            translate([-5.5,-0.4,0]) cube([11,0.8,8]);
            translate([-0.4,-5.5,0]) cube([0.8,11,8]);
        }
        cylinder(14,4.75,4.75,$fn=90);//centre hole
    }
}

//You will need two of these per cartridge
Reel();