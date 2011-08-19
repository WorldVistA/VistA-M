EASMTL2 ;MIN/TCM ALB/SCK/AEG - AUTOMATED MEANS TEST LETTER - SEARCH ; 7/3/01
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**3,12,14,20,22,55**;MAR 15,2001
 ;
EN60 ; Entry point for inital 60-day letter search for candidates 
 N EASIEN,DFN,VADM,CNT,ANNVDT,EASLAST
 ;
 K ^TMP("EASERR",$J)
 S CNT=0 ; Initialize counter
 S ANNVDT=EASDT("ANV")
 ; Check for means test data to process, quit if none found
 Q:'$D(^DGMT(408.31,"B",ANNVDT))
 ;
 ; Retieve data for each Means Test entry being processed
 S EASIEN=0
 F  S EASIEN=$O(^DGMT(408.31,"B",ANNVDT,EASIEN)) Q:EASIEN'>0  D
 . ; Quit further processing if means test is not MEANS TEST type
 . Q:'$$GET1^DIQ(408.31,EASIEN,.019,"I")=1
 . S DFN=$$GET1^DIQ(408.31,EASIEN,.02,"I") ; get patient's DFN
 . ; Check conditions; if all passed, add new entry to worklist file, #713.2
 . Q:'DFN                         ; Safety check for DFN
 . Q:'$$CHKDFN(DFN,EASIEN)          ; Check for valid PATIENT File entry, **55**
 . Q:$$TEST(DFN)                  ; Quit if test patient
 . S EASLAST=$$LST^DGMTU(DFN)     ; Get last MT on file
 . Q:'(+EASLAST=EASIEN)  ; Not the latest MT record for patient
 . Q:"L,N"[$P(EASLAST,U,4)        ; Quit, patient no longer requires means test (No Longer Applicable or No Longer Required)
 . Q:$$DECEASED^EASMTUTL("",DFN)  ; Quit if patient deceased
 . ;  If passed through all condition checks, update files
 . Q:$$CHKSTAT(EASIEN,DFN)         ; Check current MT status
 . Q:$$FUTURE(DFN)  ; Quit if a future means test is on file
 . D NEWSTAT(DFN,.EASPT)
 . Q:EASPT'>0  ; Safety check
 . Q:'$$NEWLTR(EASPT,.EASDT)  ; Quit if letter status was not updated
 . ; Finally, Update the counters
 . S CNT=CNT+1
 S EAS6CNT(EASPRCDT)=CNT,EAS6CNT=EAS6CNT+CNT
 D ERRMSG
 K ^TMP("EASERR",$J),^TMP("EASBDPTR",$J)
 Q
 ;
NEWLTR(EASPT,EASDT) ; Add new entry to the work list file #713.2.
 ; Input
 ;   EASPT  - Ptr to 713.1 file
 ;   EASDT  - Worklist date array
 ;
 ; Output
 ;   RSLT   - 1 if new letter status entry added
 ;            0 if new letter status was not added
 ;
 N ANNVDT,FDA,RSLT
 ;
 S ANNVDT=EASDT("ANV")
 ;
 ; Check for an existing entry for patient and anniversary date
 I $D(^EAS(713.2,"AN",EASPT,ANNVDT)) Q 0 ; Quit if duplicate entry
 ;
 ; Add new entry to the letter status file, #713.2
 S FDA(1,713.2,"+1,",.01)=EADT
 S FDA(1,713.2,"+1,",2)=EASPT
 S FDA(1,713.2,"+1,",3)=ANNVDT
 S FDA(1,713.2,"+1,",4)=0
 S FDA(1,713.2,"+1,",8)=EASDT("60")
 S FDA(1,713.2,"+1,",11)=EASDT("30")
 S FDA(1,713.2,"+1,",17)=EASDT("0")
 S FDA(1,713.2,"+1,",9)=1
 ; Modification for DCD sites which are required to print only the 0-day letters
 ;; EAS*1*12
 I $$VERSION^XPDUTL("IVMC"),$G(DT)'>3021014 D
 . K FDA(1,713.2,"+1,",9)
 . S FDA(1,713.2,"+1,",18)=1
 ; ***
 D UPDATE^DIE("","FDA(1)","","ERRMSG")
 Q 1
 ;
UPDLTR(EAS1,TYPE) ; Update Flagged to print field for letter type
 ; Input
 ;   EAS1  - Ptr to file 713.2
 ;   TYPE  - Letter type (1:60d, 2:30d, 4:0d)
 ;
 N DGFDA,ERRMSG
 ;
 S DGFDA(1,713.2,EAS1_",",$S(TYPE=2:12,1:18))=1
 D UPDATE^DIE("","DGFDA(1)","","ERRMSG")
 Q
 ;
NEWSTAT(DFN,EASPT) ; Update the Patient status file, #713.1
 ; Input
 ;   DFN   - Patient's DFN
 ;   EASPT - Return Var, New IEN to 713.1 file
 ;
 N EASIEN,DGFDA,FDAIEN,ERROUT
 ;
 ; Create new entry in the patient status file
 ;
 I '$D(^EAS(713.1,"B",DFN)) D  Q
 . S DGFDA(1,713.1,"+1,",.01)=DFN
 . S DGFDA(1,713.1,"+1,",2)=0
 . D UPDATE^DIE("","DGFDA(1)","FDAIEN","ERROUT(1)")
 . I $D(ERROUT) D
 . . S ^TMP("EASERR",$J,DFN)=ERROUT(1,"DIERR",1)_" - "_ERROUT(1,"DIERR",1,"TEXT",1)
 . . S:+$G(FDAIEN(1))'>0 ^TMP("EASERR",$J,DFN)="Unable to generate entry in EAS MT PATIENT STATUS File, #713.1"
 . S EASPT=+$G(FDAIEN(1))
 ;
 I $D(^EAS(713.1,"B",DFN)) D
 . Q:'DFN
 . S EASPT=$O(^EAS(713.1,"B",DFN,0))
 Q
 ;
PRNTDT(EARY,ETYPE) ; Retrieve Print date and flagged to print status for letter type
 ; Input
 ;    EARY  - Data array from Patient Status file, #713.1, MT Anniversary date field, #11
 ;    ETYPE - Search type, 30 or 0 day
 ;
 ; Output
 ;    RSLT = Print date ^ Flagged to print status
 ;           will be 0^0 if nothing found to return
 ;
 N RSLT
 ;
 S RSLT=$S(ETYPE=2:EARY(11,"I"),ETYPE=4:EARY(17,"I"),1:0)
 S RSLT=RSLT_"^"_+$S(ETYPE=2:EARY(12,"I"),ETYPE=4:EARY(18,"I"),1:0)
 Q RSLT
 ;
CHKSTAT(EASIEN,DFN) ; Check for means test status, still required or not
 ; Input
 ;    EASIEN  - Internal Entry Number to the ANNUAL MEANS TEST File, #408.31
 ;
 ; Output
 ;    1 - if means test is no longer required or applicable
 ;    0 - if means test is still required
 ;
 N RSLT,EASTAT
 ;
 ; If status = "NO LONGER REQUIRED" or "NO LONGER APPLICABLE" then set result to 1
 ; The .03 field is a pointer to the MEANS TEST STATUS File, #408.32, checks
 ; IEN=3 and IEN=10, NO LONGER REQUIRED and NO LONGER APPLICABLE entries respectively 
 ; If the 408.32 file is changed, this code will need to be reviewed and updated if necessary.
 ;
 S RSLT=0,DFN=$G(DFN)
 ;
 S EASTAT=$$GET1^DIQ(408.31,EASIEN,.03,"I")
 I (EASTAT=3)!(EASTAT=10) S RSLT=1
 ;
 ;; Check current MT Status from API (Looking for Cat-C, Agree to Pay Dedct, MT later than 10-5-99
 I 'RSLT D
 . S:'$$MTCHK^EASMTCHK(DFN,"L") RSLT=1
 ;
 Q $G(RSLT)
 ;
FUTURE(DFN) ; Future Means Test available?
 N RSLT
 ;
 S RSLT=$$FUT^DGMTU(DFN)
 Q $G(RSLT)
 ;
TEST(DFN) ; Test Patient?
 N VAROOT,ZSSN,EASDEM
 ;
 S VAROOT="EASDEM"
 D DEM^VADPT
 S ZSSN=$P(EASDEM(2),U,1)
 I $E(ZSSN,1,5)["00000" Q 1
 ;
 Q 0
 ;
CHKDFN(DFN,MTIEN) ; Checks for a valid zero node in the patient file entry.  
 ; If no valid zero node, sets bad ptr entry
 ;
 N RSLT
 ;
 S DFN=$G(DFN),MTIEN=$G(MTIEN)
 S RSLT=$D(^DPT(DFN,0))
 I 'RSLT D
 . S ^TMP("EASBDPTR",$J,DFN)=MTIEN
 ;
 Q $G(RSLT)
 ;
ERRMSG ; Send mail message if any errors were generated during processing
 I $D(^TMP("EASERR",$J)) D ERRORS
 I $D(^TMP("EASBDPTR",$J)) D BADPTR
 Q
 ;
ERRORS ;
 N EASDFN,EASERR,MSG,DFN,VA
 ;
 S MSG(.1)="The following issues were reported by the Means Test Letter Search Process:"
 S MSG(.9)=""
 ;
 S EASDFN=0
 F  S EASDFN=$O(^TMP("EASERR",$J,EASDFN)) Q:'EASDFN  D
 . S DFN=EASDFN D PID^VADPT
 . S MSG(EASDFN)=$$GET1^DIQ(2,EASDFN,.01)_" ("_VA("BID")_") "_$G(^TMP("EASERR",$J,EASDFN))
 . K VA
 ;
 D SEND(.MSG)
 Q
 ;
BADPTR ;
 N EASDFN,EASERR,MSG,X
 ;
 S MSG(.1)="During the MT Letter Search, the following Annual Means Test "
 S MSG(.2)="File entries (#408.31) were found which may point to a non-existent"
 S MSG(.3)="Patient entry in the PATIENT File (#2):"
 S MSG(.4)=""
 S X=$$SETSTR^VALM1("PATIENT FILE (#2)","",5,20)
 S X=$$SETSTR^VALM1("MT FILE (#408.31)",X,35,20)
 S MSG(.5)=X
 S X=$$SETSTR^VALM1("=================","",5,20)
 S X=$$SETSTR^VALM1("=================",X,35,20)
 S MSG(.6)=X
 ;
 S EASDFN=0
 F  S EASDFN=$O(^TMP("EASBDPTR",$J,EASDFN)) Q:'EASDFN  D
 . S X=$$SETSTR^VALM1(EASDFN,"",5,20)
 . S X=$$SETSTR^VALM1($G(^TMP("EASBDPTR",$J,EASDFN)),X,35,20)
 . S MSG(EASDFN)=X
 ;
 D SEND(.MSG)
 Q
 ;
SEND(MSG) ;
 S XMSUB="MT LETTERS SEARCH ISSUES - "_$$FMTE^XLFDT($$NOW^XLFDT,"D")
 S XMTEXT="MSG("
 S XMY("G.EAS MTLETTERS")=""
 S XMDUZ="AUTOMATED MT LETTERS"
 D ^XMD
 Q
