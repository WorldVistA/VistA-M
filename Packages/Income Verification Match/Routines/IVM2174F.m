IVM2174F ;ALB/JAM - IVM*2.0*174 - FIX BLANK SSN IN PERSON INCOME FILE ;9/26/2018 3:21pm
 ;;2.0;INCOME VERIFICATION MATCH;**174**;21-OCT-94;Build 15
 ;
 Q
EP ; Entry Point
 Q
IVMFSSN(DFN,IVMJOB) ; Process only ZDP segments to store SSNs into 408.13 file if IEN is in ^XTMP("DG53970P")
 ; Called by: ^IVMCM if DFN is defined in ^XTMP("DG53970P") when processing ORU-Z10 message
 ;
 ; Input:   DFN - Patient DFN from the ORU-Z10 PID
 ;          IVMJOB - job number in ^XTMP("DG53970P",JOB)
 ;
 N IVMCTR,IVMSEG,IVMVAL,IEN,IVMIEN,IVMFOUND,IVMIENCNT
 ; spouse segment
 S IVMSEG=$G(^TMP($J,"IVMCM","ZDPS"))
 I IVMSEG'="" D FILESSN(DFN,IVMJOB,IVMSEG)
 ; inactive spouse segments
 S IVMCTR=0
 F  S IVMCTR=$O(^TMP($J,"IVMCM","ZDPIS",IVMCTR)) Q:(IVMCTR="")  D
 . S IVMSEG=$G(^TMP($J,"IVMCM","ZDPIS",IVMCTR)) Q:IVMSEG=""
 . D FILESSN(DFN,IVMJOB,IVMSEG)
 ; dependent segments
 S IVMCTR=0
 F  S IVMCTR=$O(^TMP($J,"IVMCM","ZDPC",IVMCTR)) Q:(IVMCTR="")  D
 . S IVMSEG=$G(^TMP($J,"IVMCM","ZDPC",IVMCTR)) Q:IVMSEG=""
 . D FILESSN(DFN,IVMJOB,IVMSEG)
 ; inactive dependent segments
 S IVMCTR=0
 F  S IVMCTR=$O(^TMP($J,"IVMCM","ZDPIC",IVMCTR)) Q:(IVMCTR="")  D
 . S IVMSEG=$G(^TMP($J,"IVMCM","ZDPIC",IVMCTR)) Q:IVMSEG=""
 . D FILESSN(DFN,IVMJOB,IVMSEG)
 ; All ZDP segments processed
 ; If all IENs related to the DFN are gone from ^XTMP, remove the DFN from ^XTMP
 S IVMFOUND=0
 ; For the DFN, loop over ALL the dependent IENs in the 408.12 file "B" index
 S IEN="" F  S IEN=$O(^DGPR(408.12,"B",DFN,IEN)) Q:'IEN  D  Q:IVMFOUND
 . ; get the related 408.13 IEN
 . S IVMVAL=$P(^DGPR(408.12,IEN,0),"^",3)
 . I $P(IVMVAL,";",2)'="DGPR(408.13," Q
 . S IVMIEN=$P(IVMVAL,";",1)
 . S IVMIENCNT=0
 . ; If IVMIEN is in ^XTMP("DG53970P",IVMJOB,"SSN",count)=IVMIEN set flag
 . F  S IVMIENCNT=$O(^XTMP("DG53970P",IVMJOB,"SSN",IVMIENCNT)) Q:'IVMIENCNT  I ^XTMP("DG53970P",IVMJOB,"SSN",IVMIENCNT)=IVMIEN S IVMFOUND=1 Q
 ; If no IENs found, clear the DFN out of the ^XTMP global
 I 'IVMFOUND K ^XTMP("DG53970P",IVMJOB,"DFN",DFN)
 Q
