//-- Chronic drivable implant for extracellular electrophysiology
//-- Ariel Burman - Buenos Aires, Argentina
//-- v1.0 - September 2018
//-- Creative Commons - Attribution - Share Alike
//-- Modification for two canulas

use <open-ephys-eib.scad>;

//hub
$fn=50;
lengthT = 5.5;
tubeD = 1.55; //original 1.5, but need to use drill bit
knotH = 3.23;
knotD= 2.6+.2;
deltaH = 2.77;
heightT = deltaH + knotH + 1; //1 mm extra for the washer
extra=1;
widthHub = 3;

module hubM(){

    difference(){
      union(){
        // body
        for (i = [-1,1])
        hull(){
            cylinder(h=heightT,d=widthHub*1.3);
            rotate([0,0,-i*30])translate([i*lengthT/2,0,0])cylinder(h=heightT,d=widthHub);
        }
        hull(){
          cylinder(h=heightT,d=widthHub*1.3);
          translate([0,lengthT/2,0])cylinder(h=heightT,d=widthHub);
        }
        hull(){
          translate([0,lengthT/2,0])cylinder(h=heightT,d=widthHub);
          translate([-1.6,1+lengthT/2,0])cylinder(h=heightT,d=widthHub);
        }

        translate([0,lengthT/2,-extra])cylinder(h=extra,d=tubeD+1);
        translate([-1.6,1+lengthT/2,-extra])cylinder(h=extra,d=tubeD+1);
      }

      //knot
      translate([0,0,heightT-knotH])cylinder(h=knotH+.1,d=knotD);
      
      for (j=[1,2,3])
      rotate([0,0,j*120])
      intersection(){
      
        translate([0,-0.25,heightT-knotH])rotate([0,0,-150])cube([widthHub,widthHub*.9,knotH+.1]);
              mirror([1,0,0])
    translate([0,-0.25,heightT-knotH])rotate([0,0,-157])cube([widthHub,widthHub*.8,knotH+.1]);
      }

      //holes
      rotate([0,0,30])translate([-lengthT/2,0,-.05])cylinder(h=heightT+.1,d=tubeD);
      translate([0,0,-.05])cylinder(h=heightT-knotH+.1,d1=tubeD-0.05,d2=tubeD);
      rotate([0,0,-30])translate([lengthT/2,0,-.05])cylinder(h=heightT+.1,d=tubeD);
      translate([0,lengthT/2,-extra-.05])cylinder(h=heightT+extra+.1,d=tubeD);
      translate([-1.6,1+lengthT/2,-extra-.05])cylinder(h=heightT+extra+.1,d=tubeD);
    }
}

//stage
widthS = 3;
heightS = 2; //1 mm extra for the washer

module stageM(){

    difference(){
      union(){
        // body
        for (i = [-1,1])
        hull(){
            cylinder(h=heightS,d=widthS*1.3);
            rotate([0,0,-i*30])translate([i*lengthT/2,0,0])cylinder(h=heightS,d=widthS);
        }
        hull(){
            cylinder(h=heightS,d=widthS*1.3);
            translate([0,lengthT/2,0])cylinder(h=heightS,d=widthS);
        }
        hull(){
            translate([0,lengthT/2,0])cylinder(h=heightS,d=widthS);
            translate([-1.6,1+lengthT/2,0])cylinder(h=heightS,d=widthS);
        }
      }

      //holes
      rotate([0,0,30])translate([-lengthT/2,0,-.05])cylinder(h=heightS+.1,d=tubeD);
      translate([0,0,-.05])cylinder(h=heightS+.1,d1=tubeD-0.05,d2=tubeD);
      rotate([0,0,-30])translate([lengthT/2,0,-.05])cylinder(h=heightS+.1,d=tubeD);
      translate([0,lengthT/2,-.05])cylinder(h=heightS+.1,d=tubeD);
      translate([-1.6,1+lengthT/2,-.05])cylinder(h=heightS+.1,d=tubeD);
    }
}

//body
h = 23;
armL = 10; //lenght min 10
armT = 3; //thickness
armW = 3;

diskTh= 2;

