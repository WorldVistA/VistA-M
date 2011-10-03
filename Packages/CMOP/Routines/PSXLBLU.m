PSXLBLU ;BIR/HTW,BAB-CMOP Host Label Print..Blackline Resolver ;[ 05/01/97  11:47 AM ]
 ;;2.0;CMOP;**1**;11 Apr 97
BLR ;BLACK LINE RESOLVER
 L +^PSX(553):1 I '$T D MSG Q
 I ^PSX(553,1,"S")="R" D MSG Q
 G:'$D(^PSX(554,"AB")) BLR1
 S R554=$O(^PSX(554,"AB",""))
 I $P($G(^PSX(554,1,1,R554,0)),"^",4)="R" S ZH="F" D MSG Q
BLR1 I ^PSX(553,1,"S")="S" S ^PSX(553,1,"P")="R"
 L -^PSX(553)
 W @IOF
 S ZEND=999999999,PSXBLR=1
 W ?25,"CMOP LABEL RESTART UTILITY"
 W !!,"To run the Label Restart Utility you will need the Rx number of the last"
 W !," USEABLE Rx that printed, as well as the CMOP Order # where the"
 W !,"error occurred.",!
 S DIR(0)="Y",DIR("A")="Did the error occur during Reprint",DIR("B")="NO"
 S DIR("?")="If the error occurred while reprinting labels answer YES, otherwise press enter."
 D ^DIR K DIR G:$D(DIRUT) END1
 S:$G(Y)=1 REPRINT=1 K Y
