PRCFFUA ;WISC/SJG-ROUTINE TO PROCESS OBLIGATIONS CONT ;6/13/94  14:34
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Allows Fiscal to edit BOCs prior to PO amendment obligation
 ; only the BOCs on the amendment can be edited
 ;
OK ; Prompt user
 S DIR(0)="Y"
 S DIR("A")="Is the above BOC information correct",DIR("B")="YES"
 S DIR("?")="Enter 'NO' or 'N' to edit the BOCs on amended items."
 S DIR("?",1)="Enter '^' to exit this option."
 S DIR("?",2)="Enter 'YES' or 'Y' or 'RETURN' to continue processing this amendment."
 W ! D ^DIR K DIR
 Q
POAM ;
 D ARRAY^PRCFFUA4 I $D(ITRAY("NOITEMS")) D MSG9^PRCFFUA3 Q
 I FATAL=1 D MSG9^PRCFFUA3 Q
 N BOCEDIT,ESHEDIT
 D PROMPT Q:'Y!($D(DIRUT))
 K YY S YY=Y,YY(0)=Y(0)
 S (BOCEDIT,ESHEDIT)=0,FILE=$$FILE() D ROLLSET
 S PRCFA("BBFY")=$$BBFY^PRCFFU5(+PO) S Y=YY,Y(0)=YY(0) K YY
 Q:'Y!($D(DIRUT))
 I Y D
 .I $P(PCP,"^",2)=2 D MSG7^PRCFFUA3 Q
 .D:+$P(PCP,"^",2)<2 SAEDIT
 I (BOCEDIT=0)&(ESHEDIT=1) D ROLLSET,MSG1^PRCFFUA3,SF1^PRCFFUA1
 QUIT
ROLLSET ; Sets variable needed for amendment rollup
 S (DA,PRCHPO)=PRCFA("PODA"),PRCHTOTQ=$P(PO(0),U,15),PRCHAM=PRCFAA
 Q
 ;
SAEDIT ; BOC Edit
 D ESHEDIT S BOCEDIT=0
 W !! N MSG S MSG="...now editing the BOCs on the amendment..." D EN^DDIOL(MSG) W !
 I '$D(ITRAY("NOITEMS")) D ONEITEM
 I 'Y!($D(DIRUT)) D MSG6^PRCFFUA3 Q
 Q
ONEITEM ; Edit BOC for one item
 Q:$D(ITRAY("NOITEMS"))
 S BOCEDIT=0
 S DIC("A")="Select ITEM: ",DA(1)=PRCFA("PODA"),DIC="^PRC("_FILE_","_DA(1)_",2,",DIC(0)="AEQMZ" D ^DIC K DIC("A") S YY=Y
 I Y>0,$D(ITRAY("CANCEL",+Y)) W ! D EN^DDIOL("The Item Number selected by you has been cancelled and cannot be changed in the amendment!") W ! G ONEITEM
 I Y>0,'$D(ITRAY(+Y)) W ! D EN^DDIOL("The Item Number selected by you is not on this amendment!") W ! G ONEITEM
 I Y<0 S:X["^" PRCFOUT="" D ROLLSET S POX="^PRC("_FILE_","_PRCFA("PODA")_",0)" S PO(0)=@POX S %=$S($D(PRCFOUT):-1,1:1) Q
 S DA=+Y,DIE=DIC,DR=3.5,PRCHAMDA=23 D ^DIE S Y=YY,(BOCEDIT,FISCEDIT)=1
 I Y>0,$D(ITRAY(+Y))  D ROLLSET,MSG1^PRCFFUA3 D:FILE=442 SF1^PRCFFUA1 D:FILE=443.6 ^PRCHSF3
 S DIC("A")="Select Next ITEM: ",(D0,DA)=PRCFA("PODA") G ONEITEM
 ;
PROMPT ; Prompt for user
 S DIR(0)="Y",DIR("A")="Should the amendment BOC information be edited at this time",DIR("B")="NO"
 S DIR("?")="Enter 'NO' or 'N' or 'RETURN' if no editing is needed."
 S DIR("?",1)="Enter '^' to exit the option."
 S DIR("?",2)="Enter 'YES' or 'Y' to edit this information."
 W ! D ^DIR K DIR
 Q
ESHEDIT ; Edit Shipping BOC
 ; 13    - Estimated Shipping and/or Handling
 ; 13.05 - Estimated Shipping BOC
 S ESHEDIT=0 Q:'$D(ITRAY("ESH"))
 I $G(PRCTMP(FILE,+PO,13,"I"))="" Q
 I FILE=442,$G(PRCTMP(442,+PO,13.05,"I"))]"" D MSG10^PRCFFUA3,ESH1
 I FILE=443.6,$G(PRCTMP(443.6,+PO,13.05,"I"))]"" D ESH1
 K PRCTMP(442,+PO,13),PRCTMP(442,+PO,13.05),PRCTMP(443,6,+PO,13),PRCTMP(443.6,+PO,13.05)
 Q
ESH1 K MSG W !!
 S MSG(1)="...now editing Estimated Shipping BOC...",MSG(2)=" ",MSG(3)="The BOC for Estimated Shipping is '"_$G(PRCTMP(FILE,+PO,13.05,"E"))_"'."
 D EN^DDIOL(.MSG) K MSG
 S DIR(0)="Y",DIR("A")="Should I change the BOC for Estimated Shipping",DIR("B")="YES" W ! D ^DIR K DIR
 I 'Y!($D(DIRUT)) W ! D EN^DDIOL("No change made to Shipping BOC.") Q
 I Y D
 .W !
 .S DA=+PO,DIE=FILE,DR=13.05 D ^DIE K DIE,DR
 .S (ESHEDIT,FISCEDIT)=1
 .Q
 Q
FILE() ; Determine file for lookup/editing
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=0 S FILE=443.6
 I $D(PRCFA("RETRAN")),PRCFA("RETRAN")=1 S FILE=442
 Q FILE
KILL K AESHBOC,FILE,II,ITRAY,OESHBOC,POX
 Q
