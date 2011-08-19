XUTMQ1 ;SEA/RDS - TaskMan: Option, ZTMINQ, Part 3 (Modules) ;4/20/95  10:33
 ;;8.0;KERNEL;;Jul 10, 1995
 ;
ENTRY G ^XUTMQ
 ;
PRINT ;Subroutine--Print A Task
 N XUTMT,ZTSK W:'ZTC @IOF,!,ZTH,! W:'ZTF !,"-------------------------------------------------------------------------------"
 S X=0,ZTF=0 D EN^XUTMTP(ZTS) I $Y>18 W ! S ZTF=1,DIR(0)="E" D ^DIR S X=$D(DTOUT)!$D(DUOUT) Q:X  W @IOF
 S ZTC=ZTC+1 Q
 ;
RANGE ;LIST--Process A Range
 S ZT1=$P(ZT,"-"),ZT2=$P(ZT,"-",2),ZTS=ZT1 I $D(^%ZTSK(ZTS))!($D(^%ZTSCH("TASK",ZTS))) D PRINT Q:X
 F ZTJ=0:0 S ZTS=$O(^%ZTSCH("TASK",ZTS)) Q:ZTS=""!(ZTS>ZT2)  I '$D(^%ZTSK(ZTS)) D PRINT Q:X
 Q:X  S ZTS=ZT1 F ZTJ=0:0 S ZTS=$O(^%ZTSK(ZTS)) Q:ZTS>ZT2!'ZTS  D PRINT Q:X
 Q
 ;
OUT ;Tag for breaking FOR scope to exit listing early
 Q
 ;
EVERY ;Every task.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT1,ZT2,ZTC,ZTF,ZTH,ZTREC,ZTS
 K ^TMP($J)
 S ZTC=0,ZTF=1,ZTH="Every task..."
 W !!,"Building list of sorted tasks..."
 ;
E1 S ZTS=0 F  S ZTS=$O(^%ZTSK(ZTS)) Q:'ZTS  D
 .S ZTREC=$G(^%ZTSK(ZTS,0)) Q:'$L(ZTREC)
 . D SORT(+$P(ZTREC,U,6),ZTS)
 .Q
 ;
E2 S ZTS=0 F  S ZTS=$O(^%ZTSCH("TASK",ZTS)) Q:'ZTS  D
 .I $D(^%ZTSK(ZTS)) Q
 . D SORT($H,ZTS) ;S ^TMP($J,99999-$H,99999-$P($H,",",2),ZTS)=""
 .Q
 W "finished!"
 ;
E3 ;
 G:$O(^TMP($J,0))="" E4
 S ZTSAVE("^TMP($J,")="" D EN^XUTMDEVQ("LIST^XUTMQ","TASK LIST",.ZTSAVE)
 K ^TMP($J)
 Q
 S ZT1="" F  S ZT1=$O(^TMP($J,ZT1),-1) Q:ZT1=""  D  I X Q
 . S ZTS=0 F  S ZTS=$O(^TMP($J,ZT1,ZTS)) Q:'ZTS  D PRINT I X Q
 .Q
 I X K ^TMP($J) Q
 ;
E4 I 'ZTC W !!,"This volume set has no defined tasks!"
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D
 .I ZTC S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR K ^TMP($J) Q
 ;
LIST ;List of tasks.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZTC,ZTF,ZTH,ZTI,ZTJ,XUTMT,ZTS,ZTSK
L0 S XUTMT(0)="AL",XUTMT("A")="Enter list to display: ",XUTMT("??")="@" D ^XUTMT K ^TMP($J,"XUTMT") Q:ZTSK=""  S X=0,ZTC=0,ZTF=1,ZTH="All tasks within the list "_ZTSK_"..."
 F ZTI=1:1:$L(ZTSK,",") S ZT=$P(ZTSK,",",ZTI) D RANGE:ZT["-" G OUT:X I ZT'["-",$D(^%ZTSK(ZT))!($D(^%ZTSCH("TASK",ZT))) S ZTS=ZT D PRINT G OUT:X
 I ZTC W !!,"There ",$S(ZTC=1:"is ",1:"are "),ZTC," task",$S(ZTC=1:"",1:"s")," in that list."
 I 'ZTC W !!?5,$S(ZTSK["-"!(ZTSK[","):"None of those tasks are ",1:"That task is not "),"defined in this volume set's Task File."
 K DIR,DIRUT,DTOUT,DUOUT,X,ZT,ZT1,ZT2,ZTC,ZTF,ZTI,ZTJ,XUTMT,ZTS,ZTSK W ! G L0
 ;
NOT ;Unsuccessful tasks.
 N DIR,DIRUT,DTOUT,DUOUT,X,ZT1,ZT2,ZTC,ZTF,ZTH,ZTS,ZTSCREEN,ZTSK
 K ^TMP($J)
 S X=0,ZTH="Unsuccessful tasks...",ZTC=0,ZTF=1
 W !!,"Searching for unsuccessful tasks..."
 ;
N1 S ZTS=0 F  S ZTS=$O(^%ZTSK(ZTS)) Q:'ZTS  D
 .I $D(^%ZTSK(ZTS,0))[0 Q
 .I $D(^%ZTSK(ZTS,.1))[0 Q
 .I "BCDEFIL"'[$P(^%ZTSK(ZTS,.1),U) Q
 .S XUTMT=ZTS,XUTMT(0)="L" D ^XUTMT
 .I '$D(ZTSK("A")),'$D(ZTSK("IO")),'$D(ZTSK("JOB")),'$D(ZTSK("LINK")),'$D(ZTSK("TASK")) D SORT(+$P(ZTSK(0),U,6),ZTS)
 .Q
 W "Finished!",!
 ;
N2 ;
 G:$O(^TMP($J,0))="" N3
 S ZTSAVE("^TMP($J,")="" D EN^XUTMDEVQ("LIST^XUTMQ","TASK LIST",.ZTSAVE)
 K ^TMP($J)
 Q
 S ZT1="" F  S ZT1=$O(^TMP($J,ZT1),-1) Q:ZT1=""  D  I X Q
 . S ZTS=0 F  S ZTS=$O(^TMP($J,ZT1,ZTS)) Q:'ZTS  D  I X Q
 .. D PRINT
 .Q
 I X K ^TMP($J) Q
 ;
N3 I 'ZTC W !!,"No tasks failed to run to completion."
 W ! S DIR(0)="E",DIR("A")="Press RETURN to continue" D
 .I ZTC S DIR("A")="End of listing.  "_DIR("A")
 D ^DIR K ^TMP($J) Q
 ;
SORT(ZTDTH,ZTSK) ;
 Q:(ZTSK'>0)!(ZTDTH'>0)
 I ZTDTH["," S ZTDTH=$$H3^%ZTM(ZTDTH)
 S ^TMP($J,ZTDTH,ZTSK)=""
 Q
