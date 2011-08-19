QAOSDELT ;HISC/DAD-PURGE DELETED OCCURRENCES ;9/14/93  11:37
 ;;3.0;Occurrence Screen;;09/14/1993
 W !!!?32,"*** WARNING ***",!!?5,"This option purges those Occurrence Screen records flagged as deleted",!?10,"once these records have been purged they cannot be recovered",*7
ASK ;
 W !!,"Are you sure you want to continue" S %=2 D YN^DICN
 G:(%=-1)!(%=2) EXIT I '% W !!?5,"Please answer Y(es) or N(o)" G ASK
SCRN ;
 W !!,"Select the screens to purge." K ^UTILITY($J,"QAOSDELT")
 S QAQDIC="^QA(741.1,",QAQDIC(0)="AEMNQZ",QAQDIC("A")="Select SCREEN: "
 S QAQDIC("B")="ALL",QAQUTIL="QAOSDELT" D ^QAQSELCT G:QAQQUIT EXIT
DATE ;
 W !!,"Select the date range to purge."
 D ^QAQDATE G:QAQQUIT EXIT I QAQNBEG>DT W !?5,"*** Beginning date must be today or earlier !! ***",*7 G DATE
 S ZTRTN="ENTSK^QAOSDELT",ZTDTH=$H
 S (ZTIO,ZTSAVE("QAQ*"),ZTSAVE("QAO*"),ZTSAVE("^UTILITY($J,"))=""
 S ZTDESC="Purge deleted occurrence screen records"
 D ^%ZTLOAD W !!,"Deletion request queued."
 G EXIT
ENTSK ;
 K QAOSTEST F QA=0:0 S QA=$O(^DD(741,.01,"DEL",QA)) Q:QA'>0  D
 . S X=$G(^DD(741,.01,"DEL",QA,0))
 . S:X]"" QAOSTEST(QA)=X
 . Q
 F QAOSDT=QAQNBEG-.0000001:0 S QAOSDT=$O(^QA(741,"C",QAOSDT)) Q:(QAOSDT'>0)!(QAOSDT>QAQNEND)!(QAOSDT\1'?7N)  F QAOSD0=0:0 S QAOSD0=$O(^QA(741,"C",QAOSDT,QAOSD0)) Q:QAOSD0'>0  D
 . S QAOSZERO=$G(^QA(741,QAOSD0,0)) Q:$P(QAOSZERO,"^",11)'=2
 . S QAOSSCRN=+$G(^QA(741,QAOSD0,"SCRN"))
 . Q:$D(^UTILITY($J,"QAOSDELT",QAOSSCRN,QAOSSCRN))[0
 . S QAOSTEST=0 F QA=0:0 S QA=$O(QAOSTEST(QA)) Q:QA'>0!QAOSTEST  D
 .. X QAOSTEST(QA) S QAOSTEST=$T
 .. Q
 . I 'QAOSTEST S DIK="^QA(741,",DA=QAOSD0 D ^DIK
 . Q
EXIT ;
 K %,DA,DIK,QA,QAOSD0,QAOSDT,QAOSSCRN,QAOSTEST,QAOSZERO
 K ^UTILITY($J,"QAOSDELT")
 D K^QAQDATE
 Q
