ORMARKER ; SLC/MIP,WAT - Use to get chart markers ;7/30/08  11:25
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**296**;Dec 17, 1997;Build 19
 ;;ICRs in use: #4156 $$CVEDT^DGCV, #10061 ^VADPT API
CV(RVAL,DFN) ;Combat Vet Marker
 N CVE S CVE=$$CVEDT^DGCV(DFN)
 I ($P(CVE,"^",1)'=1)!($P(CVE,"^",3)=0) S RVAL(0)="NOTCV" Q
 N VASV
 D SVC^VADPT
 ;Service Branch
 S RVAL(0)=""
 I $D(VASV(6,1))=1 S RVAL(0)=VASV(6,1)
 ;Status
 S RVAL(1)=""
 I $D(VASV(6,3))=1 S RVAL(1)=VASV(6,3)
 ;Service Seperation Date
 S RVAL(2)=""
 I $D(VASV(6,5))=1 S RVAL(2)=VASV(6,5)
 ;Combat Vet Expiration Date
 S RVAL(3)=""
 I $D(VASV(10,1))=1 S RVAL(3)=VASV(10,1)
 ;OIF/OEF
 S RVAL(4)=""
 I (VASV(11)>0)!(VASV(12)>0)!(VASV(13)>0) S RVAL(4)="OEF/OIF"
 ;Remove these later, put these sets for temporary backwards compatiblity
 S RVAL(5)=""
 S RVAL(6)=""
 S RVAL(7)=""
 ;Clean up VADPT variables
 D KVA^VADPT
 Q
