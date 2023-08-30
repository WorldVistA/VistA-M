MAGIP278 ;WOIFO/DAC - Install code for MAG*3.0*278 ; Oct 06, 2021@13:54:20
 ;;3.0;IMAGING;**278**;Mar 19, 2002;Build 138
 ;; Per VA Directive 6402, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP278 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ; Error handling
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;***** POST-INSTALL CODE
POS ; Post-Install
 ;
 D QUE
 ;
 D ATTACH
 D SYN
 Q
 ;
QUE ; Que post install
 N NAMSP,PATCH,JOBN,ZTSK,ZTRTN,ZTIO,ZTDTH,ZTDESC,Y,ZTQUEUED,ZTREQ,ZTSAVE,CNT,PSJCNT,SBJM,RESTART,SMSG
 S NAMSP="MAGVCLN"
 S JOBN="MAG*3.0*278 Post Install"
 S PATCH="MAG*3.0*278"
 S Y=$$NOW^XLFDT S ZTDTH=$$FMTH^XLFDT(Y)
 ;
 S ZTRTN="QUE^"_NAMSP,ZTIO=""
 S (SBJM,ZTDESC)="Background job for "_JOBN
 S ZTSAVE("JOBN")="",ZTSAVE("ZTDTH")="",ZTSAVE("DUZ")="",ZTSAVE("SBJM")=""
 D ^%ZTLOAD
 D:$D(ZTSK)
 . N POSTEXT
 . S POSTEXT(1)="A MailMan message will be sent to the installer and the"
 . S POSTEXT(2)="MAG SERVER mail group upon Post Install Completion"
 . S POSTEXT(3)="*** Task #"_ZTSK_" Queued! ***"
 . D MES^XPDUTL(.POSTEXT)
 . S ZTSAVE("ZTSK")=""
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 K XPDQUES
 Q
 ;
 ;
ATTACH ; Attach options to PSO EPCS UTILITY menu
 N MENU,OPTION,CHECK,SYN
 S MENU="MAGV HDIG MENU"
 F OPTION="MAGV SEARCH PROBLEMS","MAGV RESOLVE PROBLEMS"  D
 . S SYN=$S(OPTION["SEARCH":"SRPR",1:"VRPR")
 . S CHECK=$$ADD^XPDMENU(MENU,OPTION,SYN)
 . D BMES^XPDUTL(">>> "_OPTION_" Option"_$S('CHECK:" NOT added to "_MENU,1:" added to "_MENU)_" <<<")
 Q
 ;
SYN ; Add Synonyms to Menu
 N MENUIEN
 S MENUIEN=$$FIND1^DIC(19,,"BX","MAGV HDIG MENU")
 I MENUIEN D
 . N IENS,MAGERR,ITEMIEN,FDA
 . S ITEMIEN=$$FIND1^DIC(19.01,","_MENUIEN_",",,"MAGV SEARCH PROBLEMS")
 . Q:'ITEMIEN
 . S IENS=ITEMIEN_","_MENUIEN_","
 . S FDA(19.01,IENS,2)="SRPR"
 . D FILE^DIE(,"FDA","MAGERR")
 . ;
 . K IENS,MAGERR,ITEMIEN
 . S ITEMIEN=$$FIND1^DIC(19.01,","_MENUIEN_",",,"MAGV RESOLVE PROBLEMS")
 . Q:'ITEMIEN
 . S IENS=ITEMIEN_","_MENUIEN_","
 . S FDA(19.01,IENS,2)="VRPR"
 . D FILE^DIE(,"FDA","MAGERR")
 ;
 Q
 ;
 ;***** PRE-INSTALL CODE
PRE ; Pre-Install
 N DIU,MAGFLD,MAGERR,MAGOPTID,MAGOPTDE,DA
 S MAGOPTID=$$FIND1^DIC(19,,"X","MAGV IDENTIFY DUPLICATES")
 S MAGOPTDE=$$FIND1^DIC(19,,"X","MAGV DELETE DUPLICATES")
 ; Delete Obsolete Options if they exist
 I MAGOPTID D
 . N MAGVRMI,DIK
 . S MAGVRMI=$$DELETE^XPDMENU("MAGV HDIG MENU","MAGV IDENTIFY DUPLICATES")
 . I MAGVRMI S DIK="^DIC(19,",DA=+$G(MAGOPTID) D ^DIK
 I MAGOPTDE D
 . N MAGVRMD,DIK
 . S MAGVRMD=$$DELETE^XPDMENU("MAGV HDIG MENU","MAGV DELETE DUPLICATES")
 . I MAGVRMD S DIK="^DIC(19,",DA=+$G(MAGOPTID) D ^DIK
 D FIELD^DID(2005.67,.01,,"LABEL","MAGFLD","MAGERR")
 ; If old DD exists, remove it
 I $G(MAGFLD("LABEL"))="DUPLICATE IEN" D
 . S DIU(0)="D",DIU="^MAGV(2005.67," D EN^DIU2
 Q
