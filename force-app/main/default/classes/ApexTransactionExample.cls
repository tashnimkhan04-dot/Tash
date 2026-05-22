if (rows != null && !rows.isEmpty()) {
    // Keep existing functionality - first row maps to AE fields
    adverseEvent.Product_Name__c = rows[0].productName;
    adverseEvent.Product_Type__c = rows[0].productType;
    
    // NEW - serialize all rows to JSON
    List<Map<String, Object>> productList = new List<Map<String, Object>>();
    for (ProductRow row : rows) {
        Map<String, Object> productMap = new Map<String, Object>();
        productMap.put('srNo', row.srNo);
        productMap.put('productName', row.productName);
        productMap.put('productType', row.productType);
        productMap.put('indication', row.indication);
        productMap.put('dose', row.dose);
        productMap.put('frequency', row.frequency);
        productMap.put('route', row.route);
        productMap.put('lotNumber', row.lotNumber);
        productMap.put('expiryDate', row.expiryDate != null ? String.valueOf(row.expiryDate) : null);
        productMap.put('therapyStartDate', row.therapyStartDate != null ? String.valueOf(row.therapyStartDate) : null);
        productMap.put('therapyEndDate', row.therapyEndDate != null ? String.valueOf(row.therapyEndDate) : null);
        productMap.put('pickupStatus', row.pickupStatus);
        productMap.put('technicalComplaint', row.technicalComplaint);
        productMap.put('technicalComplaintNumber', row.technicalComplaintNumber);
        productMap.put('technicalComplaintDescription', row.technicalComplaintDescription);
        productList.add(productMap);
    }
    adverseEvent.Product_Info_JSON__c = JSON.serialize(productList);
}
