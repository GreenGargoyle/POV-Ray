// Date: 05/11/2015
// Author: Gareth Kennedy
// Author: Oleksandr Shpuryk
               
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "shapes3.inc"

//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_M = camera { perspective location <3,12,-12> look_at <0,0,5> } 
camera{Camera_M} 

// light --------------------------------------------------------------------
light_source{<0,2500,-3500> color White } 
 
// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000} 
  
// plane --------------------------------------------------------------------  
plane{ <0,0,1>, 0 
       texture{ pigment{ color rgb <0.85,0.82,0.8>}
                normal { bumps 0.075 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
              translate<0,0,30>
     }  

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
        
        
        
//############################### Table #################################
#declare table = 

box
{  
    <0 , 0 , 0>,
    <100 , 0.01 , 100>
    
    
    texture
    {
        uv_mapping pigment
        {
            image_map{jpeg "tableTexture.jpg"}
             
        } 
        scale <1 , 0.1 , 3>                  
    }  
    translate<-60 , 0 , -5> 
    scale z * 1.5
} 
//############################### End Of Table #########################        
        
        
//############################### Pen ##################################
//Ink cartridge of the pen.
#declare blueInkCartridge = union
{        
    //Empty part of cartridge.
    cylinder
    {  
        <0 , 3 , 0>,
        <0 , 4 , 0>,
        0.05     
        
        texture
        {
            pigment
            {
                color White
            }
        }
        
    } 
    
    //Ink part of cartridge.
    cylinder
    {     
        <0 , 4 , 0>,
        <0 , 7 , 0>, 
        0.05     
        
        texture
        {
            pigment
            {
                color Blue
            }
        }
    }                             
} 

//Ink cartridge of the pen.
#declare blackInkCartridge = union
{        
    //Empty part of cartridge.
    cylinder
    {  
        <0 , 3 , 0>,
        <0 , 4 , 0>,
        0.05     
        
        texture
        {
            pigment
            {
                color White
            }
        }
        
    } 
    
    //Ink part of cartridge.
    cylinder
    {     
        <0 , 4 , 0>,
        <0 , 7 , 0>,
        0.05     
        
        texture
        {
            pigment
            {
                color Black
            }
        }
    }                             
}   

//Plastic casing of the pen.
#declare plasticCasing = cylinder 
{
    <0 , 2.4 , 0>,
    <0 , 8 , 0>,
    0.1
    
    texture
    {  
        pigment
        {
            color White
            filter 0.9
        }   
    }   
}  

//End of pen.
#declare penEnd = cylinder
{  
    <0 , 2.2 , 0>,
    <0 , 2.4 , 0>,
    0.1
} 

#declare penCap = lathe
{ 
    quadratic_spline 6,
    <0.2 , 8>, 
    <0.2 , 9>,
    <0.15 , 10.0>,
    <0.13 , 10.2>,
    <0.12 , 10.3>
    <0.1 , 10.4> 
    
    translate <0 , -2 , 0>
} 

#declare penCapHandle = sphere
{     
    <1 , 1 , 1>,
    0.2 
    
    
    scale <0.3 , 5 , 0.3>
    translate <-0.13 , 1.8 , -0.17>
} 

#declare penLid = union
{
    object{penCap}
    object{penCapHandle} 
}

#declare penBits = union
{
    object{penEnd}
    object{penLid}
}   


#declare hexagonPenBlue = union
{
    object{ 
            Hexagon  
    
            texture
            {  
                pigment
                {  
                    color rgbf<1.0, 1.0, 1.0, 0.75>
                    
                }
                
                finish 
                {
                    ambient 0.1
                    diffuse 0.9
                    phong 1
                } 
                   
            } 
            interior{ior 1.1}
              
            scale <3.2 , 0.15 , 0.15> * 1.00 rotate<0 , 0 , 90> translate<0 , 5 , 0>
          } 
    
    
    object{penLid translate<0 , -1.6 , 0> scale<1.5 , 1.5 , 1.5> texture{pigment{color Blue}}}
    object{penEnd scale<1.5 , 1.5 , 1.5> translate<0 , -1.6 , 0>texture{pigment{color Blue}}}
    object{blueInkCartridge scale<1.5 , 1.5 , 1.5> translate<0 , -1.6 , 0>} 
}

#declare hexagonPenBlack = union
{
    object{ 
            Hexagon
              
            texture
            {  
                pigment
                { 
                    color rgbf<1.0, 1.0, 1.0, 0.75>  
                }
                
                finish 
                {
                    ambient 0.1
                    diffuse 0.9
                    phong 1
                } 
                   
            } 
            interior{ior 1.1}
              
            scale <3.2 , 0.15 , 0.15> * 1.00 rotate<0 , 0 , 90> translate<0 , 5 , 0>
          }
    
    
    object{penLid translate<0 , -1.6 , 0> scale<1.5 , 1.5 , 1.5> texture{pigment{color Black}}}
    object{penEnd scale<1.5 , 1.5 , 1.5> translate<0 , -1.6 , 0>texture{pigment{color Black}}}
    object{blackInkCartridge scale<1.5 , 1.5 , 1.5> translate<0 , -1.6 , 0>} 
}
//############################### End Of Pen ###############################


//############################### Ketchup ##################################
#declare ketchupSachetInner = isosurface
{
    //Function.
    function
    {
        y - f_noise3d(x , 0 , z)
    }
    
    //What function is contained in.
    contained_by
    {
        box
        {
            -2 , 2
        }
    } 
    
    uv_mapping pigment{image_map{jpeg "k.jpg"} scale<1.5 , 1 , 1> translate<2.1 , 0 , 0>}
}  

//The outer edges of the sachet.
#declare ketchupSachetEdges = difference
{ 
    isosurface
    {  
        //Function.
        function
        {
            y - f_noise3d(x , 0 , z)
        }
        
        //What function is contained in.
        contained_by
        {
            box
            {
                -2.3 , 2.3
            }
        } 
        
        pigment{color Red}
    
    }
   
    ketchupSachetInner
} 

#declare ketchupSachet = union
{
    object{ketchupSachetInner}
    object{ketchupSachetEdges}
}

#declare thinnerKetchupSachet = difference
{
    object{ketchupSachet}  
    
  
    box
    {
        -2.4 , 2.4 
        translate<0 , -2.2 , 0>
    } 
       
    scale<1 , 0.5 , 0.5> 
    rotate y * 180
}

#declare completeKetchupSachet = difference
{    
    object{thinnerKetchupSachet}
    object{thinnerKetchupSachet scale 1.01 translate<0 , -0.1 , 0>}
    
}
//############################ End Of Ketchup ##############################
 

//################################# Usb ####################################

#declare Obj1 = merge { 
    difference { 
        cylinder { <0,0,0>,<0,0,0.25>,0.25 
            texture { 
                pigment { 
                    color rgb<0.01,0.01,0.01>
                }
                finish { phong 1 }
            }
            scale <1,1,1> rotate<0,0,0> translate<-1.8,0.25,-0.1>
        }
    
        cylinder { <0,0,-0.5>,<0,0,1>,0.12 
            texture { 
                pigment { 
                    color rgb<0.01,0.01,0.01>
                }
                finish { phong 1 }
            }
            scale <1,1,1> rotate<0,0,0> translate<-1.8,0.25,-0.1>
         }
    }     
               
    box { <0, 0, 0>, <0.4, 0.1, 0.25>
        texture { 
            pigment { 
                color rgb<0.01,0.01,0.01>
            }
            finish { phong 1 }
        }
        scale <1,1,1> rotate<0,0,0> translate<-2.2,0.4,-0.1>
    }
            
                       
    difference {         
        intersection {   
            object {
            Round_Cylinder(<0,0,0>, <0,0.32,0>, 1.5 ,       0.15,   0)  
                texture { 
                    pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale<1,1,0.5>  rotate<0, 0,0> translate<-3,0.25,0>
            }

            cylinder { <0,-0.5,0>,<0,1,0>, 1.5 
                texture{ pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale <1,1,1> rotate<0,0,0> translate<-3.5,0,0>
            } 
           
            cylinder { <0,-0.5,0>,<0,1,0>, 1 
                texture{ pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale <1,1,1> rotate<0,0,0> translate<-2.5,0,0>
            } 
        }
 
        difference { 
            cylinder { <0,0.5,0>,<0,1,0>, 0.4
                texture{ pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale <1,1,1> rotate<0,0,0> translate<-2.8,0,0>
            } 
  
            cylinder { <0,-0.5,0>,<0,2,0>, 0.34
                texture{ pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale <1,1,1> rotate<0,0,0> translate<-2.8,0,0>
            }           
        }           
      
        cylinder { <0,0,0>, <0,0.2,0>, 0.6
            texture{ pigment{ color rgb<0.01,0.01,0.01> }
                finish { phong 1 }
            }
            scale<1,1,1>  rotate<0,0,0> translate<-3.2,0.32,0>
        }  
    }
}   
  
       
#declare Obj2 = merge {                   
    torus { 0.7, 0.07              
        scale <1,0.5,1> translate<0,0.1,0>
    }
    torus { 0.7, 0.07              
        scale <1,0.5,1>
    }      
} 
         
                          
#declare Obj3 = merge {          
    object{ 
    Round_Box(<0.9,0.1,-0.01>,<3.1,0.7,1.01>, 0.05   , 0)  
        texture{ 
            pigment{ color rgb<0.5,0.5,0.5> }
            finish { phong 1 }
        }
        scale<1,1,1>  rotate<0, 0,0> translate<0,0,0>
    }             
            
    object { 
    Round_Cylinder(<3,0.1,0.5>, <3,0.7,0.5>, 0.505,       0.05,   0)  
        texture{ 
            pigment{ color rgb<0.5,0.5,0.5> }
            finish { phong 1 }
        }
        scale<1,1,1>  rotate<0, 0,0> translate<0,0.00,0>
    }          
            
    object { 
    Round_Cylinder(<3,0,0.5>, <3,0.8,0.5>, 0.2,       0.05,   0)  
        texture{ 
            pigment{ color rgb<1,0,0> * 0.02 }
            finish { phong 1 }
        }
        scale<1,1,1>  rotate<0, 0,0> translate<0,0.00,0>
    }          
                 
    difference {
        merge {
            object{ 
            Round_Box(<0,0,0>,<3.1,0.8,1>, 0.1   , 0)  
                texture{ 
                    pigment{ color rgb<0.01,0.01,0.01>}
                    finish { phong 1 }
                }
                scale<1,1,1>  rotate<0, 0,0> translate<0,0,0>
            }   
      
            difference {  
                object { 
                Round_Cylinder(<0,0,0.5>, <0,0.8,0.5>, 0.5,       0.1,   0)  
                    texture{ 
                        pigment{ color rgb<0.01,0.01,0.01> }
                        finish { phong 1 }
                    }
                    scale<1,1,1>  rotate<0, 0,0> translate<0,0.00,0>
                } 
            
                cylinder {
                    <0,-0.2,0.5> <0,1,0.5> 0.4
                    texture{ 
                        pigment{ color rgb<0.01,0.01,0.01> }
                        finish { phong 1 }
                    }
                }
            }      
   
            object { 
            Round_Cylinder(<3,0,0.5>, <3,0.8,0.5>, 0.5,       0.1,   0)  
                texture{ 
                    pigment{ color rgb<0.01,0.01,0.01> }
                    finish { phong 1 }
                }
                scale<1,1,1>  rotate<0, 0,0> translate<0,0.00,0>
            }   
        }

        cylinder {
            <0,0,0> <0,2,0> 0.6
            texture{ 
                pigment{ color rgb<0.01,0.01,0.01> }
                finish { phong 1 }
            } 
            rotate <90, 0, 0>
            translate<-0.45,-0.3,-0.5>
        } 
    
        cylinder {
            <0,0,0> <0,2,0> 0.6
            texture{ 
                pigment{ color rgb<0.01,0.01,0.01> }
                finish { phong 1 }
            } 
            rotate <90, 0, 0>
            translate<-0.45,1.05,-0.5>
        }       
      
        cylinder {
            <3,-0.5,0.5>, <3,0.9,0.5>, 0.2
            texture{ 
                pigment{ color rgb<0.01,0.01,0.01> }
                finish { phong 1 }
            } 
            rotate <0, 0, 0>
        }  
      
        cylinder {
            <1.5,-0.5,-0.5> <1.5,2,-0.5> 0.8
            texture{ 
                pigment{ color rgb<0.01,0.01,0.01> }
                finish { phong 1 }
            } 
            rotate <0, 0, 0>
        }    
    }          
}      
     

#declare LabelText1 = 
    texture { 
        pigment { 
            image_map { png "crucial.png"
                map_type 0 
                interpolate 2 
                    once 
            } 
            scale <1,0.8,1>
        } 
        finish { phong 1 }
    }

#declare Label = box{ <0, 0, 0>,< 1, 1, 0.0001> }     
     
 
#declare Usb = merge {
    object { Obj1 

        scale<1,1,1>  rotate<20,-20,15> translate<0.25,0.82,0.9>
    }
    
    object{ Obj2 
        texture {Chrome_Metal}    
        rotate<35,0,0> translate<-0.8,0.5,0.4>
    }     
         
    object { Obj3 } 
    
    object { Label
        texture { LabelText1 }
        rotate<90,0,0>
        translate<0.1,0.801,0.7>
        scale<1.5,1,0.5>
    }       
}     
//############################### End Of USB ###############################            
      

//############################### Lighter ################################## 
#declare LabelText2 = texture { 
    pigment { 
        image_map { png "bic.png"
            map_type 2 
            interpolate 2 
                once 
        } 
        scale <1,5,1>  translate <0,0,0>  rotate <0,-90,0>
    } 
    finish { phong 1 }
}
            
#declare Lighter = merge {    
    cylinder {
        <0,0,0> <0,5,0> 1
        texture { LabelText2 }
        scale <0.5,1,1>
    }  
    
    difference {  
        object { 
        Round_Cylinder(<0,4,0> <0,6,0> 1 ,       0.15,   0)  
            scale<0.5,1,1>  rotate<0, 0,0> translate<0,0.00,0>
        } 
        
        box { 
            <-1,5,-2.5> <1,7,-0.5>
            translate <0,-1,4.65>
            rotate <-20, 0, 0>
        }
         
        cylinder {
            <0,4.9,-0.6> <0,7,-0.6> 0.25
        }
        
        box { 
            <-0.3,4.9,-0.3> <0.3,6.5,1>
        }
        
        cylinder {
            <0,5.3,-0.7> <0,5.4,-0.7> 0.33
        } 
        
        cylinder {
            <0,5.6,-0.7> <0,5.7,-0.7> 0.33
        } 
        
        box { 
            <-0.6,5.1,0> <-0.45,5.4,0.2>
        }
         
        box { 
            <0.6,5.1,0> <0.45,5.4,0.2>
        }
        
        cylinder{ 
            <0,3,0> <0,5,0> 2 
        } 
        texture{Polished_Chrome}
    }
        
    difference {  
        cylinder {
            <0,5.2,0> <0,5.35,0> 1
            pigment {
                rgb<1,0,0> 
            }
            scale <0.5,1,0.95>
        }
        box { 
            <-0.5,5.1,-1.3> <0.5,5.5,0.45>
            pigment {
                rgb<1,0,0> 
            }
        }
    }  
      
    box { 
        <-0.2,4.9,0.3> <0.2,5.3,0.7>
        pigment {
            rgb<1,0,0> 
        }
    }     
       
    cylinder {
        <0,5,0> <0,5.15,0> 0.4
        pigment {
            rgb<0.1,0.1,0.1> 
        } 
        rotate <0, 0, 90>
        translate <5.3,5.75,0.1>
    }  
    
    cylinder {
        <0,5.45,0> <0,5.6,0> 0.4
        pigment {
            rgb<0.1,0.1,0.1> 
        } 
        rotate <0, 0, 90>
        translate <5.3,5.75,0.1>
    }
      
    cylinder {
        <0,5.1,0> <0,5.5,0> 0.35
        pigment {
            rgb<0.05,0.05,0.05> 
        } 
        rotate <0, 0, 90>
        translate <5.3,5.75,0.1>
    }      
      
    cylinder {
        <0,4.9,-0.6> <0,5.7,-0.6> 0.08
        pigment {
            rgb<1,1,1> * 0.1
        }
    }  
} 
//############################### End Of Lighter ###########################              
       
    
//################################ Spray ###################################
       
#declare LabelText3 = texture { 
    pigment { 
        image_map { png "spray.png"
            map_type 2 
            interpolate 2 
                once 
        } 
        scale <1,2.5,1>  translate <0,0.25,0>  rotate <0,5,0>
    } 
    finish { phong 1 }
}

                  
#declare Spray = merge {                                         
    object { 
    Round_Cylinder(<0,0,0> <0,3,0> 1 ,       0.3,   0)  
        texture{ pigment{ color rgb<1,1,1> }
            finish { phong 1 }
        }
    }     
     
    object{ Round_Pyramid_N_out( 36, <0,2.95,0>, 0.85, <0,4.2,0>, 0.75, 0.1, 1, 0) 
        texture{ pigment{ rgb<1,1,1> }    
                 finish { phong 1 } 
               } 

        scale <1,1,1>*1 
        rotate <0,0,0>
        translate< 0, 0, 0>
    }
     
    object{
    Round_Cone( <0,4.1,0>, 0.65    , <0,4.7,0>, 0.6 , 0.02, 0)  
        texture{ pigment{ color rgb<1,1,1> }
            finish { phong 1 }
        }
    }  
    
    difference {
        object{
        Round_Cone( <0,4.6,0>, 0.53    , <0,5.5,0>, 0.47 , 0.02, 0)  
            texture{ pigment{ color rgb<1,1,1> }
                finish { phong 1 }
            }
        }
                 
        cylinder { <0,5.25,-0.45>,<0,5.25,-1>,0.18 
            texture{ pigment{ color rgb<1,1,1> }
                finish { phong 1 }
            }
        }
     
        cylinder { <0,5.25,-0.4>,<0,5.25,-1>,0.03 
           texture{ pigment{ color rgb<1,1,1> }
                finish { phong 1 }
            }
        }
    }
       
    cylinder {
        <0,0.25,0> <0,2.75,0> 1.001         
        texture { LabelText3 }
    } 
     
    difference {
        object{ 
        Round_Cone( <0,4.2,0>, 0.7    , <0,5.75,0>, 0.58 , 0.02, 0)  
            
        }         
          
        object{
        Round_Cone( <0,4.15,0>, 0.7    , <0,5.7,0>, 0.58 , 0.02, 0)  
            
        }  
             
            
        material {
            texture {
                pigment {color rgbf<1.0, 1.0, 1.0, 0.75>}
                finish {ambient 0.1
                     diffuse 0.9
                     phong 1}
            }
            interior {ior 1.1}
        }    
             
    } 
}  
//############################### End Of Spray #############################      

      
//############################### Bonjela ##################################

