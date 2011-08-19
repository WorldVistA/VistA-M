GMRAPST2 ;HIRMFO/WAA- PRINT SUM LISTING OF OUT COMES ;3/5/97  14:50
 ;;4.0;Adverse Reaction Tracking;**7,33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the ADT entry point to get all
 ; the entries in that date range.
 S GMRAOUT=0
 W !,"Select an Observed date range for this report."
 D DT^GMRAPL G:GMRAOUT EXIT
 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPST2",(ZTSAVE("GMRAOUT"),ZTSAVE("GMAST"),ZTSAVE("GMAEN"))=""
 . S ZTDESC="Summary of Outcomes" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 ;loop through the 120.85 file and look for the field that 
 D NOW^%DTC S GMRADPDT=X
 S GMRADATE=GMAST-.0001,GMRAPG=1
 S (GMRARRAY("YES"),GMRARRAY("NO"),GMRARRAY("NULL"))="",GMRATOT=0
 F  S GMRADATE=$O(^GMR(120.85,"B",GMRADATE)) Q:GMRADATE<1  Q:GMRADATE>GMAEN  D
 .S GMRAPA1=0 F  S GMRAPA1=$O(^GMR(120.85,"B",GMRADATE,GMRAPA1)) Q:GMRAPA1<1  D
 ..S GMRAPA1(0)=$G(^GMR(120.85,GMRAPA1,0)) Q:GMRAPA1(0)=""  ;Bad Node
 ..Q:+$G(^GMR(120.8,$P(GMRAPA1(0),U,15),"ER"))  ;Entered in Error data
 ..Q:'$$PRDTST^GMRAUTL1($P(GMRAPA1(0),U,2))  ;GMRA*4*33 Exclude test patient from report if production or legacy environment.
 ..S GMRATOT=GMRATOT+1
 ..F GMRALAB=1:1 S GMRALINE=$T(TEXT+GMRALAB) Q:$P(GMRALINE,";",3)=""  D
 ...S GMRAP=$P(GMRALINE,";",4)
 ...I $P(GMRAPA1(0),U,GMRAP)="y" S $P(GMRARRAY("YES"),U,GMRAP)=$P(GMRARRAY("YES"),U,GMRAP)+1
 ...I $P(GMRAPA1(0),U,GMRAP)="n" S $P(GMRARRAY("NO"),U,GMRAP)=$P(GMRARRAY("NO"),U,GMRAP)+1
 ...I $P(GMRAPA1(0),U,GMRAP)="" S $P(GMRARRAY("NULL"),U,GMRAP)=$P(GMRARRAY("NULL"),U,GMRAP)+1
 ...Q
 ..Q
 .Q
 Q:GMRAOUT
 D HEAD
 S (GMRAY,GMRAN,GMRANU)=0
 F GMRALAB=1:1 S GMRALINE=$T(TEXT+GMRALAB) Q:$P(GMRALINE,";",3)=""  D
 .N GMRAP,GMRATAB
 .S GMRAP=$P(GMRALINE,";",4)
 .S GMRATAB=40-$L($P(GMRALINE,";",3))
 .W !,?GMRATAB,$P(GMRALINE,";",3)
 .W ?42,$P(GMRARRAY("YES"),U,GMRAP)
 .S GMRAY=GMRAY+$P(GMRARRAY("YES"),U,GMRAP)
 .W ?53,"| ",$P(GMRARRAY("NO"),U,GMRAP)
 .S GMRAN=GMRAN+$P(GMRARRAY("NO"),U,GMRAP)
 .W ?63,"| ",$P(GMRARRAY("NULL"),U,GMRAP)
 .S GMRANU=GMRANU+$P(GMRARRAY("NULL"),U,GMRAP)
 .Q
 W !,?30,"        ---------------------------------------"
 W !,?32,"Totals: ",?42,GMRAY,?53,"| ",GMRAN,?63,"| ",GMRANU
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
 W !,?30,"Summary of Outcomes"
 W !,?25,"From: ",$$FMTE^XLFDT(GMAST,"2D")," To: ",$$FMTE^XLFDT(GMAEN,"2D")
 W !,?42,"Yes",?55,"No",?65,"No Response"
 W !,$$REPEAT^XLFSTR("-",79)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
TEXT ;;these are the labels that will denote the field data
 ;;Patients that Died: ;3
 ;;Reactions treated with RX drugs: ;4
 ;;Life Threatening illness: ;5
 ;;Required ER/MD visit: ;6
 ;;Required hospitalization: ;7
 ;;Prolonged Hospitalization: ;9
 ;;Resulted in permanent disability: ;10
 ;;Patient recovered: ;11
 ;;Congenital Anomaly: ;16
 ;;Required intervention: ;17
 ;;
