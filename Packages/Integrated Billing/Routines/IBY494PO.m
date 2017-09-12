IBY494PO ;ALB/ESG - Post Install for IB patch 494 ;7-Jan-2013
 ;;2.0;INTEGRATED BILLING;**494**;21-MAR-94;Build 11
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; ePharmacy Operating Rules - IB patch 494 post install
 ;
EN ; entry point
 N XPDIDTOT
 S XPDIDTOT=4
 D SMR(1)              ; 1. remove Shared Matches Report option/task/routine
 D OPT(2)              ; 2. remove options from the IB e-Pharmacy Menu
 D NON(3)              ; 3. remove the Non Covered Drugs functionality
 D TRI(4)              ; 4. Remove decommissioned TRICARE menu options
 ;
EX ; exit point
 Q
 ;
SMR(IBXPD) ; remove Shared Matches Report option/task/routine
 N DA,DIC,DO,X,Y,Z,DIK,OPTNAME,OPTIEN,OSIEN,DEL
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing ePharmacy Shared Matches Report functionality ... ")
 ;
 S OPTNAME="IBCNR SHARED MATCHES RPT TASK"    ; this is the option to be removed
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)           ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been removed.") G SMRX
 ;
 K Z D OPTSTAT^XUTMOPT(OPTNAME,.Z)            ; obtain the option schedule in file 19.2 if one exists
 ;
 I '$O(Z("")) D MES^XPDUTL("  No Scheduled Tasks found for option ["_OPTNAME_"].")
 ;
 I $O(Z("")) D
 . N SCH
 . D MES^XPDUTL("  Scheduled Task found for option ["_OPTNAME_"].")
 . S SCH=0 F  S SCH=$O(Z(SCH)) Q:'SCH  D
 .. N ZTSK,IBTSK
 .. S (ZTSK,IBTSK)=+$P($G(Z(SCH)),U,1) Q:'ZTSK
 .. D DQ^%ZTLOAD    ; unschedule task IA 10063
 .. I $G(ZTSK(0)) D MES^XPDUTL("  TaskManager scheduled task #"_IBTSK_" has been unscheduled.")
 .. I '$G(ZTSK(0)) D MES^XPDUTL("  TaskManager scheduled task #"_IBTSK_" is invalid.")
 .. K ZTSK
 .. S ZTSK=IBTSK
 .. D KILL^%ZTLOAD    ; delete task IA 10063
 .. I $G(ZTSK(0)) D MES^XPDUTL("  TaskManager task #"_IBTSK_" has been deleted.")
 .. I '$G(ZTSK(0)) D MES^XPDUTL("  TaskManager task #"_IBTSK_" is invalid.")
 .. Q
 . Q
 ;
 ; remove the entries from file 19.2 option scheduling file
 I '$O(^DIC(19.2,"B",OPTIEN,0)) D MES^XPDUTL("  No data in OPTION SCHEDULING file for option ["_OPTNAME_"].")
 S OSIEN=0 F  S OSIEN=$O(^DIC(19.2,"B",OPTIEN,OSIEN)) Q:'OSIEN  D
 . N DIK,DA
 . S DIK="^DIC(19.2,",DA=OSIEN D ^DIK
 . D MES^XPDUTL("  Option ["_OPTNAME_"] removed from OPTION SCHEDULING file.")
 . Q
 ;
 ; remove the option from the main Option file (file 19)
 S DIK="^DIC(19,",DA=OPTIEN D ^DIK
 D MES^XPDUTL("  Option ["_OPTNAME_"] removed from the system.")
 ;
 ; remove the routine
 S X="IBCNRSM",DEL=$G(^%ZOSF("DEL")) I DEL'="" X DEL    ; DBIA 10096
 D MES^XPDUTL("  Routine IBCNRSM removed from the system.")
 ;
SMRX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
OPT(IBXPD) ; remove options from the IB parent menu e-Pharmacy Menu  [IBCNR E-PHARMACY MENU]
 N CHMP,RES
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing ECME options from the IB e-Pharmacy parent menu ... ")
 ;
 F CHMP="IBCNR EDIT HIPAA NCPDP FLAG","IBCNR EDIT NCPDP PROCESSOR","IBCNR EDIT PAYER","IBCNR EDIT PBM" D
 . S RES=$$DELETE^XPDMENU("IBCNR E-PHARMACY MENU",CHMP)
 . I RES D MES^XPDUTL("  Menu Option ["_CHMP_"] successfully removed!") Q
 . D MES^XPDUTL("  Menu Option ["_CHMP_"] has already been removed.")
 . Q
 ;
