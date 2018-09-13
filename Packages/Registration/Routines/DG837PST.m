DG837PST ;BIR/PTD/ELZ/CKN-PATCH DG*5.3*837 POST INSTALLATION ROUTINE ; 1/3/12 1:30pm
 ;;5.3;Registration;**837**;Aug 13, 1993;Build 5
 ;
 D IDFLD,ALIAS
 D EP  ;MVI_791 - Conversion process for TF file #391.91
 Q
 ;
IDFLD ;MVI_876 (ptd) - Turn on Audit for the new DoD identification fields
 ;Do not run module if patch DG*5.3*837 previously installed.
 I $$PATCH^XPDUTL("DG*5.3*837") Q
 N FLDNUM
 S FLDNUM=991.08 D TURNON^DIAUTL(2,FLDNUM)
 D BMES^XPDUTL("The TEMPORARY ID NUMBER #"_FLDNUM_" field in the PATIENT file is set to AUDIT.")
 S FLDNUM=991.09 D TURNON^DIAUTL(2,FLDNUM)
 D BMES^XPDUTL("The FOREIGN ID NUMBER #"_FLDNUM_" field in the PATIENT file is set to AUDIT.")
 Q
 ;
ALIAS ;MVI_805 (elz) - clean up Alias multiple in patient (#2) file.
 ;Do not run module if patch DG*5.3*837 previously installed.
 I $$PATCH^XPDUTL("DG*5.3*837") Q
AGAIN ;Line tag to be called if module needs to be run again.
 N DGNM,DFN,DGX,FDA,DGERR
 D BMES^XPDUTL("Cleaning up duplicate Alias PATIENT file entries.")
 K ^TMP("DG837PST",$J)
 S DGNM="" F  S DGNM=$O(^DPT("B",DGNM)) Q:DGNM=""  S DFN=0 F  S DFN=$O(^DPT("B",DGNM,DFN)) Q:'DFN  I $O(^DPT("B",DGNM,DFN,0)) S ^TMP("DG837PST",$J,DFN)=""
 S DFN=0 F  S DFN=$O(^TMP("DG837PST",$J,DFN)) Q:'DFN  D
 . N DGALIAS
 . S DGX=0 F  S DGX=$O(^DPT(DFN,.01,DGX)) Q:'DGX  D
 .. S DGALIAS=$P($G(^DPT(DFN,.01,DGX,0)),"^",1,2) Q:DGALIAS=""
 .. I '$D(DGALIAS(DGALIAS)) S DGALIAS(DGALIAS)="" Q
 .. S FDA(2.01,DGX_","_DFN_",",.01)="@" D FILE^DIE("E","FDA","DGERR")
 .. I $G(DGERR("DIERR",1,"TEXT",1))'=""  D BMES^XPDUTL("ERROR: DFN"_DFN_" "_DGERR("DIERR",1,"TEXT",1))
 D BMES^XPDUTL("Done cleaning up Duplicate Alias entries.")
 K ^TMP("DG837PST",$J)
 Q
 ;
EP ;MVI_791 (ckn) - Post install routine entry point for TF conversion process
 N RESTART
 S RESTART=0
 I '$$CHECK() Q
 D QUE
 Q
QUE ;Queue the process
 N ZTRTN,ZTDESC,ZTSK
 S ZTRTN="PROCESS^DG837PST",ZTDESC="DG837PST - CONVERSION PROCESS TREATING FACILITY FILE"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 I $D(ZTSK) S ^XTMP("DG837PST","@@","TASK")=ZTSK
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CHECK() ;Initial check
 D BMES^XPDUTL("Post install conversion process to update TREATING FACILITY FILE #391.91")
 N INITSTRT
 I '$D(^XTMP("DG837PST","@@","PROCESS INIT STARTED")) S (^XTMP("DG837PST","@@","PROCESS INIT STARTED"),^XTMP("DG837PST","@@","PROCESS STARTED"))=$$NOW^XLFDT() D BMES^XPDUTL("<<Process Started>>") Q 1
 I $D(^XTMP("DG837PST","@@","PROCESS COMPLETED")) D BMES^XPDUTL("<<Process is already completed>>")
 I $D(^XTMP("DG837PST","@@","PROCESS STOPPED")) D BMES^XPDUTL("<<Process stopped in previous run>>")
 I 'RESTART Q 0
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to complete the rerun" D ^DIR K DIR
 I '+Y Q 0
 S INITSTRT=$G(^XTMP("DG837PST","@@","PROCESS INIT STARTED"))
 K ^XTMP("DG837PST","@@")
 S ^XTMP("DG837PST","@@","PROCESS INIT STARTED")=$G(INITSTRT)
 S ^XTMP("DG837PST","@@","PROCESS STARTED")=$$NOW^XLFDT()
 D BMES^XPDUTL("<<Process Started>>") Q 1
PROCESS ;
 N TFIEN,MIEN,QFLG,X,X1,X2,FDA,FDAIEN,SNODE0,NODE0
 S QFLG=0
 S X1=DT,X2=60 D C^%DTC
 S ^XTMP("DG837PST","@@","TOTAL RECORDS")=$P($G(^DGCN(391.91,0)),"^",4)
 S ^XTMP("DG837PST",0)=X_"^"_$$DT^XLFDT_"^DG*5.3*837 - POST INSTALL - CONVERSION PROCESS IN TREATING FACILITY FILE"
 S TFIEN=+$G(^XTMP("DG837PST","@@","CURRENT IEN"))
 F  S TFIEN=$O(^DGCN(391.91,TFIEN)) Q:+TFIEN=0!(QFLG)  D
 . I $D(^XTMP("DG837PST","@@","FORCE STOP")) S QFLG=1 Q
 . S ^XTMP("DG837PST","@@","CURRENT IEN")=TFIEN
 . I $O(^DGCN(391.91,TFIEN,1,0))="" D
 . . N TMPST
 . . S TMPST=$P($G(^DGCN(391.91,TFIEN,0)),"^",2)
 . . I $E($$STA^XUAF4(TMPST),1,4)="200N" D  Q
 . . . N FDA
 . . . I $P($G(^DGCN(391.91,TFIEN,2)),"^")'="" S FDA(1,391.91,+TFIEN_",",10)=$P($G(^DGCN(391.91,TFIEN,2)),"^")
 . . . I $P($G(^DGCN(391.91,TFIEN,0)),"^",9)="" S FDA(1,391.91,+TFIEN_",",.09)="NI"
 . . . D FILE^DIE("K","FDA(1)","ERR")
 . . . K FDA
 . . I ($E($$STA^XUAF4(TMPST),1,4)'="200N")&(($$STA^XUAF4(TMPST)=200)!($$GET1^DIQ(4,TMPST_",",13)="OTHER")!($$GET1^DIQ(4,TMPST_",",13)="VAMC")) D
 . . . N FDA
 . . . S FDA(1,391.91,+TFIEN_",",.09)="PI",FDA(1,391.91,+TFIEN_",",10)="USVHA"
 . . . D FILE^DIE("K","FDA(1)","ERR")
 . . . K FDA
 . I $D(^DGCN(391.91,TFIEN,1)) D
 . . S MIEN=0 S MIEN=$O(^DGCN(391.91,TFIEN,1,MIEN)) Q:+MIEN=0
 . . S SNODE0=$G(^DGCN(391.91,TFIEN,1,MIEN,0))
 . . S FDA(1,391.91,+TFIEN_",",11)=$P(SNODE0,"^")  ;Source ID
 . . S FDA(1,391.91,+TFIEN_",",12)=$P(SNODE0,"^",2)  ;Identifier Status
 . . D FILE^DIE("K","FDA(1)","ERR")
 . . K FDA
 . . I $O(^DGCN(391.91,TFIEN,1,MIEN))="" Q  ;No more entries in multiple file
 . . ; For rest of the entries in multiple file, create new record.
 . . S NODE0=$G(^DGCN(391.91,TFIEN,0)),TMPST=$P(NODE0,"^",2)
 . . S FDA(1,391.91,"+1,",.01)=$P($G(NODE0),"^",1)
 . . S FDA(1,391.91,"+1,",.02)=$P($G(NODE0),"^",2)
 . . S FDA(1,391.91,"+1,",.03)=$P($G(NODE0),"^",3)
 . . S FDA(1,391.91,"+1,",.07)=$P($G(NODE0),"^",7)
 . . S FDA(1,391.91,"+1,",.08)=$P($G(NODE0),"^",8)
 . . S FDA(1,391.91,"+1,",.09)=$P($G(NODE0),"^",9)
 . . I $E($$STA^XUAF4(TMPST),1,4)="200N" S FDA(1,391.91,"+1,",10)="",FDA(1,391.91,"+1,",.09)="NI"
 . . I ($E($$STA^XUAF4(TMPST),1,4)'="200N")&(($$STA^XUAF4(TMPST)=200)!($$GET1^DIQ(4,TMPST_",",13)="OTHER")!($$GET1^DIQ(4,TMPST_",",13)="VAMC")) D
 . . . S FDA(1,391.91,"+1,",.09)="PI",FDA(1,391.91,"+1,",10)="USVHA"
 . . F  S MIEN=$O(^DGCN(391.91,TFIEN,1,MIEN)) Q:+MIEN=0  D
 . . . N FDAIEN S SNODE0=$G(^DGCN(391.91,TFIEN,1,MIEN,0))
 . . . S FDA(1,391.91,"+1,",11)=$P($G(SNODE0),"^")
 . . . S FDA(1,391.91,"+1,",12)=$P($G(SNODE0),"^",2)
 . . . D UPDATE^DIE("S","FDA(1)","FDAIEN","ERR")
 . . K FDA,FDAIEN
 . S DIK="^DGCN(391.91,"_TFIEN_",1,",DA(1)=TFIEN
 . S DA=0 F  S DA=$O(^DGCN(391.91,TFIEN,1,DA)) Q:+DA=0  D ^DIK
 . K DIK,DA
 I QFLG S ^XTMP("DG837PST","@@","PROCESS STOPPED")=$$NOW^XLFDT() Q
 S ^XTMP("DG837PST","@@","PROCESS COMPLETED")=$$NOW^XLFDT()
 D MAIL
 D DELDD ;Delete old fields once conversion process is done.
 Q
MAIL ;Send Mail message
 N PATCH,SITE,STATN,SITENM,MSG,XMDUZ,XMSUB,XMTEXT,XMY
 S PATCH="DG*5.3*837"
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S (XMY(DUZ),XMY(.5))="",XMY("CHINTAN.NAIK@DOMAIN.EXT")="",XMY("PAULETTE.DAVIS@DOMAIN.EXT")="",XMY("CHRISTINE.CHESNEY@DOMAIN.EXT")=""
 S XMDUZ="MPI PATCH MONITOR",XMTEXT="MSG("
 S XMSUB="DG*5.3*837 - Conversion process completed for site: "_STATN
 S MSG(1)="The DG*5.3*837 post-init conversion process for TREATING FACILITY LIST (#391.91) file completed successfully."
 S MSG(1.5)=""
 S MSG(2)="Patch: "_PATCH
 S MSG(3)="Task: "_$G(^XTMP("DG837PST","@@","TASK"))
 S MSG(4)=""
 S MSG(5)="Site Station #: "_STATN
 S MSG(6)="Site Name: "_SITENM
 S MSG(7)=""
 S MSG(8)="Process Started at: "_$$FMTE^XLFDT($G(^XTMP("DG837PST","@@","PROCESS INIT STARTED")),"5P")
 S MSG(8.5)=""
 S MSG(9)="Process Completed at: "_$$FMTE^XLFDT($G(^XTMP("DG837PST","@@","PROCESS COMPLETED")),"5P")
 S MSG(9.5)=""
 S MSG(10)="Total Records in TREATING FACILITY LIST file (#391.91): "_^XTMP("DG837PST","@@","TOTAL RECORDS")
 D ^XMD
 Q
STRTAGN ;Re run of process in case of process is stopped
 N RESTART
 S RESTART=1
 I '$$CHECK() Q
 D QUE
 Q
STOP ;Stop the process
 W !!,"Stop process"
 I '$D(^XTMP("DG837PST","@@","PROCESS STARTED")) W !,"<< No process is currently running >>" Q
 I $D(^XTMP("DG837PST","@@","PROCESS COMPLETED")) W !,"<< Process already completed >>" Q
 W !!,"Process is currently running."
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to stop this process" D ^DIR K DIR
 I +Y S ^XTMP("DG837PST","@@","FORCE STOP")=1
 K DIR,Y
 Q
 ;
DELDD ;MVI_791 (ptd) - Delete obsolete fields in #391.91 file and 391.92.
 ;This code should only be called after the conversion
 ;routine has moved the data from the obsolete fields
 ;to the new fields and deleted the data.
 ;
 ;Delete these fields from the TREATING FACILITY LIST #391.91 file:
 ;   ASSIGNING AUTHORITY (#1) field, and
 ;   SOURCE ID (#20) subfile 391.9101, which includes the
 ;   SOURCE ID(#.01) and IDENTIFIER STATUS (#1) fields
 ;and delete the obsolete VAFC ASSIGNING AUTHORITY (#391.92) file.
 ;
 ;
 D BMES^XPDUTL("Removing obsolete fields from the TREATING FACILITY LIST #391.91 file.")
 ;Delete DD definition for the ASSIGNING AUTHORITY (#1)
 ;field in the TREATING FACILITY LIST (#391.91) file.
 ;
 S DIK="^DD(391.91,",DA=1,DA(1)=391.91
 D ^DIK
 K DA,DIK
 D BMES^XPDUTL(">>> Obsolete ASSIGNING AUTHORITY #1 field has been deleted.")
 ;
 ;Remove SOURCE ID (#391.9101) sub-file in the TREATING FACILITY
 ;LIST (#391.91) file.  S=subfile.
 I $$VFILE^DILFD(391.9101)=1 D  ;If sub-file exists, delete it.
 .S DIU=391.9101,DIU(0)="S"
 .D EN^DIU2
 .K DIU
 .D BMES^XPDUTL(">>> Obsolete SOURCE ID #391.9101 sub-file has been deleted.")
 ;
 ;Remove VAFC ASSIGNING AUTHORITY (#391.92) file; D=delete data
 I $$VFILE^DILFD(391.92)=1 D  ;If file exists, delete it.
 .D BMES^XPDUTL("Removing obsolete VAFC ASSIGNING AUTHORITY #391.92 file.")
 .S DIU="^DGCN(391.92,",DIU(0)="D"
 .D EN^DIU2
 .K DIU
 .D BMES^XPDUTL(">>> Obsolete VAFC ASSIGNING AUTHORITY #391.92 file has been deleted.")
 Q
 ;