FILESSN(DFN,IVMJOB,IVMSEG) ; Check segment and store SSN in 408.13 if criteria met
 ; Input:   DFN - DFN from PID segment
 ;          IVMJOB - job number in ^XTMP("DG53970P",JOB) 
 ;          IVMSEG - the ZDPS or ZDPC segment
 N IVMPRI,IVMVAL,IVMIEN,IVMFOUND,IVMIENCNT,IVMSSN,IVMPSSNR,IVMFLG1,IVMERR
 N IVMSEX,IVMSEX13,IVMDOB,IVMDOB13,IVMRELN,IVMRELO
 N FDA,IVMERRORS,DIERR
 S IVMRELN=$P(IVMSEG,"^",6)
 ; skip segment if RELATIONSHIP is SELF
 Q:IVMRELN=1
 S IVMPRI=$P(IVMSEG,"^",7) ; ien of patient relation file 408.12
 ; if IEN not supplied, derive it by looping over dependents in 408.12 file
 I IVMPRI="" D
 . ; get Sex and DOB from segment
 . S IVMSEX=$P(IVMSEG,"^",3),IVMDOB=$$FMDATE^HLFNC($P(IVMSEG,"^",4))
 . S IVMFLG1=0
 . ; loop over dependents for this DFN in the 408.12 file
 . S IVMPRI=0 F  S IVMPRI=$O(^DGPR(408.12,"B",DFN,IVMPRI)) Q:'IVMPRI  D  Q:IVMFLG1
 . . ; Get Relationship, DOB, and Sex from income person file 408.13
 . . D GETIP(IVMPRI,.IVMRELO,.IVMDOB13,.IVMSEX13)
 . . Q:(IVMRELO=1)  ; quit if RELATIONSHIP is SELF
 . . ; match sex, dob and relationship from segment with values from 408.13 file 
 . . I (IVMSEX=IVMSEX13)&(IVMDOB=IVMDOB13)&(IVMRELN=IVMRELO) S IVMFLG1=1   ; Match - found dependent in 408.13.
 ; If dependent IEN from 408.12 file not defined - Quit
 Q:IVMPRI=""
 ; get the related 408.13 IEN
 S IVMVAL=$P(^DGPR(408.12,IVMPRI,0),"^",3)
 I $P(IVMVAL,";",2)'="DGPR(408.13," Q
 S IVMIEN=$P(IVMVAL,";",1) ; ien of income person file 408.13
 S IVMFOUND=0,IVMIENCNT=0
 ; loop over IENs in ^XTMP to see if IVMIEN is there
 F  S IVMIENCNT=$O(^XTMP("DG53970P",IVMJOB,"SSN",IVMIENCNT)) Q:'IVMIENCNT  I ^XTMP("DG53970P",IVMJOB,"SSN",IVMIENCNT)=IVMIEN S IVMFOUND=1 Q
 Q:'IVMFOUND
 ; IVMIEN is the IEN that needs the SSN updated in 408.13 - ^DGPR(408.13,IEN,0) piece 9
 S IVMSSN=$P(IVMSEG,"^",5) ;SSN
 ; Validate the SSN and if not valid, place the error in the ^XTMP global and quit
 S IVMERR=""
 I '$$VALSSN(IVMSSN,.IVMERR) S ^XTMP("DG53970P",IVMJOB,"SSNERR",IVMIEN)=$G(IVMERR) Q
 ; strip dashes
 S IVMSSN=$TR(IVMSSN,"-")
 ; check for Pseudo SSN
 S IVMPSSNR=$P(IVMSEG,"^",10) ;Pseudo SSN Reason
 ; If not valid value, set it to null
 I IVMPSSNR]"",IVMPSSNR'="R",IVMPSSNR'="S",IVMPSSNR'="N" S IVMPSSNR=""
 ; If there is a valid Pseudo SSN Reason, then append a "P" to the end
 ;  of the SSN so that it can be recognized on VistA as a pseudo
 I IVMPSSNR'="" S IVMSSN=$G(IVMSSN)_"P"
 ; Recheck the SSN field in 408.13 file and if corrupted, clean it up
 D CHKSSN(IVMIEN)
 ; Update the SSN - if not successful, place the error in the ^XTMP global and quit
 S FDA(408.13,IVMIEN_",",.09)=IVMSSN
 S FDA(408.13,IVMIEN_",",.1)=IVMPSSNR
 D FILE^DIE("K","FDA","IVMERRORS(1)")
 I +$G(DIERR) D  Q
 . S IVMERR=$G(IVMERRORS(1,"DIERR",1,"TEXT",1))
 . S ^XTMP("DG53970P",IVMJOB,"SSNERR",IVMIEN)=IVMERR
 ; update was successful, clean the IEN out of the ^XTMP global
 K ^XTMP("DG53970P",IVMJOB,"SSN",IVMIENCNT),^XTMP("DG53970P",IVMJOB,"SSNERR",IVMIEN)
 Q
