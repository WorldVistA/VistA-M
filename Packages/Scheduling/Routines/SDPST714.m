SDPST714 ;;MS/PB - CCRA PRE INSTALL;NOV 19, 2019
 ;;5.3;Scheduling;**714**;NOV 19, 2019;Build 80
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch SD*5.3*714.
 ;Checks for the TMP_SEND logical link, if it exists, edits the link to remove
 ;the institution
 Q
LINK ; update the TMP_Send Link
 N LIEN,VAL,SDERR,FDA,DNS
 D MES^XPDUTL("Checking VistA system for CCRA-NAK logical link setup...")
 S VAL="TMP_SEND"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I $G(LIEN)'>0 D MES^XPDUTL("Link doesn't exists") Q
 S DNS=$$GET1^DIQ(870,$G(LIEN)_",",400.01,"I")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("TMP_SEND logical link being set up now. ")
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
 .D MES^XPDUTL("FileMan error when editing the TMP_SEND Link.")
 D MES^XPDUTL("TMP_SEND Link has been updated.")
 Q
QEND K DIR,SDERR Q
QABORT S XPDABORT=1 K DIR,SDERR Q
