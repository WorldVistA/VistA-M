PSGDSP1 ;BIR/CML3-PRINT BLANK DISCHARGE ORDERS FORM ; 12 Mar 98 / 9:31 AM
 ;;5.0; INPATIENT MEDICATIONS ;**8,60**;16 DEC 97
 ;
EN ;
 D NOW^%DTC S PSGDT=%,PSGPDT=$$ENDTC^PSGMI(PSGDT),CML=IO'=IO(0)!($E(IOST,1,2)'="C-")
 U IO D PAT,PRINT
DONE ;
 W:CML&($Y) @IOF K AD,AGE,DIR,ELN,HDR,LINE,LN,PDOB,PG,PI,PN,PPN,PSEX,PSGPDT,PSSN,RCT,RF,SCV,STRS,TD,WD,WT,Z Q
 ;
PAT ;
 D PSJAC2^PSJAC(1) S PN=$P(PSGP(0),"^")_"^"_PSGP,WD=PSJPWDN
 K VASD,^UTILITY("VASD",$J) S DFN=PSGP,(PSGOD,SC)="" D SDA^VADPT I $D(^UTILITY("VASD",$J,1,"E")),$D(^("I")) S SC=$P(^("E"),"^",2),PSGD=$$ENDTC^PSGMI(+^("I"))
 K VAEL S ELIG="" D ELIG^VADPT I $D(VAEL) S ELIG=$S(VAEL(3)["^":VAEL(3),1:"^")_" "_VAEL(4)_"^"_VAEL(6)
 S PI=$P(PSJPSEX,U,2)_U_$E($P(PSJPDOB,U,2),1,10)_";"_PSJPAGE_U_$P(PSJPSSN,U,2)_U_PSJPDX_U_$S(PSJPRB]"":PSJPRB,1:"*NF*")_U_$E($P(PSJPAD,U,2),1,10)_U_$E($P(PSJPTD,U,2),1,10)_U_$E(PSGOD,1,8)_U_SC_U_+PSJPWT
 Q
 ;
PRINT ;
 S (DRG,ELN,LN,LINE,NC,NP,STRS)="",$P(ELN,"=",81)="",$P(LN,"_",53)="",$P(LINE,"-",81)="",$P(STRS,"*",57)="",N=0
 S HDR="22^ORDERS" D ENHDR^PSGDSP0
 S N=N+1 I $Y+15>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!!,$J(N,3),?4,"Medication: ",LN,$E(LN,1,11),!!?4,"Outpatient Directions: ",LN,!!?4 W:ELIG "___SC  ___NSC   " W "Qty: _____   Refills:  0  1  2  3  4  5  6  7  8  9  10  11",!!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24)
 W !?4,"Provider's Signature",?40,"DEA #",?55,"Date AND Time"
 D:$Y+15>IOSL ^PSGDSPN Q:NP="^"  S N=N+1 D OP D:$Y+15>IOSL ^PSGDSPN Q:NP="^"  S N=N+1 D OP F N=N+1:1 Q:$Y+15>IOSL  D OP
 S HDR="19^INSTRUCTIONS",NC=1 D ^PSGDSPN Q:NP="^"  S NC=0 W !,ELN,!?1,"DIETARY INSTRUCTIONS: (Check One)",!?1,"__ NO RESTRICTIONS __ RESTRICTIONS (Specify) ",$E(LN,1,33),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+10>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"PHYSICAL ACTIVITY LIMITATIONS: (Check One)",!?1,"__ NO RESTRICTIONS __ RESTRICTIONS (Specify) ",$E(LN,1,33),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+11>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"SPECIAL INSTRUCTIONS: (list print information, handouts, or other",!?1,"instructions pertinent to patient's condition)",$E(LN,1,32),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26),! I $Y+9>IOSL D ^PSGDSPN Q:NP="^"
 W !,ELN,!?1,"DIAGNOSES: ",LN,$E(LN,1,15),!!?1,LN,$E(LN,1,26),!!?1,LN,$E(LN,1,26) I $Y+21>IOSL D ^PSGDSPN Q:NP="^"
 W !!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Nurse's Signature",?55,"Date AND Time",!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Provider's Signature",?55,"Date AND Time",!!!?19,$E(ELN,1,42),!?19,">>>>> I HAVE RECEIVED AND UNDERSTAND <<<<<"
 W !?19,">>>>> MY DISCHARGE INSTRUCTIONS      <<<<<",!?19,$E(ELN,1,42),!!?19,$E(LN,1,35)," ",$E(LN,1,24),!?19,"Patient's Signature",?55,"Date And Time"
 F Q=$Y+5:1:IOSL-1 W !
 W !?2,PPN,?40,PSSN,?78-$L(PDOB),PDOB Q
 ;
OP ;
 W !,LINE,!!,$J(N,3),?4,"Medication: ",LN,$E(LN,1,11),!!?4,"Outpatient Directions: ",LN,!!?4
 W:ELIG "___SC  ___NSC   " W "Qty: _____   Refills:  0  1  2  3  4  5  6  7  8  9  10  11",!!?4,$E(LN,1,35)," ",$E(LN,1,14)," ",$E(LN,1,24),!?4,"Provider's "
 W "Signature",?40,"DEA #",?55,"Date AND Time" Q
