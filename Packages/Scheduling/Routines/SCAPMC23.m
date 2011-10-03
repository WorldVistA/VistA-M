SCAPMC23 ;ALB/REW - Team API's:TPPT ; JUN 30, 1995
 ;;5.3;Scheduling;**41,148**;AUG 13, 1993
 ;;1.0
TPPT(DFN,SCDATES,SCPOSA,SCUSRA,SCPURPA,SCROLEA,SCYESCL,SCLIST,SCERR) ; -- positions for a patient 
 ; input:
 ; DFN = ien of PATIENT file(#2) [required]
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
 ; SCYESCL -boolean[0-NO(default)/1-YES] Include pts asc. via enrollment?
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
 ;                 4       IEN of file #404.43 (Pt Tm Pos Assign -404.43)
 ;                 5       current effective date
 ;                 6       current inactivate date (if any)
 ;                 7       pointer to 403.46 (role)
 ;                 8       Name of Standard Role
 ;                 9       pointer to User Class (#8930)
 ;                10       Name of User Class
 ;                11       Pointer to patient team assignment (404.42)JLU
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
ST N SCPTTP,SCPTTP0,SCTP,SCR,SCACTHIS,SCTM,SCND,SCU,SCPTTPI,SCTPA,SCPTBEG,SCPTEND,SCTPPT,SCTEAMA,SCENROLL
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCBEGIN,SCEND,SCINCL,SCDTS,SCPTPA
 ; -- initialize control variables
 G:'$$OKDATA PRACQ
 ; -- loop through patient team position assignment history
 S (SCTP,SCTPA)=0
 F  S SCTP=$O(^SCPT(404.43,"ADFN",DFN,SCTP)) Q:'SCTP  D
 .F SCPTTP=0:0 S SCPTTP=$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCPTTP)) Q:'SCPTTP  D
 .. ; S SCPTTPI=$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCPTTP,0))
 .. ; replaced line above with FOR LOOP and new dot level below. Now loops thru all assignments
 .. ; made on a given day - PDR 9/98
 .. S SCPTPA="" ; position assignment IEN
 .. F  S SCPTPA=$O(^SCPT(404.43,"ADFN",DFN,SCTP,SCPTTP,SCPTPA)) Q:'SCPTPA  D
 ... S SCPTTP0=$G(^SCPT(404.43,SCPTPA,0))
 ... S SCPTBEG=$P(SCPTTP0,U,3)
 ... S SCPTEND=$P(SCPTTP0,U,4)
 ... Q:1>$$DTCHK^SCAPU1(SCBEGIN,SCEND,SCINCL,SCPTBEG,SCPTEND)
 ... S SCACTHIS=$$ACTHIST^SCAPMCU2(404.59,SCTP,SCDATES,SCERR,"SCTPPT")
 ... ; --- below changes scacthis to send 404.43 data
 ... S:SCPTBEG>$P(SCACTHIS,U,3) $P(SCACTHIS,U,3)=SCPTBEG
 ... S:SCPTEND&((SCPTEND<$P(SCACTHIS,U,4))!('$P(SCACTHIS,U,4))) $P(SCACTHIS,U,4)=SCPTEND
 ... S $P(SCACTHIS,U,2)=SCPTPA ; SCPTTPI
 ... Q:'SCACTHIS
 ... Q:'$$OKARRAY^SCAPU1(.SCPOSA,.SCTP)
 ... S SCND=$G(^SCTM(404.57,SCTP,0)) ;the team position 0 node
 ... S SCU=$P(SCND,U,13)
 ... Q:'$$OKUSRCL^SCAPU1(.SCUSRA,.SCU)
 ... S SCTM=$P(SCND,U,2)
 ... S SCP=$P(^SCTM(404.51,+SCTM,0),U,3)
 ... Q:'$$OKARRAY^SCAPU1(.SCPURPA,.SCP)
 ... S SCPTA=0
 ... S SCR=+$P(SCND,U,3)
 ... Q:'$$OKARRAY^SCAPU1(.SCROLEA,.SCR)
 ... D BLD^SCAPMC24(.SCLIST,SCTM,SCTP,SCACTHIS,SCR)
 ; - if scyescl=1 get enrolled clinics & find positions associated w clinc for teams that the pt is in
 G:'SCYESCL PRACQ
 IF '$$TMPT^SCAPMC(DFN,SCDATES,.SCPURPA,"SCTEAMA",.SCERR) G PRACQ
 IF '$$CLPT^SCAPMC29(DFN,SCDATES,"SCTEAMA","SCENROLL",.SCERR) G PRACQ
 IF '$G(SCENROLL(0)) G PRACQ
 S INDX=0
 F INDX=1:1:$G(SCENROLL(0)) S SCX=$G(SCENROLL(INDX)) D
 .IF 'SCX D  Q
 ..S SCPARM("Enroll Xref")=$G(SCX)
 ..D ERR^SCAPMCU1(.SCESEQ,,SCPARM,"",.SCERR)
 .S SC44=$P(SCX,U,1)
 .S ENR("BEGIN")=$S(SCBEGIN>$P(SCX,U,3):SCBEGIN,1:$P(SCX,U,3))
 .S ENR("END")=$S('$P(SCX,U,4):SCEND,(SCEND<$P(SCX,U,4)):SCEND,1:$P(SCX,U,4))
 .S ENR("INCL")=SCINCL
 .Q:'$$TPCL^SCAPMC(SC44,"ENR",.SCPOSA,.SCUSRA,.SCPURPA,.SCROLEA,.SCLIST,.SCERR)
PRACQ Q $G(@SCERR@(0))<1
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 S SCYESCL=+$G(SCYESCL,0)
 IF '$D(^DPT(+$G(DFN),0)) D  S SCOK=0
 . S SCPARM("Patient")=$G(DFN,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ;
 Q SCOK
 ;