#declare Obj4 = merge {           
    cone { <0.00,0.8,0.00>, 0.5, <0.00,1.00,0.00>, 0.7
        texture{Polished_Chrome}
    }

    object { Round_Cylinder(<0,0.6,0>, <0,0.8,0>, 0.6 ,       0.02,   0)  
        texture { 
            pigment{ color rgb<1,1,1> }
            finish { phong 1 }
        }
        scale<1,1,1>  rotate<0, 0,0> translate<0,0.00,0>
    }
    
    object{ Round_Pyramid_N_out(24, <0,0,0>, 0.45, <0,0.7,0>, 0.55, 0.08, 1, 0) 
        texture{ 
            pigment{ rgb<1,1,1> }    
            finish { phong 1 } 
        }
        scale <1,1,1>*1 rotate <0,0,0> translate< 0, 0, 0>
    }   
}


#declare Obj5 = merge {
    object{ Round_Box(<-1.03,5,0>,<1.03,5.8,-0.03>, 0.03   , 0)  
        texture{ 
            pigment{ color rgb<0,0,1> }
            finish { phong 0.5 }
        }
    }
           
    object{ Round_Box(<-1.04,5,0>,<1.04,5.3,-0.05>, 0.05   , 0)  
        texture{ 
            pigment{ color rgb<0,0,1> *0.9 }
            finish { phong 0.5 }
        }
    } 
    
    scale<1,1,1>  rotate<8, 0,-5> translate<-0.52,0,-0.81>     
}      


