PRCIN07 ;SF/SWS-PREINSTALL *107 TO ADD 441.2 entry ;4-26-94/3:45 PM
V ;;5.1;IFCAP;**114**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
START ;Per VHA Directive 10-93-142, this routine should not be modified.
 N DIC,Y,NREC
 S DIC="^PRC(441.2,",X=4235
 D ^DIC
 I Y=-1 D
 .S (DIC,Y)=""
 .S DIC="^PRC(441.2,",X=4235,DIC(0)=""
 .D FILE^DICN
 .I Y'=-1  S MREC=+Y
 .S THISDESC="Hazardous Material Spill Containment and Clean-up Equipment and Material."
 .S THISDESC=THISDESC_"  Includes Secondary Spill Containment Sumps; Liquid Spill Containment Pallets; Spill Containment Basins; Spill Containment Systems; Absorbent, Sorbent and Blotting Materials."
 .S (DIC,Y)=""
 .S DIE="^PRC(441.2,",DA=MREC,DR="1///Hazardous Material Spill;2///^S X=THISDESC;3///42;4///General;5///DLA/DASS"
 .D ^DIE
 K DIC,Y,MREC,DA,X
 Q