dy = -diskTh;
baseOut = 9;
baseIn = 7;
topOut = 24;
topIn = 22;
dh = 3; // space at bottom, for the cover to start higher

angle = 90-atan(2*(h-dh)/(topOut-baseOut));
// pills
pillL = h-dh-diskTh-3;
pillW = 2.2;

module body(){
  fn1 = 50;
  hubM();
  // disc to mount pcb
  translate([0,0,h-diskTh/2]) 
  difference(){
    union(){
      cylinder(h=diskTh,d=14,$fn=fn1,center=true);
      translate([0,0,-armT*.4-diskTh/2])cylinder(h=armT*.8,d=9,$fn=fn1,center=true);
    }
    translate([0,0,-armT/2+.1])cylinder(h=diskTh+armT,d=1.6,$fn=fn1,center=true); //d=2.6 to have the scre go all the way up TODO check that 1.6
    //holes for mounting eib
    for(i=[0:7])
      rotate([0,0,360/8*i])
      translate([5.13,0,0])
        cylinder(h=diskTh+.1,d=1.3,$fn=25,center=true);
  }
  translate([0,0,h-diskTh-1.5]) 
  difference(){
    cylinder(h=6,d=3.6,$fn=fn1,center=true);
    cylinder(h=6.1,d=2.6,$fn=fn1,center=true);
  }

  // arms
  for(i=[0,1])
  rotate([0,0,180*i])translate([11,0,h-diskTh-armT/2])
    union(){
      cube([armL,armW,armT],center=true);
      translate([armL/2-1,0,-armT/2-1])cube([2,armW,2],center=true);
      translate([-armL/2,0,armT/2])
      difference(){
          rotate([90,0,0])cylinder(h=armW,d=2*armT,$fn=30,center=true);
          translate([armT,0,0])cube([2*armT,armW+1,2*armT],center=true);
          translate([0,0,armT+.1])cube([2*armT,armW+1,2*armT],center=true);
      }
    }
    
  // pills
  for (i=[-1,1])
    translate([i*(baseIn+baseOut)/4,0,dh])
    rotate([0,i*angle,0])
    translate([0,0,pillL/2+3])
     {
      cube([pillW,armW,pillL],center=true); 
      translate([0,0,-pillL/2])rotate([90,0,0])cylinder(h=armW,d=pillW,$fn=fn1,center=true);
     }
   

  //body cover
  difference() {
    translate([0,0,dh])cylinder(h=h+dy-dh,d1=baseOut,d2=topOut+(topOut-baseOut)*dy/(h-dh),$fn=fn1);
    translate([0,0,dh])cylinder(h=h+dy-dh+0.01,d1=baseIn,d2=topIn+(topIn-baseIn)*dy/(h-dh),$fn=fn1);
    translate([0,0,dh])cylinder(h=1,d=baseIn,$fn=fn1,center=true);
    translate([0,13,17])cube([30,20,20],center=true);
    translate([0,-13,17])cube([30,20,20],center=true);


    rotate([0,0,30])translate([-lengthT/2,0,-.05])cylinder(h=heightT+.1,d=tubeD,$fn=50);
    rotate([0,0,-30])translate([lengthT/2,0,-.05])cylinder(h=heightT+.1,d=tubeD,$fn=50);
    translate([0,lengthT/2,-extra-.05])cylinder(h=heightT+extra+.1,d=tubeD,$fn=50);

    //holes for dental cement
    for(i=[50,130,235,270,305])
      rotate([0,0,i])
      translate([5,0,1.2+dh])rotate([0,90,0])cylinder(h=3,d=1,$fn=20,center=true);
    for(i=[30,65,115,150,250,290])
      rotate([0,0,i])
      translate([5.5,0,2.7+dh])rotate([0,90,0])cylinder(h=3,d=1,$fn=20,center=true);

  }
  //added closure for hub
  translate([0,0,dh])
  for(j=[0,1,2])
  rotate([0,0,j*120])
  difference(){
    cylinder(h=.4,d=7.5,$fn=fn1);
    for(i=[-1,1])rotate([0,0,i*20])translate([-8,-1.5,-.1])cube([16,8,.6]);
  }
  // hooks for covers
  for (i =[0,1])
  mirror([i,0,0])
  for (j=[0,1])
  translate([(baseIn+baseOut)/4,0,dh])
  rotate([0,angle,0])
  translate([0,0,(h-dh)*.5+j*(h-dh)*.14])
  translate([-.85-pillW/2,0,0])
  difference(){
    scale([1.9,1,1.5]) {
      hull(){
        translate([0,0,-0.5])rotate([90,0,0])cylinder(h=armW,d=1,$fn=40,center=true);
        translate([0,0,+0.5])rotate([90,0,0])cylinder(h=armW,d=1,$fn=40,center=true);
        translate([.25,0,0])cube([.5,armW,2],center=true);
      }
    }
    scale([1.2,1.1,1.1]) {
      hull(){
        translate([0,0,-0.5])rotate([90,0,0])cylinder(h=armW,d=1,$fn=40,center=true);
        translate([0,0,+0.5])rotate([90,0,0])cylinder(h=armW,d=1,$fn=40,center=true);
        translate([.25,0,0])cube([.5,armW,2],center=true);
      }
    }

  }
}

