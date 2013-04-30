IB20P449 ;ELZ/OAK - POST INIT FOR PATCH;02/22/2011
 ;;2.0;INTEGRATED BILLING;**449**;21-MAR-94;Build 15
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
ENV ;
 ; setup so no queue of install
 S XPDNOQUE=1
 Q
 ;
POST ; post init entry point
 ;
 D MES^XPDUTL("  Starting post-init for IB*2.0*449")
 ;
 D 3542
 D 3503
 D REPORT
 ;
 D MES^XPDUTL("  Finished post-init for IB*2.0*449")
 ;
 Q
 ;
3542 ; add entry to exemption file 354.2 if not there
 I $O(^IBE(354.2,"B","CATASTROPHICALLY DISABLED",0)) D  Q
 . D MES^XPDUTL("    - CATASTROPHICALLY DISABLED already exists, nothing to add to 354.2.")
 ;
 N DO,X,Y,DIC
 ;
 S X="CATASTROPHICALLY DISABLED",DIC="^IBE(354.2,",DIC(0)=""
 S DIC("DR")=".02///Patient is Catastrophically Disabled;.03///1;.04///1;.05///100"
 D FILE^DICN
 ;
 D MES^XPDUTL($S(Y>1:"    - CATASTROPHICALLY DISABLED Exemption Reason (#354.2) added.",1:"*** ERROR: COULD NOT CREATE NEW CD ENTRY IN 354.2 ***"))
 ;
 Q
 ;
3503 ; add entry to Charge Removal Reason file if not there
 ;
 N IBX,DO,DIC,X,Y
 ;
 D MES^XPDUTL("    - Adding entry to Charge Removal Reason (#350.3) file.")
 S IBX="CATASTROPHICALLY DISABLED^CD" D
 . K DO S DIC="^IBE(350.3,",DIC(0)="",X=$P(IBX,"^")
 . S DIC("DR")=".02///^S X=$P(IBX,U,2);.03///3"
 . I $O(^IBE(350.3,"B",X,0)) D MES^XPDUTL("      - "_X_" already exists.") Q
 . D FILE^DICN
 . D MES^XPDUTL($S(Y>1:"      - "_$P(IBX,"^")_" entry added.",1:"*** ERROR: COULD NOT CREATE NEW "_$P(IBX,"^",2)_" ENTRY IN 350.3 ***"))
 ;
 D MES^XPDUTL("    - Done adding entry in Charge Removal Reason (#350.3) file.")
 Q
 ;
REPORT ; - this will produce a report of patient's with charges that are CD.
 ;
 N POP,%ZIS,ZTRTN,ZTDESC,ZTSK,IBA,IBEDT,IBBDT,ZTSAVE
 S IBBDT=3100504,IBEDT=DT
 S IBA(1)="Select the device for the Catastrophically Disabled Charge report.  It"
 S IBA(2)="should be queued to a printer off hours as it can take some time to run"
 S IBA(3)="with at least a margin of 132 columns."
 D MES^XPDUTL(.IBA)
 S %ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) D  Q
 .S ZTRTN="DQ^IBOCDRPT",ZTDESC="Catastrophically Disabled Copay Report"
 .S (ZTSAVE("IBEDT"),ZTSAVE("IBBDT"))=""
 .D ^%ZTLOAD D HOME^%ZIS K IO("Q")
 .D MES^XPDUTL("Catastrophically Disabled Copay Report queued #"_ZTSK)
 D DQ^IBOCDRPT
 Q
