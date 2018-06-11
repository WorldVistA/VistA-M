PSSNDSU ;DAL/JCH - MEDS DOSAGE FORM NDS UTILITIES ;09/07/2017
 ;;1.0;PHARMACY DATA MANAGEMENT;**211**;9/30/97;Build 20
 ;
 Q
 ;
QUE ; Task off to run in background
 N ZTRTN,ZTDESC,ZTDTH
 ;
 S ZTRTN="EN^PSSNDSU"
 S ZTDESC="Medications Dosage Form NDS Master File Associations"
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 ;
 D ^%ZTLOAD
 Q
 ;
EN ; Update Meds Dosage Form pointers to MASTER file
 N PSSFL,XUMF
 S XUMF=1
 S PSSFL=$P($T(FILE+1),";",3)
 Q:'$G(PSSFL)
 ;  MASTER <concept> field (#90) in <concept> file points to MASTER <concept> file
 D UPDATE(PSSFL)
 Q
 ;
UPDATE(OFILE) ; Update MASTER FILE multiple (#90) field pointers in legacy file (OFILE).
 ; Check ASSOCIATED VA <concept> field (#90) in MASTER file, add pointers in OFILE to MASTER file. 
 D SCANM(OFILE)
 ; Check pointers to MASTER file in OFILE, remove pointers if MASTER file entry doesn't exist.
 D SCANO(OFILE)
 Q
 ;
SCANM(OFILE) ; Get ASSOCIATED VA <concept> field (#99) values from MASTER file MFILE, update pointers in OFILE
 N ASSOC,MIEN,MGLO,MERR,MFILE,OFILIEN
 D FIELD^DID(OFILE,90,"","POINTER","MGLO","MERR")      ; Get global name and related MASTER file of OFILE
 S MGLO="^"_$G(MGLO("POINTER"))                        ; MASTER file global
 S MFILE=+$P(MGLO,"(",2)                               ; MASTER file number
 S ASSOC="" F  S ASSOC=$O(@(MGLO_"""AC"",ASSOC)")) Q:ASSOC=""  D      ; ASSOCIATED VA <concept> multiple (#99)
 .S MIEN=0 F  S MIEN=$O(@(MGLO_"""AC"",ASSOC,MIEN)")) Q:'MIEN  D
 ..S OFILIEN=$$FIND1^DIC(OFILE,,"O",ASSOC,,,"PSERR")
 ..Q:'$G(OFILIEN)
 ..D UPDPTR(ASSOC,MIEN,"ADD",OFILE)
 Q
 ;
SCANO(OFILE) ; Get MASTER <concept> field (#90) values from legacy file OFILE, verify pointing to actual MASTER entry 
 N OFILIEN,OGLO,OERR,MPTR,MFILE,MGLO,PSIEN
 D FILE^DID(OFILE,"","GLOBAL NAME","OGLO","OERR")   ; Get global name for OFILE 
 S OGLO=$G(OGLO("GLOBAL NAME"))
 D FIELD^DID(OFILE,90,"","POINTER","MGLO","MERR")   ; Get MASTER <concept> file global name and file number
 S MGLO="^"_$G(MGLO("POINTER"))
 S MFILE=+$P(MGLO,"(",2)
 S OFILIEN=0 F  S OFILIEN=$O(@(OGLO_OFILIEN_")")) Q:'OFILIEN  D   ; Loop through pointers to MASTER file field (#90)
 .S MPTR=$G(@(OGLO_OFILIEN_","_"""MASTER"")")) Q:'MPTR
 .N PSSRSLT,ONAME,MNAME,MFILESUB,PSSERR
 .D FIND^DIC(OFILE,,"@;.01","A",OFILIEN,,,,,"PSSRSLT","PSSERR")
 .S ONAME=$G(PSSRSLT("DILIST","ID",1,.01))
 .K PSSRSLT
 .D FIND^DIC(MFILE,,"@;.01","A",MPTR,,,,,"PSSRSLT","PSSERR")
 .S MNAME=$G(PSSRSLT("DILIST","ID",1,.01))
 .S MFILESUB=MFILE_901
 .K PSSRSLT
 .D FIND^DIC(MFILESUB,","_MPTR_",",".01","",ONAME,,,,,"PSSRSLT","PSSERROR")
 .I '$G(PSSRSLT("DILIST",2,1)) D UPDPTR(ONAME,MPTR,"DEL",OFILE)
 Q
 ;
UPDPTR(PSSVANAM,PSSMIEN,PSSACT,PSSFILE) ; Update MASTER VA <concept> field (#90) in <concept> file 
 ; anytime the ASSOCIATED VA <concept>(S) field (#99) in the MASTER <concept> file (#50.60699) is updated.
 ;  PSSVANAM   : Name of ASSOCIATED VA <concept> from local <concept> file
 ;   PSSFILE   : The VA File Number (#50.606) that points to the MASTER file (#50.60699) 
 ;   PSSMIEN   : IEN of the entry in the MASTER <concept> (#50.60699) file.
 ;   PSSACT    : Action to perform on MASTER <concept> (#90) multiple in <concept> file (#50.606):
 ;                 "ADD"  = Add a pointer to the PSSMIEN entry in MASTER <concept>  file (#50.60699), if it doesn't already exist
 ;                 "DEL"  = Delete pointer to the PSSMIEN entry in MASTER <concept> file (#50.60699), if it exists
 N PSSMFILE   ; MASTER <concept> file (#50.60699), retrieved from "MASTER <concept>" field (#90) in <concept> file (#50.606)
 N PSSMGLO    ; Data global for MASTER <concept> file (#50.60699)
 N PSSGLO     ; Data global for legacy <concept) file (#50.606)
 N PSSMSUB    ; MASTER <concept> file's (#50.60699) ASSOCATED VA <concepts> field's (#99) SUB-FILE number. (#50.60699901)
 N PSSFDA     ; FDA_ROOT array for FILE^DIE call.
 N PSSERR     ; Error returned by FILE^DIE call. Not used, provided for maintenance/troubleshooting.
 N PSSVAIEN   ; The IEN(s) in the <concept> file (#50.606), whose MASTER <concept> multiple (#90) is being updated by this routine.
 N PSSVAMPTR  ; The current value of the MASTER <concept> file (#50.60699) multiple (#90) in the <concept> file (#50.606), pointing to MASTER <concept> (#50.60699)
 N PSSVANAMS  ; <concept> (#50.606) file NAME (.01) value truncated to 30 characters to check "B" x-ref, which only contains max of 30 chars.
 N PSSIEN     ; Internal Entry Number (IEN) of local file (#50.606)
 ;
 Q:'PSSMIEN!'$L(PSSVANAM)!'$L(PSSACT)!'$G(PSSFILE)
 S PSSVANAMS=$E(PSSVANAM,1,30)
 ;
 ; Get MASTER <concept> file number and data global. File number must be 50.60699 (MASTER DOSAGE FORM)
 ; Get data global reference
 D FIELD^DID(PSSFILE,90,"","POINTER","PSSMGLO","PSSERR")
 S PSSMGLO="^"_$G(PSSMGLO("POINTER"))
 S PSSMFILE=+$P(PSSMGLO,"(",2)
 Q:(",50.60699,")'[(","_PSSMFILE_",")
 ;
 D FILE^DID(PSSFILE,"N","GLOBAL NAME","PSSGLO","PSSERR")
 S PSSGLO=$G(PSSGLO("GLOBAL NAME"))
 ;
 ; Get MASTER <concept> file's ASSOCATED VA <concepts> field's (#99) SUB-FILE number. Must be 50.60699901
 S PSSMSUB=PSSMFILE_"901"
 Q:(",50.60699901,")'[(","_PSSMSUB_",")
 ; Search for and delete old MASTER <concept> (#90) field entries from <concept> file (#50.606) that are being replaced
 S PSSIEN=0 F  S PSSIEN=$O(@(PSSGLO_"""B"",PSSVANAM,PSSIEN)")) Q:'PSSIEN  D
 .I PSSACT="ADD" D  Q
 ..I $G(@(PSSGLO_"PSSIEN,""MASTER"")"))=PSSMIEN Q   ; Already there, don't file duplicate entry.
 ..S PSSFDA(PSSFILE,PSSIEN_",",90)=+PSSMIEN
 ..D FILE^DIE("","PSSFDA","PSSERR")
 .I PSSACT="DEL" D  Q     ;   Delete the MASTER <concept> (#90) field pointer from <concept> file (#50.606) entry PSSVAIEN
 ..Q:'$G(PSSIEN)
 ..S PSSFDA(PSSFILE,PSSIEN_",",90)="@"
 ..D FILE^DIE("","PSSFDA","PSSERR")
 Q
 ;
FILE ; File to be updated
 ;;50.606
 Q
