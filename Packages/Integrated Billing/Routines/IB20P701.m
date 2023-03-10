IB20P701 ;SLC/RM - POST INSTALL ROUTINE FOR IB*2.0*701 ; April 12, 2021@2:21 pm
 ;;2.0;INTEGRATED BILLING;**701**;March 21, 1994;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References    Supported by ICR#    Type
 ;-------------------    -----------------    ----------
 ; $$DELETE^XPDMENU      1157                 Supported
 ; $$LKOPT^XPDMENU       1157                 Supported
 ; BMES^XPDUTL           10141                Supported
 ; MES^XPDUTL            10141                Supported
 ;
 Q
 ;
DELOPT ; Remove option 'DG OTH FSM ELIG. CHANGE REPORT' from 'IB OUTPUT PATIENT REPORT MENU'
 N CHECK,MENU,OPTION,DA,DIK
 D BMES^XPDUTL(" >>  Starting the Post-Initialization routine ...")
 D MES^XPDUTL(" ")
 D MES^XPDUTL("     Removing Option DG OTH FSM ELIG. CHANGE REPORT from")
 D MES^XPDUTL("     IB OUTPUT PATIENT REPORT MENU...")
 D MES^XPDUTL(" ")
 S MENU="IB OUTPUT PATIENT REPORT MENU"
 S OPTION="DG OTH FSM ELIG. CHANGE REPORT"
 I '+$$LKOPT^XPDMENU(MENU) D MES^XPDUTL("     "_MENU_" does not exist.") Q
 I '+$$LKOPT^XPDMENU(OPTION) D MES^XPDUTL("     "_OPTION_" does not exist.") Q
 ;
 S CHECK=$$DELETE^XPDMENU(MENU,OPTION)
 I CHECK D
 . D MES^XPDUTL("     Successfully removed DG OTH FSM ELIG. CHANGE REPORT from")
 . D MES^XPDUTL("     IB OUTPUT PATIENT REPORT MENU...")
 E  D
 . D MES^XPDUTL("     DG OTH FSM ELIG. CHANGE REPORT menu option does not exist")
 . D MES^XPDUTL("     in IB OUTPUT PATIENT REPORT MENU...")
 . D MES^XPDUTL("     NO ACTION TAKEN.")
 D MES^XPDUTL(" ")
 D MES^XPDUTL(" >>  End of the Post-Initialization routine ...")
 D MES^XPDUTL(" ")
 Q
 ;
