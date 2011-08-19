SCUTBK3 ;MJK/ALB - RPC Broker Utilities ; SEP 99
 ;;5.3;Scheduling;**41,51,177,204**;AUG 13, 1993
 ;
GETUSER(SCDATA,SCDUZ) ; -- get user data
 ;
 ; input:                 SCDUZ -> user's id (DUZ)
 ;output: for success SCDATA(0) -> duz ^ name ^ default query id ^ default institution name
 ;        for failure SCDATA(0) -> 0 ^ <number of errors>
 ;                      (1...n) -> error text
 ;
 ; Related RPC: SCUT GET USER RECORD
 ;
 ;
 ;I $$VAPVER(XWBAPVER) D CLOSE^%ZISTCP Q  ;old clients off / future
 N X,DIERR,SCPARM
 IF SCDUZ="CURRENT USER" S SCDUZ=+$G(DUZ)
 S X=$G(^VA(200,+SCDUZ,0))
 IF X]"" D
 . N Y
 . S SCDATA(0)=+SCDUZ_U_$P(X,U)_U_$$DEFAULT(SCDUZ)
 . D GETENV^%ZOSV
 . S SCDATA(0)=SCDATA(0)_U_Y_U_$P($G(^DIC(4,DUZ(2),0)),U,1)
 ELSE  D
 . S SCPARM("USER ID")=SCDUZ
 . D BLD^DIALOG(4030005.001,.SCPARM,"","SCDATA","S")
 . D HDREC(.SCDATA,$G(DIERR),"Scheduling User Data Retrieval")
 Q
 ;
DEFAULT(SCDUZ) ; -- get default query for user
 N X
 S X=+$P($G(^SCRS(403.35,+SCDUZ,"PCMM")),U,15)
 IF 'X S X=+$O(^SD(404.95,"B","System Default",0))
 S X=X_U_$P($G(^SD(404.95,+X,0),"Unknown"),U)
 Q X
 ;
SETDEF(SCDATA,SCDUZ,SCQRY) ; -- set user's default query
 ; input:                 SCDUZ -> user's id (DUZ)
 ;                        SCQRY ->query ien
 ;output: for success SCDATA(0) -> 1
 ;        for failure SCDATA(0) -> 0 ^ <number of errors>
 ;                      (1...n) -> error text
 ;
 ;
 ; Related RPC: SCUT SET USER QUERY DEFAULT
 ;
 N SCVAL,SCFDA,SCIENS,SCERR,DIERR,SCPROC
 S SCPROC="Setting User Query Default"
 S SCFDA="SCFDA",SCIENS="SCIENS",SCERR="SCERR"
 ; -- make sure user has param rec
 IF '$D(^SCRS(403.35,+SCDUZ,0)) D  G:$O(SCDATA(0)) SETDEFQ
 . D FDA^DILF(403.35,"+1,",.01,"",+SCDUZ,SCFDA,SCERR)
 . S SCIENS(1)=+SCDUZ
 . D UPDATE^DIE("",SCFDA,SCIENS,SCERR)
 . D ERRCHK(.SCDATA,.SCERR,SCPROC)
 ;
 ; -- set default
 K SCFDA,SCIENS,SCERR,SCVAL
 S SCFDA="SCFDA",SCIENS="SCIENS",SCERR="SCERR"
 S SCVAL=$S(SCQRY:SCQRY,1:"@")
 D FDA^DILF(403.35,+SCDUZ_",",1.15,"",SCVAL,SCFDA,SCERR)
 D FILE^DIE("K",SCFDA,SCERR)
 D ERRCHK(.SCDATA,.SCERR,"Setting User Query Default")
SETDEFQ Q
 ;
VERPAT(SCRESULT,SCPATCH) ;
 ;       for rpc SCMC VERIFY C/S SYNC
 ;       input  := ServerPatch^ClientVersion
 ;       output := SCRESULT: 0 = Not Continue
 ;                           1 = Continue (pre SD*5.3*204)
 ;                           n = RpcTimeLimit (after SD*5.3*204)
 ;
 N SCX
 ;
 ; site turned off all clients?
 S SCRESULT=$$DISCLNTS^SCMCUT()'=1
 I SCRESULT=0 Q
 ;
 ; hook for complex RPCVersion checker
 S SCRESULT=$$VAPVER(XWBAPVER)
 ;
 ; if programmer, OK, quit
 I $$VPROGMR() Q
 ;
 ; hook for complex patch existence checker
 I $$VPATCH(SCPATCH)'=1 S SCRESULT=0 Q
 ;
 ; hook for complex executable version checker
 I $$VCLIENT(SCPATCH) S SCRESULT=0
 ;
 Q
 ;
VPROGMR() ; check if user is programmer
 N SCX
 D SECKEY^SCUTBK11(.SCX,"XUPROG")
 Q SCX=1
 ;
VAPVER(SCX) ; check client RPCVersion
 ;       ; input SCX := client RPCVersion(server XWBAPVER)
 ;       ; output    := RpcTimeLimit
 I +SCX<204 Q 1
 S SCX=+$O(^SCTM(404.44,0))
 I SCX<1 Q 0
 S SCX=+$P($G(^SCTM(404.44,SCX,1)),U,4)
 Q $S(SCX<30:30,SCX>300:300,1:SCX)
 ;
VCLIENT(SCX) ; check executable version/update if new
 ;       ; input SCX := server^client (versions)
 ;Q 0     ; hook for more complex checker
 N SCSER,SCCLI
 S SCSER=$P(SCX,U)
 I SCSER']"" Q 1
 S SCCLI=$P(SCX,U,2)
 I SCCLI']"" Q 1
 ;
 ;OK if on active list
 N SC1,SC1LIST
 S SC1=$$CLNLST^SCMCUT(SCSER,"SC1LIST",1)
 I SC1,$D(SC1LIST(SCCLI)) Q 0
 ;
 ;stop if on inactive list
 N SC2,SC2LIST
 S SC2=$$CLNLST^SCMCUT(SCSER,"SC2LIST",0)
 I SC2,$D(SC2LIST(SCCLI)) Q 1
 ;
 ;add client/server pair, OK if update
 Q '$$UPCLNLST^SCMCUT(SCX)
 ;
VPATCH(SCX) ; check server version
 ;       ; input SCX := server^client (versions)
 Q $$PATCH^XPDUTL($P(SCX,U))
 ;
 ; >>>> Error Processing Utilities <<<<
 ;
HDREC(SCDATA,SCER,SCPROC) ; -- build zeroth of SCDATA array
 IF SCER D
 . S SCDATA(0)=0_U_+SCER_U
 . D SETPROC(.SCDATA,.SCPROC)
 ELSE  D
 . S SCDATA(0)=1_U_U ; no errors
 Q
 ;
SETPROC(SCDATA,SCPROC) ; -- set process name for error list
 S $P(SCDATA(0),U,3)=SCPROC
 Q
 ;
ERRCHK(SCDATA,SCERR,SCPROC) ; -- process fileman dbs errors
 N SCERS
 S SCERS=$G(SCERR("DIERR"))
 IF SCERS D MSG^DIALOG("EA",.SCDATA,"","",SCERR)
 D HDREC(.SCDATA,SCERS,SCPROC)
 Q
 ;
