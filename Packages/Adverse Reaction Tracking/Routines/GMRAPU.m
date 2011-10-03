GMRAPU ;HIRMFO/WAA- PRINT ALLERGY LIST BY LOCATION UNVERIFIED ;8/27/93
 ;;4.0;Adverse Reaction Tracking;**33**;Mar 29, 1996;Build 5
EN1 ; This routine will loop through the GMRA patient allergy file (120.8)
 ; to find all patients with unverified reactions
 ;
 S GMRAOUT=0 D PRINTER
EXIT ; Exit of program kill cleanup
 D KILL^XUSCLEAN
 K ^TMP($J,"GMRAPU")
 Q
PRINTER ;Select printer
 W ! K GMRAZIS D DEV^GMRAUTL I POP W !,"PLEASE TRY LATER" S GMRAOUT=1 Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="PRINT^GMRAPU",ZTSAVE("GMRAOUT")=""
 . S ZTDESC="List of Unverified Reactions by Ward Location" D ^%ZTLOAD
 . W !!,$S($D(ZTSK):"Request queued...",1:"Request NOT queued please try Later.")
 . Q
 U IO D PRINT U IO(0)
 Q
PRINT ;Queue point for report
 K ^TMP($J,"GMRAPU") D FIND
REPORT ; Print out the report
 S GMRAOUT=$G(GMRAOUT)
 S GMALOC="",GMRAPG=1,GMRADATE=$$NOW^XLFDT
 I '$D(^TMP($J,"GMRAPU")) D HEAD W !,?20,"NO DATA FOR THIS REPORT"
 F  S GMALOC=$O(^TMP($J,"GMRAPU",GMALOC)) Q:GMALOC=""  D HEAD Q:GMRAOUT  D  Q:GMRAOUT
 .S GMRANAM="" F  S GMRANAM=$O(^TMP($J,"GMRAPU",GMALOC,GMRANAM)) Q:GMRANAM=""  D  Q:GMRAOUT
 ..S GMADFN=0 F  S GMADFN=$O(^TMP($J,"GMRAPU",GMALOC,GMRANAM,GMADFN)) Q:GMADFN<1  D  Q:GMRAOUT
 ...S GMRASSN="",GMRARB=""
 ...D VAD^GMRAUTL1(GMADFN,"","","","",.GMRASSN,.GMRARB)
 ...W !,GMRARB,$S(GMRARB'="":"  ",1:""),GMRANAM," (",GMRASSN,")"
 ...S GMADT=0 F  S GMADT=$O(^TMP($J,"GMRAPU",GMALOC,GMRANAM,GMADFN,GMADT)) Q:GMADT<1  S GMRAPA=0 F  S GMRAPA=$O(^TMP($J,"GMRAPU",GMALOC,GMRANAM,GMADFN,GMADT,GMRAPA)) Q:GMRAPA<1  D  Q:GMRAOUT
 ....S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0))
 ....Q:GMRAPA(0)=""
 ....W !,?3,$$FMTE^XLFDT(GMADT,"1")
 ....W ?30,$S($P(GMRAPA(0),U,5)'="":$E($P($G(^VA(200,$P(GMRAPA(0),U,5),0)),U),1,24),1:"<None>")
 ....W ?55,$E($P(GMRAPA(0),U,2),1,24)
 ....I $Y>(IOSL-4) D HEAD
 ....Q
 ...Q
 ..Q
 .Q
 D CLOSE^GMRAUTL
 Q
HEAD ; Print header information
 I $E(IOST,1)="C" D  Q:GMRAOUT
 .I GMRAPG=1 W @IOF Q
 .I GMRAPG'=1 D  Q:GMRAOUT
 ..N DIR S DIR(0)="E" D ^DIR I 'Y S GMRAOUT=1
 ..K Y
 ..Q
 .Q
 Q:GMRAOUT
 I GMRAPG'=1 W @IOF
 W "Report Date: ",$P($$FMTE^XLFDT(GMRADATE),"@"),?70,"Page: ",GMRAPG
 W !,?19,"List of Unverified Reactions by Ward Location"
 W !,?30,"Ward Location: ",GMALOC
 W !,?3,"Origination Date/Time",?30,"Originator",?55,"Reaction"
 W !,$$REPEAT^XLFSTR("-",78)
 S GMRAPG=GMRAPG+1
 I $D(ZTQUEUED) S:$$STPCK^GMRAUTL1 GMRAOUT=1 ; Check if stopped by user
 Q
FIND ; This subroutines will build the data for the report.
 N GMADFN
 S GMADFN=0
 F  S GMADFN=$O(^GMR(120.8,"AVER",GMADFN)) Q:GMADFN<1  D
 .N GMRALOC,GMRANAM,GMALOC,GMRAPA
 .S GMRANAM="",GMRALOC=""
 .Q:'$$PRDTST^GMRAUTL1(GMADFN)  ;GMRA*4*33 Exclude test patients if production or legacy environment.
 .D VAD^GMRAUTL1(GMADFN,"",.GMRALOC,.GMRANAM,"","","") I GMRALOC="" S GMALOC="OUTPATIENT"
 .E  S GMALOC=$P($G(^DIC(42,GMRALOC,0)),U)
 .Q:GMALOC=""
 .S GMRAPA=0
 .F  S GMRAPA=$O(^GMR(120.8,"AVER",GMADFN,GMRAPA)) Q:GMRAPA<1  D
 ..N GMADT
 ..S GMRAPA(0)=$G(^GMR(120.8,GMRAPA,0)) Q:GMRAPA(0)=""
 ..S GMADT=$P(GMRAPA(0),U,4)
 ..S ^TMP($J,"GMRAPU",GMALOC,GMRANAM,GMADFN,GMADT,GMRAPA)=""
 ..Q
 .Q
 Q
