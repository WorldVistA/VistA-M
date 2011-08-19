XUTMTA ;SEA/RDS - TaskMan: ToolKit, Select ;12/12/94  15:21
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
SELECT ;Main Section--Select Task
 N DDH,DIR,DIRUT,DTOUT,DUOUT,X,Y,ZT
 F  D SETUP,^DIR Q:+Y=Y!$D(DIRUT)
 K XUTMT,ZTSK S ZTSK=$S($D(DIRUT):"",'$D(^%ZTSK(Y,0))&$D(^TMP($J,0,Y)):$G(^TMP($J,0,Y)),1:Y) Q
 ;
 ;
SETUP ;SELECT--Setup Reader Input Parameters
 S DIR(0)="NAO^1:9999999999:0^D XFORM^XUTMTA"
 S DIR("A")=$S($D(XUTMT("A"))#2:XUTMT("A"),1:"Select TASK: ")
 S DIR("?")=$S($D(XUTMT("?"))#2:XUTMT("?"),1:"^D HELP1^XUTMTA")
 S DIR("??")=$S($D(XUTMT("??"))#2:XUTMT("??"),1:"^D HELP2^XUTMTA") I DIR("??")="@" K DIR("??")
 I $D(XUTMT("B"))#2 S DIR("B")=XUTMT("B")
 I $D(DTIME)[0 S DIR("T")=60
 Q
 ;
 ;XFORM--Does task have an intact ^%ZTSK(#,0)
XFORM ;SELECT--Input Transform
 I '$D(%ZTSK(X)),$D(^TMP($J,0,X)) S X=$G(^TMP($J,0,X)) ;Use index to get task number.
 I '$D(^%ZTSK(X)),'$D(^%ZTSCH("TASK",X)) W !!?5,"Task # ",X," is not defined in this volume set's Task File." K X Q
 I $D(^%ZTSK(X,0))[0,'$D(^%ZTSCH("TASK",X)) W !!?5,"While a record does exist for this task, most of the critical data is",!?5,"missing.  Please select a different task." K X Q
 I XUTMT(0)["U",$S($D(^%ZTSK(X,0))[0:0,1:$P(^(0),U,3)'=DUZ)!$S($D(^%ZTSCH("TASK",X))[0:0,$P(^(X),U,9)=DUZ:0,1:$P(^(X),U,9)'=ZTNAME) W !!?5,"You may only select a task that you created.  Please select a different",!?5,"task." K X Q
 W:$D(^%ZTSK(X,0))#2 "  ",$S($G(^(.03))]"":$E(^(.03),1,75),1:$P(^(0),U,1,2))
 W:$D(^%ZTSK(X,0))[0&($D(^%ZTSCH("TASK",X))#2) "  ",$P(^%ZTSCH("TASK",X),U,1,2)
 Q
 ;
HELP1 ;SELECT--Default Help For '?'
 W !!?5,"Select a task by its internal number: an integer between 1 and 999999999."
 I $D(^TMP($J,0)) W !,"Or by the Index number."
 Q
 ;
HELP2 ;SELECT--Default Help For '??'
 D HELP1
 N DIR,DDH,DIRUT,DTOUT,DUOUT,X,Y D ^XUTMQ
 Q
 ;
