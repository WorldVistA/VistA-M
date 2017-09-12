IBY435PO ;ALB/ESG - Post Install for IB patch 435 ;4-Oct-2010
 ;;2.0;INTEGRATED BILLING;**435**;21-MAR-94;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ePharmacy Phase 5 - patch 435 post install
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=2
 D SOI(1)              ; 1. add a new Source of Information for insurance
 D EPI(2)              ; 2. change a menu synonym
 ;
EX ; exit point
 Q
 ;
SOI(IBXPD) ; add a new Source of Information for insurance
 N DA,DIC,DO,X,Y
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Add a new Source of Information for Insurance ... ")
 ;
 F X=10 D
 . I $D(^IBE(355.12,"B",X)) D MES^XPDUTL("Already there...no action") Q
 . S DIC="^IBE(355.12,",DIC(0)="F"
 . S DIC("DR")=".02///E-PHARMACY;.03///eRxEL"
 . D FILE^DICN
 . I Y=-1 D MES^XPDUTL("ERROR when adding a new Ins. Source of Information.  Log a Remedy ticket!") Q
 . D MES^XPDUTL("Entry added successfully")
 . Q
 ;
SOIX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
EPI(IBXPD) ; change a menu synonym
 N DIE,DA,DR,X,Y,MENUIEN,ITEMIEN
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Modify an ePharmacy menu synonym ... ")
 S MENUIEN=$O(^DIC(19,"B","IBCNR E-PHARMACY MENU",0)) I 'MENUIEN D MES^XPDUTL("Parent menu not found.") G EPIX
 S ITEMIEN=$O(^DIC(19,"B","IBCNR ELIGIBILITY INQUIRY",0)) I 'ITEMIEN D MES^XPDUTL("ePharm Menu item not found.") G EPIX
 S DA=+$O(^DIC(19,MENUIEN,10,"B",ITEMIEN,0)) I 'DA D MES^XPDUTL("ePharm Menu item not found on Parent Menu.") G EPIX
 S DIE="^DIC(19,"_MENUIEN_",10,"
 S DA(1)=MENUIEN
 S DR="2////EPI"
 D ^DIE
 D MES^XPDUTL("ePharmacy Menu synonym has been updated.")
 ;
EPIX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
