GMTSP129 ; SLC/DJH - Patch 129 post-install routine ;6/6/19 4:00pm
 ;;2.7;Health Summary;**129**;Oct 20, 1995;Build 8
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ; This routine is a part of patch GMTS*2.7*129 that is supporting patch SOW*3.0*65 (which will completely
 ; decommission the Social Work (SOW) package from VistA) and remove all Social Work GMTS code and components
 ; This routine is marking Health Summary Components for Social Work as inactive by setting the DISABLE FLAG 
 ; field to P (Permanent).  This will make the component non-selectable for use, and prevents the component 
 ; from being printed in any Health Summary in which it is included.
 ;
 ; DBIA#   SUPPORTED
 ; -----   --------------------------------------
 ; 10013   ^DIK
 ;
EN ; Entry point
 ;
ROUT ; remove routines from ^DIC(9.8
 N SPNI,DA,DIK
 S SPNI=0 S SPNI=$O(^DIC(9.8,"B","GMTSSOWZ",SPNI)) D
 . Q:'SPNI  S DA=SPNI,DIK="^DIC(9.8," D ^DIK K DA,DIK
 S SPNI=0 S SPNI=$O(^DIC(9.8,"B","GMTSSOWK",SPNI)) D
 . Q:'SPNI  S DA=SPNI,DIK="^DIC(9.8," D ^DIK K DA,DIK
 ;
 ;keep record of deleted records for 60 days
 S ^XTMP("GMTSP129",0)=$$FMADD^XLFDT($$NOW^XLFDT,60)_U_$$NOW^XLFDT
 ;
 ; Find all HS Component that contain GMTSSOW* in the PRINT ROUTINE
COMP N GMTIEN,CNT,GMTCMP,GMTIEN2
 S GMTIEN=0 F  S GMTIEN=$O(^GMT(142.1,GMTIEN)) Q:'GMTIEN  D
 . Q:$G(^GMT(142.1,GMTIEN,0))']""
 . Q:($P(^GMT(142.1,GMTIEN,0),U,2)'["GMTSSOW")
 . S GMTCMP(GMTIEN)=$P(^GMT(142.1,GMTIEN,0),U)
 . M ^XTMP("GMTSP129",142.1,GMTIEN)=^GMT(142.1,GMTIEN)
 ;
 ; Generate 0 found msg and quit
 I '$O(GMTCMP(0)) D  Q
 . S CNT=1
 . S MSG(CNT)="",CNT=CNT+1
 . S MSG(CNT)="PATCH GMTS*2.7*129 completed processing successfully.",CNT=CNT+1
 . S MSG(CNT)="",CNT=CNT+1
 . S MSG(CNT)="This patch found 0 Health Summary components with field PRINT ROUTINE ",CNT=CNT+1
 . S MSG(CNT)="containing GMTSSOWK.",CNT=CNT+1
 . S MSG(CNT)=""
 . S XMSUB="PATCH GMTS*2.7*129 INSTALL",XMTEXT="MSG(",XMDUZ="Patch GMTS*2.7*129"
 . S XMY(DUZ)=""
 . D ^XMD
 ;
 S GMTCMP=0 F  S GMTCMP=$O(GMTCMP(GMTCMP)) Q:'GMTCMP  D
 . S GMTIEN=0 F  S GMTIEN=$O(^GMT(142,"AE",GMTCMP,GMTIEN)) Q:'GMTIEN  D
 . . S GMTCMP(GMTCMP,GMTIEN)=$P(^GMT(142,GMTIEN,0),U)
 . . S GMTIEN2=0 F  S GMTIEN2=$O(^GMT(142,"AE",GMTCMP,GMTIEN,GMTIEN2)) Q:'GMTIEN2  D
 . . . S GMTCMP(GMTCMP,GMTIEN,GMTIEN2)=""
 . . . M ^XTMP("GMTSP129",142,GMTIEN,GMTIEN2)=^GMT(142,GMTIEN,1,GMTIEN2)
 ;
 ; set disabled field
 S GMTCMP=0 F  S GMTCMP=$O(GMTCMP(GMTCMP)) Q:'GMTCMP  D
 . N DA,DIE
 . S DA=GMTCMP,DIE="^GMT(142.1," S DR="5////P" D ^DIE K DIE
 . ; remove from health summary type
 . S GMTIEN=0 F  S GMTIEN=$O(GMTCMP(GMTCMP,GMTIEN)) Q:'GMTIEN  D
 . . S GMTIEN2=0 F  S GMTIEN2=$O(GMTCMP(GMTCMP,GMTIEN,GMTIEN2)) Q:'GMTIEN2  D
 . . . ; GMTCMP = IEN IN #142.1, GMTIEN = IEN IN #142, GMTIEN2 = SUB IEN IN 1 RECORD OF #142
 . . . ; DELETE  FROM #142
 . . . S DA(2)=142,DA(1)=GMTIEN,DA=GMTIEN2,DIK="^GMT("_DA(2)_","_DA(1)_",1," D ^DIK
 ;
MAIL ;
 N XMY,XMDUZ,XMSUB,XMTEXT,DIE,DA,DR,MSG
 S CNT=1
 S XMY(DUZ)=""
 S XMSUB="PATCH GMTS*2.7*129 INSTALL",XMTEXT="MSG(",XMDUZ="Patch GMTS*2.7*129"
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="PATCH GMTS*2.7*129 completed processing successfully.",CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="These Health Summary Component(s) were marked permanently disabled",CNT=CNT+1
 S GMTCMP=0 F  S GMTCMP=$O(GMTCMP(GMTCMP)) Q:'GMTCMP  D
 . S MSG(CNT)=GMTCMP(GMTCMP),CNT=CNT+1
 S MSG(CNT)="",CNT=CNT+1
 S MSG(CNT)="The above Components were deleted from these Health Summary Types:",CNT=CNT+1
 ;
 S GMTCMP=0 F  S GMTCMP=$O(GMTCMP(GMTCMP)) Q:'GMTCMP  D
 . S GMTIEN=0 F  S GMTIEN=$O(GMTCMP(GMTCMP,GMTIEN)) Q:'GMTIEN  D
 . . S MSG(CNT)=GMTCMP(GMTCMP,GMTIEN),CNT=CNT+1
 ;SEND MAIL MSG
 D ^XMD
 Q
