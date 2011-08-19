FHMTK2 ; HISC/NCA - List Diet Patterns ;4/25/95  09:54
 ;;5.5;DIETETICS;;Jan 28, 2005
ASK R !!,"Print ALL Diet Patterns? Y// ",ANS:DTIME G:'$T!(ANS="^") KIL S:ANS="" ANS="Y" S X=ANS D TR^FH S ANS=X
 I $P("YES",ANS,1)'="",$P("NO",ANS,1)'="" W *7,!,"  Answer YES to print all Diet Patterns; NO to select ONE Diet Pattern to print" G ASK
 I ANS?1"Y".E S FHDA="" G LIS
F0 K DI S N1=0
F1 W ! K DIC S DIC="^FH(111,",DIC(0)="AEQMZ" D ^DIC K DIC G KIL:X[U!$D(DTOUT),F5:X="",F1:Y<1
 S PREC=$P(Y(0),U,4) I PREC,$D(DI(PREC)) W *7,!!,"This conflicts with ",$P(DI(PREC),"^",2),! G F1
 S N1=N1+1,DI(PREC)=+Y_"^"_Y(0) G F5:+Y=1,F1:N1<5 W *7,!!,"You have now selected the maximum of 5 Diet Modifications!"
F5 G:'N1 KIL
 I N1>1 D  I CHK W !!,"You can not select REGULAR with another Diet." G F0
 .S CHK=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  I +DI(D0)=1 S CHK=1 Q
 .Q
 W !!,"You have selected the following Diet:",!
 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  W !?5,$P(DI(D0),U,2)
F9 R !!,"Is this Correct? Y// ",Y:DTIME G:'$T!(Y="^") KIL S:Y="" Y="Y" S X=Y D TR^FH S Y=X
 I $P("YES",Y,1)'="",$P("NO",Y,1)'="" W *7,!,"  Answer YES to accept diet list; NO to select diets again" G F9
 I Y'?1"Y".E W !!,"Select new diets ..." G F0
 S FHOR="^^^^",N1=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  S N1=N1+1,$P(FHOR,U,N1)=+DI(D0)
 S Y="" F A1=1:1:5 S D3=$P(FHOR,"^",A1) Q:'D3  S:Y'="" Y=Y_", " S Y=Y_$P(^FH(111,D3,0),"^",7)
 S FHDA=$O(^FH(111.1,"AB",FHOR,0)) I 'FHDA W !,"No Diet Pattern for this Diet Order" G KIL
 K A1,CHK,DI,D0,D3,FHOR,PREC,N1,Y
LIS ; List Diet Patterns
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="L1^FHMTK21",FHLST="ANS^FHDA" D EN2^FH G KIL
 U IO D L1^FHMTK21 D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
