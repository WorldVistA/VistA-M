PSDDWKE ;BIR/JPW-Pharm Dispensing Worksheet (cont'd) ; 24 Aug 93
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
EDIT ;ask/edit dispensing info
 W ! S (PSDOUT,MSG)=0
 K DA,DIE,DR,DTOUT,Y S DA=PSDN,DIE=58.85,DR="14T//^S X=PSDBYN;I $D(OKD) S Y=""@1"";1//^S X=ORDSN;@1" D ^DIE K DIE I $D(DTOUT) S PSDOUT=1 D MSG Q
 I $D(Y),ACT'="E" S PSDOUT=1 D MSG Q
 S ORDS=+$P($G(^PSD(58.85,PSDN,0)),"^",2),ORDSN=$P($G(^PSD(58.8,+ORDS,0)),"^"),NEW=$S(ORDS'=+PSDS:1,1:0)
 S QTY=$S($P($G(^PSD(58.85,PSDN,0)),"^",17):+$P($G(^(0)),"^",17),1:+$P($G(^(0)),"^",6))
 D:NEW SET I '$D(^PSD(58.8,+ORDS,1,+PSDR,0)) D MSG1 Q
 I 'NPKG!(NBKU']"") S MSG=1 D MSG1 Q
 I $D(Y),ACT="E" S PSDOUT=0 Q
 K DA,DIR,DIRUT,DTOUT,DUOUT,Y S DIR("B")=QTY,DIR(0)="58.85,18",DIR("A")="QUANTITY DISPENSED ("_NBKU_"/"_NPKG_")" D ^DIR K DIR I $D(DTOUT) S PSDOUT=1 D MSG Q
 I ACT'="E",$D(DIRUT) S PSDOUT=1 D MSG Q
 I 'Y!$D(DUOUT) S PSDOUT=0 Q
 S $P(^PSD(58.85,PSDN,0),"^",17)=Y
 I ACT="E" D DIE G EDIT1
 I 'NEW,PSDM D DIE
 I NEW,PSDMN D DIE
EDIT1 S QTY=+$P($G(^PSD(58.85,PSDN,0)),"^",17),STAT=+$P($G(^(0)),"^",7),PSDBY=+$P($G(^(0)),"^",13),PSDBYN="" S:PSDBY PSDBYN=$P($G(^VA(200,PSDBY,0)),"^")
 Q:ACT=""
 W !!,"Updating your order..."
 I $P($G(^PSD(58.85,PSDN,0)),"^",8) K DA,DIE,DR S DA=+$P(^(0),"^",8),DIE=58.81,DR="2////"_+ORDS_";5////"_QTY_";10////"_STAT_";12////"_MFG_";13////"_LOT_";14////"_EXP_";17////"_NAOU_";18////"_PSDBY D ^DIE K DA,DIE,DR
 W "still updating..."
 K DA,DIE,DR S DA=REQ,DA(1)=PSDR,DA(2)=NAOU,DIE="^PSD(58.8,"_DA(2)_",1,"_DA(1)_",3,"
 S DR="2////"_ORDS_";10////"_STAT_";19////"_QTY D ^DIE K DA,DIE,DR
 W "done.",!
 Q
DIE ;edit mfg/lot #/exp
 S Y=EXP X ^DD("DD") S EXPD=Y
 K DA,DIE,DR S DA=PSDN,DIE=58.85,DR="9//^S X=MFG;10//^S X=LOT;11//^S X=EXPD" D ^DIE K DA,DIE,DR
 K TMFG,TLOT,TEXP S:$P(^PSD(58.85,PSDN,0),"^",9)'=MFG TMFG=$P(^PSD(58.85,PSDN,0),"^",9) S:$P(^(0),"^",10)'=LOT TLOT=$P(^(0),"^",10) S:$P(^(0),"^",11)'=EXP TEXP=$P(^(0),"^",11)
 I $D(TMFG)!($D(TLOT))!($D(TEXP)) K DA,DIE,DR S DA=+PSDR,DA(1)=+ORDS,DIE="^PSD(58.8,"_DA(1)_",1,",DR="9////"_$S($D(TMFG):TMFG,1:MFG)_";10////"_$S($D(TLOT):TLOT,1:LOT)_";11////"_$S($D(TEXP):TEXP,1:EXP) D ^DIE K DA,DIE,DR,TEXP,TLOT,TMFG
 S MFG=$P(^PSD(58.85,PSDN,0),"^",9),LOT=$P(^(0),"^",10),EXP=$P(^(0),"^",11) S Y=EXP X ^DD("DD") S EXPD=Y
 Q
SET ;sets disp data if disp site changes
 S (MFG,LOT,EXP,NBKU,NPKG)=""
 S PSDMN=+$P($G(^PSD(58.8,+ORDS,0)),"^",5)
 S PSDAGN=+$P($G(^PSD(58.8,+ORDS,2)),"^"),PSDRGN=+$P($G(^(2)),"^",5),PSDGSN=+$P($G(^(2)),"^",6)
 I $D(^PSD(58.8,+ORDS,1,+PSDR,0)) S NBKU=$P(^(0),"^",8),NPKG=+$P(^(0),"^",9) S:PSDMN MFG=$P(^(0),"^",10),LOT=$P(^(0),"^",11),EXP=$P(^(0),"^",12)
 S PRT=$P($G(^PSD(58.85,PSDN,2)),"^") K ^PSD(58.85,"AW",+ORDS,+PRT,PSDN) S ^PSD(58.85,PSDN,2)=""
 Q
MSG1 W $C(7),!!,"This order cannot be processed.  ",PSDRN," is ",!,$S(MSG:"missing breakdown unit or package size",1:"not stocked")," in ",ORDSN,".",! S PSDNO=1
MSG W !!,"Press <RET> to continue" R X:DTIME W !!
 I '$T!(X["^") S PSDOUT=1
 Q
