PRCIN116 ;RB-PREINSTALL PRC*116 TO ADD 441.2 entry ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**116**;Oct 20, 2000;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
START ;Adding FSC code 5331  O-RINGS
 N DIC,Y,MREC,IEN S IEN=0
 S IEN=$O(^PRC(441.2,"B",4235,IEN))
 I IEN S DA=IEN,DIK="^PRC(441.2," D ^DIK K DA,DIK
 S IEN=0,IEN=$O(^PRC(441.2,"B",5331,IEN))
 I IEN S DA=IEN,DIK="^PRC(441.2," D ^DIK K DA,DIK
A S DIC="^PRC(441.2,",X=5331
 D ^DIC
 I Y=-1 D
 .S (DIC,Y)=""
 .S DIC="^PRC(441.2,",X=5331,DIC(0)="",(DA,DINUM)=5331,DLAYGO=441.2,DIC(0)="FLZ"
 .D FILE^DICN
 .I Y'=-1  S MREC=+Y
 .S THISDESC="Excludes Packing and Gasket Material (FSC5330)"
 .S (DIC,Y)=""
 .S DIE="^PRC(441.2,",DA=MREC,DR="1///O-RINGS;2///^S X=THISDESC;3///53;4///General;5///DLA/DASS"
 .D ^DIE
 N DIC,Y,MREC	
B S DIC="^PRC(441.2,",X=4235
 D ^DIC
 I Y=-1 D
 .S (DIC,Y)=""
 .S DIC="^PRC(441.2,",X=4235,DIC(0)="",(DA,DINUM)=4235,DLAYGO=441.2,DIC(0)="FLZ"
 .D FILE^DICN
 .I Y'=-1  S MREC=+Y
 .S THISDESC="Hazardous Material Spill Containment and Clean-up Equipment and Material."
 .S THISDESC=THISDESC_"  Includes Secondary Spill Containment Sumps; Liquid Spill Containment Pallets; Spill Containment Basins; Spill Containment Systems; Absorbent, Sorbent and Blotting Materials."
 .S (DIC,Y)=""
 .S DIE="^PRC(441.2,",DA=MREC,DR="1///Hazardous Material Spill;2///^S X=THISDESC;3///42;4///General;5///DLA/DASS"
 .D ^DIE
 K DIC,DIE,Y,DLAYGO,MREC,DA,X,DINUM
 Q
