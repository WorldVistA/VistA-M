PSDREC ;BIR/LTL-CS Receiving ; 6 July 94
 ;;3.0; CONTROLLED SUBSTANCES ;**69**;13 Feb 97;Build 13
 ;References to ^PSD(58.8, covered by DBIA2711
 ;References to file 58.81 covered by DBIA #2808
 ;References to ^PRC(442, covered by DBIA#682
 ;
 I '$D(PSDSITE) D ^PSDSET G:'$D(PSDSITE) QUIT
 I '$D(^XUSEC("PSJ RPHARM",DUZ)),'$D(^XUSEC("PSD TECH ADV",DUZ)) W !!,"Sorry, you need either the PSJ RPHARM or PSD TECH ADV Security key",!,"to do receiving.",!! G QUIT
 I $P($G(^VA(200,DUZ,20)),U,4)']"" N XQH S XQH="PSD ESIG" D EN^XQH G QUIT
SETUP D DT^DICRW N C,D,D0,DA,DIC,DINUM,DIE,DIR,DIRUT,DLAYGO,DR,DTOUT,DUOUT,DZ,PSDAT,PSDB,PSDI,PSDIT,PSDW,PSDLOC,PSDLOCN,PSDOUT,PSDP,PSDPI,PSDS,PSDCON,PSDL,PSDPO,PSDREC,PSDRUG,PSDRUGN,PSDT,PSAPV,X,Y,%,%H,%I S PSDL=0,(PSDI,PSDPO)=""
 D NOW^%DTC S PSDAT=+$E(%,1,12)
 S PSDLOC=$P(PSDSITE,U,3),PSDLOCN=$P(PSDSITE,U,4)
 G:$P(PSDSITE,U,5) CHKD
LOOK S DIC="^PSD(58.8,",DIC(0)="AEQ",DIC("A")="Select Dispensing Site: "
 S DIC("S")="I $P($G(^(0)),U,3)=+PSDSITE,$P($G(^(0)),U,2)[""M""&($S('$D(^(""I"")):1,+^(""I"")>DT:1,'^(""I""):1,1:0))"
 S:$P($G(^PSD(58.8,+PSDLOC,0)),U,2)["M" DIC("B")=PSDLOCN
 D ^DIC K DIC G:Y<0 QUIT S PSDLOC=+Y,PSDLOCN=$P(Y,U,2)
 S $P(PSDSITE,U,3)=+Y,$P(PSDSITE,U,4)=$P(Y,U,2)
CHKD D:$P($G(^PSD(58.8,PSDLOC,0)),U,8)=1  G:$D(DIRUT) QUIT
PV .W ! S DIR(0)="Y",DIR("A")="Is this a Prime Vendor receipt",DIR("B")="Yes",DIR("?")="If so, I'll retrieve the current Prime Vendor P.O.# for this Dispensing Site." D ^DIR K DIR Q:$D(DIRUT)!(Y<1)  S:Y=1 PSAPV=1
 .S (PSDPO,Y)=$P($G(^PSD(58.8,+PSDLOC,0)),U,9),C=$P(^DD(58.8,13,0),U,2)
 .D Y^DIQ S DIC("B")=Y
 .I +$E($P($G(^PRC(442,+PSDPO,12)),U,5),4,5)'=+$E(DT,4,5) W !!,"Current Prime Vendor P.O.#: ",Y,?40 S Y=$P($G(^(12)),U,5) X ^DD("DD") W "Date Assigned: ",Y
 I '$O(^PSD(58.8,PSDLOC,1,0)) W !!,"There are no drugs in ",PSDLOCN G QUIT
PO W ! S DIC="^PRC(442,",DIC(0)="AEMQZ" S:'$G(DIC("B")) DIC("B")=$G(PSDPO)
 S DIC("A")="Select Pharmacy Purchase Order Number: ",DIC("S")="I $P($G(^(0)),U,5)[822400" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT)) QUIT S:Y>0 PSDPO=+Y I Y<1 S PSDPO(1)=0 G ^PSDREC2
 S PSDCON=$P($G(Y(0)),U,12)
 I $G(PSAPV),PSDPO'=$P($G(^PSD(58.8,+PSDLOC,0)),U,9) S DIE="^PSD(58.8,",DA=PSDLOC,DR="13////"_PSDPO D ^DIE K DIE,DA,DR
LINE I '$O(^PRC(442,+PSDPO,2,0)) W !!,"No line items on this P.O.",!! S PSDPO(1)=0 G ^PSDREC2
 I '$O(^PRC(442,+PSDPO,2,1)),'$P($G(^PRC(442,+PSDPO,2,1,0)),U,5) S PSDPO(1)=0 G ^PSDREC2
PART I '$O(^PRC(442,+PSDPO,11,0)) W !!,"No receipts processed for this P.O.",!! S PSDPO(1)=0 G ^PSDREC2
PRE I $O(^PSD(58.81,"C",PSDPO,"")) W !!,"Previous receipts have been processed for this P.O.",! S DIR(0)="Y",DIR("A")="Would you like to review them before proceeding",DIR("B")="Yes" D ^DIR K DIR G:$D(DIRUT) QUIT G:Y=1 DEV^PSDREV
CHO S DIR(0)="Y",DIR("A")="Loop through all items for a selected receipt",DIR("B")="Yes",DIR("?")="If not, I will ask you to select the item(s) to receive."
 S DIR("??")="^W !!,""If you plan on receiving only certain items, you may prefer NOT to loop."""
 W ! D ^DIR K DIR
 Q:$D(DIRUT)  G:'Y ^PSDREC3
 S PSDPI=$O(^PRC(442,+PSDPO,11,0)),PSDP=$P($G(^PRC(442,+PSDPO,11,+PSDPI,0)),U),Y=1 D:$O(^PRC(442,+PSDPO,11,PSDPI))
PSEL .S DIC="^PRC(442,+PSDPO,11,",DA(1)=PSDPO,DIC(0)="AEMQ",DIC("A")="Please select Warehouse receipt date: ",DIC("B")=$P($G(^PRC(442,+PSDPO,11,+$P($G(^PRC(442,+PSDPO,11,0)),U,3),0)),U),D="B",DZ="??" D DQ^DICQ
 .W ! D ^DIC K DIC S PSDPI=+Y,PSDP=$P(Y,U,2)
 D:Y>0 ^PSDREC1 S PSDPO="" G PO
QUIT Q
