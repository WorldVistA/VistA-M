XUTMTUL ;SEA/RDS - TaskMan: ToolKit, Unschedule List ;11/18/94  11:53
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
SCHED ;Lookup Tasks In Schedule File
 N ZT,ZT1,ZT2,ZT3,ZT4,ZT5,ZT6,ZTF,ZTS S ZTSK=0 K ^TMP($J,"XUTMTUL")
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)),ZT2="" Q:'ZT1  F ZT=0:0 S ZT2=$O(^%ZTSCH(ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D SCREEN,DQSCHED:ZTF
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D SCREEN,DQIO:ZTF
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTS=ZT2 D SCREEN,DQJOB:ZTF
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTS=ZT3 D SCREEN,DQLINK:ZTF
 K ^TMP($J,"XUTMTUL") Q
 ;
SCREEN ;Screen Tasks For Selection & User Authority To Select
 N X
 S ZTF=0 I '$D(^TMP($J,"XUTMT",ZTS)) S ZT5=$O(^TMP($J,"XUTMT",ZTS)) Q:ZT5=""  S ZT6=$O(^(ZT5,"")) Q:ZT6>ZTS!'ZT6
 I 'ZTKEY S X=$G(^%ZTSK(ZTS)) I $S(X="":1,$P(X,U,11)_","_$P(X,U,12)=XUTMUCI:DUZ'=$P(X,U,3),1:ZTNAME'=$P(X,U,10)) Q
 S ZTF=1 S:'$D(^TMP($J,"XUTMTUL",ZTS)) ^TMP($J,"XUTMTUL",ZTS)="",ZTSK=ZTSK+1 Q
 ;
DQSCHED ;Dequeue A Schedule List Entry
 L +^%ZTSK(ZT2),+^%ZTSCH(ZT1,ZT2)
 S:$D(^%ZTSCH(ZT1,ZT2))#2 ZT3=^(ZT2) K ^(ZT2) I ZT3]"" S:$D(^%ZTSK(ZT2)) $P(^(ZT2,.2),"^")=ZT3
 S:$D(^%ZTSK(ZT2)) $P(^(ZT2,.1),"^",1,3)="F^"_$H_U_ZTNAME
 L -^%ZTSCH(ZT1,ZT2),-^%ZTSK(ZT2)
 Q
 ;
DQIO ;Dequeue A Device Waiting List
 N %ZTIO,ZTDTH,ZTSK
 S %ZTIO=ZT1,ZTDTH=ZT2,ZTSK=ZT3 L +^%ZTSK(ZTSK),+^%ZTSCH("IO") D DQ^%ZTM4
 S:$D(^%ZTSK(ZTSK)) $P(^(ZTSK,.1),U,1,3)="F^"_$H_U_ZTNAME
 L -^%ZTSCH("IO"),^%ZTSK(ZTSK)
 Q
 ;
DQJOB ;Dequeue A Submanager Waiting List Entry
 L +^%ZTSK(ZT3),+^%ZTSCH("JOB") K ^%ZTSCH("JOB",ZT1,ZT2)
 S:$D(^%ZTSK(ZT3)) $P(^(ZT3,.1),U,1,3)="F^"_$H_U_ZTNAME
 L -^%ZTSCH("JOB"),-^%ZTSK(ZT3) Q
 ;
DQLINK ;Dequeue A Link Waiting List Entry
 L +^%ZTSK(ZT3),+^%ZTSCH("LINK") K ^%ZTSCH("LINK",ZT1,ZT2,ZT3)
 S:$D(^%ZTSK(ZT3)) $P(^(ZT3,.1),U,1,3)="F^"_$H_U_ZTNAME
 L -^ZTSCH("LINK"),-^%ZTSK(ZT3) Q
 ;
