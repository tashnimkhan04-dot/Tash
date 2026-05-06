public class Sep24Circle implements Sep25ShapeInterface {
    
    double radius;
    
    public Sep24Circle (double  R){
        radius = R;
            
    }
    
    public double getArea(){
        return Math.PI * radius * radius;
        
    }

}