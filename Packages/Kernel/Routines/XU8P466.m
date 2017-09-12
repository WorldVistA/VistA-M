XU8P466 ;ISF/RWF - PATCH 466 POST INIT ;06/04/2008
 ;;8.0;KERNEL;**466**;Jul 10, 1995;Build 9
 Q
 ;
POST ;Post-init
 Q:$$PATCH^XPDUTL("XU*8.0*466")
 D BMES^XPDUTL(" Post-Init is removing VPID's. Please wait a minute!")
 D DEL
 D BMES^XPDUTL(" Finished removing VPID's")
 Q
 ;
DEL ;Clean out any VPIDs.
 N DA,DIC,DIE,DR,VPID,X,Y
 S VPID="",DIE="^VA(200,",DA=0
 F  S DA=$O(^VA(200,DA)) Q:'DA  I $D(^VA(200,DA,"VPID")) D
 . S DR="9000///@" D ^DIE
 . Q
 Q
