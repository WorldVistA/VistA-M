PRCSEB0 ;SF-ISC/LJP/SAW/DGL/DAP-CPA EDITS CON'T ; 7/29/99 1:01pm
V ;;5.1;IFCAP;**81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EDTD ;EDIT TRANSACTION DATA
 N TYPE,TYPE1,CHECK,JUMP S JUMP=1
 D EN3F^PRCSUT(1) G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIE=DIC,DIC(0)="AEQM" S DIC("S")="I $P(^(0),U,4)'=1" S:$D(PRCSFT) DIC("S")="I $P(^(0),U,4)=1"
 S DIC("S")=DIC("S")_",$D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE"") I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 D ^PRCSDIC G EXIT:Y<0 K DIC("S") S (DA,PRCSDAA,PRCSY,T1)=+Y L +^PRCS(410,DA):15 G EDTD:$T=0
 S TYPE=$P(^PRCS(410,DA,0),"^",4)
EDTD1 S X=^PRCS(410,DA,0) S:+X PRC("FY")=$P(X,"-",2),PRC("QTR")=+$P(X,"-",3) S PRCSX3=$P(X,"^",2) G ASK:PRCSX3="" I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),"^",11)="Y" S PRCS2=1
EDTD3 I $D(^PRCS(410,DA,7)),$P(^(7),U,6)]"" G EDTD4
 I $D(PRCSEM) S DIE=DIC,DR="[PRCSENMDR]" D ^DIE S DA=T1 L -^PRCS(410,DA) G EXIT
 I PRCSX3'="O" S DR=$S(PRCSX3="C"&('$D(PRCS2)):"[PRCSENC]",PRCSX3="C"&($D(PRCS2)):"[PRCSENCI]",PRCSX3="A":"[PRCSENA]",1:"[PRCSENCT]") S:PRCSX3="A"&($P(^PRCS(410,PRCSY,0),U,4)=1) DR="[PRCSENA 1358]" S DIE=DIC D ^DIE S DA=PRCSY
 D:PRCSX3="A"&($O(^PRCS(410,PRCSY,12,0))) SCPC0^PRCSED
 I PRCSX3="A",$P(^PRCS(410,DA,0),U,4)=1 S X=$P(^(4),U,6),X1=$P(^(3),U,7) I $J(X,0,2)'=$J(X1,0,2)!('X)!('X1) W $C(7),!,"Adj $ Amt does not equal the total of BOC $ Amts.",!,"Please correct the error.",! K DR G EDTD3
 I PRCSX3="A",$P(^PRCS(410,DA,0),"^",4)=1 D W6^PRCSEB
 I PRCSX3'="O" G EDTD2
EDTD4 I $D(^PRCS(410,DA,7)),$P(^(7),"^",6)'="" S DR="[PRCSEDS]" D ^DIE D W1 G EDTD2
EDTD5 ;*81 Loop now checks site parameter to see if Issue Books should be allowed
 S X=+$P(^PRCS(410,DA,0),"^",4) I X<2 D
 .I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVX="I Y>1&(Y<5)",PRCVY="The 1358, Issue Book, and NO FORM types are not valid for use in this option."
 .I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVX="I Y>1",PRCVY="The 1358 and NO FORM types are not valid for use in this option."
 .W !,PRCVY,!
 .W !,"Please enter another form type.",!
 .S PRCDAA=DA,DIC="^PRCS(410.5,",DIC("A")="FORM TYPE: ",DIC(0)="AEQZ",DIC("S")=PRCVX,DIC("B")=4 D ^DIC S:Y=-1 Y=4 S DA=PRCDAA K DIC
 .K PRCVX,PRCVY
 .S $P(^PRCS(410,DA,0),"^",4)=+Y,X=+Y
 I $G(PRCSIP) S $P(^PRCS(410,DA,0),"^",6)=PRCSIP
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")=1 S PRCVZ=1
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q")'=1 S PRCVZ=0
 W !,"The form type for this transaction is ",$P($G(^PRCS(410.5,X,0)),"^"),!
 I PRCVZ=1,X=5 W !,"All Supply Warehouse requests must be processed in the new Inventory System.",!!,"Please cancel this IFCAP Issue Book order." D W3 G:%'=1 EXIT W !! K PRCS,PRCS2 G EDTD
 ;P182--Removed reference to TEMPREQ in following line: no longer used.
 ;Q:$D(TEMPREQ)  S (DIC,DIE)="^PRCS(410,"
 K PRCVZ
 S (DIC,DIE)="^PRCS(410,"
 G EDTD2:X=""
 S (PRCSDR,DR)="["_$S(X=2:"PRCSEN2237B",X=3:"PRCSENPR",X=4:"PRCSENR&NR",1:"PRCSENIB")_"]"
ED1 K DTOUT,DUOUT,Y S PRCSDAA=DA D ^DIE I $D(DTOUT) S DA=PRCSDAA G EXIT
 S DA=PRCSDAA D RL^PRCSUT1
 D ^PRCSCK I $D(PRCSERR),PRCSERR G ED1
 K PRCSERR
 I PRCSDR="[PRCSENCOD]" D W7 D:$D(PRCSOB) ENOD1^PRCSEB1 K PRCSOB
 S:$P($G(^PRCS(410,DA,7)),U)="" $P(^PRCS(410,DA,7),U)=DUZ,$P(^PRCS(410,DA,7),U,2)=$P($G(^VA(200,DUZ,20)),U,3)
 D:PRCSDR'="[PRCSENCOD]" W1 I $D(PRCS2),+^PRCS(410,DA,0) D W6^PRCSEB
EDTD2 S DA=PRCSDAA L -^PRCS(410,DA) G EXIT:$D(PRCSQ) D W3 G EXIT:%'=1 W !! K PRCS,PRCS2 G EDTD
ASK W !!,"This transaction does not have a valid transaction type (e.g.,O for Obligation, A for Adjustment, C for Ceiling).  Please enter one now.",! S DR="1" D ^DIE K DR G EDTD1
W1 W !!,"Would you like to review this request" S %=2 D YN^DICN G W1:%=0 Q:%'=1  S (N,PRCSZ)=DA,PRCSF=1 D PRF1^PRCSP1 S DA=PRCSZ K X,PRCSF,PRCSZ Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !!,"Would you like to edit another request" S %=1 D YN^DICN G W3:%=0 Q
W7 W !,"Do you wish to enter obligation data" S %=1 D YN^DICN Q:%=-1!(%=2)  G W7:%=0 S:%=1 PRCSOB=1 Q
EXIT K %,C,D,DA,DIC,DIE,DQ,DR,PRCS,PRCS2,PRCSDAA,PRCSDR,PRCSL,PRCSTT,I,N,T,T1,T2,X,X1,PRCSX3,Y,Z,Z7,PRCVZ Q
