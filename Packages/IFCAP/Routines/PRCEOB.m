PRCEOB ;WISC/CLH/CTB-1358 OBLIGATION ; 15 Apr 93  1:02 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 K PRC,PRCF,Y
 S PRCF("X")="AB" D ^PRCFSITE Q:'%
 D LOOKUP G:Y<0 OUT K DIC,OB,DA,DIR,TRNODE,PCP,IOINHI,IOINLOW,IOINORM,X,PO,PODA,PRCHP,PATNUM,TR3,TR4,PO0,%,MSG S (OB,DA)=+Y
SC D NODE^PRCS58OB(DA,.TRNODE)
 S PRCFA("TRDA")=OB D SCREEN^PRCEOB1 W ! S DIR(0)="Y",DIR("A")="Is the above information correct",DIR("B")="YES",DIR("?")="'NO' will allow you to edit the information, '^' to Exit" D ^DIR G:$D(DIRUT) OUT
 K DIR G:$D(DIRUT) OUT I 'Y D OB^PRCS58OB(OB) G SC
 S PCP=$P(TRNODE(0),"-",4),PQT=$P(TRNODE(0),"-",3) D CPBAL^PRCFAC01 K PQT,PRCF("NOBAL") S DIR(0)="Y",DIR("A")="OK to continue",DIR("B")="YES" D ^DIR G:'Y!($D(DTOUT)) OUT
 K DA,X S PRCHP("T")=21,PRCHP("S")=4,PRCHP("A")="1358 Obligation Number",PRCFA(1358)="" D EN^PRCHPAT K PRCFA(1358),PRCHP I '$D(DA) S X="Unable to establish Obligation Number, processing has been terminated.*" D MSG^PRCFQ G OUT
 D OB1^PRCS58OB(OB,DA)
 D PAT^PRCH58OB(DA,.PODA,.PO,.PATNUM)
 D COB^PRCH58OB(PODA,.TRNODE,.PO,OB,X)
 N PRCFA,PRCFDEL,AMT,CS,DA,DIK,TIME
TT S PRCFA("REF")=$P($P(PO(0),"^"),"-",2),PRCFA("SYS")="CLM" S PRCFA("TT")="921.60" D TT^PRCFAC G:'% KILL
 I "921.00921.10921.24921.60921.71"'[PRCFA("TT") W " Invalid Transaction Type.Status Code selected. ",!?20,"921.00, 921.10, 921.24, 921.60 or 921.71 ONLY!",$C(7),! G TT
 D NEWCS^PRCFAC G:'$D(DA) KILL
 I PRCFA("EDIT")'["921.71" S DR=$S(PRCFA("EDIT")["921.60":"61",1:"7")_";8;9DELIVERY DATE~;S PRCFA(""DEL"")=Y",DIE="^PRCF(423," D ^DIE I $D(Y)'=0 G KILL
 S PRC("CP")=+$P(PO(0),"^",3) D ^PRCFALD S PRC("CP")=$P($P(PO(0),"^",3)," ")
 S CS=$S($D(^PRCF(423,PRCFA("CSDA"),1)):^(1),1:"") S $P(CS,"^")=PRCFA("YALD"),$P(CS,"^",5,7)=PRC("CP")_"^"_+$P(PO(0),"^",5)_"^^"
 S $P(CS,"^",8,11)=$P(PO(0),"^",6)_"^"_($P(PO(0),"^",7)*100)_"^"_$S($P(PO(0),"^",8)>0:$P(PO(0),"^",8),1:"$")_"^"_$S(+$P(PO(0),"^",9)'=0:$P(PO(0),"^",9)*100,1:""),$P(CS,"^",16)="$",^PRCF(423,PRCFA("CSDA"),1)=CS
 I PRCFA("EDIT")["921.71" S ^PRCF(423,PRCFA("CSDA"),13,0)="^423.11A^2^2" F I=1,2 S X=$S(I=1:6,1:8) S SA=+$P(PO(0),"^",X),AMT=$P(PO(0),"^",X+1)*100,^PRCF(423,PRCFA("CSDA"),13,I,0)=I_"^^^^^"_$S(SA>0:SA,1:"$")_"^^^"_$S(+AMT'=0:AMT,1:"")
 D @($S(PRCFA("EDIT")'["921.71":"^PRCFA921",1:"71^PRCFA921"))
 D ^PRCFACXM I $D(PRCFDEL)!($D(PRCFA("CSHOLD"))) S X="No further processing is being taken on this 1358.  It has NOT been obligated.  Entry in PO file is being deleted.*" D MSG^PRCFQ K PRCFDEL,PRCFA("CSHOLD") G KILL
 D WAIT^PRCFYN,POST G OUT:'%
 S X=100,DA=PRCFA("PODA") D ENF^PRCHSTAT
 S AMT=$P(^PRCF(423,PRCFA("CSDA"),1),"^",9)+$P(^(1),"^",11)*.01 D NOW^PRCFQ S TIME=X
 ;S X=$P(TRNODE(4),"^",8),DA=PRCFA("TRDA") D TRANK^PRCSES S X=$P(PRC("PER"),"^",2) D EN^PRCHUTL
 S X=$P(TRNODE(4),"^",8),DA=PRCFA("TRDA") D TRANK^PRCSES
 S DEL=$S('$D(DEL):"",1:DEL)
 W !,"Updating Code Sheet information",!
 D CS^PRCS58OB(OB,AMT,TIME,PATNUM,PODA,DEL,X,.PRC)
 W !,"Updating 1358 Obligation balances",!
 D BAL^PRCH58OB(PODA,AMT)
 S X=AMT D TRANS1^PRCSES
 S X=AMT D TRANS^PRCSES D BULLET^PRCEFIS1,OUT W !! G V
OUT K DTOUT,DIRUT,DUOUT,DIROUT,P,PRCB,PRCSCOST,PRCSN,PRCST,PRCST1,XMDUZ,XMSUB,XMTEXT,Y,Z
 Q
KILL D KILL^PRCH58OB(PODA) G OUT
 ;
LOOKUP ;Lookup 1358 transaction which is pending fiscal action.
 N DIC,FSO,TN
 S:'$D(TT) TT="O"
 S DIC=410,DIC(0)="AEMNZ",FSO=$O(^PRCD(442.3,"AC",10,0)),DIC("S")="S TN=^(0) I $P($P(TN,U),""-"",1,2)=PRCF(""SIFY""),TT[$P(TN,U,2),$P(TN,""^"",4)=1,$D(^(10)),$P(^(10),U,4)=FSO"
 D ^PRCSDIC
 Q
POST ;post data in file 424
 N X,Z,DAR,DIC,Y,DA,DIE,DR,TIME
 S (X,Z)=PATNUM,%=1 D EN1^PRCSUT3 I +$P(X,"-",3)>1 W $C(7),!,"This is not a new 1358.  Adjustments may only be entered through the",!,"adjustment option." H 3 S %=0 Q
 S DIC=424,DIC(0)="LX",DLAYGO=424 D ^DIC K DLAYGO I Y<0 W !,"ERROR IN CREATING 424 RECORD" S %=0 Q
 S DAR=+Y
 D NOW^%DTC S TIME=%,DIE=DIC,DA=DAR,X=PODA,DR=".02////^S X=PODA;.03////^S X=""O"";.06////^S X=$P(PO(0),U,11);.07////^S X=TIME;.08////^S X=DUZ;1.1///^S X=""INITIAL OBLIGATION"";.15////^S X=OB"
 D ^DIE S %=1
 Q
