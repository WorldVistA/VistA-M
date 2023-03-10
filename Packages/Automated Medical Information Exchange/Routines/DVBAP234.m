DVBAP234 ;ALB/FSB - Post init for DVBA*2.7*234 ; May 13,2021@15:02
 ;;2.7;AMIE;**234**;Apr 10, 1995;Build 6
 ;
 ; This routine adds menu items to the menus distributed in DVBA*2.7*84. 
 ; The menu changes were requested by HRC.
 ; 
 ; Reference to HRC Pharmacy Menu [DVBA HRC MENU PHARMACY] supported by ICR #4595.
 ; Reference to First Party Veteran Charge Report [PRCA FP VETERAN CHRG RPT] supported by ICR #7269.
 ;
 Q
POST ;
 ;
 ; See ADDMNU for documentation on input parameters.
 ; Last parameter is the Display Order. Must be a number from 1 - 99.
 ;
 ; Pharmacy menu
 ;
 D BMES^XPDUTL("-> Adding options to HRC Pharmacy Menu <-")
 D ADDMNU("DVBA HRC MENU EXTENDED SVCS","PRCA FP VETERAN CHRG RPT","VCR",90)
 D ADDMNU("DVBA HRC MENU PHARMACY CC","PRCA FP VETERAN CHRG RPT","VCR",35)
 D ADDMNU("DVBA HRC MENU PHARMACY","PRCA FP VETERAN CHRG RPT","VCR",35)
 Q
ADDMNU(DVBA1,DVBA2,DVBA3,DVBA4) ;
 ;
 ; Adds Items to Menu (#19.01) subfile in Option (#19) file
 ; Input: 
 ; DVBA1 = Name of the menu(Required)
 ; DVBA2 = Item (#.01)- Name of Option being added to the menu. (Required)
 ; DVBA3 = Synonym (#2) field (optional)
 ; DVBA4 = Display Order (#3) field (optional) (Number from 1 - 99)
 ;
 ; Output: 1 = Success - Option added to menu.
 ; 0 = Failure - Option not added to menu.
 ;
 N DVBAOK
 S DVBAOK=$$ADD^XPDMENU(DVBA1,DVBA2,DVBA3,DVBA4)
 I 'DVBAOK D  Q
 .D MES^XPDUTL(" Could not add "_DVBA2_" to "_DVBA1_" ***Please contact support for assistance.***")
 D MES^XPDUTL(" "_DVBA2_" added to "_DVBA1)
 Q
