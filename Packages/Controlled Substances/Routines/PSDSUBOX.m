PSDSUBOX ;BHAM ISC/JAM - DEA DATA - Waived Practitioner Report ;05 July 2011 5:30 pm
 ;;3.0;CONTROLLED SUBSTANCES;**73**;13 Feb 97;Build 8
 ;External reference to ^PS(59 supported by DBIA #2621
 ;External reference to ^PSRX( supported by DBIA #1977
 ;External reference to ^PSDRUG( supported by DBIA #221
 ;
 ;ask division/site
 N PSDIV,PSPRV,RPTYP,PSDED,PSDBD,PSDSD
 D DIVSEL(.PSDIV) I $G(PSDIV)="^" G EXIT
 I $G(PSDIV)="^ALL" S PSDIV=0 F  S PSDIV=$O(^PS(59,PSDIV)) Q:'PSDIV  I $S('$D(^PS(59,+PSDIV,"I")):1,'^("I"):1,DT'>^("I"):1,1:0) S PSDIV(PSDIV)=""
 I '$D(PSDIV) G EXIT
 ;
DATE ;ask date range
 W ! K %DT S %DT(0)=-DT,%DT="AEP",%DT("A")="Start Date: " D ^%DT
 I Y<0!($D(DTOUT)) G EXIT
 S (%DT(0),PSDBD)=Y,%DT("A")="End Date: "
 W ! D ^%DT I Y<0!($D(DTOUT)) G EXIT
 S PSDED=Y,PSDSD=PSDBD-.000001
PRV ;ask provider(s)
 W !!,?5,"You may select a single provider, several providers,",!,?5,"or enter ^ALL to select all providers.",!!
 K PRV,DIC S DIC("A")="Select Provider: ",DIC=200,DIC(0)="QEAM"
 S DIC("S")="I $D(^(""PS"")),$P(^(""PS""),""^""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)'<DT)"
 F  D ^DIC Q:+Y<0  S PSPRV(+Y)=""
 K DIC I $$UP^XLFSTR(X)="^ALL" K DUOUT G TYP
 I ($D(DUOUT))!($D(DTOUT)) G EXIT
 I '$D(PSPRV)&(Y<0) G PRV
TYP  ;ask report selection - detail or summary
 S DIR(0)="SA^D:Detailed;S:Summary",DIR("A")="Detailed/Summary Report: ",DIR("B")="D"
 D ^DIR
 I $D(DIRUT) G EXIT
 S RPTYP=Y
 W ! K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !!,"NO DEVICE SELECTED OR REPORT PRINTED!!",! K IOP G EXIT
 I $D(IO("Q")) D  G EXIT
 .S ZTRTN="RPT^PSDSUBOX",ZTDESC="DEA Waived Practitioner Report",ZTSAVE("PSDIV(")="",ZTSAVE("PSPRV(")=""
 .F G="PSDSD","PSDED","PSDBD","RPTYP" S:$D(@G) ZTSAVE(G)=""
 .D ^%ZTLOAD W:$D(ZTSK) !,"Report Queued to Print !!",! D HOME^%ZIS K ZTSK,IO("Q")
 U IO
 ;
RPT ;generate report
 N RXN,ND0,ND2,DRGDA,DRGNM,DEA,DIV,PRVDA,PRVNM,PG,DTM
 S PG=1,DTM=$$FMTE^XLFDT(DT)
 K ^TMP("PSDSUBOX",$J)
 F  S PSDSD=$O(^PSRX("AFDT",PSDSD)) Q:'PSDSD!(PSDSD>(PSDED+.99))  D
 .S RXN=0 F  S RXN=$O(^PSRX("AFDT",PSDSD,RXN)) Q:'RXN  D
 ..S ND0=$G(^PSRX(RXN,0)),DRGDA=$P(ND0,"^",6),DRGNM=$$GET1^DIQ(50,DRGDA,.01),DEA=$$GET1^DIQ(50,DRGDA,3)
 ..Q:DEA<1  Q:DEA>5  Q:'$$DETOX^PSSOPKI(DRGDA)
 ..S ND2=$G(^PSRX(RXN,2)),DIV=$P(ND2,"^",9),PRVDA=$P(ND0,"^",4),PRVNM=$$GET1^DIQ(59,PRVDA,.01)
 ..I '$D(PSDIV(+DIV)) Q
 ..I $D(PSPRV) I '$D(PSPRV(+PRVDA)) Q
 ..D SETMP
 D PRT
 ;
EXIT D ^%ZISC K PG,G,DR,X,Y,DIR,DIRUT,DUOUT,I,Y,DIC,DTOUT,%DT
 K ZTDESC,ZTRTN,ZTSAVE S:$D(ZTQUEUED) ZTREQ="@" K ZTQUEUED D KVA^VADPT
 Q
 ;
SETMP ;set ^TMP("PSDSUBOX",$J global
 S ^TMP("PSDSUBOX",$J,DIV,$E(DRGNM,1,30)_"^"_DRGDA,$E(PRVNM,1,30)_"^"_PRVDA)=$G(^TMP("PSDSUBOX",$J,DIV,$E(DRGNM,1,30)_"^"_DRGDA,$E(PRVNM,1,30)_"^"_PRVDA))+1
 S ^TMP("PSDSUBOX",$J,DIV,$E(DRGNM,1,30)_"^"_DRGDA,$E(PRVNM,1,30)_"^"_PRVDA,RXN)=""
 Q
 ;
PRT ;prints report
 N DIV,DRG,PRV,PSDATE,PEDATE,PSDOUT
 S PSDOUT=0,PSDATE=$$FMTE^XLFDT(PSDBD),PEDATE=$$FMTE^XLFDT(PSDED)
 I '$D(^TMP("PSDSUBOX",$J)) D HD W !,?25,"***NO DATA FOUND FOR SELECTION***",!! D HD1^PSDDSOR I $D(DIRUT) Q
 S DIV=0 F  S DIV=$O(^TMP("PSDSUBOX",$J,DIV)) Q:'DIV  D  I PSDOUT Q
 .D HD,PGCHK I PSDOUT Q
 .S DRG="" F  S DRG=$O(^TMP("PSDSUBOX",$J,DIV,DRG)) Q:DRG=""  D  I PSDOUT Q
 ..W ! I RPTYP="S" W $P(DRG,"^")
 ..S PRV="" F  S PRV=$O(^TMP("PSDSUBOX",$J,DIV,DRG,PRV)) Q:PRV=""  D  I PSDOUT Q
 ...D PRT1 Q:PSDOUT  D PGCHK
 ..I RPTYP="S" W !
 Q
 ;
PRT1 ;print report details
 N ND0,LIN,DFN,PL,EE
 I RPTYP="S" W !?3,$$GET1^DIQ(200,$P(PRV,"^",2),.01),?45,$J(^TMP("PSDSUBOX",$J,DIV,DRG,PRV),6) Q
 S RXN=0 F  S RXN=$O(^TMP("PSDSUBOX",$J,DIV,DRG,PRV,RXN)) Q:'RXN  D  Q:PSDOUT
 .S ND0=$G(^PSRX(RXN,0)),DFN=$P(ND0,"^",2)
 .W ?2,"Issue Date: ",$$FMTE^XLFDT($P(ND0,"^",13))
 .D DEM^VADPT,ADD^VADPT
 .W !?2,"Patient: ",VADM(1)
 .W !?2,VAPA(1),$S(VAPA(2)'="":", "_VAPA(2),1:"")
 .I VAPA(3)'="" W !?2,VAPA(3)
 .W !?2,$S(VAPA(4)'="":VAPA(4)_", ",1:""),$P(VAPA(5),"^",2)," ",VAPA(6)
 .D PGCHK I PSDOUT Q
 .W !!?2,$$GET1^DIQ(50,$P(DRG,"^",2),.01),?50,"Qty: ",$P(ND0,"^",7),?60,"# of Refills: ",$P(ND0,"^",9)
 .D FSIG^PSDDSOR1("R",RXN,75)
 .I $G(FSIG(1))'="" D
 ..W !?2,"SIG: ",$$UNESC^ORHLESC($G(FSIG(1)))
 ..I $O(FSIG(1)) D
 ...F EE=1:0 S EE=$O(FSIG(EE)) Q:'EE  D
 ....W !?6,$$UNESC^ORHLESC($G(FSIG(EE)))
 .D PGCHK I PSDOUT Q
 .W !!?2,"Provider: ",$$GET1^DIQ(200,$P(ND0,"^",4),.01),!
 .D VADR($$GET1^DIQ(52,RXN,39.3,"I"),.VADR)
 .I $D(VADR(1)) W ?2,$P(VADR(1),"^"),!?2,VADR(2),!?2,VADR(3),!
 .F LIN=1:1:80 W "="
 .D PGCHK I PSDOUT Q
 Q
HD ;header
 N DVL,DVN,LIN
 W @IOF,?22,"DEA DATA-Waived Practitioner Report",?67,DTM,!,?32,$S(RPTYP="D":"Detailed",1:"Summary")_" Report"
 S DVN=$P($G(^PS(59,+$G(DIV),0)),"^",1),DVL=80-(9+$L(DVN))/2
 I DVN'="" W !?DVL,"DIVISION: ",DVN
 W !?26,PSDATE_" to "_PEDATE,?70,"Page: "_PG,!
 I RPTYP="S" W !,"DRUG/PROVIDER",?45,"# OF PATIENTS",!
 F LIN=1:1:80 W "-"
 S PG=PG+1
 Q
PGCHK ;check for page break
 I ($Y+4)>IOSL D  Q
 .W ! D HD1^PSDDSOR I $D(DIRUT) S PSDOUT=1 Q
 .D HD W !
 Q
 ;
DIVSEL(ARY) ;Division selection (one, multiple or ALL)
 N DIC,DTOUT,DUOUT,QF,Y,X
 W !!,?5,"You may select a single or multiple Divisions,"
 W !,?5,"or enter ^ALL to select all Divisions.",!
 S DIC("S")="I $S('$D(^PS(59,+Y,""I"")):1,'^(""I""):1,DT'>^(""I""):1,1:0)"
 S DIC="^PS(59,",DIC(0)="QEZAM",DIC("A")="Division: ",QF=0
 F  D ^DIC Q:X=""  D  Q:QF
 .I $$UP^XLFSTR(X)="^ALL" K ARY S ARY="^ALL",QF=1 Q
 .I $D(DTOUT)!$D(DUOUT) K ARY S ARY="^",QF=1 Q
 .W "   ",$P(Y,"^",2),$S($D(ARY(+Y)):"       (already selected)",1:"")
 .W ! S ARY(+Y)=""
 I '$D(ARY) S ARY="^"
 Q
VADR(ORN,VADD) ;Get Provider's Address
 ;ORN: Order IEN (Pointer to file #100)
 K ^TMP($J,"ORDEA"),VADD
 D ARCHIVE^ORDEA(ORN)
 I $D(^TMP($J,"ORDEA",ORN,3)) S VADD=^(3) D
 .I $P(VADD,"^",2)="" Q
 .S VADD(1)=$P(VADD,"^",2),VADD(2)=$P(VADD,"^",3)
 .S VADD(3)=$P(VADD,"^",4)_", "_$P(VADD,"^",5)_" "_$P(VADD,"^",6)
 K ^TMP($J,"ORDEA")
 Q
