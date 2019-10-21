include<drivableimplant64.scad>;

module driveHolder() {
  for(i=[0,1])
  mirror([i,0,0])
  difference(){
   union(){
    translate([armL+2.6,-.75,h-diskTh-3*armT/2])cube([2.6,3*armW+1.5,armT],center=true);
    translate([armL+2.6,armW+.05,h-diskTh-armT/2+1])cube([2.6,armW-.1,2+armT],center=true);
    translate([armL+2.6,armW+.05,h-diskTh-armT/2+2.5])rotate([90,0,0])cylinder(h=armW-.1,d=tubeD+1.8,center=true);
    translate([armL+2.6,-armW-.75-.05,h-diskTh-armT/2+4])cube([2.6,armW+1.5-.1,8+armT],center=true);
    translate([armL+2.6,-armW-.05,h-diskTh-armT/2+2.5])rotate([90,0,0])cylinder(h=armW-.1,d=tubeD+1.8,center=true);
    translate([armL+2.6,-5,h-diskTh-armT/2+2.5])rotate([90,0,0])cylinder(h=knotH,d=knotD+2,center=true);
       
   }
   translate([armL+2.6,0,h-diskTh-armT/2+2.5])rotate([90,0,0])cylinder(h=12,d=tubeD,center=true);
   translate([armL+2.6,-8.2+knotH-.05,h-diskTh-armT/2+2.5])rotate([90,0,0])cylinder(h=knotH+.1,d=knotD,center=true);
  }

  ///Mount part
  mountSizeD = 8.1; //D = 8.1 classic // 3.7 reduced
  mountSizeW = 12;  //W= 12 classic // 8=reduced
  mountAdj = 0;  // 0 classic // 1 reduced
  translate([0,-armW,44.5-mountAdj])
    difference(){
      union(){
        translate([0,0,-3])cube([mountSizeW,armW+3,6],center=true);
        translate([0,0,0])rotate([90,0,0])cylinder(d=mountSizeW,h=armW+3,center=true);
        translate([.5,0,6-mountAdj*1.5])cube([8,armW+3,6],center=true);
      }
      rotate([90,0,0])cylinder(d=mountSizeD,h=armW+3+.1,center=true);
      translate([0,0,5.5])cube([1.2,armW+3+.1,9],center=true);
      translate([0,0,6.5-mountAdj*2])rotate([0,90,0])cylinder(d=2,h=10,center=true);
      translate([6.1-2.9,0,6.5-mountAdj*2])rotate([0,90,0])cylinder(h=knotH,d=knotD,center=true);
    }
    
    
  translate([0,-armW,25.96])
  difference() {
    rotate([90,0,0])cylinder(h=armW+3,d=28.5,center=true);
    rotate([90,0,0])cylinder(h=armW+3+.1,d=23.4,center=true);
    translate([0,0,-35+3.03])cube([70,armW*3,70],center=true);
  } 
}


// to do the surgery
*driveHolder();

// Show all
*union() {
 translate([0,0,10]) stage();
 body();
 color("Green")translate([0,0,h])eib64();
 translate([0,19.67+3,h-3.6])rotate([90,0,0])driveHolder(); //+6 to take it out
}