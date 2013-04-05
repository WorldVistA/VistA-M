PSGOE82 ;BIR/CML3-NON-VERIFIED ORDER EDIT (CONT.) ;27 Jan 98 / 9:32 AM
 ;;5.0;INPATIENT MEDICATIONS ;**2,35,50,67,58,81,127,168,181,276**;16 DEC 97;Build 3
 ;
 ; Reference to ^DD(53.1 is supported by DBIA #2256.
 ; Reference to ^VA(200 is supported by DBIA #10060.
 ; Reference to ^DIE is supported by DBIA #10018.
 ; Reference to ^DIC is supported by DBIA #10006.
 ; Reference to ^DICN is supported by DBIA #10009.
 ;
1 ; provider
 S MSG=0,PSGF2=1 S:PSGOEEF(PSGF2) BACK="1^PSGOE82"
A1 I $G(PSGORD)["P",$G(PSGP) I $$LASTREN^PSJLMPRI(PSGP,PSGORD) D  Q
 . W !?5,"This order has been renewed. Provider may not be edited at this point. " D PAUSE^VALM1
 W !,"PROVIDER: ",$S(PSGPR:PSGPRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I $S(X="":'PSGPR,1:X="@") W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,1) G A1
 I X="",PSGPR S X=PSGPRN I PSGPR'=PSGPRN,$D(^VA(200,PSGPR,"PS")) W:0 "    "_$P(^("PS"),"^",2)_"    "_$P(^("PS"),"^",3) G DONE
 I X?1."?" D ENHLP^PSGOEM(53.1,1)
 I $E(X)="^" D ENFF G:Y>0 @Y G A1
 K DIC S DIC="^VA(200,",DIC(0)="EMQZ",DIC("S")="I $D(^(""PS"")),^(""PS""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)>DT)" D ^DIC K DIC I Y'>0 G A1
 S PSGPR=+Y,PSGPRN=Y(0,0) G DONE
 ;
5 ; self med
 S MSG=0,PSGF2=5 S:PSGOEEF(PSGF2) BACK="5^PSGOE82" K PSGOEEF(6) S:PSGSM PSGOEEF(6)=1
A5 W !,"SELF MED: " W $P("NO^YES","^",PSGSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 ;I "01"[X,$L(X)<2 S:PSGSM=""&(X]"") PSGSM=X W:PSGSM]"" "  (",$P("NO^YES","^",PSGSM+1),")" G:'PSGSM DONE S PSGOEEF(6)=1 G 6
 I "01"[X,$L(X)<2 S:X]"" PSGSM=+X W:PSGSM]"" "  (",$P("NO^YES","^",PSGSM+1),")" G:'PSGSM DONE S PSGOEEF(6)=1 G 6
 I X="@" W $C(7),"  (Required)" G A5
 I X?1"^".E D ENFF G:Y>0 @Y G A5
 I X?1."?" D ENHLP^PSGOEM(53.1,5) G A5
 D YN I  S PSGSM=$E(X)="Y" K PSGOEEF(6) G:'PSGSM DONE S PSGOEEF(6)=1 G 6
 W $C(7) D ENHLP^PSGOEM(53.1,5) G A5
 ;
6 ; hospital supplied self med
 S MSG=0,PSGF2=6 S:PSGOEEF(PSGF2) BACK="6^PSGOE82"
A6 W !,"HOSPITAL SUPPLIED SELF MED: " W:PSGHSM]"" $P("NO^YES","^",PSGHSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I "01"[X,$L(X)=1 S:X]"" PSGHSM=+X W "  (",$P("NO^YES","^",PSGHSM+1),")" S MSG=0,PSGF2=5 G DONE
 I X="@" W $C(7),"  (Required)" G A6
 I X?1"^".E D ENFF G:Y>0 @Y G A6
 I X?1."?" D ENHLP^PSGOEM(53.1,6) G A6
 D YN I  S PSGHSM=$E(X)="Y" S MSG=0,PSGF2=5 G DONE
 W $C(7) D ENHLP^PSGOEM(53.1,6) G A6
 ;
2 ; dispense drug multiple
 ;*276 - Disallow unauthorized nurses from editing Dispense Drug
 I '$P($G(PSJSYSU),";",4) W !,"You are not authorized to edit Dispense Drugs." D PAUSE^VALM1 Q
 S MSG=0,PSGF2=2,BACK="2^PSGOE82" K PSGOEEND
 N PSGX,PSGXX F PSGXX=0:0 S PSGX=PSGXX,PSGXX=$O(^PS(53.45,PSJSYSP,2,PSGXX)) Q:'PSGXX
 N PSJPNDRN I $G(PSGORD) I $E(PSGORD,$L(PSGORD))="P",$P($G(^PS(53.1,+PSGORD,0)),"^",24)="R" S PSJPNDRN=1 D
 .S $P(PSJPNDRN,"^",2)="Dispense drugs for renewal orders cannot be deleted, but can be given an INACTIVE DATE.  "
 N DA,DIC,DIE,DR,DIR S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(2,53.4502)=".01;.02"_$S($G(PSJPNDRN):";.03",1:"") D ^DIE
 I '$O(^PS(53.45,PSJSYSP,2,0)) W $C(7),!!,"WARNING: This order must have at least one dispense drug before pharmacy can",!?9,"verify it!",! S MSG=1
 D DDOC(PSGX)
 NEW PSJDOSE
 D DOSECHK^PSJDOSE
 I +$G(PSJDSFLG) D DSPWARN^PSJDOSE S PSGOEEF(109)=1
 G DONE
 ;
40 ; comments
 S MSG=0,PSGF2=40,BACK="40^PSGOE82",DA=PSJSYSP,DR=1,DIE="^PS(53.45," D ^DIE W ! G DONE
 ;
66 ; provider comments
 ;S MSG=0,PSGF2=66,BACK="66^PSGOE82",DA=PSJSYSP,DR=4,DIE="^PS(53.45," D ^DIE W ! G DONE
 ;
DONE ;
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 K F,F0,PSGF2,F3,PSG,SDT Q
 ;
ENFF ; up-arrow to another field
 S Y=-1 I '$D(PSGOEEF)!(X?1"^"1.9N) W $C(7),"  ??" Q
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
DDOC(PSGX) ; Order check on additional dispense drug for allergy and adv. reactions.
 N PSGY,PSGND1,PSGND3,PSJALLGY
 S PSGY=0 F  S PSGX=$O(^PS(53.45,PSJSYSP,2,PSGX)) Q:'PSGX  S PSGY=$P($G(^PS(53.45,PSJSYSP,2,PSGX,0)),"^") Q:PSGY=""  D
 . N INTERVEN,PSJDDI,PSJIREQ,PSJRXREQ,PSJDD,PSGORQF,PSJPDRG S PSJDD=PSGY
 . S Y=1,(PSJIREQ,PSJRXREQ,INTERVEN,X)=""
 . I '$G(PSJALGY1) S PSJALLGY(PSJDD)="" D ALLERGY^PSJOC
 . ;D IVSOL^PSGSICHK
 . I ($D(PSGORQF)) D
 .. K ^PS(53.45,PSJSYSP,2,PSGX),^PS(53.45,PSJSYSP,2,"B",PSGY)
 Q
 ;
F101 ;;101^PSGOE8
F109 ;;109^PSGOE8
F3 ;;3^PSGOE8
F7 ;;7^PSGOE8
PSGF26 ;;26^PSGOE8
F39 ;;39^PSGOE81
F8 ;;8^PSGOE81
F10 ;;10^PSGOE81
PSGF25 ;;25^PSGOE81
F1 ;;1^PSGOE82
F5 ;;5^PSGOE82
PSGF2 ;;2^PSGOE82
