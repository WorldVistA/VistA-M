ORY374 ;ISL/TC - Post-install for patch OR*3*374 ;12/12/13  11:45
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**374**;Dec 17, 1997;Build 9
 ;
 ;
 ;
 ;
POST ; Initiate post-init processes
 D UPDTNOT
 Q
UPDTNOT ; Update Message Type & Description fields of Notification #76 to accommodate Inactive Provider scenario.
 N ORFDA,ORERROR,ORMSG,I
 D BMES^XPDUTL("Updating the MESSSAGE TYPE & DESCRIPTION fields of the DEA CERTIFICATE EXPIRED notification...")
 S ORFDA(100.9,"76,",.04)="PKG"
 S ORFDA(100.9,"76,",4)="Triggered by Outpatient Pharmacy when the prescriber's PKI certificate expires after "
 S ORFDA(100.9,"76,",4)=ORFDA(100.9,"76,",4)_"the order is submitted in CPRS, but prior to Pharmacy processing the order. "
 S ORFDA(100.9,"76,",4)=ORFDA(100.9,"76,",4)_"Also triggered when prescriber's Rx profile becomes inactive during processing."
 D FILE^DIE("K","ORFDA","ORERROR")
 I $D(ORERROR) D  Q
 .S ORMSG(1)=" "
 .S ORMSG(2)="ERROR: Unable to update the MESSAGE TYPE & DESCRIPTION fields."
 .S ORMSG(3)="VA FileMan Error #"_ORERROR("DIERR",1)_":"
 .F I=1:1:+$O(ORERROR("DIERR",1,"TEXT","A"),-1) D
 ..S ORMSG(I+3)=ORERROR("DIERR",1,"TEXT",I)
 .D BMES^XPDUTL(.ORMSG)
 Q
