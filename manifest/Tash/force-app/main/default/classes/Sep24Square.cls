public class Sep24Square implements Sep25ShapeInterface {
    
    double side;
    
    public Sep24Square (double s){
        side = s;
        
    }
    
    public double getArea(){
        return side * side * side *side;
        
    }

}