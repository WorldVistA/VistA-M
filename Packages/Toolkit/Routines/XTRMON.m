XTRMON ;ISCSF/RWF - Watch for changes in routine checksums. ;02 Jul 2003 2:59 pm
 ;;7.3;TOOLKIT;**27,59,70**;Apr 25, 1995
A N CNT,NOW,MODE,RTN,RN,RSUM,TEST,XMB,DA,DIC,X0,OS
 K ^TMP($J)
 S CNT=0,NOW=$$HTFM^XLFDT($H),U="^"
 S RSUM=^%ZOSF("RSUM"),TEST=^%ZOSF("TEST")
 S OS=^%ZOSF("OS")
 S MODE=$G(^XTV(8989.3,1,"RM")) I "n"[$E(MODE) Q
 G ALL:"a"=$E(MODE)
SEL S RTN=""
 F  S RTN=$O(^XTV(8989.3,1,"RM1","B",RTN)) Q:RTN=""  D
 . I RTN["*" D RANGE($P(RTN,"*")) Q
 . D CHK(RTN)
 . Q
EXIT ;
 D LOST
 S XMB="XTRMON",XMTEXT="^TMP($J,",XMB(1)=$$FMTE^XLFDT(NOW,1),XMB(2)=CNT
 X ^%ZOSF("UCI") S XMB(3)=Y
 D:CNT>0 ^XMB
 K XMB,CNT,RN,RTN
 Q
 ;
RANGE(RTN) ;Check a N-space
 S RN=RTN D CHK(RTN) ;Check for rtn with namespace name
 I OS["GT.M" G GRNG
 F  S RN=$O(^$ROUTINE(RN)) Q:$E(RN,1,$L(RTN))'=RTN  D CHK(RN)
 Q
 ;
GRNG ;Check a N-space in GT.M
 N X,RA,RY,RX S RSUM="S Y=$$RSUM^%ZOSV2(X)"
 I '$D(ZTQUEUED) W !,"Namespace: "_RTN
 S X=$ZSEARCH("*.X"),RA=$$RTNDIR^%ZOSV_RTN,RY=RA_"*.m"
 F  S RX=$ZSEARCH(RY) Q:(RX="")!(RX'[RA)  D
 . S RX=$TR(RX,"]","/"),RN=$P($P(RX,"/",$L(RX,"/")),".",1)
 . D CHK(RN)
 Q
 ;
ALL ;Check all routines
 I OS["GT.M" G GALL
 S RN="" F  S RN=$O(^$ROUTINE(RN)) Q:RN=""  D CHK(RN)
 G EXIT
 ;
GALL ;GT.M all routines
 N X,RY,RX S RSUM="S Y=$$RSUM^%ZOSV2(X)"
 S X=$ZSEARCH("*.X"),RY=$$RTNDIR^%ZOSV_"A.m"
 F  S RX=$ZSEARCH(RY) Q:(RX="")!(RX'["*")  D
 . S RX=$TR(RX,"]","/"),RN=$P($P(RX,"/",$L(RX,"/")),".",1) D CHK(RN)
 G EXIT
 ;
CHK(RN) ;Check one routine
 N $ET,$ES S $ET="D CHKERR^XTRMON Q"
 S X=RN X TEST Q:'$T
 S DA=$O(^DIC(9.8,"B",RN,0)) I DA<1 D  Q:DA'>0  ;See if RN is in file
 . S X=RN,DIC="^DIC(9.8,",DIC(0)="ML" D FILE^DICN ;No, so add
 . S DA=+Y I DA>0 S DIE=DIC,DR="1///R" D ^DIE ;Set routine flag
 . Q
 S X0=^DIC(9.8,DA,0),X=RN X RSUM I '$D(ZTQUEUED) W "." ;Test
 Q:(Y<0)!(Y=+$P(X0,U,5))
 D LOG($E(RN_"          ",1,10)_$S($P(X0,U,5)>0:"Has changed, Old: "_$P(X0,U,5)_" New: "_Y,1:"Is new"))
 I '$D(ZTQUEUED) W !,RN,?10,$S($P(X0,U,5)>0:"Has changed",1:"Is new")
 S $P(^DIC(9.8,DA,0),U,5,6)=Y_U_NOW
 Q
 ;
CHKERR ;Handle an error during check
 S $ET="D ^%ZTER G UNWIND^%ZTER"
 D LOG(RN_" Caused an error: "_$$EC^%ZOSV)
 S Y=-1,$EC="" ;Set Y=-1 to stop test
 Q
 ;
LOG(MSG) ;Record message
 S CNT=CNT+1,^TMP($J,CNT,0)=MSG
 Q
 ;
LOST ;Look for routines no-longer in the system
 I '$D(ZTQUEUED) W !,"Starting LOST routine check."
 S RTN=""
 F  S RTN=$O(^DIC(9.8,"B",RTN)) Q:RTN=""  D
 . Q:$E(RTN)="%"
 . S IX=$O(^DIC(9.8,"B",RTN,0)),X0=$G(^DIC(9.8,+IX,0)) Q:$P(X0,U,2)="PK"
 . S X=RTN X TEST Q:$T
 . D LOG($E(X_"          ",1,10)_"Not in UCI")
 . S DA=IX,DIK="^DIC(9.8," D ^DIK
 . Q
 Q
