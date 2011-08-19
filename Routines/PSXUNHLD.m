PSXUNHLD ;BIR/WPB-Routine to Remove a Transmission from Hold Status ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
EN I '$D(^XUSEC("PSXCMOPMGR",DUZ)) W !,"You are not authorized to use this option!" Q
 I $P($G(^PSX(553,1,"S")),"^",1)="R" W !,"The interface is running.  Wait until the interface is stopped." Q
 S DIC=552.1,DIC(0)="AQMEZ"
 S DIC("S")="I $D(^PSX(552.1,""AH"",$P(^PSX(552.1,+Y,0),U,1),+Y)),($D(^PSX(552.1,+Y,2)))" D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!($G(Y)'>0) EXIT S BAT=+Y
 K Y,X
 S OBAT=$P($G(^PSX(552.1,BAT,2)),"^",2),OREC=$O(^PSX(552.1,"B",OBAT,""))
 I $G(OREC)="" W !,"The original transmission was not received.",! S DIR(0)="Y",DIR("A")="Do you wish to continue",DIR("B")="NO" D ^DIR K DIR G:Y<1!($D(DIRUT)) EXIT G EN1
 S OLDSTAT=$P(^PSX(552.1,OREC,0),"^",2)
 ; mods for new unhold to delete retrans if original is processed
 I "7"[$G(OLDSTAT) W !!,"The original transmission, ",OBAT," is downloading to the automated",!,"vendor system.",!,"Transmission, ",$P(^PSX(552.1,BAT,0),"^",1)," is a retransmission of ",OBAT," and can not be queued." G EXIT
 I "346"[$G(OLDSTAT) D COM,EN2 G EXIT
EN1 W !!
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="UNHOLD",DIR("?")="Changing the status of this retransmission will allow the data to go to the automated vendor system for filling." D ^DIR K DIR G:$G(Y)=0!($D(DIRUT)) EXIT K Y,X
EN2 G:$G(OREC)="" RST
 S O1=$P(^PSX(552.1,OREC,1),"^",1),O2=$P(^PSX(552.1,OREC,1),"^",2)
 I $G(O1)'="" S DIK="^PSX(552.2," F J=O1:1:O2 S MSG=OBAT_"-"_J,REC=$O(^PSX(552.2,"B",MSG,"")) Q:$G(REC)=""  S DA=REC D ^DIK K REC,DA,MSG
 K DIK
 S P5524=$O(^PSX(552.4,"B",OREC,"")) Q:$G(P5524)'>0  S DIK="^PSX(552.4,",DA=P5524 D ^DIK K DA,DIK,P5524
 K ^PSX(552.1,OREC,"S") S DA=OREC,DIE="^PSX(552.1,",COM="Filled under "_$P(^PSX(552.1,BAT,0),"^",1),DR="1////4;15///"_COM D ^DIE K DIE,DA,COM,DR
RST Q:$G(TMP)>0
 S DA=BAT,DIE="^PSX(552.1,",DR="1////2" D ^DIE K DIE,DR,DA
 S DIK="^PSX(552.1,",DA=BAT D IX^DIK K DA,DIK
 W !!,"Transmission ",$P(^PSX(552.1,BAT,0),"^")," is queued to download to the automated vendor system."
EXIT K Y,X,DIR,DIC,TMP,DTOUT,DIROUT,DUOUT,DIRUT,BAT,OBAT,OLDSTAT,OREC,J,MSG,O1,O2
 Q
COM W !!,"The original transmission, ",OBAT," has already been sent to the automated",!,"vendor system.",!,"Transmission, ",$P(^PSX(552.1,BAT,0),"^",1)," is a retransmission of ",OBAT," and can not be queued."
 S TMP=OREC,OREC=BAT,BAT=TMP,OBAT=$P(^PSX(552.1,OREC,0),"^")
 Q
