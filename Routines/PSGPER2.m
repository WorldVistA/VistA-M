PSGPER2 ;BIR/CML3-PRINTS PRE-EXCHANGE NEEDS REPORT ;18 MAR 03 / 5:14 PM
 ;;5.0; INPATIENT MEDICATIONS ;**80,115**;16 DEC 97
 ;
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
ENQ ;
 D ENP S DIK="^PS(53.4,",DA=PSGPXN D ^DIK K DA,DIK,PSGPXN Q
 ;
ENP ;
 K ^TMP("PSGPERP",$J) U IO
 F DFN=0:0 S DFN=$O(^PS(53.4,PSGPXN,1,DFN)) Q:'DFN  D PID^VADPT,GWR F ON=0:0 S ON=$O(^PS(53.4,PSGPXN,1,DFN,1,ON)) Q:'ON  D ONI F DD=0:0 S DD=$O(^PS(53.4,PSGPXN,1,DFN,1,ON,1,DD)) Q:'DD  I $D(^(DD,0)) S ND=^(0) D DDS
 D NOW^%DTC S %=$$ENDTC^PSGMI(%),(BORD,F,L)="",$P(L,"-",81)="",$P(BORD,"#",25)="",T=IO'=IO(0)!($E(IOST)'="C"),RF=$S(T:0,1:0) D:'RF HEADER S (DN,DDN,NP,WD)=""
 F  S WD=$O(^TMP("PSGPERP",$J,WD)) Q:WD=""  S PI="" F  S F=0,PI=$O(^TMP("PSGPERP",$J,WD,PI)) Q:PI=""  S RB=^(PI) D
 . D PPI F  S F=1,DN=$O(^TMP("PSGPERP",$J,WD,PI,DN)) Q:DN=""  S PX=^(DN) D OP F  S DDN=$O(^TMP("PSGPERP",$J,WD,PI,DN,DDN)) Q:DDN=""  S PX=^(DDN) D PRT
 . I $O(^TMP("PSGPERP",$J,WD,PI))]"" S F="" D NP
 W:T&($Y) @IOF,@IOF D ^%ZISC
 ;
DONE ;
 K ^TMP("PSGPERP",$J),BORD,DN,DD,DO,DRG,DRGS,F,L,MR,ND,ND0,ND2,ND4,NP,ON,PI,PDN,PN,PX,RB,RF,SCH,SDN,SN,SND1,SPN,STOP,STRT,T,UD,VD,VU,W,WD,X,XL,Y,DDN,I2,ND1,PSG25,PSG26,PSGEB,PSGEBN,PSGNODE,PSGOAT,PSGSTAT
 K DONE,FIL,NF,PDM,PDRG,PSGACTO,PSGDA,PSGNEFDO,PSGNESDO,PSGPEN,PSGPENWS,PSGY,PSIVAC,PSIVCT,PSIVE,PSIVEXAM,PSIVUP,PSIVWAT,PSJH,PSJNOO,PSJNOON
 Q
 ;
NP ;
 I 'T K DIR S DIR(0)="E" W ! D ^DIR S:'Y WD="zzz" W:Y $C(13),# Q
 ;
HEADER ;
 W:$Y @IOF W !?20,"PRE-EXCHANGE UNITS REPORT - ",%
 W !!,"Ward",?32,"Room-bed",!,"Patient",!?5,"Order",!?20,"Dispense Drug",?64,"U/D",?72,"Needs",!,L
 W:F !!,$S(WD'="zz":WD,1:"NOT FOUND"),?32,RB,!,PN_"  ("_SN_")" Q
 ;
GWR ;
 S WD=$G(^DPT(DFN,.1)),RB=$G(^(.101)),PN=$P($G(^(0)),"^") S:WD="" WD="zz" S:RB="" RB="NOT FOUND" S:PN="" PN=DFN_";DPT("
 S SPN=$E(PN,1,20)_"^"_DFN,^TMP("PSGPERP",$J,WD,SPN)=PN_"^"_RB_"^"_VA("BID") Q
 ;
ONI ;
 S ND=$G(^PS(55,DFN,5,ON,0)),DN=$G(^(.2)),SCH=$P($G(^(2)),"^"),MR=$P(ND,"^",3),ND=$$ENNPN^PSGMI($P(ND,"^",2)),DO=$P(DN,"^",2),DN=$P(DN,"^") I DN="" S DN="zz"
 E  S DN=$$ENPDN^PSGMI(DN)
 S:MR]"" MR=$$ENMRN^PSGMI(MR) S SDN=$E(DN,1,20)_"^"_ON,^TMP("PSGPERP",$J,WD,SPN,SDN)=DN_"^"_DO_"^"_MR_"^"_SCH_"^"_$P(ND,"^",2) Q
 ;
