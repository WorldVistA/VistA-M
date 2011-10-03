SCAPMC28 ;ALB/REW - Patients with an Appointment ; 1/10/05 2:49pm
 ;;5.3;Scheduling;**41,140,346**;AUG 13, 1993
 ;;1.0
PTAP(SCCL,SCDATES,SCMAXCNT,SCLIST,SCERR,MORE) ; -- list of patients with an appointment in a given clinic
 ; 
 ; input:
 ;  SCCL = Pointer to File #44
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCMAXCNT        - Maximum # of patients to return, default=99
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  MORE - This is a flag that says that this list exists and has been
 ;         aborted because it reached the maxcount.  If this =1 it means
 ;         'kill the old list & start where you finished'
 ;  Note: Don't Return DFNs where $D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+DFN)) is true
 ; Output:
 ;  SCLIST() = array of patients
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of PATIENT file entry
 ;                 2       Name of patient
 ;                 3       ien to 40.7 - Not Stop Code!! stp=$$intstp
 ;                 4       AMIS reporting stop code
 ;                 5       Patient's Long ID (SSN)
 ;
 ; SCEFFDT - negative of effective date
 ; SCN     - current subscript (counter) 1->n
 ; SCPTA0   is 0 node of Patient Team Assignment file 1st piece is DFN
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;  @SCERR@(0)=number of errors, undefined if none
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 ;   Returned: 1 if ok, 0 if error^More?
 ;
 ;
ST N SCEND,SCVSDT,SCSTART
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA APQ ;check/setup variables
 ; -- loop through visit file
LP S SCDT=SCBEGIN
 S:'$P(SCEND,".",2) SCEND=$$FMADD^XLFDT(SCEND,1) ;ending is end of day
 IF $G(MORE) D
 .S SCSTART=$P($G(@SCLIST@(0)),U,2)
 .S SCBEGIN=$P($G(@SCLIST@(0)),U,3)
 .K @SCLIST
APQ Q $$PTAPX(.SCCL,.SCBEGIN,.SCEND,.SCMAXCNT,.SCLIST,.SCERR,.SCSTART)
 ;
PTAPX(SCCL,SCBEGIN,SCEND,MAXCNT,SCLIST,SCERR,SCSTART) ;return appointments in dt range
 ; Input: (As above plus:)
 ;    SCSTART - Continue with list at this point
 ; output: SCN - COUNT OF PTS
 ; returns:      dfn^ptname^clinic^apptdt^long id
 ; 
 ;initialize variables
 N SCDT,SCARRAY,DFN,SDAPTCNT,SDARRAY,SDERR,SDX,SDY
 K ^TMP($J,"SDAMA301")
 ;setup call to SDAPI
 S SDARRAY(1)=$G(SCBEGIN)_";"_$G(SCEND),SDARRAY(2)=$G(SCCL),SDARRAY("FLDS")=4
 S SDARRAY("SORT")="P"
 ;call SDAPI to retrieve appointments
 S SDAPTCNT=$$SDAPI^SDAMA301(.SDARRAY)
 ;handle errors if any returned from SDAPI and QUIT
 I SDAPTCNT<0 D  Q ($G(@SCERR@(0))<1)_U_(SCN'<SCMAXCNT)
 .;call existing error handler
 .D ERR^SCAPMCU1(.SCESEQ,,,"",.SCERR)
 .K ^TMP($J,"SDAMA301")
 ;if appointments returned 
 I SDAPTCNT>0 D
 .;retrieve patient ID to start at if continuing list (was appt ifn)
 .; * no code could be found to utilize continuation of a list
 .; * if this changes this code should be revisited to ensure only 1
 .;   call to SDAPI is made.
 .S DFN=+$G(SCSTART)
 .S SCSTART=0
 .S SCDT=0
 .;resort appts to ensure same data is returned to user
 .;only 1st appt date/time is needed for each patient
 .;as patient can only be added to the list once.
 .K ^TMP($J,"RE-SORT","SDAMA301")
 .S (SDY,SDX)=0
 .F  S SDX=$O(^TMP($J,"SDAMA301",SDX)) Q:'SDX  D
 ..S SDY=$O(^TMP($J,"SDAMA301",SDX,""))
 ..S ^TMP($J,"RE-SORT","SDAMA301",SDY,SDX)=""
 .K ^TMP($J,"SDAMA301")
 .;loop through re-sorted appts returned from SDAPI until
 .; 1. no more patients with appointments exist
 .; 2. number of patients found that match criteria is not less than max
 .F  S SCDT=$O(^TMP($J,"RE-SORT","SDAMA301",SCDT)) Q:'SCDT!(SCN'<SCMAXCNT)  D
 ..;get patient for the kept appointment in the re-sorted list
 ..F  S DFN=$O(^TMP($J,"RE-SORT","SDAMA301",SCDT,DFN)) Q:'DFN!(SCN'<SCMAXCNT)  D
 ...;quit if patient is found in either of the following lists
 ...;this list may be used elsewhere, left in for compatibility
 ...Q:$D(@SCLIST@("SCPTAP",+DFN))
 ...Q:$D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+DFN))
 ...;increment the patient counter and store in SCLIST
 ...S SCN=$G(@SCLIST@(0))+1
 ...S @SCLIST@(0)=SCN
 ...;get the patient's long ID (SSN) and Name
 ...D GETS^DIQ(2,+DFN,".01;.363","","SCARRAY")
 ...;add the following appt info to SCLIST at the current Patient Counter
 ...;1. Patient DFN 2. Patient Name 3. Clinic IEN 4. Appt DTM 5. Patients Long ID
 ...S @SCLIST@(SCN)=DFN_U_$G(SCARRAY(2,+DFN_",",.01))_U_SCCL_U_SCDT_U_$G(SCARRAY(2,+DFN_",",.363))
 ...;add the patient's DFN to the exclusion list
 ...S @SCLIST@("SCPTAP",+DFN,+SCN)=""
 ;kill the re-sorted appt global reference generated
 K ^TMP($J,"RE-SORT","SDAMA301")
 ;if # of patients found that match criteria is NOT LESS than the requested Max then
 ;set SCLIST at the 0 Node to:
 ;1.Current Patient Count 2. Current Patient Processing 3. Appt DTM 4. Clinic IEN
 S:(SCN'<SCMAXCNT) @SCLIST@(0)=SCN_U_+$G(DFN)_U_+$G(SCDT)_U_+$G(SCCL)
 Q ($G(@SCERR@(0))<1)_U_(SCN'<SCMAXCNT)
 ;
OKDATA() ;check/setup variables
 N SCOK
 S SCOK=1
 S SCMAXCNT=$G(SCMAXCNT,99)
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SC(+$G(SCCL),0)) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SCCL,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid TEAM ien passed (Error # 4045101 in DIALOG file)
 Q SCOK
