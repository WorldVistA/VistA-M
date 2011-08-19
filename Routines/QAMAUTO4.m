QAMAUTO4 ;HISC/DAD-AUTO ENROLL RERUN FOR A DATE RANGE ;5/26/93  09:25
 ;;1.0;Clinical Monitoring System;;09/13/1993
EN S PROBLEM=0,QAMPARAM=$S($D(^QA(740,1,"QAM"))#2:^("QAM"),1:""),QA=$P($P(QAMPARAM,"^",2),";"),PROBLEM=$S(QA="":1,'$D(^%ZIS(1,"B",QA)):1,1:0) I 'PROBLEM F QA=3:1:5 S PROBLEM=$S($P(QAMPARAM,"^",QA)="":1,1:0) Q:PROBLEM
 I PROBLEM W !!!?3,"***********************************************************************",*7,!?3,"*    Auto enroll has found important site parameters to be missing    *"
 I  W !?3,"*  Use the 'Site Parameters Edit' option to enter the necessary data  *",!?3,"***********************************************************************",*7 G EXIT
OK ;
 K ^UTILITY($J,"QAM MONITOR"),^("QAM SERVICE"),^("QAMAUTO45")
MON W !!,"Want to run auto enroll for specific monitors" S %=2 D YN^DICN G EXIT:%=-1,SRV:%=2 I '% W !!?5,"Please answer Y(es) or N(o)" G MON
 S QAQDIC="^QA(743,",QAQDIC(0)="AEMNQZ",QAQDIC("A")="Select MONITOR: ",QAQDIC("S")="I $P(^(0),""^"",5),$P($G(^(1)),""^"",5)",QAQUTIL="QAM MONITOR" D EN1^QAQSELCT I QAQQUIT W !!,"*** No monitors selected ***",*7 G EXIT
SRV W !!,"Want to run auto enroll for specific services" S %=2 D YN^DICN G EXIT:%=-1,DATE:%=2 I '% W !!?5,"Please answer Y(es) or N(o)" G SRV
 S QAQDIC="^DIC(49,",QAQDIC(0)="AEMNQZ",QAQDIC("A")="Select SERVICE: ",QAQUTIL="QAM SERVICE" D EN1^QAQSELCT I QAQQUIT W !!,"*** No services selected ***",*7 G EXIT
DATE ; *** CALLED HERE BY QAOAUTO - OS/3 'RERUN' AUTO ENROLL
 W !!,"Enter the date range you want auto enroll to scan" D ^QAQDATE G:QAQQUIT EXIT S %DT="",X="T" D ^%DT S QAMDT=Y
 I (QAQNBEG'<QAMDT)!(QAQNEND'<QAMDT) W !!?5,"*** Start and end dates must be T-1 or earlier ***",!,*7 G DATE
ZTDTH S %DT="AEPRSX",%DT(0)="NOW",%DT("A")="Queue auto enroll to run at: " D ^%DT K %DT G:Y'>0 EXIT
 S QAMQTIME(0)=$P(Y,".",2),ZTDTH=Y\1,QAMQTIME(0)=QAMQTIME(0)_$E("000000",1,6-$L(QAMQTIME(0))),X=$P(QAMPARAM,"^",5),QAMQBEG=$P(X,"-")_"00",QAMQEND=$P(X,"-",2)_"00"
 I (QAMQTIME(0)<QAMQBEG)!(QAMQTIME(0)>QAMQEND) W " ??",*7,!!?5,"Queueing time must be between ",$E(QAMQBEG,1,4)," and ",$E(QAMQEND,1,4),! G ZTDTH
 S (ZTDTH,QAMQTIME)=ZTDTH_"."_QAMQTIME(0),QAMAXDAY=$P(QAMPARAM,"^",3)-1,QAMHANG=$P(QAMPARAM,"^",4),QAQNBEG(0)=QAQNBEG,QAQNEND(0)=QAQNEND W !!,"Queueing auto enroll, please wait"
 F QA=0:0 S X1=QAQNBEG,X2=QAMAXDAY D C^%DTC S QAQNEND=$S(X>QAQNEND(0):QAQNEND(0),1:X) D QUEUE Q:QAQNEND(0)=QAQNEND  S X1=QAQNEND,X2=1 D C^%DTC S QAQNBEG=X
RPT W !!,"Want a report of the dates when auto enroll will run" S %=1 D YN^DICN I '% W !!?5,"Please answer Y(es) or N(o)" G RPT
 D:%=1 ^QAMAUTO5 G EXIT
QUEUE ;
 S ZTRTN="ENTSK^QAMAUTO4",(ZTSAVE("QAQNBEG"),ZTSAVE("QAQNEND"),ZTSAVE("^UTILITY($J,"))="",ZTDESC="Rerun auto enroll for a given date range",ZTIO="" K ZTSK D ^%ZTLOAD W "."
 S ^UTILITY($J,"QAMAUTO45",QAQNBEG)=QAQNBEG_"^"_QAQNEND_"^"_QAMQTIME_"^"_$S($D(ZTSK)#2:ZTSK,1:"")
 S X=QAMQTIME D H^%DTC S QA1=%H,QA2=%T+(60*QAMHANG),%H=(QA1+(QA2\86400))_","_(QA2#86400) D YMD^%DTC S %=$P(%,".",2),%=%_$E("000000",1,6-$L(%)),(ZTDTH,QAMQTIME)=X_"."_%
 I (%<QAMQBEG)!(%>QAMQEND) S (ZTDTH,QAMQTIME)=QAMQTIME\1_"."_QAMQTIME(0)
 Q
ENTSK ;
 F QAMRANGE=QAQNBEG:0 S QAMTODAY=QAMRANGE D ^QAMAUTO0 S X1=QAMRANGE,X2=1 D C^%DTC S QAMRANGE=X Q:QAMRANGE>QAQNEND
EXIT ;
 K %DT,QAMRANGE,X,X1,X2,%H,%T,D,I,Y,ZTSK,ZTSAVE,ZTDESC,ZTDTH,ZTRTN,ZTIO,QAMDT,QAMPARAM,PROBLEM,QAQQUIT,QA1,QA2,QAMAXDAY,QAMHANG,QAMQBEG,QAMQEND,QAMQTIME
 K ^UTILITY($J,"QAM MONITOR"),^("QAM SERVICE"),^("QAMAUTO45")
 D K^QAQDATE S:$D(ZTQUEUED) ZTREQ="@"
 Q
