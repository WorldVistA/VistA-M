PSGOE92 ;BIR/CML - ACTIVE ORDER EDIT (CONT.) ;2/18/10 4:15pm
 ;;5.0;INPATIENT MEDICATIONS ;**2,35,50,58,81,110,215,237,276,316,317,366,327,372**;16 DEC 97;Build 153
 ;
 ;Reference to ^DD(53.1 is supported by DBIA #2256.
 ;Reference to ^PS(55 is supported by DBIA #2191.
 ;Reference to ^PSDRUG is supported by DBIA #2192.
 ;Reference to $$GET^XPAR is supported by DBIA #2263
 ;Reference to $$SDEA^XUSER supported by DBIA #2343
 ;
1 ; provider
 S MSG=0,PSGF2=1 S:PSGOEEF(PSGF2) BACK="1^PSGOE92"
A1 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Provider may not be edited for active complex orders." D PAUSE^VALM1
 W !,"PROVIDER: ",$S(PSGPR:PSGPRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 ;; START NCC T4 MODS >> 327*RJS
 S PSTMPI=PSGPR,PSTMPN=PSGPRN
 I $S(X="":'PSGPR,1:X="@") W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(55.06,1) G A1
 I +$G(ANQX) G A2
 I X="",PSGPR S X=PSGPRN I PSGPR'=PSGPRN,$L($$GET1^DIQ(200,PSGPR,53.1)) G DONE
 I X?1."?" D ENHLP^PSGOEM(55.06,1)
 I $E(X)="^" D ENFF G:Y>0 @Y G A1
 ;*366 - check provider credentials
 K DIC S DIC="^VA(200,",DIC(0)="EMQZ",DIC("S")="I $$ACTPRO^PSGOE1(+Y)" D ^DIC K DIC I Y'>0 G A1
A2 D CLOZPRV^PSGOE82
 I $G(ANQX) W ! S PSGPR=PSTMPI,PSGPRN=PSTMPN  K PSTMPN,PSTMPI,ANQX G A1
 ;; END NCC T4 MODS << 327*RJS
 S PSGPR=+Y,PSGPRN=Y(0,0)
 N PSJDEA,PSDEA,PDEA,PSPPKG
 I $G(PSGPDRG)]"" D
 .S PSPPKG=$S(PSJPROT=1:"U",PSJPROT=3:"UI",1:"") Q:PSPPKG=""
 .S PSJDEA=$$OIDEA^PSSOPKI(PSGPDRG,PSPPKG),PSDEA=$P(PSJDEA,";",2) I +PSDEA>=2,+PSDEA<=5 S PDEA=$$SDEA^XUSER(,+PSGPR,PSDEA,,"I")
 I ($G(PDEA)=2)!($G(PDEA)=1)!(+$G(PDEA)=4) D  G A1
 .W !,"Provider not authorized to prescribe medications in Federal Schedule "_PSDEA_".",!,"Please contact the provider.",!
 .S PSGPR=PSTMPI,PSGPRN=PSTMPN K PSTMPN,PSTMPI
 G DONE
 ;
5 ; self med
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Self Med may not be edited for active complex orders." D PAUSE^VALM1
 S MSG=0,PSGF2=5 S:PSGOEEF(PSGF2) BACK="5^PSGOE92" K PSGOEEF(6) S:PSGSM PSGOEEF(6)=""
A5 W !,"SELF MED: " W:PSGSM]"" $P("NO^YES","^",PSGSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I "01"[X,$L(X)<2 S:X]"" PSGSM=+X W:PSGSM]"" "  (",$P("NO^YES","^",PSGSM+1),")" G:'PSGSM DONE S PSGOEEF(6)="" G 6
 I X="@" W $C(7),"  (Required)" G A5
 I X?1"^".E D ENFF G:Y>0 @Y G A5
 I X?1."?" D ENHLP^PSGOEM(55.06,5) G A5
 D YN I  S PSGSM=$E(X)="Y" K PSGOEEF(6) G:'PSGSM DONE S PSGOEEF(6)="" G 6
 W $C(7) D ENHLP^PSGOEM(55.06,5) G A5
 ;
6 ; hospital supplied self med
 S MSG=0,PSGF2=6 S:PSGOEEF(PSGF2) BACK="6^PSGOE92"
A6 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Hospital Supplied Self Med may not be edited for active complex orders." D PAUSE^VALM1
 W !,"HOSPITAL SUPPLIED SELF MED: " W:PSGHSM]"" $P("NO^YES","^",PSGHSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I "01"[X,$L(X)=1 S:X]"" PSGHSM=+X W "  (",$P("NO^YES","^",PSGHSM+1),")" S MSG=0,PSGF2=5 G DONE
 I X="@" W $C(7),"  (Required)" G A6
 I X?1"^".E D ENFF G:Y>0 @Y G A6
 I X?1."?" D ENHLP^PSGOEM(55.06,6) G A6
 D YN I  S PSGHSM=$E(X)="Y" S MSG=0,PSGF2=5 G DONE
 W $C(7) D ENHLP^PSGOEM(55.06,6) G A6
 ;
2 ; dispense drug multiple
 ;*276 - Disallow unauthorized nurses from editing Dispense Drug
 I '$P($G(PSJSYSU),";",4) W !,"You are not authorized to edit Dispense Drugs." D PAUSE^VALM1 Q
 I $G(PSGP),$G(PSGORD) I $$COMPLEX^PSJOE(PSGP,PSGORD) D
 .N X,Y,PARENT S PARENT=$S(PSGORD["U":$$GET1^DIQ(55.06,+PSGORD_","_PSGP,125,"I"),1:$$GET1^DIQ(53.1,+PSGORD,125,"I"))
 .I PARENT D FULL^VALM1 W !!?5,"This order is part of a complex order. Please review the following ",!?5,"associated orders before changing this order." D CMPLX^PSJCOM1(PSGP,PARENT,PSGORD)
 S MSG=0,PSGF2=2,BACK="2^PSGOE92",PSGOEEND=1
 N PSGX,ARRAY D LIST^DIC(53.4502,","_PSJSYSP_",",,"I",,,,,,,"ARRAY") S PSGX=+ARRAY("DILIST",0)
 ; PSJ*5*317 - If PSJ PADE OE BALANCES parameter is YES, PADE balances should display as identifier.
 N PSJPADLK S PSJPADLK=0  ; Flag indicating PADE drug lookup was done, don't do drug lookup twice - PSJ*5*317
 I $$GET^XPAR("SYS","PSJ PADE OE BALANCES") D
 .N DA,DIC,DIE,DR,DIR,PSJLOC,PSJDRG,PSJDDC,PSJORD,DFN,PSJORCL,PSJCLNK,PSJCLND S PSJCLND=""
 .; If clinic order, quit if clinic location is not linked to PADE
 .I $G(PSGORD)["P" S PSJCLND=$$GET1^DIQ(53.1,+$G(PSGORD),113,"I")_"^"_$$GET1^DIQ(53.1,+$G(PSGORD),126,"I") I 1
 .E  I $G(PSGORD)["U" S PSJCLND=$$GET1^DIQ(55.06,+$G(PSGORD)_","_+$G(PSGP),130,"I")_"^"_$$GET1^DIQ(55.06,+$G(PSGORD)_","_+$G(PSGP),131,"I") I 1
 .E  I $G(PSGORD)["V" S PSJCLND=$$GET1^DIQ(55.01,+$G(PSGORD)_","_+$G(PSGP),136,"I")_"^"_$$GET1^DIQ(55.01,+$G(PSGORD)_","_+$G(PSGP),139,"I")
 .S PSJORCL=$S(PSJCLND&$P(PSJCLND,"^",2):+PSJCLND_"C",1:"")
 .I PSJORCL S PSJCLNK=$$PADECL^PSJPAD50(+$G(PSJORCL)) Q:'PSJCLNK
 .I '$G(PSJCLNK) Q:'$$PADEWD^PSJPAD50(+$G(VAIN(4)))
 .S DFN=$G(PSGP),PSJORD=$G(PSGORD)
 .N ARRAY D LIST^DIC(53.4502,","_PSJSYSP_",",,"I",,,,,,,"ARRAY")
 .F I=1:1 Q:'$D(ARRAY("DILIST",2,I))  S PSJDDC=ARRAY("DILIST",2,I),PSJDRG(PSJDDC)=$$GET1^DIQ(53.4502,PSJDDC_","_PSJSYSP,.01,"I")
 .S PSJLOC=$S($G(PSJORD)["U":+$$GET1^DIQ(55.06,+PSJORD_","_DFN,130,"I")_"C",$G(PSJORD)["P":+$$GET1^DIQ(53.1,+$G(PSGORD),113,"I")_"C",1:"")
 .S:'PSJLOC PSJLOC=+$G(VAIN(4)) I '$G(PSJLOC) D
 ..N VAIN D INP^VADPT S PSJLOC=$G(VAIN(4))
 .S PSJPADLK=1
 .D READDD^PSJPAD50(.PSJDRG,$G(PSGPDRG),PSJLOC,PSJORD,$G(PSGORD))
 ; PSJ*5*317 - If PSJ PADE OE BALANCES parameter is NO, PADE balances should NOT display as identifer.
 I '$G(PSJPADLK) N DA,DIE,DR S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(2,53.4502)=".02//1;.03" D ^DIE
 I '$G(ARRAY("DILIST",0)) W $C(7),!!,"WARNING: This order must have at least one dispense drug before pharmacy can",!?9,"verify it!",! S MSG=1
 D DDOC^PSGOE82(PSGX) ;* Perform allergy/adv. reaction order checks
 N PSJDOSE
 D DOSECHK^PSJDOSE
 I +$G(PSJDSFLG) D DSPWARN^PSJDOSE S:$G(PSGOEEF(109))="" PSGOEEF(109)=1 ; PSJ*5*237 - Check PSGOEEF(109) to prevent infinite loop
 ; PSJ*5*215 - If Dispense Drug(s) changed, make entry in Activity Log.
 ; Compare the edited dispense drug information in ^PS(53.45 to the active
 ; order dispense drug information in ^PS(55.
 S (PSJDDTMP,PSJDD55,PSJDTMP1,PSJDD551)=""
 N ARRAY D LIST^DIC(53.4502,","_PSJSYSP_",",.02,"I",,,,,,,"ARRAY")
 F I=1:1 Q:'$D(ARRAY("DILIST",2,I))  S PSJDDTMP=ARRAY("DILIST",2,I) D
 .S PSJDDTMP(PSJDDTMP)=ARRAY("DILIST",1,I)_"^"_ARRAY("DILIST","ID",I,.02)
 .S PSJDTMP1="Disp Drug: "_"("_$P($G(PSJDDTMP(PSJDDTMP)),"^",1)_") "_$$GET1^DIQ(50,$P($G(PSJDDTMP(PSJDDTMP)),"^",1),.01)_" Units: "_$P($G(PSJDDTMP(PSJDDTMP)),"^",2)_" "
 N ARR1 D LIST^DIC(55.07,","_+ON_","_DFN_",",.02,"I",,,,,,,"ARR1")
 F I=1:1 Q:'$D(ARR1("DILIST",2,I))  S PSJDD55=ARR1("DILIST",2,I) D
 .S PSJDD55(PSJDD55)=ARR1("DILIST",1,I)_"^"_ARR1("DILIST","ID",I,.02)
 .S PSJDD551="Disp Drug: "_"("_$P($G(PSJDD55(PSJDD55)),"^",1)_") "_$$GET1^DIQ(50,$P($G(PSJDD55(PSJDD55)),"^",1),.01)_" Units: "_$P($G(PSJDD55(PSJDD55)),"^",2)_" "
 ; If the two temporary strings PSJDTMP1 and PSJDD551 do not match each other exactly
 ; then an edit has been made to the Dispense Drug Field.  Make a new entry in
 ; the Activity Log for this order.
 I PSJDTMP1'=PSJDD551 D NEWUDAL^PSGAL5(DFN,+ON,6000,"Dispense Drug",PSJDD551)
 K PSGOEEND,PSJDDTMP,PSJDTMP1,PSJDD55,PSJDD551 G DONE
 ;
15 ; comments
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Comments may not be edited for active complex orders." D PAUSE^VALM1
 S MSG=0,PSGF2=15,BACK="15^PSGOE92",DA=PSJSYSP,DR=1,DIE="^PS(53.45," D ^DIE W ! G DONE
 ;
72 ; provider comments
 ;
DONE ;
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 K F,F0,PSGF2,F3,PSG,SDT Q
 ;
ENFF ; up-arrow to another field
 S Y=-1 I '$D(PSGOEEF) W $C(7),"  ??" Q
 S X=$E(X,2,99) I X=+X S Y=$S($D(PSGOEEF(X)):X,1:-1) W "  " W:Y>0 $$CODES2^PSIVUTL(53.1,X) W:Y'>0 $C(7),"??" Q
 K DIC S DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I $D(PSGOEEF(+Y))" D ^DIC K DIC S Y=+Y S:Y>0 Y=$P($T(@("F"_Y)),";",3) Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
 ;
YN ; yes/no as a set of codes
 I X'?.U F Y=1:1:$L(X) I $E(X,Y)?1L S X=$E(X,1,Y-1)_$C($A(X,Y)-32)_$E(X,Y+1,$L(X))
 F Y="NO","YES" I $P(Y,X)="" W $P(Y,X,2) Q
 Q
 ;
F101 ;;101^PSGOE9
F109 ;;109^PSGOE9
F3 ;;3^PSGOE9
F7 ;;7^PSGOE9
PSGF26 ;;26^PSGOE9
F41 ;;41^PSGOE91
F8 ;;8^PSGOE91
F10 ;;10^PSGOE91
F34 ;;34^PSGOE91
F1 ;;1^PSGOE92
F5 ;;5^PSGOE92
PSGF2 ;;2^PSGOE92