OPTX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
NON(IBXPD) ; Remove the IB non covered drugs functionality
 N RES,OPTNAME,OPTIEN,DA,DR,DIK,DIU,DIE,DEL,X
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing IB Drugs Non-Covered Functionality ... ")
 ;
 ; remove the report from the parent IB menu (2.7.4.1)
 S RES=$$DELETE^XPDMENU("IBCNR E-PHARMACY MENU","IB DRUGS NON COVERED REPORT")
 I RES D MES^XPDUTL("  Menu Option [IB DRUGS NON COVERED REPORT] successfully removed from parent menu!")
 I 'RES D MES^XPDUTL("  Menu Option [IB DRUGS NON COVERED REPORT] was already removed from parent menu.")
 ;
 ; remove the menu option from the system (2.7.4.2)
 S OPTNAME="IB DRUGS NON COVERED REPORT"      ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)           ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove the IB site parameter data and fields (2.7.4.5 and 2.7.4.6)
 S DIE=350.9,DA=1,DR="11.02///@" D ^DIE           ; delete 11.02 data
 S DIK="^DD(350.9,",DA=11.02,DA(1)=350.9 D ^DIK   ; delete 11.02 field
 S DIU=350.912,DIU(0)="DS" D EN^DIU2              ; delete NON COVERED REJECT CODES 350.912 subfile (data and DD)
 D MES^XPDUTL("  Data removed from the IB Site Parameter file.")
 ;
 ; remove the 366.16 data file (2.7.4.7)
 S DIU=366.16,DIU(0)="DT" D EN^DIU2        ; delete file 366.16 data and DD
 D MES^XPDUTL("  Data removed from IB NDC NON COVERED BY PLAN file #366.16.")
 ;
 ; remove the obsolete routines from the system (2.7.4.10)
 S DEL=$G(^%ZOSF("DEL"))
 I DEL'="" F X="IBNCDNC","IBNCDNC1" X DEL
 D MES^XPDUTL("  2 Routines removed from the system (IBNCDNC and IBNCDNC1).")
 ;
NONX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
TRI(IBXPD) ; Remove decommissioned TRICARE menu options
 N RES,OPTNAME,OPTIEN,DA,DR,DIK,DIU,DIE,DEL,X
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing decommissioned TRICARE menu options ... ")
 ;
 ; IB TRICARE ENGINE START
 S RES=$$DELETE^XPDMENU("IB SITE MGR MENU","IB TRICARE ENGINE START")
 I RES D MES^XPDUTL("  Menu Option [IB TRICARE ENGINE START] successfully removed from parent menu!")
 I 'RES D MES^XPDUTL("  Menu Option [IB TRICARE ENGINE START] was already removed from parent menu.")
 ;
 ; remove the routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE ENGINE START"      ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; IB TRICARE ENGINE STOP
 S RES=$$DELETE^XPDMENU("IB SITE MGR MENU","IB TRICARE ENGINE STOP")
 I RES D MES^XPDUTL("  Menu Option [IB TRICARE ENGINE STOP] successfully removed from parent menu!")
 I 'RES D MES^XPDUTL("  Menu Option [IB TRICARE ENGINE STOP] was already removed from parent menu.")
 ;
 ; remove the routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE ENGINE STOP"       ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; IB TRICARE MENU
 S RES=$$DELETE^XPDMENU("IB BILLING CLERK MENU","IB TRICARE MENU")
 I RES D MES^XPDUTL("  Menu Option [IB TRICARE MENU] successfully removed from parent menu!")
 I 'RES D MES^XPDUTL("  Menu Option [IB TRICARE MENU] was already removed from parent menu.")
 ;
 ; remove the menu option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE MENU"              ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove IB TRICARE REVERSE routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE REVERSE"           ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove IB TRICARE RESUBMIT routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE RESUBMIT"          ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove IB TRICARE REJECT routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE REJECT"            ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove IB TRICARE TRANSMISSION routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE TRANSMISSION"      ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
 ;
 ; remove IB TRICARE DEL REJECT routine option from the system (2.7.5.1)
 S OPTNAME="IB TRICARE DEL REJECT"        ; this is the option to be deleted
 S OPTIEN=+$$LKOPT^XPDMENU(OPTNAME)       ; this should be the ien to file 19 for this option
 I 'OPTIEN D MES^XPDUTL("  The option ["_OPTNAME_"] has already been deleted.")
 I OPTIEN S DIK="^DIC(19,",DA=OPTIEN D ^DIK D MES^XPDUTL("  Option ["_OPTNAME_"] deleted from the system.")
TRIX ;
 D MES^XPDUTL(" Done.")
 D UPDATE^XPDID(IBXPD)
 Q
 ;