DDS ;
 S ND1=$G(^PS(55,DFN,5,ON,1,+ND,0)),UD=$P(ND1,"^",2),ND1=$$ENDDN^PSGMI(+ND1),SND1=$E(ND1,1,20)_"^"_+ND,ND=$P(ND,"^",2)
 I ND#1 S ND=(ND\1)+1
 S ^TMP("PSGPERP",$J,WD,SPN,SDN,SND1)=ND1_"^"_UD_"^"_ND
 Q
 ;
PPI ;
 S DFN=$P(PI,"^",2),PN=$P(RB,"^"),SN=$P(RB,"^",3),RB=$P(RB,"^",2) I 'RF,$Y+6>IOSL D NP Q:NP["^"
 W !!,$S(WD'="zz":WD,1:"NOT FOUND"),?32,RB,!,PN,"  ("_SN_")" Q
 ;
OP ;
 S PDN=$P(PX,"^"),DO=$P(PX,"^",2),MR=$P(PX,"^",3),SCH=$P(PX,"^",4)
 W !?5,PDN," ",DO," ",MR,$S(MR]"":" ",1:""),SCH
 Q
PRT ; find order info and print same
 I 'RF,$Y+4>IOSL D NP Q:NP="^"
 I 1 S PDN=$P(PX,"^"),UD=$P(PX,"^",2),PX=$P(PX,"^",3) W !?20,PDN,?62,$J($S('UD:1,$E(UD)=".":0_UD,1:UD),5),?72,$J(PX,5) Q
 S ON=$P(DN,"^",2),ND=$G(^PS(55,DFN,5,ON,0)),ND2=$G(^(2)),ND4=$G(^(4)),Y=$P($G(^(6)),"^"),ND0=$G(^(.1)),DO=$P(ND0,"^",2)
 S DRG=$$ENDDN^PSGMI($P(ND0,"^")),MR=$$ENMRN^PSGMI(MR) ; ,DRGS=$P($G(^(+$O(^PS(55,DFN,5,ON,1,0)),0)),"^")
 I 'RF W !?5,DRG,?47,DO,?65,$J($S('UD:1,UD=.5:"1/2",UD=.25:"1/4",UD?1".".N:0_UD,1:UD),5),?75,$J(+PX,5) Q
 ;
 S SCH=$P(ND2,"^"),STRT=$P(ND2,"^",2),STOP=$P(ND2,"^",4),VU=$P(ND4,"^",3),VD=$P(ND4,"^",4),VU=$P($G(^VA(200,+VU,0)),"^",2) S:VU="" VU=$P(ND4,"^",3)
 F Q="STRT","STOP","VD" S @Q=$$ENDTC^PSGMI(@Q)
 W:$Y @IOF W !!?6,BORD_"  PRE-EXCHANGE MED  "_BORD,!?6,"#",?73,"#",!?6,"#  ",PN,?50,"Ward: ",WD,?73,"#",!?6,"#  ("_SN_")",?52,"RB: "_RB,?73,"#",!?6,"#",?73,"#"
 W !?6,"#  "_DRG,?46,"START: "_STRT,?73,"#",!?6,"#  "_$S(DRGS]"":"("_DRGS_")",1:""),?47,"STOP: "_STOP,?73,"#",!?6,"#  GIVE: "_$S(DO]"":" "_DO,1:"")_$S(MR]"":" "_MR,1:"")_$S(SCH]"":" "_SCH,1:""),?73,"#"
 S XL=0 I Y="" W !?6,"#",?73,"#",!?6,"#  (NO SPECIAL INSTRUCTIONS)"
 E  W !?6,"#",?73,"#",!?6,"#    " S Y=$$ENSET^PSGSICHK(Y) F Q=1:1:$L(Y," ") S X=$P(Y," ",Q) S:$X+$L(X)>72 XL=XL+1 W:$X+$L(X)>72 ?73,"#",!?6,"#  " W X_" "
 W ?73,"#",!?6,"#",?73,"#",!,?6,"#",?43,"VERIFIED: "_VD,?73,"#",!?6,"#",?49,"BY: "_VU,?73,"#",!?6,"#",?38,"SEND TO FLOOR: "_PX,?73,"#"
 S XL=2-XL I XL>0 F Q=1:1:XL W !?6,"#",?73,"#"
 W !?6,"#",?73,"#",!?6,"#",?36,"_______________     _______________  #",!?6,"#",?36,"FILLED BY",?56,"CHECKED BY",?73,"#",!?6,BORD_BORD_$E(BORD,1,20) Q
