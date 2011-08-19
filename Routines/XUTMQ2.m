XUTMQ2 ;SEA/RDS - TaskMan: Option, XUTMINQ, Part 4 (Modules) ;6/21/95  16:25
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENTRY G ^XUTMQ
 ;
PRINT ;Subroutine--Print A Task
 N XUTMT,ZTSK W:'ZTC @IOF,!,ZTH,! W:'ZTF !,"-------------------------------------------------------------------------------"
 S X=0,ZTC=0,ZTF=0 D EN^XUTMTP(ZTS) I $Y>18 W ! S ZTF=1,DIR(0)="E" D ^DIR S X=$D(DTOUT)!$D(DUOUT) Q:X  W @IOF
 S ZTC=ZTC+1 Q
 ;
OUT ;Tag for breaking FOR scope to exit early
 Q
 ;
LINK ;Cross-cpu waiting lists.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZTC,ZTF,ZTH,ZTS S ZTC=0,ZTF=1,ZTH="Tasks waiting for dropped links..."
 S ZT1="" F ZT=0:0 S ZT1=$O(^%ZTSCH("LINK",ZT1)),ZT2="" Q:ZT1=""  F ZT=0:0 S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:'ZT2  F ZTS=0:0 S ZTS=$O(^%ZTSCH("LINK",ZT1,ZT2,ZTS)) Q:'ZTS  D PRINT G OUT:X
 I 'ZTC W !!,"There are no tasks on this volume set that are waiting for dropped links."
 W ! S DIR(0)="E",DIR("A")=$S(ZTC:"End of listing.  ",1:"")_"Press RETURN to continue" D ^DIR Q
 ;
RUN ;Running tasks.
 N XUTMT,ZTSK,ZT1
 I ^%ZOSF("OS")["VAX DSM" F ZT1=0:0 D VAX1 Q:ZT1'>0
 S XUTMT(0)="R4"
 S XUTMT("CLEAR")=1
 S XUTMT("EOL")=1
 S XUTMT("HEADER")="Running tasks..."
 S XUTMT("NODE")="^%ZTSCH(""TASK"","
 S XUTMT("NONE")="There are no tasks listed as running."
 D ^XUTMT Q
 ;
VAX1 ;Use VMS to help clean the TASK list
 N $ETRAP,PID S $ETRAP="K ^%ZTSCH(""TASK"",ZT1) S $ECODE="""""
VAX2 S ZT1=$O(^%ZTSCH("TASK",ZT1)) Q:ZT1'>0
 S PID=$P((^%ZTSCH("TASK",ZT1)),U,10) Q:'PID
 S Y=$&ZLIB.%GETJPI(PID,"PID")
 Q
 ;
FUT ;Future tasks.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZT3,ZTC,ZTF,ZTH,ZTS
 K ^TMP($J)
 S ZTC=0,ZTF=1,ZTH="Scheduled and waiting tasks..."
 W !!,"Building sorted list of tasks..."
 ;
F1 S ZT1="" F  S ZT1=$O(^%ZTSCH("JOB",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("JOB",ZT1,ZT2)) Q:'ZT2  D
 .. D SORT(ZT1,ZT2) ;S ^TMP($J,99999-ZT1,99999-$P(ZT1,",",2),ZT2)=""
 .Q
 ;
F2 S ZT1=$$H3^%ZTM($H) F  S ZT1=$O(^%ZTSCH(ZT1)) Q:'ZT1  D
 .S ZTS=0 F  S ZTS=$O(^%ZTSCH(ZT1,ZTS)) Q:'ZTS  D
 .. D SORT(ZT1,ZTS) ;S ^TMP($J,99999-ZT1,99999-$P(ZT1,",",2),ZTS)=""
 .Q
 ;
F3 S ZT1="" F  S ZT1=$O(^%ZTSCH("IO",ZT1)) Q:ZT1=""  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("IO",ZT1,ZT2)) Q:'ZT2  D
 ..S ZT3=0 F  S ZT3=$O(^%ZTSCH("IO",ZT1,ZT2,ZT3)) Q:ZT3=""  D
 ... D SORT(ZT2,ZT3) ;S ^TMP($J,99999-ZT2,99999-$P(ZT2,",",2),ZT3)=""
 .Q
 ;
F4 S ZT1="" F  S ZT1=$O(^%ZTSCH("LINK",ZT1)) Q:'ZT1  D
 .S ZT2="" F  S ZT2=$O(^%ZTSCH("LINK",ZT1,ZT2)) Q:'ZT2  D
 ..S ZTS=0 F  S ZTS=$O(^%ZTSCH("LINK",ZT1,ZT2,ZTS)) Q:'ZTS  D
 ... D SORT(ZT2,ZTS) ;S ^TMP($J,99999-ZT2,99999-$P(ZT2,",",2),ZTS)=""
 .Q
 W "finished!"
 ;
F5 ;
 G:$O(^TMP($J,0))="" F6
 S ZTSAVE("^TMP($J,")="" D EN^XUTMDEVQ("LIST^XUTMQ","TASK LIST",.ZTSAVE)
 K ^TMP($J)
 Q
 S ZT1="" F  S ZT1=$O(^TMP($J,ZT1),-1) Q:ZT1=""  D  I X Q
 . S ZTS=0 F  S ZTS=$O(^TMP($J,ZT1,ZTS)) Q:'ZTS  D PRINT I X Q
 .Q
 I X K ^TMP($J) Q
 ;
F6 I 'ZTC W !!,"There are no future tasks on this volume set."
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D
 .I ZTC S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR K ^TMP($J) Q
 ;
SORT(ZTDTH,ZTSK) ;
 I ZTDTH["," S ZTDTH=$$H3^%ZTM(ZTDTH)
 S ^TMP($J,ZTDTH,ZTSK)=""
 Q
