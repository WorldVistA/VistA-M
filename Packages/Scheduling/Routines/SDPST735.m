SDPST735 ;;CCRA/PB - CCRA PRE INSTALL;NOV 4, 2019
 ;;5.3;Scheduling;**735**;NOV 4, 2019;Build 21
 ;;Per VA directive 6402, this routine should not be modified.
 ;Post install routine for patch SD*5.3*735.
 ;Checks for the CCRA-NAK logical link, if it exists, edits the link to remove
 ;the institution and adds the COM CARE-OTHER non count clinic to the
 ;Hospital Location File (#44)
 Q
EN ; Entry point
 ;D CLINIC
LINK ; update the CCRA-NAK Link
 N LIEN,VAL,SDERR,FDA,DNS
 D MES^XPDUTL("Checking VistA system for CCRA-NAK logical link setup...")
 S VAL="CCRA-NAK"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I $G(LIEN)'>0 D MES^XPDUTL("Link doesn't exists") Q
 S DNS=$$GET1^DIQ(870,$G(LIEN)_",",400.01,"I")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("CCRA-NAK logical link being set up now. ")
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
 .D MES^XPDUTL("FileMan error when editing the CCCRA-NAK Link.")
 D MES^XPDUTL("CCRA-NAK Link has been updated.")
 Q
QEND K DIR,SDERR Q
QABORT S XPDABORT=1 K DIR,SDERR Q
