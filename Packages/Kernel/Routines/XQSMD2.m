XQSMD2 ; SEA/MJM - Secure MenuMan Delegation (Cont.) ;7/3/91  08:42 ;8/21/92  11:58 AM
 ;;8.0;KERNEL;;Jul 10, 1995
 S U="^",XQMG=DUZ,XQNGO=0
BUILD ;Put remaining options into Delgate Options File
 S (XQM,XQN)="" D LIST I XQM=-1!(XQN=-1) G OUT
 D:$Y+2>IOSL WAIT W !!!,"Ready to ",$S(XQDOP:"remove these options from",1:"delegate these options to")," these people? Y// " R XQ:DTIME S:'$T XQ=U G:XQ=U OUT S:XQ="" XQ="Y" G:"YyNn"'[XQ BUILD
 I XQ["N"!(XQ["n") W !!,"Fine, you may edit the user or option list, or enter a '^' to quit." G NAME^XQSMD
 I '$D(^TMP($J,"OP")) W !!,"No options found, no action taken.",*7 G OUT
 ;
ZTLOAD ;Set up Taskman parameters an queue the request
 S ZTRTN="ZTSK^XQSMD31",ZTDTH=$H,ZTIO="",(XQDESC,ZTDESC)=XQMGR_" "_$S(XQDOP:"remov",1:"add")_"ing delegated options"
 S ZTSAVE("^TMP($J,")="",ZTSAVE("XQDOP")="",ZTSAVE("XQLEV")="",ZTSAVE("XQHOLD(")="",ZTSAVE("XQPRO")=""
 D ^%ZTLOAD
 W !!,"Request to ",$S(XQDOP:"remove",1:"add")," delegated options has been queued, task # ",ZTSK,",",!?5,"named: ",XQDESC,"."
 ;
SCAN ;Scan selected options for restrictions and report them
 S XQN=""
 F XQI=0:0 D:$Y+3>IOSL WAIT Q:XQ=U  S XQN=$O(^TMP($J,"ZN",XQN)) Q:XQN=""  S XQON0=^(XQN) S:$L($P(XQON0,U,5)) XQLK(XQN)=$P(XQON0,U,5) D:$L($P(XQON0,U,2)) OOO D RTIM D:$L($P(XQON0,U,9)) RDEV
 S XQKEY(0)="",XQN="",DIC=19.1,DIC(0)="FMXZ",XQI=0
 F XQJ=0:0 S XQN=$O(XQLK(XQN)) Q:XQN=""  S X=XQLK(XQN) D ^DIC I Y>0,'$D(XQKEY(+Y)),$S($D(^XUSEC("XUMGR",DUZ)):1,$D(^VA(200,DUZ,52,"B",+Y)):1,1:0) S XQKEY(+Y)="",XQI=XQI+1
 ;
 I $O(XQKEY(0))'="" D KEYS^XQSMD21 ;Allocate keys for locked options
 ;
 G OUT
 Q
 ;
OOO W !,XQN," is out of order with the string: '",$P(XQON0,U,2),"'" Q
 ;
RTIM ; Identify and display prohibited times for option
 S %A="",XQON=$O(^DIC(19,"B",XQN,0)) I $D(^DIC(19,XQON,3.91)) F %XQI=0:0 S %XQI=$O(^DIC(19,XQON,3.91,%XQI)) Q:%XQI'>0  W !,XQN," is PROHIBITED during the times ",$P(^(%XQI,0),U,1),$P(^(0),U,2)," (military time)." K %A
 K %XQI I $D(%A) K %A I $L($P(XQON0,U,8)) W !,XQN," is PROHIBITED during the times ",$P(XQON0,U,8)," (military time)."
 Q
 ;
RDEV W !,XQN," is restricted to run on only certain devices." Q
 ;
LIST ;List users and options selected so far.
 W @IOF S (XQT,XQM)=0,XQM=$O(XQHOLD(XQM)) I XQM="" W !!," No users selected yet." S XQM=-1 Q
 W !!,"For the following user(s):",!
 F XQI=1:1 D:$Y+2>IOSL WAIT Q:XQ=U  W:'(XQT#2) ! W ?(XQT#2*35),XQI,". ",XQHOLD(XQM) S XQT=XQT+1,XQM=$O(XQHOLD(XQM)) Q:XQM=""
 W !!,"You will ",$S(XQDOP:"remove ",1:"delegate "),"the following options: ",!
 S XQT=0,XQN="",XQN=$O(^TMP($J,"ZN",XQN)) I XQN="" W !!,"No menu options selected yet" S XQN=-1 Q
 F XQI=0:0 D:$Y+2>IOSL WAIT Q:XQ=U  W !,XQN,"   ",$P(^TMP($J,"ZN",XQN),U,1) S XQN=$O(^(XQN)) Q:XQN=""
 W !!,$S(XQDOP:" Removed ",1:" Delegated "),"by ",XQMGR," on ",XQDATE,".",!
 S XQ=""
 Q
WAIT ;Skip to the head of the next page
 I 1 S XQ="" R:IOST["C-" !?26,"Press RETURN to continue,'^' to quit.",XQ:DTIME S:'$T XQ=U W @IOF
 Q
 ;
OUT K DIC,DIK,DA,DISYS,DINUM,POP,XQ,XQH,XQI,XQJ,XQK,XQL,XQM,XQN,XQT,XQON0,XQAL,XQDATE,XQDEL,XQDESC,XQDT,XQDUZ,XQLEV,XQLK,XQMG,XQMGR,XQNAM,XQNGO,XQUF,XQPRO,XQSTART,XQEND,XQHOLD,XQKEY,ZTSK,X,Y,XY,%,^TMP($J)
 K ZTRTN,ZTDTH,ZTIO,ZTDESC,ZTSAVE,XQDOP,C,XQU1L
 Q
