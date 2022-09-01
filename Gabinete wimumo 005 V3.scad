$fn=40;  // Alto número de caras de polígonos

/********************************************
*** CAJA WIMUMO 005 
********************************************/

ap = 1.5; // ancho pared
ai = 17; // alto interno 
xi = 64; // largo interno en x
yi = 110; // largo en y
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
        translate([xi-5,0,0]){
            caladuraCablesPilas();
         };
};

// Para probar si coincide 
//snap_tapa();

}
/********************************************
*** FIN CAJA WIMUMO 005 - A continuacion, 
modulos y librerias usadas en la caja
********************************************/

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


module caladuraCablesPilas(){
    translate([0,91.5,0]){
        cube([5,15,5]);
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
            cube([10,20,2],center = true);
        }
    translate([borde+dist*3,0,a]){
            cube([10,20,2],center = true);
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

