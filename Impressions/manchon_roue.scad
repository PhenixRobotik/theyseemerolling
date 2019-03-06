$fn=100;

Daxis=8;//diametre axe
Dmin=6;//diametre dans l'encoche

Lroulement_encoche=16;//distance minimale entre le roulement et l'encoche
Lroulement_roue=18;//distance entre la fin du roulement et la partie exterieure de la poulie
Lencoche=5;//longueur de l'encoche

ep=1.8;//epaisseur du manchon

Dholes=3;//diametre des trous de fixation
Dflat=Dholes*2;//longueur plate a cote des trous

Lsq=25;//longueur de la piece

Wsq=18;

eps=0.001;

cutx=Wsq*2;
cuty=Lsq*4;
cutz=Daxis*2;

difference()//holes for screews
{

union(){//place for screews

translate([0,Lsq-Dflat-Lroulement_roue,0])
difference(){
translate([0,Dflat/2,-Daxis/4-ep/2])
cube(size=[Daxis*2.5,Dflat,Daxis/2+ep],center=true);

translate([0,Lsq/2-eps,0])
rotate([90,0,0])
cylinder(h=Lsq,r=Daxis/2+ep/2,center=true);
}

difference(){//cuts the cilinder in 2
    
difference(){//central hole

difference(){//cut 2 sections
translate([0,Lsq/2,0])
rotate([90,0,0])
cylinder(h=Lsq,r=Daxis/2+ep,center=true);

union(){//2 cut sections in tube
translate([0,Lroulement_encoche/2+(Lsq-Lroulement_encoche)+eps,0])
rotate([90,0,0])
cylinder(h=Lroulement_encoche+eps,r=Daxis/2,center=true);
    
tmp=Lsq-Lroulement_encoche-Lencoche;
translate([0,tmp/2-eps,0])
rotate([90,0,0])
cylinder(h=tmp,r=Daxis/2,center=true);
}
}

rotate([90,0,0])
cylinder(h=Lsq*4,r=Dmin/2,center=true);
}

translate([0,0,cutz/2])
cube(size=[cutx,cuty,cutz],center=true);
}
}

translate([0,Lsq-Dflat-Lroulement_roue,0])
union(){
translate([Daxis*0.9,Dflat/2,0])
cylinder(h=Lsq,r=Dholes/2,center=true);

translate([-Daxis*0.9,Dflat/2,0])
cylinder(h=Lsq,r=Dholes/2,center=true);
}

}