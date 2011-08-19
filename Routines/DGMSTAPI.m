DGMSTAPI ;ALB/SCK - API's for Military Sexual Trauma ; 2/28/02 4:56pm
 ;;5.3;Registration;**195,243,308,353,379,443,700**;Aug 13, 1993
 Q
 ;
GETSTAT(DFN,DGDATE) ;  Retrieves the current MST status for a patient
 ;
 ;  Input
 ;    DFN  - IEN of patient in the PATIENT File (#2)
 ;    DGDATE - Date for status lookup [OPTIONAL]
 ;
 ;  Output
 ;    DGMST - Format will depend on result of lookup
 ;
 ;    If an entry is found then:
 ;       DGMST returns a 7 piece data string, caret(^)-delimited:
 ;        $P(1) = IEN of entry in MST HISTORY File (#29.11)
 ;        $P(2) = Internal value of MST Status ("Y,N,D,U")
 ;        $P(3) = Date of status change
 ;        $P(4) = IEN of provider making determination, file (#200)
 ;        $P(5) = IEN of user who entered status, file (#200)
 ;        $P(6) = External format of MST Status
 ;        $P(7) = IEN pointer of the INSTITUTION file (#4)
 ;
 ;    If no MST History is found, then:
 ;       DGMST = 0^U
 ;                "U" = (Unknown)
 ;    If an error occured in the GETS^DIQ lookup, then:
 ;       DGMST = -1^^Error Code IEN
 ;                   (returned by GETS^DIQ call)
 ;
 ; Get most recent MST status entry for the patient from file using
 ;  reverse $Order on the "APDT" x-ref.
 ;
 N DGMST,DGIEN,DGFDA,DGMSG
 S DFN=$G(DFN)
 I '+DFN!('$D(^DPT(DFN,0))) D  G STATQ
 . S DGMST="-1"
 I '$D(^DGMS(29.11,"APDT",DFN))  D  G STATQ
 .S DGMST="0^U"
 S DGDATE=$S(+$G(DGDATE)>0:DGDATE,1:$$NOW^XLFDT)
 I '$D(^DGMS(29.11,"APDT",DFN,DGDATE)) S DGDATE=$$DATE(DFN,DGDATE)
 I '+DGDATE D  G STATQ
 . S DGMST="0^U"
 S DGIEN=""
 S DGIEN=+$P($Q(^DGMS(29.11,"APDT",DFN,DGDATE,DGIEN),-1),",",5)
 ;
 ; Check for valid ien, if entry missing, return Unknown
 I +DGIEN'>0 D  G STATQ
 . S DGMST="0^U"
 ;
 ; Retrieve data
 D GETS^DIQ(29.11,+DGIEN_",","*","IE","DGFDA","DGMSG")
 ; check for errors
 I $D(DGMSG) D  G STATQ
 .S DGMST="-1^^"_$G(DGMSG("DIERR",1))
 ;
 S DGMST=DGIEN_U_$G(DGFDA(29.11,+DGIEN_",",3,"I"))_U_$G(DGFDA(29.11,+DGIEN_",",.01,"I"))_U_$G(DGFDA(29.11,+DGIEN_",",4,"I"))_U_$G(DGFDA(29.11,+DGIEN_",",5,"I"))
 S DGMST=DGMST_U_$G(DGFDA(29.11,+DGIEN_",",3,"E"))
 S DGMST=DGMST_U_$S($G(DGFDA(29.11,+DGIEN_",",6,"I"))]"":$G(DGFDA(29.11,+DGIEN_",",6,"I")),1:$$SITE)
 ;
STATQ Q $G(DGMST)
 ;
NEWSTAT(DFN,DGSTAT,DGDATE,DGPROV,DGSITE,DGXMIT) ; MST HISTORY (#29.11) filer
 ; Callpoint to create a new MST HISTORY FILE (#29.11) entry.
 ; Will also queue HL7 message for HEC database updates.
 ;
 ;  Input
 ;    DFN    - Patients DFN
 ;    DGSTAT - MST Status code, "Y,N,D,U"
 ;    DGDATE - Date of MST status change  [default=NOW]
 ;    DGPROV - IEN of Provider making determination, file (#200)
 ;    DGSITE - IEN pointer of the INSTITUTION file (#4)
 ;    DGXMIT - HL7 transmit flag [OPTIONAL]
 ;              0=don't queue a message
 ;              1=queue a message [default])
 ;
 ;  Output
 ;    DGRSLT - Returns IEN of file (#29.11) entry if successful
 ;
 ;    If no patient was defined, then:
 ;       DGRSLT = -1^No patient defined
 ;
 ;    If an error occured in the GETS^DIQ lookup, then:
 ;       DGMST = -1^^Error Code IEN
 ;                   (returned by GETS^DIQ call)
 ;
 N DGFDA,DGMSG,DGERR,DGRSLT,MSTIEN
 S DFN=$G(DFN)
 I DFN']""!('$D(^DPT(DFN,0))) D  G NEWQ
 . S DGRSLT="-1^No patient defined"
 ;
 S DGSTAT=$S($G(DGSTAT)]"":DGSTAT,1:"U")
 S DGDATE=$G(DGDATE)
 S DGPROV=$G(DGPROV)
 S DGSITE=$G(DGSITE)
 S DGXMIT=$S($G(DGXMIT)=0:DGXMIT,1:1)
 S DGDATE=$S(+DGDATE>0:DGDATE,1:$$NOW^XLFDT)
 S DGSITE=$S(+DGSITE>0:DGSITE,1:$$SITE)
 ;
 I '$$CHANGE(DFN,DGSTAT,DGDATE) D  G NEWQ
 . S DGRSLT="0"
 ;
 I '$$VALID(DFN,DGSTAT,DGDATE,DGPROV,DGSITE,.DGERR) D  G NEWQ
 . S DGRSLT="-1^"_DGERR
 ;
 S DGFDA(1,29.11,"+1,",.01)=DGDATE
 S DGFDA(1,29.11,"+1,",2)=DFN
 S DGFDA(1,29.11,"+1,",3)=DGSTAT
 S DGFDA(1,29.11,"+1,",4)=DGPROV
 S DGFDA(1,29.11,"+1,",5)=DUZ
 S DGFDA(1,29.11,"+1,",6)=DGSITE
 ;
 D UPDATE^DIE("","DGFDA(1)","MSTIEN","DGERR")
 I $D(DGERR) D  G NEWQ
 . S DGRSLT="-1^"_$G(DGERR("DIERR",1))
 ;
 S DGRSLT=+MSTIEN(1)
 ;
 ; Callpoint to queue an entry that will trigger a HEC
 ;  Enrollment Full Data Transmission (ORF/ORU~ZO7) HL7 message.
 ; The HL7 message will contain the following three MST data elments
 ;  as part of the VA-Specific Eligibility ZEL segment:
 ;   (23) - MST STATUS
 ;   (24) - DATE MST STATUS CHANGED
 ;   (25) - SITE DETERMINING MST STATUS
 ;
 I DGXMIT D
 . D SEND^DGMSTL1(DFN,"Z07")
 ;
NEWQ Q $G(DGRSLT)
 ;
DELMST(MSTIEN) ; Deletes the MST HISTORY File (#29.11) entry passed in.  
 ; This call is not to be used except from inside the DG MST List
 ; Manager interface.  
 ;
 ; Input
 ;    MSTIEN   - IEN of the entry in the MST HISTORY File (#29.11)
 ;
 ; Output
 ;    If no IEN passed in, return -1
 ;    otherwise return 1
 ;
 Q:'$G(MSTIEN) "-1^No entry to delete"
 ;
 N DA,XD
 S DA=+$G(MSTIEN)
 S DIK="^DGMS(29.11,"
 D ^DIK K DIK
 Q 1
 ;
NAME(DA) ; Returns name from the VA NEW PERSON File using DIQ call
 ;
 N DGNAME,DGPROV,DIQ,DR,DIC
 I $G(DA)="" G NAMEQ
 S DIC=200,DR=".01",DIQ="DGPROV"
 D EN^DIQ1
 S DGNAME=$G(DGPROV(200,DA,.01))
NAMEQ Q $G(DGNAME)
 ;
CHANGE(DFN,DGSTAT,DGDATE) ;Did the Status OR Date change?
 ;  Input
 ;      DFN    - Patients DFN
 ;      DGSTAT - MST Status code, "Y,N,D,U"
 ;      DGDATE - Date of MST Status Change (FM format)
 ;
 ;  Output
 ;      Returns 0 if no status change
 ;              1 if status changed
 ;
 N DGCHG,DGMST
 S DGCHG=0
 I +$G(DFN)'>0!('$D(^DPT(DFN,0))) G CHNGQ
 S DGSTAT=$G(DGSTAT)
 I DGSTAT'?1A!("YNDU"'[DGSTAT) G CHNGQ
 S DGDATE=$G(DGDATE)
 I DGDATE="" G CHNGQ
 S DGMST=$$GETSTAT(DFN),DGMST=$G(DGMST)
 I +DGMST<1!($P(DGMST,U,2)'=$G(DGSTAT))!($P(DGMST,U,3)'=$G(DGDATE)) S DGCHG=1
CHNGQ Q DGCHG
 ;
SITE(DGSITE) ;Convert a station number into a pointer to the
 ; INSTITUTION file (#4).  If called with a null parameter then
 ; the pointer to the INSTITUTION file (#4) of the primary site
 ; will be returned.
 ;
 ;  Input
 ;    DGSITE - Station number (optional)
 ;
 ;  Output
 ;    Return Site IEN to INSTITUTION file (#4)
 ;
 S DGSITE=$G(DGSITE)
 I DGSITE]"",$D(^DIC(4,"D",DGSITE)) D
 . S DGSITE=$O(^DIC(4,"D",DGSITE,0))
 E  D
 . S DGSITE=$P($$SITE^VASITE,U)
 I +DGSITE'>0 S DGSITE=""
 Q DGSITE
 ;
DATE(DFN,DGDT) ;Determine 'current' MST date
 ; 
 ;  Input
 ;    DFN  - Patient's DFN
 ;    DGDT - FileMan format date
 ;
 ;  Output
 ;    Return MST effective date
 ;
 N DGMSTDT
 S DFN=$G(DFN)
 I '+DFN D  G DATEQ
 . S DGMSTDT=""
 S DGDT=$S(+$G(DGDT)>0:DGDT,1:$$NOW^XLFDT)
 I $P(DGDT,".",2)="" S DGDT=DGDT_".999999"
 S DGMSTDT=$O(^DGMS(29.11,"APDT",DFN,DGDT),-1)
DATEQ Q DGMSTDT
 ;
VALID(DFN,DGSTAT,DGDATE,DGPROV,DGSITE,DGERR) ;Validate fields before filing
 ; Input:
 ;      DFN - [REQUIRED] - ien of Patient
 ;   DGSTAT - [REQUIRED] - MST Status code, "Y,N,D,U"
 ;   DGDATE - [REQUIRED] - Date of MST status change[FileMan Internal]
 ;   DGPROV - [optional] - IEN of Provider making determination
 ;   DGSITE - [optional] - IEN pointer of the INSTITUTION file
 ;    DGERR - [optional] - error parameter passed by reference
 ; Output:
 ;   Function Value - Returns 1 - if validation checks passed
 ;                            0 - if validation checks failed
 ;            DGERR - an error message if validation checks fail
 ; init variables
 N I,DGFILE,DGFLD,DGMSG,DGSTR,DGVAL,DGVAR,DGX,VALID
 S DGFILE=29.11,VALID=1,DGMSG=" IS REQUIRED"
 ; Quit DO block if invalid condition found
 ; Check for [REQUIRED] fields
 D
 . I DFN="" D MSG(DGFILE,2,DGMSG,.DGERR) Q        ;pat ien
 . I DGSTAT="" D MSG(DGFILE,3,DGMSG,.DGERR) Q     ;mst status code
 . I DGDATE="" D MSG(DGFILE,.01,DGMSG,.DGERR) Q   ;dt chg status
 .;
 .; Check for valid FIELD values
 . S DGMSG=" IS NOT VALID"
 .; need to strip off the 'seconds' to pass the CHK^DIE() call...
 . I DGDATE["." N DGSECS S DGSECS=$E($P(DGDATE,".",2),5,6) I DGSECS'="" I DGSECS<0!(DGSECS>60) D MSG(DGFILE,.01,DGMSG,.DGERR) Q
 . N DGDATEX S DGDATEX=DGDATE
 . I DGDATEX["." S DGDATEX=$P(DGDATEX,".")_"."_$E($P(DGDATEX,".",2),1,4)
 . I $E($P(DGDATEX,".",2),1,4)="0000" S DGDATEX=$P(DGDATEX,".")_".1"
 . S DGSTR=".01;DGDATEX^2;DFN^3;DGSTAT^4;DGPROV^5;DUZ^6;DGSITE"
 .;
 . F I=1:1:$L(DGSTR,U) S DGX=$P(DGSTR,U,I) Q:DGX=""  D  Q:'VALID
 .. S DGFLD=$P(DGX,";"),DGVAR=$P(DGX,";",2),DGVAL=@DGVAR
 .. Q:DGVAL=""
 .. S VALID=$$TESTVAL(DGFILE,DGFLD,DGVAL)
 .. D:'VALID MSG(DGFILE,DGFLD,DGMSG,.DGERR)
 Q VALID
 ;
MSG(DGFIL,DGFLD,DGMSG,DGERR) ; error message setup
 ; Input:
 ;   DGFIL - file number
 ;   DGFLD - field number of file
 ;   DGMSG - message type verbiage - " IS REQUIRED" or " IS NOT VALID"
 ;   DGERR - error parameter passed by reference
 ; Output:
 ;   DGERR - error message
 S DGERR=$$GET1^DID(DGFIL,DGFLD,,"LABEL")_DGMSG
 Q
 ;
TESTVAL(DGFIL,DGFLD,DGVAL) ; Determine if a field value is valid.
 ; Input:
 ;   DGFIL - file number
 ;   DGFLD - field number of file
 ;   DGVAL - field value to be validated
 ; Output:
 ;   Function value: Returns 1 if field is valid
 ;                           0 if validation fails
 N DGVALEX,DGRSLT,VALID
 S VALID=1
 I DGVAL'="" D
 . S DGVALEX=$$EXTERNAL^DILFD(DGFIL,DGFLD,"F",DGVAL)
 . I DGVALEX="" S VALID=0 Q   ; no external value, not valid
 . I $$GET1^DID(DGFIL,DGFLD,"","TYPE")'="POINTER" D
 .. D CHK^DIE(DGFIL,DGFLD,,DGVALEX,.DGRSLT) I DGRSLT="^" S VALID=0
 Q VALID
