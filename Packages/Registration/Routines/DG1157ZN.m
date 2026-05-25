DG1157ZN ;MNTVBB/DTA - PATIENT FILE ZERO NODE CLEAN-UP; DEC 10, 2025
 ;;5.3;Registration;**1157**;Aug 13, 1993;Build 6
 ;
 ; ICR#: 10103 $$FMADD^XLFDT
 ; Reference(s) to BMES^XPDUTL supported by ICR# 10141
 Q
EN ;routine entry point
 N DGPTIEN,DGPTCNT,DGPMIEN,DGOEIEN,DGNXTREC,DGPTIENS,DGNEWNM,DA,DR,DIE,DGNM,DGNMGD
 D BMES^XPDUTL("Search for "_"""B"""_" X-Refs for any Patient record with no zero node or NAME value")
 D CHKBXREF
 D BMES^XPDUTL("Search for Patient Movement or Outpatient Encounter pointers")
 D CHKPNTRS
 D BMES^XPDUTL("Updating Patient records without a zero node or null value for the NAME field")
 D UPDNM    ;update relevant records
 D BMES^XPDUTL("Update complete.")
 Q
CHKBXREF ;Look for "B" X-Refs for any Patient record with no zero(0) node or NAME value
 S (DGPTCNT,DGPTIEN,DGPMIEN,DGNMGD)=0
 F  S DGPTIEN=+$O(^DPT(DGPTIEN)) Q:DGPTIEN=0  D
 . ;Find Patients records without a zero node or a null value for the NAME (.01) field
 . I $P($G(^DPT(DGPTIEN,0)),"^",1)'=""  Q
 . S (DGNM,DGNMGD)="" F  S DGNM=$O(^DPT("B",DGNM)) Q:DGNM=""  D
 .. I $D(^DPT("B",DGNM,DGPTIEN)) S DGPTCNT=DGPTCNT+1 D BMES^XPDUTL(DGPTCNT_" Patient file "_"""B"""_" X-REF has "_DGNM_" for Patient IEN "_DGPTIEN) S DGNMGD=1 Q
 .. Q
 . Q:DGNMGD=1
 Q
CHKPNTRS ;Look for Patient Movement or Outpatient Encounter pointers to a Patient record with no zero(0) node or NAME value
 S (DGPTCNT,DGPTIEN,DGPMIEN,DGNMGD)=0
 F  S DGPTIEN=+$O(^DPT(DGPTIEN)) Q:DGPTIEN=0  D
 . ;Find Patients records without a zero node or a null value for the NAME (.01) field
 . I $P($G(^DPT(DGPTIEN,0)),"^",1)'=""  Q
 . I $D(^DGPM("C",DGPTIEN)) S DGPMIEN=$O(^DGPM("C",DGPTIEN,0)) S DGPTCNT=DGPTCNT+1 D BMES^XPDUTL(DGPTCNT_" Patient IEN "_DGPTIEN_" has a pointer to the Patient Movement record :"_DGPMIEN) Q
 . I $D(^SCE("C",DGPTIEN)) S DGOEIEN=$O(^SCE("C",DGPTIEN,0)) S DGPTCNT=DGPTCNT+1 D BMES^XPDUTL(DGPTCNT_" Patient IEN "_DGPTIEN_" has a pointer to the Outpatient Encounter record :"_DGOEIEN) Q
 . Q
 Q
UPDNM ;
 S (DGPTCNT,DGPTIEN,DGPMIEN,DGNMGD)=0
 S ^XTMP("DGNEWNM",0)=$$FMADD^XLFDT(DT,90)_U_DT_U_"DG UPDATE MISSING PATIENT FILE ZERO(0) NODE WITH DEFAULT NAME"
 F  S DGPTIEN=+$O(^DPT(DGPTIEN)) Q:DGPTIEN=0  D
 . ;Find Patients records without a zero node or a null value for the NAME (.01) field
 . I $P($G(^DPT(DGPTIEN,0)),"^",1)'=""  Q
 . S (DGNM,DGNMGD)="" F  S DGNM=$O(^DPT("B",DGNM)) Q:DGNM=""  D
 .. I $D(^DPT("B",DGNM,DGPTIEN)) S DGNMGD=1 Q
 .. Q
 . Q:DGNMGD=1
 . I $D(^DGPM("C",DGPTIEN)) Q
 . I $D(^SCE("C",DGPTIEN)) Q
 . S DGPTCNT=DGPTCNT+1
 . S ^XTMP("DGNEWNM",DT,DGPTCNT,DGPTIEN)=DGPTIEN
 . S DGNEWNM="ZZZPATIENT"_DGPTIEN_",MCLVII"
 . S DIE="^DPT(",DA=DGPTIEN,DR=".01////"_DGNEWNM
 . D ^DIE
 . Q
 D BMES^XPDUTL(DGPTCNT_" Records Updated")
 Q