//covers
deltaC= .2;
fixY= 1.9; //manually adjust to get the right hook
dyCover = 3; // overrrides the global dy

module cover(){
  fn1=80;
  dy = dyCover; // overrrides the global dy
  difference(){
    translate([0,0,dh])cylinder(h=h+dy-dh,d1=baseOut,d2=topOut+(topOut-baseOut)*dy/(h-dh),$fn=fn1);
    translate([0,0,dh])cylinder(h=h+dy-dh+0.01,d1=baseIn,d2=topIn+(topIn-baseIn)*dy/(h-dh),$fn=fn1);
    translate([0,13-20+deltaC,(h-9)/2+7+deltaC/2])cube([30,20,h-9+deltaC],center=true);
    translate([0,0,3+deltaC])cube([20,20,8],center=true);
    translate([0,-10+.1,h])cube([30,20,8],center=true);
    for(i=[0,1])
      mirror([i,0,0])translate([topOut/2,0,h+dy/2]) rotate([0,90,0])cylinder(h=6,d=.8,$fn=40,center=true);
  }
  for (j=[0,1])
   mirror([1*j,0,0])
   translate([(baseIn+baseOut)/4,0,dh])
   rotate([0,angle,0])
   translate([0,0,(h-dh)*.5+j*(h-dh)*.14])
   translate([-.85-pillW/2,fixY+j*.3,0])
   difference(){
    hull(){
      translate([0,0,-0.5])rotate([90,0,0])cylinder(h=7.5,d=1,$fn=40,center=true);
      translate([0,0,+0.5])rotate([90,0,0])cylinder(h=7.5,d=1,$fn=40,center=true);
    }
    translate([0,5,0])rotate([0,0,-40])cube([6,2,2.5],center=true);
   }

}

module coverwindow() {
   difference(){
     cover();
     translate([0,15,h*0.6])rotate([90,0,0])cylinder(h=30,d=6,$fn=80);
   }
}
module cap(){
  fn1=80;
  dy = dyCover; // overrrides the global dy
  capTH=1;
  difference(){
    translate([0,0,dh])cylinder(h=h+dy-dh,d1=baseIn,d2=topIn+(topIn-baseIn)*dy/(h-dh)-.4,$fn=fn1);
    translate([0,0,h+dy-capTH/2])cube([14.6,8,3*capTH],center=true);  
    translate([0,0,h/2+dy/2-capTH])cube([topOut*1.5,topOut*1.5,h+dy],center=true);  
  }
}


module showAll(){

color("Red") 
   coverwindow();
color("Blue") 
   rotate([0,0,180.01]) cover();
translate([0,0,10]) stageM();
difference(){
    body();
  translate([-1.6,1+lengthT/2,-extra-.05])cylinder(h=heightT+extra+.1,d=tubeD);
}
cap();
color("Green")translate([0,0,h])eib64();

}

// parts to print
*difference(){
    body();
  translate([-1.6,1+lengthT/2,-extra-.05])cylinder(h=heightT+extra+.1,d=tubeD);
}

*stageM();
*cover();
*cap();
*coverwindow();



// all
showAll();