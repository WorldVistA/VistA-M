PSGWUTL1 ;BHAM ISC/CML-Utility routine for HELP functions ; 15 Aug 93 / 4:46 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
SS ; Scroll-stop for last page of 80 column reports
 R !!,"END OF REPORT!  Press <RETURN> to return to Menu:",SS:DTIME K SS Q
HELP ; Help for scroll-stop
 W *7,!,"Please Enter: <RETURN> to continue viewing report or ""^"" to Exit report: "
 R ANS:DTIME S:'$T ANS="^" G:ANS?1."?" HELP Q
 ;***********************************************************************
IG ; Reset Sort Keys for inventory groups
 F INVGRP=0:0 S INVGRP=$O(^PSI(58.2,INVGRP)) Q:'INVGRP  I $O(^PSI(58.2,INVGRP,1,"D",0)) W "." D IGSET
 K INVGRP Q
IGSET S CNT=0 F SK=0:0 S SK=$O(^PSI(58.2,INVGRP,1,"D",SK)) Q:'SK  S AOU=$O(^PSI(58.2,INVGRP,1,"D",SK,0)),CNT=CNT+1,AOULP(CNT)=AOU
 F SK=0:0 S SK=$O(AOULP(SK)) Q:'SK  S NSK=SK*100,DA(1)=INVGRP,DA=AOULP(SK),DIE="^PSI(58.2,"_DA(1)_",1,",DR="2///"_NSK D ^DIE
 K D,D0,DA,DI,DIC,DIE,DQ,DR,X,CNT,SK,NSK,AOU,AOULP Q
 ;***********************************************************************
SEL ; Ask if reports are to print by Inventory Group or AOU
 W !!?5,"You may select a single AOU, several AOUs,",!?5,"or enter ""^ALL"" to select all AOUs.",!?20,"-OR-",!?5,"You may select an Inventory Group."
ASKSEL ;
 W !!,"Do you want to select AOU(s) or an Inventory Group? (Enter 'A' or 'I'): " R SEL:DTIME S:'$T SEL="^" G:"^"[SEL QUIT I SEL?1."?" D HELPSEL G ASKSEL
 I SEL'="A"&(SEL'="I") W *7,"??" D HELPSEL G ASKSEL
 W !
ASKIG Q:SEL="A"  S DIC="^PSI(58.2,",DIC(0)="QEAM",DIC("S")="I $D(^PSI(58.2,""WS"",+Y))" D ^DIC K DIC I Y<0 K SEL Q
 S IGDA=+Y I '$O(^PSI(58.2,IGDA,1,0)) W *7,!!,"There are no AOUs defined for this Inventory Group!" G ASKIG
 F IGAOU=0:0 S IGAOU=$O(^PSI(58.2,IGDA,1,IGAOU)) Q:'IGAOU  S AOULP(IGAOU)=""
 W !!,"This Inventory Group contains the following AOU(s):" F IGAOU=0:0 S IGAOU=$O(AOULP(IGAOU)) Q:'IGAOU  W !?5,$P(^PSI(58.1,IGAOU,0),"^") I $D(^PSI(58.1,IGAOU,"I")),^("I"),^("I")'>DT W "   *** INACTIVE ***"
QUIT K:SEL="^"!(SEL="") SEL K %,IGAOU,DIC,X,Y Q
HELPSEL ;
 W !!?5,"Enter an 'A' if you wish to select individual AOUs (one, several or ^ALL).",!?5,"Enter an 'I' if you wish to select all AOUs in an Inventory Group.",!?5,"Or enter ""^"" to Exit." Q
PSGWDT() ;Find current date and time
 D NOW^%DTC
 S Y=$E(%,1,12)
 X ^DD("DD")
 Q Y
