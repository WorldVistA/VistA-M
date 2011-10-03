RORX005B ;HCIOFO/BH,SG - INPATIENT UTILIZATION (SORT) ; 9/14/05 9:30am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** CALCULATES MEDIAN LENGTHS OF STAY
 ;
 ; NODE          Closed root of the category section
 ;               in the temporary global
 ;
 ; FSUM          Update the summary data (0/1)
 ;
MLOS(NODE) ;
 N BSID,TMP,XREFNODE
 ;--- Median length of the whole stays
 S XREFNODE=$NA(@NODE@("IPMLOS",0))
 S TMP=$$XREFMDNV^RORXU004(XREFNODE,+$G(@NODE@("IPS")))
 S (@NODE@("IPMLOS"),@NODE@("IPMLOS",0))=TMP
 ;--- Median lengths of the bed section stays
 S BSID=""
 F  S BSID=$O(@NODE@("IPMLOS",BSID))  Q:BSID=""  D:BSID
 . S XREFNODE=$NA(@NODE@("IPMLOS",BSID))
 . S TMP=+$G(@NODE@("IPB",BSID,"S"))
 . S @NODE@("IPMLOS",BSID)=$$XREFMDNV^RORXU004(XREFNODE,TMP)
 Q
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SORT() ;
 N BSID,FILE,IENS,NAME,NODE,RC,RORMSG,TMP
 S NODE=$NA(^TMP("RORX005",$J))  Q:$D(@NODE)<10 0
 ;--- Bed sections
 S RC=$$LOOP^RORTSK01(0)  Q:RC<0 RC
 S BSID=""
 F  S BSID=$O(@NODE@("IPB",BSID))  Q:'BSID  D
 . D:BSID>0
 . . S IENS=(+BSID)_",",FILE=+$P(BSID,";",2)
 . . S NAME=$$GET1^DIQ(FILE,IENS,.01,,,"RORMSG")
 . . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,FILE,IENS)
 . . S:NAME?." " NAME="Unknown ("_BSID_")"
 . . S @NODE@("IPB","B",NAME,BSID)=""
 ;--- Median length of stay
 S RC=$$LOOP^RORTSK01(0.5)  Q:RC<0 RC
 D MLOS(NODE)
 ;---
 Q 0
 ;
 ;***** CALCULATES THE INTERMEDIATE TOTALS
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TOTALS(PATIEN) ;
 N NODE,TMP
 S NODE=$NA(^TMP("RORX005",$J))
 ;
 ;=== Inpatient data
 D:$D(@NODE@("IP",PATIEN))>1
 . N DAYS,STAYS,VISITS
 . S @NODE@("IP",PATIEN)=RORLAST4
 . S @NODE@("IP")=$G(@NODE@("IP"))+1
 . S STAYS=+$G(@NODE@("IP",PATIEN,"S"))
 . S DAYS=+$G(@NODE@("IP",PATIEN,"D"))
 . S VISITS=+$G(@NODE@("IP",PATIEN,"V"))
 . ;--- Number of stays
 . D:(STAYS>0)!(VISITS>0)
 . . S @NODE@("IPS")=$G(@NODE@("IPS"))+STAYS
 . . S @NODE@("IPS",STAYS)=$G(@NODE@("IPS",STAYS))+1
 . . S @NODE@("IPS",STAYS,RORPNAME,PATIEN)=""
 . ;--- Number of days
 . D:(DAYS>0)!(VISITS>0)
 . . S @NODE@("IPD")=$G(@NODE@("IPD"))+DAYS
 . . S @NODE@("IPD",DAYS)=$G(@NODE@("IPD",DAYS))+1
 . . S @NODE@("IPD",DAYS,RORPNAME,PATIEN)=""
 . ;--- Number of short stays (visits)
 . D:VISITS>0
 . . S @NODE@("IPV")=$G(@NODE@("IPV"))+VISITS
 Q 0
