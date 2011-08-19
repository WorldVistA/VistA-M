SCCVE ;ALB/RMO,TMP - Encounter Conversion Driver; [ 04/05/95  8:19 AM ]
 ;;5.3;Scheduling;**211**;Aug 13, 1993
 ;
QUE(SCLOG,SCREQ) ;Schedule encounter conversion via task manager
 ; Input  -- SCLOG    CST log IEN
 ;           SCREQ    CST request IEN
 ; Output -- None
 N I,SCERRMSG,SCREQ0,SCREQD,Y,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S SCREQ0=$G(^SD(404.98,SCLOG,"R",SCREQ,0))
 ;
 ; -- quit if convert or reconvert & conversion disabled
 IF $P(SCREQ0,U,3)=1!($P(SCREQ0,U,3)=2),'$$OK^SCCVU(1) G QUEQ
 ;
 I SCREQ0="" D  G QUEQ
 . N SCERRIP
 . S SCERRIP(1)=SCLOG
 . S SCERRIP(2)=SCREQ
 . S SCERRIP(3)="Conversion"
 . D GETERR^SCCVLOG1(4049004.001,"",.SCERRIP,SCLOG,0,.SCERRMSG)
 S SCREQD=$$LOW^XLFSTR($$EXPAND^SCCVDSP2(404.9825,.02,$P(SCREQ0,U,2)))
 S ZTDESC="CST Log #"_SCLOG_" - "_SCREQD_" ("_$$LOW^XLFSTR($$EXPAND^SCCVDSP2(404.9825,.03,$P(SCREQ0,U,3)))_")"
 S ZTRTN="EN^SCCVE"
 F I="SCLOG","SCREQ" S ZTSAVE(I)=""
 S ZTIO="SCCV RESOURCE"
 S ZTDTH=$S($P(SCREQ0,U,4):$P(SCREQ0,U,4),1:$$NOW^XLFDT)
 D ^%ZTLOAD
 I $D(ZTSK) D
 . W "  (Task: #",ZTSK,")"
 . D UPD^SCCVLOG("CST",SCLOG,"","","",ZTSK,$G(^%ZOSF("VOL")),6)
QUEQ Q
 ;
EN ;Entry point to run encounter estimate/conversion
 ; Input  -- SCLOG    CST log IEN
 ;           SCREQ    CST request IEN
 ; Output -- None
 N SCACT,SCCVEVT,SCEND,SCERRMSG,SCRSTDT,SCRSTPT,SCSTDT,SCSTOPF,SCBULL,SCTOT,SCRSTDFN,SCCVERRH,SCCVERRT,SCCVDIS,SCCVACRP,SCCV900,ZZLOG,SCCVMAXE
 I '$G(SCLOG)!('$G(SCREQ))!('$G(DUZ)) D  G ENQ ;req vars missing
 . N SCERRIP
 . S SCERRIP(1)=$S('$G(SCLOG):"SCLOG",'$G(SCREQ):"SCREQ",1:"DUZ")
 . S SCERRIP(2)="EN^SCCVE"
 . D GETERR^SCCVLOG1(4040001.001,"",.SCERRIP,$G(SCLOG),0,.SCERRMSG)
 . I $G(SCLOG),$G(SCREQ) D STOP^SCCVLOG(SCLOG,SCREQ,1)
 ;
 ; -- set overall variables
 S SCCVACRP=$$ENDDATE^SCCVU()
 S SCCV900=+$O(^DIC(40.7,"C",900,0))
 S SCCVMAXE=$S($P($G(^SD(404.91,1,"CNV")),U,7):$P(^("CNV"),U,7),1:1000)-1
 ;
 D SET(SCLOG,SCREQ,.SCACT,.SCCVEVT,.SCSTDT,.SCENDT,.SCRSTPT,.SCRSTDT,.SCBULL,.SCRSTDFN)
 ;
 ; -- quit if convert or reconvert & conversion disabled
 IF SCCVEVT=1!(SCCVEVT=2),'$$OK^SCCVU(0) G ENQ
 ;
 ;Log event
 D UPD^SCCVLOG("CST",SCLOG,"","","","","",SCACT)
 ;
 I $G(SCCVEVT)=1,$$CHKACT^SCCVLOG(SCLOG,SCCVEVT,5,"CST") D  G ENQ ;converted
 . D GETERR^SCCVLOG1(4049001.008,"","",SCLOG,0,.SCERRMSG)
 ;
 I "^2^4^"'[(U_SCACT_U) D  G ENQ ;start or re-start
 . D GETERR^SCCVLOG1(4049006.001,"","",SCLOG,0,.SCERRMSG)
 . D STOP^SCCVLOG(SCLOG,SCREQ,1)
 ;
 I '$G(SCSTDT)!('$G(SCENDT)) D  G ENQ ;start date or end date undefined
 . D GETERR^SCCVLOG1(4049001.003,"","",SCLOG,0,.SCERRMSG)
 . D STOP^SCCVLOG(SCLOG,SCREQ,1)
 ;
 I $G(SCCVEVT)="" D  G ENQ ;event undefined
 . D GETERR^SCCVLOG1(4049001.009,"","",SCLOG,0,.SCERRMSG)
 . D STOP^SCCVLOG(SCLOG,SCREQ,1)
 ;
 I $$VERDT^SCCVU2(SCSTDT,SCENDT,SCLOG) D  G ENQ ;invalid date range
 . D STOP^SCCVLOG(SCLOG,SCREQ,1)
 ;
 S (SCCVERRH,SCCVERRT)=+$P($G(^SD(404.98,SCLOG,1)),U,5)
 I SCCVEVT S SCTOT(1.02)=$P($G(^SD(404.98,SCLOG,1)),U,2),SCTOT(2.06)=$P($G(^(2)),U,6)
 I 'SCCVEVT K ^XTMP("SCCV-VIS-"_SCLOG),^XTMP("SCCV-BOTH-"_SCLOG)
 ;
 ;Convert appointments
 I $G(SCRSTPT)<2 D EN^SCCVEAP(SCCVEVT,SCSTDT,SCENDT,SCLOG,SCREQ,+$G(SCRSTDFN),.SCSTOPF) G ENQ:$G(SCSTOPF) I $G(SCRSTPT) S (SCRSTDT,SCRSTDFN)=""
 ;
 ;Convert disposition
 I $S('$G(SCRSTPT):1,1:SCRSTPT'=2) D EN^SCCVEDI(SCCVEVT,$S($G(SCRSTDT):SCRSTDT,1:SCSTDT),SCENDT,SCLOG,SCREQ,.SCSTOPF) G ENQ:$G(SCSTOPF) I $G(SCRSTPT) S (SCRSTDT,SCRSTDFN)=""
 ;
 ;Convert add/edits
 D EN^SCCVEAE(SCCVEVT,$S($G(SCRSTDT):SCRSTDT,1:SCSTDT),SCENDT,SCLOG,SCREQ,.SCSTOPF) G ENQ:$G(SCSTOPF)
 ;
 ;Log completion
 D UPD^SCCVLOG("CST",SCLOG,"","","","@","@",5)
 ;
