PRCPRPC2 ;WISC/RFJ/DWA-patient distribution costs (print report) ;11 Mar 94
 ;;5.1;IFCAP;**32**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
PRINT ;  print report
 D NOW^%DTC S Y=% D DD^%DT S NOW=Y,PAGE=1,SCREEN=$$SCRPAUSE^PRCPUREP U IO D H
 S ORROOM=""
 ;  show report variables selected
 W !!?10,"*** R E P O R T   V A R I A B L E S   S E L E C T E D ***",!
 W !,"SURGICAL SPECIALTY RANGE FROM      : ",$S(PRCPSURS="":"FIRST",1:PRCPSURS),?60,"TO: ",$S(PRCPSURE="z":"LAST",1:PRCPSURE)
 W !,"PATIENT NAME RANGE FROM            : ",$S(PRCPPATS="":"FIRST",1:PRCPPATS),?60,"TO: ",$S(PRCPPATE="z":"LAST",1:PRCPPATE)
 W !,"OPERATION/PROCEDURE CODE RANGE FROM: ",$S(PRCPOPCS="":"FIRST",1:PRCPOPCS),?60,"TO: ",$S(PRCPOPCE="z":"LAST",1:PRCPOPCE)
 S Y=DATESTRT D DD^%DT W !,"DISTRIBUTION DATES FROM            : ",Y S Y=DATEEND D DD^%DT W ?60,"TO: ",Y,!
 W !,"PRINT SUMMARY ONLY   : ",$S(PRCPSUMM=1:"YES",1:"NO")
 W !,"PRINT ITEMS ON REPORT: ",$S($G(PRCPFITM)=1:"YES",1:"NO")
 ;
 S DISTRNM="" F  S DISTRNM=$O(^TMP($J,"PRCPRPCR",DISTRNM)) Q:DISTRNM=""!($G(PRCPFLAG))  S SURGSPEC="" F  S SURGSPEC=$O(^TMP($J,"PRCPRPCR",DISTRNM,SURGSPEC)) Q:SURGSPEC=""!($G(PRCPFLAG))  D
 .   I $G(ZTQUEUED),$$S^%ZTLOAD S PRCPFLAG=1 W !?10,"<<< TASKMANAGER JOB TERMINATED BY USER >>>" Q
 .   I $Y>(IOSL-8) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   I '$G(PRCPSUMM) W !!?5,"FROM Inventory Point: ",DISTRNM,?40,"TO Surgical Specialty: ",SURGSPEC
 .   S INOUTPAT="" F  S INOUTPAT=$O(^TMP($J,"PRCPRPCR",DISTRNM,SURGSPEC,INOUTPAT)) Q:INOUTPAT=""!($G(PRCPFLAG))  D
 .   .   S PATNAME="" F  S PATNAME=$O(^TMP($J,"PRCPRPCR",DISTRNM,SURGSPEC,INOUTPAT,PATNAME)) Q:PATNAME=""!($G(PRCPFLAG))  D
 .   .   .   S OPCODE="" F  S OPCODE=$O(^TMP($J,"PRCPRPCR",DISTRNM,SURGSPEC,INOUTPAT,PATNAME,OPCODE)) Q:OPCODE=""!($G(PRCPFLAG))  D
 .   .   .   .   S DA=0 F  S DA=$O(^TMP($J,"PRCPRPCR",DISTRNM,SURGSPEC,INOUTPAT,PATNAME,OPCODE,DA)) Q:'DA!($G(PRCPFLAG))  S DATA=^(DA) D
 .   .   .   .   .   S SURGEON=$E($$USER^PRCPUREP(+$P(DATA,"^",2)),1,15) I SURGEON="" S SURGEON=" "
 .   .   .   .   .   S TOTCOST=$P(DATA,"^",3)
 .   .   .   .   .   ;  accumulate totals
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",1,DISTRNM)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(DISTRNM)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",2,SURGSPEC)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(SURGSPEC)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",2,SURGSPEC,INOUTPAT)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(INOUTPAT)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",3,INOUTPAT)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(INOUTPAT)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",4,OPCODE)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(OPCODE)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",5,SURGEON)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(SURGEON)=%
 .   .   .   .   .   S %=$G(^TMP($J,"PRCPRPCRT",6)),$P(%,"^")=$P(%,"^")+1,$P(%,"^",2)=$P(%,"^",2)+TOTCOST,^(6)=%
 .   .   .   .   .   I $G(PRCPSUMM) Q
 .   .   .   .   .   ;
 .   .   .   .   .   S Y=DA D DD^%DT S DATE=$P(Y,",")
 .   .   .   .   .   I $P(DATA,"^")'="" S ORROOM=$E($P($G(^SC($P($G(^SRS(+$P(DATA,"^"),0)),"^"),0)),"^"),1,10)
 .   .   .   .   .   S:ORROOM="" ORROOM="N/A"
 .   .   .   .   .   W !,PATNAME,?12,INOUTPAT,?17,OPCODE,?26,DATE,?35,SURGEON,?52,ORROOM,?65,$J(TOTCOST,15,2) S ORROOM=""
 .   .   .   .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 .   .   .   .   .   I $G(PRCPFITM)=1 S ITEMDA=0 F  S ITEMDA=$O(^PRCP(446.1,DA,445,ITEMDA)) Q:'ITEMDA!($G(PRCPFLAG))  S DATA=$G(^(ITEMDA,0)) I DATA'="" D
 .   .   .   .   .   .   W !?10,"IM# ",ITEMDA,?20,$E($$DESCR^PRCPUX1(PRCP("I"),ITEMDA),1,25),?50,"QTY: ",+$P(DATA,"^",2),?65,$J(+$P(DATA,"^",3),15,2)
 .   .   .   .   .   .   I $Y>(IOSL-4) D:SCREEN P^PRCPUREP Q:$D(PRCPFLAG)  D H
 I $G(PRCPFLAG) Q
 K ORROOM
 ;
 ;  print report totals
 D PRINTOTL^PRCPRPC3
 Q
 ;
 ;
H S %=NOW_"  PAGE "_PAGE,PAGE=PAGE+1 I PAGE'=2!(SCREEN) W @IOF
 W $C(13),"PATIENT DISTRIBUTION COST REPORT FOR: ",$E(PRCP("IN"),1,20),?(80-$L(%)),%
 S %="",$P(%,"-",81)=""
 I $G(PRCPFTOT) W !,"*** R E P O R T  T O T A L S ***",?46,$J("COUNT",10),$J("TOTAL COST",12),$J("AVERAGE",12),!,% Q
 W !,"NAME-SSN",?11,"IO",?17,"OPCODE",?26,"DATE",?35,"SURGEON",?52,"OR ROOM",?70,"TOTAL COST",!,%
 Q
