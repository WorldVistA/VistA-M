IBY702PO ;AITC/TAZ - Post-Installation for IB patch 702; MAY 11, 2021
 ;;2.0;INTEGRATED BILLING;**702**;MAR 21,1994;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #4677 for the usage of CREATE^XUSAP.
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 Q
 ;
POST ; POST-INSTALL
 N IBINSTLD,IBXPD,PRODENV,SITE,SITENAME,SITENUM,XPDIDTOT
 S XPDIDTOT=6
 S SITE=$$SITE^VASITE,SITENAME=$P(SITE,U,2),SITENUM=$P(SITE,U,3)
 ;
 S PRODENV=$$PROD^XUPROD(1)   ; 1=Production Environment, 0=Test Environment
 S IBINSTLD=0 ; all commands will run, regardless of install status
 D MES^XPDUTL("")
 ;
 D ADDPROXY(1)    ; Create "ICB,IB NOINS" in file New Person (#200)
 ;
 D DEFAU(2)   ;Default field #350.9,51.34 to 180
 ;
 D OPAR(3)  ; add inactive and ambiguous rpts to menus
 ;
 D OPTR(4)  ; remove menu option IBCNE POTENTIAL NEW INS FOUND
 ;
 D PIUPD(5)   ;Remove report options from the Patient Insurance Menu.
 ;
 D SITEREG(6,SITENUM) ; Send site registration message to FSC
 ;
 D MES^XPDUTL("")      ; Displays the 'Done' message and finishes the progress bar
 D MES^XPDUTL("POST-Install for IB*2.0*702 Completed.")
 Q
 ;============================
 ;
ADDPROXY(IBXPD) ;Add APPLICATION PROXY user to file 200.  Supported by IA#4677.
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Adding entry 'ICB,IB NOINS' to the New Person file (#200)")
 N IEN200
 S IEN200=$$CREATE^XUSAP("ICB,IB NOINS","")
 I +IEN200=0 D MES^XPDUTL("........'ICB,IB NOINS' already exists.")
 I +IEN200>0 D MES^XPDUTL("........'ICB,IB NOINS' added.")
 I IEN200<0 D MES^XPDUTL("........ERROR: 'ICB,IB NOINS' NOT added.")
 Q
 ;
DEFAU(IBXPD) ;Default field 350.9,51.34 to 180
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Set default for field EIV NO GRP NUM A/U (#350.9,51.34) ... ")
 ;
 N IBDFDA,DATA,DAYS,MSG
 S DAYS=$$GET1^DIQ(350.9,"1,",51.34)
 I DAYS'="" S MSG="EIV NO GRP NUM A/U is already set." G DEFAUQ
 S IBDFDA=1
 S DATA(51.34)=180
 D UPD^IBDFDBS(350.9,.IBDFDA,.DATA)
 S MSG="EIV NO GRP NUM A/U default set to 180."
DEFAUQ ;
 D MES^XPDUTL(MSG)
 ;
 Q
 ;
SITEREG(IBXPD,SITENUM) ; send site registration message to FSC
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Send eIV site registration message to FSC ... ")
 ;
 I '$$PROD^XUPROD(1) D MES^XPDUTL("N/A - Not a production account - No site registration message sent") G SITEREGQ
 I SITENUM=358 D MES^XPDUTL("Current Site is MANILA - NO eIV site registration message sent") G SITEREGQ
 D ^IBCNEHLM
 D MES^XPDUTL("eIV site registration message was successfully sent")
 ;
SITEREGQ ;
 Q
 ;
 ;
OPAR(IBXPD) ; add inactive and imbiguous reports to menus
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D BMES^XPDUTL("Add report options: IBCNE IIV INACTIVE POLICY RPT and ")
 D MES^XPDUTL("                    IBCNE IIV AMBIGUOUS POLICY RPT")
 D MES^XPDUTL("To Menus: IBCN INS RPTS and ")
 D MES^XPDUTL("          IBCNE IIV MENU")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$ADD^XPDMENU
 ; ICR #10141 for the usage of $$INSTALDT^XPDUTL
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBSYN,IBCHK
 S IBOER="",IBCHK=""
 ;is the patch installed
 I +IBINSTLD D  S IBOER=2 G OPARQ
 . D MES^XPDUTL("Patch IB*2.0*702 has been previously installed. Not running step")
 . D BMES^XPDUTL(" ")
 ;
 ; IBCNE IIV INACTIVE POLICY RPT
 ; IBCNE IIV AMBIGUOUS POLICY RPT
 ; IBCN INS RPTS
 ; IBCNE IIV MENU
 ;
 S IBOER=0 F IBMENU="IBCN INS RPTS","IBCNE IIV MENU" D
 . F IBNAM="IBCNE IIV INACTIVE POLICY RPT","IBCNE IIV AMBIGUOUS POLICY RPT" D
 .. S IBSYN=$S(IBNAM["INACTIVE":"IP",1:"AR")
 .. ;
 .. S IBRET=$$ADD^XPDMENU(IBMENU,IBNAM,IBSYN)
 .. ;
 .. I IBRET D MES^XPDUTL("Option: "_IBNAM_" added to menu: "_IBMENU) Q
 .. S IBOER=1 D MES^XPDUTL("Not able to add Option: "_IBNAM_" to menu: "_IBMENU)
 ;
OPARQ ; option remove end point
 I IBOER'=2 D BMES^XPDUTL("Add report options to menus was"_($S('IBOER:"",1:" not"))_" successful")
 Q
 ;
OPTR(IBXPD) ; Remove menu option IBCNE POTENTIAL NEW INS FOUND
 ;
 S IBXPD=$G(IBXPD)
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_$G(XPDIDTOT))
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Remove option: IBCNE POTENTIAL NEW INS FOUND from Select Menus ")
 D BMES^XPDUTL(" ")
 ;
 ; ICR #1157  for the usage of $$DELETE^XPDMENU
 ; ICR #10141 for the usage of $$INSTALDT^XPDUTL
 ;
 N IBMENU,IBNAM,IBOER,IBRET,IBCHK
 S (IBOER,IBCHK)=""
 ;is the patch installed
 I +IBINSTLD D  S IBOER=2 G OPTRQ
 . D MES^XPDUTL("Patch IB*2.0*702 has been previously installed. Not running step")
 . D BMES^XPDUTL(" ")
 ;
 ; IBCNE POTENTIAL NEW INS FOUND  (to be removed)
 ; IBCN INS RPTS
 ; IBCNE IIV MENU
 ;
 ;
 S IBOER=0,IBNAM="IBCNE POTENTIAL NEW INS FOUND"
 F IBMENU="IBCN INS RPTS","IBCNE IIV MENU" D
 . ;
 . S IBRET=$$DELETE^XPDMENU(IBMENU,IBNAM)
 . ;
 . I IBRET D BMES^XPDUTL("Option: "_IBNAM_" removed from menu: "_IBMENU) Q
 . S IBOER=1 D BMES^XPDUTL("Not able to remove Option: "_IBNAM_" from menu: "_IBMENU)
 ;
