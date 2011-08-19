DVBHDEL ;ALB/JLU - Deletetion routine for HINQ suspence file
 ;;V4.0;HINQ;;03/25/92 
 ;
EN ;entry point to this routine.
 W !,"This option will delete an entry from the HINQ suspense file.",!
 S DIC="^DVB(395.5,",DIC(0)="AEMQ"
 F  D ^DIC Q:Y'>0  D:+Y DEL
EX K DIC,Y,DIK,DA,DVBT,%
 Q
 ;
DEL S (DVBT,DA)=+Y,DIK="^DVB(395.5,"
ASK W !!,"Is this the entry you want deleted? ",$P(^DPT(DVBT,0),U)
 S %=2
 D YN^DICN Q:%=2!(%=-1)
 I %=0 W !!,"Yes to delete the entry or No to leave it in the suspense file." G ASK
 D ^DIK
 W !!,"Deletion completed on ",$P(^DPT(DVBT,0),U),!
 Q
