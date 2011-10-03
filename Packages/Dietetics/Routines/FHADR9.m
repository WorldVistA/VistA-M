FHADR9 ; HISC/NCA - Dietetic Survey ;11/25/94  14:27
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; Enter/Edit Dietetic Survey
 D QR^FHADR1 G:'PRE KIL
F1 ; Select Survey Category
 S FHX3=0 K DIR S DIR(0)="SO^1:APPETIZING;2:FOODS PREFERRED;3:HOT ENOUGH;4:COLD ENOUGH;5:COURTEOUS;6:PREFERENCES DISCUSSED;7:TIMELINESS;8:ENOUGH TIME TO EAT;9:NUTRITIONAL INFO;10:OVERALL",DIR("A")="Select SURVEY CATEGORY"
 S DIR("?")="Select one of the questions on the Dietetic Survey."
 D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S FHX1=+Y
 S FLDNUM=69+FHX1
 S TIT=$P($G(^DD(117.3,FLDNUM,0)),U,4)
 S TIT=$S(FHX1=1:"Q1AP",FHX1=2:"Q2FP",FHX1=3:"Q3HF",FHX1=4:"Q4CF",FHX1=5:"Q5CR",FHX1=6:"Q6PD",FHX1=7:"Q7TI",FHX1=8:"Q8ET",FHX1=9:"Q9NI",1:"Q10V")
 I '$D(^FH(117.3,PRE,TIT,0)) D CREAT
F2 ; Select Service
 K DIR S DIR(0)="SO^1:GM&S;2:NHCU;3:PSYCH;4:DOM;5:SCI;6:OTHER",DIR("A")="Select SERVICE",DIR("?")="Enter the Service you want to enter or edit."
 D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL S FHX2=+Y
 I 'FHX3 S FHX3=$P($G(^FH(117.3,PRE,TIT,0)),"^",3) Q:'FHX3
 S OLD=$P($G(^FH(117.3,PRE,TIT,FHX3,0)),"^",FHX2+1)
 G RTG
CREAT ; Create the first entry
 ;S ^FH(117.3,PRE,TIT,0)=$S(FHX1=1:"^117.358^^",FHX1=2:"^117.359^^",FHX1=3:"^117.31^^",FHX1=4:"^117.361^^",FHX1=5:"^117.362^^",FHX1=6:"^117.363^^",FHX1=7:"^117.364^^",FHX1=8:"^117.365^^",1:"^117.366^^")
 ;S ^FH(117.3,PRE,TIT,0)=$S(FHX1=1:"^117.37^^",FHX1=2:"^117.371^^",FHX1=3:"^117.372^^",FHX1=4:"^117.373^^",FHX1=5:"^117.374^^",FHX1=6:"^117.375^^",FHX1=7:"^117.376^^",FHX1=8:"^117.377^^",FHX1=8:"^117.378^^",1:"^117.379^^")
 ;S ^FH(117.3,PRE,TIT,0)=$P($G(^DD(117.3,FLDNUM,0)),U,2)
 ;S DA=$P(^FH(117.3,PRE,TIT,0),"^",3)+1,$P(^FH(117.3,PRE,TIT,0),"^",3)=DA
 K DIC,DD,DO S DIC="^FH(117.3,PRE,TIT,",DIC(0)="L",DLAYGO=117.3,DA(1)=PRE
 S (X,DINUM)=1 D FILE^DICN
 S FHX3=+Y K DA,DIC,DLAYGO,DINUM Q
RTG ; Read in Rating String
 W ! K DIR S DIR(0)="FO^2:35",DIR("A")="Enter Rating String" S:OLD'="" DIR("B")=OLD S DIR("?")="^D HEL^FHADR9"
 D ^DIR I X="@" S X="" G R1
 G:$D(DIRUT)!($D(DIROUT)) KIL
 D C0 I '$D(X) G RTG
R1 S $P(^FH(117.3,PRE,TIT,FHX3,0),"^",FHX2+1)=X
F3 W ! K DIR S DIR(0)="YA",DIR("A")="Enter More Rating String for another service ? ",DIR("B")="YES" D ^DIR G:$D(DIRUT)!($D(DIROUT)) KIL K DIR
 G F2:Y,F1
C0 ; Check validity of the Rating String
 D TR^FH
 I $E(X,$L(X))=" " S X=$E(X,1,$L(X)-1)
 S X9="",(X6,X7)=0 F X4=1:1 Q:$P(X," ",X4,99)=""  S X1=$P(X," ",X4) D C1
 K:X6 X K X1,X2,X3,X4,X5,X6,X7,X8,X9 Q
C1 I X1="" W *7,!?5,"Two spaces found in input" S X6=1 Q
 S X5=$F("E V G F U",$E(X1,1)) I 'X5 W *7,!?5,"'",$E(X1,1),"' Not a Rating." S X6=1 Q
 F X8=1:1 Q:$E(X1,X8)'?1U
 I X8<2!(X8>2) W *7,!?5,"Illegal String Specification in ",X1 S X6=1 Q
 I $E(X1,X8,$L(X1))="" W *7,!?5,"No number surveyed for ",X1 S X6=1
 I $E(X1,X8,$L(X1))'?1.4N W *7,!?5,"Illegal entry in rating ",X1 S X6=1
 I $E(X1,X8,$L(X1))>9999 W *7,!?5,$E(X1,X8,$L(X1))," cannot be greater than 9999" S X6=1
 S X2=$E(X1,1)
 I X9[X2 W *7,!?5,X2," used more than once." S X6=1
 S X9=X9_" "_X2,X7=X7+1
 I X7>5 W *7,!?5,"There are only 5 ratings." S X6=1
 Q
HEL ; Help Prompt for Rating String
 W !!,"List the numbers surveyed by specifying which rating it belongs"
 W !,"to and separated by a single space.",!
 W !,"Example: E20 V40 G40 F3 U1",!
 W !,"  E = Excellent, V = Very Good, G = Good, F = Fair and U = Unacceptable",!
 W !,"Omit if none surveyed for a certain rating.",! Q
KIL G KILL^XUSCLEAN
