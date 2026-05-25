MAGIP333 ;WOIFO/PMK - Install code for MAG*3.0*333; Jan 15, 2026@08:41:46
 ;;3.0;IMAGING;**333**;Mar 19, 2002;Build 2
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; |                                                               |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here 
 ; 
 ; Supported IA #10103 reference $$FMTE^XLFDT function call
 ; Supported IA #10103 reference $$NOW^XLFDT function call
 ; Supported IA #10141 reference BMES^XPDUTL subroutine call
 ; Supported IA #1157 reference $$DELETE^XPDMENU function call
 ; 
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 D KILL20061211
 D KILL2006541
 D KILLTRMENU
 Q
 ;
KILL20061211 ; kill the Q/R CHECK DIVISION field in file 2006.1
 ; P305 incorrrectly set the field #211 information to 8;E1,1
 ; This neeeds to be reset to 8;1
 S DIK="^DD(2006.1,",DA(1)=211 D ^DIK
 Q
 ;
KILL2006541 ; kill the DICOM VISTA Q/R REQUEST QUEUE (file #2006.541) DD
 ; Killing the old DD is necessary to add the DIVISION
 N DIU
 K ^MAGDSTT(2006.541)
 S DIU=2006.541,DIU(0)="" D EN^DIU2
 Q
 ;
KILLTRMENU ; remove the TeleReader Menu
 ; The TeleReader Menu will be reinstalled with DISPLAY ORDER=85
 N STATUS
 S STATUS=$$DELETE^XPDMENU("MAG SYS MENU","MAGT TELEREADER MENU")
 W !!," Removal of Telereader Menu: ",$S(STATUS:"Success",1:"Failure")
 Q
 ;
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D SET20061212
 D CLEAR^MAGUERR(1)
 ;
 ;--- Various Updates
 D SETTRMENU ; p349 PMK 01/14/2026
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
SET20061212 ; Set field 212
 ; setting these fields will set the delimiter for 212
 N MAGERR,MAGFDA,SITE
 S SITE=0
 F SITE=$O(^MAG(2006.1,SITE)) Q:'SITE  D
 . S MAGFDA(2006.1,SITE_",",212)=""
 . D UPDATE^DIE("","MAGFDA",,"MAGERR")
 . Q
 Q
 ;
SETTRMENU ; Reinstall TeleReader Menu with DISPLAY ORDER=85 -  P349 PMK 01/14/2026
 N STATUS
 S STATUS=$$ADD^XPDMENU("MAG SYS MENU","MAGT TELEREADER MENU","TR",85)
 W !!," Reinstall of Telereader Menu: ",$S(STATUS:"Success",1:"Failure")
 Q
 ;
UPDATE() ;
 Q 0
