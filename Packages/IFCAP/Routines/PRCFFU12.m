PRCFFU12 ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS CONT ;6/13/94  14:34
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Allows Fiscal to edit Cost Center and BOCs prior to PO obligation
PO ; PO Correction
 ; Fiscal cannot edit if FCP is a Special Fund Control Point (2)
 N CCEDIT,BOCEDIT,ESHEDIT D PROMPT
 S (CCEDIT,BOCEDIT,ESHEDIT)=0
 Q:'Y!($D(DIRUT))
 I Y D
 .I +$P(PCP,"^",2)=2 D MSG7 Q
 .I +$P(PCP,"^",2)<2!(+$P(PCP,"^",2)>2) D CCEDIT,SAEDIT
 I (CCEDIT=0)&(BOCEDIT=0)&(ESHEDIT=1) S PRCHPO=PRCFA("PODA") D MSG1,^PRCHSF
 QUIT
 ;
CCEDIT ; Cost Center edit
 S CCEDIT=0,OLDCC=$P(PO(0),U,5)
 W !! N MSG S MSG(1)="...now editing the Cost Center...",MSG(2)="" D EN^DDIOL(.MSG)
 S DA=PRCFA("PODA"),DR="2;",DIE="^PRC(442," D ^DIE K DIE,DR
 S NEWCC=X I OLDCC'=NEWCC S (FISCEDIT,CCEDIT)=1,PO(0)=^PRC(442,DA,0)
 Q
SAEDIT ; BOC Edit
 D ESHEDIT
 S BOCEDIT=0
 W !! N MSG S MSG(1)="...now editing the line item BOCs...",MSG(2)="" D EN^DDIOL(.MSG)
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to assign the same BOC to ALL items",DIR("B")="NO"
 D ^DIR K DIR W !!
 G:Y ALLITEMS
 K DIR S DIR(0)="Y",DIR("A")="Do you wish to edit specific line items",DIR("B")="YES"
 D ^DIR K DIR
 G:Y ONEITEM
 I 'Y!($D(DIRUT)) D MSG6 Q
 Q
