TIUPT329 ;;LB/PB - CCRA POST INSTALL;NOV 4, 2019
 ;;1.0;TEXT INTEGRATION UTILITIES;**329**;NOV 4, 2019;Build 42
 ;;Per VA directive 6402, this routine should not be modified.
 ;Post install routine for patch TIU*1.0*329.
 ;Checks for the TIUCCRA logical link, if it exists, edits the link to remove
 ;the institution and to add the dns domain for the HC server
 Q
 D LINK
 Q
LINK ; update the TMP_Send Link
 N LIEN,VAL,SDERR,FDA,DNS
 D MES^XPDUTL("Checking VistA system for TIUCCRA logical link setup...")
 S VAL="TIUCCRA"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I $G(LIEN)'>0 D MES^XPDUTL("Link doesn't exists") Q
 S DNS=$$GET1^DIQ(870,$G(LIEN)_",",400.01,"I")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("TIUCCRA logical link being set up now. ")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 ;
 ; file link with IP address and port entered
 K FDA,SDERR
 S FDA(870,$G(LIEN)_",",.02)="@" ; delete the station number
 S FDA(870,$G(LIEN)_",",.08)=$G(DNS) ; add dns domain for HealthConnect server
 D UPDATE^DIE(,"FDA",$G(LIEN)_",","SDERR") K FDA
 D MES^XPDUTL("")
 I $D(SDERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the TIUCCRA Link.")
 D MES^XPDUTL("TIUCCRA Link has been updated.")
 Q
QEND K DIR,SDERR Q
QABORT S XPDABORT=1 K DIR,SDERR Q
