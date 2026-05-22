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

                if (String.isBlank(row.technicalComplaint)) {
                    String tcNumber = getStringValue(sourceRow, 'technicalComplaintNumber');
                    String tcDesc = getStringValue(sourceRow, 'technicalComplaintDescription');

                    if (!String.isBlank(tcNumber) && !String.isBlank(tcDesc)) {
                        row.technicalComplaint = tcNumber + ' - ' + tcDesc;
                    } else if (!String.isBlank(tcNumber)) {
                        row.technicalComplaint = tcNumber;
                    } else if (!String.isBlank(tcDesc)) {
                        row.technicalComplaint = tcDesc;
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

<apex:page standardController="New_Potential_Adverse_Event__c"
           extensions="PAE_ProductInfoController"
           readOnly="true"
           showHeader="false"
           sidebar="false">

    <style>
        html,
        body {
            width: 100%;
            margin: 0;
            padding: 0;
            overflow-x: hidden;
            font-family: Arial, sans-serif;
            font-size: 11px;
        }

        .tableWrapper {
            width: 100%;
            max-width: 100%;
            overflow-x: auto;
            overflow-y: hidden;
            padding: 0;
            margin: 0;
        }

        .prodTable {
            width: 100%;
            min-width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        .prodTable th {
            background: #b7aca4;
            color: white;
            padding: 5px 4px;
            text-align: center;
            font-size: 10px;
            border: 1px solid #d58f82;
            white-space: normal;
            word-wrap: break-word;
        }

        .prodTable td {
            border: 1px solid #ddd;
            padding: 4px;
            text-align: center;
            font-size: 10px;
            background: #fff;
            white-space: normal;
            word-wrap: break-word;
        }

        .prodTable tr:nth-child(even) td {
            background: #f9f9f9;
        }

        .noData {
            color: #888;
            font-size: 11px;
            padding: 5px;
        }
    </style>

    <apex:outputPanel layout="block" rendered="{!productRows.size > 0}" style="width:100%;">
        <div class="tableWrapper">
            <table class="prodTable">
                <thead>
                    <tr>
                        <th>Sr No</th>
                        <th>Product</th>
                        <th>Product Type</th>
                        <th>Indication</th>
                        <th>Dose</th>
                        <th>Frequency</th>
                        <th>Route</th>
                        <th>Lot No</th>
                        <th>Expiry Date</th>
                        <th>Therapy Start</th>
                        <th>Therapy End</th>
                        <th>Pickup Status</th>
                        <th>Technical Complaint</th>
                    </tr>
                </thead>

                <tbody>
                    <apex:repeat value="{!productRows}" var="row">
                        <tr>
                            <td>{!row.srNo}</td>
                            <td>{!row.productName}</td>
                            <td>{!row.productType}</td>
                            <td>{!row.indication}</td>
                            <td>{!row.dose}</td>
                            <td>{!row.frequency}</td>
                            <td>{!row.route}</td>
                            <td>{!row.lotNumber}</td>
                            <td>{!row.expiryDate}</td>
                            <td>{!row.therapyStartDate}</td>
                            <td>{!row.therapyEndDate}</td>
                            <td>{!row.pickupStatus}</td>
                            <td>{!row.technicalComplaint}</td>
                        </tr>
                    </apex:repeat>
                </tbody>
            </table>
        </div>
    </apex:outputPanel>

    <apex:outputPanel layout="block" rendered="{!productRows.size == 0}" style="width:100%;">
        <p class="noData">No product information available.</p>
    </apex:outputPanel>

</apex:page>
