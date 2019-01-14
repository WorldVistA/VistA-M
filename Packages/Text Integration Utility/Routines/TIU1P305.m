TIU1P305 ;AITC/CR - Post Installation for Patch 305 ;12/18/17 3:58pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**305**;JUN 20, 1997;Build 27
 ;
 ; call to: $$ADD^XPDMENU - supported by ICR #1157
 ;          $$FIND1^DIC   - supported by ICR #2051
 ;          $$GET1^DIQ    - supported by ICR #2056
 ;          BMES^XPDUTL   - supported by ICR #10141 (same for MES^XPDUTL)
 ;
PRE ; clear the multiple field #3 of file #8925.1 in preparation for the text
 ; exported by this patch.
 K ^TMP("TIU1P305")
 D BMES^XPDUTL("Starting Pre-installation operations for patch TIU*1.0*305...")
 D BMES^XPDUTL("Preparing to delete the text in the BOILERPLATE TEXT field, please wait...")
 N IEN,TIUFILE,TIUFLD,TIUIEN,TIUOLDTL,TIUNAME,TIUTITLE,TIUROOT,WP
 ; find any title mapped to the TIU VHA ENTERPRISE STANDARD TITLE "COMPUTER DOWNTIME", #2166, in file #8926.1
 S TIUFILE=8925.1,TIUFLD=3,TIUROOT=""  ;TIUFLD is the multiple for the Boilerplate Text
 D CHKMAP
 S TIUTITLE=$P($G(^TMP("TIU1P305",$J)),U,3)
 I TIUTITLE']"" G ERR1
 S TIUIEN=$$FIND1^DIC(TIUFILE,,"MX",TIUTITLE)
 ; get text stored in the multiple before override
 I TIUIEN S TIUOLDTL=$$GET1^DIQ(TIUFILE,TIUIEN_",",TIUFLD,"","WP") ; old text comes out in array WP
 I '$D(WP) D  G EXIT1
 . D BMES^XPDUTL("There is no text to delete in field #"_TIUFLD_" of file #"_TIUFILE)
 ;
 D BMES^XPDUTL("Text in the BOILERPLATE TEXT field before deletion:")
 D BMES^XPDUTL("===================================================================")
 D BMES^XPDUTL(.WP)
 D MES^XPDUTL("===================================================================")
 I TIUIEN D WP^DIE(TIUFILE,TIUIEN_",",TIUFLD,"K",TIUROOT)
PRE1 D BMES^XPDUTL("The text found in the BOILERPLATE TEXT field has been deleted.") D EXIT1
 Q
 ;
POST ; add two new menu options in two menus in TIU
 ; [TIU DOWNTIME BOOKMARK PN] and [TIUFPC CREATE POST-SIGNATURE]
 ; under [TIU IRM MAINTENANCE MENU] and [TIUF DOCUMENT DEFINITION MGR]
 ; respectively
 D BMES^XPDUTL("Starting Post-installation operations for patch TIU*1.0*305...")
 D ADD1
 D ADD2
 D EXIT
 Q
 ;
ADD1 ; update "TIU IRM MAINTENANCE MENU"
 N TIUOK,TIUSYN
 S TIUSYN=13 ; this can be changed later by the site if desired
 ; parameter order: menu to update, option to add, synonym
 S TIUOK=$$ADD^XPDMENU("TIU IRM MAINTENANCE MENU","TIU DOWNTIME BOOKMARK PN",TIUSYN)
 I TIUOK=1 D
 . D BMES^XPDUTL("[TIU DOWNTIME BOOKMARK PN] Option is part of [TIU IRM MAINTENANCE MENU]")
 E  D  G ERR
 . D BMES^XPDUTL("Couldn't add option [TIU DOWNTIME BOOKMARK PN] to [TIU IRM MAINTENANCE MENU]")
 Q
 ;
ADD2 ; update "TIUF DOCUMENT DEFINITION MGR"
 N TIUOK,TIUSYN
 S TIUSYN=6
 ; parameter order: menu to update, option to add, synonym
 S TIUOK=$$ADD^XPDMENU("TIUF DOCUMENT DEFINITION MGR","TIUFPC CREATE POST-SIGNATURE",TIUSYN)
 I TIUOK=1 D
 . D BMES^XPDUTL("[TIUFPC CREATE POST-SIGNATURE] Option is part of [TIUF DOCUMENT DEFINITION MGR]")
 E  D  G ERR
 . D BMES^XPDUTL("Couldn't add option [TIUFPC CREATE POST-SIGNATURE] to [TIUF DOCUMENT DEFINITION MGR]")
 Q
 ;
ERR ; alert the user if there is an error
 D BMES^XPDUTL("Unable to attach the menu option")
 Q
 ;
ERR1 ; alert user if there is an error
 D BMES^XPDUTL("Pre-installation check: no local title mapped to title COMPUTER DOWNTIME.")
 D MES^XPDUTL("Please resolve this issue by mapping a local title in file #8925.1 to")
 D MES^XPDUTL("the TIU VHA ENTERPRISE STANDARD TITLE 'COMPUTER DOWNTIME' in file #8926.1")
 D MES^XPDUTL("before running the option 'TIU DOWNTIME BOOKMARK PN'.")
 D MES^XPDUTL("Patch installation will continue...")
 D EXIT1
 Q
 ;
EXIT ;
 D BMES^XPDUTL("Finished Post-installation of patch TIU*1.0*305.")
 Q
 ;
EXIT1 ;
 D BMES^XPDUTL("Finished Pre-installation of patch TIU*1.0*305.")
 K ^TMP("TIU1P305")
 Q
 ;
CHKMAP ; look for a local title mapped to the TIU VHA ENTERPRISE STANDARD TITLE 'COMPUTER DOWNTIME' (IEN=2166)
 ; TIUNAME is the title in file #8925.1 mapped to the record #2166 in file #8926.1
 F IEN=0:0 S IEN=$O(^TIU(8925.1,IEN)) Q:'IEN  I $$GET1^DIQ(8925.1,+IEN,1501,"I")=2166 S TIUTITLE=$$GET1^DIQ(8925.1,+IEN,1501,"E"),TIUIEN=+IEN,TIUNAME=$$GET1^DIQ(8925.1,+IEN,.01,"E"),^TMP("TIU1P305",$J)=TIUTITLE_U_IEN_U_TIUNAME
 Q
