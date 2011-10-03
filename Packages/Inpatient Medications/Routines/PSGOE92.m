PSGOE92 ;BIR/CML3-ACTIVE ORDER EDIT (CONT.) ;27 Jan 98 / 9:32 AM
 ;;5.0; INPATIENT MEDICATIONS ;**2,35,50,58,81,110,215**;16 DEC 97;Build 3
 ;
 ;Reference to ^DD(53.1 is supported by DBIA #2256.
 ;Reference to ^PS(55 is supported by DBIA #2191.
 ;Reference to ^PSDRUG is supported by DBIA #2192.
 ;
1 ; provider
 S MSG=0,PSGF2=1 S:PSGOEEF(PSGF2) BACK="1^PSGOE92"
A1 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Provider may not be edited for active complex orders." D PAUSE^VALM1
 W !,"PROVIDER: ",$S(PSGPR:PSGPRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I $S(X="":'PSGPR,1:X="@") W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(55.06,1) G A1
 I X="",PSGPR S X=PSGPRN I PSGPR'=PSGPRN,$D(^VA(200,PSGPR,"PS")) W:0 "    "_$P(^("PS"),"^",2)_"    "_$P(^("PS"),"^",3) G DONE
 I X?1."?" D ENHLP^PSGOEM(55.06,1)
 I $E(X)="^" D ENFF G:Y>0 @Y G A1
 K DIC S DIC="^VA(200,",DIC(0)="EMQZ",DIC("S")="I $D(^(""PS"")),^(""PS""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)>DT)" D ^DIC K DIC I Y'>0 G A1
 S PSGPR=+Y,PSGPRN=Y(0,0) G DONE
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
 I $G(PSGP),$G(PSGORD) I $$COMPLEX^PSJOE(PSGP,PSGORD) D
 . N X,Y,PARENT,P2ND S P2ND=$S(PSGORD["U":$G(^PS(55,PSGP,5,+PSGORD,.2)),1:$G(^PS(53.1,+PSGORD,.2))),PARENT=$P(P2ND,"^",8)
 . I PARENT D FULL^VALM1 W !!?5,"This order is part of a complex order. Please review the following ",!?5,"associated orders before changing this order." D CMPLX^PSJCOM1(PSGP,PARENT,PSGORD)
 S MSG=0,PSGF2=2,BACK="2^PSGOE92",PSGOEEND=1
 NEW PSGX,PSGXX F PSGXX=0:0 S PSGX=PSGXX,PSGXX=$O(^PS(53.45,PSJSYSP,2,PSGXX)) Q:'PSGXX
 K PSGXX
 N DA,DIE,DR S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(2,53.4502)=".02//1;.03" D ^DIE
 I '$O(^PS(53.45,PSJSYSP,2,0)) W $C(7),!!,"WARNING: This order must have at least one dispense drug before pharmacy can",!?9,"verify it!",! S MSG=1
 D DDOC^PSGOE82(PSGX) ;* Perform allergy/adv. reaction order checks
 NEW PSJDOSE
 D DOSECHK^PSJDOSE
 I +$G(PSJDSFLG) D DSPWARN^PSJDOSE S PSGOEEF(109)=1
 ; PSJ*5*215 - If Dispense Drug(s) changed, make entry in Activity Log.
 ; Compare the edited dispense drug information in ^PS(53.45 to the active
 ; order dispense drug information in ^PS(55.
 S (PSJDDTMP,PSJDD55,PSJDTMP1,PSJDD551)=""
 F PSJDDTMP=0:0 S PSJDDTMP=$O(^PS(53.45,PSJSYSP,2,PSJDDTMP)) Q:'PSJDDTMP  D
 . S PSJDDTMP(PSJDDTMP)=$G(^PS(53.45,PSJSYSP,2,PSJDDTMP,0))
 . S PSJDTMP1=PSJDTMP1_"Disp Drug: "_"("_$P($G(PSJDDTMP(PSJDDTMP)),"^",1)_") "_$P($G(^PSDRUG($P($G(PSJDDTMP(PSJDDTMP)),"^",1),0)),"^")_" Units: "_$P($G(PSJDDTMP(PSJDDTMP)),"^",2)_" "
 F PSJDD55=0:0 S PSJDD55=$O(^PS(55,DFN,5,+ON,1,PSJDD55)) Q:'PSJDD55  D
 . S PSJDD55(PSJDD55)=$G(^PS(55,DFN,5,+ON,1,PSJDD55,0))
 . S PSJDD551=PSJDD551_"Disp Drug: "_"("_$P($G(PSJDD55(PSJDD55)),"^",1)_") "_$P($G(^PSDRUG($P($G(PSJDD55(PSJDD55)),"^",1),0)),"^")_" Units: "_$P($G(PSJDD55(PSJDD55)),"^",2)_" "
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
