%ZTLOAD6 ;SEA/RDS-TaskMan: P I: Dequeue ;12/29/94  16:02
 ;;8.0;KERNEL;;JUL 10, 1995
 ;
INPUT ;check input parameters for error conditions
 I $D(ZTSK)[0 S ZTSK=""
 I $D(ZTSK)>1 S ZTLOAD=ZTSK K ZTSK S ZTSK=ZTLOAD K ZTLOAD
 I ZTSK<1!(ZTSK\1'=ZTSK) S ZTSK(0)=0 Q
 L +^%ZTSK(ZTSK)
 ;
 D UNSCH
QUIT ;cleanup & quit
 I $D(^%ZTSK(ZTSK)),$D(DUZ)#2,DUZ]"",$D(^VA(200,DUZ,0))#2 S $P(^%ZTSK(ZTSK,.1),U,1,3)="F^"_$H_U_$P(^VA(200,DUZ,0),U)
 L -^%ZTSK(ZTSK) S ZTSK(0)=1 K ZT,ZT1,ZT2,ZT3
 Q
 ;
UNSCH ;search ^%ZTSCH & unschedule task
 ;Call with task locked.
 N ZT1,ZT2,ZT3
 S ZT1=0 F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^(ZT1,ZTSK)) S ZT2=$G(^(ZTSK)) K ^%ZTSCH(ZT1,ZTSK) I ZT2]"" S $P(^%ZTSK(ZTSK,.2),U)=ZT2
 L +^%ZTSCH("JOB"):15
 S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  I $D(^(ZT1,ZTSK)) K ^%ZTSCH("JOB",ZT1,ZTSK)
 L -^%ZTSCH("JOB"),+^%ZTSCH("IO"):15
 S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK)) D DQ(ZT1,ZT2,ZTSK)
 L -^%ZTSCH("IO"),+^%ZTSCH("C"):15
 S ZT1="" F  S ZT1=$O(^%ZTSCH("C",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("C",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK)) K ^%ZTSCH("C",ZT1,ZT2,ZTSK)
 L -^%ZTSCH("C"),+^%ZTSCH("LINK")
 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  I $D(^(ZT2,ZTSK)) K ^%ZTSCH("LINK",ZT1,ZT2,ZTSK)
 L -^%ZTSCH("LINK")
 Q
 ;
DQ(%ZTIO,ZTDTH,ZTSK) ;SEARCH--remove task from Device Waiting List
 L +^%ZTSCH("IO") D DQ^%ZTM4 L -^%ZTSCH("IO")
 Q
 ;
