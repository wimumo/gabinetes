$fn=40;  // Alto número de caras de polígonos

a = 6; // altura
ap=1; // ancho pared;
as = 2; // solapa
xi = 30; // ancho interno
yi = 41; // largo interno
rc = 6; // radio curvatura
gpcb = 1.6; // grosor del pcb

difference(){
// Borde exterior de la caja
    translate([-ap,-ap,0]){
        caja(xi+2*ap,yi+2*ap,a,rc);
    }

    // Agujero principal
    translate([as,as,-1]){
        caja(xi-2*as,yi-2*as,a+1-ap,rc);
    }
   
    // caladura para soportar pcb
    translate([0,0,-1]){
        caja(xi,yi,gpcb+1,rc);
    }
   
    
    // ranura pasacable
    d=6;
    translate([xi/2,-1,a-ap-1]){
        cube([d,20,1.5],center=true);
    };


}


module caja(xi, yi, a, rc){
    
    hull(){
        translate([0+rc,0+rc,0]){
            cylinder(a,rc,rc);
        }
        translate([xi-rc,0+rc,0]){
            cylinder(a,rc,rc);
        }
        translate([0+rc,yi-rc,0]){
            cylinder(a,rc,rc);
        }
        translate([xi-rc,yi-rc,0]){
            cylinder(a,rc,rc);
        }
   
};
    
    }
