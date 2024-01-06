//
//  A film cartridge to fit Single 8 cameras
//  Version 1.1
//  Copyright (c) Jenny List 2023,2024.
//
//  Released under the CERN-OHL-S 2.0
//  When distributing this file, its derivatives, or products made from it or them
//  you MUST include the URL of the original distribution
//  at https://github.com/JennyList/Single-8-cartridge
//

//Version number
VersionNumber = 1.1;

//The outer shape of a Single 8 cartridge. Used only as the form for the final cartridge
module SolidSingle8Cartridge(cartridgeHeight=12){
    difference(){
        union(){
            translate([28,38,0]) cylinder(cartridgeHeight,28,28,$fn=90); //left reel
            translate([73,38,0]) cylinder(cartridgeHeight,28,28,$fn=90); //right reel
            hull(){ //left front
                translate([0,7,0]) cube([29.5,32,cartridgeHeight]);
                translate([19.5,0,0]) cube([10,10,cartridgeHeight]);
                translate([7,7,0]) cylinder(cartridgeHeight,7,7,$fn=90);
            }
            translate([71.5,0,0]){ //right front
                hull(){
                    translate([0,7,0]) cube([29.5,32,cartridgeHeight]);
                    translate([0,0,0]) cube([10,10,cartridgeHeight]);
                    translate([22.5,7,0]) cylinder(cartridgeHeight,7,7,$fn=90);
                }
            }
            translate([39.5,16,0]) cube([22,48,cartridgeHeight]); // centre piece for curved inner shape to be carved from
        }
        
        translate([50.5,82.5,0]) cylinder(cartridgeHeight,22,22,$fn=90);  //Rounded centre back      
        translate([50.5,12.525,0]) cylinder(cartridgeHeight,6,6,$fn=90); //Rounded centre front
    }
}

// A boilerplate function for making circular arcs. Used to make the ISO slot.
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

// The function for the top half of the cartridge
module Single8CartridgeLid(cartridgeHeight=12){
    difference(){
        SolidSingle8Cartridge(cartridgeHeight);
        translate([0,0,1.5]){
            translate([28,38,0]) cylinder(20,27,27,$fn=90); //left reel
            translate([73,38,0]) cylinder(20,27,27,$fn=90);  //right reel
            hull(){ //left front
                translate([1,8,0]) cube([27.5,30,20]);
                translate([19.5,1,0]) cube([9,9,20]);
                translate([7,7,0]) cylinder(20,6,6,$fn=90);
            }
            translate([71.5,0,0]){ //right front
                hull(){
                    translate([1,8,0]) cube([27.5,30,20]);
                    translate([1,1,0]) cube([9,9,20]);
                    translate([22.5,7,0]) cylinder(20,6,6,$fn=90);
                }
            }
        }
        translate([29,37,0]) cylinder(cartridgeHeight,7,7,$fn=90); //left spindle
        translate([72,37,0]) cylinder(cartridgeHeight,7,7,$fn=90); //right spindle       
        translate([27.5,2,1]) cube([50,2,20]);  //somewhere for the film to go through
        
        translate ([36.5,52,0]) linear_extrude(0.5,true) scale([0.42,0.55,1]) mirror([0,1,0])  text("Jenny List", font = "Liberation Sans:style=Bold" ); // Stick my name on it
        
        translate([14.5,4,0]) cube([14.5,1,10]); //light stopper left
        translate([72,4,0]) cube([14.5,1,10]); //light stopper right
        
        translate([29,37,0]){//left spindle
            difference(){
                cylinder(4,7.5,7.5,$fn=90); 
                cylinder(4,7,7,$fn=90);
            }
        }
        translate([72,37,0]){ //right spindle
            difference(){
                cylinder(4,7.5,7.5,$fn=90); 
                cylinder(4,7,7,$fn=90);
            }
        }
    }
            translate([14.5,4,0]) cube([14.5,1,10]); //light stopper left
        translate([72,4,0]) cube([14.5,1,10]); //light stopper right
        
        translate([29,37,0]){//left spindle
            difference(){
                cylinder(4,7.5,7.5,$fn=90); 
                cylinder(4,7,7,$fn=90);
            }
        }
        translate([72,37,0]){ //right spindle
            difference(){
                cylinder(4,7.5,7.5,$fn=90); 
                cylinder(4,7,7,$fn=90);
            }
        }
}

// inside shape of cartridge, just used for carving out
module InsideOfSIngle8Cartridge(lidHeight=2,barrier=0){
    cylinderRadius = 26 - barrier;
    translate([28,38,0]) cylinder(lidHeight,cylinderRadius,cylinderRadius,$fn=90); //left reel
    translate([73,38,0]) cylinder(lidHeight,cylinderRadius,cylinderRadius,$fn=90);  //right reel
    hull(){ //left front
        translate([2+barrier,8+barrier,0]) cube([26.5-(2*barrier),30-barrier,lidHeight]);
        translate([19.5,1+barrier,0]) cube([9-barrier,9-barrier,lidHeight]);
        translate([8,7,0]) cylinder(lidHeight,6-barrier,6-barrier,$fn=90);
    }
    translate([72.5,0,0]){ //right front
        hull(){
            translate([0+barrier,8+barrier,0]) cube([26.5-(2*barrier),30-barrier,lidHeight]);
            translate([0+barrier,1+barrier,0]) cube([9-barrier,9-barrier,lidHeight]);
            translate([20.5,7,0]) cylinder(lidHeight,6-barrier,6-barrier,$fn=90);
        }
    }
}

