GMRAPST1 ;HIRMFO/WAA- PRINT LISTING OF FATAL REACTIONS ;3/5/97  14:45
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries where the patient has died.
 S GMRAOUT=0
 W !,"Select an Observed date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 K ^TMP($J,"GMRAPST1")
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPST1",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="List of Fatal Reaction over a date range" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 ;Loop through the 120.85 file.
 K ^TMP($J,"GMRAPST1")
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 F  S GMRADATE=$O(^GMR(120.85,"B",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D
 .S GMRAPA1=0 F  S GMRAPA1=$O(^GMR(120.85,"B",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""  ;Bad Node
 ..Q:+$G(^GMR(120.8,$P(GMRAPA1(0),U,15),"ER"))  ;data entered in error
 ..Q:$P(GMRAPA1(0),U,3)'="y"  ; If patient did not die of the reaction
 ..S GMRADFN=$P(GMRAPA1(0),U,2),GMRADDT=$P(GMRAPA1(0),U) ; reaction date
 ..Q:'$$PRDTST^GMRAUTL1(GMRADFN)  ;GMRA*4*33 Exclude test patient from report in production or legacy environments.
 ..S (GMRAPID,GMRANAME)=""
 ..D VAD^GMRAUTL1(GMRADFN,GMRADDT,"",.GMRANAME,"",.GMRAPID)
 ..S GMRADIED=$P($G(^DPT(GMRADFN,.35)),U) ; Date patient died
 ..S ^TMP($J,"GMRAPST1",$E(GMRANAME,1,30),GMRAPID,GMRADDT,GMRAPA1)=GMRADIED
 ..Q
 .Q
 Q:GMRAOUT
 I '$D(^TMP($J,"GMRAPST1")) D HEAD W !,"NO DATA FOR THIS REPORT..." Q
 S GMRANAME=""
 F  S GMRANAME=$O(^TMP($J,"GMRAPST1",GMRANAME)) Q:GMRANAME=""  D  Q:GMRAOUT
 .S GMRAPID=""
 .F  S GMRAPID=$O(^TMP($J,"GMRAPST1",GMRANAME,GMRAPID)) Q:GMRAPID=""  D  Q:GMRAOUT
 ..D HEAD Q:GMRAOUT
 ..W !,$E(GMRANAME,1,22)," (",$E(GMRANAME,1),$P(GMRAPID,"-",3),")"
 ..S GMRADDT=0
 ..F  S GMRADDT=$O(^TMP($J,"GMRAPST1",GMRANAME,GMRAPID,GMRADDT)) Q:GMRADDT<1  D  Q:GMRAOUT
 ...S GMRAPA1=0
 ...F  S GMRAPA1=$O(^TMP($J,"GMRAPST1",GMRANAME,GMRAPID,GMRADDT,GMRAPA1)) Q:GMRAPA1<1  D  Q:GMRAOUT  W !
 ....S GMRADIED=^TMP($J,"GMRAPST1",GMRANAME,GMRAPID,GMRADDT,GMRAPA1)
 ....W ?31,$$FMTE^XLFDT($P(^GMR(120.85,GMRAPA1,0),U),"2D")
 ....S GMRAX="",GMRACNT=1 K GMRARX
 ....F  S GMRAX=$O(^GMR(120.85,GMRAPA1,3,"B",GMRAX)) Q:GMRAX=""  D
 .....S GMRARX(GMRACNT)=GMRAX,GMRACNT=GMRACNT+1
 .....Q
 ....W ?40,GMRARX(1),?70,$$FMTE^XLFDT(GMRADIED,"2D")
 ....D HEAD Q:GMRAOUT
 ....S GMRACNT=1 F  S GMRACNT=$O(GMRARX(GMRACNT)) Q:GMRACNT<1  D  Q:GMRAOUT
 .....W !,?40,GMRARX(GMRACNT) D HEAD Q:GMRAOUT
 .....Q
 ....Q
 ...Q
 ..W ! D HEAD Q:GMRAOUT
 ..Q
 .Q
 D CLOSE^GMRAUTL
 Q
 ;has the patient died within the date
HEAD ; Print header information
 I GMRAPG'=1  Q:$Y<(IOSL-4)
 I $E(IOST,1)="C" D  Q:GMRAOUT
 .I GMRAPG=1 W @IOF Q
 .I GMRAPG'=1 D  Q:GMRAOUT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S GMRAOUT=1
 ..K Y
 ..Q
 .Q
 Q:GMRAOUT
 I GMRAPG'=1 W @IOF
 W "Report Date: ",$P($$FMTE^XLFDT(GMRADPDT),"@"),?70,"Page: ",GMRAPG
 W !,?22,"List of Fatal Reaction over a date range"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,"Patient",?31,"Dates",?40,"Related Reaction",?70,"Date Died"
 W !,$$REPEAT^XLFSTR("-",79)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
