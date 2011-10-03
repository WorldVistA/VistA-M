XUTMTR3 ;SEA/RDS - TaskMan: ToolKit, Report 3 (Status 2) ;12/27/94  13:38
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
TASK ;Lookup Task File Data
 K ZTSK S ZTSK="" L +^%ZTSK(XUTMT) S:'$D(^%ZTSK(XUTMT)) ZTSK(.11)="UNDEFINED" S:$D(^(XUTMT))&($D(^(XUTMT,0))[0) ZTSK(.11)="INCOMPLETE"
 S ZTSK=XUTMT S ZTSK(0)=$S($D(^%ZTSK(ZTSK,0))#2:^(0),1:""),ZTSK(.1)=$S($D(^(.1))#2:^(.1),1:""),ZTSK(.2)=$S($D(^(.2))#2:^(.2),1:""),ZTSK(.26)=$S($D(^(.26))#2:^(.26),1:"")
 N %,%D,%H,%M,%Y,%ZTT,X,Y,ZT,ZT1,ZT2,ZT3,ZTC
 ;
SCHED ;Lookup Task In Schedule File
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^%ZTSCH(ZT1,ZTSK))#2 S ZTSK("A",ZT1,ZTSK)="",ZT2=^(ZTSK) I ZT2]"",$S($D(ZTSK(.11))[0:1,1:ZTSK(.11)'="UNDEFINED") S $P(ZTSK(.2),U)=ZT2
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 ZTSK("IO",ZT1,ZT2,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  S:$D(^(ZT1,ZTSK))#2 ZTSK("JOB",ZT1,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 ZTSK("LINK",ZT1,ZT2,ZTSK)=""
 S:$D(^%ZTSCH("TASK",ZTSK))#2 ZTSK("TASK",ZTSK)=^(ZTSK)
 L -^%ZTSK(XUTMT)
 ;
STATUS ;Determine Status According To Lookup Data
 S ZTC=0
 I $D(ZTSK("A")) S ZT1="" F ZT=0:0 S ZT1=$O(ZTSK("A",ZT1)) Q:ZT1=""  S ZTSK(.15,ZTC)="Scheduled to start "_$$TIME^XUTMTP(ZT1),ZTC=ZTC+1
 I ZTSK(.26)]"" S ZTSK(.15,ZTC)="Waiting for hunt group"_$S(ZTSK(.26)[",":"s ",1:" ")_ZTSK(.26)_".",ZTC=ZTC+1
 I ZTSK(.26)="",$D(ZTSK("IO")) S ZT1="" F ZT=0:0 S ZT1=$O(ZTSK("IO",ZT1)) Q:ZT1=""  S ZTSK(.15,ZTC)="Waiting for device "_ZT1,ZTC=ZTC+1
 I $D(ZTSK("JOB")) S ZTSK(.15,ZTC)="Waiting for a submanager.",ZTC=ZTC+1
 I $D(ZTSK("LINK")) S ZT1="" F ZT=0:0 S ZT1=$O(ZTSK("LINK",ZT1)) Q:ZT1=""  S ZTSK(.15,ZTC)="Waiting for the link to "_ZT1_" to be restored.",ZTC=ZTC+1
 I $D(ZTSK("TASK")) S ZTSK(.15,ZTC)="Currently running.",ZTC=ZTC+1
 I $O(ZTSK(.3))="",$D(ZTSK(.1))#2,$P(ZTSK(.1),U)]"" D ^XUTMTP0 S ZTC=ZTC+1
 K XUTMT Q
 ;