VALSSN(X,ERROR) ; Validate the SSN format
 ; Input:  X - SSN to validate
 ;         ERROR - pass by reference, returns error text if validation fails
 ; Output: 1 if valid, 0 if invalid
 N CNT
 I X'?9N&(X'?3N1"-"2N1"-"4N) S ERROR="SSN must be either nine numbers, or be in the format nnn-nn-nnnn." Q 0
 ; strip dashes
 I X'?.AN F CNT=1:1:$L(X) I $E(X,CNT)?1P S X=$E(X,0,CNT-1)_$E(X,CNT+1,999),CNT=CNT-1
 I X'?9N S ERROR="Invalid format for SSN." Q 0
 I $E(X,1)=9 S ERROR="The SSN must not begin with 9." Q 0
 I $E(X,1,3)="000" S ERROR="First three digits of SSN cannot be zeros." Q 0
 Q 1
GETIP(IVMPRI,IVMRELO,IVMDOB13,IVMSEX13) ; Return 408.13 Sex,DOB,Relationship via 408.12 record
 ; Input: IVMPRI - IEN of 408.12 entry
 ;        IVMRELO - Relationship from 408.12 piece 2 (pass by ref)
 ;        IVMDOB13 - Date of Birth from 408.13 piece 3 (pass by ref)
 ;        IVMSEX13 - Sex from 408.13 piece 2  (pass by ref)
 N IVMPRN
 S IVMPRN=$G(^DGPR(408.12,+IVMPRI,0))
 S IVMRELO=$P(IVMPRN,"^",2)
 I IVMPRN']"" Q
 ; Quit if RELATIONSHIP is SELF
 Q:IVMRELO=1
 N IVMSEG13
 ; ivmseg13 is 0 node of income person file 408.13
 S IVMSEG13=$$DEM^DGMTU1(IVMPRI)
 I IVMSEG13']"" Q   ; Can't find 408.13 record
 ; get Sex and DOB from 408.13 file
 S IVMSEX13=$P(IVMSEG13,"^",2),IVMDOB13=$P(IVMSEG13,"^",3)
 Q
CHKSSN(IEN) ; Check to see if SSN IN 408.13 is corrupted and clean up if it is
 ; Input:  IEN - 408.13 ien
 N IVMSSN
 S IVMSSN=$P(^DGPR(408.13,IEN,0),"^",9)
 I IVMSSN=" "!(IVMSSN=" P") D
 . S $P(^DGPR(408.13,IEN,0),"^",9)=""
 . ; we have to assume the xrefs are bad and need to be cleaned up
 . D XREF(IEN)
 Q
XREF(IEN) ; clean "SSN", "BS" and "BS5" xrefs for this INCOME PERSON file (#408.13) record
 N VAL,XREF
 F XREF="SSN","BS","BS5" D
 . S VAL=""
 . F  S VAL=$O(^DGPR(408.13,XREF,VAL)) Q:VAL=""  D
 . . I $D(^DGPR(408.13,XREF,VAL,IEN)) K ^DGPR(408.13,XREF,VAL,IEN)
 Q
