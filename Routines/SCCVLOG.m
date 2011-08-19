SCCVLOG ;ALB/RMO,TMP - CST/AST Log Utilities - Log Event; [ 04/05/95  8:39 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
UPDREC(SCLOG,SCIEN,SCCVT) ;Update CST/AST last entry and number of records
 ; Input  -- SCLOG    CST/AST log IEN
 ;           SCIEN    Last entry IEN
 ;           SCCVT    'AST' or 'CST' for type of template
 ; Output -- None
 N SCDATA,SCCVFL
 S SCCVFL=$S(SCCVT="CST":"404.98",1:"404.99")
 S SCDATA(1.01)=SCIEN ;last entry converted
 S SCDATA(1.02)=$G(SCTOT(1.02)) ;number of records converted
 S SCDATA(2.06)=$G(SCTOT(2.06)) ;number of records not converted
 I $D(^SD(SCCVFL,+SCLOG,0)) D UPD^SCCVDBU(SCCVFL,SCLOG,.SCDATA)
 Q
 ;
UPD(SCCVT,SCLOG,SCSTDT,SCENDT,SCOMBUL,SCTSK,SCVOL,SCACT) ;Update CST or AST log entry
 ; Input  -- SCCVT    'AST' or 'CST' for type of template
 ;           SCLOG    CST or AST log IEN
 ;           SCSTDT   Start date               [optional]
 ;           SCENDT   End date                 [optional]
 ;           SCOMBUL  Bulletin upon completion [optional]
 ;           SCTSK    Task #                   [optional]
 ;           SCVOL    Volume set               [optional]
 ;           SCACT    Action                   [optional]
 ; Output -- None
 N SCDATA,SCCVFL
 S SCCVFL=$S(SCCVT="CST":"404.98",1:"404.99")
 I $G(SCACT) D HIS($$NOW^XLFDT,SCLOG,SCACT,"",SCCVFL,$G(SCTSK))
 S:$G(SCSTDT) SCDATA(.03)=SCSTDT ;start date
 S:$G(SCENDT) SCDATA(.04)=SCENDT ;end date
 S:$G(SCOMBUL)'="" SCDATA(.06)=SCOMBUL ;bulletin upon completion
 I $G(SCACT)=2,$P($G(^SD(SCCVFL,SCLOG,0)),U,8)'=3 D  ;initialize fields when starting, but not on a restart
 . S SCDATA(1.01)="@" ;last entry
 . S SCDATA(1.02)=0 ;number of records
 . S SCDATA(2.06)=0 ;number of records
 S:$G(SCTSK)'="" SCDATA(1.03)=SCTSK ;task #
 S:$G(SCVOL)'="" SCDATA(1.04)=SCVOL ;volume set
 I $D(SCDATA) D UPD^SCCVDBU(SCCVFL,SCLOG,.SCDATA)
 Q
 ;
HIS(SCEVDTM,SCLOG,SCACT,SCCVEVT,SCCVFL,SCTSK) ; CST/AST Log history
 ; Input  -- SCEVDTM  Event date/time
 ;           SCLOG    CST/AST log IEN
 ;           SCACT    Action
 ;           SCCVEVT  Last log status
 ;           SCCVFL   'AST' or 'CST' file # (404.98 or 404.99)
 ;           SCTSK    task # [optional]
 ; Output -- None
 N C,SCACTD,SCCVEVTD,SCDATA,SCHIS,SCIENS,SCLOG0,Y
 S SCHIS=+$O(^SD(SCCVFL,SCLOG,"E","AEV",SCEVDTM,SCACT,0))
 G HISQ:SCHIS
 S SCIENS="+1,"_SCLOG
 S SCDATA(.01)=SCEVDTM ;event date/time
 S SCDATA(.02)=$S(SCCVEVT'=3:SCACT,1:7) ;action
 S SCLOG0=$G(^SD(SCCVFL,SCLOG,0))
 S:$G(SCCVEVT)="" SCCVEVT=$S('$P(SCLOG0,U,9):$P(SCLOG0,U,5),1:3)
 S:$G(SCCVEVT)'="" SCDATA(.03)=SCCVEVT ;event
 IF '$G(SCTSK) N SCTSK S SCTSK=$P($G(^SD(SCCVFL,SCLOG,1)),U,3) ;task number
 I SCTSK D  ;task comment
 . S SCACTD=$$LOW^XLFSTR($$EXPAND^SCCVDSP2(SCCVFL_"75",.02,SCACT))
 . I $G(SCCVEVT)'="",SCCVEVT<3 D
 . . S Y=$$EXPAND^SCCVDSP2(SCCVFL_"75",.03,SCCVEVT)
 . . S SCCVEVTD=$E(Y,1)_$$LOW^XLFSTR($E(Y,2,$L(Y)))
 . S:$G(SCCVEVT)<3 SCDATA(50,"WP",1)=SCCVEVTD_" "_SCACTD_" as task #"_SCTSK
 . S:$G(SCCVEVT)=3 SCDATA(50,"WP",1)="Template canceled by user #: "_$G(DUZ)
 . S SCDATA(50)=$NA(SCDATA(50,"WP"))
 D ADD^SCCVDBU(SCCVFL_"75",SCIENS,.SCDATA)
 I SCCVFL=404.98,"^3^5^"[(U_SCACT_U) D
 . ;Update file with estimate totals
 . I 'SCCVEVT,SCACT=5,$O(SCTOT(0)) D UPDTOTL^SCCVEGU1(SCLOG,.SCTOT)
 . ; 
 . I $P($G(^SD(404.98,SCLOG,0)),U,6) D  ;send bulletin
 . . I SCCVEVT D  ;convert if complete or stopped
 . . . D SEND^SCCVLOG2(SCLOG,SCACT)
 . . ELSE  I SCACT=5 D  ;estimate only when complete
 . . . D MAILSUM^SCCVEGD0(SCLOG)
HISQ Q
 ;
CHKACT(SCLOG,SCCVEVT,SCACT,SCCVT) ;Check log entry action for a specific log event
 ; Input  -- SCLOG    CST/AST log IEN
 ;           SCCVEVT  CST/AST event
 ;           SCACT    Action
 ;           SCCVT    'AST' or 'CST' for type of template
 ; Output -- 1=Found and 0=Not Found
 N A,D,E,Y,SCCVFL
 S (D,Y)=0
 S SCCVFL=$S(SCCVT="CST":"404.98",1:"404.99")
 F  S D=$O(^SD(SCCVFL,SCLOG,"E","AEV",D)) Q:'D!(Y)  D
 . S E=""
 . F E=$O(^SD(SCCVFL,SCLOG,"E","AEV",D,E)) Q:E=""!(Y)  I E=SCCVEVT D
 . . S A=0
 . . F  S A=$O(^SD(SCCVFL,SCLOG,"E","AEV",D,E,A)) Q:'A!(Y)  I A=SCACT S Y=1
 Q +$G(Y)
 ;
STOP(SCLOG,SCREQ,SCSTOPF) ;Stop conversion/estimate
 ; Input  -- SCLOG    CST log IEN
 ;           SCREQ    CST request IEN
 ;           SCSTOPF  Force exit [optional]
 ; Output -- SCSTOPF  1=Stopped and 0=Not stopped
 N SCREQ0,SCLOG1,SCFORCEX
 ;
 ; -- force exit if calling routine says to
 S SCFORCEX=+$G(SCSTOPF)
 ;
 ; -- force exit if too many errors have occurred
 IF 'SCFORCEX,$G(SCCVMAXE),$G(SCCVERRH)>SCCVMAXE S SCFORCEX=1
 ;
 S SCSTOPF=0
 ;
 I +$$LSTACT(SCLOG)=5 G STOPQ ;already completed
 S SCREQ0=$G(^SD(404.98,SCLOG,"R",SCREQ,0))
 S SCLOG1=$G(^SD(404.98,SCLOG,1))
 I $S(SCFORCEX:1,$$S^%ZTLOAD:1,$P(SCREQ0,U,2)=2:1,$P(SCREQ0,U,5):$P(SCREQ0,U,5)<$$NOW^XLFDT,1:0) D
 . D UPD("CST",SCLOG,"","","","@","@",3)
 . ;
 I +$$LSTACT(SCLOG)=3 D
 . S SCSTOPF=1
 . ;
 . ; stopping a running task
 . I $D(ZTQUEUED) S ZTSTOP=1 Q
 . ;
 . ; -- kill/stop a pending task
 . N ZTSK
 . S ZTSK=$P(SCLOG1,U,3)
 . ; -- get status
 . IF ZTSK]"" D ISQED^%ZTLOAD
 . ; -- kill task if task is pending
 . IF $G(ZTSK(0)) D KILL^%ZTLOAD
 . ;
STOPQ Q
 ;
LSTACT(SCLOG) ;Last action taken on CST log entry
 ; Input  -- SCLOG    CST log IEN
 ; Output -- Action^Description
 N SCACT,Y
 S SCACT=$P($G(^SD(404.98,SCLOG,0)),U,7)
 I $G(SCACT) S Y=SCACT_U_$$EXPAND^SCCVDSP2(404.9875,.02,SCACT)
 Q $G(Y)
 ;
LSTEVT(SCLOG) ;Last event performed on CST log entry
 ; Input  -- SCLOG    CST log IEN
 ; Output -- event
 N SCEVT
 S SCEVT=$P($G(^SD(404.98,SCLOG,0)),U,5)
 Q SCEVT
 ;
LSTREQ(SCLOG) ;Returns the # of the last request for a CST
 ; Input  -- SCLOG    CST log IEN
 ; Output -- Last request ien
 ;
 Q +$O(^SD(404.98,SCLOG,"R","A"),-1)
 ;
