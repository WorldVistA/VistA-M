PSGWUTL ;BHAM ISC/CML,KKA-Utility routine for FileMan functions ; 06 Dec 93 / 2:23 PM
 ;;2.3; Automatic Replenishment/Ward Stock ;**17**;4 JAN 94
OND ;Check quantities for On-Demands/Returns
 Q:'$D(^PSI(58.1,DA(2),1,DA(1),0))  Q:'$P(^(0),"^",2)  I X'>(2*$P(^(0),"^",2)) Q
 W *7,!!,"This quantity seems too high!  The normal Stock Level for this item is ",$P(^PSI(58.1,DA(2),1,DA(1),0),"^",2)
ASK W !?5,"Are you sure of this amount " S %=2 D YN^DICN I %=1 K %,%Y Q
 I %=0!(%=-1) W "    Enter 'YES' or 'NO'" G ASK
 K X,%,%Y Q
QUIT K %,%Y,ADT,AOU,LP,II,ITM Q
 ;SUBROUTINES FOR AMIS XREFS
QD ;SET "AMIS" XREF FOR QTY DISPENSED
 Q:$D(PSGWV)  I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),1,DA,0),"^",4)'=1 Q:'$D(^PSI(58.19,DA))  S ADT=$P(^(DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMIS",$H,ADT,"A",AOU,ITM,X)=""
 G QUIT
KQD ;KILL "AMIS" XREF FOR QTY DISPENSED
 Q:$D(PSGWV)  Q:'$D(^PSI(58.19,DA))  S ADT=$P(^(DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,AOU,1,DA(1),0),"^"),LP="" F II=0:0 S LP=$O(^PSI(58.5,"AMIS",LP)) Q:'LP  I $D(^PSI(58.5,"AMIS",LP,ADT,"A",AOU,ITM)) K ^(ITM)
 G QUIT
OD ;SET "AMIS" XREF FOR ON-DEMAND REQUEST
 Q:$D(PSGWV)  I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),5,DA,0),"^",4)'=1 S ADT=$P(^(0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMIS",$H,ADT,"W",AOU,ITM,X)=""
 G QUIT
KOD ;KILL "AMIS" XREF FOR ON-DEMAND REQUEST
 Q:$D(PSGWV)  S ADT=$P(^PSI(58.1,DA(2),1,DA(1),5,DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,AOU,1,DA(1),0),"^"),LP="" F II=0:0 S LP=$O(^PSI(58.5,"AMIS",LP)) Q:'LP  I $D(^PSI(58.5,"AMIS",LP,ADT,"W",AOU,ITM)) K ^(ITM)
 G QUIT
RET ;SET "AMIS" XREF FOR RETURNS
 Q:$D(PSGWV)  I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),3,DA,0),"^",4)'=1 S ADT=DA,AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMIS",$H,ADT,"R",AOU,ITM,X)=""
 G QUIT
KRET ;KILL "AMIS" XREF FOR RETURNS
 Q:$D(PSGWV)  S ADT=DA,AOU=DA(2),ITM=$P(^PSI(58.1,AOU,1,DA(1),0),"^"),LP="" F II=0:0 S LP=$O(^PSI(58.5,"AMIS",LP)) Q:'LP  I $D(^PSI(58.5,"AMIS",LP,ADT,"R",AOU,ITM)) K ^(ITM)
 G QUIT
QDERR ;SET "AMISERR" XREF ON QTY DISPENSED
 Q:$D(PSGWV)  I $D(^PSI(58.1,DA(2),"SITE")),^("SITE")]"" Q
 I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),1,DA,0),"^",4)'=1 Q:'$D(^PSI(58.19,DA))  S ADT=$P(^(DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMISERR",AOU,$H,ADT,"A",ITM,X)=""
 G QUIT
KQDERR ;KILL "AMISERR" XREF ON QTY DISPENSED
 Q:$D(PSGWV)  Q:'$D(^PSI(58.19,DA))  S ADT=$P(^(DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),LP=""
 F II=0:0 S LP=$O(^PSI(58.5,"AMISERR",AOU,LP)) Q:'LP  I $D(^PSI(58.5,"AMISERR",AOU,LP,ADT,"A",ITM)) K ^(ITM)
 G QUIT
ODERR ;SET "AMISERR" XREF ON ON-DEMANDS
 Q:$D(PSGWV)  I $D(^PSI(58.1,DA(2),"SITE")),^("SITE")]"" Q
 I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),5,DA,0),"^",4)'=1 S ADT=$P(^(0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMISERR",AOU,$H,ADT,"W",ITM,X)=""
 G QUIT
KODERR ;KILL "AMISERR" XREF ON ON-DEMANDS
 Q:$D(PSGWV)  S ADT=$P(^PSI(58.1,DA(2),1,DA(1),5,DA,0),"^"),AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),LP=""
 F II=0:0 S LP=$O(^PSI(58.5,"AMISERR",AOU,LP)) Q:'LP  I $D(^PSI(58.5,"AMISERR",AOU,LP,ADT,"A",ITM)) K ^(ITM)
 G QUIT
RETERR ;SET "AMISERR" XREF ON RETURNS
 Q:$D(PSGWV)  I $D(^PSI(58.1,DA(2),"SITE")),^("SITE")]"" Q
 I X'=0,$P(^PSI(58.1,DA(2),0),"^",3)'=1,$P(^(1,DA(1),3,DA,0),"^",4)'=1 S ADT=DA,AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),^PSI(58.5,"AMISERR",AOU,$H,ADT,"R",ITM,X)=""
 G QUIT
KRETERR ;KILL "AMISERR" XREF ON RETURNS
 Q:$D(PSGWV)  S ADT=DA,AOU=DA(2),ITM=$P(^PSI(58.1,DA(2),1,DA(1),0),"^"),LP=""
 F II=0:0 S LP=$O(^PSI(58.5,"AMISERR",AOU,LP)) Q:'LP  I $D(^PSI(58.5,"AMISERR",AOU,LP,ADT,"A",ITM)) K ^(ITM)
 G QUIT
INACT ;CHECK FOR INACTIVE DATE ON ITEM FOR "D" XREF (FILE 58.1)
 K PSGWFLG I '$D(^PSI(58.1,DA(2),1,DA(1),"I")) S PSGWFLG=1 Q
 S:$O(^PSI(58.1,DA(2),1,DA(1),"I"))>DT PSGWFLG=1 Q
DRGSCRN ;SCREEN DRUG FILE DRUGS FOR AR/WS FOR ^DD(58.11,.01,0) AND ^DD(58.11,.01,12.1)
 ; naked indicator set within VA FileMan in file 58.11
 ; this code is called as part of the input transform
 I $S('$D(^("I")):1,+^("I")>DT:1,1:0) S APU=$P($G(^(2)),"^",3) I $S(APU="":1,APU["O":1,APU["U":1,APU["I":1,APU["X":1,1:APU["N")
 K APU Q
DRGSCRN2 ;
 S DIC("S")="I $S('$D(^(""I"")):1,+^(""I"")>DT:1,1:0) S APU=$P($G(^(2)),""^"",3) I $S(APU="""":1,APU[""O"":1,APU[""U"":1,APU[""I"":1,APU[""X"":1,1:APU[""N"")"
 D ^DIC K DIC S DIC=DIE,X=+Y
 I Y<0 W !,"Enter name of drug being stocked in this AOU." K X
 K APU Q
EDCHK ;
 I $O(^PSI(58.1,D0,1,+$G(D1),0)) S Y=-1 K X W !,"  NO EDITING -- This item has activity.           "
 Q
