DGENPTA1 ;ALB/CJM,EG,CKN,ERC,TDM,PWC,JAM,KUM - Patient API - File Data ;5/24/11 4:54pm
 ;;5.3;Registration;**121,147,314,677,659,653,688,810,754,838,841,842,978,1036,1064**;Aug 13,1993;Build 41
 ;
LOCK(DFN) ;
 ;Description: Given an internal entry number of a PATIENT  record, this
 ;   function will lock the record. It should be used when updating the
 ;   record.
 ;Input:
 ;  DFN - Patient IEN
 ;Output:
 ;  Function Value - Returns 1 if the lock was successful, 0 otherwise
 ;
 I $G(DFN) L +^DPT(DFN):2
 Q $T
UNLOCK(DFN) ;
 ;Description: Given an internal entry number of a record in the PATIENT
 ;   file, this function will unlock the record that was previously
 ;   locked by LOCK PATIENT RECORD.  
 ;Input:
 ;   DFN - Patient IEN
 ;Output: None
 ;
 I $G(DFN) L -^DPT(DFN)
 Q
 ;
STOREPRE(DFN,DGPREFAC) ;
 ;Description: Used to store the patient's preferred facility in the
 ;   patient record.
 ;Input:
 ;  DFN - Patient IEN
 ;  DGPREFAC - pointer to the record in the INSTITUTION file.
 ;Output:
 ;  Function Value - Returns 1 on success, 0 on failure.
 ;
 N SUCCESS,DATA
 S SUCCESS=1
 D  ;drops out if invalid condition found
 . I $G(DFN),$D(^DPT(DFN,0))
 . E  S SUCCESS=0 Q
 . I ($G(DGPREFAC)'=""),'$G(DGPREFAC) S SUCCESS=0 Q
 . I $G(DGPREFAC),'$D(^DIC(4,DGPREFAC,0)) S SUCCESS=0 Q
 . S DATA(27.02)=DGPREFAC
 . S DATA(27.03)="V"     ; DG*5.3*838
 . S SUCCESS=$$UPD^DGENDBS(2,DFN,.DATA)
 Q SUCCESS
 ;
CHECK(DGPAT,ERROR) ;
 ;Description: Does validation checks on the patient contained in the
 ;DGPAT array.
 ;
 ;Input:
 ;  DGPAT - this local array contains patient data
 ;Output:
 ;  Function Value - returns 1 if all validation checks passed, 0 otherwise
 ;  ERROR - if validation checks fail, an error message is returned (pass by reference)
 ;
 ;
 N SUCCESS,FIELD
 S SUCCESS=1
 S ERROR=""
 ;
 ;check field values
 ;
 ;some of the field's input transforms require DA or DUZ to be defined, so do not do this
 ;F  S SUB=$O(DGPAT(SUB)) Q:SUB=""  D:(DGPAT(SUB)'="")  Q:'SUCCESS
 ;.S FIELD=$$FIELD(SUB)
 ;.I '$$TESTVAL^DGENDBS(2,FIELD,DGPAT(SUB)) D
 ;..S SUCCESS=0
 ;..S ERROR="BAD FIELD VALUE, PATIENT FILE FIELD = "_$$GET1^DID(2,FIELD,,"LABEL")
 ;
 ;instead, check field values without referencing DD
 I DGPAT("INELDEC")'="",($L(DGPAT("INELDEC"))>75)!($L(DGPAT("INELDEC"))<3) S SUCCESS=0,ERROR="BAD FIELD VALUE, PATIENT FIELD FIELD = INELIGIBLE VARO DECISION" G QCHECK
 ;
 I DGPAT("INELREA")'="",($L(DGPAT("INELREA"))>40) S SUCCESS=0,ERROR="BAD FIELD VALUE, PATIENT FIELD FIELD = INELIGIBLE REASON" G QCHECK
 ;
 I DGPAT("VETERAN")="" S SUCCESS=0,ERROR="BAD FIELD VALUE, PATIENT FIELD = VETERAN (Y/N)?" G QCHECK
 ;
 I DGPAT("DEATH"),(DGPAT("DEATH")>$$NOW^XLFDT) S SUCCESS=0,ERROR="DATE OF DEATH CAN NOT BE A FUTURE DATE" G QCHECK
 ;
 I DGPAT("INELDATE"),(DGPAT("INELREA")="") S SUCCESS=0,ERROR="INELIGIBLE REASON UNSPECIFIED FOR INELIGIBLE PATIENT" G QCHECK
 ;
QCHECK ;
 Q SUCCESS
 ;
STORE(DGPAT,ERROR,NOCHECK) ;
 ;Description: Files data in the patient record.  It requires a lock
 ;on the Patient record, adn releases the lock when done.
 ;
 ;Input:
 ;  DGPAT- the patient array, passed by reference
 ;  NOCHECK - a flag, if set to 1 it means consistency checks were done aready, so skip
 ;
 ;Output:
 ;  Function Value - returns 1 if successful, otherwise 0
 ;  ERROR - on failure, an error message is returned (optional, pass by reference)
 ;
 S ERROR=""
 I '$D(DGPAT) S ERROR="PATIENT NOT FOUND" Q 0
 I '$$LOCK(DGPAT("DFN")) S ERROR="UNABLE TO LOCK THE PATIENT RECORD" Q 0
 I $G(NOCHECK)'=1 Q:'$$CHECK(.DGPAT,.ERROR) 0
 ;
 N DATA,SUB,FIELD,SUCCESS,DGINDID,DGINDAD,DGINDSD,DGINDED,DGINDARR
 S SUB=""
 ;
 ; DG*5.3*1064
 ; Check value in Patient file is changed, then only update
 D GETS^DIQ(2,DFN,".571:.574","I","DGINDARR")
 S DGINDID=$G(DGINDARR(2,DFN_",",.571,"I"))
 S DGINDAD=$G(DGINDARR(2,DFN_",",.573,"I"))
 S DGINDSD=$G(DGINDARR(2,DFN_",",.572,"I"))
 S DGINDED=$G(DGINDARR(2,DFN_",",.574,"I"))
 I DGINDID=DGPAT("INDID") K DGPAT("INDID")
 I DGINDAD=DGPAT("INDADT") K DGPAT("INDADT")
 I DGINDSD=DGPAT("INDSDT") K DGPAT("INDSDT")
 ; If Indian End Date is blank or double quotes, delete the field in Patient file
 I DGINDED'=DGPAT("INDEDT"),DGPAT("INDEDT")="" S DGPAT("INDEDT")="@"
 I DGINDED=DGPAT("INDEDT") K DGPAT("INDEDT")
 ;
 F  S SUB=$O(DGPAT(SUB)) Q:(SUB="")  I (SUB'="DEATH")&(SUB'="SSN") S FIELD=$$FIELD(SUB) I FIELD S DATA(FIELD)=$G(DGPAT(SUB))
 S SUCCESS=$$UPD^DGENDBS(2,DGPAT("DFN"),.DATA)
 I 'SUCCESS S ERROR="FILEMAN UNABLE TO UPDATE PATIENT RECORD"
 ; jam; dg*5.3*978 - 1010.1514 and 1010.1515 fields added to the ZIO segment (seq 7 and 10) - ORIG APPT REQUEST CHG DT/TM and APPT REQUEST ON 1010EZ CHG DT/TM
 ;   these are timestamps that may have been triggered by VistA filing the other 1010.* fields above.
 ;   So we set those values from the HL7 into the database now - after those others have been filed
 I SUCCESS,$D(DGPAT("APPREQTS")) D
 . N DATA,DGENDA
 . S DGENDA=DGPAT("DFN")
 . S DATA(1010.1515)=DGPAT("APPREQTS")
 . S SUCCESS=$$UPD^DGENDBS(2,.DGENDA,.DATA)
 . K DATA,DGENDA
 I SUCCESS,$D(DGPAT("ORIGAPPREQTS")) D
 . N DATA,DGENDA
 . S DGENDA=DGPAT("DFN")
 . S DATA(1010.1514)=DGPAT("ORIGAPPREQTS")
 . S SUCCESS=$$UPD^DGENDBS(2,.DGENDA,.DATA)
 . K DATA,DGENDA
 ;
 ; Call Purple Heart API to file PH data in file 2
 I SUCCESS,$D(DGPAT("PHI")) D EDITPH^DGRPLE($G(DGPAT("PHI")),$G(DGPAT("PHST")),$G(DGPAT("PHRR")),DGPAT("DFN"))
 ; Call POW API to file POW data in file 2 - DG*5.3*653
 ;I SUCCESS,$D(DGPAT("POWI")) D EDITPOW^DGRPLE($G(DGPAT("POWI")),$G(DGPAT("POWLOC")),$G(DGPAT("POWFDT")),$G(DGPAT("POWTDT")),DGPAT("DFN"))
 I SUCCESS D
 . I '$D(DGPAT("POWI")) D  Q
 . . N DATA,ERROR,DGENDA
 . . S DGENDA=DGPAT("DFN")
 . . S (DATA(.525),DATA(.526),DATA(.527),DATA(.528),DATA(.529))="@"
 . . I '$$UPD^DGENDBS(2,.DGENDA,.DATA,.ERROR) D
 . . . D ADDMSG^DGENUPL3(.MSGS,"Unable to update POW Data.",1)
 . . K DATA,ERROR,DGENDA
 . D EDITPOW^DGRPLE($G(DGPAT("POWI")),$G(DGPAT("POWLOC")),$G(DGPAT("POWFDT")),$G(DGPAT("POWTDT")),DGPAT("DFN"))
 D UNLOCK(DGPAT("DFN"))
 Q SUCCESS
 ;
FIELD(SUB) ;
 ;Description: Returns the field number of a subscript for the PATIENT object.
 ;
 N FNUM
 S FNUM=$S(SUB="DEATH":.351,SUB="PATYPE":391,SUB="VETERAN":1901,SUB="NAME":.01,SUB="DOB":.03,SUB="SEX":.02,SUB="SSN":.09,SUB="PREFAC":27.02,SUB="AG/ALLY":.309,1:"")
 S:'FNUM FNUM=$S(SUB="INELDATE":.152,SUB="INELREA":.307,SUB="INELDEC":.1656,SUB="PID":.363,SUB="EMGRES":.181,1:"")
 I FNUM="" S FNUM=$S(SUB="IR":.32103,SUB="RADEXPM":.3212,SUB="APPREQ":1010.159,SUB="APPREQDT":1010.1511,SUB="SPININJ":57.4,SUB="PFSRC":27.03,1:"")
 ; jam; DG*5.3*978 - these fields added to the ZIO segment (seq 8 and 9) - ORIGINAL APPOINTMENT REQUEST and ORIG APPT REQUEST DATE
 I FNUM="" S FNUM=$S(SUB="ORIGAPPREQ":1010.1512,SUB="ORIGAPPREQDT":1010.1513,1:"")
 I FNUM="" S FNUM=$S(SUB="MOH":.541,SUB="DENTC2IN":.3858,SUB="DENTC2DT":.3859,1:"")
 I FNUM="" S FNUM=$S(SUB="PENAEFDT":.3851,SUB="PENAREAS":.3852,SUB="PENTRMDT":.3853,1:"")
 I FNUM="" S FNUM=$S(SUB="PENTRMR1":.3854,SUB="PENTRMR2":.3855,SUB="PENTRMR3":.3856,SUB="PENTRMR4":.3857,SUB="PILOCK":.386,SUB="PALOCK":.3861,1:"")
 ; DG*5.3*1064
 I FNUM="" S FNUM=$S(SUB="INDID":.571,SUB="INDADT":.573,SUB="INDSDT":.572,SUB="INDEDT":.574,1:"")
 Q FNUM
