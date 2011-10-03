ORY245 ;SLC/JM -- post-install for OR*3*245 ; 1/19/2006
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**245**;Dec 17, 1997;Build 2
 Q
POST ; Used to insert new ORCM QUICK ORDERS BY USER option into ORCM MGMT menu
 N OROPTION,ORMENU
 N DO,DA,DD,DI,DIC,DIE,DLAYGO,DQ,DR,X,Y,DINUM
 D BLDXREF
 ; find option
 S OROPTION=$O(^DIC(19,"B","ORCM QUICK ORDERS BY USER",0)) I '+OROPTION D  Q
 . D BMES^XPDUTL("An error occurred during the installation.")
 . D MES^XPDUTL("The new option ORCM QUICK ORDERS BY USER was not found.")
 ; find menu
 S ORMENU=$O(^DIC(19,"B","ORCM MGMT",0)) I '+ORMENU D  Q
 . D BMES^XPDUTL("Unable to attach the new ORCM QUICK ORDERS BY USER option.")
 . D MES^XPDUTL("Menu ORCM MGMT was not found.")
 ; If option already attached to menu then install has been run before
 I +$O(^DIC(19,ORMENU,10,"B",OROPTION,0)) D  Q
 . D BMES^XPDUTL("Option ORCM QUICK ORDERS BY USER is already attached to ORCM MGMT menu.")
 ; Attach option to menu
 I '$D(^DIC(19,ORMENU,10,0)) S ^(0)="^19.01PI^^"
 S DIC="^DIC(19,"_ORMENU_",10,",DIC(0)="L",DLAYGO=19,DA(1)=ORMENU,X=OROPTION,DIC("DR")="2///QU;3///4.5"
 D FILE^DICN
 I +$O(^DIC(19,ORMENU,10,"B",OROPTION,0)) D  I 1
 . D BMES^XPDUTL("New option ORCM QUICK ORDERS BY USER successfully attached to ORCM MGMT menu.")
 E  D BMES^XPDUTL("Error trying to attach ORCM QUICK ORDERS BY USER to ORCM MGMT menu.")
 Q
BLDXREF ; index new cross reference
 N DIK,DA,MSG1,MSG2,IEN
 I $D(^ORD(101.44,"C"))=0 S MSG1="Populating",MSG2="populated"
 E  S MSG1="Reindexing",MSG2="reindexed"
 D BMES^XPDUTL(MSG1_" the new C cross reference of the ORDER QUICK VIEW file.")
 K ^ORD(101.44,"C")
 S IEN=0
 F  S IEN=$O(^ORD(101.44,IEN)) Q:'IEN  D
 . S DIK="^ORD(101.44,"_IEN_",10,",DIK(1)=".01^C",DA(1)=IEN D ENALL^DIK
 D BMES^XPDUTL("The C cross reference of the ORDER QUICK VIEW file has been "_MSG2_".")
 Q
