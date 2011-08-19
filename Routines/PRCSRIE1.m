PRCSRIE1 ;WISC/SAW/DXH/SC/BMM - DELETE/REPLACE REPETITIVE ITEM LIST ; 3/31/05 3:22pm
V ;;5.1;IFCAP;**13,81**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;BMM patch PRC*5.1*81 in EDIT, added DMCHK to ensure RILs from
 ;DynaMed are not edited.  First check that DynaMed switch is on.
 ;*81-SC-if it is DM RIL trx, then right before deleting update Audit
 ;File 414.02 & send a msg to DynaMed thru a call to rtn PRCVRCA.
 ;
EDIT ;EDIT REP ITEM
 D DISP^PRCOSS3
 S DIC="^PRCS(410.3,",DIC(0)="AEMQZ",DIC("S")="S PRC(""SITE"")=+^(0),PRC(""CP"")=$P(^(0),""-"",4),$P(^(0),U,5)="""" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select REPETITIVE ITEM LIST #: " D ^DIC K DIC("S") I Y'>0 G EXIT
 S (PRCSDA,DA)=+Y,PRCSNO=$P(^PRCS(410.3,DA,0),U)
 ;PRC*5.1*81 can't edit if DynaMed RIL
 I $$GET^XPAR("SYS","PRCV COTS INVENTORY",1,"Q"),$$DMCHK(DA) W !!,"** This RIL originated from DynaMed and cannot be edited **" H 3 G EXIT
 L +^PRCS(410.3,DA):1
 I $T=0 W !!,?15,"** Record in use, try to edit later **",! G EDIT
 S PRC("SITE")=+Y(0),PRC("CP")=$P(Y(0),"-",4),DR="[PRCSRI]",DIE=DIC,DIE("NO^")=1 D ^DIE D CALC L -^PRCS(410.3,DA) K DIE("NO^")
W2 W !!,"Would you like to edit another repetitive item list entry" S %=2 D YN^DICN G W2:%=0,EXIT:%=2!(%<1) W !! K PRCSV,PRCSV1 G EDIT
CALC ;CALCULATE TOTAL COST
 W !,"Let me total the cost for this Repetitive Item List entry (#",PRCSNO,")"
 S (N,PRCSTC)="" F I=0:1 S N=$O(^PRCS(410.3,PRCSDA,1,"B",N)) Q:N=""  S N(1)="",N(1)=$O(^(N,N(1))) I $D(^PRCS(410.3,PRCSDA,1,N(1),0)) S N(2)=^(0),PRCSTC=PRCSTC+($P(N(2),"^",2)*($P(N(2),"^",4)))
 W !,"Total number of items: ",I,"    Total cost (all items): $",$J(PRCSTC,0,2) S $P(^PRCS(410.3,PRCSDA,0),"^",2)=PRCSTC K N,PRCSTC
 ;Karen's new stuff
CHECK ;
 S ZIP=0 F  S ZIP=$O(^PRCS(410.3,PRCSDA,1,ZIP)) Q:+ZIP=0  D
 .S K0=^PRCS(410.3,PRCSDA,1,ZIP,0),V0=$P(K0,"^",5),V1=$P(K0,"^")
 .S K1=$P($G(^PRC(441,+V1,2,+V0,0)),"^",3) S:K1'="" $P(K0,"^",6)="Y" S:K1="" $P(K0,"^",6)="N"
 .S ^PRCS(410.3,PRCSDA,1,ZIP,0)=K0
 K ZIP,K0,K1,V0,V1 QUIT
DEL ;DELETE REPETITIVE ITEM LIST ENTRY
 S DIC="^PRCS(410.3,",DIC(0)="AEMQZ",DIC("S")="S PRC(""SITE"")=+^(0),PRC(""CP"")=+$P(^(0),""-"",4),$P(^(0),U,5)="""" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select REPETITIVE ITEM LIST #: " D ^DIC K DIC("S") I Y'>0 G EXIT
 S DA=+Y L +^PRCS(410.3,DA):1
 I $T=0 W !!,?15,"** Record in use, try to delete later **",! G DEL
