ORY626 ;ISL/STAFF - Post-install for patch OR*3*626 ;09/22/24  07:12
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**626**;Dec 17, 1997;Build 19
 ;
POST ; post-init process
 N ORPGXFLG
 S ORPGXFLG=0
 D SET
 I 'ORPGXFLG D  Q
 .D MES^XPDUTL("Pharmacogenomics order checks setup successfully completed!")
 D MES^XPDUTL("***There was a problem setting up the Pharmacogenomics order***")
 D MES^XPDUTL("***checks. Please log a ServiceNow ticket for assistance.***")
 Q
 ;
SET ;Set up Pharmacogenomics order checks
 N ORERR,ORTEXT
 D MES^XPDUTL("Setting up the Pharmacogenomics order checks...")
 I '$D(^ORD(100.8,"B","PHARMACOGENOMICS HIGH")) D
 .S ^ORD(100.8,40,0)="PHARMACOGENOMICS HIGH"
 .S ^ORD(100.8,40,1,0)="^^3^3^"_DT_"^"
 .S ^ORD(100.8,40,1,1,0)="This Pharmacogenomic high level order check provides drug-gene "
 .S ^ORD(100.8,40,1,2,0)="guidance for appropriate drug therapy to help prevent patient harm "
 .S ^ORD(100.8,40,1,3,0)="and ensure effective treatments."
 .S ^ORD(100.8,"B","PHARMACOGENOMICS HIGH",40)=""
 .K ORERR D EN^XPAR("PKG","ORK PROCESSING FLAG","PHARMACOGENOMICS HIGH","E",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS HIGH order check to enabled."
 ..S ORTEXT(2)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 .K ORERR D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","PHARMACOGENOMICS HIGH","High",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS HIGH order check to high severity."
 ..S ORTEXT(2)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 .K ORERR D EN^XPAR("SYS","ORK EDITABLE BY USER","PHARMACOGENOMICS HIGH","N",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS HIGH order check to uneditable."
 ..S ORTEXT(2)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 I ORPGXFLG Q
 ;
 I '$D(^ORD(100.8,"B","PHARMACOGENOMICS MODERATE")) D
 .S ^ORD(100.8,41,0)="PHARMACOGENOMICS MODERATE"
 .S ^ORD(100.8,41,1,0)="^^3^3^"_DT_"^"
 .S ^ORD(100.8,41,1,1,0)="This Pharmacogenomic moderate level order check provides drug-gene "
 .S ^ORD(100.8,41,1,2,0)="guidance for appropriate drug therapy to help prevent patient harm and "
 .S ^ORD(100.8,41,1,3,0)="ensure effective treatments."
 .S ^ORD(100.8,"B","PHARMACOGENOMICS MODERATE",41)=""
 .K ORERR D EN^XPAR("PKG","ORK PROCESSING FLAG","PHARMACOGENOMICS MODERATE","E",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS MODERATE order check to enabled."
 ..S ORTEXT(2)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 .K ORERR D EN^XPAR("PKG","ORK CLINICAL DANGER LEVEL","PHARMACOGENOMICS MODERATE","Moderate",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS MODERATE order check to"
 ..S ORTEXT(2)="moderate severity."
 ..S ORTEXT(3)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 .K ORERR D EN^XPAR("SYS","ORK EDITABLE BY USER","PHARMACOGENOMICS MODERATE","N",.ORERR)
 .I +ORERR>0 D  S ORPGXFLG=1 Q
 ..K ORTEXT
 ..S ORTEXT(1)="Unable to set the PHARMACOGENOMICS MODERATE order check to"
 ..S ORTEXT(2)="to uneditable."
 ..S ORTEXT(3)="Please log a ServiceNow ticket for assistance."
 ..D MES^XPDUTL(.ORTEXT)
 Q
