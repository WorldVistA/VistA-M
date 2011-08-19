SCAPMC2 ;ALB/REW - Team API's: PTTM ; JUN 30, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
PTTM(SCTEAM,SCDATES,SCLIST,SCERR) ; -- list of patient team assignments
 ; input:
 ;  SCTEAM = ien of TEAM [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of patients
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of PATIENT file entry
 ;                 2       Name of patient
 ;                 3       IEN of Patient Team Assignment
 ;                 4       Activation Date
 ;                 5       Inactivation Date
 ;                 6       Patient Long ID (SSN)
 ;
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;  @SCERR@(0)=number of errors, undefined if none
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;
 ;   Returned: 1 if ok, 0 if error
 ;
 ;
ST N SCPT,SCPTA,SCPTA0
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA PRACQ ;check/setup variables
 ; -- loop through patient team assignments
LP S SCPT=0
 F  S SCPT=$O(^SCPT(404.42,"ATMPT",SCTEAM,SCPT)) Q:'SCPT  D
 .S SCPTA=0
 .F  S SCPTA=$O(^SCPT(404.42,"ATMPT",SCTEAM,SCPT,SCPTA)) Q:'SCPTA  D
 ..S SCPTA0=$G(^SCPT(404.42,SCPTA,0))
 ..Q:'SCPTA0
 ..Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,$P(SCPTA0,U,2),$P(SCPTA0,U,9))
 ..D BLD(.SCLIST,SCPTA,SCPTA0,.SCN)
PRACQ Q $G(@SCERR@(0))<1
 ;
 ;
BLD(SCLIST,SCPTA,SCPTA0,SCN) ; build list
 ;
 ; SCPA    - ien of patient team assignment file #404.42
 ; SCEFFDT - negative of effective date
 ; SCN     - current subscript (counter) 1->n
 ; SCPTA0   is 0 node of Patient Team Assignment file 1st piece is DFN
 ; 
 ; this builds the array:
 ;   sclist(1->n)=sc2^ptname^effdt^inactdt
 ;    for each scpta zero node passed to it
 Q:'SCPTA!('SCPTA0)  ;add error trapping?
 Q:$D(@SCLIST@("SCPTA",+SCPTA0,SCPTA))
 Q:$D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+SCPTA0))
 N SCEFFDT,SCCNT
 S SCN=SCN+1
 S @SCLIST@(SCN)=+SCPTA0_U_$P($G(^DPT(+SCPTA0,0)),U,1)_U_SCPTA_U_$P(SCPTA0,U,2)_U_$P(SCPTA0,U,9)_U_$P($G(^DPT(+SCPTA0,.36)),U,3)
 ;_U_$P(SCPTA0,U,3)_U_$P($G(^SCTM(404.51,+$P(SCPTA0,U,3),0)),U,1) - didn't include team data to make return array generic
 S @SCLIST@("SCPTA",+SCPTA0,SCPTA,SCN)=""
 Q
OKDATA() ;check/setup variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SCTM(404.51,+$G(SCTEAM),0)) D  S SCOK=0
 . S SCPARM("TEAM")=$G(SCTEAM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid TEAM ien passed (Error # 4045101 in DIALOG file)
 IF '$D(^SCTM(404.51,+SCTEAM,0)) D  S SCOK=0
 . S SCPARM("TEAM")=SCTEAM
 . D ERR^SCAPMCU1(SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