#declare LabelText4 = texture { 
    pigment { 
        image_map { 
            png "bonjela1.png"
            map_type 0 
            interpolate 2 
            once 
        } 
        scale <2,0.5,1> 
        translate<-1,5.3,0>
    } 
    finish { phong 1 }
}

#declare Obj6 = box{ <-1,5.3,-0.0451>,<1,5.79,-0.04> }

                   
#declare LabelText5 = texture { 
    pigment { 
        image_map { 
            png "bonjela2.png"
            map_type 2
            interpolate 2 
            once 
        } 
        scale <1,4.8,1> 
        translate<0,1.1,0> 
        rotate <0,0,0>
    } 
    finish { phong 1 }
}
                 
                 
#declare Obj7 = object{ Supercone(<0.00,1.00,0.00>, 0.7, 0.7, 
                                  <0.00,5.8,0.00>, 1, 0.025) 
    texture{ 
        pigment{ color rgb<0,0,1>  }
        finish { phong 0.5 }
    }
    scale<1,1,1> 
    rotate<0,0,0> 
    translate<0,0,0>
}
                 
                 
#declare Bonjela = merge {                 
    object { Obj4 }
    
    object { Obj5 } 
      
    object { Obj6
        texture { LabelText4 } 
        scale<1,1,1>  rotate<8, 0,-5> translate<-0.52,0,-0.81>
    }
                  
    difference {             
        object { Obj7
            texture { LabelText5 } 
            scale<1,1,1>  rotate<0, 0,0> translate<0,0,0>
        }          
            
        box { <-1.1,5.75,0.2>,<1.1,6.5,-0.1>
            texture { 
                pigment{ color rgb<0,0,1> }
                finish { phong 0.5 }
            }
            scale<1,1,1>  rotate<8, 0,-5> translate<-0.52,0,-0.84>      
        }      
    }
}
//########################### End Of Bonjela ############################# 


