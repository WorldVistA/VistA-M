PSGOE9 ;BIR/CML3-EDIT ORDERS IN 55 ; 7/6/11 9:45am
 ;;5.0;INPATIENT MEDICATIONS ;**11,47,50,72,110,111,188,192,207,113,223,269**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PS(51.1 is supported by DBIA 2177
 ; Reference to ^PS(51.2 is supported by DBIA# 2178
 ; Reference to ^PS(55 is supported by DBIA #2191
 ; Reference to ^PSDRUG is supported by DBIA# 2192
 ;
101 ; Orderable Item (AKA primary drug)
 S MSG=0,PSGF2=101,PSGOOPD=PSGPD,PSGOOPDN=PSGPDN S:PSGOEEF(PSGF2) BACK="101^PSGOE9"
 S %=1 W !!,$C(7),"WARNING!  If you change the drug of an order, the Dosage Ordered and Dispense",!,"Drug(s) are deleted." F  W !,"Do you wish to continue" S %=2 D YN^DICN Q:%  D DH^PSGOE8
 I %'=1 G DONE
A101 ;
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Orderable Item may not be edited for active complex orders." D PAUSE^VALM1
 W !,"ORDERABLE ITEM: ",$S(PSGPD:PSGPDN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGPD S X=PSGPDN I PSGPD'=PSGPDN,$D(^PS(50.7,PSGPD,0)) G DONE
 I $S(X="@":1,X]"":0,1:'PSGPD) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(55.06,101) G A101
 I X?1."?" D ENHLP^PSGOEM(55.06,101)
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A101
 ;BHW;PSJ*5.0*192;Modify ^DIC call to use MIX^DIC and only B/C cross-references
 K DIC,D S DIC="^PS(50.7,",DIC(0)="EMQZ",DIC("S")="I $$ENOISC^PSJUTL(Y,""U"")",D="B^C" D MIX^DIC1 K DIC,D I Y'>0 G A101
 I +Y=PSGPD G DONE  ;PSJ*5*269 - No change to Orderable Item
 F  S %=2 D DH^PSGOE8,YN^DICN Q:%
 I %'=1 G A101
 S (PSGPDRG,PSGPD)=+Y,(PSGPDN,PSGPDRGN)=$$OINAME^PSJLMUTL(PSGPDRG)
 S PSGNEDFD=$$GTNEDFD^PSGOE7("U",PSGPDRG)
 S PSGPDNX=1,PSGPD=+Y,PSGPDN=$$OINAME^PSJLMUTL(PSGPD),PSGDO="" K ^PS(53.45,PSJSYSP,2) S X=$O(^PSDRUG("ASP",PSGPD,0)) I X,'$O(^(X)) S ^PS(53.45,PSJSYSP,2,0)="^53.4502P^1^1",^(1,0)=X,^PS(53.45,PSJSYSP,2,"B",X,1)="" G DONE
 D ENDRG^PSGOEF1(PSGPD,0)
 G DONE
 ;
109 ; dosage ordered
 S MSG=0,PSGF2=109 S:PSGOEEF(PSGF2) BACK="109^PSGOE9"
A109 ;
 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Dosage may not be edited for active complex orders." D PAUSE^VALM1
 D EDITDOSE^PSJDOSE S X=PSGDO G DONE
 W !,"DOSAGE ORDERED: ",$S(PSGDO]"":PSGDO_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X=""&(PSGDO]"") S X=PSGDO
 I $$CHECK^PSGOE8(PSJSYSP)&(X="")&(PSGDO']"") W $C(7),"    (Required) " G A109
 I $$CHECK^PSGOE8(PSJSYSP)&(X="@") W $C(7),"  (Required)" G A109
 I '$$CHECK^PSGOE8(PSJSYSP)&(X="@") S PSGDO="" G DONE
 I X?1."?" D ENHLP^PSGOEM(55.06,109) G A109
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A109
 I $E(X,$L(X))=" " F  S X=$E(X,1,$L(X)-1) Q:$E(X,$L(X))'=" "
 I $S(X?.E1C.E:1,$L(X)>20:1,X="":0,X["^":1,X?1.P:1,1:X=+X) W $C(7),"  ",$S(X?1.P!(X=""):"(Required)",1:"??") D ENHLP^PSGOEM(55.06,109) G A109
 S PSGDO=X G DONE
 ;
3 ; med route
 S MSG=0,PSGF2=3 S:PSGOEEF(PSGF2) BACK="3^PSGOE9"
A3 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Med Route may not be edited for active complex orders." D PAUSE^VALM1
 W !,"MED ROUTE: ",$S(PSGMR:PSGMRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGMR S X=PSGMRN I PSGMR'=PSGMRN,$D(^PS(51.2,PSGMR,0)) W "  "_$P(^(0),"^",3) G DONE
 I $S(X="@":1,X]"":0,1:'PSGMR) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(55.06,3) G A3
 I X?1."?" D ENHLP^PSGOEM(55.06,3)
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A3
 K DIC S DIC="^PS(51.2,",DIC(0)="EMQZ",DIC("S")="I $P(^(0),""^"",4)" D ^DIC K DIC I Y'>0 G A3
 S PSGMR=+Y,PSGMRN=Y(0,0) G DONE
 ;
7 ; schedule type
 S MSG=0,PSGF2=7 S:PSGOEEF(PSGF2) BACK="7^PSGOE9"
A7 I $G(PSGP),$G(PSGORD) I $$COMPLEX^PSJOE(PSGP,PSGORD) D
 . N X,Y,PARENT,P2ND S P2ND=$S(PSGORD["U":$G(^PS(55,PSGP,5,+PSGORD,.2)),1:$G(^PS(53.1,+PSGORD,.2))),PARENT=$P(P2ND,"^",8)
 . I PARENT D FULL^VALM1 W !!?5,"This order is part of a complex order. Please review the following ",!?5,"associated orders before changing this order." D CMPLX^PSJCOM1(PSGP,PARENT,PSGORD)
 W !,"SCHEDULE TYPE: "_$S(PSGSTN]"":PSGSTN_"// ",1:"") R X:DTIME S X=$TR(X,"coprocf","COPROCF") I X="^"!'$T S PSGOEE=0 W $C(7) G DONE
 I X="" S X=PSGST,PSGSTN=$$ENSTN^PSGMI(X) W:PSGSTN]"" "  ",PSGSTN G DONE
 S:X="F" X="R"
 I ",?,??,C,O,OC,P,R,"'[(","_X_",") W " ??" G A7
 I $$PRNOK^PSGS0($G(PSGSCH)),X="C" W "  ??" G A7
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(55.06,7) G A7
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A7
 ;*223 Don't allow O sched type on C orders
 I X="O",$$SCHTP^PSGOE8(PSGSCH)'="O" W !,"  SCHEDULE ("_PSGSCH_") is not a ONE TIME Schedule." G A7
 ;*269 Don't allow C sched type on O orders
 I X="C",$$SCHTP^PSGOE8(PSGSCH)="O" W !,"  SCHEDULE ("_PSGSCH_") is not a CONTINUOUS Schedule." G A7
 S PSGOST=PSGST
 S PSGST=X,PSGSTN=$$ENSTN^PSGMI(X) W:PSGSTN]"" "  ",PSGSTN
 I X="P",$G(PSGAT)]"" S PSGOAT=PSGAT S PSGAT="" D
 .W !!,"NOTE: This change in schedule type also changes the ADMIN TIMES.",!
 .S MSG=1,PSGOEEF(39)=1
 .I $G(PSJNEWOE) D PAUSE^VALM1
 G DONE
 ;
26 ; schedule
 S MSG=0,PSGF2=26 S:PSGOEEF(PSGF2) BACK="26^PSGOE9"
A26 I $G(PSJORD),$G(PSGP) I $$COMPLEX^PSJOE(PSGP,PSJORD) S PSGOEE=0 D  G DONE
 . W !!?5,"Schedule may not be edited for active complex orders." D PAUSE^VALM1
 W !,"SCHEDULE: ",$S(PSGSCH]"":PSGSCH_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 S:X="" X=PSGSCH,PSGSCH="" I "@"[X W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(55.06,26) G A26
 S DOW=0 I $$DOW^PSIVUTL($$ENLU^PSGMI(X)) S DOW=1
 I X?1."?" D ENHLP^PSGOEM(55.06,26) G A26
 I $E(X)="^" D ENFF^PSGOE92 G:Y>0 @Y G A26
 ;BHW;PSJ*5*188;Add flag and IEN return variable for PSGS0 (PSJ*5*134), Highlight Admin Times if they changed.
 N PSJSLUP,PSGSFLG S PSJSLUP=1,PSGSFLG=1 D EN^PSGS0 I '$D(X) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(55.06,26) G A26
 I X'=PSGSCH D
 . S PSGSCH=X
 . I PSGS0Y'=PSGAT S PSGAT=PSGS0Y  ;Change so that any schedule change will adjust the type and default the admin times - DRF
 . D  ;Change schedule type to agree with schedule
 .. I $G(DOW) S PSGST="C",PSGSTN=$$ENSTN^PSGMI(PSGST) Q
 .. I (PSGSCH[" PRN")!(PSGSCH="PRN") I $$PRNOK^PSGS0(PSGSCH) S PSGOST=PSGST,PSGST="P",PSGSTN=$$ENSTN^PSGMI(PSGST) Q
 .. I PSGSCH]"" S X=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0))
 .. S PSGST=$P($G(^PS(51.1,X,0)),"^",5) I PSGST="D" S PSGST="C"  ;DOW schedules are converted to Continuous
 .. S PSGSTN=$$ENSTN^PSGMI(PSGST)
 . W !!,"NOTE: This change in schedule also changes the ADMIN TIMES and SCHEDULE TYPE.",!
 . S MSG=1,PSGOEEF(39)=1
 . I $G(PSJNEWOE) D PAUSE^VALM1
 I PSGST="O" S PSGOEEF(7)=1
 ;
DONE ;
 I PSGOEE G:'PSGOEEF(PSGF2) @BACK S PSGOEE=PSGOEEF(PSGF2)
 K F,F0,PSGF2 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
