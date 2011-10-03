FHPRO1 ; HISC/REL/RVD - Production Processing ;3/6/95  15:45
 ;;5.5;DIETETICS;**3,5**;Jan 28, 2005;Build 53
 ;Patch #5 adding missing variable FHSITE & process each date seperately for Forecasting.
 ;
 K ^TMP($J),^TMP("FH")
 S FHSITE=""
 S FHALL=0   ;if fhall=1, process all data for certain Production Fac.
 S FHPFLG=0  ;if fhpflg=1, there is only one Production Facility.
 S FHP=$O(^FH(119.71,0)) I FHP'<1,$O(^FH(119.71,FHP))<1 S FHPFLG=1 G CEFO
F0 R !!,"Select PRODUCTION FACILITY: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.71,",DIC(0)="EMQ" D ^DIC G:Y<1 F0 S FHP=+Y
 ;
CEFO ;Census and Forcast
R0 R !!,"Use CENSUS or FORECAST? (C OR F): ",FHP6:DTIME G:'$T!("^"[FHP6) KIL S X=FHP6 D TR^FH S FHP6=X I $P("CENSUS",FHP6,1)'="",$P("FORECAST",FHP6,1)'="" W *7," Enter C or F" G R0
 K M2 S FHP6=$E(FHP6,1),FHP6=$S(FHP6="C":"Census",1:"Forecast") G:FHP6["F" F1
 ;
CL ;Ask for Communication Office if census is selected.
 K FHSITE,FHSITENM,X,DIC
 I $G(FHP) S DIC("S")="I $D(^FH(119.73,+Y,0)),$P(^FH(119.73,+Y,0),U,4)=FHP"
 R !!,"Select COMMUNICATION OFFICE (or ALL): ALL// ",X:DTIME
 S:X="" X="ALL" G:'$T!("^"[X) KIL D TR^FH I X="ALL" S FHSITE=0
 I X'="ALL" S DIC="^FH(119.73,",DIC(0)="EMQ" D ^DIC G:Y<1 CL S FHSITE=+Y,FHSITENM=$P(Y,U,2)
 G:'$D(FHSITE) KIL
 I FHSITE'<1,$O(^FH(119.73,FHP))<1 G F1
 ;
F1 S %DT("A")="Select Start Date: ",%DT="AEX" W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F1:Y<1 S (X1,D1)=+Y
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G F1
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined for that Date!" G F1
 ;
F2 S %DT("A")="Select End Date: ",%DT="AEX" W ! D ^%DT G KIL:"^"[X!$D(DTOUT),F2:Y<1
 I +Y<D1 W !!,"***End Date must be on or after Start Date!!!" G F2
 S (X1,FHDT2)=+Y S FHERRDT=0
 D E1^FHPRC1 I FHCY<1 W *7,!!,"No MENU CYCLE Defined for that Date!" G F2
 I '$D(^FH(116,FHCY,"DA",FHDA,0)) W *7,!!,"MENU CYCLE DAY Not Defined for that Date!" G F2
 S FHD1SV=D1
 F FHDTI=1:1 S X1=FHD1SV,X2=FHDTI-1 D C^%DTC Q:FHDTI'>0!(X>FHDT2)  D
 .S (X1,D1,DTP)=X D E1^FHPRC1 I FHCY<1 D DTP^FH W *7,!!,"No MENU CYCLE Defined for Date: ",DTP S FHERRDT=1
 .I '$D(^FH(116,FHCY,"DA",FHDA,0)) D DTP^FH W *7,!!,"No MENU CYCLE Defined for Date: ",DTP S FHERRDT=1
 S D1=FHD1SV
 I $G(FHERRDT) G F2
 ;
R1 ;R !!,"Select MEAL (B,N,E, or combination of BNE, or ALL): ALL// ",MEAL:DTIME G:'$T!(MEAL["^") KIL S:MEAL="" MEAL="ALL" S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 R !!,"Select Starting and Ending MEAL (B, N, E, B-B, B-N, B-E, N-B, N-N, N-E, E-B, E-N, E-E, or ALL): ALL// ",MEAL:DTIME
 G:'$T!(MEAL["^") KIL S:MEAL="" MEAL="ALL" S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 D CHKML
 I '$G(FHMLFLG)!(MEAL["?") W *7,!!,"You may select B for Breakfast, N for Noon, E for Evening, B-N for Breakfast to Noon, N-E for Noon to Evening, or any combination separated by a hyphen, or ALL for all meals" G R1
 ;I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Select B for Breakfast, N for Noon, or E for Evening, or any combination of BNE, or ALL for all meals" G R1
 S FHDA=^FH(116,FHCY,"DA",FHDA,0)
 I $D(^FH(116.3,D1,0)) S X=^(0) F LL=2:1:4 I $P(X,"^",LL) S $P(FHDA,"^",LL)=$P(X,"^",LL)
 ;I MEAL'="A" S FHX1=$P(FHDA,"^",$F("BNE",MEAL)) I 'FHX1 W *7,!!,"*** NO MENU DEFINED FOR THIS MEAL ***" G KIL
R2 R !!,"Do you want PRODUCTION Summary? (Y/N) N// ",FHP1:DTIME G:'$T!(FHP1["^") KIL S:FHP1="" FHP1="N" S X=FHP1 D TR^FH S FHP1=X I $P("YES",FHP1,1)'="",$P("NO",FHP1,1)'="" W *7,"  Enter YES or NO" G R2
 S FHP1=$E(FHP1,1)
R3 R !!,"Do you want MEAL SERVICE Summary? (Y/N) N// ",FHP2:DTIME G:'$T!(FHP2["^") KIL S:FHP2="" FHP2="N" S X=FHP2 D TR^FH S FHP2=X I $P("YES",FHP2,1)'="",$P("NO",FHP2,1)'="" W *7,"  Enter YES or NO" G R3
 S FHP2=$E(FHP2,1)
R4 R !!,"Do you want RECIPE PREPARATION Sheet? (Y/N) N// ",FHP3:DTIME G:'$T!(FHP3["^") KIL S:FHP3="" FHP3="N" S X=FHP3 D TR^FH S FHP3=X I $P("YES",FHP3,1)'="",$P("NO",FHP3,1)'="" W *7,"  Enter YES or NO" G R4
 S FHP3=$E(FHP3,1)
R5 R !!,"Do you want STOREROOM REQUISITION Sheet? (Y/N) N// ",FHP4:DTIME G:'$T!(FHP4["^") KIL S:FHP4="" FHP4="N" S X=FHP4 D TR^FH S FHP4=X I $P("YES",FHP4,1)'="",$P("NO",FHP4,1)'="" W *7,"  Enter YES or NO" G R5
 S FHP4=$E(FHP4,1)
R7 R !!,"Do you want PRINTED RECIPES? (Y/N) N// ",FHP5:DTIME G:'$T!(FHP5["^") KIL S:FHP5="" FHP5="N" S X=FHP5 D TR^FH S FHP5=X I $P("YES",FHP5,1)'="",$P("NO",FHP5,1)'="" W *7,"  Enter YES or NO" G R7
 S FHP5=$E(FHP5,1)
R8 R !!,"Do you want Advance Food Prep? (Y/N) N// ",FHP8:DTIME G:'$T!(FHP8["^") KIL S:FHP8="" FHP8="N" S X=FHP8 D TR^FH S FHP8=X I $P("YES",FHP8,1)'="",$P("NO",FHP8,1)'="" W *7,"  Enter YES or NO" G R8
 S FHP8=$E(FHP8,1)
R10 R !!,"Do you want Storeroom Requisition for AFP? (Y/N) N// ",FHP10:DTIME G:'$T!(FHP10["^") KIL S:FHP10="" FHP10="N" S X=FHP10 D TR^FH S FHP10=X I $P("YES",FHP10,1)'="",$P("NO",FHP10,1)'="" W *7,"  Enter YES or NO" G R10
 S FHP10=$E(FHP10,1)
R9 R !!,"Do you want Printed Recipes for AFP? (Y/N) N// ",FHP9:DTIME G:'$T!(FHP9["^") KIL S:FHP9="" FHP9="N" S X=FHP9 D TR^FH S FHP9=X I $P("YES",FHP9,1)'="",$P("NO",FHP9,1)'="" W *7,"  Enter YES or NO" G R9
 S FHP9=$E(FHP9,1)
 D:FHP6["F" FOR
 G:$G(FHQUIT) KIL
L0 W !!,"The report requires a 132 column printer.",!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="^FHPRO2",FHLST="D1^FHDT2^MEAL^FHDA^FHP^FHP1^FHP2^FHP3^FHP4^FHP5^FHP6^FHP8^FHP9^FHP10^M2(^FHSITE" D EN2^FH G KIL
 U IO D ^FHPRO2 D ^%ZISC K %ZIS,IOP G KIL
 ;Next ask for forcasted amount.
FOR S FHD1SAV=D1,FHQUIT=0 ;save the starting date.
 S FHSITE=0
 F FHDTI=1:1 S X1=FHD1SAV,X2=FHDTI-1 D C^%DTC Q:FHDTI'>0!(X>FHDT2)!$G(FHQUIT)  D
 .S FHDTTO=X,D1=X
 .W !!,"Forecasting ..." D Q2^FHPRF1
 .F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1!$G(FHQUIT)  D
 ..S S1=^TMP($J,P0)
 ..W !!?5,"Service Point: ",$P(^FH(119.72,P0,0),"^",1)
 ..D C1
 S D1=FHD1SAV
 Q
C1 ;
 S X=FHDTTO D DOW^%DTC S DOW=Y+1
 S FHDAY=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",DOW)
 S DTP=FHDTTO D DTP^FH
 W !?5,"Forecast Census for ",FHDAY,"DAY, ",DTP," : ",S1," // " R X:DTIME
 I '$T!(X["^") S FHQUIT=1 Q
 S:X="" X=S1 I X'?1N.N!(X>9999) W *7,"  Must be a number less than 9999" G C1
 I '$D(M2(P0)) S M2(P0)=X
 E  S M2(P0)=M2(P0)_"^"_X
 Q
 ;
CHKML ;check meal
 S FHMLFLG=0
 F FHMLCM="B","N","E","B-B","B-N","B-E","A","N-B","N-N","N-E","E-B","E-N","E-E" Q:FHMLCM=MEAL
 S:FHMLCM=MEAL FHMLFLG=1
 Q
 ;
KIL K ^TMP($J),^TMP("FH") G KILL^XUSCLEAN
