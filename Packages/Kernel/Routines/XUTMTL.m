XUTMTL ;SEA/RDS - TaskMan: ToolKit, Lookup ;11/18/94  10:27
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
TASK ;Lookup Task File Data
 S ZTSK=XUTMT L +^%ZTSK(ZTSK) I '$D(^%ZTSK(ZTSK)) K XUTMT L -^%ZTSK(ZTSK) S ZTSK="" Q
 S ZTSK(0)=$S($D(^%ZTSK(ZTSK,0))#2:^(0),1:""),ZTSK(.1)=$S($D(^(.1))#2:^(.1),1:""),ZTSK(.2)=$S($D(^(.2))#2:^(.2),1:"")
 N ZT,ZT1,ZT2,ZT3
 ;
SCHED ;Lookup Task In Schedule File
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^%ZTSCH(ZT1,ZTSK))#2 S ZTSK("A",ZT1,ZTSK)="",ZT2=^(ZTSK) I ZT2]"" S $P(ZTSK(.2),U)=ZT2
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 ZTSK("IO",ZT1,ZT2,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  S:$D(^(ZT1,ZTSK))#2 ZTSK("JOB",ZT1,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 ZTSK("LINK",ZT1,ZT2,ZTSK)=""
 S:$D(^%ZTSCH("TASK",ZTSK))#2 ZTSK("TASK",ZTSK)=^(ZTSK) K XUTMT
 ;
EXIT L -^%ZTSK(ZTSK)
 Q