ORDER W !
 S DIC=552.2,DIC(0)="AEQMZ",DIC("A")="Enter Beginning CMOP Order #: "
 D ^DIC K DIC G:$E(X)["^"!($D(DUOUT))!($D(DTOUT)) STOP
 I ""[X W !,"This is a required response. Enter ""^"" to Exit" G ORDER
 S (PSXBEG,ZA2)=+Y,BATREF=$P($P(Y,U,2),"-")_"-"_$P($P(Y,U,2),"-",2)
 S N514=$O(^PSX(552.1,"B",BATREF,""))
ORD1 S DIC=552.2,DIC(0)="AEQMZ",DIC("A")="Enter Ending CMOP Order #: "
 D ^DIC K DIC G:$E(X)["^"!($D(DUOUT))!($D(DTOUT)) STOP
 I ""[X S PSXEND=PSXBEG K Y G RX
 S PSXEND=+Y
RX I PSXEND<PSXBEG W !,"Ending order # MUST FOLLOW beginning order #.  Try again." K PSXEND G ORD1
 W !
 S DIR(0)="FO^1:999999999"
 S DIR("A")="Enter the last USABLE Rx number printed or 'RETURN' to start at the first Rx in order"
 S DIR("?")="^D HELP^PSXLBLU"
 D ^DIR K DIR G:$D(DUOUT)!($D(DTOUT)) STOP
 I $G(Y)="" S RESET="TOP" G D1
 S RXX=$TR(Y," ","")
FIND S CNT=1,CNT1=0
 F C=1:0 S C=$O(^PSX(552.2,ZA2,"T",C)) Q:'C  S J=^(C,0) I $P(J,"|")="ZX1" D
 .S RXY=$P(J,"|",2) I RXX=RXY S RESET=CNT
 .S CNT=CNT+1,CNT1=CNT1+1
 I '$G(RESET) W !!,"NO MATCHING RX NUMBER FOUND...Searching",! H 2 D HELP G RX
 I CNT1=1 W !!,"There is only one Rx in this order. To print it, press RETURN at the prompt." G RX
 I $G(RESET)=CNT1 W !!,"You have chosen the last Rx in this order.  If you want to print this Rx, enter the Rx preceding this Rx within the order or press RETURN to print the entire order." G RX
D1 D DEVICE^PSXLBL S ^PSX(553,1,"P")="S"
STOP ;
 I ^PSX(553,1,"P")="R" S ^PSX(553,1,"P")="S"
 K C,DIC,DIR,X,Y,ZX,BATREF1,OUT,Z1,NODE,TRUG,J,N,ZA2,RXX,RXY,Z,ZEND
 K CNT,REPRINT,RESET,BATREF,N514,PSXBAR,PSXLAP,CNT1
 K DTOUT,DUOUT,DIRUT,DIROUT,PSXBEG,PSXEND,PSXBLR,R554
 Q
HELP ;
 S Z=ZA2-1,ZEND=ZA2
SKIP ;
 F  S Z=$O(^PSX(552.2,Z)) Q:'Z!(Z>ZEND)  S BATREF1=$P(^(Z,0),U) D S1 Q:$G(OUT)
 Q
S1 W @IOF
 W !,"You selected CMOP order # ",BATREF1
 W !,"If this is correct, please choose the last USABLE Rx that printed"
 W !,"from the following list: "
S2 F Z1=0:0 S Z1=$O(^PSX(552.2,Z,"T",Z1)) Q:'Z1  S NODE=^(Z1,0) D  Q:$G(OUT)
 .I $P(NODE,"|")="PID" W !!,$TR($P(NODE,"|",6),"^",","),?30 Q
 .I $P(NODE,"|")="RX1" S TRUG=$P($P(NODE,"|",15),"^",2) Q
 .I $P(NODE,"|")="ZX1" W !,$P(NODE,"|",2),?15,TRUG
 .I $Y>20 S DIR(0)="E" D ^DIR K DIR S:$D(DUOUT)!($D(DTOUT)) OUT=1 W @IOF
 Q
PRINT ;
 S A0="",AZ1=BATREF_"-",^TMP($J,PSXBEG)=""
 F  S A0=$O(^PSX(552.2,"B",A0)) Q:($G(A0)']"")  I A0[AZ1 D
 .F A1=0:0 S A1=$O(^PSX(552.2,"B",A0,A1)) Q:'A1!(A1>PSXEND)  D
 ..I A1>PSXBEG S ^TMP($J,A1)=""
 ..K AZ
 K A1,ZA2,A0,AZ1
MAIN ;
 F A1=0:0 S A1=$O(^TMP($J,A1)) Q:'A1  S ZA2=A1-1 D MAIN^PSXLBL1
F514 D NOW^%DTC S (Y,RNOW1)=% X ^DD("DD") S RNOW=$P(Y,":",1,2) K Y,%,DD,DO
 S DA=ZA2
 I $G(REPRINT) D  G F1
 .I '$D(^PSX(552.1,N514,3,0)) S ^PSX(552.1,N514,3,0)="^552.115^^"
 .S DA(1)=N514,DIC(0)="LMZ",DIC="^PSX(552.1,DA(1),3,",X="BATCH REPRINTED by "_$P($G(^VA(200,DUZ,0)),"^")_" on "_RNOW,DLAYGO=552
 I '$D(^PSX(552.1,N514,4,0)) S ^PSX(552.1,N514,4,0)="^552.117D^^"
 S DA(1)=N514,DIC(0)="LMZ",DIC="^PSX(552.1,DA(1),4,",X=RNOW1 S DIC("DR")="1////"_DUZ,DLAYGO=552
F1 D FILE^DICN K DIC,X,DLAYGO
F2 I '$D(^PSX(552.2,"AQ",BATREF)),($P($G(^PSX(552.1,N514,0)),"^",2)=2) D
 .S $P(^PSX(552.1,N514,0),"^",2)=3,$P(^(0),"^",6)=RNOW1
 .S DIK="^PSX(552.1,",DA=N514 D IX^DIK K DIK,DA
 .S $P(^PSX(554,1,0),"^",4)=BATREF
 S PSXDA=N514 D ACK^PSXNOTE
F553 S ^PSX(553,1,"P")="S"
END ;
 K ^PSX(552.1,"APR",BATREF)
 K NOW,BDAT,BDATE,EDAT,EDATE,BATREF,Z,ER,NTE,Q,V,C,ZZ,Z,X,Y,G,N2,N3,SITE
 K ZA2,ADDR,AZ,AZ1,B,C1,C2,DIE,DR,I,N4,N514,Q1,TODAY,RNOW,RX1,ZX,BAR
 K S,SADD1,SADD2,SCITY,ZZT,F,SIGN,SNAME,SSN,SSTATE,STEL,SZIP,TEMP,TODAY
 K PSXBAR0,PSXBAR1,R554,DIRUT,DTOUT,DUOUT,DIROUT,RNOW1
 Q
MSG W !!,"Labels may NOT be printed while the CMOP "_$S($G(ZH)="F":"Background Filer ",1:"Interface ")_"is running.",!!,"Please try again,later.",!! L -^PSX(553)
 K ZH,R554
 Q
END1 K PSXBEG,PSXEND,BATREF,Z,ER,NTE,Q,V,C,ZZ,Z,X,Y,G,A,CT,CH1,L,PSXST,ZY
 K IEN14,CNT,R554,PSXBLR
 Q
