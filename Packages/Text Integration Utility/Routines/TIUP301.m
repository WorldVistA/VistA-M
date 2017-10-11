TIUP301 ; SLC/DJH - Patch 301 post-install routine  ; 1/11/17 4:54pm
 ;;1.0;TEXT INTEGRATION UTILITIES;**301**;;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ; TIU*1.0*301
 ; This routine sets the parameter 'UPLOAD FILING ERROR CODE'
 ; from 'D GETPN^TIUCHLP' to 'D CNFIX^TIUCNFIX' for all CONSULTS
 ; document types & from 'D GETPN^TIUCHLP' to 'D PNFIX^TIUPNFIX'
 ; for all PROGRESS NOTES document types.   This is to resolve 
 ; issues caused by facilities who didn't complete the post install
 ; instructions for patch TIU*1.0*131 or didn't complete the
 ; instructions because they didn't upload CONSULTS or PROGRESS NOTES
 ; when patch 131 was installed.
 ;
 ; EXTERNAL REFERENCES
 ;  $$FIND1^DIC
 ;  $$GET1^DIQ
 ;  $$HTE^XLFDT
 ;  $$NOW^XLFDT
 ;  $$FMADD^XLFDT
 ;  $$FMTH^XLFDT
 ;  $$FMTE^XLFDT
 ;  BMES^XPDUTL
 ;  MES^XPDUTL
 ;  FILE^DIE
 ;  ^XMD
EN ;
 N IEN,TIUIEN,TIUIEN2,TIUCONS,TIUPN,IND,TIUDOCN,CNT,BEGDT,TXT
 N NAMSP,TIUBADV,TIUPARAM,MSG,TYPE,PATCH,JOBN,IND,DOCTYPE
 N PURGDT,TEXT,TIUCURR,TIUMSG,FDARR,IENS,ERR,FLAGS,REPORT
 S NAMSP=$$NAMSP,PATCH="TIU*1.0*301"
 S JOBN="TIU PATCH 301 INSTALL"
 S IND=$J(" ",8),CNT=1000,MSG(CNT)="",CNT=CNT+1
 S TIUBADV="D GETPN^TIUCHLP"   ; Bad param value
 ; Get the IENs for PATIENT RECORD FLAG CAT I/II Doc Class
 ;
 ; INITIALIZE ^XTMP
 S BEGDT=$$NOW^XLFDT,PURGDT=$$FMADD^XLFDT(BEGDT,365)  ;365 day life
 S ^XTMP(NAMSP,0)=PURGDT_"^"_BEGDT_"^"_PATCH
 S ^XTMP(NAMSP,0,"STATUS")="RUN^"_$$NOW^XLFDT_"^^^"
 ;
 D MESSHDR ; Build message header
 ;
 ; PROCESS CONSULTS
 S TIUCONS=$$FIND1^DIC(8925.1,"","X","CONSULTS","B") ; Consults IEN
 S MSG(CNT)="CONSULTS:",CNT=CNT+1
 S TYPE=TIUCONS
 S TIUPARAM="D CNFIX^TIUCNFIX"
 S DOCTYPE=$$GET1^DIQ(8925.1,TIUCONS,.04)
 ;Consults is a stand-alone class
 I DOCTYPE="CLASS" D
 . D FIX(TYPE) ;fix CL record first
 . D GETCL
 ; Consults is a Document Class
 I DOCTYPE'="CLASS" D
 . D FIX(TYPE) ;fix DC record first
 . S TIUIEN=TYPE
 . D GETDOC
 ;
 ; PROCESS PROGRESS NOTES
 S TIUPN=$$FIND1^DIC(8925.1,"","X","PROGRESS NOTES","B") ; Progress Notes CL IEN
 S MSG(CNT)="PROGRESS NOTES:",CNT=CNT+1
 S TYPE=TIUPN
 S TIUPARAM="D PNFIX^TIUPNFIX"
 D FIX(TYPE)  ; First fix CL record
 D GETCL
 ;
 D MAIL
 Q
 ;
 ; =============== SUBROUTINES =================
 ;
MESSHDR ; Build message header
 S MSG(CNT)="PATCH TIU*1.0*301 INSTALL",CNT=CNT+1
 S MSG(CNT)="   UPLOAD FILING ERROR CODE (Field 4.8) Review:",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="   IEN  Document Name (Type)",CNT=CNT+1
 S MSG(CNT)="        Result",CNT=CNT+1
 S MSG(CNT)="--------------------------------------------",CNT=CNT+1
 Q
 ;
GETCL ; Find all DOCUMENT CLASSES within the Class
 S TIUIEN=0
 F  S TIUIEN=$O(^TIU(8925.1,TYPE,10,"B",TIUIEN)) Q:'TIUIEN  D
 . ;Skip Consults
 . Q:TIUIEN=TIUCONS
 . D:$$GET1^DIQ(8925.1,TIUIEN,4.8)'="" FIX(TIUIEN)
 . D GETDOC
 Q
 ;
