%ZTMS7 ;SEA/RDS-TaskMan: Submanager, (GetNext) ;10 Feb 2003 3:17 pm
 ;;8.0;KERNEL;**1,118,127,136,275**;Jul 10, 1995;
 ;
GETNEXT ;PROCESS--search Device Waiting List for next task waiting for %ZTIO
 ;check stop node, and claim ownership of Device Waiting List
 S %ZTIME=$$H3^%ZTM($H)
 I $D(^%ZTSCH("STOP","SUB",ZTPAIR)) S ZTQUIT=1 G DEALOC8
 I $D(^%ZTSCH("WAIT","SUB")) G DEALOC8
 I $O(^%ZTSCH("IO",%ZTIO,0))<1 G DEALOC8
 S %=$G(^%ZTSCH("IO",%ZTIO))
 I %'["RES" S X=$$DEVLK^%ZTMS1(1,%ZTIO,3) D:$D(ZTMLOG) LOG("No Lock "_%ZTIO) I 'X G DEALOC8
 I %["RES" D ^%ZISC ;If a RES close now so open will update
 S ZTDTH=""
 ;
 ;look for task
G3 S ZTDTH=$O(^%ZTSCH("IO",%ZTIO,ZTDTH)),ZTSK="" I ZTDTH="" G DEALOC8
G5 S ZTSK=$O(^%ZTSCH("IO",%ZTIO,ZTDTH,ZTSK)) I ZTSK="" G G3
 L +^%ZTSK(ZTSK):0 G G5:'$T
 I $D(^%ZTSCH("IO",%ZTIO,ZTDTH,ZTSK))[0 L -^%ZTSK(ZTSK) G G5
 D DQ^%ZTM4 ;Remove from lists
 I $D(^%ZTSK(ZTSK,0))[0!'ZTSK D  G G5
 . I ZTSK>0,$D(^%ZTSK(ZTSK)) D TSKSTAT("I","Discarded Because Incomplete")
 . L -^%ZTSK(ZTSK)
 I $L($P($G(^%ZTSK(ZTSK,.1)),U,10)) D  G G5
 . D TSKSTAT("D","Stopped by User")
 . L -^%ZTSK(ZTSK)
 S ZTQUEUED=.5
 D:$D(ZTMLOG) LOG("Got "_%ZTIO)
 Q  ;Quit w/ ^%ZTSK(ZTSK) locked
 ;
DEALOC8 ;GETNEXT--deallocate device, and set ZTNONEXT
 D DEVLK^%ZTMS1(-1,%ZTIO)
 S IO("C")="",IO("T")=1 D ^%ZISC K IO("T"),IO("C")
 S ZTNONEXT=1,%ZTIO=""
 L  ;Quit w/ all locks clear.
 Q
 ;
LOG(M) ;Log a msg
 N % S %=$G(^%ZTSCH("L",$J))+1,^($J)=%
 S ^%ZTSCH("L",$J,%)=M_" ^"_$H
 Q
TSKSTAT(CODE,MSG) ; Update task's status
 S $P(^%ZTSK(ZTSK,.1),U,1,3)=$G(CODE)_U_$H_U_$G(MSG)
 Q
