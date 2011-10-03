XUSCLEAN ;SF/STAFF - CLEANUP BEFORE EXIT ;10/26/06  08:12
 ;;8.0;KERNEL;**13,59,165,353,434**;Jul 10, 1995;Build 6
H ;;Exit point for all R/S applications
 LOCK  ;Unlock any locks
 S U="^"
 ;Unwind Exit Actions
 I $D(^XUTL("XQ",$J,"T")) S %XQEA=^("T") D
 . F %XQEA1=%XQEA:-1:1 I $D(^XUTL("XQ",$J,%XQEA1)),$P(^(%XQEA1),U,16) S %XQEA2=+^(%XQEA1) I $D(^DIC(19,%XQEA2,15)),$L(^(15)) X ^(15)
 K %XQEA,%XQEA1,%XQEA2
 ;Jump if the home device was closed
 G:$D(IO("C")) H2
 ;Clear the screen
 I $S($D(IOST)[0:1,IOST="":1,IOST["C-":1,1:0),'$D(XUERF) W !!!!!!!!!!!!!!!!!!!!!!!
 I $D(XQNOLOG) W !!,"==>  Sorry, all activity on this volume set is being halted!  Try again later.",*7,*7,*7,!!!!
 ;W !!,"Halting at " S X=$P($H,",",2),Y=$E(X#3600\60+100,2,3),X=X\3600,Z=0 S:X>11 Z=1 S:'X X=12 S:X>12 X=X-12 W X,":",Y," ",$S(Z:"pm",1:"am")
 W !!,"Logged out at "_$$HTE^XLFDT($H,"1FMP")
 D:$D(DUZ("NEWCODE")) NEWCODE
 ;NON-R/S exit thru here also.
H2 ;No talking after this point
 D C,XUTL
 ;un-comment the following line if you want FM space recall cleared
 ;after each session.
 ;K ^DISV($G(DUZ,0))
 S:'($D(XQXFLG)#2) XQXFLG="" I $D(XQCH),XQCH="HALT" S $P(XQXFLG,U,3)=""
 I ($D(XQNOHALT)#2)!($D(ZTQUEUED)#2)!($P(XQXFLG,U,3)="XUP") K XQNOHALT,XQXFLG Q  ;Return to REST^XQ12, ^XUP or Taskman.
 ;This was for modem hang up code. Obsolete now
 I $D(^%ZIS("H"))#2 X ^("H")
 ;Go to ZU to do final halt.
 G HALT^ZU
 ;
TOUCH ;SR. API to set the keepalive node, Only set once a day
 Q:+$G(^XUTL("XQ",$J,"KEEPALIVE"))=+$H
 S ^XUTL("XQ",$J,"KEEPALIVE")=$H
 Q
 ;
C ;Do device close execute, User exit.
 N XUDEV
 S XUDEV=$S($D(^XUTL("XQ",$J,"IOS")):^("IOS"),1:"")
 D ^%ZISC,BYE
 Q
 ;
 ;Called from Broker, VistaLink, R/S
BYE ;Set flags to show user has left. Called from anyplace the user exits
 N DA,DIK,R0,%
 I $G(^VA(200,+$G(DUZ),1.1)) S $P(^VA(200,DUZ,1.1),"^",3)=0
 S DA=+$G(^XUTL("XQ",$J,0)) D LOUT(DA)
 I $D(^XUSEC(0,DA,0)) D
 . S R0=^XUSEC(0,DA,0)
 . I $G(IO("IP"))]"",$P(R0,"^",13)]"" S %=$$CMD^XWBCAGNT(.R0,"XWB DELETE HANDLE",$P(R0,"^",13))
 K ^XUTL("XQ",$J)
 Q
 ;
LOUT(DA) ;Enter log-out time, in Sign-on log
 N DIK
 I $D(^XUSEC(0,DA,0)) D
 . S R0=^(0),$P(^(0),"^",4)=$$NOW^XLFDT,DIK="^XUSEC(0,",DIK(1)="3" D EN1^DIK
 Q
 ;
XUTL ;Cleanup JOB temporary Globals
 N XQN D CLEAN^DILF ;Cleanup FM too.
 K ^XUTL($J),^UTILITY($J),^TMP($J)
 S XQN=" " F  S XQN=$O(^XUTL(XQN)) Q:XQN=""  K:"^XQO^XGATR^XGKB^"'[XQN ^XUTL(XQN,$J)
 S XQN=" " F  S XQN=$O(^TMP(XQN)) Q:XQN=""  K ^TMP(XQN,$J)
 S XQN=" " F  S XQN=$O(^UTILITY(XQN)) Q:XQN=""  K:"^ROU^GLO^LRLTR"'[XQN ^UTILITY(XQN,$J)
 K ^XUTL("ZISPARAM",$I)
 Q
 ;
NEWCODE ;Remind user they changed there VC.
 W !!,*7,"But, as I recall...",!,"You've changed your VERIFY CODE during this session.",!,"Please remember it for next time." H 4
 Q
 ;
 ;Entry point to clear symbol table
KILL ;SR. This is what was requested.
 K %1,%2,%3 S %3=+$G(^XUTL("XQ",$J,"T"))
 ;See if Menu stack has Variable to protect.
 F %1=%3:-1:1 S %2=+$G(^XUTL("XQ",$J,%1)),%2=$G(^DIC(19,%2,"NOKILL")) I %2]"" N @%2
 ;Fall into next part of kill.
KILL1 ;To clean up ALL but kernel variables.
 I $$BROKER^XWBLIB S %2=$P($T(VARLST^XWBLIB),";;",2) I %2]"" N @%2 ;Protect Broker variables.
 N XGWIN,XGDI,XGEVENT ;P434 remove KWAPI
 N XQAEXIT,XQAUSER,XQX1,XQAKILL,XQAID
 ;p434 add DILOCKTM, remove XRTL, %ZH0
 K (DUZ,DTIME,DILOCKTM,DT,DISYS,IO,IOBS,IOF,IOM,ION,IOSL,IOST,IOT,IOS,IOXY,U,XQVOL,XQY,XQY0,XQDIC,XQPSM,XQPT,XQAUDIT,XQXFLG,ZTSTOP,ZTQUEUED,ZTREQ)
 K IO("C"),IO("Q")
 Q
 ;
XMR ;Entry point from XUS to DO xmr and cleanup after.
 N XQXFLG ;p434
 D NEXT^XUS1 S XQXFLG="",XQXFLG("HALT")=1 G H2
