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
        
        // Pre-fill Product Name and Type from the first MICC Product record on page load
        try {
            List<MICC_Product__c> miccList = [
                SELECT Id, Name, Product_Type__c
                FROM   MICC_Product__c
                ORDER BY CreatedDate ASC
                LIMIT  1
            ];
            if (!miccList.isEmpty()) {
                rows[0].productName                     = miccList[0].Name;
                rows[0].productType                     = miccList[0].Product_Type__c;
                rows[0].productObj.MICC_Product_Link__c = miccList[0].Id;
            }
        } catch (Exception e) { System.debug('MICC Product fetch failed: ' + e.getMessage()); }
    }

    public void handleAEReset() {
        if (!addIndividualEventsFlag) {
            aeRows = new List<AERow>{ new AERow(1) };
        }
    }

    public void fetchProductDetails() {
        try {
            String rowIdxStr = ApexPages.currentPage().getParameters().get('rowIdx');
            if (String.isNotBlank(rowIdxStr)) {
                Integer index = Integer.valueOf(rowIdxStr);
                ProductRow currentRow = rows[index - 1];
                if (String.isNotBlank(currentRow.productName)) {
                    List<MICC_Product__c> master = [SELECT Id, Name, Product_Type__c FROM MICC_Product__c WHERE Name = :currentRow.productName LIMIT 1];
                    if (!master.isEmpty()) {
                        currentRow.productObj.MICC_Product_Link__c = master[0].Id;
                        currentRow.productType = master[0].Product_Type__c;
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
        public AERow(Integer no) { this.aeNo = no; this.eventName = ''; this.outcome = 'unknown'; }
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

            if (!rows.isEmpty()) {
                ProductRow r = rows[0];
                mainAE.Product_Name__c               = r.productName;
                mainAE.Product_Type__c               = r.productType;
                mainAE.Product_Indication__c         = r.indication;
                mainAE.Dose__c                       = r.dose;
                mainAE.Frequency__c                  = r.frequency;
                mainAE.Route_of_administering__c     = r.route;
                mainAE.Lot_Number__c                 = r.lotNumber;
                mainAE.Expiry_Date__c                = r.expiryDate;
                mainAE.Therapy_Start_Date__c         = r.therapyStartDate;
                mainAE.Therapy_End_Date__c           = r.therapyEndDate;
                mainAE.Pickup_Status__c              = r.pickupStatus;
                mainAE.Is_Technical_Complaint__c     = r.technicalComplaint;
                mainAE.Technical_Complaint_Desc__c   = r.technicalComplaintDescription;
                mainAE.Technical_Complaint_Number__c = r.technicalComplaintNumber;
                mainAE.MICC_Product_Link__c          = r.productObj.MICC_Product_Link__c;
            }

            String caseId = ApexPages.currentPage().getParameters().get('caseId');
            if (String.isNotBlank(caseId)) {
                List<Case> cases = [SELECT Product_Indication__c FROM Case WHERE Id = :caseId LIMIT 1];
                if (!cases.isEmpty() && cases[0].Product_Indication__c != null) {
                    mainAE.Product_Indication__c = cases[0].Product_Indication__c;
                }
            }
            
            if (!aeRows.isEmpty()) {
                AERow ae = aeRows[0];
                mainAE.AE_Event_Name__c = ae.eventName;
                mainAE.AE_Start_Date__c = ae.startDate;
                mainAE.AE_End_Date__c   = ae.endDate;
                mainAE.Outcome__c       = ae.outcome;
            }

            insert mainAE;
            return new PageReference('/' + mainAE.Id);
        } catch (Exception e) { ApexPages.addMessages(e); return null; }
    }
}