//############################### Phone ##################################                   
#declare LabelSpeaker = texture { 
    pigment { 
        image_map { 
            png "speaker.png"
            map_type 0 
            interpolate 2 
            once 
        } 
        scale <2,0.4,1> 
        translate<0,0.09,0>
    } 
    finish { phong 1 }
}    
      
#declare LabelText6 = texture { 
    pigment { 
        image_map { 
            png "htc.png"
            map_type 0 
            interpolate 2 
            once 
        } 
        scale <2,0.45,1> 
        translate<0,0.09,0>
    } 
    finish { phong 1 }
}     
      
#declare Obj8 = box { <0,0,0>,<2,0.5,0.1> }

#declare Obj9 =  difference {
    object { Round_Box(<0,0,0>,<4,7.5,0.7>, 0.25   , 0)  
        texture{ pigment{ color rgb<1,1,1> }
            finish { phong 1 }
        }
    } 
   
    box { <-0.0001,-0.1,0.3>,<4.5,8,-0.5>
        texture{ pigment{ color rgb<1,1,1>}
             finish { phong 1 }
        }
    }
} 

#declare Obj10 = difference { 
    difference {
        object{ Round_Box(<0,0,0>,<4,7.5,0.7>, 0.25   , 0)  
            texture {
                Chrome_Metal
            }
        } 
    
        box { <-0.1 , -0.1 , 0.3> <4.1,7.8,1>  
            texture {
                Chrome_Metal
        
            }  
        }    
    }     
    
    box { <-0.0001,-0.1,-0.3>,<4.5,8,0.15>
        texture {
            Chrome_Metal  
        }
    }
         
    cylinder { <3.6,7.25,0.149>,<3.6,7.25,0.2>,0.15 
        pigment {color rgb<0, 0, 0>}
    }
}   
   
