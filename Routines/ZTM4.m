%ZTM4 ;SEA/RDS-TaskMan: Manager, (Waiting List) ;06/19/2000  09:32
 ;;8.0;KERNEL;**1,118,127,162**;Jul 03, 1995
 ;
 ;^%ZTSK(ZTSK) must be locked before call
NQ ;enter a task on the busy device waiting lists
 N ZT,ZT1,ZT2,ZT3,ZT4,ZT5,ZTHG,ZTI
 K ^%ZTSK(ZTSK,.26) S ZTHG="" ;L +^%ZTSCH("IO")
 I ZTIOT'="HG" D  I ZTIO(1)="DIRECT" G NQX
 . I $D(^%ZTSCH("IO",%ZTIO))[0 S ^(%ZTIO)=ZTIOT
 . S ^%ZTSK(ZTSK,.26,%ZTIO)="",^%ZTSCH("IO",%ZTIO,ZTDTH,ZTSK)=""
 . I (ZTIO(1)="DIRECT")!('$D(^%ZIS(1,"AHG",ZTIOS))) Q
 . S ZT2=""
 . F  S ZT2=$O(^%ZIS(1,"AHG",ZTIOS,ZT2)) Q:ZT2=""  D NAME,ADD
 . Q
 I ZTIOT="HG" S ZT2=ZTIOS D ADD
 I ZTHG]"" S ^%ZTSK(ZTSK,.26)=ZTHG
NQX Q
 ;
NAME ;NQ--save name of hunt group
 S ZTS=$G(^%ZIS(1,ZT2,0))
 S ZTN=$P(ZTS,U) I ZTN="" Q
 I ZTHG="" S ZTHG=ZTN Q
 S ZTHG=ZTHG_","_ZTN
 Q
 ;
ADD ;NQ--add the devices in this hunt group to the list the task waits for
 N ZTI,ZT5 S ZT5=""
 F  S ZT5=$O(^%ZIS(1,ZT2,"HG","B",ZT5)) Q:ZT5=""  D
 .S ZTI=$P($G(^%ZIS(1,ZT5,0)),U,2) ;Get $I
 .I ZTI="" Q
 .I $D(^%ZTSCH("IO",ZTI))[0 S ^%ZTSCH("IO",ZTI)=$P($G(^%ZIS(1,ZT5,"TYPE")),"^") ;Get type
 .S ^%ZTSCH("IO",ZTI,ZTDTH,ZTSK)="",^%ZTSK(ZTSK,.26,ZTI)=""
 Q
 ;
DQ ;Remove A Task From The Busy Device Waiting Lists, TASK is LOCKED
 N ZT,ZT1,ZTL
 K ^%ZTSCH("IO",%ZTIO,ZTDTH,ZTSK)
 S ZT1=""
 F  S ZT1=$O(^%ZTSK(ZTSK,.26,ZT1)) Q:ZT1=""  K ^%ZTSCH("IO",ZT1,ZTDTH,ZTSK)
 K ^%ZTSK(ZTSK,.26) Q
 ;
KILL ;POST^%ZTMS4, Call To Delete A Task And Unschedule It Completely
 ;As long as ^%ZTSK(ZTSK) is locked we can remove any reference.
 N ZTDTH
 I $D(^%ZTSK(ZTSK,0))[0 K ^%ZTSK(ZTSK) Q  ;No task to work on.
 S ZTDTH=$G(^%ZTSK(ZTSK,.04)) S:ZTDTH="" ZTDTH=$$H3^%ZTM($P(^%ZTSK(ZTSK,0),U,6))
 I %ZTIO]"",$D(^%ZTSK(ZTSK,0))#2,$P(^(0),U,6)]"" D DQ
 K ^%ZTSK(ZTSK)
 N ZT,ZT1,ZT2 D US
 Q
 ;
US ;Un-Schedule a task from all lists
 ;S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  I $D(^(ZT1,ZTSK)) K ^(ZTSK)
 ;S ZT1="" F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^(ZT1,ZTSK)) K ^(ZTSK)
 K ^%ZTSCH(ZTDTH,ZTSK),^%ZTSCH("JOB",ZTDTH,ZTSK)
 S ZT1="" F  S ZT1=$O(^%ZTSCH("C",ZT1)) Q:ZT1=""  K ^%ZTSCH("C",ZT1,ZTDTH,ZTSK)
 ;Any others??
 Q
