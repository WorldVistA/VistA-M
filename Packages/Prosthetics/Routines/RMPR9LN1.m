RMPR9LN1 ;HOIFO/HNC -  FLEX FIELD SORT;9/18/02 11:38
 ;;3.0;PROSTHETICS;**90,75,60,125**;Feb 09, 1996;Build 21
 ;SPS - Patch 75 added DALC section at the end.
EN(RESULT) ;
 ;RESULT passed to broker in ^TMP($J,
 ;delimited by "^"
 K ^TMP($J)
 N RMPRII,RMPRLN
 S CNT=0
 F RMPRII=1:1 S RMPRLN=$P($T(HLST+RMPRII),";",4) Q:RMPRLN=""  D
 .S RMPRFLD=$P($T(HLST+RMPRII),";",3)
 .S CNT=CNT+1
 .S ^TMP($J,"RMPR",CNT)=RMPRLN_U_RMPRFLD
 S RESULT=$NA(^TMP($J))
 Q
HLST ;pick list
 ;;0;*** COMMON/PURCHASING ***
 ;;1;Date Item Added To PO
 ;;2;Type Of Transaction
 ;;4;Billing Item
 ;;10;Delivery Date
 ;;11;Form
 ;;12;Souce
 ;;14;Total Cost
 ;;16;Remarks
 ;;20;DELIVERY VERIFICATION DATE
 ;;20.1;DELIVERY VERIFICATION STATUS
 ;;23;Transaction Number or PO Number
 ;;24;Brief Description
 ;;25;Deliver To
 ;;26;Date Required
 ;;27;Initiator
 ;;38.1;Exclude/Waiver
 ;;38.7;Contract #
 ;;62;Patient Category
 ;;63;Special Category
 ;;34;OIF/OEF
 ;;78;Unit Of Issue
 ;;89;Saved Item Description
 ;;0;*** INVENTORY ***
 ;;4.6;Stock Issue Date
 ;;37;PIP Item Description
 ;;38;HCPCS PIP Description
 ;;0;*** PRODUCT INFORMATION ***
 ;;4.9;Coding Error Flag
 ;;4.91;Coding Flag Date
 ;;8.12;PCE
 ;;8.13;PCE Date
 ;;9;Serial Number
 ;;9.1;Product Description
 ;;9.2;Product Model
 ;;21;Lot Number
 ;;35;Who Edit 2319
 ;;36;Date of Edit 2319
 ;;0;*** SUSPENSE ***
 ;;8.1;Suspense Date
 ;;8.11;Suspense Station
 ;;8.14;Suspense Status
 ;;8.2;Date RX Written
 ;;8.3;Initial Action Date
 ;;8.4;Completion Date
 ;;8.5;Type of Request
 ;;8.6;Suspense Requestor
 ;;8.61;Consult Request Service
 ;;8.7;Provisional Diagnosis
 ;;8.8;Suspense ICD9
 ;;8.9;Consult Date
 ;;0;*** RETURNED ITEMS ***
 ;;13;Action
 ;;17;Returned Status
 ;;17.5;Retruned Status Date
 ;;0;*** ORTHO LAB ***
 ;;40;Lab Requesting Station
 ;;45;Total Lab Labor Hours
 ;;46;Total Lab Labor Cost
 ;;47;Total Lab Material Cost
 ;;48;Total Lab Cost
 ;;50;Lab Completion Date
 ;;51;Lab Remarks
 ;;69;Source of Procurement
 ;;70;Receiving Station
 ;;71;Work Order Number
 ;;72;2529-3 Date
 ;;4.92;HIGH TECH ITEM
 ;;72.5;FREE TEXT WO #
 ;;80;Lab Work for Other Station
 ;;81;NO ADMIN COUNT
 ;;0;*** DALC ***
 ;;89.1;DALC REFERENCE NUMBER
 ;;89.2;DALC BILLING DATE
 ;;89;DALC ITEM
 ;;4.2;WHO PLACED ORDER
 ;;89.3;DALC ORDERING STATION
 ;;90;DALC BILLING STATION
 ;;91;DALC VENDOR
 ;;92;DALC DUNS
 ;;93;DALC TAXID
 ;END
