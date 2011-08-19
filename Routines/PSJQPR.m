PSJQPR ;BIR/MLM-INPATIENT MEDS/IV FLUIDS QUICK ORDERS REPORT ;29 SEP 94 / 9:13 AM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
EN ; Entry point to enter/edit Inpatient Pharmacy quick orders/protocols.
 W:$Y @IOF W !,"  This lists Inpatient Medication and/or IV Fluid Quick Orders that have been",!
 W "defined in the Pharmacy Quick Orders file. You may list only IV Fluid quick",!,"orders, only Inpatient Medication quick orders, or all quick orders."
 K DIR S DIR(0)="SO^F:IV Fluids;M:Inpatient Medications;A:All",DIR("B")="All",DIR("??")="^D HLP^PSJQPR" D ^DIR Q:$D(DIRUT)  S P("TYP")=$S(Y="F":1,Y="M":2,1:3)
 ;
ENQ ; Ask device and queue report.
 W ! K IO("Q"),%ZIS,IOP S %ZIS="QM" D ^%ZIS I POP W !,"NO DEVICE SELECTED OR REPORT PRINTED" G K
 G:'$D(IO("Q")) DEQ K ZTDTH,ZTSAVE,ZTSK S ZTIO=ION,ZTSAVE("P(")="",ZTRTN="DEQ^PSJQPR",ZTDESC="IV FLUIDS QUICK ORDERS REPORT" K IO("Q") D ^%ZTLOAD W:$D(ZTSK) !,"Queued."
 ;
K ; Kill and exit.
 K P,X,Y
 Q
 ;
DEQ ; Queued entry point.
 K ^TMP("PSIV",$J)
 U IO D @("SORT"_P("TYP")) I '$D(^TMP("PSIV",$J)) W !!,"NO " W:P("TYP")#2=1 "IV FLUID" W:P("TYP")=3 " OR " W:P("TYP")>1 "INPATIENT MEDICATION" W " QUICK ORDERS FOUND",!! D K Q
 S UL80="",$P(UL80,"-",80)="" D NOW^%DTC S HDT=$P(%,".") D HD
 F P1=0:0 S P1=$O(^TMP("PSIV",$J,P1)) Q:'P1!$D(DUOUT)  S P2="" F  S P2=$O(^TMP("PSIV",$J,P1,P2)) Q:P2=""!$D(DUOUT)  F P3=0:0 S P3=$O(^TMP("PSIV",$J,P1,P2,P3)) Q:'P3!$D(DUOUT)  D PRINT
 I $E($G(IOST))'="C" W:$Y @IOF
 E  I '$D(DUOUT) K DIR S DIR(0)="E" D ^DIR
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 K %,DUOUT,HDT,ND,P,P2,P1,P3,PG,UL80,^UTILITY("PSIV",$J)
 Q
 ;
SORT1 ; List only IV Fluids.
 F P1=0:0 S P1=$O(^PS(57.1,"C",P("TYP"),P1)) Q:'P1  D SAVE
 Q
SORT2 ; List only Inpatient Meds.
 F P1=0:0 S P1=$O(^PS(57.1,"C",P("TYP"),P1)) Q:'P1  D SAVE
 Q
SORT3 ; List all.
 F P1=0:0 S P1=$O(^PS(57.1,P1)) Q:'P1  D SAVE
 Q
 ;
SAVE ; Sort order data.
 S ND=$G(^PS(57.1,P1,0)),^TMP("PSIV",$J,+$P(ND,U,3),$P(ND,U),P1)=""
 Q
 ;
PRINT ; Print Quick Orders.
 S ND=$G(^PS(57.1,+P3,0)),P("QOP")=$P(ND,U,2) S:P("QOP") P("QOP")=$P($G(^ORD(101,+P("QOP"),0)),U) I $Y+5>IOSL D PAUSE Q:$D(DUOUT)
 W !!?8,"QUICK ORDER NAME: ",$P(ND,U),!,?20,"TYPE: ",$S(P1=1:"IV FLUID",1:"INPATIENT MEDICATION"),!,?11,"PROTOCOL NAME: ",P("QOP"),!
 D @("PRINT"_P1) Q:$D(DUOUT)  D:$Y+3>IOSL PAUSE Q:$D(DUOUT)
 S P("PCP")=$S($P($G(^PS(57.1,P3,1)),U,6)=1:"No",1:"Yes")
 W "Provider Comments Prompt: ",P("PCP"),!!,?16,"COMMENTS: "
 I $D(^PS(57.1,P3,2)) F PC=0:0 S PC=$O(^PS(57.1,P3,2,PC)) Q:'PC  D
 .S LN=$G(^PS(57.1,P3,2,PC,0))
 .F LNN=1:1:$L(LN," ") D
 ..I $X+$L($P(LN," ",LNN))>79 W !,?26
 ..W $P(LN," ",LNN)," " D:$Y+3>IOSL PAUSE Q:$D(DUOUT)
 Q:$D(DUOUT)  W ! I $Y+3>IOSL D PAUSE
 Q
 ;
PRINT1 ; Print IV Fluid order.
 I $Y+1>IOSL D PAUSE Q:$D(DUOUT)
 W ! F P("SS")=3,4 Q:$D(DUOUT)  S FIL=$S(P("SS")=3:52.6,1:52.7) W:$X>16 ! W ?16,$S(FIL=52.6:"Additive:",1:"Solution:")," " F P("DRG")=0:0 S P("DRG")=$O(^PS(57.1,P3,P("SS"),P("DRG"))) Q:'P("DRG")!$D(DUOUT)  D
 .S ND=$G(^PS(57.1,P3,P("SS"),P("DRG"),0)),P("AMT")=$P(ND,U,2),ND=$G(^PS(FIL,+$P(ND,U),0))
 .W ?26,$S($P(ND,U)]"":$P(ND,U),1:"Undefined "_$S(FIL=52.6:"Additive",1:"Solution"))," ",P("AMT"),! I $Y+1>IOSL D PAUSE Q:$D(DUOUT)
 Q:$D(DUOUT)
 W:$X>16 !
 S P("IF")=$P($G(^PS(57.1,P3,1)),U,5)
 W ?11,"Infusion Rate: ",$S(P("IF")]"":P("IF"),1:"Undefined"),!
 Q
 ;
PRINT2 ; Print Inpatient Med. order.
 I $Y+5>IOSL D PAUSE Q:$D(DUOUT)
 S ND=$G(^PS(57.1,P3,1)),P("SC")=$P(ND,U,3),P("PD")=$P($G(^PS(50.3,+$P(ND,U),0)),U),P("MR")=$P($G(^PS(51.2,+$P(ND,U,2),0)),U,3),P("DO")=$P(ND,U,4)
 F X="PD","MR","SC","DO" S:P(X)="" P(X)="Undefined"
 W !,?12,"Primary Drug: ",P("PD"),!,?10,"Dosage Ordered: ",P("DO"),!,?15,"Med Route: ",P("MR"),!,?16,"Schedule: ",P("SC"),!
 Q
 ;
PAUSE I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR Q:$D(DUOUT)
 D HD
 Q
 ;
HD ; Print report header.
 S PG=$G(PG)+1 W:$Y @IOF W !,?71,"PAGE: ",PG,!!,?21,"INPATIENT PHARMACY QUICK ORDER REPORT",?63,"DATE: ",$$WDTE^PSIVUTL(HDT),!!,UL80,!
 Q
HLP ;DIR("??") Help
 W !!?5,"Please make the appropriate selection for your Quick Orders Report!"
 Q
