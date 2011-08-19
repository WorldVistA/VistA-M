SCAPMC25 ;ALB/REW - Team API's:MSGDTH ; may 1999
 ;;5.3;Scheduling;**41,177,297**;AUG 13, 1993
 ;;1.0
MSGPT(MSGTYPE,DFN,SCTEAMA,SCDATES,SCYESCL,SCLIST,SCERR) ; users getting death message
 ; Input:
 ;  MSGTYPE:
 ;      1 = Death Message
 ;      2 = Inpatient Message
 ;      3 = Team Message
 ;      4 = Consult Message
 ;      5 = Inactivation Message
 ;
 ;   DFN - Pointer to Patient File #2
 ;  SCTEAMA -array of pointers to team file 404.51
 ;          if none are defined - returns all teams
 ;          if @scteama@('exclude') is defined - exclude listed teams
 ;  SCDATES("BEGIN") = begin date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("END")   = end date to search (inclusive)
 ;                       [default: TODAY]
 ;         ("INCL")  = 1: only use pracitioners who were on
 ;                       team for entire date range
 ;                     0: anytime in date range
 ;                      [default: 1] 
 ; SCYESCL -boolean[1-yes(default)/0-no] Include pts asc. via enrollment?
 ;   SCLIST - Name of output array
 ;  SCERR = array NAME to store error messages.
 ;          [ex. ^TMP("ORXX",$J
 ; Output:
 ;  SCLIST() = array of practitioners (users) - pointers to file #200
 ;             Format:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of NEW PERSON file entry (#200)
 ;                 2       .01 of file #200
 ;  SCERR()  = Array of DIALOG file messages(errors) .
 ;  @SCERR(0)= Number of error(s), UNDEFINED if no errors
 ;             Foramt:
 ;               Subscript: Sequential # from 1 to n
 ;               Piece     Description
 ;                 1       IEN of DIALOG file
 ;   Returned: 1 if ok, 0 if error
 ;
ST N SCOK,SCTM,SCTP,SCX,SCY,NODE,SCZ,SCTPND
 N SCLSEQ,SCN,SCESEQ,SCPARM,SCP,SCBEGIN,SCEND,SCINCL,SCDTS
 S SCOK=1
 ; -- initialize control variables
 G:'$$OKDATA MSGQ
 ;given patient get list of their teams
 S SCOK=$$TMPT^SCAPMC(DFN,SCDATES,,"^TMP(""SCMSG1"",$J)",.SCERR)
 G:SCOK<1 MSGQ
 ;validate teams
 F SCX=1:1 S NODE=$G(^TMP("SCMSG1",$J,SCX)) Q:'NODE  S SCTM=+NODE D:$$OKARRAY^SCAPU1(.SCTEAMA,SCTM)  Q:SCOK<1
 .;given teams get list of their positions
 .S SCZ=$$TPTM^SCAPMC(SCTM,SCDATES,,,"^TMP(""SCMSG2"",$J)",.SCERR)
 .Q:'SCZ
 .IF SCZ<0 S SCOK=-1 Q
 .;given list of valid positions get list of practitioners
 ; should position get message?
 ;;bp/cmf **177** begin
 F SCY=1:1 S SCTPND=$G(^TMP("SCMSG2",$J,SCY)) Q:'SCTPND  D
 .S SCTP=$P(SCTPND,U,1)
 .D:$$OKPOS(MSGTYPE,SCTP,DFN,SCYESCL,SCDATES,.SCERR)
 ..;given list of valid positions get current practitioners
 ..S SCOK=$$PRTP^SCAPMC(SCTP,SCDATES,.SCLIST,.SCERR)
 ..Q
 .;new code here
 .;if preceptor notice turned on for message type
 .I +$P($G(^SCTM(404.57,SCTP,2)),U,MSGTYPE+4) D
 ..S SCX=+$$OKPREC2^SCMCLK(SCTP,DT)
 ..;if preceptor duz returned, add to array
 ..I SCX S @SCLIST@("SCPR",SCX)=""
 ..Q
 .Q
 ;
 ;;bp/cmf **177** orig begin
 ;;o;;F SCY=1:1 S SCTPND=$G(^TMP("SCMSG2",$J,SCY)) Q:'SCTPND  S SCTP=$P(SCTPND,U,1) D:$$OKPOS(MSGTYPE,SCTP,DFN,SCYESCL,SCDATES,.SCERR)
 ;;o;;.;given list of valid positions get current practitioners
 ;;o;;.S SCOK=$$PRTP^SCAPMC(SCTP,SCDATES,.SCLIST,.SCERR)
 ;;bp/cmf **177** orig end
 ;;bp/cmf **177** end
MSGQ F SCZ="SCMSG1","SCMSG2","SCMSG3" K ^TMP(SCZ)
PRACQ Q $G(@SCERR@(0))<1
 ;
OKPOS(MSGTYPE,SCTP,DFN,SCYESCL,SCDATES,SCERR) ;check if message should go out to position for given pt
 ;needs pre-validated input
 ;return 1=ok,0=not ok
 N GETMESS,SCOK,SCX,SCTM
 K ^TMP("SCMSG3",$J)
 S SCTM=$P($G(^SCTM(404.57,SCTP,0)),U,2)
 S GETMESS=$P($G(^SCTM(404.57,SCTP,2)),U,MSGTYPE)
 S:"T"[GETMESS SCOK=1 ;if null give messages
 S:GETMESS="N" SCOK=0
 IF GETMESS="P" D
 .;check if pt is assigned to position
 .S SCX=$$TPPT^SCAPMC(DFN,SCDATES,,,,,SCYESCL,"^TMP(""SCMSG3"",$J)",.SCERR)
 .S SCOK=$D(^TMP("SCMSG3",$J,"SCTP",SCTM,SCTP))
 .S:SCX<0 SCOK="-1^Error in position-patient call"
 K ^TMP("SCMSG3",$J)
 Q SCOK
 ;
OKDATA() ;setup/check variables
 N SCOK
 S SCOK=1
 D INIT^SCAPMCU1(.SCOK) ; set default dates & error array (if undefined)
 S:'$L($G(SCYESCL)) SCYESCL=1
 IF '$D(^DPT(+$G(DFN),0)) D  S SCOK=0
 . S SCPARM("PATIENT")=$G(PATIENT,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 ;
 ; -- is it a valid DFN passed (Error # 20001 in DIALOG file)
 IF '$D(^DPT(+DFN,0)) D   S SCOK=0
 . S SCPARM("PATIENT")=DFN
 . D ERR^SCAPMCU1(SCESEQ,20001,.SCPARM,"",.SCERR)
 Q SCOK
 ;
PCMMXMY(MSGTYPE,DFN,SCTEAMA,SCDATES,SCYESCL) ;create xmy array for the appropriate type of pcmm mess
 ; return 1 if success,0 if error or no users receiving message
 N SCOK,SCGROUP,SC200,SCGROUP
 IF '$G(MSGTYPE) S SCOK=0 G QTXMY
 S SCOK=1
 S SCOK=$$MSGPT(MSGTYPE,.DFN,.SCTEAMA,.SCDATES,.SCYESCL,"^TMP(""SC PCMM MAIL"",$J)")
 S SC200=0
 F  S SC200=$O(^TMP("SC PCMM MAIL",$J,"SCPR",SC200)) Q:'SC200  S XMY(SC200)=""
 IF $D(XMY) D
 .S XMY(.5)=""
 ELSE  D
 .S SCOK=0
 .S XMY(.5)=""
 K ^TMP("SC PCMM MAIL",$J)
QTXMY Q SCOK
 ;
MSGTEXT(MSGTYPE) ;
 Q $S(MSGTYPE=1:"DEATH",(MSGTYPE=2):"INPATIENT",(MSGTYPE=3):"TEAM",(MSGTYPE=4):"CONSULT",(MSGTYPE=5):"INACTIVATION",1:"ERROR")
