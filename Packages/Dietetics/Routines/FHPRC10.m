FHPRC10 ; HISC/NCA - Meal Analysis ;3/6/95  15:41
 ;;5.5;DIETETICS;;Jan 28, 2005
 K ^TMP($J)
GET W ! K DIC S DIC="^FHUM(",DIC(0)="AEQMZ",DIC("S")="I $P(^(0),U,5)",DIC("DR")=".01" D ^DIC K DLAYGO G KIL:U[X!$D(DTOUT),GET:Y<1 S MENU=+Y,MNAM="Menu: "_$P(Y,U,2) D RET^FHPRC14
ED R !!,"Do you wish to EDIT this Menu? NO// ",YN:DTIME G:'$T!(YN["^") KIL S:YN="" YN="N" S X=YN D TR^FH S YN=X I $P("YES",YN,1)'="",$P("NO",YN,1)'="" W *7," Answer YES or NO" G ED
 I YN?1"N".E W ! G R3
E1 ; Enter/Edit Day
 R !,"Select DAY #: ",DAY:DTIME G:'$T!(DAY["^") KIL
 I DAY="" S X3=$O(^TMP($J,"RECIPES",0)) G KIL:X3="",R3
 I DAY'?1N!(DAY<1)!(DAY>7) W *7,"  Enter a Day # from 1-7" G E1
E2 ; Enter/Edit Meal #
 R !,"Select MEAL #: ",MEAL:DTIME G:'$T!(MEAL["^") KIL
 I MEAL="" S X3=$O(^TMP($J,"RECIPES",0)) G KIL:X3="",E1
 I MEAL'?1N!(MEAL<1)!(MEAL>6) W *7,"  Enter a Meal # from 1-6" G E2
R0 ; Edit Meal File
 S S1=$G(^TMP($J,"RECIPES",DAY,MEAL,0))
 K DIC S DIC="^FH(116.1,",DIC(0)="EQM"
 W !,"Select Meal: ",$S($P($G(^FH(116.1,+S1,0)),"^",1)'="":$P(^FH(116.1,+S1,0),"^",1)_" // ",1:"") R X:DTIME G:'$T!(X["^") KIL
 I X="@" K ^TMP($J,"RECIPES",DAY,MEAL) W "   Meal Deleted" G E2
 I X="" S:S1'="" X=$P($G(^FH(116.1,+S1,0)),"^",1) I S1="" S X3=$O(^TMP($J,"RECIPES",0)) G KIL:X3="",E2
 D ^DIC G:Y<1 R0 S M1=+Y K DIC
S1 ; Edit Production Diet
 K DIC S DIC="^FH(116.2,",DIC(0)="AEQMZ" S:$P(S1,"^",2) DIC("B")=$P($G(^FH(116.2,+$P(S1,"^",2),0)),"^",1) D ^DIC G KIL:U[X!$D(DTOUT),S1:Y<1 S PD=+Y,CODE=$P(Y(0),"^",2) K DIC
 S ZZ=M1_"^"_PD I S1=ZZ G:$D(^TMP($J,"RECIPES",DAY,MEAL)) R1
 S $P(S1,"^",2)=PD
 D SRCH^FHPRC14
R1 ; Edit Recipe and Portion
 K DIC S DIC="^FH(114,",DIC(0)="EQM"
 R !!,"Select Recipe: ",X:DTIME G KIL:'$T!(X["^"),E2:X=""
 I X="?" D LIS^FHPRC14 G R1
 D ^DIC G:Y<1 R1 K DIC S REC=+Y S:'$D(^TMP($J,"RECIPES",DAY,MEAL,REC)) ^TMP($J,"RECIPES",DAY,MEAL,REC)=1_"^"_$P($G(^FH(114,REC,0)),"^",14)
R2 W !,"Serving Portion: ",+$G(^TMP($J,"RECIPES",DAY,MEAL,REC))_"// " R X:DTIME G:'$T!(X["^") KIL G:X="" R1
 I X'?.N.1".".N!(X<0)!(X>9999) W *7,!,"Enter amount of serving portion.  Enter 0 to omit recipe;",!,"otherwise enter a number greater than 0 but less than 9999." G R2
 S $P(^TMP($J,"RECIPES",DAY,MEAL,REC),"^",1)=X
 G R1
R3 ; Select RDA Category
 K DIC S DIC="^FH(112.2,",DIC(0)="AEQM",DIC("A")="Select DRI Category: " W ! D ^DIC G:X[U!$D(DTOUT) KIL S RDA=$S(Y<1:0,1:+Y) K DIC
 S (AGE,NAM,SEX)=""
F1 S ALL=1 D ^FHDPA G PAT:X="*",S3:X="",KIL:'DFN S NAM=$P(Y(0),U,1),SEX=$P(Y(0),U,2),AGE=$P(Y(0),U,3) G:SEX=""!(AGE="") P1
 I $P($G(^DPT(DFN,.35)),"^",1) W *7,!!?5,"  [ Patient has expired. ]" G KIL
 S AGE=$E(DT,1,3)-$E(AGE,1,3)-($E(DT,4,7)<$E(AGE,4,7))
S3 R !!,"Do you wish a detailed analysis? Y// ",SUM:DTIME G:'$T!(SUM["^") KIL S:SUM="" SUM="Y" S X=SUM D TR^FH S SUM=X I $P("YES",SUM,1)'="",$P("NO",SUM,1)'="" W *7,!,"  Answer YES or NO" G S3
 S SUM=$E(SUM,1),SUM=SUM="N" K M
 W !!,"The Analysis requires a 132 column printer.",!
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) D  G KIL
 .K IO("Q"),ZTUCI,ZTDTH,ZTIO,ZTSAVE
 .S ZTRTN="^FHPRC11",ZTREQ="@",ZSAVE("ZTREQ")="",ZTDESC=$P($G(XQY0),U,1)
 .F G="AGE","DAY","MEAL","MNAM","NAM","^TMP($J,","RDA","SEX","SUM" S ZTSAVE(G)=""
 .D ^%ZTLOAD D ^%ZISC U IO W !,"Request Queued",! K ZTSK Q
 U IO X ^%ZOSF("BRK") D ^FHPRC11 X ^%ZOSF("NBRK") D ^%ZISC K %ZIS,IOP G KIL
PAT R !!,"Enter Patient's Name: ",NAM:DTIME G:'$T!("^"[NAM) KIL
 I NAM["?"!(NAM'?.ANP)!(NAM["^") W *7,!?5,"Enter Patient's Name to be printed on the report." G PAT
P1 R !,"Sex: ",SEX:DTIME G:'$T!("^"[SEX) KIL S X=SEX D TR^FH S SEX=X I $P("MALE",SEX,1)'="",$P("FEMALE",SEX,1)'="" W *7,"  Enter M or F" G P1
 S SEX=$E(SEX,1)
P2 R !,"Age: ",AGE:DTIME G:'$T!("^"[AGE) KIL I AGE'?1N.N!(AGE<6)!(AGE>124) W !?5,"Enter Age in years between 6 and 124" G P2
 G S3
KIL ; Kill all Used Variables
 K ^TMP($J) G KILL^XUSCLEAN
