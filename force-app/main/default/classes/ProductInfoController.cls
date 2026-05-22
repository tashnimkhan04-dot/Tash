public with sharing class PAE_ProductInfoController {

    public List<Map<String, Object>> productRows { get; set; }

    public PAE_ProductInfoController(ApexPages.StandardController sc) {
        productRows = new List<Map<String, Object>>();

        New_Potential_Adverse_Event__c pae = [
            SELECT Product_Info_JSON__c
            FROM New_Potential_Adverse_Event__c
            WHERE Id = :sc.getId()
            LIMIT 1
        ];

        if (String.isNotBlank(pae.Product_Info_JSON__c)) {
            List<Object> parsed =
                (List<Object>) JSON.deserializeUntyped(pae.Product_Info_JSON__c);

            Integer srNo = 1;

            for (Object obj : parsed) {
                Map<String, Object> sourceRow = (Map<String, Object>) obj;
                Map<String, Object> row = new Map<String, Object>();

                row.put('srNo', sourceRow.containsKey('srNo') ? sourceRow.get('srNo') : srNo);
                row.put('productName', sourceRow.get('productName'));
                row.put('productType', sourceRow.get('productType'));
                row.put('indication', sourceRow.get('indication'));
                row.put('dose', sourceRow.get('dose'));
                row.put('frequency', sourceRow.get('frequency'));
                row.put('route', sourceRow.get('route'));
                row.put('lotNumber', sourceRow.get('lotNumber'));
                row.put('expiryDate', sourceRow.get('expiryDate'));
                row.put('therapyStartDate', sourceRow.get('therapyStartDate'));
                row.put('therapyEndDate', sourceRow.get('therapyEndDate'));
                row.put('pickupStatus', sourceRow.get('pickupStatus'));

                String technicalComplaint = '';

                if (sourceRow.get('technicalComplaint') != null) {
                    technicalComplaint = String.valueOf(sourceRow.get('technicalComplaint'));
                } else {
                    if (sourceRow.get('technicalComplaintNumber') != null) {
                        technicalComplaint += String.valueOf(sourceRow.get('technicalComplaintNumber'));
                    }

                    if (sourceRow.get('technicalComplaintDescription') != null) {
                        if (technicalComplaint != '') {
                            technicalComplaint += ' - ';
                        }
                        technicalComplaint += String.valueOf(sourceRow.get('technicalComplaintDescription'));
                    }
                }

                row.put('technicalComplaint', technicalComplaint);

                if (row.get('productName') != null || row.get('productType') != null) {
                    productRows.add(row);
                    srNo++;
                }
            }
        }
    }
}
