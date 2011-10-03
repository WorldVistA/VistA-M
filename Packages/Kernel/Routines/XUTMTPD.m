XUTMTPD ;SEA/RDS - TaskMan: ToolKit, Print For Delete ;01/31/96  11:34
 ;;8.0;KERNEL;**20**;Jul 10, 1995
 ;
SCHED ;Lookup Tasks In Schedule File
 N DIR,X,Y,ZT,ZT1,ZT2,ZT3,ZT4,ZT5,ZT6,ZTF,ZTIOSL,ZTS
 K ^TMP($J,"XUTMTPD"),ZTSK S X=0,ZTIOSL=$Y,ZTSK=0
 S ZT1="" F  S ZT1=$O(^%ZTSCH(ZT1)),ZT2="" Q:'ZT1  F  S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D DISPLAY G QUIT:$D(DIRUT)
 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F  S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D DISPLAY G QUIT:$D(DIRUT)
 ;
TASK ;Lookup Unscheduled Tasks In Task File
 S ZT1="" F  S ZT1=$O(^TMP($J,"XUTMT",ZT1)) Q:ZT1=""  D RANGE:$D(^(ZT1))=10 G QUIT:$D(^(ZT1))=10&X I $D(^TMP($J,"XUTMT",ZT1))=1,$D(^%ZTSK(ZT1)) S ZTS=ZT1 D DISPLAY G QUIT:$D(DIRUT)
 I ZTSK W !
 ;
QUIT ;Cleanup And Quit
 K ^TMP($J,"XUTMTPD") Q
 ;
RANGE ;TASK--Process A Range
 S ZT3=ZT1,(ZT2,ZTS)=$O(^TMP($J,"XUTMT",ZT1,"")) I $D(^%ZTSK(ZTS)) D DISPLAY Q:X
 F ZT=0:0 S ZTS=$O(^%ZTSK(ZTS)) Q:ZTS>ZT3!'ZTS  D DISPLAY Q:X
 Q
 ;
DISPLAY ;SUB--Add Either One Or Zero To The Count Of Scheduled Tasks In List
 ;
D2 ;First Screen By Whether Task Has Already Been Counted
 I $D(^TMP($J,"XUTMTPD",ZTS))#2 Q
 ;
D5 ;Then Screen by Whether Task Is Within Range
 I '$D(^TMP($J,"XUTMT",ZTS)) S ZT5=$O(^TMP($J,"XUTMT",ZTS)) Q:ZT5=""  S ZT6=$O(^(ZT5,"")) Q:ZT6>ZTS!'ZT6
 ;
D8 ;Finally Screen By Whether User Has Authority To Select Task
 N X
 I 'ZTKEY S X=$G(^%ZTSK(ZTS,0)) I $S(X="":1,$P(X,U,11)_","_$P(X,U,12)=XUTMUCI:DUZ'=$P(X,U,3),1:ZTNAME'=$P(X,U,10)) Q
 L
 ;
D12 ;Display And Count Tasks Not Screened Out
 S ^TMP($J,"XUTMTPD",ZTS)="",ZTSK=ZTSK+1
 N XUTMT,ZTSK S X=0,ZTF=0 D EN^XUTMTP(ZTS)
 W !,"-------------------------------------------------------------------------------"
 I $Y-ZTIOSL>18 S ZTF=1,ZTIOSL=0,DIR(0)="E" D ^DIR Q:$D(DIRUT)  W @IOF
 Q
 ;
