NURCRL0 ;HIRMFO/RM,RTK-CARE PLAN RANK ORDER PRINT ;8/29/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; ENTRY FROM OPTION 'NURCRP-CP RANK LISTING' TO PRINT RANK ORDER 
 ; LISTING OF CARE PLAN
 ;
 ;  Select Date/Time range for report
 S %DT("A")="Start with Date (Time Optional): ",%DT="AET",%DT(0)="-NOW" D ^%DT I +Y'>0 G EXIT
 S NURCBGDT=+Y
ENDT S %DT("A")="Go to Date (Time Optional): ",%DT="AET",%DT(0)=NURCBGDT D ^%DT I +Y>0 S X=+Y,%DT="T",%DT(0)="-NOW" D ^%DT W:+Y'>0 $C(7)," ??" G:+Y'>0 ENDT I +Y>0 S NURCENDT=+Y_$S(Y[".":"",1:".24")
 E  G EXIT
 ;
 ;  Select Ward(s) for report :Use Nursing utility
 W ! I $$MDIC^NURCRL3'>0 G EXIT
 S X="" F  S X=$O(NURSNLOC(X)) Q:X=""  F Y=0:0 S Y=$O(NURSNLOC(X,Y)) Q:Y'>0  F NURC=0:0 S NURC=$O(^NURSF(211.4,Y,3,NURC)) Q:NURC'>0  D
 .S NURSMAS=+$G(^NURSF(211.4,Y,3,NURC,0)) I NURSMAS>0 S NURSMAS(0)=$P($G(^DIC(42,NURSMAS,0)),"^") I $L(NURSMAS(0)) S NURSMAS(NURSMAS(0),NURSMAS)=""
 ;
 ;  Select the Ward/Group Report ID for the header
 K DIRUT S NURCLID=$$RPRTID^NURCROP2 G:$D(DIRUT) EXIT
 ;
 ;   Select whether report is for Admitting location or all locations
 W ! S NURCSORT=$$SORTYP^NURCROP2 G EXIT:NURCSORT'>0
 ;
 ;  Select if want to display Dx only, Dx/Int or Int only
 W ! K DIR S DIR(0)="SOM^1:Nursing Diagnoses Only;2:Combination Nursing Diagnoses/Interventions;3:Interventions Only;",DIR("A")="Select which data is to be displayed in this report",DIR("?")="ENTER A CODE FROM THE LIST."
 D ^DIR K DIR I "^^"[Y G EXIT
 S NURCRTYP=Y
 ;
DEV ;  Ask device and allow to queue
 ;   If QUEUE then call ^%ZTLOAD and exit
 W ! S %ZIS="Q" D ^%ZIS I POP K IO("Q") G EXIT
 I $E(IOST)="P",'$D(IO("Q")),'$D(IO("S")) D ^%ZISC S XQH="NURS-PRINTER QUEUE" W $C(7) D EN^XQH K XQH G DEV
 I $D(IO("Q")) D  G EXIT
 .   K IO("Q")
 .   S ZTIO=ION,ZTRTN="PRINT^NURCRL0",ZTDESC="Nursing Care Plan Statistics - Rank Order Print",ZTSAVE("NURSMAS*")="",ZTSAVE("NURCBGDT")="",ZTSAVE("NURCENDT")="",ZTSAVE("NURCRTYP")="",ZTSAVE("NURCSORT")="",ZTSAVE("NURCLID")=""
 .   D ^%ZTLOAD K ZTSK
 .   Q
 ;
PRINT ; ENTRY FROM TASK TO PRINT RANK ORDER PRINT IF QUEUED TO DEVICE
 ;
 ; Call print routine
 D PRINT^NURCRL4
 ;
 ;  If terminal don't let last page scroll off of screen
 ; I 'NURCOUT S NURCPAGE=$$HEADER^NURCRL1(-1)
EXIT ;
 ;  Clean up variables
 K ^TMP($J) S NUROUT=$S('$D(NURCOUT):1,1:NURCOUT) D CLOSE^NURSUT1,^NURCKILL
 Q
