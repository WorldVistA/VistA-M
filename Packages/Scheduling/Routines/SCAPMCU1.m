SCAPMCU1 ;ALB/REW - TEAM API UTILITIES ; 7/12/99 9:33am
 ;;5.3;Scheduling;**41,45,48,177**;AUG 13, 1993
 ;;1.0
INIT(SCOK) ; setup date array &  error arrays if none passed in
 ;  VARIABLES SET:
 ;     SCOK - SET TO 0 IF ERROR
 ;
 ;  Makes sure the following are defined:
 ;   scbegin,scend,scincl,@scdates('begin'),@scdates@('end'),@scdates@('incl') - defaults are today & inclusive
 ;
 ;    Note: you should NEW the above just before making this call
 ;                     ---
 S (SCN,SCESEQ,SCLSEQ)=0
 IF '$L($G(SCERR)) K ^TMP("SCERR",$J) S SCERR="^TMP(""SCERR"",$J)"
 IF '$L($G(SCLIST)) S SCLIST="^TMP(""SC TMP LIST"",$J)" K ^TMP("SC TMP LIST",$J)
 IF (SCERR="SCERR")!(SCERR="SCLIST")!((SCERR'?1A1.7AN)&(SCERR'?1"^"1A.20E)) D  S SCOK=0
 . S SCPARM("ERROR ARRAY")=$G(SCERR,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF SCLIST="SCERR"!(SCLIST="SCLIST")!((SCLIST'?1A1.7AN.1"(".60E)&(SCLIST'?1"^"1A1.7AN.1"(".60E)) S SCOK=0 D  S SCOK=0
 . S SCPARM("OUTPUT ARRAY")=$G(SCLIST,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 S:'$D(SCDATES)!($G(SCDATES)="") SCDATES="SCDTS"
 S SCBEGIN=$G(@SCDATES@("BEGIN"),DT),SCBEGIN=$S(SCBEGIN:SCBEGIN,1:DT)
 S SCEND=$G(@SCDATES@("END"),DT),SCEND=$S(SCEND:SCEND,1:DT)
 S SCINCL=$G(@SCDATES@("INCL"),1)
 S (SCN,SCESEQ,SCLSEQ)=0
 S:'$D(@SCDATES@("BEGIN")) @SCDATES@("BEGIN")=SCBEGIN
 S:'$D(@SCDATES@("END")) @SCDATES@("END")=SCEND
 S:'$D(@SCDATES@("INCL")) @SCDATES@("INCL")=SCINCL
 Q
 ;
 ; bp/cmf 177 - added SCFUTURE input param, used at PCPOSCNT+17
 ;;bp/cmf 177; orig entry call; PCPOSCNT(SCTP,SCDATE,SCPCONLY);this is a more efficient count of PC patients assigned to position
PCPOSCNT(SCTP,SCDATE,SCPCONLY,SCFUTURE) ;this is a more efficient count of PC patients assigned to position
 ; Input: SCTP - ien to 404.57
 ;        SCDATE - date of concern, default=DT
 ;        SCPCONLY - 1= must be pc, 0=all assignments 1=DEFAULT
 ;        SCFUTURE - 1= include future, 0=current 0=DEFAULT ;;bp/cmf 177
 ;returns count of patient assignments or -1 if error
 N SCPTPA,SCCNT,SCHSTIEN,SCNODE
 Q:'$G(SCTP) -1
 S SCDATE=$G(SCDATE,DT)
 S:'$L($G(SCPCONLY)) SCPCONLY=1
 S:'$L($G(SCFUTURE)) SCFUTURE=0 ;;bp/cmf 177 add
 S (SCPTPA,SCCNT)=0
 F  S SCPTPA=$O(^SCPT(404.43,"APTPA",SCTP,SCPTPA)) Q:'SCPTPA  D
 .S SCHSTIEN=0
 .F  S SCHSTIEN=$O(^SCPT(404.43,"APTPA",SCTP,SCPTPA,SCHSTIEN)) Q:'SCHSTIEN  D
 ..S SCNODE=$G(^SCPT(404.43,SCHSTIEN,0))
 ..Q:$P(SCNODE,U,4)&($P(SCNODE,U,4)<SCDATE)
 ..;;bp/cmf 177;orig code;;Q:$P(SCNODE,U,3)>SCDATE
 ..Q:('SCFUTURE)&($P(SCNODE,U,3)>SCDATE)  ;;bp/cmf 177 mod-use scfuture
 ..Q:SCPCONLY&('$P(SCNODE,U,5))  ;pc role is not 1 or 2
 ..S SCCNT=SCCNT+1
 Q SCCNT
 ;
TEAMCNT(SCTM,DATE) ;this is a more efficient version of the count
 N DFN,SCCNT,SCNODE,HISTIEN
 Q:'$G(SCTM) 0
 S DATE=$G(DATE,DT)
 S (DFN,SCCNT)=0
 F  S DFN=$O(^SCPT(404.42,"ATMPT",SCTM,DFN)) Q:'DFN  D
 .S HISTIEN=0
 .F  S HISTIEN=$O(^SCPT(404.42,"ATMPT",SCTM,DFN,HISTIEN)) Q:'HISTIEN  D
 ..S SCNODE=$G(^SCPT(404.42,HISTIEN,0))
 ..Q:$P(SCNODE,U,9)&($P(SCNODE,U,9)<DATE)
 ..Q:$P(SCNODE,U,2)>DATE
 ..S SCCNT=SCCNT+1
 Q SCCNT
 ;
TEAMCNT2(SCTM,DATE) ;this is the count of patients assigned to the team on a date
 ; Input: SCTM - ien to 404.51
 ;        DATE - date of concern, default=DT
 N SCX,SCDATES,SCTEAMS,SCERR,X
 S SCDATES("BEGIN")=$G(DATE,DT)
 S SCDATES("END")=SCDATES("BEGIN")
 S SCX=$$PTTM^SCAPMC(SCTM,"SCDATES","^TMP(""SCTEAMS"",$J,""CNT"")","SCERRX")
 IF 'SCX S X=-SCX
 ELSE  D
 .S DFN=0
 .F X=0:1 S DFN=$O(^TMP("SCTEAMS",$J,"CNT","SCPTA",DFN)) Q:'DFN
 K ^TMP("SCTEAMS",$J,"CNT")
 Q X
ACTHISTB(FILE,IEN) ;boolean active function
 ;MOVED TO SCAPMCU2
 Q $$ACTHISTB^SCAPMCU2(.FILE,.IEN)
ACTHIST(FILE,IEN,SCDATES,SCERR) ;is entry active for a time period?
 ;MOVED TO SCAPMCU2
 Q $$ACTHIST^SCAPMCU2(.FILE,.IEN,.SCDATES,.SCERR)
 ;
LASTDATE(FILE,IEN) ;gets last date for team or position from 404.52,404.58,404.59 - uses DATES function below
 ; Input Parameters:
 ;    File = either 404.52 or 404.58 or 404.59
 ;    IEN  = pointer to team(404.51) or team position(404.57)
 ; Returned:
 ;  -1 if error,o/w latest date defined 0=no historical dates
 N SCX
 S SCX=$$DATES(.FILE,.IEN,3990101) ; gets dates as of 1/1/2999
 Q $S($P(SCX,U,1)<0:-1,$P(SCX,U,3):$P(SCX,U,3),1:+$P(SCX,U,2))
 ;
DATES(FILE,IEN,DATE) ;used to return latest activation & inactivation date
 ; Input Parameters:
 ;    File = either 404.52, 404.53, 404.58, or 404.59
 ;    IEN  = pointer to team(404.51) or team position(404.57)
 ;    DATE = default=DT
 ;  Returned:
 ;  status^actdate^inactdate^scien^first actdate? [1=yes/null=no]
ST N ROOT,EFFDT,STATUS,ACTDT,INACTDT,X,FUTURE,PREVDT,SCTODAY,PREVST,SCSTAT,SCIEN,SCLAST
 S:'$G(DATE) DATE=DT
 S STATUS=-1,SCTODAY=0
 S SCSTAT=1
 ;bp/cmf - 177 change begin
 G:('$G(FILE))!("^404.52^404.53^404.58^404.59^"'[$G(FILE))!('$G(IEN)) QTDATES
 ;orig;G:('$G(FILE))!("^404.52^404.58^404.59^"'[$G(FILE))!('$G(IEN)) QTDATES
 ;bp/cmf - 177 change begin
 S ROOT="^SCTM("_FILE_",""AIDT"",IEN,SCSTAT"
 S EFFDT=-DATE
 S X=ROOT_")"
 ;if there is an active x-ref
 IF $D(@X) D
 .;if today is an activation date
 .IF $D(@X@(EFFDT)) S ACTDT=-EFFDT
 .;if today is not an activation date get previous one
 .ELSE  D
 ..S ACTDT=-$O(@X@(EFFDT))
 .;if no activation in past get one in future
 .S:'$G(ACTDT) ACTDT=-$O(@X@(EFFDT),-1),FUTURE=1
 .S SCSTAT=0
 .S INACTDT=$O(@X@(-(ACTDT-.000001)),-1),INACTDT=$S(INACTDT:-INACTDT,1:INACTDT)
 .S STATUS=$$DTCHK^SCAPU1(DATE,DATE,0,ACTDT,INACTDT)
 .S SCSTAT=STATUS
 .S X=ROOT_","_$S(SCSTAT:-ACTDT,1:-INACTDT)_")"
 .S SCIEN=$O(@X@(0))
 ELSE  D
 .S STATUS=0
QTDATES Q STATUS_U_$G(ACTDT)_U_$G(INACTDT)_U_$G(SCIEN)_U_$G(FUTURE)
 ;
ERR(SEQ,ERNUM,PARMS,OUTPUT,SCER) ;-- process errors
 ;if no dialog entry 4040000 will be processed
 S ERNUM=$G(ERNUM,4040000)
 S:'$$GET1^DIQ(.84,$G(ERNUM)_",",.01) ERNUM=4040000
 IF SCER]"" D
 . S SEQ=$G(SEQ,0)+1
 . S SCER(SEQ)=ERNUM
 . ;S @SCER@(0)=$G(@SCER@(0))+1 ;bp/djb 7/12/99
 . S SCER(0)=$G(SCER(0))+1
 . ;D BLD^DIALOG(.ERNUM,.PARMS,.OUTPUT,.SCER) ;bp/djb 7/12/99
 . D BLD^DIALOG(.ERNUM,.PARMS,.OUTPUT,"SCER")
 Q
 ;
OKTMPOS(TEAM,POSITION,DATE) ;validate legitimate position in a team for a dt
 ; used in screen for pc practitioner position of patient team assngt
 ;
 ; TEAM - ien of team file
 ; POSITION - ien of team position file
 ; DATE     - date of interest
 ; return 1 if ok, 0 ow
 ;
CHK ;
 N SCTP,SCOK,SCPOS0
 S SCOK=0
 S:'$L($G(SCERR)) SCERR="^TMP(""SCERR"",$J)"
 IF '$D(^SCTM(404.51,+$G(TEAM),0)) D  G QTOKTP
 . S SCPARM("TEAM")=$G(TEAM,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$D(^SCTM(404.57,+$G(POSITION),0)) D  G QTOKTP
 . S SCPARM("POSITION")=$G(POSITION,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 IF '$G(DATE) D  G QTOKTP
 . S SCPARM("DATE")=$G(DATE,"Undefined")
 . D ERR^SCAPMCU1(.SCESEQ,4045101,.SCPARM,"",.SCERR)
 S SCPOS0=$G(^SCTM(404.57,POSITION,0))
 ;if position not linked to team
 G QTOKTP:$P(SCPOS0,U,2)'=TEAM
 ;if not active position
 G QTOKTP:'$$DATES(404.59,POSITION,DATE)
 S SCOK=1
QTOKTP Q SCOK
RSNDICS(EVCODE) ; -- called by input transform and screen logic for type of reason
 ; Input: EVCODE = event code (e.g. ZM1)
 ;  Used to check for fields that point to Scheduling Reason File
 ;    Piece = Piece number of zero node of 
 Q $P(^SD(403.43,$P(^(0),U,2),0),U,1)=EVCODE
 ;
OKPREC(TEAM) ; - called by screen logic for preceptor position file (#.1) of team position (#404.57) file
 ;  Input; TEAM = Pointer to team file (#404.51) for team position with preceptor
 ; requires position being assigned to be a possible preceptor position
 ;  AND that position is from the same team as the supervised position
 Q ($P(^SCTM(404.57,Y,0),U,12))&($P(^SCTM(404.57,Y,0),U,2)=TEAM)
