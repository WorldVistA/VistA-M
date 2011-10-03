PRCSED ;WISC/SAW-CONTROL POINT ACTIVITY EDITS CON'T ;10-30-91/11:32
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
REP ;ENTER REP REQUEST
 D EN^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 D EN1^PRCSUT3 G:'X EXIT S X1=X D EN2^PRCSUT3 G:'$D(X1) EXIT S X=X1 D W L +^PRCS(410,DA):15 G REP:$T=0 S DIC(0)="AEMQ",DIE=DIC,DR="3///3",X4=3 D ^DIE
 S T1=DA,(PRCSDR,DR)="[PRCSENPR]"
R1 K DTOUT,DUOUT,Y D ^DIE I $D(Y)!($D(DTOUT)) S DA=T1 L -^PRCS(410,DA) G EXIT
 S DA=T1 D RL^PRCSUT1 L -^PRCS(410,DA)
 D ^PRCSCK I $D(PRCSERR),PRCSERR G R1
 D W1^PRCSEB,W3 G EXIT:%'=1 W !! G REP
NREP ;ENTER NON-REP REQUEST
 D EN^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 D EN1^PRCSUT3 Q:'X  S X1=X D EN2^PRCSUT3 Q:'$D(X1)  S X=X1 D W L +^PRCS(410,DA):15 G NREP:$T=0 S DIC(0)="AEMQ",DIE=DIC,DR="3///2",X4=2 D ^DIE
 S T1=DA,(PRCSDR,DR)="[PRCSEN2237B]"
N1 K DTOUT,DUOUT,Y D ^DIE I $D(Y)!($D(DTOUT)) S DA=T1 L -^PRCS(410,DA) G EXIT
 S DA=T1 D RL^PRCSUT1
 D ^PRCSCK I $D(PRCSERR),PRCSERR G N1
 D W1^PRCSEB L -^PRCS(410,DA) D W3 G EXIT:%'=1 W !! G NREP
 ;
 ;P182 -- Deleted R1358 SUBROUTINE (not called from anywhere)
 ;
ACSCP ;ASSIGN CEILING TO SCP'S
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRCS(410,",DIE=DIC,DIC(0)="AEQM",DIC("S")="I $D(^(3)),+^(3)=+PRC(""CP""),$P(^(0),""^"",5)=PRC(""SITE""),$P(^(0),""^"",2)=""C"" I $D(^PRC(420,""A"",DUZ,PRC(""SITE""),+PRC(""CP""),1))!($D(^(2)))"
 S DIC("A")="Select CEILING TRANSACTION NUMBER: " D ^PRCSDIC G EXIT:Y<0 K DIC("S"),DIC("A") S DA=+Y L +^PRCS(410,DA):15 G ACSCP:$T=0
ACSCP1 S DR="[PRCSENE]",DIE=DIC D ^DIE
 S PRCST=$S($D(^PRCS(410,DA,4)):$P(^(4),"^",8),1:"")
 S (PRCS,PRCS(1))=0 F I=0:0 S PRCS=$O(^PRCS(410,DA,12,PRCS)) Q:PRCS'>0  S PRCS(1)=PRCS(1)+$P(^(PRCS,0),"^",2)
 I PRCS(1)>PRCST D ACSCP4 W !!,"You have assigned $ ",$J(PRCS(1),0,2)," to your sub-control points.",!,"This is $ ",$J((PRCS(1)-PRCST),0,2)," more than the total ceiling available."
 I PRCS(1)>PRCST W !,"Please re-edit your entries and make the necessary corrections." G ACSCP1
ACSCP2 I PRCST>PRCS(1) D ACSCP4 W !!,"You still have $ ",$J((PRCST-PRCS(1)),0,2)," available that could be assigned to your",!,"sub-control points."
 I PRCST>PRCS(1) W "  Do you want to re-edit your entries" S %=1 D YN^DICN G ACSCP2:%=0,ACSCP1:%=1
 L -^PRCS(410,DA)
ACSCP3 W !!,"Would you like to assign ceiling to sub-control points from another",!,"ceiling transaction" S %=2 D YN^DICN G ACSCP3:%=0,ACSCP:%=1,EXIT
ACSCP4 W !!,"The transaction $ amount is $ ",$S(PRCST:$J(PRCST,0,2),1:"0.00"),"." Q
SCPC ;CHECK $AMT ASSIGNED TO SCP FOR ADJ AND OBL TRANS
 S DR="[PRCSENE]",(DIC,DIE)="^PRCS(410," D ^DIE
SCPC0 S (PRCS,PRCS(1))=0 F I=0:0 S PRCS=$O(^PRCS(410,DA,12,PRCS)) Q:PRCS'>0  S PRCS(1)=PRCS(1)+$P(^(PRCS,0),"^",2)
 S (PRCST(1),PRCS(2))=0,PRCST=$S($D(^PRCS(410,DA,4)):$P(^(4),"^",8),1:"") ;I $D(^PRCS(410,DA,0)) I $P(^(0),U,2)="A" S PRCST=$P(^(4),U,6)
 S PRCS(2)=PRCS(1),PRCST(1)=PRCST S:PRCS(1)["-"&(PRCST(1)["-") PRCS(2)=-PRCS(1),PRCST(1)=-PRCST
 I PRCS(2)>PRCST(1) D SCPC2 W !!,"You have assigned $",$J(PRCS(1),0,2)," to your sub-control points.",!,"This is $",$J((PRCS(1)-PRCST),0,2)," more than the total available."
 I PRCS(2)>PRCST(1) W !,"Please re-edit your entries and make the necessary corrections." G SCPC
SCPC1 I PRCST(1)>PRCS(2) D SCPC2 W !!,"You still have $ ",$J((PRCST-PRCS(1)),0,2)," available that could be assigned to your",!,"sub-control points."
 I PRCST(1)>PRCS(2) W "  Do you want to re-edit your entries" S %=1 D YN^DICN G SCPC1:%=0,SCPC:%=1
 G EXIT
SCPC2 W !!,"The transaction $ amount is $ ",$S(PRCST:$J(PRCST,0,2),1:"0.00"),"." Q
W W !!,"This transaction is assigned transaction number: ",X Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
W3 W !!,"Would you like to enter another request" S %=1 D YN^DICN G W3:%=0 Q
EXIT K %,DIC,DIE,DR,PRCSL,PRCST,T1,X,X1,X4 Q
