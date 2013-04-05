PSJOE0 ;BIR/CML3-INPATIENT PROFILE AND ORDER ENTRY ; 4/15/10 2:45pm
 ;;5.0;INPATIENT MEDICATIONS;**47,56,110,133,162,241,267**;16 DEC 97;Build 158
 ;
 ; Reference to ^PS(51.2 is supported by DBIA 2178.
 ; Reference to ^PS(55 is supported by DBIA 2191.
 ; Reference to ^VA(200 is supported by DBIA 10060.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
START ; print orders
 W:X]"" $P("^PROFILE",X,2) D ENL^PSJO3 G:PSJOL="^" DONE Q:PSJOL="N"  K PSJPR S PSGOEAV=0,PSJNARC=1 D ^PSJO I 'PSJON Q
 ;
ENVW ; ask user to select or view any of the orders shown
 S (PSGONC,PSGONR,PSGONV)=0,PSGLMT=PSJON S:$D(PSJPRF) PSGPRF=1 D ENASR^PSGON K PSGPRF
 G:X["^" DONE I X]"" S PSGOEA=""
 K PSJDLW
 I  F PSJOE=1:1:PSGODDD S PSGOE=PSJOE F PSJOE1=1:1:$L(PSGODDD(PSJOE),",")-1 S PSJOE2=$P(PSGODDD(PSJOE),",",PSJOE1),(PSGORD,PSJORD)=^TMP("PSJON",$J,PSJOE2) G:$D(PSJDLW) DONE D 
 .I PSJORD=+PSJORD N PSJO,PSJO1 S PSJO=PSJORD,PSJO1=0 F  S PSJO1=$O(^PS(53.1,"ACX",PSJO,PSJO1)) Q:'PSJO1  Q:PSGOEA["^"  Q:$D(PSJDLW)  S PSJORD=PSJO1_"P" D GODO S PSJORD=""
 .Q:PSJORD=""  Q:PSGOEA["^"
 .D GODO Q:PSGOEA["^"
 Q
 ;
LMNEW(PSGP,PSJPROT) ;Entry point for new order entry from listman.
 ; PSGP = DFN
 ; PSJPROT=1:UD ONLY; 2:IV ONLY; 3:BOTH
 ;
 D CKNEW N PSJUDPRF S PSJNEWOE=1
 S PSGPTS=PSJPTS,PSGOEAV=$P(PSJSYSP0,U,9)&PSJSYSU,PSGOEDMR=$O(^PS(51.2,"B","ORAL",0)),PSGOEPR=$S($D(^PS(55,PSGP,5.1)):$P(^(5.1),"^",2),1:0),PSJORQF=0,PSJOEPF=""
 I PSGOEPR>0,$D(^VA(200,+PSGOEPR,"PS")) S PSGOEPR=$S('$P(^("PS"),"^",4):PSGOEPR,($P(^("PS"),"^",4)<DT):0,1:PSGOEPR)
 S:'PSGOEPR PSGOEPR=PSJPTSP
 ; line below fixes bug in line above - infinite loop when selecting New Order in Unit Dose OE for Outpatient.
 F PSJOE=0:0 Q:PSJORQF!('(PSJPCAF&(PSJPROT'=2))&(PSJPROT'>1))  D KILL^PSJBCMA5(+$G(PSJSYSP)) D:PSJPCAF&(PSJPROT'=2) EN^PSJOE1 K PSGEFN,PSGOEF I PSJPROT>1 D ENIN^PSIVORE
 Q
 ;
DONE ;
 K PSG,PSGDL,PSGDLS,PSGDO,PSGDRG,PSGDRGN,PSGFD,PSGHSM,PSGMR,PSGMRN,PSGNEDFD,PSGNEFD,PSGNESD,PSGOES,PSGOPR,PSGORD,PSGOROE1,PSGPR,PSGPRN,PSGS0XT,PSGS0Y,PSGSCH,PSGSD,PSGSI,PSGSM,PSGST,PSGSTN,PSGUD,PSGX,PSJDLW,PSJLM,PSJNARC,PSIVAC
 K P,PSGEFN,PSGOEEF
 Q
 ;
CKNEW ;
 K CF,CHK,OD,PSGLMT,PSGODDD,PSGOEA,PSGON,PSGONC,PSGONR,PSGONV,PSGORD,PSJCOM,PSJOE1,PSJOE2 Q:$D(PSJPRF)
 I $P(PSJPDD,"^",3) W !!?2,"Patient is shown as deceased.  You may not enter orders for this patient." D CONT Q
 I 'PSJPCAF W !!,"(NOTE: You cannot enter Unit Dose orders for this patient.)" D CONT
 Q
 ;
CONT ;
 K DIR S DIR(0)="EA",DIR("A")="Press Return to continue..." D ^DIR
 Q
 ;
GODO ;Display selected order.
 S PSIVAC="C" I $S(PSJORD["V":1,PSJORD["P":$P($G(^PS(53.1,+PSJORD,0)),"^",4)="F",1:0) D @$S($D(PSJPRP):"ENINP^PSIVOPT(DFN,PSJORD)",1:"ENIN^PSIVOPT") G GODO1
 I '$D(PSJPRP),(PSJORD["P"),($P($G(^PS(53.1,+PSJORD,0)),U,4)="I") D ASKTYP Q:$D(DIRUT)  I Y="I" D ENIN^PSIVOPT G GODO1
 S PSGORD=PSJORD D EN2^PSGVW,^PSGOE1:'$D(PSJPRF)
GODO1 ;
 I $D(PSJPRP),'PSJPR K DIR S DIR(0)="E" D ^DIR K DIR S:$D(DUOUT)!$D(DTOUT) PSJDLW=1 Q:$D(PSJDLW)  W:$Y @IOF
 Q
 ;
ASKTYP ; Ask if completing as IV or UD.
 Q
 W !! D PIV^PSIVUTL(+PSJORD_"P")
 I $G(PSJPDD) S DIR(0)="E" D ^DIR S Y="I" Q
 W ! K DIR S DIR(0)="SOA^U:Unit Dose;I:IV Medication",DIR("A")="Do you wish to complete this as an IV or Unit Dose order (I/U)? ",DIR("?")="^D PENDIU^PSJO3" D ^DIR
 Q
 ;
OLDCOM(DFN,PSJORD) ;
 Q:$$COMPLEX^PSJOE(DFN,PSJORD)
 N DURFLG S DURFLG=$S($G(PSJORD)["P":$G(^PS(53.1,+PSJORD,2.5)),$G(PSJORD)["V":$G(^PS(55,DFN,"IV",+PSJORD,2.5)),1:$G(^PS(55,DFN,5,+PSJORD,2.5))) I $P(DURFLG,"^",2)]"" D
 . D CLEAR^VALM1 W !!!!!?21," * WARNING * "
 . W !!!?5,"The following order contains a Requested Duration"
 . W !?12,"and may be part of a complex dose!"
 . W !!," Review the entire profile to determine appropriate action(s).",!!!!!!! D PAUSE^VALM1
 Q
AM ;
 W !!?2,"Enter a 'Y' (or press the RETURN key) to enter new INPATIENT orders for this",!,"patient.  Enter an 'N' (or an '^') if there are no new orders for this patient."
 W:'PSJPCAF !!?2,"PLEASE NOTE: The patient selected is NOT shown as currently admitted.",!,"Therefore, you cannot enter Unit Dose orders for this patient.  (You can enter",!,"IV orders.)" Q