ONEITEM ; Edit BOC for one item
 S BOCEDIT=0
 S DIC("A")="Select ITEM: ",DA(1)=PRCFA("PODA"),DIC="^PRC(442,"_DA(1)_",2,",DIC(0)="AEQMZ" D ^DIC K DIC("A")
 I Y<0 S:X["^" PRCFOUT="" S (PRCHPO,DA)=PRCFA("PODA"),(FISCEDIT,BOCEDIT)=1 D MSG1,^PRCHSF S PO(0)=^PRC(442,PRCFA("PODA"),0) S %=$S($D(PRCFOUT):-1,1:1) Q
 S DA=+Y,DIE=DIC,DR=3.5 D ^DIE S DIC("A")="Select Next ITEM: ",(D0,DA)=PRCFA("PODA") G ONEITEM
ALLITEMS ; Edit BOCs for all items
 S BOCEDIT=0
 S DIC=420.2,DIC(0)="AQEMNZ" D ^DIC I Y<0 D MSG6 Q
 S SA=+Y I $P(PO(0),"^",5)="" D MSG2 G OUT3^PRCFFMO1
 S SA=$P(Y(0),U) I '$D(^PRCD(420.1,$P(PO(0),"^",5),1,+SA)) W $C(7) D MSG3 G ALLITEMS
 I 'Y!($D(DIRUT)) W !! D MSG21 G OUT^PRCFFMO1
 D MSG4 I 'Y!($D(DIRUT)) D MSG6 Q
 D MSG5 S ITEM=0 F  S ITEM=$O(^PRC(442,PRCFA("PODA"),2,ITEM)) Q:'ITEM  D
 .S DA(1)=PRCFA("PODA"),DA=ITEM,DIE="^PRC(442,"_DA(1)_",2,",DR="3.5///^S X=SA" D ^DIE K DIE,DR
 K SA S (PRCHPO,DA)=PRCFA("PODA"),(FISCEDIT,BOCEDIT)=1 D MSG1,^PRCHSF S PO(0)=^PRC(442,PRCFA("PODA"),0)
 Q
PROMPT ; Prompt for user
 S DIR(0)="Y",DIR("A")="Should the Cost Center or BOC information be edited at this time",DIR("B")="NO"
 S DIR("?")="Enter 'NO' or 'N' or 'RETURN' if no editing is needed."
 S DIR("?",1)="Enter '^' to exit the option."
 S DIR("?",2)="Enter 'YES' or 'Y' to edit this information."
 W ! D ^DIR K DIR
 Q
ESHEDIT ; Edit Shipping BOC
 S ESHEDIT=0
 D GENDIQ^PRCFFU7(442,+PO,"13;13.05","IEN","")
 I $G(PRCTMP(442,+PO,13,"I"))="" Q
 I $G(PRCTMP(442,+PO,13,"I")) D
 .K MSG W !!
 .S MSG(1)="...now editing Estimated Shipping BOC...",MSG(2)=" ",MSG(3)="The BOC for Estimated Shipping is '"_$G(PRCTMP(442,+PO,13.05,"E"))_"'."
 .D EN^DDIOL(.MSG) K MSG
 .S DIR(0)="Y",DIR("A")="Should I change the BOC for Estimated Shipping",DIR("B")="YES" W ! D ^DIR K DIR
 .I 'Y!($D(DIRUT)) W ! D EN^DDIOL("No change made to Shipping BOC.") Q
 .I Y D
 ..W !
 ..S DA=+PO,DIE=442,DR=13.05 D ^DIE K DIE,DR
 ..S (ESHEDIT,FISCEDIT)=1
 ..Q
 .Q
 K PRCTMP(442,+PO,13),PRCTMP(442,+PO,13.05)
 Q
 ; Message processing
MSG1 K MSG W !! S MSG="...now recalculating FMS accounting lines..." D EN^DDIOL(MSG) K MSG W !
 Q
 ;
MSG2 K MSG W !! S MSG(1)="...Cost Center is missing - cannot continue..."
MSG21 S MSG(2)=" ",MSG(3)="No further action is being taken on this obligation."
 D EN^DDIOL(.MSG) K MSG W !
 Q
 ;
MSG3 K MSG W !! S MSG(1)="BOC '"_SA_"' is not valid with Cost Center "_$P(PO(0),U,5)_".",MSG(2)="Please ensure that this BOC is properly linked with the Cost Center."
 D EN^DDIOL(.MSG) K MSG W !
 Q
 ;
MSG4 W !! S DIR(0)="Y",DIR("A",1)="I will now enter BOC '"_SA_"' on all line items.",DIR("A")="Is this OK",DIR("B")="YES"
 D ^DIR K DIR
 Q
 ;
MSG5 K MSG W !! S MSG="...now changing the BOCs on all line items..."
 D EN^DDIOL(MSG) K MSG W !
 Q
MSG6 I (CCEDIT=1)!(BOCEDIT=1)!(ESHEDIT=1) Q
 K MSG W !!
 S MSG(1)="",MSG(2)=""
 S:CCEDIT=0 MSG(1)="Cost Center has not changed.",MSG(3)=" "
 S:BOCEDIT=0 MSG(2)="BOC has not changed.",MSG(4)=" "
 S MSG(5)="No further editing is being done on this obligation.",MSG(6)=" "
 S MSG(7)="Returning to the Obligation processing."
 D EN^DDIOL(.MSG) K MSG W !
 Q
MSG7 ;
 K MSG W !! S MSG(1)="Cost Center and BOCs cannot be edited for Supply Fund orders."
 S MSG(2)=" "
 S MSG(3)="Returning to the Obligation processing."
 D EN^DDIOL(.MSG) K MSG
 Q
