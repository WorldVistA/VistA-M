GMRCP146 ;;COG/PB/MJ - CCRA PRE INSTALL;NOV 7, 2019
 ;;3.0;Consult Tracking;**146**;NOV 7, 2019;Build 12
 ;;Per VA directive 6402, this routine should not be modified.
 ;Pre install routine for patch GMRC*3.0*146.
 ;Checks for the GMRCCCRA logical link, if it exists, edits the link to remove
 ;the institution and to add the dns domain for the HC server
 Q
EN ; Entry point
 D LINK
 Q
LINK ; update the TMP_Send Link
 N LIEN,VAL,GMRCERR,FDA,DNS
 D MES^XPDUTL("Checking VistA system for GMRCCCRA logical link setup...")
 S VAL="GMRCCCRA"
 S LIEN=$$FIND1^DIC(870,,"B",.VAL)
 I $G(LIEN)'>0 D MES^XPDUTL("Link doesn't exists") Q
 S DNS=$$GET1^DIQ(870,$G(LIEN)_",",400.01,"I")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("GMRCCCRA logical link being updated now. ")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 D MES^XPDUTL("")
 ;
 ; file link with IP address and port entered
 K FDA,GMRCERR
 S FDA(870,$G(LIEN)_",",.02)="@" ; delete the station number
 S FDA(870,$G(LIEN)_",",.08)=$G(DNS) ; add dns domain for HealthConnect server
 D UPDATE^DIE(,"FDA",$G(LIEN)_",","GMRCERR") K FDA
 D MES^XPDUTL("")
 I $D(GMRCERR) D  Q  ; something went wrong
 .D MES^XPDUTL("FileMan error when editing the GMRCCCRA Link.")
 D MES^XPDUTL("GMRCCCRA Link has been updated.")
 Q
 ;
