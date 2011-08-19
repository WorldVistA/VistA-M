GMRAPST4 ;HIRMFO/WAA- PRINT FREQUENCY OF DIST OVR DT BY DC ;6/17/08  09:28
 ;;4.0;Adverse Reaction Tracking;**7,33,41**;Mar 29, 1996;Build 8
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries in that date range.
 N GMAEN,GMAST,GMRADATE,GMRADC0,GMRADCN,GMRADPDT,GMRATOT  ;41 Added NEW SAC
 S GMRAOUT=0
 W !,"Select an Observed date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 K ^TMP($J,"GMRAPST4")
 D KILL^XUSCLEAN
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPST4",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="Frequency Distribution of Drug Classes" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 ;loop through the 120.85 file and look for the field that 
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 K ^TMP($J,"GMRAPST4")
 S GMRATOT=0
 F  S GMRADATE=$O(^GMR(120.85,"B",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D
 .S GMRAPA1=0 F  S GMRAPA1=$O(^GMR(120.85,"B",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""  ;Bad Node
 ..Q:+$G(^GMR(120.8,$P(GMRAPA1(0),U,15),"ER"))  ;Entered in error data
 ..Q:'$$PRDTST^GMRAUTL1($P(GMRAPA1(0),U,2))  ;GMRA*4*33 Exclude test patient from report if production or legacy environment.
 ..S GMRAPA=$P(GMRAPA1(0),U,15) Q:'GMRAPA
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 ..S GMRADC=0
 ..F  S GMRADC=$O(^GMR(120.8,GMRAPA,3,GMRADC)) Q:GMRADC<1  D
 ...S GMRATOT=GMRATOT+1
 ...S GMRADCN=$P($G(^GMR(120.8,GMRAPA,3,GMRADC,0)),U) Q:GMRADCN=""
 ...S ^TMP($J,"GMRAPST4",GMRADCN)=$G(^TMP($J,"GMRAPST4",GMRADCN))+1
 ...Q
 ..Q
 .Q
 Q:GMRAOUT
 Q:'$D(^TMP($J,"GMRAPST4"))
 S GMRADCN=0
 ;Sort in value order.
 F  S GMRADCN=$O(^TMP($J,"GMRAPST4",GMRADCN)) Q:GMRADCN<1  D
 .S GMRADC=$G(^TMP($J,"GMRAPST4",GMRADCN))  Q:GMRADC<1
 .S ^TMP($J,"GMRAPST4","B",GMRADC,GMRADCN)=""
 .Q
 D HEAD
 S GMRADC=""
 F  S GMRADC=$O(^TMP($J,"GMRAPST4","B",GMRADC),-1) Q:GMRADC<1  D  Q:GMRAOUT
 .S GMRADCN=0,GMRATAB=0,GMRADC0=0
 .F  S GMRADCN=$O(^TMP($J,"GMRAPST4","B",GMRADC,GMRADCN)) Q:GMRADCN<1  D  Q:GMRAOUT
 ..;  S GMRADC0=$G(^PS(50.605,GMRADCN,0))  ;41 Changed from direct read to API call
 ..D C^PSN50P65(GMRADCN,,"GMRA")  ;41  Added API
 ..S GMRADC0=$G(^TMP($J,"GMRA",GMRADCN,.01))_"^"_$G(^TMP($J,"GMRA",GMRADCN,1))
 ..S GMRATAB=30-$L($E($P(GMRADC0,U,2),1,30))
 ..W !,?GMRATAB,$E($P(GMRADC0,U,2),1,30),"  (",$P(GMRADC0,U),")  :",$J(GMRADC,5)
 ..D HEAD Q:GMRAOUT
 ..Q
 .Q
 W !!,?22,"Total number of records processed ",GMRATOT
 D CLOSE^GMRAUTL
 Q
HEAD ; Print header information
 I GMRAPG'=1  Q:$Y<(IOSL-4)
 I $E(IOST,1,2)="C-" D  Q:GMRAOUT
 .I GMRAPG=1 W @IOF Q
 .I GMRAPG'=1 D  Q:GMRAOUT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S GMRAOUT=1
 ..K Y
 ..Q
 .Q
 Q:GMRAOUT
 I GMRAPG'=1 W @IOF
 W "Report Date: ",$P($$FMTE^XLFDT(GMRADPDT),"@"),?70,"Page: ",GMRAPG
 W !,?20,"Frequency Distribution of Drug Classes"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,"Drug Class",?43,"Number"
 W !,$$REPEAT^XLFSTR("-",79)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
