SCAPMC27 ;ALB/REW - PTST Patients with a Stop Code ; JUN 30, 1995
 ;;5.3;Scheduling;**41,140**;AUG 13, 1993
 ;;1.0
PTST(SCST,SCDATES,SCMAXCNT,SCLIST,SCERR,MORE) ; -- list of patients with a IEN of 40.7
 ; USE $$PTSTEXT(below) if you have stop code (e.g. 301)
 ; input:
 ;  SCST = stop code
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCMAXCNT        = Maximum Number to Return - Default=99
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;  MORE  - For continuing lists (see scapmc28)
 ;Note: Don't Return DFNs where $D(^TMP("SCMC",$J,"EXCLUDE PT","SCPTA",+DFN)) is true
 ; Output:
 ;  SCLIST() = array of patients
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of PATIENT file entry
 ;                 2       Name of patient
 ;                 3       ien to 40.7 - Not Stop Code!! stp=$$intstp
 ;                 4       AMIS reporting stop code
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
ST N SCDT,SCEND,SCCL,SCNODE,SCX
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 S SCX=0
 G:'$$OKDATA STQ ;check/setup variables
 ; -- loop file#44
LP S SCDT=SCBEGIN
 S:'$P(SCEND,".",2) SCEND=$$FMADD^XLFDT(SCEND,1) ;ending is end of day
 IF $G(MORE) D
 .S SCSTART=+$P($G(@SCLIST@(0)),U,2)
 .S SCBEGIN=+$P($G(@SCLIST@(0)),U,3)
 .S SCCL=+$P($G(@SCLIST@(0)),U,4)
 .K @SCLIST
 ELSE  D
 .S SCSTART=0
 .S SCCL=0
 ; go thru clinics with stop code=SCST
 F  S:'$G(MORE) SCCL=$O(^SC(SCCL)) Q:'SCCL  S:$P($G(^SC(SCCL,0)),U,7)=SCST SCX=$$PTAPX^SCAPMC28(.SCCL,.SCBEGIN,.SCEND,.SCMAXCNT,.SCLIST,.SCERR,.SCSTART) S MORE=0
STQ Q SCX
 ;
OKDATA() ;check/setup variables
 N SCOK
 S SCOK=1
 S SCMAXCNT=$G(SCMAXCNT,99)
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^DIC(40.7,+$G(SCST),0)) D  S SCOK=0
 . S SCPARM("STOP")=$G(SCST,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ; -- is it a valid TEAM ien passed (Error # 4045101 in DIALOG file)
 Q SCOK
 ;
INTST(STOP) ;given stop code return ient
 Q +$O(^DIC(40.7,"C",+$G(STOP),0))
 ;
PTSTEXT(SCSTOP,SCDATES,SCMAXCNT,SCLIST,SCERR) ; -- list of patients with AMIS REPORTING STOP CODE
 ;  For variables see: PTST (above)
 ;   Returned: 1 if ok, 0 if error^More?
 N SCST
 S SCST=$$INTST(.SCSTOP)
 Q $$PTST(.SCST,.SCDATES,.SCMAXCNT,.SCLIST,.SCERR,.MORE)
