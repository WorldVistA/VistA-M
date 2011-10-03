DG53800P ;BHM/CKN - POST INSTALL ROUTINE TO UPDATE IPP FIELD IN TREATING FACILITY FILE 391.91 ; 3/17/09 12:17pm
 ;;5.3;Registration;**800**;Aug 13, 1993;Build 4
 Q
EP ;MPIC_1490 - Post install routine entry point
 N RESTART
 S RESTART=0
 I '$$CHECK() Q
 D QUE
 Q
QUE ;Queue the process
 N ZTRTN,ZTDESC,ZTSK
 S ZTRTN="PROCESS^DG53800P",ZTDESC="DG53800P - UPDATE IPP FIELD IN TREATING FACILITY FILE"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 I $D(ZTSK) S ^XTMP("DG53800P","@@","TASK")=ZTSK W !,"Task: "_$G(ZTSK)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
CHECK() ;Initial check
 D BMES^XPDUTL("Post install process to update IPP field in TREATING FACILITY FILE #391.91")
 N INITSTRT
 I '$D(^XTMP("DG53800P","@@","PROCESS INIT STARTED")) S (^XTMP("DG53800P","@@","PROCESS INIT STARTED"),^XTMP("DG53800P","@@","PROCESS STARTED"))=$$NOW^XLFDT() D BMES^XPDUTL("<<Process Started>>") Q 1
 I $D(^XTMP("DG53800P","@@","PROCESS COMPLETED")) D BMES^XPDUTL("<<Process is already completed>>")
 I $D(^XTMP("DG53800P","@@","PROCESS STOPPED")) D BMES^XPDUTL("<<Process stopped in previous run>>")
 I 'RESTART Q 0
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to complete the rerun" D ^DIR K DIR
 I '+Y Q 0
 S INITSTRT=$G(^XTMP("DG53800P","@@","PROCESS INIT STARTED"))
 K ^XTMP("DG53800P","@@")
 S ^XTMP("DG53800P","@@","PROCESS INIT STARTED")=$G(INITSTRT)
 S ^XTMP("DG53800P","@@","PROCESS STARTED")=$$NOW^XLFDT()
 D BMES^XPDUTL("<<Process Started>>") Q 1
PROCESS ;
 N TFIEN,QFLG,INSTIEN,VAL,X,X1,X2
 S QFLG=0,VAL=1
 S X1=DT,X2=60 D C^%DTC
 S ^XTMP("DG53800P",0)=X_"^"_$$DT^XLFDT_"^DG53800P - POST INSTALL - IPP FIELD UPDATE IN TREATING FACILITY FILE"
 S INSTIEN=$O(^DIC(4,"D","200MH","")) ;Institution file ien for 200MH
 S TFIEN=+$G(^XTMP("DG53800P","@@","CURRENT IEN"))
 F  S TFIEN=$O(^DGCN(391.91,"C",INSTIEN,TFIEN)) Q:+TFIEN=0!(QFLG)  D
 . I $D(^XTMP("DG53800P","@@","FORCE STOP")) S QFLG=1 Q
 . S ^XTMP("DG53800P","@@","CURRENT IEN")=TFIEN
 . S DIE="^DGCN(391.91,",DA=TFIEN,DR=".08///^S X=VAL"
 . D ^DIE K DIE,DA,DR
 I QFLG S ^XTMP("DG53800P","@@","PROCESS STOPPED")=$$NOW^XLFDT() Q
 S ^XTMP("DG53800P","@@","PROCESS COMPLETED")=$$NOW^XLFDT()
 D MAIL
 Q
MAIL ;Send Mail message
 N PATCH,SITE,STATN,SITENM,MSG,XMDUZ,XMSUB,XMTEXT,XMY
 S PATCH="DG*5.3*800"
 S SITE=$$SITE^VASITE,STATN=$P($G(SITE),"^",3),SITENM=$P($G(SITE),"^",2)
 S (XMY(DUZ),XMY(.5))="",XMY("CHINTAN.NAIK@VA.GOV")="",XMY("PAULETTE.DAVIS@VA.GOV")=""
 S XMDUZ="MPI PATCH MONITOR",XMTEXT="MSG("
 S XMSUB="DG*5.3*800 - POST INIT - IPP FIELD UPDATE COMPLETE FOR SITE: "_STATN
 S MSG(1)="The DG*5.3*800 post-init process to update the IN-PERSON PROOFED (#.08) field in the TREATING FACILITY LIST (#391.91) file completed successfully."
 S MSG(1.5)=""
 S MSG(2)="Patch: "_PATCH
 S MSG(3)="Task: "_$G(^XTMP("DG53800P","@@","TASK"))
 S MSG(4)=""
 S MSG(5)="Site Station #: "_STATN
 S MSG(6)="Site Name: "_SITENM
 S MSG(7)=""
 S MSG(8)="Process Started at: "_$$FMTE^XLFDT($G(^XTMP("DG53800P","@@","PROCESS INIT STARTED")),"5P")
 S MSG(8.5)=""
 S MSG(9)="Process Completed at: "_$$FMTE^XLFDT($G(^XTMP("DG53800P","@@","PROCESS COMPLETED")),"5P")
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
 I '$D(^XTMP("DG53800P","@@","PROCESS STARTED")) W !,"<< No process is currently running >>" Q
 I $D(^XTMP("DG53800P","@@","PROCESS COMPLETED")) W !,"<< Process already completed >>" Q
 W !!,"Process is currently running."
 W ! S DIR(0)="Y",DIR("B")="Yes",DIR("A")="Do you want to stop this process" D ^DIR K DIR
 I +Y S ^XTMP("DG53800P","@@","FORCE STOP")=1
 K DIR,Y
 Q
