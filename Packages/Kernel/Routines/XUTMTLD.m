XUTMTLD ;SEA/RDS - TaskMan: ToolKit, Lookup For Delete ;11/18/94  10:35
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
SCHED ;Lookup Tasks In Schedule File
 N ZT,ZT1,ZT2,ZT3,ZT4,ZT5,ZT6,ZTS K ^TMP($J,"XUTMTLD"),ZTSK S ZTSK=0
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D COUNT
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D COUNT
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D COUNT
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D COUNT
 ;
TASK ;Lookup Unscheduled Tasks In Task File
 S ZT1="" F ZT=0:0 S ZT1=$O(^TMP($J,"XUTMT",ZT1)) Q:ZT1=""  D RANGE:$D(^(ZT1))=10 I $D(^TMP($J,"XUTMT",ZT1))=1,$D(^%ZTSK(ZT1)) S ZTS=ZT1 D COUNT
 K ^TMP($J,"XUTMTLD") Q
 ;
RANGE ;TASK--Process A Range
 S ZT3=ZT1,(ZT2,ZTS)=$O(^TMP($J,"XUTMT",ZT1,"")) D COUNT:$D(^%ZTSK(ZTS))
 F ZT=0:0 S ZTS=$O(^%ZTSK(ZTS)) Q:ZTS>ZT3!'ZTS  D COUNT
 Q
 ;
COUNT ;SUB--Add Either One Or Zero To The Count Of Scheduled Tasks In List
 ;
C2 ;First Screen By Whether Task Has Already Been Counted
 I $D(^TMP($J,"XUTMTLD",ZTS))#2 Q
 ;
C5 ;Then Screen by Whether Task Is Within Range
 I '$D(^TMP($J,"XUTMT",ZTS)) S ZT5=$O(^TMP($J,"XUTMT",ZTS)) Q:ZT5=""  S ZT6=$O(^(ZT5,"")) Q:ZT6>ZTS!'ZT6
 ;
C8 ;Finally Screen By Whether User Has Authority To Select Task
 N X
 I 'ZTKEY S X=$G(^%ZTSK(ZTS,0)) I $S(X="":1,$P(X,U,11)_","_$P(X,U,12)=XUTMUCI:DUZ'=$P(X,U,3),1:ZTNAME'=$P(X,U,10)) Q
 ;
C12 ;Count Tasks Not Screened Out
 S ^TMP($J,"XUTMTLD",ZTS)="",ZTSK=ZTSK+1 Q
 ;
