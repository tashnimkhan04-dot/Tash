public virtual class Sep25ParentClassVehicle {
    
    public string make;
    public string model;
    
    public Sep25ParentClassVehicle (string make, string model){
        this.make=make;
        this.model=model;
    }
    
    public virtual void displayInfo(){
        system.debug('Vehicle make:' + make + ',Model:' + model);
    }

}