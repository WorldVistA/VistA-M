PSIVAOR1 ;BIR/PR-PRINT ACT/DC ORDER RPT BY WD/DRG ;16 DEC 97 / 1:39 PM 
 ;;5.0; INPATIENT MEDICATIONS ;**31**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191
 ; Reference to ^PS(52.6 is supported by DBIA 1231
 ; Reference to ^PS(52.7 is supported by DBIA 2173
 ;
P1 ;Print IV room
 F IV=0:0 D F S IV=$O(^TMP("PSJ",$J,IV)) Q:'IV  W !!,"IV ROOM: ",$S($D(^PS(59.5,IV,0)):$P(^(0),U),1:"Broken pointer??") D P2
 Q
P2 ;Print out ward
 S WD="" F P2=0:0 D F S WD=$O(^TMP("PSJ",$J,IV,WD)) Q:WD=""  W !!?1,"WARD: ",WD D P3
 Q
P3 ;Print out patient
 S PAT="" F P3=0:0 D F S PAT=$O(^TMP("PSJ",$J,IV,WD,PAT)) Q:PAT=""  S DFN=$P(PAT,U,2),ON="" W !!,?4,$P(PAT,U)," ",$P(PAT,U,3)," ",$P(PAT,U,4) D P4
 Q
P4 ;Print order number
 F Q=0:0 D F S ON=$O(^TMP("PSJ",$J,IV,WD,PAT,ON)) Q:ON=""  W !!?7,"[",+ON,"]     ",$P(ON,U,2) S G=^PS(55,DFN,"IV",+ON,0) D P40 S Y=$P(G,U,3),P6=$P(G,U,6) X ^DD("DD") S P6=$S($D(^VA(200,P6,0)):$P(^(0),U),1:"?") W ?35,Y,?60,$E(P6,1,20) D P5
 Q
P40 ;Print ONCALL or HOLD
 I "HO"[$P(G,U,17) W $S($P(G,U,17)="H":"  (*ON HOLD*)",1:"  (*ON CALL*)")
 Q
P5 ;Print out order contents
 F P5=0:0 D F S P5=$O(^PS(55,DFN,"IV",+ON,"AD",P5)) Q:'P5  I $D(^(P5,0)) S NA=^(0) W !,?9,$P(^PS(52.6,+NA,0),U)," ",$P(NA,U,2)
 F P5=0:0 D F S P5=$O(^PS(55,DFN,"IV",+ON,"SOL",P5)) Q:'P5  I $D(^(P5,0)) S NA=^(0) W !?9,$P(^PS(52.7,+NA,0),U)," ",$P(NA,U,2)
 D F W !?9,$P(^PS(55,DFN,"IV",+ON,0),U,8) I $P(^(0),U,9)'="" D F W !?9,$P(^(0),U,9)," ",$P(^(0),U,11)
 D F W !?9,"Cumulative doses: ",$S($D(^PS(55,DFN,"IV",+ON,9)):+$P(^(9),U,3),1:0)
 I XREF="ADC" D F S Y=$S($D(^PS(55,DFN,"IV",+ON,"ADC")):^("ADC"),1:"NF") I Y X ^DD("DD") W !?9,"Last DC'd on: ",Y
 ;
 Q
F I $Y+5>IOSL D H^PSIVAOR
 Q