OPTRQ ; option remove end point
 ;
 I IBOER'=2 D BMES^XPDUTL("Option: IBCNE POTENTIAL NEW INS FOUND was"_($S('IBOER:"",1:" not"))_" removed from Select menus")
 Q
 ;
 ;ICR 1157 allows calls to XPDMENU
PIUPD(IBXPD) ; Update the Patient Insurance (PI) Menu
 ;
 N CNT,DEL,OPTION
 D BMES^XPDUTL(" STEP "_IBXPD_" of "_XPDIDTOT)
 D MES^XPDUTL("-------------")
 D MES^XPDUTL("Removing options from Patient Insurance (PI) Menu ... ")
 ;
 I +IBINSTLD D  S IBOER=2 G PIUPDQ
 . D MES^XPDUTL("Patch IB*2.0*702 has been previously installed. Options previously removed.")
 ;
 F CNT=1:1 S OPTION=$P($T(OPTLIST+CNT),";;",2) Q:OPTION=""  D
 . S DEL=$$DELETE^XPDMENU("IBCN INSURANCE MGMT MENU",OPTION)
 . D MES^XPDUTL(OPTION_" was "_$S('DEL:"not ",1:"")_"removed.")
PIUPDQ ; Exit PIUPD
 D MES^XPDUTL("Removing options from Patient Insurance (PI) Menu Complete.")
 Q
 ;
OPTLIST ; List of options to remove from Patient Insurance Menu
 ;;IBCN LIST INACTIVE INS W/PAT
 ;;IBCN LIST NEW NOT VER
 ;;IBCN LIST PLANS BY INS CO
 ;;IBCN POL W/NO EFF DATE REPORT
 ;;IBCN ID DUP INSURANCE ENTRIES
 ;;IBCN NO COVERAGE VERIFIED
 ;;IBCN PT W/WO INSURANCE REPORT
 ;;IBCN INS PLANS MISSING DATA
 ;;
