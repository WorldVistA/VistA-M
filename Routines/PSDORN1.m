PSDORN1 ;BIR/JPW,LTL-Nurse CS Order Entry (cont'd) ;12/14/99  16:09
 ;;3.0; CONTROLLED SUBSTANCES ;**20,66**;13 Feb 97;Build 3
 ;
 ; Reference to DPT( supported by DBIA # 10035
 ; Reference to PSD(58.8 supported by DBIA # 2711
 ; Reference to VA(200 supported by DBIA # 10060
 ; Line tag SIG^XUSESIG supported by DBIA # 10050
 ;
 I $D(ORD) F CNT1=1:1:CNT S PSDA=+ORD(CNT1) D ASK
 Q
ASK ;displays order for review
 D DISPLAY
 W !! K DA,DIR,DIRUT S DIR(0)="Y",DIR("B")="YES",DIR("A")="Is this OK",DIR("?",1)="Answer 'YES' to send this request to pharmacy for processing,"
 S DIR("?",2)="or 'NO' to edit or delete this request",DIR("?")="or '^' to quit and DELETE this CS order request." D ^DIR K DIR
 I $D(DIRUT) S PSDOUT=1 D DEL Q
 I 'Y D EDIT Q:PSDOUT  G ASK
 I Y N X,X1 D SIG^XUSESIG S:X1="" PSDOUT=1 D:X1="" DEL Q:X1=""  D
 .D PHARM W !! W:$D(ORD) "Your order request #"_CNT1_" of "_CNT
 .W ?32,"Sent to Pharmacy...",!!
 .R:$D(ORD) "Press <RET> to continue",X:DTIME,!!
 Q
DISPLAY ;displays order request to screen
 K LN S $P(LN,"-",80)=""
 W @IOF,!,?17,"Controlled Substance "
 W:$G(PSDEM) "*PRIORITY PICK UP* "
 W "Order Request" I $D(ORD) W " # "_CNT1_" of "_CNT
 W:$G(PAT) !!,"Patient:  ",$P($G(^DPT(PAT,0)),U),!!
 W !!,"Pharmacy Dispensing #: ",!
 W "Requested by",?16,": ",$P($G(^VA(200,PSDUZ,0)),"^")
 W ?51,$S($G(PSDT(9))]"":"Needed by: "_PSDT(9),1:"Request Date: "_REQD),!,LN,!
 W !,"Drug",?16,": ",PSDRN,?56,"Quantity: ",?66,PSDQTY,!,"Dispensed by",?16,": N/A",?50,"Dispensed Date: N/A"
 W !,"Disp. Location",?16,": " W:+PSDS $P($G(^PSD(58.8,+PSDS,0)),"^") W !,"Exp. Date",?16,": ",!,"Manufacturer",?16,": ",!,"Lot #",?16,": "
 W !,"Ord. Location",?16,": ",NAOUN,!,"Order Status",?16,": ",$P($G(^PSD(58.82,1,0)),"^"),!,"Comments:"
 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,0)) K ^UTILITY($J,"W") F TEXT=0:0 S TEXT=$O(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,TEXT)) Q:'TEXT  D
 .S X=$G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,TEXT,0)),DIWL=5,DIWR=75,DIWF="W" D ^DIWP
 I  D ^DIWW
 Q
EDIT ;edit or delete order request
 W !!,"Edit or Delete this Order Request:  EDIT//  " R X:DTIME I '$T S PSDOUT=1 D DEL Q
 Q:X["^"  S X=$E(X) S:X="" X="E" I "EeDd"'[X W !!,"Press <RET> to edit this order request, or enter 'D' to delete the request.",! G EDIT
 I "Dd"[X D DEL Q
 K DA,DIE,DR S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_NAOU_",1,"_PSDR_",3,",DR="13" D ^DIE K DIE,DR
 Q
DEL ;deletes order request
 S PSDOUT=1 W !!,?25,"Request being deleted...",! K DIK S DA=PSDA,DA(1)=PSDR,DA(2)=NAOU,DIK="^PSD(58.8,"_NAOU_",1,"_PSDR_",3," D ^DIK K DIK
 Q
PHARM ;create worksheet entry in file 58.85
 I $D(XRTL) D T0^%ZOSV
 W ?5,!!,"Processing your request now..." F  L +^PSD(58.85,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
ADD S PSDREC=$P(^PSD(58.85,0),"^",3)+1 I $D(^PSD(58.85,PSDREC)) S $P(^PSD(58.85,0),"^",3)=PSDREC G ADD
 K DA,DIC,DIE,DLAYGO,DR S (DIC,DIE,DLAYGO)=58.85,DIC(0)="L",X=PSDREC D ^DIC K DIC,DLAYGO
 L -^PSD(58.85,0)
 S PSDRD=$S($P($G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,0)),"^",2):$P(^(0),"^",2),1:DT)
 S DA=PSDREC,DR="1////"_+PSDS_";2////"_NAOU_";3////"_PSDR_";4////"_PSDA_";5////"_PSDQTY_";6////1;12////"_PSDUZ_";19////"_PSDRD_";21////"_$P($G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,2)),U,2)_";22////"_$G(PAT) D ^DIE K DIE
 I $D(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,0)) S ^PSD(58.85,PSDREC,1,0)=^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,0) D
 .F WORD=0:0 S WORD=$O(^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,WORD)) Q:'WORD  S ^PSD(58.85,PSDREC,1,WORD,0)=^PSD(58.8,NAOU,1,PSDR,3,PSDA,1,WORD,0)
 K DA,DIC,DIE,DLAYGO,DR,WORD
 I $D(XRT0) S XRTN=$T(+0) D T1^%ZOSV
 D:$P($G(^PSD(58.8,NAOU,1,PSDR,3,PSDA,2)),U,2) ^PSDORNP K PSDREC,PSDT(9)
 Q