#declare Obj11 = merge {      
    box { <-0.0001,0.6,0.3>,<4.0001,7,0.149>  
        texture { 
            pigment { 
                color rgb<0,0,0>
            }
            finish { phong 1 }
        }
    }  
         
    object { Round_Cylinder(<3.6,7.25,0.149>,<3.6,7.25,0.2>,0.15,       0.02,   0)  
        material {
            texture {
                pigment {color rgbf<0, 0, 0, 0.1>}
                finish {F_Glass1}
            }
            interior {ior 1.5}
        }
    }

    cylinder { <0.5,7.15,0.149>,<0.5,7.15,0.2>,0.05 
        pigment {color rgb<0, 0, 0>}
    } 
      
    cylinder { <0.65,7.15,0.149>,<0.65,7.15,0.2>,0.05 
        pigment {color rgb<0, 0, 0>}
    }
}
  
#declare Phone = union { 
    object { Obj8 texture { LabelText6 } 
        scale <1.2,0.7,1> translate<0.95,0.7,0.14> 
    }  
                         
    object { Obj8 texture { LabelSpeaker } 
        scale <1.2,0.7,1> translate<0.85,0.15,0.149> 
    } 

    object { Obj8 texture { LabelSpeaker } 
        scale <1.2,0.7,1> translate<0.85,7,0.149> 
    } 
    
    object {Obj9}
    
    object {Obj10}
    
    object {Obj11}
}
//########################### End Of Phone #############################         
   
  
//############################## CREATING OBJECTS ###############################
object{table}  

object{hexagonPenBlack rotate<5 , 150 , 6> translate<-0.1 , -1.6 , 2.5>}

object{hexagonPenBlue rotate<3 , 160 , 0> translate<-0.4 , -1.5 , 3>} 

object{completeKetchupSachet rotate<0,-8,0> translate<-0.27 , 0 , -1.7> scale<1.08 , 1 , 1>}

object { Usb rotate <0,5,0> translate<-0.1,0,0>} 

object{Lighter rotate <0,-70,0> translate <-4.3,0,-1.1> scale <0.85,0.85,0.85>}

object {Spray translate <4,0,-2.6> scale <0.75,0.85,0.75>}

object { Bonjela  translate <-4.2,0,0.4> }

object {Phone scale<1,1.1,1> rotate<60 , -35 , 0> translate<5 , 0.5 , -2.5>}
//###############################################################################