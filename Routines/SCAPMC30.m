SCAPMC30 ;ALB/REW - TEAM APIs:TPCL  ; 30 Jun 95
 ;;5.3;Scheduling;**41,520**;AUG 13, 1993;Build 26
 ;;1.0
TPCL(SC44,SCDATES,SCPOSA,SCUSRA,SCPURPA,SCROLEA,SCLIST,SCERR) ;  -- list of positions for a clinic
 ; input:
 ;  SC44 = ien of HOSPITAL LOCATION <FILE#44> [required]
 ; SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCPOSA -array of pointers to team position - 404.57 (per SCPURPA)
 ;  SCUSRA -array of pointers to user file - 8930 (per SCPURPA array)
 ;  SCPURPA -array of pointers to team purpose file 403.47
 ;          if none are defined - returns all teams
 ;          if @SCPURPA@('exclude') is defined - exclude listed teams
 ;  SCROLEA - array of pointers to std position file 403.46 (per SCPURPA)
 ;  SCLIST -array name to store list
 ;          [ex. ^TMP("SCPT",$J)]
 ;        
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J)]
 ;
 ; Output:
 ;  SCLIST() = array of positions (includes SCTP xref)
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of TEAM POSITION File (#404.57)
 ;                 2       Name of Position
 ;                 3       IEN of Team #404.51
 ;                 4       IEN of file #404.59 (Tm Pos History)
 ;                 5       current effective date
 ;                 6       current inactivate date (if any)
 ;                 7       pointer to 403.46 (role)
 ;                 8       Name of Standard Role
 ;                 9       pointer to User Class (#8930)
 ;                10       Name of User Class
 ;                Subscript: "SCTP",SCTM,IEN =""
 ;
 ;  SCERR() = Array of DIALOG file messages(errors) .
 ;  @SCERR@(0) = number of errors, undefined if none
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;  Returned: 1 if ok, 0 if error
 ; Other:
 ;  SCACTHIS =  status (-1:err|0:inact|1:act)^404.52 ien ^actdt^inacdt
 ;
 ;
ST N SCPTTP,SCPTTP0,SCTP,SCR,SCACTHIS,SCTM,SCND,SCU,SCOK,SCP,SCTPCL
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 S SCOK=1
 G:'$$OKDATA CLTPQ
 S SCTP=0 F  S SCTP=$O(^SCTM(404.57,"E",SC44,SCTP)) Q:'SCTP  D  Q:'SCOK
 .S SCTP0=$G(^SCTM(404.57,SCTP,0))
 .IF '$L(SCTP0) D
 ..S SCPARM("POSITION")=$G(SCTP,"Undefined")
 ..S SCPARM("CLINIC")=$G(SC44,"Undefined")
 ..D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 .S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 .S SCP=$P(^SCTM(404.51,+SCTM,0),U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCPURPA,.SCP)
 .S SCR=+$P(^SCTM(404.57,SCTP,0),U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 .S SCACTHIS=$$ACTHIST^SCAPMCU2(404.59,SCTP,SCDATES,SCERR,"SCTPCL")
 .Q:'SCACTHIS
 .D BLD^SCAPMC24(.SCLIST,SCTM,SCTP,SCACTHIS,SCR)
CLTPQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;check/setup variables - return 1 if ok; 0 if error
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SC(+$G(SC44),0)) D  S SCOK=0
 . S SCPARM("CLINIC")=$G(SC44,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
