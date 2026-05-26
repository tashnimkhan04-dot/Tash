public with sharing class PAE_ProductInfoController {
    public List<ProductRow> productRows { get; set; }
    public class ProductRow {
        public String srNo { get; set; }
        public String productName { get; set; }
        public String productType { get; set; }
        public String indication { get; set; }
        public String dose { get; set; }
        public String frequency { get; set; }
        public String route { get; set; }
        public String lotNumber { get; set; }
        public String expiryDate { get; set; }
        public String therapyStartDate { get; set; }
        public String therapyEndDate { get; set; }
        public String pickupStatus { get; set; }
        public String technicalComplaint { get; set; }
        public String technicalComplaintNumber { get; set; }
        public String technicalComplaintDescription { get; set; }
    }
    public PAE_ProductInfoController(ApexPages.StandardController sc) {
        productRows = new List<ProductRow>();
        New_Potential_Adverse_Event__c pae = [
            SELECT Product_Info_JSON__c
            FROM New_Potential_Adverse_Event__c
            WHERE Id = :sc.getId()
            LIMIT 1
        ];
        if (String.isNotBlank(pae.Product_Info_JSON__c)) {
            List<Object> parsed =
                (List<Object>) JSON.deserializeUntyped(pae.Product_Info_JSON__c);
            Integer counter = 1;
            for (Object obj : parsed) {
                Map<String, Object> sourceRow = (Map<String, Object>) obj;
                ProductRow row = new ProductRow();
                row.srNo = getStringValue(sourceRow, 'srNo');
                if (String.isBlank(row.srNo)) {
                    row.srNo = String.valueOf(counter);
                }
                row.productName = getStringValue(sourceRow, 'productName');
                row.productType = getStringValue(sourceRow, 'productType');
                row.indication = getStringValue(sourceRow, 'indication');
                row.dose = getStringValue(sourceRow, 'dose');
                row.frequency = getStringValue(sourceRow, 'frequency');
                row.route = getStringValue(sourceRow, 'route');
                row.lotNumber = getStringValue(sourceRow, 'lotNumber');
                row.expiryDate = getStringValue(sourceRow, 'expiryDate');
                row.therapyStartDate = getStringValue(sourceRow, 'therapyStartDate');
                row.therapyEndDate = getStringValue(sourceRow, 'therapyEndDate');
                row.pickupStatus = getStringValue(sourceRow, 'pickupStatus');
                row.technicalComplaint = getStringValue(sourceRow, 'technicalComplaint');
                row.technicalComplaintNumber = getStringValue(sourceRow, 'technicalComplaintNumber');
                row.technicalComplaintDescription = getStringValue(sourceRow, 'technicalComplaintDescription');
                if (String.isBlank(row.technicalComplaint)) {
                    if (!String.isBlank(row.technicalComplaintNumber) && !String.isBlank(row.technicalComplaintDescription)) {
                        row.technicalComplaint = row.technicalComplaintNumber + ' - ' + row.technicalComplaintDescription;
                    } else if (!String.isBlank(row.technicalComplaintNumber)) {
                        row.technicalComplaint = row.technicalComplaintNumber;
                    } else if (!String.isBlank(row.technicalComplaintDescription)) {
                        row.technicalComplaint = row.technicalComplaintDescription;
                    }
                }
                if (!String.isBlank(row.productName) || !String.isBlank(row.productType)) {
                    productRows.add(row);
                    counter++;
                }
            }
        }
    }
    private static String getStringValue(Map<String, Object> sourceRow, String keyName) {
        if (sourceRow != null && sourceRow.containsKey(keyName) && sourceRow.get(keyName) != null) {
            return String.valueOf(sourceRow.get(keyName));
        }
        return '';
    }
}
if (!notesList.isEmpty()) {
    String escalationNotes = '';
    for (MICC_Notes__c note : notesList) {
        String decryptedNote = MICC_UtilityClass.decrypt(note.Notes__c);
        escalationNotes += decryptedNote + '\n\n';
    }
    description = 'Escalation Notes:\n' + escalationNotes;
}
