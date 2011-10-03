SCAPMC29 ;ALB/REW - TEAM APIs:CLPT  ; 2/17/00 1:33pm
 ;;5.3;Scheduling;**41,210,520**;AUG 13, 1993;Build 26
 ;;1.0
CLPT(DFN,SCDATES,SCTEAMA,SCLIST,SCERR) ;clinics for patient
 ; input:
 ;  DFN = ien of PATIENT <FILE#2> [required]
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("END")   = end date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("INCL")  = 1: only use pracitioners who were on
 ;                       team for entire date range
 ;                     0: anytime in date range
 ;                      [default: 1] 
 ;  SCTEAMA= array of teams to include reverse with scposa('exclude')
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of clinics
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of HOSPITAL LOCATION file entry (#44)
 ;                 2       Name of CLINIC
 ;                 3       ENROLLMENT DATE
 ;                 4       DISCHARGE DATE
 ;                 5       OPT OR AC
 ;                 6       REVIEW DATE
 ;
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;  @SCERR(0)= Number of error(s), UNDEFINED if no errors
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
 ; -- initialize control variables
 ;
ST N SCX,SCS,SC44,SCACOPT,SCTM,SCPOSA,SCTP
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS,SCOK,SCS,SCND,SCACT,SCINACT,SCREVDT,SCCLNM
 G:'$$OKDATA PTCLQ ; check/setup variables
 IF $L($G(SCTEAMA)) D
 .S SCTM=0
 .F  S SCTM=$O(@SCTEAMA@(SCTM)) Q:'SCTM  D  Q:'SCX
 ..S SCX=$$TPTM^SCAPMC(SCTM,SCDATES,,,"SCPOSAX",.SCERR)
 .F SCX=1:1 S SCTP=+$G(SCPOSAX(SCX)) Q:'SCTP  S SCPOSA(SCTP)=""
 .S:$D(@SCTEAMA@("EXCLUDE")) SCPOSA("EXCLUDE")=""
 ;S SCX=0 F  S SCX=$O(^DPT(DFN,"DE",SCX)) Q:'SCX  D
 ;.S SC44=+$G(^DPT(DFN,"DE",SCX,0))
 ;.Q:'SC44
 ;.Q:'$$OKCLIN(SC44,.SCPOSA)
 ;.S SCCLNM=$P($G(^SC(SC44,0)),U,1)
 ;.S SCS=0 F  S SCS=$O(^DPT(DFN,"DE",SCX,1,SCS)) Q:'SCS  D
 ;..S SCND=$G(^DPT(DFN,"DE",SCX,1,SCS,0))
 ;..S SCACT=$P(SCND,U,1)
 ;..S SCINACT=$P(SCND,U,3)
 ;..Q:'$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,SCACT,SCINACT)
 ;..S SCACOPT=$P(SCND,U,2)
 ;..S SCREVDT=$P(SCND,U,5)
 ;..S SCN=$G(@SCLIST@(0),0)+1
 ;..;bp/ar nois brx-1298-12323 prevent undefined variable error
 ;..;New code begins
 ;..Q:'SCACT
 ;..Q:'SCN
 ;.;End of brx-1298-12323
 ;..S @SCLIST@(0)=SCN
 ;..S @SCLIST@(SCN)=SC44_U_SCCLNM_U_SCACT_U_SCINACT_U_SCACOPT_U_SCREVDT
 ;..S @SCLIST@("SCCL",SC44,SCACT,SCN)=""
PTCLQ Q $G(@SCERR@(0))<1
 ;
OKCLIN(SC44,SCPOSA) ;is clinic ok, given position array
 N SCOK,SCTP
 IF '$D(SCPOSA) S SCOK=1 G QTOKC
 S (SCOK,SCTP)=0
 F  S SCTP=$O(^SCTM(404.57,"E",+SC44,SCTP)) Q:'SCTP  S:$$OKARRAY^SCAPU1(.SCPOSA,SCTP) SCOK=1
QTOKC Q SCOK
 ;
OKDATA() ;check/setup variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^DPT(+$G(DFN),0)) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(DFN,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
