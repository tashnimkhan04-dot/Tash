public with sharing class BeerController {
    // Constructor
    public BeerController() {
        // Initialize any necessary variables or settings
    }

    // Example method to get a list of beers
    public List<String> getBeerList() {
        // This is a placeholder for actual beer retrieval logic
        return new List<String>{'IPA', 'Stout', 'Pale Ale', 'Lager'};
    }

    // Method to retrieve beer records with their price
    public List<PricebookEntry> getBeerPrices() {
        return [SELECT Id, Name, UnitPrice 
                FROM PricebookEntry 
                WHERE IsActive = true];
    }
}