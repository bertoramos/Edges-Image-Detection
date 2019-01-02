class SobelEdgeDetector {
  
  private final int[][] xkernel = {{-1,0,+1},
                                   {-2,0,+2},
                                   {-1,0,+1}};
  private final int[][] ykernel = {{-1,-2,-1},
                                   {0,0,0},
                                   {+1,+2,+1}};
  
  private final PImage img;
  private final PImage G;
  private final PImage Gx;
  private final PImage Gy;
  
  SobelEdgeDetector(String img) {
    this.img = loadImage(img);
    this.img.loadPixels();
    G = createImage(this.img.width, this.img.height, RGB);
    Gx = createImage(this.img.width, this.img.height, RGB);
    Gy = createImage(this.img.width, this.img.height, RGB);
    calculateEdges();
  }
  
  private void calculateEdges() {
        
    for(int i=1; i < img.height-1; i++){
       for(int j=1; j < img.width-1; j++) {
         float xsum = 0;
         float ysum = 0;
         for(int ki=-1; ki <= 1; ki++){
            for(int kj=-1; kj <= 1; kj++){
               int pos = (i + ki)*img.width + (j + kj); // (y + ky)*img.width + (x + kx)
               color c = img.pixels[pos];
               float gray = (red(c) + green(c) + blue(c))/3.0;
               xsum += gray * xkernel[ki+1][kj+1];
               ysum += gray * ykernel[ki+1][kj+1];
            }
         }
         Gx.pixels[i*img.width+j] = color(xsum, xsum, xsum);
         Gy.pixels[i*img.width+j] = color(ysum, ysum, ysum);
         
         // Gradient combination
         float sum = sqrt( sq(xsum) + sq(ysum) );
         G.pixels[i*img.width+j] = color(sum, sum, sum);
       }
    }
    
    Gx.updatePixels();
    Gy.updatePixels();
    G.updatePixels();
    
  }
  
  public PImage getGradientXImage() {
    return this.Gx;
  }
  
  public PImage getGradientYImage() {
    return this.Gy;
  }
  
  public PImage getGradientImage() {
    return this.G;
  }
  
}
