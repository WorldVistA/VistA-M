XPDIR ;SFISC/RSD - Install Restart ; 09/29/2005
 ;;8.0;KERNEL;**30,58,393**;Jul 10, 1995;Build 12
EN ;restart install
 N DIR,DIRUT,POP,XPD,XPDA,XPDD,XPDIJ,XPDDIQ,XPDNM,XPDNOQUE,XPDPKG,XPDST,XPDSET,XPDT,XPDQUIT,XPDQUES,Y,ZTSK,%
 S %="I $P(^(0),U,9)#3,$D(^XPD(9.7,""ASP"",Y,1,Y)),$D(^XTMP(""XPDI"",Y))",XPDST=$$LOOK^XPDI1(%)
 Q:'XPDST!$D(XPDQUIT)
 S ZTSK=$P(^XPD(9.7,XPDST,0),U,6) D:ZTSK
 .;check if task exist or is queued
 .D ISQED^%ZTLOAD
 .;task is queued to run
 .Q:ZTSK(0)
 .;task doesn't exist, k ZTSK so it can be re-scheduled
 .I ZTSK(0)="" K ZTSK Q
 .D STAT^%ZTLOAD
 .;task is not define
 .I 'ZTSK(1) K ZTSK Q
 .;task is queued to run
 .Q:ZTSK(1)=1
 .;task is running, set quit flag
 .I ZTSK(1)=2 S XPDQUIT=1 W !,"Install is currently running, cannot re-install!" Q
 .;task finished or was interrupted, kill it so it can be rescheduled
 .D KILL^%ZTLOAD K ZTSK Q
 ;abort if there is nothing to install or they '^'
 G:'$O(XPDT(0))!$D(XPDQUIT) ABORT
 ;clean out old task, so they can reinstall
 I '$D(ZTSK) D
 .N XPD
 .S XPD(9.7,XPDST_",",5)=""  D FILE^DIE("","XPD")
 I $G(ZTSK) W !!,"This install is already queued as task #",ZTSK,!,"Please use the Taskman Menu if you want to reschedule." G ABORT
 ;kill XPDT array so that while in XPDI and ABORT is called, nothing is deleted
 S XPDIJ=0,XPDA=XPDST,XPDNM=$P(^XPD(9.7,XPDA,0),U) K XPDT
 ;restore environment check variables
 I $D(^XTMP("XPDI",XPDA,"ENVVAR")) D
 .S:$D(^XTMP("XPDI",XPDA,"ENVVAR","XPDNOQUE")) XPDNOQUE=^("XPDNOQUE")
 .I $D(^XTMP("XPDI",XPDA,"ENVVAR","XPDDIQ")) M XPDDIQ=^("XPDDIQ")
 G DEV^XPDI
 ;
ABORT W !!,"**RESTART ABORTED**",!
 L -XPD(9.7,XPDST)
 Q
