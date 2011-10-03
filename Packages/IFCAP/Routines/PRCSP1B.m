PRCSP1B ;WISC/SAW-CONTROL POINT ACTIVITY ;10-11-91/10:24
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
PROJ ;PROJECT NUMBER REPORT
 D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S PRCSAZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S L=0,DIC="^PRCS(410,",FLDS="[PRCSPROJ]",DHD="SORT GROUP REPORT - CP: "_PRC("CP"),BY="+49;S1,.01",FR="?,"_PRCSAZ_"-0001",TO="?,"_PRCSAZ_"-9999"
 D EN1^DIP K L,DIC,FLDS,DHD,BY,FR,TO,PRC("CP"),PRCSAZ Q
TEMPT ;LIST OF TEMPORARY TRANSACTIONS
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S L=0,DIC="^PRCS(410,",FLDS="[PRCSTEMPT]",DHD="TEMPORARY TRANSACTION LISTING - CONTROL POINT "_PRC("CP"),BY="15,5",(FR,TO)=PRC("CP")_",?"
 S DIS(0)="I $D(^PRCS(410,D0,0)),$P(^(0),U,1)=$P(^(0),U,3),$P(^(0),U,5)=PRC(""SITE"")"
 D EN1^DIP K BY,DIC,DIS,FLDS,FR,L,TO Q
SUBCP ;SUB-CONTROL POINT REPORT
 W !,"Would you like the report printed for a full Fiscal Year"
 S %=1 D ^PRCFYN G EXIT:%<0 G S2:%=1
S1 D EN1^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 G:'$D(PRC("CP")) EXIT
 S PRCSAZ=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ")
 S DIC="^PRCS(410,",DHD="SUB-CONTROL POINT EXPENDITURES - "_PRC("CP")_" for FY-Q: "_PRC("FY")_"-"_PRC("QTR")
 S FLDS="[PRCSSBCPT]",BY="16,+.01;S1,@.01",FR="?,"_PRCSAZ_"-0001"
 S TO="?,"_PRCSAZ_"-9999",L=0 D EN1^DIP
 K DIS(0),PRC("SCP"),PRC("CP"),PRC("QTR"),PRC("FY"),PRCS(1) G SUBCP
S2 D STA^PRCSUT G W2:'$D(PRC("SITE")) D FY^PRCSUT Q:'$D(PRC("FY"))  Q:PRC("FY")="^"  G EXIT:Y<0 D CP^PRCSUT
 G EXIT:Y<0 ;S DIC="^PRCS(410.4,",DIC(0)="AEMQ" D ^DIC G S2:Y<0
 S DIC="^PRCS(410," S DHD="SUB-CONTROL POINT EXPENDITURES - "_PRC("CP"),FLDS="[PRCSSBCPT1]"
 S BY="16,+.01;S1,@.01",FR="?,"_PRC("SITE")_"-"_PRC("FY")_"-1-"_$P(PRC("CP")," ")_"-0001",TO="?,"_PRC("SITE")_"-"_PRC("FY")_"-4-"_$P(PRC("CP")," ")_"-9999",L=0
 S DIS(0)="I $D(^PRCS(410,D0,0)),$P(^(0),""-"",4)=$P(PRC(""CP""),"" "")"
 D EN1^DIP K DIS(0),PRC("CP"),PRC("FY"),PRCS(1) G EXIT
POS ;PURCHASE ORDER STATUS
 D EN3^PRCSUT G W2:'$D(PRC("SITE")),EXIT:Y<0
 S DIC="^PRC(442,",DIC(0)="AEQM",DIC("A")="Select PURCHASE ORDER NUMBER: ",DIC("S")="I +^(0)=PRC(""SITE""),+$P(^(0),""^"",3)=+PRC(""CP"")" D ^DIC G EXIT:Y<0 K DIC S D0=+Y,X=$S($D(^PRC(442,+Y,7)):+^(7),1:0)
 S X=$S($D(^PRCD(442.3,X,0)):^(0),1:"UNKNOWN") W !!,"Purchase Order Status: ",$P(X,"^") I $P(X,"^",2)<10 D EXIT G POS
POS1 W !!,"Would you like the purchase order display" S %=2 D YN^DICN G POS1:%=0 G:%=2 POS2 D:%=1 ^PRCHDP1 I %=-1 D EXIT,W1 Q:$D(PRCSX)  G POS
POS2 W !!,"Would you like to review the entire purchase order" S %=2 D YN^DICN G POS2:%=0 I %'=1 D EXIT,W1 Q:$D(PRCSX)  G POS
 S PRCHQ="^PRCHFPNT",PRCHQ("DEST")="US" D ^PRCHQUE K IOP D EXIT,W1 K ZTSK Q:$D(PRCSX)  G POS
S S L=0,DIC="^PRCS(410,"
 D EN1^DIP Q
DEV K IO("Q") S %ZIS("B")="HOME",%ZIS="MQ" D ^%ZIS Q
W1 W !!,"Enter information for another report or an uparrow to return to the menu.",! Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official." R X:5 G EXIT
NONE W !!,"A status has not yet been reported for this purchase order." G EXIT
W I (IO=IO(0))&('$D(ZTQUEUED)) W !!,"Press return to continue:  " R X:DTIME
 I (IO'=IO(0))!($D(ZTQUEUED)) D ^%ZISC U IO(0)
EXIT K %,%DT,BY,C,C0,C2,C3,D,DA,DHD,DIC,DIE,PRCS,FLDS,FR,I,L,N,TO,X,Y,Z,Z1,ZTRTN,ZTSAVE Q
