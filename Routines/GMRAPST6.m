GMRAPST6 ;HIRMFO/WAA- ADR OUTCOME REPORT ;3/5/97  15:16
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries in that date range.
 S GMRAOUT=0
 W !,"Select an Observed date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 K ^TMP($J,"GMRAPST6")
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPST6",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="P&T Committee ADR Outcome Report" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 ;loop through the 120.85 file and look for the field that 
 K ^TMP($J,"GMRAPST6")
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 F  S GMRADATE=$O(^GMR(120.85,"B",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D
 .S GMRAPA1=0 F  S GMRAPA1=$O(^GMR(120.85,"B",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""  ;Bad Node
 ..S GMRADDT=$P(GMRAPA1(0),U) ; reaction date
 ..S GMRAPA=$P(GMRAPA1(0),U,15) ; Get the 120.8 entry for this reaction in 120.85
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""  ; Bad node
 ..Q:+$G(^GMR(120.8,GMRAPA,"ER"))  ;entered in error data
 ..S GMRACA=$P(GMRAPA(0),U,2) ; Causative Agent
 ..S DFN=$P(GMRAPA(0),U),GMRACA=$E(GMRACA,1,22)_"-"_$E($P(^DPT(DFN,0),U),1)_$E($P(^(0),U,9),6,9)
 ..Q:'$$PRDTST^GMRAUTL1(DFN)  ;GMRA*4*33 Exclude test patients if production or legacy environment.
 ..S ^TMP($J,"GMRAPST6",GMRADDT,GMRACA,GMRAPA1)=""
 ..Q
 .Q
 Q:GMRAOUT
 I '$D(^TMP($J,"GMRAPST6")) D HEAD W !,"NO DATA FOR THIS REPORT..." Q
 S GMRAOTH=$G(GMRAOTH,$O(^GMRD(120.83,"B","OTHER REACTION",0)))
 S GMRADDT=0
 F  S GMRADDT=$O(^TMP($J,"GMRAPST6",GMRADDT)) Q:GMRADDT<1  D  Q:GMRAOUT
 .S GMRACA=""
 .F  S GMRACA=$O(^TMP($J,"GMRAPST6",GMRADDT,GMRACA)) Q:GMRACA=""  D  Q:GMRAOUT
 ..S GMRAPA1=0
 ..F  S GMRAPA1=$O(^TMP($J,"GMRAPST6",GMRADDT,GMRACA,GMRAPA1)) Q:GMRAPA1<1  D  Q:GMRAOUT
 ...S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0))
 ...Q:GMRAPA(0)=""
 ...D HEAD Q:GMRAOUT
 ...W !,$J($$FMTE^XLFDT(GMRADDT,"2D"),8) ; Obs Date
 ...W ?8,"|",GMRACA ; Causative Agent
 ...W ?38,"|"
 ...S GMRAREC=0
 ...S GMRAREC=$O(^GMR(120.85,GMRAPA1,2,0)) D:GMRAREC>0 SIGN("0",GMRAREC)
 ...W ?58,"|" W:$P(GMRAPA1(0),U,4)="y" " Y" ; Req Tx with Rx
 ...W ?63,"|" W:$P(GMRAPA1(0),U,7)="y" " Y" ; Req Hosp.
 ...W ?68,"|" W:$P(GMRAPA1(0),U,10)="y" " Y" ; Disability
 ...W ?73,"|" W:$P(GMRAPA1(0),U,3)="y" " Y" ; Death
 ...F  S GMRAREC=$O(^GMR(120.85,GMRAPA1,2,GMRAREC)) Q:GMRAREC<1  D SIGN("1",GMRAREC) Q:GMRAOUT
 ...Q:GMRAOUT
 ...D HEAD Q:GMRAOUT  W !,?8,"|",?38,"|",?58,"|",?63,"|",?68,"|",?73,"|"
 ...Q
 ..Q
 .Q
 D CLOSE^GMRAUTL
 Q
SIGN(CNT,GMRAREC) ; Print Sign/Symptoms
 N NAM,Y
 S Y=$G(^GMR(120.85,GMRAPA1,2,GMRAREC,0))
 S NAM=$S(+Y=GMRAOTH:$P(Y,U,2),$D(^GMRD(120.83,+Y,0)):$P(^GMRD(120.83,+Y,0),U),1:"")
 I 'CNT W $E(NAM,1,19)
 E  D HEAD Q:GMRAOUT  W !,?8,"|",?38,"|",$E(NAM,1,19),?58,"|",?63,"|",?68,"|",?73,"|"
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
 W !,?22,"P&T Committee ADR Outcome Report"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,$$REPEAT^XLFSTR("-",79)
 W !,"Obsv.",?8,"|",?38,"|",?58,"|Req.",?63,"|Req.",?68,"|",?73,"|"
 W !,"Date",?8,"|Causative agent-Pat. ID",?38,"|Sign/Symptoms",?58,"|Tx",?63,"|Hosp",?68,"|Dis.",?73,"|Death"
 W !,$$REPEAT^XLFSTR("-",79)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
