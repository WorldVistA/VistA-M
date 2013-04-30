PSGOE8 ;BIR/CML3-EDIT ORDERS IN 53.1 ; 7/6/11 9:44am
 ;;5.0;INPATIENT MEDICATIONS ;**47,50,65,72,110,111,188,192,113,223,269**;16 DEC 97;Build 2
 ;
 ; Reference to ^PS(50.7 is supported by DBIA# 2180
 ; Reference to ^PS(51.1 is supported by DBIA 2177
 ; Reference to ^PS(51.2 is supported by DBIA# 2178
 ; Reference to ^PSDRUG is supported by DBIA# 2192
 ;
101 ;Orderable Item
 S MSG=0,F2=101,PSGOOPD=PSGPD,PSGOOPDN=PSGPDN S:PSGOEEF(F2) BACK="101^PSGOE8"
 S %=1 I $P(PSJSYSU,";",3)>1 W !!,$C(7),"WARNING!  If you change the drug of an order, the Dosage Ordered and Dispense",!,"Drug(s) are deleted." F  W !,"Do you wish to continue" S %=2 D YN^DICN Q:%
 I %'=1 G DONE
A101 ;
 I $$PNDREN($G(PSGORD)) D  Q
 . W !!?5,"Orderable Item may not be edited at this point." D PAUSE^VALM1
 W !,"ORDERABLE ITEM: ",$S(PSGPD:PSGPDN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGPD S X=PSGPDN I PSGPD'=PSGPDN,$D(^PS(50.7,PSGPD,0)) G DONE
 I $S(X="@":1,X]"":0,1:'PSGPD) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,101) G A101
 I X?1."?" D ENHLP^PSGOEM(53.1,101)
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A101
 ;BHW;PSJ*5.0*192;Modify ^DIC call to use MIX^DIC and only B/C cross-references
 K DIC,D S DIC="^PS(50.7,",DIC(0)="EMQZ",DIC("S")="I $$ENOISC^PSJUTL(Y,""U"")",D="B^C" D MIX^DIC1 K DIC,D I Y'>0 G A101
 F  S %=2 D DH,YN^DICN Q:%
 I %'=1 G A101
 S (PSGPDRG,PSGPD)=+Y,(PSGPDN,PSGPDRGN)=$$OINAME^PSJLMUTL(PSGPDRG)
 S PSGNEDFD=$$GTNEDFD^PSGOE7("U",PSGPDRG)
 S PSGPDNX=1,PSGDO="",(PSGPDRG,PSGPD)=+Y,(PSGPDN,PSGPDRGN)=$$OINAME^PSJLMUTL(PSGPDRG) K ^PS(53.45,PSJSYSP,2) S X=$O(^PSDRUG("ASP",PSGPD,0)) I X,'$O(^(X)) D
 .S ^PS(53.45,PSJSYSP,2,0)="^53.4502P^1^1",^(1,0)=X,^PS(53.45,PSJSYSP,2,"B",X,1)=""
 D ENDRG^PSGOEF1(PSGPD,0)
 G DONE
 ;
109 ; dosage ordered
 S MSG=0,F2=109 S:PSGOEEF(F2) BACK="109^PSGOE8"
A109 ;
 I $$PNDREN($G(PSGORD)) D  Q
 . W !!?5,"Dosage may not be edited at this point." D PAUSE^VALM1
 S PSGOEEF(F2)=PSGOEE
 D EDITDOSE^PSJDOSE S X=PSGDO G DONE
 W !,"DOSAGE ORDERED: ",$S(PSGDO]"":PSGDO_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X=""&(PSGDO]"") S X=PSGDO
 I $$CHECK(PSJSYSP)&(X="")&(PSGDO']"") W $C(7),"    (Required) " G A109
 I $$CHECK(PSJSYSP)&(X="@") W $C(7),"      (Required) " G A109
 I '$$CHECK(PSJSYSP)&(X="@") S PSGDO="" G DONE
 I X?1."?" D ENHLP^PSGOEM(53.1,109) G A109
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A109
 I $E(X,$L(X))=" " F  S X=$E(X,1,$L(X)-1) Q:$E(X,$L(X))'=" "
 I $S(X?.E1C.E:1,$L(X)>20:1,X="":0,X["^":1,X?1.P:1,1:X=+X) W $C(7),"  ",$S(X?1.P!(X=""):"(Required)",1:"??") D ENHLP^PSGOEM(53.1,109) G A109
 S PSGDO=X G DONE
 ;
3 ; med route
 S MSG=0,F2=3 S:PSGOEEF(F2) BACK="3^PSGOE8"
A3 I $$PNDREN($G(PSGORD)) D  Q
 . W !!?5,"Med Route may not be edited at this point." D PAUSE^VALM1
 W !,"MED ROUTE: ",$S(PSGMR:PSGMRN_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 I X="",PSGMR S X=PSGMRN I PSGMR'=PSGMRN,$D(^PS(51.2,PSGMR,0)) W "  "_$P(^(0),"^",3) G DONE
 I $S(X="@":1,X]"":0,1:'PSGMR) W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,3) G A3
 I X?1."?" D ENHLP^PSGOEM(53.1,3)
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A3
 K DIC S DIC="^PS(51.2,",DIC(0)="EMQZ",DIC("S")="I $P(^(0),""^"",4)" D ^DIC K DIC I Y'>0 G A3
 S PSGMR=+Y,PSGMRN=Y(0,0) G DONE
 ;
26 ; schedule
 S MSG=0,F2=26 S:PSGOEEF(F2) BACK="26^PSGOE8"
A26 I $$PNDREN($G(PSGORD)) D  Q
 . W !!?5,"Schedule may not be edited at this point." D PAUSE^VALM1
 W !,"SCHEDULE: ",$S(PSGSCH]"":PSGSCH_"// ",1:"") R X:DTIME I X="^"!'$T W:'$T $C(7) S PSGOEE=0 G DONE
 S:X="" X=PSGSCH,PSGSCH="" I "@"[X W $C(7),"  (Required)" S X="?" D ENHLP^PSGOEM(53.1,26) G A26
 S DOW=0 I $$DOW^PSIVUTL($$ENLU^PSGMI(X)) S DOW=1
 I X?1."?" D ENHLP^PSGOEM(53.1,26) G A26
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A26
 ;BHW;PSJ*5*188;Add flag and IEN return variable for PSGS0 (PSJ*5*134), Highlight Admin Times if they changed.
 N PSGOES,PSJSLUP,PSGSFLG S PSJSLUP=1,PSGSFLG=1 D EN^PSGS0 I '$D(X) W $C(7),"  ??" S X="?" D ENHLP^PSGOEM(53.1,26) G A26
 I X'=PSGSCH D
 . N XX
 . S PSGSCH=X
 . I PSGS0Y'=PSGAT S PSGAT=PSGS0Y  ;Change so that any schedule change will adjust the type and default the admin times - DRF
 . D  ;Change schedule type to agree with schedule
 .. I $G(DOW) S PSGST="C",PSGSTN=$$ENSTN^PSGMI(PSGST) Q
 .. I (PSGSCH[" PRN")!(PSGSCH="PRN") I $$PRNOK^PSGS0(PSGSCH) S PSGOST=PSGST,PSGST="P",PSGSTN=$$ENSTN^PSGMI(PSGST) Q
 .. I PSGSCH]"" S XX=+$O(^PS(51.1,"AC","PSJ",PSGSCH,0))
 .. S PSGOST=$G(PSGST),PSGST=$P($G(^PS(51.1,XX,0)),"^",5) I PSGST="D" S PSGST="C"  ;DOW schedules are converted to Continuous
 .. S PSGSTN=$$ENSTN^PSGMI(PSGST)
 . I $G(PSJSYSW0),($P(PSJSYSW0,U,5)'=2),'$G(PSGEFN(8)) W !!,"NOTE: This may cause the Admin Times and the Start Time to be out of sync."
 . W !!,"NOTE: This change in schedule also changes the ADMIN TIMES and SCHEDULE TYPE.",!
 . S MSG=1,PSGOEEF(39)=1
 . I $G(PSJNEWOE) D PAUSE^VALM1
 I PSGST="O" S PSGOEEF(7)=1
 G DONE
 ;
7 ; schedule type
 S MSG=0,F2=7 S:PSGOEEF(F2) BACK="7^PSGOE8"
A7 W !,"SCHEDULE TYPE: "_$S(PSGSTN]"":PSGSTN_"// ",1:"") R X:DTIME S X=$TR(X,"coprocf","COPROCF") I X="^"!'$T S PSGOEE=0 W $C(7) G DONE
 I X="" S X=PSGST,PSGSTN=$$ENSTN^PSGMI(X) W:PSGSTN]"" "  ",PSGSTN G DONE
 S:X="F" X="R"
 I ",?,??,C,O,OC,P,R,"'[(","_X_",") W " ??" G A7
 I $$PRNOK^PSGS0($G(PSGSCH)),X="C" W "  ??" G A7
 I X="@"!(X?1."?") W:X="@" $C(7),"  (Required)" S:X="@" X="?" D ENHLP^PSGOEM(53.1,7) G A7
 I $E(X)="^" D ENFF^PSGOE82 G:Y>0 @Y G A7
 ;*223 Don't allow O sched type on C orders
 I X="O",$$SCHTP(PSGSCH)'="O" W !,"  SCHEDULE ("_PSGSCH_") is not a ONE TIME Schedule." G A7
 ;*269 Don't allow C sched type on O orders
 I X="C",$$SCHTP(PSGSCH)="O" W !,"  SCHEDULE ("_PSGSCH_") is not a CONTINUOUS Schedule." G A7
 S PSGOST=PSGST
 S PSGST=X,PSGSTN=$$ENSTN^PSGMI(X) W:PSGSTN]"" "  ",PSGSTN
 I X="P",$G(PSGAT)]"" S PSGOAT=PSGAT S PSGAT="" D
 .W !!,"NOTE: This change in schedule type also changes the ADMIN TIMES.",!
 .S MSG=1,PSGOEEF(39)=1
 .I $G(PSJNEWOE) D PAUSE^VALM1
 ;
DONE ;
 I PSGOEE G:'PSGOEEF(F2) @BACK S PSGOEE=PSGOEEF(F2)
 K F,F0,F2 Q
 ;
DEL ; delete entry
 W !?3,"SURE YOU WANT TO DELETE" S %=0 D YN^DICN I %'=1 W $C(7),"  <NOTHING DELETED>"
 Q
 ;
DH ;
 W !!?2,"When the drug of an order is changed, the Dosage Ordered and Dispense Drug(s)",!,"for the order are no longer valid, and therefore deleted from the order.",!,"If possible, a new corresponding dispense drug will be added to the order."
 W !!?2,"Answer 'YES' to continue with this change.  Answer 'NO' to select another",!,"drug or to accept the drug as it was.  Enter an '^' the exit this edit." Q
 ;
CHECK(PSJSYSP) ; Check to see if multiple dispense drugs
 ; Input  -     PSJSYSP
 ; Returns  0 = only one.
 ;          1 = more than one
 ; Checks Inactive Date and doesn't count if < or = today.
 N PSJRSB,PSJINACT,PSJRBCNT S PSJRBCNT=0
 F PSJRSB=0:0 S PSJRSB=$O(^PS(53.45,PSJSYSP,2,PSJRSB)) Q:'PSJRSB  D
 .S PSJINACT=$P(^PS(53.45,PSJSYSP,2,PSJRSB,0),"^",3)
 .I (PSJINACT="")!((PSJINACT>0)&(PSJINACT>DT)) D
 ..S PSJRBCNT=$S('$D(PSJRBCNT):1,1:PSJRBCNT+1)
 Q $S(PSJRBCNT>1:1,1:0)
 ;
PNDREN(PNDON) ;
 I PNDON'["P" Q 0
 S RNWL="^PS(53.1,"_+PNDON_",0)" S RNWL=$G(@(RNWL)) S RNWL=$S($P(RNWL,"^",24)="R":1,1:0)
 Q RNWL
 ;
SCHTP(SCH) ; *223 Return SCHedule type
 N X I SCH="" Q ""
 S X=$O(^PS(51.1,"APPSJ",SCH,0))
 Q:'$G(X) ""
 Q $P(^PS(51.1,X,0),"^",5)
 ;
