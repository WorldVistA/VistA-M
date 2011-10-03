XUSTAT2 ;SF/RWF - User/CPU/device stats part3 ;2/27/91  16:19 ;
 ;;8.0;KERNEL;;Jul 10, 1995
A S (XUEQ,XULI,XUTTIME)="",$P(XUEQ,"=",80)=XUEQ,$P(XULI,"-",80)=XULI,XUPA=1,Y=XUST D DD^%DT S XUST=Y,Y=XUEN D DD^%DT S XUEN=Y,XUTUSER=0
 S XUHDR=$S(XUSORT="V":"VOLUME SET",XUSORT="U":"USER",XUSORT="S":"SERVICE",1:"DEVICE")_"-REPORT"
 D HDR2
 I XUSORT="V" S XUCPU=0 F I=1:1 S XUCPU=$O(^TMP($J,"DUZ",XUCPU)) Q:XUCPU']""  D PROC Q:$D(DUOUT)
 I XUSORT="U" S XUSER="" F I=0:0 S XUSER=$O(^TMP($J,0,XUSER)) Q:XUSER']""  S XUREC=^(XUSER) D USER Q:$D(DUOUT)
 I XUSORT="S" S XUSER="" F XUI=0:0 S XUSER=$O(^TMP($J,"SER",XUSER)) Q:XUSER']""  D SERV Q:$D(DUOUT)
 I XUSORT="D" S XU1="" F XUI=0:0 S XU1=$O(^TMP($J,"DEV",XU1)) Q:XU1']""  D DEVICE Q:$D(DUOUT)
STATS W !!,"Total sign-on's processed: ",XUTREC
 W !,"Total Taskman records: ",XUNOTM
 W:XUSORT="U" !,"Total number of users: ",XUTUSER
 W !,"Total number of sign-on's without a sign-off time: ",XUNODT,!
EXIT G END^XUSTAT
 Q
PROC ;
 I $Y+2>IOSL D HDR Q:$D(DUOUT)
 S (XUON,XUSER)=0 F XUDUZ=0:0 S XUDUZ=$O(^TMP($J,"DUZ",XUCPU,XUDUZ)) Q:XUDUZ'>0  S X=^TMP($J,"DUZ",XUCPU,XUDUZ) S XUON=XUON+X,XUSER=XUSER+1
 S X=$S($D(^TMP($J,"TIME",XUCPU,1)):^(1),1:0)
 D SETTIME
 W !,XUCPU,?15,XUON,?30,XUSER,?45,XUTIME,!,XULI
 Q
USER ;
 I $Y+4>IOSL D HDR Q:$D(DUOUT)
 S XU1=+XUREC,XU1T=0,XUTUSER=XUTUSER+1 W !,XUSER
 S XU2="" F I=1:1 S XU2=$O(XUNAME(XU2)) Q:XU2']""  D TIME
 S X=XU1T D SETTIME W !,?20,$E(XULI,1,11),!,?20,XUTIME
 Q
TIME S XUTIME="",X=$S($D(^TMP($J,"TIME",XU1,XU2))#2:^(XU2),1:0)
 S XU1T=XU1T+X D:X SETTIME
 W !,?5,XU2,?20,XUTIME,?35,$S($D(^TMP($J,"NODAT",XU1,XU2))#2:^(XU2),1:"")
 Q
DEVICE ;
 I $Y+4>IOSL D HDR Q:$D(DUOUT)
 S X=$S(XU1?1A.E:XU1,$D(^%ZIS(1,XU1,0)):$P(^(0),"^"),1:XU1) W !,X
 S XU2="",XU1T=0 F I=1:1 S XU2=$O(XUNAME(XU2)) Q:XU2']""  D TIME
 S X=XU1T D SETTIME W !,?20,$E(XULI,1,11),!,?20,XUTIME
 Q
SERV ;
 I $Y+2>IOSL D HDR Q:$D(DUOUT)
 S X=$S($D(^TMP($J,"TIME",XUSER,1)):^(1),1:0) D SETTIME
 W !,XUSER,?37,XUTIME,?64,^TMP($J,"SER",XUSER),!,$E(XULI,1,$L(XUSER))
 Q
SETTIME ;
 S XUTTIME=XUTTIME+X,%=X,XUTIME=$S(%\86400:%\86400_" ",1:"  "),%=%#86400,XUTIME=XUTIME_$E(%\3600+100,2,3)_":"_$E(%\60#60+100,2,3)_":"_$E(%#60+100,2,3)
 Q
HDR I "C"[$E(IOST) S DIR(0)="E" D ^DIR Q:$D(DUOUT)
HDR2 W @IOF,! S Y=DT X ^DD("DD") W Y,?25,XUHDR,?65,"Page # ",XUPA,!?20
 W !?14,"This report was generated for the period",!?12,"beginning ",XUST," and ending ",XUEN
 W:XUSORT="V" !!,"VOL",?15,"Number of",?30,"Number of",?45,"Connect Time",!?15,"Sign-on's",?30,"Users",?45,"Hrs:Min.Sec"
 W:XUSORT="U" !!,"USER NAME",?20,"Connect time",?35,"No",!,?5,"VOL",?20,"Hrs:Min:Sec",?35,"sign-off"
 W:XUSORT="S" !!,"Service",?40,"Total",?60,"Total",!?37,"Hrs:Min.Sec",?59,"Sign On's"
 W:XUSORT="D" !!,"DEVICE NAME",?20,"Connect time",?35,"No",!,?5,"VOL",?20,"Hrs:Min:Sec",?35,"sign-off"
 W !,XUEQ S XUPA=XUPA+1
 Q
