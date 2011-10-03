PSGOE31 ;BIR/CML3-ORDER ENTRY THROUGH OE/RR (CONT.) ;09 JAN 97 / 2:28 PM
 ;;5.0; INPATIENT MEDICATIONS ;;16 DEC 97
 ;
 ;**************************************************
 ;*** As of 1/9/97 This routine is no longer use ***.
 ;**************************************************
1 ; provider
 G:$S($D(PSJOERR):1,+PSJSYSU=3:0,1:$P(PSJSYSU,";",2)) 5
A1 W !,"PROVIDER: ",$S(PSGPR:PSGPRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 S PSGF2=1 I $S(X="@":1,X="":'PSGPR,1:0) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,1) G A1
 I X="",PSGPR S X=PSGPRN I PSGPR'=PSGPRN,$D(^VA(200,PSGPR,"PS")) W "    "_$P(^("PS"),"^",2)_"    "_$P(^("PS"),"^",3) S PSGFOK(1)="" G:$P(PSJSYSW0,"^",24) 5 G DONE
 I X?1."?" D ENHLP^PSGOEM(53.1,1)
 I $E(X)="^" D FF G:Y>0 @Y G A1
 K DIC S DIC="^VA(200,",DIC(0)="EMQZ",DIC("S")="I $D(^(""PS"")),^(""PS""),$S('$P(^(""PS""),""^"",4):1,1:$P(^(""PS""),""^"",4)>DT)" D ^DIC K DIC I Y'>0 G A1
 S PSGPR=+Y,PSGPRN=$P(Y(0,0),"^"),PSGFOK(1)=""
 ;
5 ; self med
 I '$P(PSJSYSW0,"^",24) G 106:PSGOEORF,DONE
A5 W !,"SELF MED: " W:PSGSM]"" $P("NO^YES","^",PSGSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I "01"[X,$L(X)<2 S:PSGSM=""&(X]"") PSGSM=X W:PSGSM]"" "  (",$P("NO^YES","^",PSGSM+1),")" G:'PSGSM 106:PSGOEORF,DONE S PSGFOK(5)="" G 6
 S PSGF2=5 I X="@" W:PSGSM="" $C(7),"  ??" G:PSGSM="" A5 D DEL G:%'=1 A5 S (PSGSM,PSGHSM)="" G 106:PSGOEORF,DONE
 I X?1"^".E D FF G:Y>0 @Y G A5
 I X?1."?" D ENHLP^PSGOEM(53.1,5) G A5
 D YN I  S PSGSM=$E(X)="Y",PSGFOK(5)="" G 6:PSGSM,106:PSGOEORF,DONE
 W $C(7) D ENHLP^PSGOEM(53.1,5) G A5
 ;
6 ; hospital supplied self med
 W !,"HOSPITAL SUPPLIED SELF MED: " W:PSGHSM]"" $P("NO^YES","^",PSGHSM+1),"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOROE1=1 G DONE
 I "01"[X,$L(X)<2 S:PSGHSM=""&(X]"") PSGHSM=X W:PSGHSM]"" "  (",$P("NO^YES","^",PSGHSM+1),")" G 106:PSGOEORF,DONE
 I X="@" W:PSGHSM="" $C(7),"  ??" G:PSGHSM="" 6 D DEL G:%'=1 6 S PSGHSM="" G 106:PSGOEORF,DONE
 S PSGF2=6 I X?1"^".E D FF G:Y>0 @Y G 6
 I X?1."?" D ENHLP^PSGOEM(53.1,6) G 6
 D YN I  S PSGHSM=$E(X)="Y" G 106:PSGOEORF,DONE
 W $C(7) D ENHLP^PSGOEM(53.1,6) G 6
 ;
106 ; nature of order
 W !,"This is an old nature of order call from ^PSGOE31.",!
 Q
 G:'PSGOEORF DONE I $S($D(PSJOERR):1,$P(PSJSYSU,";",2):1,1:'PSJSYSU) S PSGFOK(106)="" G DONE
A106 W !!,"NATURE OF ORDER: ",PSJNOON,"// " R X:DTIME I X="^"!'$T W:'$T $C(7) S:'$T X="^" S PSGOROE1=1 G DONE
 I X="" W:PSJNOON]"" "  ",PSJNOON S PSGFOK(106)="" G DONE
 S PSGF2=106 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,106) G A106
 I $E(X)="^" D FF G:Y>0 @Y G A106
 F Y="W^WRITTEN","P^TELEPHONED","V^VERBAL" I $S(X=$P(Y,"^"):1,1:$P($P(Y,"^",2),X)="") W $S(X=$P(Y,"^"):"  "_$P(Y,"^",2),1:$P($P(Y,"^",2),X,2)) S PSJNOO=$P(Y,"^"),PSJNOON=$P(Y,"^",2) Q
 E  W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,106) G A106
 S PSGFOK(106)=""
 ;
DONE ;
 I PSGOROE1 K Y W $C(7),"  ...order not entered..."
 K F,F0,F1,PSGF2,F3,PSGFOK,PSGOROE1,PSGSD,SDT Q
 ;
FF ; up-arrow to another field
 S Y=-1 I '$D(PSGFOK) W $C(7),"  ??" Q
 S X=$E(X,2,99) I X=+X S Y=$S($D(PSGFOK(X)):X,1:-1) W "  " W:Y>0 $P(^DD(53.1,X,0),"^") W:Y'>0 $C(7),"??" Q
 K DIC S DIC="^DD(53.1,",DIC(0)="QEM",DIC("S")="I $D(PSGFOK(+Y))" D ^DIC K DIC S Y=+Y I Y>0 S:Y=2 FB=PSGF2 I Y'=1,Y'=2,Y'=5,Y'=6 S Y=Y_"^PSGOE3"
 Q
 ;
DEL ;
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W "  <NOTHING DELETED>"
 Q
 ;
YN ; yes/no as a set of codes
 I X'?.U F Y=1:1:$L(X) I $E(X,Y)?1L S X=$E(X,1,Y-1)_$C($A(X,Y)-32)_$E(X,Y+1,$L(X))
 F Y="NO","YES" I $P(Y,X)="" W $P(Y,X,2) Q
 Q
 ;
2 ; dispense drug multiple
 I PSGDRG,'$D(^PS(53.45,PSJSYSP,2)) S ^(2,0)="^53.4502P^1^1",^(1,0)=PSGDRG_"^"_PSGUD
 K DA,DR S DIE="^PS(53.45,",DA=PSJSYSP,DR=2,DR(53.4502,1)=".01;.02" D ^DIE
 I '$O(^PS(53.45,PSJSYSP,2,0)) W $C(7),!!,"WARNING: This order must have at least one dispense drug before pharmacy can",!?9,"verify it!"
 G @FB
