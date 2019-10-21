//-- Models for Open-Ephys EIB boards
//-- Ariel Burman - Buenos Aires, Argentina
//-- v1.0 - September 2018
//-- Creative Commons - Attribution - Share Alike

module eib64(){
  translate([0,0,0.4])
  difference(){
    cylinder(h=.8,d=21.5,$fn=80,center=true);
    for(i=[-1,1])
    translate([i*7.5,0,0])cylinder(h=2,d=(30/1000*25.4),$fn=30,center=true);
    for(i=[-1,0,1])
      translate([0,i*202*25.4/1000,0])cylinder(h=2,d=(50/1000*25.4),$fn=30,center=true);
  }
  for(i=[-1,1])
    translate([0,i*2.54,2.4+0.8])cube([12,2,4.8],center=true);
}

module eib32(){
  translate([0,0,0.4])
  difference(){
    cylinder(h=.8,d=18,$fn=80,center=true);
    for(i=[-1,1])
    translate([i*6.2,0,0])cylinder(h=2,d=(60/1000*25.4),$fn=30,center=true);
    for(i=[-1,1])
      translate([i*2,-.5,0])cylinder(h=2,d=(40/1000*25.4),$fn=30,center=true);
  }
  translate([0,2.54,2.4+0.8])cube([12,2,4.8],center=true);
}


// show all
*union(){
  eib32();
  translate([20,0,0])eib64();
}