public class Sep25ChildClasCar Extends Sep25ParentClassVehicle {
    
    public Integer numberOfDoors;
    
    public Sep25ChildClasCar (String make, String model, Integer numberOfDoors) {
        super(make, model);
        this.numberOfDoors = numberOfDoors;
    }
    
    public override void displayInfo(){
        super.displayInfo();
        System.debug('Number of Doors: ' + numberOfDoors);
    
    }

}