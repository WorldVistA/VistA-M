XUTMRP1 ;SFISC/RWF,BOSTON/MEF - REQUEUE ALL TASKS FOR A DEVICE PART TWO ;06/11/2001  11:12
 ;;8.0;KERNEL;**2,86,120,169**;Jul 10, 1995
 ;called by XUTMRP
 W !
WTSK I WAIT S ZTDH="" F  S ZTDH=$O(^%ZTSCH("IO",OLDLTA,ZTDH)),ZTSK="" Q:ZTDH=""  F  S ZTSK=$O(^%ZTSCH("IO",OLDLTA,ZTDH,ZTSK)) Q:ZTSK=""  D
 . L +^%ZTSK(ZTSK) S DEVNAM=$P($P(^%ZTSK(ZTSK,.2),";"),U)
 . D CONF:'$D(CONFDEV(DEVNAM)),REQ S:$G(REPNT) ^TMP($J,ZTSK)=""
 . L -^%ZTSK(ZTSK) Q
 S WAIT=0
 ;
FTSK I FUT S TT="" F  S TT=$O(^%ZTSCH(TT)) Q:TT=""!($E(TT)'?1N)  F ZTSK=0:0 S ZTSK=$O(^%ZTSCH(TT,ZTSK)) Q:'ZTSK  L +^%ZTSK(ZTSK) D  L -^%ZTSK(ZTSK)
 . D WT
 . I $D(^%ZTSK(ZTSK,0))#2 S DEVNAM=$P($P($G(^(.2)),";"),U) I DEVNAM]"",$D(OLDDEV(DEVNAM)) I $$DATCK D
 .. S ZTDTH=$P(^(0),U,6)
 .. D CONF:'$D(CONFDEV(DEVNAM))
 .. I $G(REPNT) Q:$D(^TMP($J,ZTSK))  ;Already requeued
 .. D REQ
 .. Q
 . Q
 ;
OPT I $G(OPT) S TT="" F  S TT=$O(^DIC(19.2,TT)) Q:TT'>0  D
 . S T1=$G(^DIC(19.2,TT,0)),DEVNAM=$P($P(T1,U,3),";")
 . Q:DEVNAM=""  Q:'$D(OLDDEV(DEVNAM))  L +^DIC(19.2,TT,0)
 . S X=NEWDEV(DEVNAME)_";"_$P($P(T1,U,3),";",2,99)
 . S $P(^DIC(19.2,TT,0),U,3)=X
 . L -^DIC(19.2,TT,0)
 . Q
 ;
END Q  ;return to XUTMRP 
 ;
WT S FLAG=1+$G(FLAG)#10 W:'FLAG "."
 Q
 ;
REQ Q:'$D(CONFDEV(DEVNAM))
 I $G(XUTMDTH) S ZTDTH=XUTMDTH
 S ZTIO=NEWDEV(CONFDEV(DEVNAM)) D REQ^%ZTLOAD K ZTDTH
 Q:'ZTSK(0)
 W !!,"Requeued ",$S(WAIT:"waiting ",1:""),"task #",ZTSK," to device ",CONFDEV(DEVNAM),!
 Q
 ;
CONF ;Build the CONFDEV array
 S DEV="" F  S DEV=$O(NEWDEV(DEV)) Q:DEV=""  D
 . I $D(OLDDEV(DEVNAM)),$P(OLDDEV(DEVNAM),";",3,4)=$P(NEWDEV(DEV),";",3,4) S CONFDEV(DEVNAM)=DEV
 . Q
 Q:$D(CONFDEV(DEVNAM))>0  ;Have a mapping
 ;Get user input
 D ASKD Q:Y'>0
 S CONFDEV(DEVNAM)=DEV,IOP=DEV D D0^XUTMRP S NEWDEV(DEV)=ZTIO,II=""
 F  S II=$O(OLDDEV(II)) Q:II=""  D
 . Q:'$D(OLDDEV(DEVNAM))
 . I $P(OLDDEV(DEVNAM),";",3,4)=$P(OLDDEV(II),";",3,4),$D(CONFDEV(DEVNAM)) S CONFDEV(II)=CONFDEV(DEVNAM)
 ;
 Q
ASKD ;For devices that don't match ask user
 W !!,"I can't find a printer for task #",ZTSK,!," with old device ",DEVNAM," with the correct parameters."
 I $D(OLDDEV(DEVNAM)) W !," (MARGIN= ",$P(OLDDEV(DEVNAM),";",3),"/ PAGE LENGTH= ",$P(OLDDEV(DEVNAM),";",4)," )."
 W !,"Where should I print it?",! D ASKD^XUTMRP(),DTSK:Y'>0
 Q
DTSK D LIST Q:'$G(ZTC)
ASK W !!,"You didn't select a device. Do you want to delete the task"
 S %=2 D YN^DICN I %'>0 S XQH="XUTM DELETE TASK" D ^XQH G ASK
 S DEL=(%=1) I 'DEL D
 . S DIR(0)="Y",DIR("A")="Do you want another chance to select a device"
 . S DIR("B")="Yes" D ^DIR K DIR
 . Q:$D(DIRUT)  Q:'Y
 . D ASKD^XUTMRP()
 Q:'DEL
 D DQ^%ZTLOAD
 I ZTSK(0) W !,"Task #",ZTSK," deleted."
 Q
DATCK() N X S X=$$HTFM^XLFDT($P(^%ZTSK(ZTSK,0),U,6))
 Q X'<SDT&(X'>EDT)
 ;
LIST ;List a task.
 N DIR,DIRUT,DTOUT,DUOUT
 S ZTC=0 I $D(^%ZTSK(ZTSK)) D EN^XUTMTP(ZTSK) S ZTC=1
 I 'ZTC W !!?5,"That task is not defined in this volume set's Task File."
 Q
