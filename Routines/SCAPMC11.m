SCAPMC11 ;ALB/REW - Team API's: PTTP ; JUN 30, 1995
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1.0
PTTP(SCTP,SCDATES,SCLIST,SCERR) ; -- list of patient team position assignments
 ; input:
 ;  SCTP = ien of TEAM POSITION [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       position for entire date range
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
 ;                 3       IEN of Patient Team Position Assignment
 ;                 4       Activation Date
 ;                 5       Inactivation Date
 ;                 6       Patient's Long ID - (SSN)
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
ST N SCTPA,SCPTA,SCPTA0,SCPTMA,SCPTPA,SCPTPA0
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 G:'$$OKDATA PRACQ ;check/setup variables
 ; -- loop through patient team position assignments
LP S SCPTMA=0
 F  S SCPTMA=$O(^SCPT(404.43,"APTPA",SCTP,SCPTMA)) Q:'SCPTMA  D
 .S SCPTPA=0
 .F  S SCPTPA=$O(^SCPT(404.43,"APTPA",SCTP,SCPTMA,SCPTPA)) Q:'SCPTPA  D
 ..S SCPTPA0=$G(^SCPT(404.43,SCPTPA,0))
 ..Q:'SCPTPA0
 ..Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,$P(SCPTPA0,U,3),$P(SCPTPA0,U,4))
 ..D BLD(.SCLIST,SCPTPA,SCPTPA0)
PRACQ Q $G(@SCERR@(0))<1
 ;
 ;
BLD(SCLIST,SCPTTPA,SCPTTPA0) ; build list
 ; SCPTTPA    - ien of patient team position assignment file #404.43
 ; SCEFFDT - negative of effective date
 ; SCN     - current subscript (counter) 1->n
 ; SCPTTPA0 - IS 0 node of Pt Team Pos Assnt(404.43) 1st piece:pt tm ass
 ; 
 ; this builds the array:
 ;   sclist(1->n)=sc2^ptname^effdt^inactdt
 ;    for each scpta zero node passed to it
 Q:'SCPTTPA!('SCPTTPA0)  ;add error trapping?
 Q:$D(@SCLIST@("SCPTTPA",+SCPTTPA0,SCPTTPA))
 N SCEFFDT,SCCNT,DFN
 S DFN=+$G(^SCPT(404.42,+SCPTTPA0,0))
 Q:$D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+DFN))
 S SCN=$G(@SCLIST@(0),0)+1
 S @SCLIST@(0)=SCN
 S @SCLIST@(SCN)=DFN_U_$P($G(^DPT(DFN,0)),U,1)_U_SCPTTPA_U_$P(SCPTTPA0,U,3)_U_$P(SCPTTPA0,U,4)_U_$P($G(^DPT(DFN,.36)),U,3)
 S @SCLIST@("SCPTTPA",+SCPTTPA0,SCPTTPA,SCN)=""
 S @SCLIST@("SCPTA",DFN,SCN)=""
 Q
OKDATA() ;check/setup variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SCTM(404.57,+$G(SCTP),0)) D  S SCOK=0
 . S SCPARM("POSITION")=$G(SCTP,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045701,.SCPARM,"",.SCERR)
 ; -- is it a valid TEAM ien passed (Error # 4045701 in DIALOG file)
 IF '$D(^SCTM(404.57,+SCTP,0)) D  S SCOK=0
 . S SCPARM("TEAM")=SCTP
 . D ERR^SCAPMCU1(SCESEQ,4045701,.SCPARM,"",.SCERR)
 Q SCOK
