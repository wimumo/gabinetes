$fn=40;  // Alto número de caras de polígonos

/********************************************
*** TAPA WIMUMO 005 
********************************************/

ap = 1.5; // ancho pared
ai = 17; // alto interno 
xi = 64; // largo interno en x
yi = 110; // largo en y
cp = 2; // cubre-plug
ypcb = 85;// largo pcb

difference(){
    
    // Cuerpo de la tapa 
    union(){
        intersection(){
            
            //caja_completa();
            // obtengo la tapa
            //translate([-5,-5,ai]){cube([80,82,20]);};
        }
        
        // TAPA PRINCIPAL
        translate([0,0,ai]){caja_tapa(ap,ap,xi,ypcb+ap);}
        // borde
        alto_b = ai-3-1.7;
        margen = 0.3;
        reborde(0+margen,0+cp+margen,ai-alto_b+1,
        ypcb-2*margen,xi-2*margen,1.5,alto_b);
        
        // TAPA BATERIAS
        translate([0,ypcb+cp+2*ap,ai]){
            caja_tapa(ap,ap,xi,yi-ypcb-cp-2*ap);
         }
        alto_tb = 10 ;
        difference(){
        reborde(0+margen,ypcb+cp+3*ap+margen,ai-alto_tb+1,
        yi-ypcb-cp-ap*3-2*margen,xi-2*margen,1.5,alto_tb);
            
         translate([margen+ap,ypcb+cp+2*ap,6]){cube([xi-2*margen-2*ap,20,ai-ap-8]);}
        //translate([]){cube([]);}
        }
        
       
        
    };
    
    // Agujeros para botones
    px = 6+2;       // posicion de los postes
    py = 6+cp+2;
    
    // LED
     translate([px+10,py+68-3.22,ai-5]){cylinder(10,3,3);}
    // Reset
    translate([px+18.78,py+68-3.22,ai-5]){cylinder(10,1.5,1.5);};
    // Tecla ON/OFF
    htec = 11;
    translate([px+26.5,py+68-3.22-htec/2,ai-5]){
        cube([42-26.5,htec,16]);
     };
     
    
    translate([-ap,-ap,0]){cube([2*ap+xi,3*ap+ypcb,20]);}
     
    
}

/* reborde */
module reborde(x,y,z,w,l,a,h){
    translate([x,y,z]){
      difference(){
        // Gran borde
        cube([l,w,h]);
        // Hueco
        translate([a,a,-1]){
          cube([l-2*a,w-2*a,h+2]);
        }
        // Ranuras para formar solapas
        // frente y atras
        translate([15,-5,-7]){
          cube([10,120,ai]);
        }
        translate([40,-5,-7]){
          cube([10,120,ai]);
        }
        // esquineras
        translate([-5,-5,-7]){
          cube([10,10,ai]);
        }
        translate([xi-5,-5,-7]){
          cube([10,10,ai]);
        }
        translate([-5,ypcb-5,-7]){
          cube([10,15,ai]);
        }
        translate([xi-5,ypcb-5,-7]){
          cube([10,15,ai]);
        }
        // Laterales
        translate([-5,ypcb/2-5,-7]){
          cube([10,10,ai]);
        }
        translate([xi-5,ypcb/2-5,-7]){
          cube([10,10,ai]);
        }
        
      }
    
    };

}


/* CAJA */
module caja_completa(){
// Caja completa
    
ap = 1.5; // ancho pared
ai = 17; // alto interno 
xi = 64; // largo interno en x
yi = 110;
cp = 2; // cubre-plug
ypcb = 85;// largo pcb

union(){
    
difference(){
    // Caja completa
    union(){
        difference(){
            // Casco de la caja
            caja(ap,ai,xi,yi);
            
            // Hueco principal de la caja
            translate([0,cp,0]){cube([xi,yi-cp,ai+0.1]);};
            
            //hueco de los cables
            translate([0,cp+2,0]){huecoCables();};
        }

        translate([2,cp+2,0]){postes();}
        
        // Pared separadora batería
        translate([0,cp+ypcb,0]){
        cube([xi,ap*3,ai]);
        };
        
       
        
  
    };
    
    // Saco la tapa
    translate([-5,-5,ai]){cube([80,150,20]);};
    
    // Hago una zanja y agujeritos para que pasen los cables del 
    // portapilas
        caladuraCablesPilas();
        translate([xi-4,0,0]){
            caladuraCablesPilas();
         };
    };

}

}


/*
*   MODULOS PARA LA CAJA
*/

//Cuerpo Caja inferior    
module caja(ap,ai,xi,yi){
    hull() {
        // Vertice A
        translate([0,0,0])
            sphere(r=ap);
        translate([0,0,ai])   
            sphere(r=ap);
        // Vertice B        
        translate([0,yi,0])
          sphere(r=ap);
        translate([0,yi,ai])   
         sphere(r=ap);        
        // Vertice C     
        translate([xi,0,0]) 
            sphere(r=ap);
        translate([xi,0,ai])   
            sphere(r=ap);   
        // Vertice D     
        translate([xi,yi,0])
            sphere(r=ap);
        translate([xi,yi,ai])   
            sphere(r=ap);   
    } 
};

module caja_tapa(ap,ai,xi,yi){
 difference(){
        hull() {
        // Vertice A
        translate([0,0,0])
            sphere(r=ap);
        translate([0,0,ai])   
            sphere(r=ap);
        // Vertice B        
        translate([0,yi,0])
          sphere(r=ap);
        translate([0,yi,ai])   
         sphere(r=ap);        
        // Vertice C     
        translate([xi,0,0]) 
            sphere(r=ap);
        translate([xi,0,ai])   
            sphere(r=ap);   
        // Vertice D     
        translate([xi,yi,0])
            sphere(r=ap);
        translate([xi,yi,ai])   
            sphere(r=ap);   
    } 
        translate([-5,-5,ai-ap/2-10]){cube([80,120,10]);}
    }
   
};



module caladuraCablesPilas(){
    translate([-1,91.5,-1]){
        cube([6,15,5]);
        };
     translate([2,95,2]){
        rotate([90,0,0]){
         cylinder(10,2,2);
        }
        };
        
}

module huecoCables(){
    borde = 9;
    dist = 12;
    a = 12;
    rad = 3;
    largo = 10;
    translate([borde+dist,0,a]){
            rotate([90,90,0]){cylinder(h=largo,r=rad);}
        }
    translate([borde+dist*3,0,a]){
            rotate([90,90,0]){cylinder(h=largo,r=rad);}
        }
}
// Postes placa 
module postes(){
    
    translate([6,6,0]){   
        poste();
    }
    translate([6+48,6,0]){
       poste();
    }
     translate([6,6+68,0]){
       poste();
    }
    translate([6+48,6+68,0]){
       poste();
    }
}

module poste(){ 
  difference(){
    union(){
    cylinder(8, 2.7, 2.7);
    cylinder(2.5, 5, 5);        
    }
    cylinder(10, 1, 1);
  }
}