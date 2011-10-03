PSORXCLE ;BHAM ISC/SAB-routine to look for bad Rxs ;08/27/00
 ;;7.0;OUTPATIENT PHARMACY;**49,50**;DEC 1997
 ;External reference to ^PS(59.7 supported by DBIA 694
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference ^PS(50.606 supported by DBIA 2174
 K ^TMP($J),^TMP("PSOTMP",$J)
 S SER=1 D ASK G:$G(QUE) END I $G(PSTOP) K PSTOP G END
EN D QUE,PRI,END
 Q
 ;
QUE S SDT=SDT-1 F  S SDT=$O(^PSRX("AD",SDT)) Q:'SDT  F RXN1=0:0 S RXN1=$O(^PSRX("AD",SDT,RXN1)) Q:'RXN1  D
 .Q:$D(^TMP($J,RXN1,0))  S ^TMP($J,RXN1,0)=1
 .I $E($P($G(^PSRX(RXN1,3)),"^",7),1,33)="New Order Created by editing Rx #" D:$G(SER) PAT D:$G(DRG) DRGS
 Q
PRI ;output
 D NOW^%DTC S Y=% X ^DD("DD") S TD=Y K %
 S $P(LINE,"=",130)="=",$P(SEP,"-",130)="-" D HDR I '$O(^TMP("PSOTMP",$J,0)) W !!,"No Data Found",! G END
 F I=0:0 S I=$O(^TMP("PSOTMP",$J,I)) Q:'I  S DAT=^TMP("PSOTMP",$J,I,0) D
 .I ($Y+7)>IOSL D HDR
 .I $G(DRG) D PRI1 Q
 .W !,$P(^PSRX(I,0),"^"),?35,$P(^DPT($P(DAT,"^"),0),"^")_" ("_$P(DAT,"^",7)_")",?76,$P(^PSDRUG($P(DAT,"^",2),0),"^")
 .W !,"     Rx Created: "_$P(DAT,"^",9)_"  Remarks: "_$P(DAT,"^",4)
 .W !,$P(^PSRX($P(DAT,"^",3),0),"^"),?35,$P(^DPT($P(DAT,"^",5),0),"^")_" ("_$P(DAT,"^",8)_")",?76,$P(^PSDRUG($P(DAT,"^",6),0),"^"),!,LINE
END ;
 D ^%ZISC K LINE,SEP,PAT1,PAT2,RXN1,RXN2,I,NODE,DAT,^TMP("PSOTMP",$J),SDT,^TMP($J),INSTD,PG,TD,VA,RX,END,INST,X,Y,QUE,SER,DRG,DRG1,DRG2,OR1,OR2,%DT,%T
 Q
PRI1 ;outputs drug report
 W !,$P(^DPT($P(DAT,"^"),0),"^")_" ("_$P(DAT,"^",8)_")"
 W !,$P(^PSRX(I,0),"^"),?15,$P(^PSDRUG($P(DAT,"^",2),0),"^"),?60,$P(^PS(50.7,$P(DAT,"^",3),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 I $P(^PSDRUG($P(DAT,"^",2),2),"^") W !?34,"Drug File Orderable Item: "_$P(^PS(50.7,$P(^PSDRUG($P(DAT,"^",2),2),"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 W !?5,"Rx Created: "_$P(DAT,"^",9)_"  Remarks: "_$P(DAT,"^",5)
 W !,$P(^PSRX($P(DAT,"^",4),0),"^"),?15,$P(^PSDRUG($P(DAT,"^",6),0),"^"),?60,$P(^PS(50.7,$P(DAT,"^",7),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 I $P(^PSDRUG($P(DAT,"^",6),2),"^") W !?34,"Drug File Orderable Item: "_$P(^PS(50.7,$P(^PSDRUG($P(DAT,"^",6),2),"^"),0),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 W !,LINE
 Q
HDR ;header
 S PG=$G(PG)+1
 U IO W @IOF,"Report of New Prescriptions Created by an Edited Prescription - "_$S($G(SER)=1:"Patient",1:"Drug")_" Search",?122,"Page: "_PG,!,"Search Date from "_INSTD,?35,"Run Date/Time: "_TD
 I $G(SER)=1 W !!,"New Rx",?35,"Patient",?76,"Drug",!,"Edited Rx",!,SEP Q
 W !!,"Patient's Name",!,"New Rx",!,"Edited Rx",?15,"Drug",?60,"Rx Orderable Item",!,SEP
 Q
ASK S (Y,INST)=$P(^PS(59.7,1,49.99),"^",4) X ^DD("DD") S INSTD=Y
 W !!,"Version 7.0 of Outpatient Pharmacy was installed on "_INSTD_"."
 K %DT S %DT("A")="What Date would you like to start your search: ",%DT("B")=INSTD
 S %DT(0)=INST,%DT="EPXA" D ^%DT I "^"[X D END S QUE=1 W !!,"Report Request Cancelled!",! Q
 G ASK:Y<0 S SDT=Y X ^DD("DD") S INSTD=Y K %DT
 W !!,"This is a 132 column Report.",! K %ZIS,IOP,ZTSK,ZTQUEUED
 S %ZIS("A")="Select a Printer: ",PSOION=ION,%ZIS="QM",%ZIS("B")="" D ^%ZIS K %ZIS I POP S IOP=PSOION,PSTOP=1 D ^%ZIS K IOP,PSOION G END
 K PSOION,QUE I $D(IO("Q")) S QUE=1 D
 .S ZTDESC="Outpatient Pharmacy Rx Search",ZTRTN=$S($G(SER)=1:"EN",1:"EN1")_"^PSORXCLE",ZTSAVE("ZTREQ")="@",(ZTSAVE("SDT"),ZTSAVE("INSTD"),ZTSAVE("DRG"),ZTSAVE("SER"))="" D ^%ZTLOAD
 .I $D(ZTSK) W !,"Printout Queued to Print.",! K ZTSK
 Q
DRG ;entry point to look for wrong drug
 K ^TMP($J),^TMP("PSOTMP",$J)
 W !,"This option will print a report of possible Prescriptions where the",!,"dispense drug name was changed incorrectly."
 S DRG=1 D ASK G:$G(QUE) END I $G(PSTOP) K PSTOP G END
EN1 D QUE,PRI,END
 Q
PAT Q:RXN1']""!('$D(^PSRX(+RXN1,0)))  S PAT1=$P(^PSRX(RXN1,0),"^",2),RMK=$P(^PSRX(RXN1,3),"^",7)
 S RXN2=$P(RMK,"Rx # ",2),RXN2=$P(RXN2,"."),RXN2=$O(^PSRX("B",RXN2,0))
 Q:RXN2']""!('$D(^PSRX(+RXN2,0)))  S PAT2=$P(^PSRX(RXN2,0),"^",2)
 I PAT1=PAT2 K PAT1,PAT2,RXN2,RMK Q
 S ^TMP("PSOTMP",$J,RXN1,0)=PAT1_"^"_$P(^PSRX(RXN1,0),"^",6)_"^"_RXN2_"^"_RMK_"^"_PAT2_"^"_$P(^PSRX(RXN2,0),"^",6)
 F DFN=PAT1,PAT2 D PID^VADPT S ^TMP("PSOTMP",$J,RXN1,0)=^TMP("PSOTMP",$J,RXN1,0)_"^"_VA("BID")
 S Y=$P(^PSRX(RXN1,2),"^") X ^DD("DD") S ^TMP("PSOTMP",$J,RXN1,0)=^TMP("PSOTMP",$J,RXN1,0)_"^"_Y
 K PAT1,PAT2,RXN2,RMK,VA,DFN
 Q
DRGS Q:RXN1']""!('$D(^PSRX(+RXN1,0)))
 S PAT1=$P(^PSRX(RXN1,0),"^",2),RMK=$P(^PSRX(RXN1,3),"^",7),RXN2=$P(RMK,"Rx # ",2),RXN2=$P(RXN2,"."),RXN2=$O(^PSRX("B",RXN2,0))
 Q:RXN2']""!('$D(^PSRX(+RXN2,0)))
 S PAT2=$P(^PSRX(RXN2,0),"^",2),DRG2=$P(^PSRX(RXN2,0),"^",6),DRG1=$P(^PSRX(RXN1,0),"^",6)
 S OR1=$P(^PSRX(RXN1,"OR1"),"^"),OR2=$P(^PSRX(RXN2,"OR1"),"^")
 I DRG1=DRG2 K PAT1,PAT2,RXN2,RMK,DRG1,DRG2,OR1,OR2 Q
 I PAT1'=PAT2 K PAT1,PAT2,RXN2,RMK,DRG1,DRG2,OR1,OR2 Q
 I DRG1'=DRG2,$P(^PSDRUG(DRG1,2),"^")=$P(^PSDRUG(DRG2,2),"^") K PAT1,PAT2,RXN2,RMK,DRG1,DRG2,OR1,OR2 Q
 S ^TMP("PSOTMP",$J,RXN1,0)=PAT1_"^"_DRG1_"^"_OR1_"^"_RXN2_"^"_RMK_"^"_DRG2_"^"_OR2
 S DFN=PAT1 D PID^VADPT S ^TMP("PSOTMP",$J,RXN1,0)=^TMP("PSOTMP",$J,RXN1,0)_"^"_VA("BID")
 S Y=$P(^PSRX(RXN1,2),"^") X ^DD("DD") S ^TMP("PSOTMP",$J,RXN1,0)=^TMP("PSOTMP",$J,RXN1,0)_"^"_Y
 K PAT1,PAT2,RXN2,RMK,VA,DFN,DRG1,DRG2,OR1,OR2
 Q
