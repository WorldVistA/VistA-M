PSGDSP ;BIR/CML3-PRINT DISCHARGE ORDERS ; 12 Feb 99 / 9:54 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,20,60,50**;16 DEC 97
LOOP ;
 D NOW^%DTC S PSGDT=%,PSGPDT=$$ENDTC2^PSGMI(PSGDT),CML=IO'=IO(0)!($E(IOST,1,2)'="C-")
 U IO I '$D(^TMP("PSG",$J)) W:$Y @IOF W !?22,"AUTHORIZED ABSENCE/DISCHARGE ORDERS",?62,PSGPDT D  G DONE
 .W !?10,"NO ACTIVE ORDERS FOUND FOR ",$S(PSJSEL("SELECT")="G":"WARD GROUP: "_PSGAPWGN,PSJSEL("SELECT")="W":"WARD: "_PSGAPWDN,1:"PATIENT(S) SELECTED"),"."
 S (DRG,ELN,LN,LINE,NC,NP,PN,STRS,WD)="",$P(ELN,"=",81)="",$P(LN,"_",53)="",$P(LINE,"-",81)="",$P(STRS,"*",57)=""
 F  S WD=$O(^TMP("PSG",$J,WD)) Q:WD=""  F  S PN=$O(^TMP("PSG",$J,WD,PN)) Q:PN=""  S PI=^(PN),ELIG=^(PN,0),DFN=$P(PN,"^",2),HDR="22^ORDERS" D ENHDR^PSGDSP0,END G:NP="^" DONE
 ;
DONE ;
 W:CML&($Y) @IOF K AD,AGE,DIR,ELN,HDR,JJ,LINE,LN,PDOB,PG,PI,PPN,PSEX,PSGPDT,PSSN,RCT,RF,SCV,STRS,TD,WD,WT,Z,PSGVAMC Q
 ;
 ;
END ;
 S DRG=0 F  S DRG=$O(^TMP("PSG",$J,WD,PN,DRG)) Q:DRG=""  S ND=^(DRG),SI=$G(^(DRG,1)) D:$Y+18>IOSL ^PSGDSPN Q:NP="^"  D ORDP
 Q:NP="^"  S N=N+1 I $Y+15>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?4,"OTHER MEDICATIONS:",!!,$J(N,3),?4,"Medication: ",LN,$E(LN,1,11),!!?4,"Outpatient Directions: ",LN,!!?4
 W:ELIG "___SC  ___NSC   " W "Qty: _____   Refills:  0  1  2  3  4  5  6  7  8  9  10  11",!!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24)
 W !?4,"Provider's Signature",?40,"DEA #",?55,"Date AND Time"
 D:$Y+15>IOSL ^PSGDSPN Q:NP="^"  S N=N+1 D OP D:$Y+15>IOSL ^PSGDSPN Q:NP="^"  S N=N+1 D OP F N=N+1:1 Q:$Y+15>IOSL  D OP
 S HDR="19^INSTRUCTIONS",NC=1 D ^PSGDSPN Q:NP="^"  S NC=0 W !,ELN,!?1,"DIETARY INSTRUCTIONS: (Check One)",!?1,"__ NO RESTRICTIONS __ RESTRICTIONS (Specify) ",$E(LN,1,33),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+10>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"PHYSICAL ACTIVITY LIMITATIONS: (Check One)",!?1,"__ NO RESTRICTIONS __ RESTRICTIONS (Specify) ",$E(LN,1,33),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+11>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"SPECIAL INSTRUCTIONS: (list print information, handouts, or other",!?1,"instructions pertinent to patient's condition)",$E(LN,1,32),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+9>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"DIAGNOSES: ",LN,$E(LN,1,15),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26) I $Y+21>IOSL D ^PSGDSPN Q:NP="^"
 W !!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Nurse's Signature",?55,"Date AND Time",!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Provider's Signature",?55,"Date AND Time",!!!?19,$E(ELN,1,42),!?19,">>>>> I HAVE RECEIVED AND UNDERSTAND <<<<<"
 W !?19,">>>>> MY DISCHARGE INSTRUCTIONS      <<<<<",!?19,$E(ELN,1,42),!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Patient's Signature",?55,"Date And Time"
 F Q=$Y+5:1:IOSL-1 W !
 W !?2,PPN,?40,PSSN,?78-$L(PDOB),PDOB Q
 ;
ORDP ;
 S N=N+1,DO=$P(ND,"^"),SPH=$P(ND,"^",7),SM=$P(ND,"^",8),NF=$P(ND,"^",9),UC=$P(ND,"^",11),DDRG=$P(ND,"^",12) S:UC<1 UC="0"_UC W !,LINE,!,$J(N,3),?4 I NF W "(N/F) "
 W $P(DRG,"^") W:'DDRG " (UD)" W ?56,$P(ND,"^",10),?72,UC W:(DDRG="MULTIPLE")!(DDRG="NO") !?4,"*ORDER CONTAINS "_DDRG_" DISPENSE DRUGS"
 W !?4,"Inpt Dose: " D
 .N MARX,I
 .I DO]"" D TXT^PSGMUTL(DO_$P(ND,"^",2)_" "_$P(ND,"^",4),64) D  Q
 ..F I=1:1:+$G(MARX) W ?16,MARX(I),!
 .W $P(ND,"^",2)_" "_$P(ND,"^",4)
 I SI]"" S Z=$L(SI," ") W !?4,"Special Instructions: " F X=1:1:Z S Y=$P(SI," ",X) W:$X+$L(Y)>78 !?30 W Y," "
 I SPH[2 W !!?4,STRS,!?4,"*  THIS IS A SCHEDULE II DRUG.  A PRESCRIPTION BLANK   *",!?4,"*  (VA FORM 10-2277d) MUST BE USED TO ORDER THIS DRUG. *",!?4,STRS Q
 I SPH["W" W !!?4,STRS,!?4,"*  THIS ITEM IS NONRENEWABLE.                          *",!?4,"*  CONTACT PHARMACY IF YOU HAVE QUESTIONS.             *",!?4,STRS Q
 W !!?4,"___ TAKE NO ACTION (PATIENT WILL NOT RECEIVE MEDICATION)",!!?4,"Outpatient Directions: ",LN,!!?4 W:SPH'["S"&ELIG "___SC  ___NSC   "
 W "Qty: _____   Refills:  0  1  2  3  4  5"_$S((+SPH>2)&(+SPH<6):"",1:"  6  7  8  9  10  11")
 W !!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24),!?4,"Provider's Signature",?40,"DEA #",?55,"Date AND Time" Q
 ;
OP ;
 W !,LINE,!!,$J(N,3),?4,"Medication: ",LN,$E(LN,1,11),!!?4,"Outpatient Directions: ",LN,!!?4 W:ELIG "___SC  ___NSC   "
 W "Qty: _____   Refills:  0  1  2  3  4  5  6  7  8  9  10  11",!!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24),!?4,"Provider's "
 W "Signature",?40,"DEA #",?55,"Date AND Time" Q
