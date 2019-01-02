
void setup() {
  size(1500,1000);
  
  String image = "./imagenes/spots.jpg";
  
  SobelEdgeDetector sed = new SobelEdgeDetector(image);
  
  PImage original = loadImage(image);
  PImage gradient = sed.getGradientImage();
  PImage xgradient = sed.getGradientXImage();
  PImage ygradient = sed.getGradientYImage();
  
  // Images
  image(original,0,0);
  image(gradient,0,original.height);
  image(xgradient,original.width,0);
  image(ygradient,original.width,original.height);
  /*
  
  ORIGINAL    GRADIENT-X
  GRADIENT    GRADIENT-Y
  
  */
}

void draw() {
   noLoop();
}
