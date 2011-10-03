NURCROP0 ;HIRMFO/RM,RTK-CARE PLAN RANK ORDER PRINT ;8/29/96
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
EN1 ; ENTRY FROM OPTION TO PRINT RANK ORDER LISTING OF CARE PLAN
 ;
 ;  Select Date/Time range for report
 S %DT("A")="Start with Date (Time Optional): ",%DT="AET",%DT(0)="-NOW" D ^%DT I +Y'>0 G EXIT
 S NURCBGDT=+Y
ENDT S %DT("A")="Go to Date (Time Optional): ",%DT="AET",%DT(0)=NURCBGDT D ^%DT I +Y>0 S X=+Y,%DT="T",%DT(0)="-NOW" D ^%DT W:+Y'>0 $C(7)," ??" G:+Y'>0 ENDT I +Y>0 S NURCENDT=+Y_$S(Y[".":"",1:".24")
 E  G EXIT
 ;
 ;  Select Ward(s) for report :Use Nursing utility
 W ! I $$MDIC^NURSAGS0'>0 G EXIT
 S X="" F  S X=$O(NURSNLOC(X)) Q:X=""  F Y=0:0 S Y=$O(NURSNLOC(X,Y)) Q:Y'>0  F NURC=0:0 S NURC=$O(^NURSF(211.4,Y,3,NURC)) Q:NURC'>0  D
 .S NURSMAS=+$G(^NURSF(211.4,Y,3,NURC,0)) I NURSMAS>0 S NURSMAS(0)=$P($G(^DIC(42,NURSMAS,0)),"^") I $L(NURSMAS(0)) S NURSMAS(NURSMAS(0),NURSMAS)=""
 ;
 ;  Select the Ward/Group Report ID for the header
 K DIRUT S NURCLID=$$RPRTID^NURCROP2 G:$D(DIRUT) EXIT
 ;
 ;  Select whether report is for Admitting location or all locations
 W ! S NURCSORT=$$SORTYP^NURCROP2 G EXIT:NURCSORT'>0
DEV ;  Ask device and allow to queue
 ;   If QUEUE then call ^%ZTLOAD and exit
 W ! S %ZIS="Q" D ^%ZIS I POP K IO("Q") G EXIT
 I $E(IOST)="P",'$D(IO("Q")),'$D(IO("S")) D ^%ZISC S XQH="NURS-PRINTER QUEUE" W $C(7) D EN^XQH K XQH G DEV
 I $D(IO("Q")) K IO("Q") S ZTIO=ION,ZTRTN="PRINT^NURCROP0",ZTDESC="Nursing Care Plan Statistics - Rank Order Print",ZTSAVE("NURSMAS*")="",ZTSAVE("NURCBGDT")="",ZTSAVE("NURCENDT")="",ZTSAVE("NURCSORT")="",ZTSAVE("NURCLID")=""
 I  D ^%ZTLOAD K ZTSK G EXIT
 ;
PRINT ; ENTRY FROM TASK TO PRINT RANK ORDER PRINT IF QUEUED TO DEVICE
 ;
 ;  Set up required variables for sort.
 ;  Calculate patient census over date/time range.
 K ^TMP($J)
 D NOW^%DTC S NURCNOW=%,NURCNCP=$O(^GMRD(124.2,"AA","NURSC",2,"Nursing Care Plan",1,0)),NURCINT=$O(^GMRD(124.25,"AA","NURSC","NURSING INTERVENTION",0)),NURCORD=$O(^GMRD(124.25,"AA","NURSC","ORDERABLE",0))
 I '$$CENSUS^NURSACE0(NURCBGDT,NURCENDT,NURCNOW,NURCSORT)!'NURCNCP!'NURCINT!'NURCORD U IO S NURCPAGE=$$HEADER^NURCROP1(0) W !!,"There is no data for this report." S NURCPAGE=$$HEADER^NURCROP1(-1) G EXIT
 ;
 ;  Loop through ^TMP($J,"NURCEN",DFN) and get DFN to process
 ;    Loop through ^GMR(124.3,"AA",DFN,DATE) over date time range
 ;     BEGIN
 F DFN=0:0 S DFN=$O(^TMP($J,"NURCEN",DFN)) Q:DFN'>0  D DEM^VADPT S NURCBS5=$E(VADM(1))_$P($P(VADM(2),"^",2),"-",3) F NURCDATE=(9999999-NURCENDT):0 S NURCDATE=$O(^GMR(124.3,"AA",DFN,NURCNCP,NURCDATE)) Q:NURCDATE'>0  D
 .;      Get a care plan
 .S NURCPDA=$O(^GMR(124.3,"AA",DFN,NURCNCP,NURCDATE,0)) Q:NURCPDA'>0
 .;      Loop through all entries in SELECTION multiple
 .;        If ACTIVE(PROBLEM(entry)) THEN
 .;         BEGIN
 .F NURCPDA1=0:0 S NURCPDA1=$O(^GMR(124.3,NURCPDA,1,NURCPDA1)) Q:NURCPDA1'>0  S NURCPTRM=+$G(^GMR(124.3,NURCPDA,1,NURCPDA1,0)) I $$ACTIVE^NURCROP1(NURCPTRM,NURCPDA,NURCBGDT,NURCENDT) D
 ..;           Find frame with CLASSIFICATION=NURSING INTERVENTION that
 ..;           is under this problem.
 ..S NURCITRM=$$GETTRM^NURCROP1(NURCPTRM,NURCINT)
 ..;           Get list of all frames/terms under NURSING INTERVENTION
 ..;           frame with CLASSIFICATION=ORDERABLE in NURSLIST.
 ..;           If NURSLIST is not empty then Loop through list
 ..;              BEGIN
 ..I $$GETLST^NURCROP1(NURCITRM,NURCORD) F NURCOTRM=0:0 S NURCOTRM=$O(NURSLIST(NURCOTRM)) Q:NURCOTRM'>0  I $D(^GMR(124.3,NURCPDA,1,"B",NURCOTRM)) D
 ...;                Set up sort arrays for the orderables
 ...K ^TMP($J,"NURSIR",NURCPTRM,9999999-$G(^TMP($J,"NURSORD",NURCPTRM,NURCOTRM)),NURCOTRM)
 ...S ^TMP($J,"NURSORD",NURCPTRM,NURCOTRM)=$G(^TMP($J,"NURSORD",NURCPTRM,NURCOTRM))+1,^TMP($J,"NURSIR",NURCPTRM,9999999-^TMP($J,"NURSORD",NURCPTRM,NURCOTRM),NURCOTRM)="",^TMP($J,"NURSORD",NURCPTRM,NURCOTRM,NURCBS5)=""
 ..;              END
 ..;            Set up the sort arrays for the problems
 ..K ^TMP($J,"NURSPR",9999999-$G(^TMP($J,"NURSPROB",NURCPTRM)),NURCPTRM)
 ..S ^TMP($J,"NURSPROB",NURCPTRM)=$G(^TMP($J,"NURSPROB",NURCPTRM))+1,^TMP($J,"NURSPR",9999999-^TMP($J,"NURSPROB",NURCPTRM),NURCPTRM)="",^TMP($J,"NURSPROB",NURCPTRM,NURCBS5)=""
 .;         END
 ;  END
 ;
 ; Use IO
 ; Print Header
 U IO S NURCPAGE=$$HEADER^NURCROP1(0)
 I '$D(^TMP($J,"NURSPR")) W !!,"There is no data for this report." G EXIT
 ;
 ;  Print the report
 ;
 D PRINT^NURCROP2
EXIT ;
 ;  Clean up variables
 I $D(ZTSK)#2 D KILL^%ZTLOAD
 K ^TMP($J) D KVAR^VADPT,CLOSE^NURSUT1,^NURCKILL
 Q
