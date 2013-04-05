LA7CHKFP ;DALOI/JMC - Print Lab Messaging File Integrity Report ;11/16/11  10:54
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**27,74**;Sep 27, 1994;Build 229
 ;
 ;This routine prints file integrity report for Lab Messaging.
 ;
EN ; Select report to print
 ;
 ;ZEXCEPT: IOF,IOM,IOSL,IOST,ZTQUEUED,ZTREQ
 ;
 N %ZIS,LA7CNT,LA7DA,LA7DT,LA7ECNT,LA7EXIT,LA7IC,LA7NOW,LA7QUIT,LA7TCNT,POP
 ;
 K ^TMP($J,"LA7ICLIST")
 D HED1
 S LA7IC="LA7IC",(LA7CNT,LA7DA,LA7QUIT)=0
 F  S LA7IC=$O(^XTMP(LA7IC)) Q:LA7IC=""!($P(LA7IC,"^")'="LA7IC")  D  Q:LA7QUIT!(LA7DA)
 . N LA7X
 . S LA7DT=$$FMTE^XLFDT($P(LA7IC,"^",2))
 . S LA7CNT=LA7CNT+1,^TMP($J,"LA7ICLIST",LA7CNT)=LA7DT_"^"_LA7IC
 . S LA7X=^XTMP(LA7IC,0)
 . S LA7ECNT=$S($P(LA7X,"^",7):$P(LA7X,"^",7),1:"NO")_" file errors"
 . S LA7ECNT=LA7ECNT_" / "_$S($P(LA7X,"^",9):$P(LA7X,"^",9),1:"NO")_" mail group errors"
 . I '$P(LA7X,"^",5) D
 . . L +^XTMP(LA7IC,0):1
 . . I $T L -^XTMP(LA7IC,0) S LA7ECNT=LA7ECNT_" - Did NOT finish" Q
 . . S LA7ECNT=LA7ECNT_" - Still running"
 . W !,$J(LA7CNT,3),"  ",LA7DT,"  [",LA7ECNT,"]"
 . I $Y+4>IOSL D
 . . D ASK
 . . I LA7QUIT Q
 . . D HED1
 I LA7QUIT Q
 I 'LA7CNT D EN^DDIOL("No reports on file!","","!?5")
 I 'LA7DA D ASK
 I 'LA7DA Q
 S LA7IC=$P($G(^TMP($J,"LA7ICLIST",LA7DA)),"^",2,3)
 ;
DEV ; Ask device to print report.
 K %ZIS
 S %ZIS="Q" D ^%ZIS
 I POP D HOME^%ZIS Q
 I $D(IO("Q")) D  Q
 . N MSG,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTRTN,ZTSAVE
 . S ZTRTN="DQ^LA7CHKFP",ZTDESC="Print LA7 Messaging Integrity Check"
 . S ZTSAVE("LA7IC")=""
 . D ^%ZTLOAD,^%ZISC
 . S MSG="Task "_$S($G(ZTSK):"",1:"NOT ")_"Queued"
 . D EN^DDIOL(MSG,"","!")
 ;
 ;
DQ ; Entry point from taskman
 N LA7ECNT,LA7EDT,LA7FIX,LA7I,LA7LINE,LA7PAGE,LA7RDT,LA7SDT,LA7X,X,Y
 U IO
 S $P(LA7LINE,"-",IOM)=""
 S (LA7EXIT,LA7PAGE)=0
 S LA7X=$G(^XTMP(LA7IC,0))
 S LA7RDT=$$FMTE^XLFDT($P(LA7IC,"^",2))
 S LA7SDT=$P(LA7X,"^",4)_"^"_$$FMTE^XLFDT($P(LA7X,"^",4))
 S LA7EDT=$P(LA7X,"^",5)_"^"_$$FMTE^XLFDT($P(LA7X,"^",5))
 S LA7TCNT=+$P(LA7X,"^",6) ; Count of # of entries checked
 S LA7ECNT=+$P(LA7X,"^",7) ; Count of number of errors
 S LA7FIX=$P(LA7X,"^",8) ; Flag if fix option was run
 S LA7NOW=$$NOW^XLFDT
 S $P(LA7NOW,"^",2)=$$FMTE^XLFDT(LA7NOW)
 D HED Q:$G(LA7EXIT)
 I '$O(^XTMP(LA7IC,0)) W !,"    NO entries to print"
 S LA7I=0
 F  S LA7I=$O(^XTMP(LA7IC,LA7I)) Q:'LA7I  D  Q:$G(LA7EXIT)
 . I $Y+5>IOSL D HED Q:$G(LA7EXIT)
 . W !,^XTMP(LA7IC,LA7I)
 I '$G(LA7EXIT) D
 . I $Y+5>IOSL D HED Q:$G(LA7EXIT)
 . W !!,"   Total number of entries: ",LA7TCNT
 . W !,"    Total number of errors: ",LA7ECNT
 . W !," Integrity Checker Started: ",$P(LA7SDT,"^",2)
 . W !,"Integrity Checker Finished: ",$P(LA7EDT,"^",2)
 . I LA7FIX>0,LA7ECNT>0 D
 . . W !!,"***Integrity Checker (IC) ran with fix option***"
 . . W !,"***Recommend that IC be re-run to verify fixes***"
 I '$G(LA7EXIT),$E(IOST,1,2)="C-" D TERM
 I $D(ZTQUEUED) S ZTREQ="@"
 E  W:$E(IOST,1,2)="P-" @IOF D ^%ZISC
 Q
 ;
 ;
TERM ;
 ;
 ;ZEXCEPT: IOF,LA7EXIT,LA7PAGE
 ;
 I 'LA7PAGE W @IOF Q
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="E" D ^DIR S:$D(DIRUT) LA7EXIT=1
 Q
 ;
 ;
ASK ; Ask for report to print
 ;
 ;ZEXCEPT: LA7CNT,LA7DA,LA7QUIT
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="NO^1:"_LA7CNT_":0",DIR("A")="Select Report"
 D ^DIR
 I $D(DIROUT) S LA7QUIT=1 Q
 I Y S LA7DA=Y
 Q
 ;
 ;
HED1 ; Print selection header
 ;
 ;ZEXCEPT: IOF,IOM
 ;
 W @IOF,$$CJ^XLFSTR("--- Lab Messaging Integrity Checker Report ---",IOM),!
 Q
 ;
 ;
HED ; Print header
 ;
 ;ZEXCEPT: IOF,IOM,IOST,LA7LINE,LA7NOW,LA7PAGE,LA7RDT
 ;
 I $E(IOST,1,2)="C-" D TERM Q:$G(LA7EXIT)
 I LA7PAGE W @IOF
 S LA7PAGE=LA7PAGE+1
 W !,"Lab Messaging File Integrity Checker Report",?IOM-30,"Printed: ",$P(LA7NOW,"^",2)
 W !,"For Date: ",LA7RDT,?IOM-27,"Page: ",LA7PAGE
 W !,LA7LINE,!
 Q
