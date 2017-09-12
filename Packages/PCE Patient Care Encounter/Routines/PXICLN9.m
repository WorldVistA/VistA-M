PXICLN9 ;ISL/dee - Cleanup routine for PX*1.0*9 ;11/8/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**9**;Aug 12, 1996
 ;
 N PXIRA
 I '$$PATCH^XPDUTL("SD*5.3*63") D
 . W !,"Must install patch SD*5.3*63  before installing this patch."
 . S XPDABORT=2
 I '$$PATCH^XPDUTL("SD*5.3*75") D
 . W !,"Must install patch SD*5.3*75  before installing this patch."
 . S XPDABORT=2
 I '$$PATCH^XPDUTL("LR*5.2*138") D
 . W !,"Must install patch LR*5.2*138 before installing this patch."
 . S XPDABORT=2
 S PXIRA=$$VERSION^XPDUTL("RA")
 I PXIRA]"",PXIRA'=4.5 D
 . W !,"RAD/NUC must be at version 4.5 before installing this patch."
 . S XPDABORT=2
 I PXIRA=4.5,'$$PATCH^XPDUTL("RA*4.5*8") D
 . W !,"Must install patch RA*4.5*8   before installing this patch."
 . S XPDABORT=2
 I '$$PATCH^XPDUTL("VSIT*2.0*1") D
 . W !,"Must install patch VSIT*2.0*1 before installing this patch."
 . S XPDABORT=2
 I '$$PATCH^XPDUTL("PX*1.0*1") D
 . W !,"Must install patch PX*1.0*1   before installing this patch."
 . S XPDABORT=2
 I '$$PATCH^XPDUTL("PX*1.0*5") D
 . W !,"Must install patch PX*1.0*5   before installing this patch."
 . S XPDABORT=2
 Q
 ;
LOCK ;Pre-install, locks lab from passing data.
 L +^LRO(69,"AA")
 K ^TMP("PXICLN9")
 Q
 ;
QUE ; Queue job to cleanup Lab and Rad Encounters.
 ;unlock lab
 L -^LRO(69,"AA")
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE,ZTCPU,ZTUCI
 D BMES^XPDUTL("Job to cleanup Lab and Rad Encounters.")
 S ZTRTN="TASKED^PXICLN9"
 S ZTIO=""
 S ZTDESC="PX*1.0*9 tasked cleanup job"
 S ZTDTH=$H
 S ZTSAVE("DUZ")=DUZ,ZTSAVE("DUZ(")=""
 D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The job is task # "_ZTSK)
 I '$D(ZTSK) D MES^XPDUTL("Could not start the task job.") D BMES^XPDUTL("You should start it by doing:  D QUE^PXICLN9  at the programmers prompt.")
 Q
 ;
TASKED ;
 D CLEANUP^PXICLN9B
 D EN1^PXICLN9A
 D MAIL
 Q
 ;
MAIL ;Send mail messge that job is done.
 N XMY,XMSUB,PXTEXT,XMTEXT
 S XMY(DUZ)=""
 S XMY("G.PCEINSTAL@ISC-SLC.DOMAIN.EXT")=""
 S XMSUB="PX*1.0*9 Cleanup is finished"
 S PXTEXT(1)="PX*1.0*9 job to cleanup Lab and Rad encounters is done."
 S:$D(ZTQUEUED) PXTEXT(2)="The task job number "_ZTQUEUED_" is finished."
 S PXTEXT(3)=" "
 S PXTEXT(4)="Visit ID for this site is:  "_$P($G(^VSIT(150.2,+$P($G(^DIC(150.9,1,4)),"^",2),0)),"^",2)
 I $G(PXIIMM) D
 . S PXTEXT(5)=" "
 . S PXTEXT(6)="The Immunization (AUTTIMM) GLOBAL was repaired. "
 . S PXTEXT(7)="The number of entries converted = "_$G(PXBCNT)
 S XMTEXT="PXTEXT("
 D ^XMD
 K PXIIMM
 Q
 ;
