XUTMTPU ;SEA/RDS - TaskMan: ToolKit, Print For Unschedule ;1/31/96  11:40
 ;;8.0;KERNEL;**20**;Jul 10, 1995
 ;
SCHED ;Lookup Tasks In Schedule File
 N DIR,X,Y,ZT,ZT1,ZT2,ZT3,ZT4,ZT5,ZT6,ZTF,ZTIOSL,ZTS K ^TMP($J,"XUTMTPU"),ZTSK,DIRUT S ZTSK=0,ZTIOSL=$Y,X=0
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D DISPLAY G QUIT:$D(DIRUT)
 I ZTSK W !
 ;
QUIT ;Cleanup And Quit
 K ^TMP($J,"XUTMTPU") Q
 ;
DISPLAY ;Add Either One Or Zero To The Count Of Scheduled Tasks In List
 ;
D2 ;First Screen By Whether Task Has Already Been Counted
 I $D(^TMP($J,"XUTMTPU",ZTS))#2 Q
 ;
D5 ;Then Screen by Whether Task Is Within Range
 I '$D(^TMP($J,"XUTMT",ZTS)) S ZT5=$O(^TMP($J,"XUTMT",ZTS)) Q:ZT5=""  S ZT6=$O(^(ZT5,"")) Q:ZT6>ZTS!'ZT6
 ;
D8 ;Finally Screen By Whether User Has Authority To Select Task
 N X
 I 'ZTKEY S X=$G(^%ZTSK(ZTS)) I $S(X="":1,$P(X,U,11)_","_$P(X,U,12)=XUTMUCI:DUZ'=$P(X,U,3),1:ZTNAME'=$P(X,U,10)) Q
 ;
D12 ;Display And Count Tasks Not Screened Out
 S ^TMP($J,"XUTMTPU",ZTS)="",ZTSK=ZTSK+1
 N XUTMT,ZTSK S ZTF=0,X=0 D EN^XUTMTP(ZTS)
 W !,"-------------------------------------------------------------------------------"
 I $Y-ZTIOSL>18 S ZTF=1,ZTIOSL=0,DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF
 Q
 ;
