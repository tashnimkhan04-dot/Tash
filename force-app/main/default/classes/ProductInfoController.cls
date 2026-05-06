public with sharing class ProductInfoController {
    public New_Potential_Adverse_Event__c mainAE {get; set;}
    public List<ProductRow> rows {get; set;}
    public List<AERow> aeRows {get; set;}
    
    public Boolean seriousnessDeath {get; set;}
    public Boolean seriousnessLifeThreatening {get; set;}
    public Boolean seriousnessDisability {get; set;}
    public Boolean seriousnessHospitalization {get; set;}
    public Boolean seriousnessCongenitalAnomaly {get; set;}
    public Boolean seriousnessOther {get; set;}
    public String eventDescription {get; set;}
    public String relevantMedicalHistory {get; set;}
    public Boolean addIndividualEventsFlag {get; set;}

    public ProductInfoController() {
        mainAE = new New_Potential_Adverse_Event__c();
        rows = new List<ProductRow>{ new ProductRow(1) };
        aeRows = new List<AERow>{ new AERow(1) };
        
        // Map from Case if ID is present
        String caseId = ApexPages.currentPage().getParameters().get('caseId');
        if (String.isNotBlank(caseId)) {
            try {
                // Fetching Product_Indication__c from Case as requested
                String query = 'SELECT Product_Indication__c FROM Case WHERE Id = :caseId LIMIT 1';
                List<SObject> caseRecords = Database.query(query);
                if (!caseRecords.isEmpty() && caseRecords[0].get('Product_Indication__c') != null) {
                    rows[0].indication = (String)caseRecords[0].get('Product_Indication__c');
                }
            } catch (Exception e) { System.debug('Case fetch failed: ' + e.getMessage()); }
        }
    }

    public void fetchProductDetails() {
        try {
            String rowIdxStr = ApexPages.currentPage().getParameters().get('rowIdx');
            if (String.isNotBlank(rowIdxStr)) {
                Integer index = Integer.valueOf(rowIdxStr);
                ProductRow currentRow = rows[index - 1];
                if (String.isNotBlank(currentRow.productName)) {
                    List<MICC_Product__c> master = [SELECT Id, Name, Product_Type__c, Product_Indication_Medicus__c FROM MICC_Product__c WHERE Name = :currentRow.productName LIMIT 1];
                    if (!master.isEmpty()) {
                        currentRow.productObj.MICC_Product_Link__c = master[0].Id;
                        currentRow.productType = master[0].Product_Type__c;
                        currentRow.indication = master[0].Product_Indication_Medicus__c;
                    }
                }
            }
        } catch (Exception e) { System.debug('Auto-fetch failed: ' + e.getMessage()); }
    }
    
    public void addRow() { if (rows.size() < 10) rows.add(new ProductRow(rows.size() + 1)); }
    public Integer rowToRemoveIndex {get; set;}
    public void removeRow() {
        if (rows.size() > 1) {
            for (Integer i = 0; i < rows.size(); i++) {
                if (rows[i].srNo == rowToRemoveIndex) { rows.remove(i); break; }
            }
            for (Integer i = 0; i < rows.size(); i++) rows[i].srNo = i + 1;
        }
    }
    
    public void addAERow() { if (aeRows.size() < 10) aeRows.add(new AERow(aeRows.size() + 1)); }
    public Integer aeRowToRemoveIndex {get; set;}
    public void removeAERow() {
        if (aeRows.size() > 1) {
            for (Integer i = 0; i < aeRows.size(); i++) {
                if (aeRows[i].aeNo == aeRowToRemoveIndex) { aeRows.remove(i); break; }
            }
            for (Integer i = 0; i < aeRows.size(); i++) aeRows[i].aeNo = i + 1;
        }
    }
    
    public void toggleAETable() {}
    
    public class ProductRow {
        public Integer srNo {get; set;}
        public String productName {get; set;}
        public String productType {get; set;}
        public String indication {get; set;}
        public String dose {get; set;}
        public String frequency {get; set;}
        public String route {get; set;}
        public String lotNumber {get; set;}
        public Date expiryDate {get; set;}
        public Date therapyStartDate {get; set;}
        public Date therapyEndDate {get; set;}
        public String pickupStatus {get; set;}
        public String technicalComplaint {get; set;}
        public String technicalComplaintNumber {get; set;}
        public String technicalComplaintDescription {get; set;}
        public New_Potential_Adverse_Event__c productObj {get; set;}
        public ProductRow(Integer srNo) {
            this.srNo = srNo; this.productName = ''; this.productType = ''; this.indication = '';
            this.pickupStatus = 'Unknown'; this.technicalComplaint = 'Unknown';
            this.productObj = new New_Potential_Adverse_Event__c();
        }
    }
    
    public class AERow {
        public Integer aeNo {get; set;}
        public String eventName {get; set;}
        public Date startDate {get; set;}
        public Date endDate {get; set;}
        public String outcome {get; set;}
        public AERow(Integer no) { this.aeNo = no; this.eventName = ''; this.outcome = 'Unknown'; }
    }

    public Integer selectedRowIndex {get; set;}
    public ProductRow selectedRow {get; set;}
    public void showDetails() {
        if (selectedRowIndex != null && selectedRowIndex > 0 && selectedRowIndex <= rows.size()) {
            selectedRow = rows[selectedRowIndex - 1];
        }
    }
    public void saveDetails() {}
    
    public PageReference saveAllData() {
        try {
            mainAE.Death__c = seriousnessDeath;
            mainAE.Life_Threatening__c = seriousnessLifeThreatening;
            mainAE.Disability__c = seriousnessDisability;
            mainAE.Hospitalization__c = seriousnessHospitalization;
            mainAE.Congenital_Anomaly__c = seriousnessCongenitalAnomaly;
            mainAE.Other_Seriousness__c = seriousnessOther;
            mainAE.Event_Description__c = eventDescription;
            mainAE.Relevant_Medical_History__c = relevantMedicalHistory;

            if(!rows.isEmpty()) {
                // Mirror first row to parent for convenience
                ProductRow r = rows[0];
                mainAE.Product_Name__c = r.productName;
                mainAE.Product_Type__c = r.productType;
                mainAE.Product_Indication__c = r.indication;
                mainAE.Dose__c = r.dose;
                mainAE.Frequency__c = r.frequency;
                mainAE.Route_of_administering__c = r.route;
                mainAE.Lot_Number__c = r.lotNumber;
                mainAE.Expiry_Date__c = r.expiryDate;
                mainAE.Therapy_Start_Date__c = r.therapyStartDate;
                mainAE.Therapy_End_Date__c = r.therapyEndDate;
                mainAE.Pickup_Status__c = r.pickupStatus;
                mainAE.Is_Technical_Complaint__c = r.technicalComplaint;
                mainAE.Technical_Complaint_Desc__c = r.technicalComplaintDescription;
                mainAE.Technical_Complaint_Number__c = r.technicalComplaintNumber;
                mainAE.MICC_Product_Link__c = r.productObj.MICC_Product_Link__c;
            }
            insert mainAE;
            
            // Save Multiple Products
            List<AE_Product__c> productRecords = new List<AE_Product__c>();
            for(ProductRow pr : rows) {
                if(String.isNotBlank(pr.productName) || pr.productObj.MICC_Product_Link__c != null) {
                    AE_Product__c childProd = new AE_Product__c();
                    childProd.New_Potential_Adverse_Event__c = mainAE.Id;
                    childProd.Name = String.isNotBlank(pr.productName) ? pr.productName : 'Product';
                    childProd.Dose__c = pr.dose;
                    childProd.Frequency__c = pr.frequency;
                    childProd.Route_of_administering__c = pr.route;
                    childProd.Lot_Number__c = pr.lotNumber;
                    childProd.Expiry_Date__c = pr.expiryDate;
                    childProd.Therapy_Start_Date__c = pr.therapyStartDate;
                    childProd.Therapy_End_Date__c = pr.therapyEndDate;
                    childProd.Product_pickup_availability_status_is__c = pr.pickupStatus;
                    childProd.Is_this_a_technical_complaint__c = pr.technicalComplaint;
                    childProd.Technical_complaint__c = pr.technicalComplaintDescription;
                    productRecords.add(childProd);
                }
            }
            if(!productRecords.isEmpty()) insert productRecords;
            
            // Save Individual Adverse Events
            if (addIndividualEventsFlag && !aeRows.isEmpty()) {
                List<AE_Individual_Event__c> childEvents = new List<AE_Individual_Event__c>();
                for (AERow ae : aeRows) {
                    if (String.isNotBlank(ae.eventName)) {
                        AE_Individual_Event__c child = new AE_Individual_Event__c();
                        child.New_Potential_Adverse_Event__c = mainAE.Id;
                        child.Name = ae.eventName;
                        child.AE_Start_Date__c = ae.startDate;
                        child.AE_End_Date__c = ae.endDate;
                        child.Outcome__c = ae.outcome;
                        childEvents.add(child);
                    }
                }
                if (!childEvents.isEmpty()) insert childEvents;
            }
            
            return new PageReference('/' + mainAE.Id);
        } catch (Exception e) { ApexPages.addMessages(e); return null; }
    }
}