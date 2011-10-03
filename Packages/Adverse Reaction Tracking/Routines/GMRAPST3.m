GMRAPST3 ;HIRMFO/WAA- PRINT FREQUENCY OF DIST OVR DT BY REACT ;3/5/97  15:14
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries in that date range.
 S GMRAOUT=0
 W !,"Select an Observed date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 K ^TMP($J,"GMRAPST3B")
 K ^TMP($J,"GMRAPST3A")
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPST3",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="Frequency Distribution of Causative Agents" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 ;loop through the 120.85 file and look for the field that 
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 K ^TMP($J,"GMRAPST3A")
 S GMRATOT=0
 F  S GMRADATE=$O(^GMR(120.85,"B",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D
 .S GMRAPA1=0 F  S GMRAPA1=$O(^GMR(120.85,"B",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""  ;Bad Node
 ..Q:+$G(^GMR(120.8,$P(GMRAPA1(0),U,15),"ER"))  ;Entered in error data
 ..Q:'$$PRDTST^GMRAUTL1($P(GMRAPA1(0),U,2))  ;GMRA*4*33 Exclude test patient from report if production or legacy environment.
 ..S GMRATOT=GMRATOT+1
 ..S GMRAPA=$P(GMRAPA1(0),U,15) Q:'GMRAPA
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 ..S GMRAREC=$P(GMRAPA(0),U,2)
 ..S ^TMP($J,"GMRAPST3A",GMRAREC)=$G(^TMP($J,"GMRAPST3A",GMRAREC))+1
 ..Q
 .Q
 Q:GMRAOUT
 Q:'$D(^TMP($J,"GMRAPST3A"))
 K ^TMP($J,"GMRAPST3B")
 S GMRAREC=""
 F  S GMRAREC=$O(^TMP($J,"GMRAPST3A",GMRAREC)) Q:GMRAREC=""  D
 .S GMRARECN=$G(^TMP($J,"GMRAPST3A",GMRAREC)) Q:GMRARECN=""
 .S ^TMP($J,"GMRAPST3B",GMRARECN,GMRAREC)=""
 .Q
 D HEAD
 S GMRARECN=""
 F  S GMRARECN=$O(^TMP($J,"GMRAPST3B",GMRARECN),-1) Q:GMRARECN<1  D  Q:GMRAOUT
 .S GMRAREC=""
 .F  S GMRAREC=$O(^TMP($J,"GMRAPST3B",GMRARECN,GMRAREC)) Q:GMRAREC=""  D  Q:GMRAOUT
 ..S GMRATAB=30-$L($E(GMRAREC,1,30))
 ..W !,?GMRATAB,$E(GMRAREC,1,30)," :",$J(GMRARECN,5)
 ..D HEAD Q:GMRAOUT
 ..Q
 .Q
 W !!,?22,"Total number of records processed ",GMRATOT
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
 W !,?20,"Frequency Distribution of Causative Agents"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,"Causative Agents",?34,"Number"
 W !,$$REPEAT^XLFSTR("-",79)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