DEL1 W !,"Are you sure you want to delete this Repetitive Item List entry" S %=2 D YN^DICN G DEL1:%=0 I %<0!(%=2) L -^PRCS(410.3,DA) G EXIT
 ;PRC*5.1*81 if it is DM RIL, then update Audit File & send msg to DM
 S DIK=DIC D EN^PRCVRCA(DA) L -^PRCS(410.3,DA) W !,"Okay....." D ^DIK W "It's deleted."
DEL2 W !,"Would you like to delete another Repetitive Item List entry" S %=2 D YN^DICN G DEL2:%=0,EXIT:%=2,EXIT:%<0 W !! G DEL
REPL ;REPLACE EXISTING REPETITIVE ITEM LIST ENTRY NUMBER
 W !!,"Select the existing Repetitive Item List entry number to be replaced.",!
 S DIC="^PRCS(410.3,",DIC(0)="AEMQZ",DIC("S")="S PRC(""SITE"")=+^(0),PRC(""CP"")=$P(^(0),""-"",4),$P(^(0),U,5)="""" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select REPETITIVE ITEM LIST #: " D ^DIC K DIC("S") I Y'>0 G EXIT
 S DA=+Y L +^PRCS(410.3):15 G:$T=0 REPL
 S T1=+Y,T2=$P(Y(0),"^"),PRC("SITE")=+^PRCS(410.3,DA,0),PRC("CP")=$P(^(0),"-",4) K DA,DIC,Y
 W !!,"Now enter the information for the new Repetitive Item List entry number.",!
 D EN^PRCSUT G W5^PRCSUT3:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 K ^PRCS(410.3,"B",T2,T1),^PRCS(410.3,"C",$P(T2,"-",5),T1)
 I $D(^PRC(420,PRC("SITE"),1,+PRC("CP"),0)),$P(^(0),U,12)>1 S Y="NONE" G STF
 S DIC="^PRC(420,PRC(""SITE""),1,+PRC(""CP""),2,",DIC(0)="AEMNQZ" D ^DIC I Y'>0 G EXIT
 S Y=$P(Y(0),"^") I '$D(^PRCD(420.1,Y,0)) G EXIT
STF S X=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")_"-"_Y
 S $P(^PRCS(410.3,T1,0),"^")=X,^PRCS(410.3,"B",X,T1)="",^PRCS(410.3,"C",Y,T1)=""
 L -^PRCS(410.3)
REPL1 W !!,"Would you like to replace another Repetitive Item List entry number" S %=2 D YN^DICN G REPL1:%=0,EXIT:%<0,EXIT:%=2 I %=1 W !! G REPL
SUB ;ASK BOC IF ONE DOES NOT EXIST FOR ITEM IN FILE 441
 S Z0=$P(^PRCS(410.3,DA(1),1,DA,0),"^"),DIC="^PRCD(420.2,",DIC(0)="AEMQ",DIC("A")="Select BOC: "
SUB1 D ^DIC I Y'>0 W !,$C(7),"Sorry, but you must select a budget object code for this item." G SUB1
 S $P(^PRC(441,Z0,0),"^",10)=+Y S DIC=DIE K Y,Z0 Q
VENDORH ;HELP PROMPT FOR VENDOR FIELD IN FILE 410.3
 S:$D(D) ZD=D S X="?",Z0=$P(^PRCS(410.3,DA(1),1,DA,0),"^") Q:'Z0  Q:'$D(^PRC(441,Z0,2,0))
 S DIC="^PRC(441,Z0,2,",DIC(0)="QEM" S:$G(PRCSIP) DIC("S")="I $O(^PRCP(445,PRCSIP,1,Z0,5,""B"",(+Y_"";PRC(440,""),0))" D ^DIC S DIC=DIE S:$D(ZD) D=ZD K ZD,DIC("S") Q
EXIT K %,DA,DIC,DIE,DR,PRCSL,T1,T2,X,Y Q
 ;
DMCHK(DA) ;check that RIL is not from DynaMed, set flag
 ;DA is RIL IEN in file 410.3
 ;
 N PRCVD,PRCVFG S (PRCVD,PRCVFG)=0
D1 S PRCVD=$O(^PRCS(410.3,DA,1,PRCVD)) G:+PRCVD=0 D2
 I $$GET1^DIQ(410.31,PRCVD_","_DA_",",6)'="" S PRCVFG=1 G D2
 G D1
D2 Q PRCVFG
 ;
