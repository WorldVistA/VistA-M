DVBAP218 ;ALB/JSR - Post init for DVBA*2.7*218 ; Jan 15,2020@12:51
 ;;2.7;AMIE;**218**;Apr 10, 1995;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine adds menu items to the menus distributed in DVBA*2.7*84. 
 ; The menu changes were requested by HRC.
 ; 
 ; Reference to HRC Pharmacy Menu [DVBA HRC MENU PHARMACY] supported by ICR #4595.
 ;
 Q
POST ;
 ;
 ;See ADDMNU for documentation on input parameters.
 ;Last parameter is the Display Order.  Must be a number from 1 - 99.
 ;
 ;Pharmacy menu
 ;
 D BMES^XPDUTL("-> Adding options to HRC Pharmacy Menu <-")
 D ADDMNU("DVBA HRC MENU PHARMACY","PSOCP RESET COPAY STATUS LM","RCL",6)
 ;
 Q
ADDMNU(DVBA1,DVBA2,DVBA3,DVBA4) ;
 ;
 ;Adds Items to Menu (#19.01) subfile in Option (#19) file
 ;Input:  
 ;     DVBA1 = Name of the menu(Required)
 ;     DVBA2 = Item (#.01)- Name of Option being added to the menu. (Required)
 ;     DVBA3 = Synonym (#2) field (optional)
 ;     DVBA4 = Display Order (#3) field (optional) (Number from 1 - 99)
 ;
 ;Output: 1 = Success - Option added to menu.
 ;        0 = Failure - Option not added to menu.
 ;
 N DVBAOK
 S DVBAOK=$$ADD^XPDMENU(DVBA1,DVBA2,DVBA3,DVBA4)
 I 'DVBAOK D  Q
 .D MES^XPDUTL("  Could not add "_DVBA2_" to "_DVBA1)
 D MES^XPDUTL("  "_DVBA2_" added to "_DVBA1)
 Q
