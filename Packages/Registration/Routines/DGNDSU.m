DGNDSU ;DAL/JCH - DEMOGRAPHICS NDS UTILITIES ;06/18/2017
 ;;5.3;Registration;**933**;Aug 13, 1993;Build 44
 ;
 Q
 ;
QUE ; Task off to run in background
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^DGNDSU"
 S ZTDESC="Demographics NDS Master File Associations"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 Q
 ;
EN ; Update Demographics pointers to MASTER files
 N DGFL,XUMF
 ; Update Demographics file pointers to MASTER file
 ;  RACE MASTER (#90) field in RACE (#10) points to RACE MASTER (#10.99) file
 ;  MASTER MARITAL STATUS(#90) field in MARITAL STATUS points to MASTER MARITAL STATUS file (#11.99)
 ;  MASTER RELIGION(#90) field in RELIGION (#13) points to MASTER RELIGION file (#13.99)
 S XUMF=1
 F DGFL=10,11,13 D UPDATE(DGFL)
 Q
 ;
UPDATE(OFILE) ; Update MASTER FILE multiple (#90) field pointers in legacy file (OFILE).
 ; Check ASSOCIATED VA <concept> field (#90) in MASTER file, add pointers in OFILE to MASTER file. 
 D SCANM(OFILE)
 ; Check pointers to MASTER file in OFILE, remove pointers if MASTER file entry doesn't exist.
 D SCANO(OFILE)
 ;
 K ^TMP($J,"DGNDS")
 Q
 ;
SCANM(OFILE) ; Get ASSOCIATED VA <concept> field (#99) values from MASTER file MFILE, update pointers in OFILE
 N ASSOC,MIEN,MGLO,MERR,MFILE
 D FIELD^DID(OFILE,90,"","POINTER","MGLO","MERR")      ; Get global name and related MASTER file of OFILE
 S MGLO="^"_$G(MGLO("POINTER"))                        ; MASTER file global
 S MFILE=+$P(MGLO,"(",2)                               ; MASTER file number
 S ASSOC="" F  S ASSOC=$O(@(MGLO_"""AC"",ASSOC)")) Q:ASSOC=""  D      ; ASSOCIATED VA <concept> multiple (#99)
 .S MIEN=0 F  S MIEN=$O(@(MGLO_"""AC"",ASSOC,MIEN)")) Q:'MIEN  D
 ..S MIEN(1)=MIEN
 ..D UPDPTR(ASSOC,.MIEN,"ADD",OFILE)
 Q
 ;
SCANO(OFILE) ; Get MASTER <concept> field (#90) values from legacy file OFILE, verify MASTER entry has matching ASSOCIATED entry
 ;   Unless - if the local file (OFILE) entry has NEVER been filed into ANY ASSOCIATED VA <concept> fields, assume it's a local
 ;   (non-standard or orphan) entry in local file OFILE and allow it to be mapped to MASTER. Check Audit trail for OFILE to see
 ;   if MASTER file pointer has ever been updated via MFS process for the OFILE entry, if not, quit and allow it to remain.
 N OFILIEN,OGLO,OERR,MPTR,MFILE,MGLO,DGAUGLO,DGAUDT
 S DGAUGLO="^TMP($J,""DGNDS"")",DGAUDT=$$NOW^XLFDT()
 D CHANGED^DIAUTL(OFILE,90,"O",DGAUGLO,"",DGAUDT)
 D FILE^DID(OFILE,"","GLOBAL NAME","OGLO","OERR")   ; Get global name for OFILE 
 S OGLO=$G(OGLO("GLOBAL NAME"))
 D FIELD^DID(OFILE,90,"","POINTER","MGLO","MERR")   ; Get MASTER <concept> file global name and file number
 S MGLO="^"_$G(MGLO("POINTER"))
 S MFILE=+$P(MGLO,"(",2)
 S OFILIEN=0 F  S OFILIEN=$O(@(OGLO_OFILIEN_")")) Q:'OFILIEN  D   ; Loop through pointers to MASTER file field (#90)
 .S MPTR=$G(@(OGLO_OFILIEN_","_"""MASTER"")")) Q:'MPTR
 .N DGRESULT,ONAME,ODA,MNAME,MFILESUB,DGERROR
 .D FIND^DIC(OFILE,,,"A",OFILIEN,,,,,"RESULT")                    ; Find entries in 
 .S ONAME=$G(RESULT("DILIST",1,1))
 .Q:'$D(^TMP($J,"DGNDS",OFILIEN))     ; Allow local mappings, if local file name associated with OFILIEN was never filed into ASSOCIATED VA <concept> (audited)
 .K RESULT
 .D FIND^DIC(MFILE,,,"A",MPTR,,,,,"RESULT")
 .S MNAME=$G(RESULT("DILIST",1,1))
 .S MFILESUB=MFILE_901
 .D FIND^DIC(MFILESUB,","_MPTR_",",".01","",ONAME,,,,,"DGRESULT","DGERROR")
 .I '$G(DGRESULT("DILIST",2,1)) S ODA(1)=MPTR D UPDPTR(ONAME,.ODA,"DEL",OFILE)
 Q
 ;
UPDPTR(DGVANAM,DGDA,DGACT,DGFILE) ; Update MASTER VA <concept> field (#90) in <concept> file 
 ; anytime the ASSOCIATED VA <concept>(S) field (#99) in the MASTER <concept> file (#10.99, 11.99, or 13.99) is updated.
 ;   DGFILE   :   The VA File Number (#10, #11, or #13) that points to the MASTER file (#10.99, #11.99, #13.99) 
 ;   DGXVAL   :   Value of ASSOCIATED VA <concept>(S) field (#99) in the MASTER <concept> file (#10.99, 11.99, or 13.99).
 ;   DGDA(1)  :   Value of DA()
 ;                  DGDA  = ASSOCIATED VA <concept>(S) sub-file (#10.99901, 11.99901, or 13.99901) IEN value
 ;                DGDA(1) = IEN of the entry in the MASTER <concept> (#10.99, 11.99, or 13.99) file.
 ;   DGACT    : Action to perform on MASTER <concept> (#90) multiple in <concept> (#10):
 ;                 "ADD"  = Add a pointer to the DGMIEN entry in MASTER <concept> (#10.99, 11.99, or 13.99) file, if it doesn't already exist
 ;                 "DEL"  = Delete pointer to the DGMIEN entry in MASTER <concept> (#10.99, 11.99, or 13.99) file, if it exists
 N DGMFILE   ; MASTER <concept> file (#10.99, #11.99, or 13.99), retrieved from "MASTER <concept>" field (#90) in <concept> file (#10, 11, or #13)
 N DGNDSGLO  ; Data global for MASTER <concept> file (10.99, 11.99, or 13.99)
 N DGMSUB    ; MASTER <concept> file's ASSOCATED VA <concepts> field's (#99) SUB-FILE number. (10.99901, 11.99901, or 13.99901)
 N DGFDA     ; FDA_ROOT array for FILE^DIE call.
 N DGERR     ; Error returned by FILE^DIE call. Not used, provided for maintenance/troubleshooting.
 N DGMIEN    ; IEN of the MASTER <concept> (#10.99, 11.99, or 13.99) file entry being modified 
 N DGVAIEN   ; The IEN(s) in the <concept> (#10, #11, OR #13) file, whose MASTER <concept> multiple (#90) is being updated by this routine.
 N DGVAMPTR  ; The current value of the MASTER <concept> multiple (#90) in the <concept> (#10, #11, OR #13) file, pointing to MASTER <concept> (#10.99, 11.99, or 13.99).
 N DGVANAMS  ; <concept> (#10) file NAME (.01) value truncated to 30 characters to check "B" x-ref, which only contains max of 30 chars.
 ;
 S DGMIEN=$G(DGDA(1))
 Q:'DGMIEN!'$L(DGVANAM)!'$L(DGACT)!'$G(DGFILE)
 S DGVANAMS=$E(DGVANAM,1,30)
 ;
 ; Get MASTER <concept> file number and data global. File number must be 10.99 (MASTER RACE), 11.99 (MASTER MARITAL STATUS), or 13.99 (MASTER RELIGION)
 ; Get data global reference
 D FIELD^DID(DGFILE,90,"","POINTER","DGNDSGLO","DGERR")
 S DGNDSGLO="^"_$G(DGNDSGLO("POINTER"))
 S DGMFILE=+$P(DGNDSGLO,"(",2)
 Q:(",10.99,11.99,13.99,")'[(","_DGMFILE_",")
 ; 
 ; Get MASTER <concept> file's ASSOCATED VA <concepts> field's (#99) SUB-FILE number. Must be 10.99901, 11.99901, or 13.99901
 S DGMSUB=DGMFILE_"901"
 Q:(",10.99901,11.99901,13.99901,")'[(","_DGMSUB_",")
 ; Search for and delete old MASTER <concept> (#90) field entries from <concept> (#10,#11, or #13) file that are being replaced
 S DGVAIEN=0 F  S DGVAIEN=$O(^DIC(DGFILE,"B",DGVANAMS,DGVAIEN)) Q:'DGVAIEN  D
 .I DGACT="ADD" D  Q
 ..S DGVAMPTR=+$G(^DIC(DGFILE,DGVAIEN,"MASTER"))
 ..I $G(^DIC(DGFILE,DGVAIEN,"MASTER",DGVAMPTR,0))=DGMIEN Q   ; Already there, don't file duplicate entry.
 ..S DGFDA(DGFILE,DGVAIEN_",",90)=+DGMIEN
 ..D FILE^DIE("","DGFDA","DGERR")
 .I DGACT="DEL" D  Q     ;   Delete the MASTER <concept> (#90) field pointer from <concept> (#10) file entry DGVAIEN
 ..Q:$G(^DIC(DGFILE,DGVAIEN,"MASTER"))'=DGMIEN    ; This should not happen, but, if it does, do no harm. X-ref is different than field value.
 ..S DGFDA(DGFILE,DGVAIEN_",",90)="@"
 ..D FILE^DIE("","DGFDA","DGERR")
 Q
