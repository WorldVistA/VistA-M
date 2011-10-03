PXICLN1 ;ISL/dee - Cleanup routine for PX*1.0*1 ;9/3/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**1**;Aug 12, 1996
 ;
 D PACKAGE
 D QUE
 Q
 ;
PACKAGE ;Fix the PCE package file entry.
 N PXPCE,PXPCE,PXPCE22,PXVT,PXVTC,PXVT22,PXFDA,PXERROR
 S PXPCE=$$PKG2IEN^VSIT("PX")
 S PXPCEC=PXPCE_","
 Q:PXPCE'>0
 S PXVT=$$PKG2IEN^VSIT("VSIT")
 S PXVTC=PXVT_","
 D
 . N DIC,X,Y
 . S DIC="^DIC(9.4,"_PXPCE_",22,"
 . S DIC(0)="LX"
 . S DIC("P")=$P(^DD(9.4,22,0),"^",2)
 . S DA(1)=PXPCE
 . S X="1.0"
 . D ^DIC
 . S PXPCE22=+Y
 I $$GET1^DIQ(9.4,PXPCEC,2,"I","","PXERROR")="" D
 . S PXFDA(9.4,PXPCEC,2)="Patient Care Encounter"
 I $$GET1^DIQ(9.4,PXPCEC,11.01,"I","","PXERROR")="" D
 . S PXFDA(9.4,PXPCEC,11.01)="SLC"
 I $$GET1^DIQ(9.4,PXPCEC,11.3,"I","","PXERROR")="" D
 . S PXFDA(9.4,PXPCEC,11.3)="I"
 I $$GET1^DIQ(9.4,PXPCEC,13,"I","","PXERROR")'="1.0" D
 . S PXFDA(9.4,PXPCEC,13)="1.0"
 I PXVT>0,$G(PXPCE22)>0 D
 . D
 .. N DIC,X,Y
 .. S DIC="^DIC(9.4,"_PXVT_",22,"
 .. S DIC(0)="X"
 .. S DIC("P")=$P(^DD(9.4,22,0),"^",2)
 .. S DA(1)=PXVT
 .. S X="2.0"
 .. D ^DIC
 .. S PXVT22=+Y
 . I PXVT22>0 D
 .. N PXP22,PXV22
 .. S PXP22=PXPCE22_","_PXPCEC
 .. S PXV22=PXVT22_","_PXVTC
 .. I $$GET1^DIQ(9.49,PXP22,1,"I","","PXERROR")="" D
 ... S X=$$GET1^DIQ(9.49,PXV22,1,"I","","PXERROR")
 ... I X]"" S PXFDA(9.49,PXP22,1)=X
 .. I $$GET1^DIQ(9.49,PXP22,2,"I","","PXERROR")="" D
 ... S X=$$GET1^DIQ(9.49,PXV22,2,"I","","PXERROR")
 ... I X]"" S PXFDA(9.49,PXP22,2)=X
 .. I $$GET1^DIQ(9.49,PXP22,3,"I","","PXERROR")="" D
 ... S X=$$GET1^DIQ(9.49,PXV22,3,"I","","PXERROR")
 ... I X]"" S PXFDA(9.49,PXP22,3)=X
 I $D(PXFDA) D FILE^DIE("","PXFDA")
 Q
 ;
QUE ; Queue job to deleting the 800 node on all Stop Code Visits.
 N ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK,ZTSAVE
 D BMES^XPDUTL("Deleting the 800 node on all Stop Code Visits.")
 S ZTRTN="STOP800^PXICLN1"
 S ZTIO=""
 S ZTDESC="PX*1.0*1 tasked cleanup job"
 S ZTDTH=$H
 D ^%ZTLOAD
 I $D(ZTSK) D MES^XPDUTL("The job is task # "_ZTSK)
 I '$D(ZTSK) D MES^XPDUTL("Could not start the task job.") D BMES^XPDUTL("You should start it by doing:  D QUE^PXICLN1  at the programmers prompt.")
 Q
 ;
STOP800 ;Delete the 800 node from all Stop Code visits
 N PXIVSIT,VSIT
 S PXIVSIT=0
 F  S PXIVSIT=$O(^AUPNVSIT(PXIVSIT)) Q:'PXIVSIT  D
 . Q:'$D(^AUPNVSIT(PXIVSIT,800))
 . Q:$P($G(^AUPNVSIT(PXIVSIT,150)),"^",3)'="S"
 . K VSIT
 . I $P(^AUPNVSIT(PXIVSIT,800),"^",1)]"" S VSIT("SC")="@"
 . I $P(^AUPNVSIT(PXIVSIT,800),"^",2)]"" S VSIT("AO")="@"
 . I $P(^AUPNVSIT(PXIVSIT,800),"^",3)]"" S VSIT("IR")="@"
 . I $P(^AUPNVSIT(PXIVSIT,800),"^",4)]"" S VSIT("EC")="@"
 . I $D(VSIT) S VSIT("IEN")=PXIVSIT D UPD^VSIT K ^AUPNVSIT(PXIVSIT,800)
 ;
MAIL ;Send mail messge that job is done.  Also send to SLC IRMFO.
 N XMY,XMSUB,PXTEXT,XMTEXT
 S XMY(DUZ)=""
 S XMY("G.PCEINSTAL@ISC-SLC.VA.GOV")=""
 S XMSUB="PX*1.0*1 Cleanup is finished"
 S PXTEXT(1)="PX*1.0*1 Cleanup job is done."
 S:$D(ZTQUEUED) PXTEXT(2)="The task job number "_ZTQUEUED_" is finished."
 S PXTEXT(3)=" "
 S PXTEXT(4)="The site part if the Visit ID for this site is:"
 S PXTEXT(5)="  "_$G(^VSIT(150.2,+$P($G(^DIC(150.9,1,4)),"^",2),0))
 S XMTEXT="PXTEXT("
 D ^XMD
 Q
 ;
