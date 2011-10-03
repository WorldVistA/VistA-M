GMRAPFT ;HIRMFO/WAA- PRINT FDA REACTION BY DATE ENTERED/TRACKED ;4/10/97  09:30
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries in that date range.
 S GMRAOUT=0
 W !,"Select a Tracking date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPFT",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="List of FDA Reactions over a Date range by Tracking date" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 D EXIT
 Q
PRINT ;Queue point for report
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 F  S GMRADATE=$O(^GMR(120.85,"ARDT",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D  Q:GMRAOUT
 .S GMRAPA1=0
 .F  S GMRAPA1=$O(^GMR(120.85,"ARDT",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D  Q:GMRAOUT
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""
 ..Q:+$G(^GMR(120.8,$P(GMRAPA1(0),U,15),"ER"))  ;data entered in error
 ..D HEAD Q:GMRAOUT
 ..S (GMRAPID,GMRANAME,GMRALOC)=""
 ..S GMRADFN=$P(GMRAPA1(0),U,2),GMRADDT=$P(GMRAPA1(0),U)
 ..Q:'$$PRDTST^GMRAUTL1(GMRADFN)  ;GMRA*4*33 Exclude test patient from report if production or legacy system.
 ..D VAD^GMRAUTL1(GMRADFN,GMRADDT,.GMRALOC,.GMRANAME,"",.GMRAPID)
 ..I GMRALOC="" S GMRALOC="OUT PATIENT"
 ..E  S GMRALOC=$P($G(^DIC(42,GMRALOC,0)),U)
 ..W !,$E(GMRANAME,1,30) ; Patient Name
 ..K GMRARAC
 ..S GMRARAC=0,GMRACNT=1 F  S GMRARAC=$O(^GMR(120.85,GMRAPA1,3,GMRARAC)) Q:GMRARAC<1  D
 ...S GMRARAC(GMRACNT)=$P($G(^GMR(120.85,GMRAPA1,3,GMRARAC,0)),U) Q:GMRARAC(GMRACNT)=""
 ...S GMRACNT=GMRACNT+1
 ...Q
 ..W ?32,"Obs DT: ",$$FMTE^XLFDT($P(GMRAPA1(0),U),"2D") ; Observed Date
 ..W ?49,$E($G(GMRARAC(1)),1,30) ; The 1st reaction that is listed first
 ..W !,"(",GMRAPID,")"
 ..W ?32,"Trk DT: ",$$FMTE^XLFDT($P(GMRAPA1(0),U,18),"2D") ; Tracking Date
 ..W ?49,$E($G(GMRARAC(2)),1,30) ; The 2nd reaction that is listed
 ..W !,"Loc: ",GMRALOC
 ..W ?32,"-------------" ; Separator
 ..W ?49,$E($G(GMRARAC(3)),1,30) ; The 3rd reaction that is listed
 ..W !,"Obs: ",$P($G(^VA(200,$P(GMRAPA1(0),U,19),0)),U) ; User entered
 ..D
 ...N X1,X2,X,Y
 ...S X2=$P(GMRAPA1(0),U),X1=$P(GMRAPA1(0),U,18)
 ...D ^%DTC
 ...W ?32,X," Days Difference" ;Difference
 ...Q
 ..W ?50,$E($G(GMRARAC(4)),1,30) ; The 4th reaction that is listed
 ..S GMRACNT=4 F  S GMRACNT=$O(GMRARAC(GMRACNT))  Q:GMRACNT<1  W !,?50,$E($G(GMRARAC(GMRACNT)),1,30) ; The Nth reaction that is listed
 ..W ! ; Put a blank line between the ADRs
 ..Q
 .Q
 D CLOSE^GMRAUTL
 Q
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
 W !,?22,"Adverse Reaction Tracking Report"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,"Patient",?40,"Dates",?49,"Related Reaction"
 W !,$$REPEAT^XLFSTR("-",78)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
