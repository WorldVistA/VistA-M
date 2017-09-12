XT73P113 ;OAK-OIFO/TKW  KIDs Post-Init for XT*7.3*113 ;10/15/08  16:12
 ;;7.3;TOOLKIT;**113**;Apr 25, 1995;Build 5
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;;
 ;;KIDs Post-Init
 ;
EN ; Delete menu item 
 D BMES^XPDUTL("Put 'Purge Duplicate Record File' option OUT OF ORDER")
 N RSLT
 S RSLT=$$LKOPT^XPDMENU("XDR PURGE")
 I RSLT'>0 D  Q
 . D BMES^XPDUTL("Option XDR PURGE (Purge Duplicate Record File) is not on your system.")
 . Q
 D OUT^XPDMENU("XDR PURGE","Inactivated with patch XT*7.3*113")
 D BMES^XPDUTL("Delete 'Purge Duplicate Record File' OPTION from the 'Manager Utilities' menu.")
 S RSLT=$$DELETE^XPDMENU("XDR MANAGER UTILITIES","XDR PURGE")
 Q:RSLT=1
 D MES^XPDUTL("  *** Deletion FAILED!! ***")
 D MES^XPDUTL("  Use the 'Menu Management' option to delete the 'XPD PURGE' menu item")
 D MES^XPDUTL("  from the 'XDR MANAGER UTILITIES' Menu Option.")
 Q
 ;
 ;
