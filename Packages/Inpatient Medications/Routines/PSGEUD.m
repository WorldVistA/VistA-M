PSGEUD ;BIR/CML3-EXTRA UNITS DISPENSED ;17 SEP 97 /  1:41 PM
 ;;5.0; INPATIENT MEDICATIONS ;**31,41,50,111,150,164**;16 DEC 97
 ;
 ; Reference to ^PSDRUG( is supported by DBIA 2192.
 ; Reference to ^PS(50.7 is supported by DBIA 2180.
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ;
 N PSJNEW,PSGPTMP,PPAGE,PSGEFN S PSJNEW=1
 D ENCV^PSGSETU Q:$D(XQUIT)  S (PSGONNV,PSGRETF)=1 K PSGPRP
 ;
GP ;
 S PSGP="",DFN=""
 D ENDPT^PSGP G:(PSGP'>0)&(DFN'>0)!('$D(PSJPAD)) DONE S:PSGP<1 PSGP=DFN I '$O(^PS(55,PSGP,5,"AUS",+PSJPAD)) W $C(7),!,"(Patient has NO active or old orders.)" G GP
 D ENL^PSGOU G:"^N"[PSGOL GP S PSGPTMP=0,PPAGE=1 D ^PSGO G:'PSGON GP S PSGLMT=PSGON,(PSGONC,PSGONR)=0
 F  W !!,"Select ORDER",$E("S",PSGON>1)," 1-",PSGON,": " R X:DTIME W:'$T $C(7) S:'$T X="^" Q:"^"[X  D:X?1."?" H I X'?1."?" D ENCHK^PSGON W:'$D(X) $C(7),"  ??" Q:$D(X)
 G:"^"[X GP F PSGRET=1:1:PSGODDD F PSGRET1=1:1 S PSGRET2=$P(PSGODDD(PSGRET),",",PSGRET1) Q:'PSGRET2  S PSGORD=^TMP("PSJON",$J,PSGRET2) D R G:$D(DTOUT) GP
 G GP
 ;
DONE ;
 D ENKV^PSGSETU K ^TMP("PSJON",$J),DO,DRGN,MR,OD,PSGLMT,PSGODDD,PSGEUD,PSGEUDA,PSGOL,PSGON,PSGONC,PSGONR,PSGONV,PSGONNV,PSGORD,PSGQ,PSGRET,PSGRET1,PSGRET2,PSGRETF,PSGSPD,SCH,WG,Z,CST Q
 ;
R ;
 S MR=$P($G(^PS(55,PSGP,5,+PSGORD,0)),"^",3),Y=$G(^(.2)),SCH=$P($G(^(2)),"^"),DO=$P(Y,"^",2),DRG=$P(Y,"^"),DRG=$S(DRG'=+DRG:"NOT FOUND",'$D(^PS(50.7,DRG,0)):DRG,$P(^(0),"^")]"":$P(^(0),"^"),1:DRG_";PS(50.7,")
 S:MR]"" MR=$S(MR'=MR:MR,'$D(^PS(51.2,MR,0)):MR,$P(^(0),"^",3)]"":$P(^(0),"^",3),$P(^(0),"^")]"":$P(^(0),"^"),1:MR_";PS(51.2,") W !!,"----------------------------------------",!,DRG,!,"Give: " D
 .N LN,MARX D TXT^PSGMUTL(DO_" "_MR_" "_SCH,65)
 .S LN="" F  S LN=$O(MARX(LN)) Q:LN=""  W:LN>1 ! W ?6,MARX(LN)
 I '$O(^PS(55,PSGP,5,+PSGORD,1,0)) D  Q
 .W !!,"No Dispense drugs have been entered for this order. At least one Dispense drugs",!,"must be associated with an order before dispensing information may be entered.",!!
 .N DIR S DIR(0)="E" D ^DIR S Y=$S(Y:0,1:1)
 S PSGEUD=0,WG=$O(^PS(57.5,"AB",+PSJPWD,0)) F DRG=0:0 S DRG=$O(^PS(55,PSGP,5,+PSGORD,1,DRG)) Q:'DRG  S X=$G(^(DRG,0)) I X D  Q:$D(DTOUT)
 .S UD=$P(X,"^",2),DRGN=$$ENDDN^PSGMI(+X) Q:DRGN=""  S:'$D(^PSDRUG(+X,212,"AC",+WG)) WG=""
 .I ($P(X,"^",3)?7N)&($P(PSGDT,".")'<$P(X,"^",3)) W !!,"Dispense drug: ",DRGN," **ORDER INACTIVE**" Q
 .I ($G(^PSDRUG(+X,"I"))?7N)&($P(PSGDT,".")'<$G(^PSDRUG(+X,"I"))) W !!,"Dispense drug: ",DRGN," **DRUG INACTIVE**" Q
 .W !!,"Dispense drug: ",DRGN,"  (U/D: ",$S('UD:1,1:UD),")"
 .K DA,DR S DA=+DRG,DA(2)=PSGP,DA(1)=+PSGORD,DIE="^PS(55,"_PSGP_",5,"_+PSGORD_",1,",DR=.11 S:$P($G(^PS(55,PSGP,5,+PSGORD,1,DA,0)),"^",11) $P(^(0),"^",11)=""
 .D ^DIE S PSGEUD=PSGEUD+$P($G(^PS(55,PSGP,5,+PSGORD,1,DA,0)),U,11)
 I PSGEUD,WG D QS
 Q
 ;
QS ;
 W !!,"THIS DRUG IS AN ATC ITEM." S Y=$G(^PS(57.5,WG,3)) I $P(Y,"^",3)="" W $C(7),"  BUT THE ATC DEVICE CANNOT BE FOUND!" S Y=0 Q
 S IOP="`"_$P(Y,"^",3),PSGSPD=$P(Y,"^",2) F  W !,"Do you want to dispense ",$S(PSGEUD>1:"these",1:"this")," extra unit",$E("s",PSGEUD>1)," through the ATC" S %=2 D YN^DICN Q:%  D QSH
 S Y=0 Q:%'=1  K %ZIS,IO("Q") S %ZIS="NQ",PSGION=ION,IOP=IOP_";255" D ^%ZIS I POP S IOP=PSGION D ^%ZIS W $C(7),!!?10,"** THE ATC MACHINE CANNOT BE FOUND! **" S Y=0 Q
 K ZTSAVE S PSGTIR="ENQ^PSGEUD",PSGTID=$H,ZTDESC="EXTRA UNITS TO ATC" F X="PSGP","PSGORD","PSGP(0)","PSGSPD" S ZTSAVE(X)=""
 D ENTSK^PSGTI W "...DONE" S Y=0 Q
 ;
ENQ ;
 D NOW^%DTC S DFN=PSGP D PID^VADPT
 S %=%_"0000000000000",BLKS="                    ",PN=$E($P(PSGP(0),"^")_BLKS,1,20),PID=$E(VA("PID")_BLKS,1,12),PL=$E($S($D(^DPT(PSGP,.1)):^(.1),1:"*N/F*")_BLKS,1,12)
 X ^%ZOSF("LABOFF") F PSGDRG=0:0 S PSGDRG=$O(^PS(55,PSGP,5,+PSGORD,1,PSGDRG)) Q:'PSGDRG  S X=$G(^(PSGDRG,0)) I X D
 .S C=$P(X,U,11),PSGEUDA=$P($G(^PSDRUG(+X,8.5)),U,2) Q:(PSGEUDA="")!('C)
 .S PSGEUDA=$E(PSGEUDA_BLKS,1,15) S:$L(C)<3 C=$E("000",1,3-$L(C))_C S C=C_$E(%,4,5)_$E(%,6,7)_$E(%,2,3)_$E(%,9,10)_$E(%,11,12) D @$S(PSGSPD:"S2",1:"S1")
 Q
 ;
S1 ;
 W $C(48) F Q=1:1:75 R *X:$S(Q<15:1,1:5) G:X=49 S1 I X=48 Q
 E  Q
 W $C(50),$C(52),PN_PID_PL_"IMD"_PSGEUDA_"1 ",$C(53),$C(54),C,$C(55),$C(13) F Q=1:1:75 R *X:$S(Q<15:1,1:5) G:X=49 S1 I X=48 Q
 Q
 ;
S2 ;
 W $C(48) F Q=1:1:75 R X:$S(Q<15:1,1:5) G:$A(X)=49 S2 I $A(X)=48 Q
 E  Q
 W $C(50),$C(52),PN_PID_PL_"IMD"_PSGEUDA_"1 ",$C(53),$C(54),C,$C(55),$C(13) F Q=1:1:75 R X:$S(Q<15:1,1:5) G:$A(X)=49 S2 I $A(X)=48 Q
 Q
 ;
QSH ;
 W !!?2,"This drug can be dispensed through the ATC machine.  Enter 'Y' to do so now.  Enter 'N' if you do not want to do so.",! Q
 ;
H ;
 W !!?2,"Select the orders (by number) for which you want to enter extra units",!,"dispensed." D:X'="?" H2^PSGON
 Q
