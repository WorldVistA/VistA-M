FHOMRO3 ;Hines OIFO/RTK OUTPATIENT ORDER MULTIPLE DIETS ;9/28/04  10:05
 ;;5.5;DIETETICS;;Jan 28, 2005
 ;
 ;Code reused from FHORD1
 K FHDI,PREC S N1=0
F1 ;
 W ! K DIC S DIC="^FH(111,",DIC(0)="AEQMZ"
 S DIC("S")="I '$D(^(""I""))&(Y>0)" D ^DIC
 K DIC G AB:X[U!$D(DTOUT),F5:X="",F1:Y<1
 S PREC=$P(Y(0),U,4) I PREC,$D(FHDI(PREC)) W *7,!!,"This conflicts with ",$P(FHDI(PREC),"^",2),! G F1
 S N1=N1+1,FHDI(PREC)=+Y_"^"_Y(0) G F5:+Y=1,F1:N1<5 W *7,!!,"You have now selected the maximum of 5 Diet Modifications!"
F5 ;
 G:'N1 AB W !!,"You have selected the following Diet:",!
 S (FHD3,FHD4)=0 F FHD0=0:0 S FHD0=$O(FHDI(FHD0)) Q:FHD0=""  W !?5,$P(FHDI(FHD0),U,2) S:$P(FHDI(FHD0),U,4)="Y" FHD3=1 S:$P(FHDI(FHD0),U,7)="Y" FHD4=1
F9 ;
 R !!,"Is this Correct? Y// ",Y:DTIME G:'$T!(Y="^") AB S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to accept diet list; NO to select diets again" G F9
 I Y'?1"Y".E K FHDI S N1=0 W !!,"Select new diets ..." G F1
 Q
AB K FHDI S N1=0 Q