// The function for the bottom half of the cartridge
// Supported ISO values: 25,50,100,200. 
module Single8Cartridge(iso=25){

    cylinderRadius = 25;
    
    difference(){
        union(){
            SolidSingle8Cartridge(1);
            InsideOfSIngle8Cartridge(11);
        }
        translate([0,0,2]) InsideOfSIngle8Cartridge(10,1);
        translate([28,38,1.5]) cylinder(2,cylinderRadius,cylinderRadius,$fn=90); //left reel cutout
        translate([73,38,1.5]) cylinder(2,cylinderRadius,cylinderRadius,$fn=90);  //right reel cutout
        translate([29,37,0]) cylinder(10,7,7,$fn=90); //left spindle
        translate([72,37,0]) cylinder(10,7,7,$fn=90); //right spindle
        translate([27.5,2,1]) cube([46,3,20]);  //somewhere for the film to go through    
        // CircularArc(InnerRadius,OuterRadius,ArkHeight,CentreAngle,AngleSubtended)
        // Arks for LHS camera protrusion to select film speed
        // AngleSubtended=20; from fuji spec 
        //CentreAngle=154; // 180-(angle subtended/2)-10
        IsoSlotDepth = 0.75; // The depth of the ISO slot. 1mm leaves it a little thin for SLA printing, causes translucency
        if(iso==25){
            AngleSubtended=20;
            CentreAngle=160;
            translate([28,38,0]) CircularArc(16,20,IsoSlotDepth,CentreAngle,AngleSubtended);
        } 
        if(iso==50){
            AngleSubtended=32;
            CentreAngle = 154;
            translate([28,38,0]) CircularArc(16,20,IsoSlotDepth,CentreAngle,AngleSubtended);
        } 
        if(iso==100){
            AngleSubtended=44;
            CentreAngle = 148;
            translate([28,38,0]) CircularArc(16,20,IsoSlotDepth,CentreAngle,AngleSubtended);
        } 
        if(iso==200){
            AngleSubtended=56; 
            CentreAngle = 142;
            translate([28,38,0]) CircularArc(16,20,IsoSlotDepth,CentreAngle,AngleSubtended);
        }     
         translate([12.5,40,0]) rotate([0,0,-90]) mirror([0,1,0]) linear_extrude(0.5,true) text(str("ISO ",iso), font = "Liberation Sans", size=5);
          
        translate([85,45,0]) rotate([0,0,-90]) mirror([0,1,0]) linear_extrude(0.5,true) text(str("Version ", VersionNumber), font = "Liberation Sans", size=5);
        translate([93,55,0]) rotate([0,0,-90]) mirror([0,1,0]) linear_extrude(0.5,true) text("CERN-OHL-S 2.0", font = "Liberation Sans", size=5);

        translate ([36.5,52,0]) linear_extrude(0.5,true) scale([0.42,0.55,1]) mirror([0,1,0])  text("Jenny List", font = "Liberation Sans:style=Bold" ); // Stick my name on it
    }
    
    //rings for light tight spindle
    translate([29,37,0]){//left spindle
        difference(){
            cylinder(4,7.5,7.5,$fn=90); 
            cylinder(4,7,7,$fn=90);
        }
    }
    translate([72,37,0]){ //right spindle
        difference(){
            cylinder(4,7.5,7.5,$fn=90); 
            cylinder(4,7,7,$fn=90);
        }
    }
    
    translate([14,5,0]) cube([14.5,1,11]); //light stopper left
    translate([72.5,5,0]) cube([14.5,1,11]); //light stopper right
    
    translate([8.5,6.5,1]) cylinder(9,2,2,$fn=90); //film pulley spindle left
    translate([92.5,6.5,1]) cylinder(9,2,2,$fn=90); //film pulley spindle right  
}

//Early version of the film pulley
module Single8FilmPulleyFlat(){
    difference(){
        cylinder(9.75,3.5,3.5,$fn=90);
        cylinder(9.75,2.5,2.5,$fn=90);
    }   
}

//Later version of the film pulley
module Single8FilmPulleyRidged(){
    difference(){
        union(){
            cylinder(0.75,3.75,3.0,$fn=90);
            translate([0,0,0.75]) cylinder(8.0,3.0,3.0,$fn=90);
            translate([0,0,8.75]) cylinder(0.75,3.0,3.75,$fn=90);
        }
        cylinder(9.5,2.5,2.5,$fn=90);
    }   
}

//These four parts are required for a complete cartridge
//plus a pair of the film reels, in the accompanying file.
//This is laid out for printing all in one go. 
//If you are ordering SLA prints online you may have to create separate STL exports of these parts
Single8CartridgeLid();
translate([0,70,0]) Single8Cartridge(50); //ISO 50
translate([5,64,0]) Single8FilmPulleyRidged();
translate([96,64,0]) Single8FilmPulleyRidged();


