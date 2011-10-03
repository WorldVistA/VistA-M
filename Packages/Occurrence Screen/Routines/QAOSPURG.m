QAOSPURG ;HISC/DAD-PURGE AUTO ENROLL RUN DATES FILE ;1/13/93  14:12
 ;;3.0;Occurrence Screen;;09/14/1993
 W !!!?32,"*** WARNING ***",!!?4,"This option purges the historical data that tells the Occurrence Screen",!?17,"package on what dates auto enrollment was run",*7,!
ASK ;
 W !,"Are you sure you want to continue" S %=2 D YN^DICN G:(%=-1)!(%=2) EXIT I '% W !!?5,"Please answer Y(es) or N(o)",! G ASK
SCRN ;
 W !!,"Select the screens to purge." K ^UTILITY($J,"QAO SCREEN")
 S QAQDIC="^QA(741.1,",QAQDIC(0)="AEMNQZ",QAQDIC("A")="Select SCREEN: "
 S QAQDIC("B")="ALL",QAQUTIL="QAO SCREEN" D ^QAQSELCT G:QAQQUIT EXIT
DATE ;
 W !!,"Select the date range to purge."
 D ^QAQDATE G:QAQQUIT EXIT I QAQNBEG'<DT W !?5,"*** Beginning date must be in the past !! ***",*7 G DATE
 S ZTRTN="ENTSK^QAOSPURG",ZTIO="",ZTDTH=$H
 S ZTSAVE("QAQ*")="",ZTSAVE("^UTILITY($J,""QAO SCREEN"",")=""
 S ZTDESC="Purge auto enroll run dates file"
 D ^%ZTLOAD W !,"Deletion request queued."
 G EXIT
 ;
ENTSK ; Tasked entry point
 S QAOSDR="" K SCRNFLD,^UTILITY($J,"QAM MONITOR")
 F QA=1:1 S X=$T(SCRNFLD+QA) Q:X=""  S SCRNFLD(+X)=$P(X,";;",2)
 F QAOSSCRN=0:0 S QAOSSCRN=$O(^UTILITY($J,"QAO SCREEN",QAOSSCRN)) Q:QAOSSCRN'>0  D
 . S SCRNFLD=$G(SCRNFLD(10*QAOSSCRN))
 . I SCRNFLD D
 .. S QAOSDR=QAOSDR_$S(QAOSDR]"":";",1:"")_SCRNFLD_"///@"
 .. K SCRNFLD(10*QAOSSCRN)
 .. Q
 . S QAMD0=+$P($G(^QA(741.1,QAOSSCRN,0)),"^",5)
 . S QAM=$P($G(^QA(743,QAMD0,0)),"^")
 . S:QAM]"" ^UTILITY($J,"QAM MONITOR",QAM,QAMD0)=""
 . Q
 ; Purge Monitoring System AUTO ENROLL RUN DATE file (#743.6)
 D EN3^QAMARCH1
 ; Purge Occurrence Screen QA OCCURRENCE AUTO RUN DATES file (#741.99)
 S QAOSALL=$S($O(SCRNFLD(0))'>0:1,1:0)
 F QAOS=QAQNBEG-.0000001:0 S QAOS=$O(^QA(741.99,"B",QAOS)) Q:(QAOS'>0)!(QAOS\1>QAQNEND)  F QAOSD0=0:0 S QAOSD0=$O(^QA(741.99,"B",QAOS,QAOSD0)) Q:QAOSD0'>0  D
 . I QAOSALL D
 .. S DIK="^QA(741.99,",DA=QAOSD0 D ^DIK
 .. Q
 . E  D
 .. S DIE="^QA(741.99,",DA=QAOSD0,DR=QAOSDR D ^DIE
 .. Q
 . Q
EXIT ;
 K %,%DT,DA,DIK,QAOS,QAOSD0,QAOSQUIT,X,Y,D,I,Z,ZTRTN,ZTSAVE,ZTIO,ZTDESC
 K ZTDTH,QAM,QAMD0,QAMD1,QAMDATE,QAMMON,QAMMONNM,SCRNFLD,QAOSALL,QAOSDR
 K DIE,DR,^UTILITY($J,"QAM MONITOR"),^UTILITY($J,"QAO SCREEN")
 D K^QAQDATE S:$D(ZTQUEUED) ZTREQ="@"
 Q
SCRNFLD ;;TOTAL FIELD FOR EACH SCREEN IN FILE #741.99
1010 ;;1
1011 ;;1.1
1020 ;;2
1030 ;;3
1041 ;;4.1
1042 ;;4.2
1051 ;;5.1
1052 ;;5.2
1061 ;;6.1
1062 ;;6.2
1070 ;;7
1080 ;;8
1090 ;;9
1990 ;;99
