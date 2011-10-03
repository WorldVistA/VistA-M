SCAPMC24 ;ALB/REW - Team API's:TPTM ; 27 Jun 99  3:05 PM
 ;;5.3;Scheduling;**41,148,177**;AUG 13, 1993
 ;;1.0
TPTM(SCTM,SCDATES,SCUSRA,SCROLEA,SCLIST,SCERR) ; -- positions for a pract
 ; input:
 ; SCTM = ien of TEAM File (#404.51) [required]
 ; SCDATES("BEGIN") = begin date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("END")   = end date to search (inclusive)
 ;                      [default: TODAY]
 ;        ("INCL")  = 1: only use patients who were assigned to
 ;                       team for entire date range
 ;                    0: anytime in date range
 ;                      [default: 1] 
 ;  SCUSRA -array of pointers to user file - 8930
 ;          if none are defined - returns all usr classes
 ;          if @SCPURPA@('exclude') is defined - exclude listed usr class
 ;  SCROLEA - array of pointers to std position file 403.46 (per scusra)
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
 ;  SCACTHIS =  status (-1:err|0:inact|1:act)^404.59 ien ^actdt^inacdt
 ;
 ;
ST N SCPTTP,SCPTTP0,SCTP,SCR,SCACTHIS,SCND,SCTPTM,SCTPA
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCBEGIN,SCEND,SCINCL,SCDTS
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- loop through team positionS
 S (SCTP,SCTPA)=0
 F  S SCTP=$O(^SCTM(404.57,"C",SCTM,SCTP)) Q:'SCTP  Q:'$$TPVALBLD(SCTP,.SCDATES,.SCPOSA,.SCUSA,.SCPURPA,.SCROLEA,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
 ;
TPVALBLD(SCTP,SCDATES,SCPOSA,SCUSA,SCPURPA,SCROLEA,SCLIST,SCERR) ;
 ; this validates a team position & builds sclist array
 ; returns 1 if ok, 0 if error
 N SCTPDT,SCDDDD,SCTP0,SCU,SCR,SCTM
 M SCDDDD=@SCDATES
 S SCTP0=$G(^SCTM(404.57,SCTP,0))
 S SCTPDT=-9999999 F  S SCTPDT=$O(^SCTM(404.59,"AIDT",SCTP,1,SCTPDT)) Q:'SCTPDT  D
 .S SCACTHIS=$$ACTHIST^SCAPMCU2(404.59,SCTP,"SCDDDD",.SCERR,"SCTPTM")
 .Q:'SCACTHIS
 .S SCND=$G(^SCTM(404.57,SCTP,0))
 .S SCU=$P(SCND,U,13)
 .Q:'$$OKUSRCL^SCAPU1(.SCUSRA,.SCU)
 .S SCR=+$P(SCND,U,3)
 .Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 .D BLD(.SCLIST,$P(SCTP0,U,2),SCTP,SCACTHIS,SCR)
 .S SCDDDD("END")=$P(SCACTHIS,U,3)-.00001
QTVALBLD Q $G(@SCERR@(0))<1
 ;
BLD(SCLIST,SCTM,SCTP,SCACTHIS,SCR) ; -- build list of positions
 ;
 ; SCLIST  - output array
 ; SCTM  - pointer to 404.51
 ; SCTP    - pointer to 404.57
 ; SCACTHIS- per $$acthis^scapmcu2(file,ien)
 ; SCPTA   - ien of pt team assignment
 ; SCR     - role
 ; 
 ; this builds the array:
 ;   sclist(1->n)=SCTP^positionname^sctm^histien^effdt^inactdt^scr^rolename^scusr^usrname
 ;  
 ;    for each scpta zero node passed to it
 ;    AND a xref  sclist('SCTP',SCTM,scpt,histien,scn)=""
 N SCEFFDT,SCCNT,SCN,SCUSR
 S:'$G(SCTM) SCTM=$P($G(^SCTM(404.57,+$G(SCTP),0)),U,2)
 Q:$D(@SCLIST@("SCTP",SCTM,SCTP,$P(SCACTHIS,U,2)))
 S SCN=$G(@SCLIST@(0),0)+1
 S @SCLIST@(0)=SCN
 S SCUSR=+$P(^SCTM(404.57,SCTP,0),U,13)
 ;               1    ^              2                   ^  3    ^  4
 ;
 ;;bp/djb/11-2-98/Added STATUS field to the output array (SRS 3.2.3).
 ;;old code begin
 ;S @SCLIST@(SCN)=SCTP_U_$P($G(^SCTM(404.57,SCTP,0)),U,1)_U_SCTM_U_$P(SCACTHIS,U,2,4)_U_SCR_U_$P($G(^SD(403.46,SCR,0)),U,1)_U_SCUSR_U_$P($G(^USR(8930,SCUSR,0)),U,1)_U_$P($G(SCPTTP0),U,1)
 ;;old code end
 ;;new code begin
 S @SCLIST@(SCN)=SCTP_U_$P($G(^SCTM(404.57,SCTP,0)),U,1)_U_SCTM_U_$P(SCACTHIS,U,2,4)_U_SCR_U_$P($G(^SD(403.46,SCR,0)),U,1)_U_SCUSR_U_$P($G(^USR(8930,SCUSR,0)),U,1)_U_$P($G(SCPTTP0),U,1)
 ;;new code end
 ;
 ;THE 11TH $P WAS ADDED BY JLU
 S @SCLIST@("SCTP",SCTM,SCTP,$P(SCACTHIS,U,2),SCN)=""
 Q
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 IF '$D(^SCTM(404.51,+$G(SCTM),0)) D  S SCOK=0
 . S SCPARM("Team")=$G(SCTM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 Q SCOK
 ;
