XUTMTR1 ;SEA/RDS - TaskMan: ToolKit, Report 1 (Status) ;05/26/98  16:41
 ;;8.0;KERNEL;**86**;Jul 10, 1995
 ;
TASK ;Lookup Task File Data
 L +^%ZTSK(XUTMT) I $D(^%ZTSCH("TASK",XUTMT)),$D(^(XUTMT,0))[0 W !,"Task # ",XUTMT," is currently running, but its record has been deleted." G T4
 I '$D(^%ZTSK(XUTMT)) W !,"Task # ",XUTMT," does not exist." G NOPE
 I $D(^%ZTSK(XUTMT,0))[0 W !,"Task # ",XUTMT," does exist, but is missing critical data." G NOPE
T4 S ZTSK=XUTMT,XUTSK(0)=$S($D(^%ZTSK(ZTSK,0))#2:^(0),1:""),XUTSK(.1)=$S($D(^(.1))#2:^(.1),1:""),XUTSK(.2)=$S($D(^(.2))#2:^(.2),1:""),XUTSK(.26)=$S($D(^(.26))#2:^(.26),1:"")
 N %,%D,%H,%M,%Y,%ZTT,X,Y,ZT,ZT1,ZT2,ZT3,ZTC
 ;
SCHED ;Lookup Task In Schedule File
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  I $D(^%ZTSCH(ZT1,ZTSK))#2 S XUTSK("A",ZT1,ZTSK)="",ZT2=^(ZTSK) I ZT2]"" S $P(XUTSK(.2),U)=ZT2
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("IO",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 XUTSK("IO",ZT1,ZT2,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  S:$D(^(ZT1,ZTSK))#2 XUTSK("JOB",ZT1,ZTSK)=""
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:ZT2=""  S:$D(^(ZT2,ZTSK))#2 XUTSK("LINK",ZT1,ZT2,ZTSK)=""
 S:$D(^%ZTSCH("TASK",ZTSK))#2 XUTSK("TASK",ZTSK)=^(ZTSK)
 L -^%ZTSK(XUTMT)
 ;
STATUS ;Determine Status According To Lookup Data
 S ZTC=0
 I $D(XUTSK("A")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("A",ZT1)) Q:ZT1=""  S XUTSK(.15,ZTC)="Scheduled to start "_$$TIME^XUTMTP(ZT1),ZTC=ZTC+1
 I XUTSK(.26)]"" S XUTSK(.15,ZTC)="Waiting for hunt group"_$S(XUTSK(.26)[",":"s ",1:" ")_XUTSK(.26)_".",ZTC=ZTC+1
 I XUTSK(.26)="",$D(XUTSK("IO")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("IO",ZT1)) Q:ZT1=""  S XUTSK(.15,ZTC)="Waiting for device "_ZT1_".",ZTC=ZTC+1 D IOQ
 I $D(XUTSK("JOB")) S XUTSK(.15,ZTC)="Waiting for a submanager.",ZTC=ZTC+1 D JL
 I $D(XUTSK("LINK")) S ZT1="" F ZT=0:0 S ZT1=$O(XUTSK("LINK",ZT1)) Q:ZT1=""  S XUTSK(.15,ZTC)="Waiting for the link to "_ZT1_" to be restored.",ZTC=ZTC+1 D LL
 I $D(XUTSK("TASK")) S XUTSK(.15,ZTC)="Currently running.",ZTC=ZTC+1
 I $O(XUTSK(.3))="",$D(XUTSK(.1))#2,$P(XUTSK(.1),U)]"" X "S X=""TRAP^XUTMTP0"",@^%ZOSF(""TRAP"") D @($P(XUTSK(.1),U)_""^XUTMTP0"")" S X="",@^%ZOSF("TRAP"),ZTC=ZTC+1
 ;
REPORT ;Report Status And Quit
 F ZT=0:1:ZTC-1 W !,XUTSK(.15,ZT)
 K XUTMT Q
 ;
A ;STATUS--determine position of late task in Schedule List
 N ZTP
 Q
 ;
IOQ ;STATUS--determine position in Device Waiting List
 N ZTP
 S ZTP=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTP=ZTP+1 I ZT3=ZTSK G I1
I1 S XUTSK(.15,ZTC)="     "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.",ZTC=ZTC+1
 Q
 ;
JL ;STATUS--determine position in Job List
 N ZTP
 S ZTP=0,ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("JOB",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:ZT2=""  S ZTP=ZTP+1 I ZT2=ZTSK G J1
J1 S XUTSK(.15,ZTC)="     "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.",ZTC=ZTC+1
 Q
 ;
LL ;STATUS--determine position in Link Waiting List
 N ZTP
 S ZTP=0,ZT2="" F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)),ZT3="" Q:ZT2=""  F ZT=0:0 S ZT3=$O(^%ZTSCH("LINK",ZT1,ZT2,ZT3)) Q:ZT3=""  S ZTP=ZTP+1 I ZT3=ZTSK G L1
L1 S XUTSK(.15,ZTC)="     "_(ZTP-1)_" task"_$S(ZTP=2:"",1:"s")_" ahead of this one.",ZTC=ZTC+1
 Q
 ;
NOPE L -^%ZTSK(XUTMT) K XUTMT
 Q
