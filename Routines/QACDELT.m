QACDELT ;HISC/CEW - Purge Contact Records ;2/10/95  11:06
 ;;2.0;Patient Representative;;07/25/1995
 W !!!?32,"***WARNING***",!!?5,"This option purges all Patient Rep contact records with Dates of Contact",!?5,"that fall within the date range you select."
 W !?5,"Once these records are purged, they cannot be recovered!",*7
ASK ;
 W !!,"Are you sure you want to continue" S %=2 D YN^DICN
 G:(%=-1)!(%=2) EXIT I '% W !!?5,"Please answer Y(es) or (N)o" G ASK
DATE ;
 W !!,"Select the date range to purge."
 D ^QAQDATE G:QAQQUIT EXIT I QAQNBEG>DT W !?5,"*** Beginning date must be today or earlier !! ***",*7 G DATE
 K DIR S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Should I continue with the purge"
 D ^DIR K DIR G:$D(DTOUT)!$D(DUOUT)!$D(DIROUT) EXIT
 I Y'>0 W !!?10,"No records purged!" G EXIT
 S ZTRTN="ENTSK^QACDELT",ZTDTH=$H
 S (ZTIO,ZTSAVE("QAQNBEG"),ZTSAVE("QAQNEND"))=""
 S ZTDESC="Purge selected Patient Representative contact records"
 D ^%ZTLOAD W !!,"Deletion request queued."
 G EXIT
ENTSK ;
 S QACDT=QAQNBEG-.0000001 F  S QACDT=$O(^QA(745.1,"D",QACDT)) Q:(QACDT'>0)!(QACDT>QAQNEND)!(QACDT\1'?7N)  D
 . S QACD0=0 F  S QACD0=$O(^QA(745.1,"D",QACDT,QACD0)) Q:QACD0'>0  D
 .. K DA,DIK S DIK="^QA(745.1,",DA=QACD0 D ^DIK
 .. Q
 . Q
EXIT ;
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 K %,DA,DIK,QACDT,ZTSAVE,ZTIO,ZTDESC,ZTDTH,ZTRTN,QACD0,DIR,DIROUT
 K DTOUT,DUOUT,Y
 D K^QAQDATE
 Q