GETDOC ; Find all DOCUMENTS within the Document Class
 S TIUIEN2=0
 F  S TIUIEN2=$O(^TIU(8925.1,TIUIEN,10,"B",TIUIEN2)) Q:'TIUIEN2  D
 . Q:TIUIEN2=TIUCONS
 . Q:$$GET1^DIQ(8925.1,TIUIEN2,4.8)=""  ; No value
 . D FIX(TIUIEN2)
 Q
 ; 
FIX(IEN) ;
 S TIUDOCN=$$GET1^DIQ(8925.1,IEN,.01)_" ("_$$GET1^DIQ(8925.1,IEN,.04)_")"
 S TIUCURR=$$GET1^DIQ(8925.1,IEN,4.8)  ; current value in field 4.8
 S REPORT=0
 ;
 I TIUCURR'=TIUPARAM,TIUCURR'=TIUBADV Q
 ;
 S MSG(CNT)=$J(IEN,6)_"  "_TIUDOCN,CNT=CNT+1
 ;
 I TIUCURR=TIUPARAM D
 . S MSG(CNT)=IND_"No change.  Value is already "_TIUPARAM,CNT=CNT+1
 ;
 I TIUCURR=TIUBADV D
 . S IENS=""""_IEN_","""
 . S FDARR="FDA(8925.1,"_IENS_")",FLAGS="K"
 . S @FDARR@(4.8)=TIUPARAM
 . D FILE^DIE(FLAGS,"FDA","TIUMSG")
 . I '$D(TIUMSG) S MSG(CNT)=IND_TIUCURR_" changed to "_TIUPARAM,CNT=CNT+1 Q
 . S ERR=0 F  S ERR=$O(TIUMSG("DIERR",1,"TEXT",ERR)) Q:ERR=""  D
 . . S MSG(CNT)=IND_TIUMSG("DIERR",1,"TEXT",ERR),CNT=CNT+1
 . S MSG(CNT)=IND_"Needs to be manually updated to "_TIUPARAM,CNT=CNT+1
 Q
 ;
MAIL ;
 N XMY,XMDUZ,DIFROM,XMSUB,XMTEXT,NMSP,VAR
 S XMY(DUZ)=""
 S XMY("G.TIU CACS")=""
 S XMY("G.PATIENT SAFETY NOTIFICATIONS")=""
 S XMSUB="PATCH TIU*1.0*301 INSTALL",XMTEXT="MSG(",XMDUZ="Patch TIU*1.0*301"
 S CNT=1
 S MSG(CNT)="PATCH TIU*1.0*301 completed processing.",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="This patch reviewed field 4.8 (UPLOAD FILING ERROR CODE) in TIU DOCUMENT",CNT=CNT+1
 S MSG(CNT)="DEFINITIONS for document classes and titles belonging to CONSULTS and PROGRESS",CNT=CNT+1
 S MSG(CNT)="NOTES.  Any values that equaled the pre-patch TIU*1.0*131 value of",CNT=CNT+1
 S MSG(CNT)="'D GETPN^TIUCHLP' and were not in use at the time of the install ('locked')",CNT=CNT+1
 S MSG(CNT)="were updated as follows:",CNT=CNT+1
 S MSG(CNT)="   1.  CONSULTS were changed to 'D CNFIX^TIUCNFIX', PROGRESS NOTES were changed",CNT=CNT+1
 S MSG(CNT)="       to 'D PNFIX^TIUPNFIX'.",CNT=CNT+1
 S MSG(CNT)="   2.  Any classes or titles that were locked during the install NEED TO",CNT=CNT+1
 S MSG(CNT)="       BE MANUALLY UPDATED using option TIU UPLOAD PARAMETER EDIT.",CNT=CNT+1
 S MSG(CNT)="   3.  Any values other than 'D GETPN^TIUCHLP' were not changed and are noted",CNT=CNT+1
 S MSG(CNT)="       only in the install file for historical purposes and no action to them",CNT=CNT+1
 S MSG(CNT)="       is required with this patch.",CNT=CNT+1
 S MSG(CNT)="   4.  Any field 4.8 without a value were not changed and are not listed.",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="**IMPORTANT NOTE**  The 'Enhanced Mismatched Consults List' [TIU144",CNT=CNT+1
 S MSG(CNT)="ENHANCED MISMATCH LIST] should be run regularly. Please take a moment now",CNT=CNT+1
 S MSG(CNT)="to run it and create a reminder in your calendar to run it again every",CNT=CNT+1
 S MSG(CNT)="6 months.  If there are any mismatches submit a help desk ticket for",CNT=CNT+1
 S MSG(CNT)="assistance resolving them.",CNT=CNT+1
 ;
 D ^XMD
 Q
 ;
NAMSP() ;
 Q $T(+0)
