DENTOP ; HISC/NCA - Post-Init to Add Options ;6/17/96  15:36
 ;;1.2;DENTAL;**21**;AUG 15, 1996
 ; Add Dental Options to Menu
 W !!,"Add Dental Options to Dental Menu..."
 S X=" ;;DENT PROGMAN;DENTPURGE;12" D AD2
 S X=" ;;DENTACTMANAGER;DENTBATCH;10" D AD2
 S X=" ;;DENTACTUSER;DENTBATCH;9" D AD2
KIL K ACT,DA,DENTX,DENTX1,DENTXA,DIC,DIE,DIK,DLAYGO,DR,LL,NAM,PKG,TXT,TYP,X,Y
 Q
AD2 ; Add Dental Options to Dental Menus
 S DA(1)=$O(^DIC(19,"B",$P(X,";",3),0)) I 'DA(1) K DA Q
 K DIC S:'$D(^DIC(19,DA(1),10,0)) ^(0)="^19.01IP^^"
 S DENTX=$O(^DIC(19,"B",$P(X,";",4),0)) I 'DENTX Q
 S DENTXA=$O(^DIC(19,DA(1),10,"B",DENTX,0)) I DENTXA Q
 S DENTX1=$P(X,";",5)
 S DIC("DR")="2///"_DENTX1
 S DIC="^DIC(19,"_DA(1)_",10,",DIC(0)="L",DLAYGO=19,X=$P(X,";",4) D ^DIC
 I $P(Y,"^",3) W !?2,X," added as item to ",$P(^DIC(19,DA(1),0),"^",1),"."
 K DA,DIC
 Q
