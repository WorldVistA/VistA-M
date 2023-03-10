ORY569 ;ISP/LMT - OR*3*569 Post-Install ;Jul 13, 2022@14:02:50
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**569**;Dec 17, 1997;Build 23
 ;
 ;
 ; Reference to ^LAB(69.73, in ICR #7216
 ;
 Q
 ;
 ;
POST ;
 ;
 N ORFILENUM,ORROOT
 ;
 ; move over data from 69.73 to 101.45
 I $O(^LAB(69.73,0)),'$O(^ORD(101.45,0)) D
 . D BMES("Moving over data from 69.73 to 101.45.")
 . M ^ORD(101.45)=^LAB(69.73)
 . ; update 0 node with new name and file number
 . S $P(^ORD(101.45,0),U,1)="AP DIALOG CONFIG"
 . S ORFILENUM=$P(^ORD(101.45,0),U,2)
 . S $P(^ORD(101.45,0),U,2)=101.45_$E(ORFILENUM,6,$L(ORFILENUM))
 . ;
 . ; now replace references to 69.73 in 0 node of multiples
 . S ORROOT=$NA(^ORD(101.45))
 . F  S ORROOT=$Q(@ORROOT) Q:ORROOT=""  Q:$QS(ORROOT,1)'=101.45  D
 . . I $QS(ORROOT,$QL(ORROOT))'=0 Q   ;only look for 0 nodes
 . . I $P(@ORROOT,U,1)'="" Q  ; 1st piece must be null
 . . S ORFILENUM=$P(@ORROOT,U,2)
 . . I ORFILENUM'[69.73 Q  ;2nd piece must contain 69.73
 . . S $P(@ORROOT,U,2)=101.45_$E(ORFILENUM,6,$L(ORFILENUM))
 . ;
 . ; Convert file to new format
 . D BMES("Converting AP DIALOG CONFIG File (#101.45)...")
 . D CONVERT,REINDEX
 ; Update file even if it's already installed
 D BMES("Updating AP DIALOG CONFIG File (#101.45)...")
 D UPDATE
 D BMES("Done")
 ;
 D TASK
 ;
 Q
 ;
 ;
TASK ; Task - AP Order Dialog - Make OPSPH Required
 ;
 N ZTDTH,ZTSAVE,ZTIO,ZTSK,ZTRTN,ZTDESC,ZTUCI,ZTCPU,ZTSYNC,ZTKIL
 ;
 S ZTRTN="UPDOPSPH^ORY569"
 S ZTDESC="AP Order Dialog - Make OPSPH Required"
 S ZTIO=""
 S ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D BMES("""AP Order Dialog - Make Provider Required"" has been queued, task number "_ZTSK)
 I '$G(ZTSK) D BMES("ERROR: ""AP Order Dialog - Make Provider Required"" failed to queue. Please enter a SNOW ticket.")
 ;
 Q
 ;
 ;
CONVERT ; Convert file - Move Orderable Item pointer from .01 field to .04 field
 N I,X0,IDX,NAME
 S I=0
 F  S I=$O(^ORD(101.45,I)) Q:'I  S X0=$G(^ORD(101.45,I,0)) I X0'="" D
 . S NAME="",IDX=$P(X0,U) I $P(X0,U,4)="" D
 . . I +IDX>0 S NAME=$P($G(^ORD(101.43,IDX,0)),U)
 . . I NAME="" S NAME=IDX
 . . S $P(X0,U,1)=NAME,$P(X0,U,4)=IDX
 . . S ^ORD(101.45,I,0)=X0
 Q
 ;
REINDEX ; Rebuild cross references
 N DA,DIK
 K ^ORD(101.45,"B"),^ORD(101.45,"C")
 S DIK="^ORD(101.45," D IXALL^DIK
 Q
 ;
UPDATE ; Update File Contents
 N IDX,PAGE,X0,RID,NAME,ID,PNAME,NAT,ISNAT
 S RID("Clinical History")="CLINHX"
 S RID("Pre-Operative Diagnosis")="PREOPDX"
 S RID("Operative Findings")="OPFIND"
 S RID("Post-Operative Findings")="POSTOPDX"
 S NAT="^BONE MARROW^BRONCHIAL BIOPSY^BRONCHIAL CYTOLOGY^DERMATOLOGY^FINE NEEDLE ASPIRATE^GASTROINTESTINAL ENDOSCOPY"
 S NAT=NAT_"^GENERAL FLUID^GYNECOLOGY (PAP SMEAR)^RENAL BIOPSY^TISSUE EXAM^URINE^UROLOGY,BLADDER/URETER^UROLOGY,PROSTATE^"
 S IDX=0 F  S IDX=$O(^ORD(101.45,IDX)) Q:'IDX  D
 . S X0=$G(^ORD(101.45,IDX,0)),NAME=$P(X0,U),ISNAT=(NAT[(U_NAME_U))
 . I ISNAT'=$P(X0,U,5) S $P(^ORD(101.45,IDX,0),U,5)=ISNAT
 . S PAGE=0 F  S PAGE=$O(^ORD(101.45,IDX,2,PAGE)) Q:'PAGE  D
 . . S X0=$G(^ORD(101.45,IDX,2,PAGE,0)),PNAME=$P(X0,U,2),ID=$P(X0,U,5)
 . . I PNAME'="",$D(RID(PNAME)),ID'=RID(PNAME) D
 . . . S $P(^ORD(101.45,IDX,2,PAGE,0),U,5)=RID(PNAME)
 . . . D BMES(NAME_" Page "_PAGE_" ("_PNAME_") RESPONSE ID set to "_RID(PNAME))
 Q
 ;
 ;
UPDOPSPH  ; Tasked job to make the OPSPH-Surgeon/Provider Order Prompt Required, once OR*3*405 is installed
 ;
 ; ZEXCEPT: ZTREQ
 N OR0,ORFDA,ORHIDE,ORIEN,ORREQUIRED,ORSPHIEN
 ;
 ; If this task is still tasked by 10/1/23 than something went wrong
 ; with the expected v32b release, and stop requeuing it
 I $$DT^XLFDT>3231001 D  Q
 . S ZTREQ="@"
 ;
 ; v32b still not installed; reschedule to try again T+1@04:00
 I '$$PATCH^XPDUTL("OR*3.0*405") D  Q
 . S ZTREQ=$$FMADD^XLFDT($$DT^XLFDT,1,4,0,0)
 ;
 ; v32b is installed. Update the Surgeon/Provider Order Prompt and make it Required
 ;
 S ZTREQ="@"
 ;
 S ORIEN=0
 F  S ORIEN=$O(^ORD(101.45,ORIEN)) Q:'ORIEN  D
 . I '$P(^ORD(101.45,ORIEN,0),U,5) Q  ; Quit if not national entry
 . ;
 . S ORSPHIEN=$O(^ORD(101.45,ORIEN,1,"B","OPSPH",0))
 . ;
 . I ORSPHIEN D  Q
 . . S OR0=$G(^ORD(101.45,ORIEN,1,ORSPHIEN,0))
 . . S ORHIDE=$P(OR0,U,2)
 . . S ORREQUIRED=$P(OR0,U,3)
 . . I ORHIDE S ORFDA(101.451,ORSPHIEN_","_ORIEN_",",.02)="@"
 . . I 'ORREQUIRED S ORFDA(101.451,ORSPHIEN_","_ORIEN_",",.03)=1
 . . I $D(ORFDA) D FILE^DIE("","ORFDA")
 . ;
 . I 'ORSPHIEN D  Q
 . . S ORFDA(101.451,"+1,"_ORIEN_",",.01)="OPSPH"
 . . S ORFDA(101.451,"+1,"_ORIEN_",",.03)=1
 . . D UPDATE^DIE("","ORFDA")
 ;
 Q
 ;
BMES(STR) ;
 ; Write string
 N OUTPUT,IDX,TAG1,TAG2
 S TAG2="MES^XPDUTL($$TRIM^XLFSTR($$CJ^XLFSTR(OUTPUT(IDX),$G(IOM,80)),""R"","" ""))"
 S TAG1="B"_TAG2
 D WRAP^ORUTL(STR,"OUTPUT",1,0,2,0,78)
 S IDX=0 F  S IDX=$O(OUTPUT(IDX)) Q:'IDX  D
 . I IDX=1 D @TAG1  I 1
 . E  D @TAG2
 Q
