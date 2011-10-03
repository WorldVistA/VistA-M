PSDLBLP ;B'ham ISC/JPW - CS Print for Patient ID List ; 2 Mar 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
 I '$D(PSDSITE) D ^PSDSET Q:'$D(PSDSITE)
 ;I '$D(^XUSEC("PSJ RNURSE",DUZ)) W !!,"Contact your Pharmacy Coordinator.  You do not have the Supervisor",!,"access required to print labels.",!!
ASK ;ask naou or ward
 S PSDOUT=0 N PSD2
 K DA,DIR,DIRUT S DIR(0)="SO^N:Nursing Location;W:Ward",DIR("A",1)="You may select Nursing Location or Ward to print the Patient ID List."
 S DIR("?",1)="Enter 'N' to select Nursing Location to print list",DIR("?")="Enter 'W' to select Ward to print list."
 S DIR("A")="Select Method" D ^DIR K DIR G:$D(DIRUT) END S ANS=Y
 I Y="N" D ASKN G:PSDOUT END G DEV
WARD ;ask ward name
 W ! K DA,DIC
 F  S DIC=42,DIC(0)="QEAM",DIC("A")="Select Ward to print Patient ID List: " D ^DIC G:$D(DTOUT)!($D(DUOUT))!((X="")&('$D(PSDW))) END Q:X=""  D
 .S PSDW($P(Y,"^",2))=+Y_"^"_$P(Y,"^",2),PSDWN=$P(Y,"^",2)
 K DIC
DEV S DIR(0)="SO^A:Alphabetical;R:Room-Bed",DIR("A")="Sort"
 D ^DIR K DIR G:$D(DIRUT) END S ANS(1)=Y
 ;ask device and queue info
 W !!,"This report is designed to print bar codes on a printer.",!,"You may queue this report to print at a later time.",!!
 K %ZIS,IOP,IO("Q"),POP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED!" G END
 I $D(IO("Q")) K IO("Q"),ZTSAVE,ZTDTH,ZTSK S ZTRTN="START^PSDLBLP",ZTDESC="Print Patient ID List for CS PHARM" D SAVE,^%ZTLOAD,HOME^%ZIS K ZTSK G END
 U IO
START ;entry for compile and print labels
 K ^TMP("PSDLBLP",$J),PSDPRT S PSDCNT=0 D NOW^%DTC S PSDT=%
 F JJ=0,1 S @("PSDBAR"_JJ)="" I $D(^%ZIS(2,^%ZIS(1,IOS,"SUBTYPE"),"BAR"_JJ)) S @("PSDBAR"_JJ)=^("BAR"_JJ)
 I PSDBAR1]"",PSDBAR0]"" S PSDPRT=1
 G:ANS(1)="R" ^PSDLBLB
 S PSDWN="" F  S PSDWN=$O(PSDW(PSDWN)) Q:PSDWN=""  F PSD1=0:0 S PSD1=$O(^DPT("ACN",PSDWN,PSD1)) Q:'PSD1  I $D(^DPT(PSD1,0)) D
 .S DFN=PSD1 D DEM^VADPT S PATN=$S('VAERR:VADM(1),1:"UNKNOWN"),SSN=$P(VADM(2),"^"),PATN=PATN_" ("_VA("BID")_")"
 .S VAINDT=PSDT D INP^VADPT S PSDRM=VAIN(5)
 .K DFN,VADM,VAIN,VAINDT
 .S PSDCNT=PSDCNT+1,^TMP("PSDLBLP",$J,PSDWN,PATN,PSDCNT)=SSN_"^"_PSDRM
PRINT ;print labels
 S (PSDOUT,PG)=0,$P(LN,"-",80)="",(PSDX1,PSDCNT)=1
 I '$D(^TMP("PSDLBLP",$J)) D HDR W !!,?15,"**** NO PATIENT WARD INFO ****",!! G DONE
 S PSDN="" F  S PSDN=$O(^TMP("PSDLBLP",$J,PSDN)) Q:PSDN=""!(PSDOUT)  Q:PSDOUT  D HDR D  Q:PSDOUT
 .S PSD="" F  S PSD=$O(^TMP("PSDLBLP",$J,PSDN,PSD)) Q:PSD=""!(PSDOUT)  D:$Y+26>IOSL HDR Q:PSDOUT  F PSD1=0:0 S PSD1=$O(^TMP("PSDLBLP",$J,PSDN,PSD,PSD1)) Q:'PSD1!(PSDOUT)  S NODE=^(PSD1) D
 ..I $Y+26>IOSL D HDR Q:PSDOUT
 ..W !,PSD,?45,$P(NODE,"^",2),"  ",$G(PSDN)
 ..W ! I $D(PSDPRT) W @PSDBAR1,$P(NODE,"^"),@PSDBAR0,!!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;kill variables and exit
 D KVAR^VADPT K VA
 K %,%H,%ZIS,ANS,DA,DFN,DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,JJ,JJ1,JJ2,LN,NODE,POP,PATN,PG,PSD,PSD1,PSDBAR0,PSDBAR1,PSDCNT,PSDN,PSDOUT
 K PSDPRT,PSDR,PSDRM,PSDT,PSDW,PSDWN,PSDX1,PSDX2,SSN,VADM,VAERR,VAIN,VAINDT,X,Y,ZTDESC,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDLBLP",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;prints header information
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1,PSD(1)=0 W:$Y @IOF W !,"Patient ID List for "
 ;F  S PSD(1)=$O(PSDW(PSD(1))) Q:PSD(1)']""  W PSD(1)
 W $S($G(PSD2)]"":PSD2,$G(PSDN)]"":PSDN,$G(NAOUN)]"":NAOUN,$O(PSDW(""))]"":$O(PSDW("")),1:"")
 W " Printed: ",$$HTE^XLFDT($H,"P"),?70,"Page: ",PG,!
 W "PATIENT",?45,"ROOM-BED",!,LN,!!
 Q
SAVE ;save queued variables
 S ZTSAVE("PSDW(")="",ZTSAVE("PSD2")="",ZTSAVE("ANS(1)")=""
 S:$D(NAOUN) ZTSAVE("NAOUN")=""
 Q
ASKN ;ask nursing location
 K DA,DIC S DIC=211.4,DIC(0)="QEA",DIC("A")="Select Nursing Location: "
 W ! D ^DIC K DIC I Y<0 S PSDOUT=1 Q
 N PSD S PSD2=$P($P($G(^SC(+$P(Y,U,2),0)),U)," ",2)
 D GETS^DIQ(211.4,+Y_",","2*","","PSD") S PSD(1)=0
 F  S PSD(1)=$O(PSD(211.41,PSD(1))) Q:PSD(1)']""  D:$G(PSD(211.41,PSD(1),.01))]""
 .S PSDW($G(PSD(211.41,PSD(1),.01)))=0
 Q
WARD2 W !!,"Compiling Ward data for ",NAOUN,"..."
 F JJ=0:0 S JJ=$O(^PSD(58.8,"D",JJ)) Q:'JJ  F JJ1=0:0 S JJ1=$O(^PSD(58.8,"D",JJ,JJ1)) Q:'JJ1  F JJ2=0:0 S JJ2=$O(^PSD(58.8,"D",JJ,JJ1,JJ2)) Q:('JJ2)!(JJ2'=NAOU)  D
 .Q:$P($G(^DIC(42,+JJ1,0)),"^")']""
 .S PSDW($P($G(^DIC(42,+JJ1,0)),"^"))=+JJ1_"^"_$P($G(^DIC(42,+JJ1,0)),"^")
 Q
