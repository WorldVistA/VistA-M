LR7OPRE ;slc/dcm - PRE-Initialization routine ;12/18/97  08:34
 ;;5.2;LAB SERVICE;**166**;Sep 27, 1994
 ;
EN ;Enter here for pre-installation stuff
 ;Remove Display Group field, file 60
 ;Remove Default Protocol field, file 69.9
 ;Remove old options [DISABLED]
 ;Remove old protocols (DISABLED)
 ;Protocols and options should be removed by KIDS
 D DD
 Q
DD ;Remove old DD's
 N IFN,DA,DIK
 I $P($G(^DD(60,502,0)),"^")="DISPLAY GROUP" D
 . S IFN=0 F  S IFN=$O(^LAB(60,IFN)) Q:IFN<1  I $D(^(IFN,0)) S $P(^(0),"^",6)=""
 . S DIK="^DD(60,",DA(1)=60,DA=502 D DIK,MES^XPDUTL("DISPLAY GROUP field removed from file 60")
 I $P($G(^DD(69.9,2,0)),"^")="OE/RR DEFAULT PROTOCOL" D
 . S IFN=0 F  S IFN=$O(^LAB(69.9,IFN)) Q:IFN<1  I $D(^(IFN,1)) S $P(^(1),"^",6)=""
 . S DIK="^DD(69.9,",DA(1)=69.9,DA=2 D DIK,MES^XPDUTL("OE/RR DEFAULT PROTOCOL field removed from file 69.9")
 I $P($G(^DD(69.99,2,0)),"^")="CANCEL ON WARD TRANSFER" D
 . S IFN=0 F  S IFN=$O(^LAB(69.9,IFN)) Q:IFN<1  S IFN1=0 F  S IFN1=$O(^LAB(69.9,IFN,9,IFN1)) Q:IFN1<1  S $P(^(IFN1,0),"^",3,4)="^"
 . S DIK="^DD(69.99,",DA(1)=69.99,DA=2 D DIK,MES^XPDUTL("CANCEL ON WARD TRANSFER field removed from file 69.9")
 . S DIK="^DD(69.99,",DA(1)=69.99,DA=3 D DIK,MES^XPDUTL("CANCEL ON SERVICE TRANSFER field removed from file 69.9")
 Q
DIK ;enable/disable DIK for testing
 D ^DIK
 Q
PTCL ;Remove old protocols
 N %,IFN,DA,DIK,ITEM,MENU
 Q:'$D(XPDQUES("PRE1"))
 I 'XPDQUES("PRE1") D BMES^XPDUTL("OK, I will leave the removal of Lab protocols for you to do manually, or") D MES^XPDUTL("you can invoke this entry point later to do the clean up (PTCL^LR7OIPRE).") Q
 S DIK="^ORD(101,",IFN="LR" F  S IFN=$O(^ORD(101,"B",IFN)) Q:IFN=""!(IFN]"LRZ")  S DA=$O(^(IFN,0)) Q:'DA  D  D DIK ;W ".",!,IFN_" protocol removed."
 . S MENU=0 F  S MENU=$O(^ORD(101,"AD",DA,MENU)) Q:+MENU'>0  D
 .. S ITEM=0 F  S ITEM=$O(^ORD(101,"AD",DA,MENU,ITEM)) Q:+ITEM'>0  D
 ... N DA,DIC,DIK,X,Y
 ... S DA=$O(^ORD(101,MENU,10,"B",ITEM,0)),DA(1)=MENU,DIK="^ORD(101,"_MENU_",10,"
 ... I DA D DIK
 Q