ENQ Q
 ;
SET(SCLOG,SCREQ,SCACT,SCCVEVT,SCSTDT,SCENDT,SCRSTPT,SCRSTDT,SCBULL,SCRSTDFN) ;
 ; Set variables
 ; Input  -- SCLOG    CST log IEN
 ;           SCREQ    CST request IEN
 ; Output -- SCACT    Action
 ;           SCCVEVT  Conversion event
 ;           SCSTDT   Start date
 ;           SCENDT   End date
 ;           SCRSTPT  Conversion re-start point (1=appt, 2=a/e, 3=disp)
 ;           SCRSTDT  Re-start date
 ;           SCBULL   Send bulletin flag
 ;           SCRSTDFN  Re-start dfn
 N SCLOG0,SCLOG1,SCOE,SCOE0,SCREQACT
 S SCLOG0=$G(^SD(404.98,SCLOG,0)),SCLOG1=$G(^(1))
 S SCREQACT=$P($G(^SD(404.98,SCLOG,"R",SCREQ,0)),U,2)
 S SCACT=$S(SCREQACT=1:2,SCREQACT=3:4,1:"") ;action based on request
 S SCCVEVT=$P(SCLOG0,U,5)
 S SCSTDT=$P(SCLOG0,U,3)
 S SCENDT=$P(SCLOG0,U,4)
 S SCBULL=$P(SCLOG0,U,6)
 ;
 I +SCLOG1,SCCVEVT,SCACT=4 D  ;Only for re-start of conversion
 . S SCOE=+SCLOG1 ;last entry
 . I $P($G(^SCE(SCOE,0)),U,6) S SCOE=+$P(^(0),U,6) ;re-start at parent
 . S SCOE0=$G(^SCE(SCOE,0))
 . S SCRSTPT=+$P(SCOE0,U,8),SCRSTDT=$P(+SCOE0,"."),SCRSTDFN=$P(SCOE0,U,2) ;set re-start point
 ;
 I 'SCCVEVT D  ;Estimate must start counting over from beginning
 .N Z,SC2,SCDATA,SCF
 .S SC2=$G(^SD(404.98,SCLOG,2))
 .F Z=1:1:11 I $P(SC2,U,Z) S SCF="2."_$S(Z<10:"0",1:"")_Z,SCDATA(+SCF)=0
 .I $D(SCDATA) D UPD^SCCVDBU(404.98,SCLOG,.SCDATA) ;Re-set totals to 0
 ;
 I SCCVEVT=2,SCACT'=4 D  ;'Start' of re-convert deletes errors and resets counts to 0
 . N SCDATA
 . S SCDATA(1.05)=0,SCDATA(50)="@",SCDATA(2.06)=0,SCDATA(1.02)=0
 . D UPD^SCCVDBU(404.98,SCLOG,.SCDATA)
 Q
 ;
STOP(SCLOG,SCREQ) ;User request to stop conversion
 ; Input  -- SCLOG    CST log IEN
 ;           SCREQ    CST request IEN
 ; Output -- None
 N SCSTOPF
 D STOP^SCCVLOG(SCLOG,SCREQ,.SCSTOPF)
 Q
 ;
