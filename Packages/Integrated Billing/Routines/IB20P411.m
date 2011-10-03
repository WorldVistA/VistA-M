IB20P411 ;OAK/ELZ - IB*2.0*411 POST INIT ;23-JAN-2009
 ;;2.0;INTEGRATED BILLING;**411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
POST ;
 N IBA
 S IBA(1)="",IBA(2)="    IB*2*411 Post-Install .....",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 D BCID
 D CLEANAG
 S IBA(1)="",IBA(2)="    IB*2*411 Post-Install Complete",IBA(3)="" D MES^XPDUTL(.IBA) K IBA
 Q
 ;
BCID ; loop through all BCID's and make sure they are 7 characters long
 D MES^XPDUTL("      >>Cleaning up the BCID's in 399")
 N BCID,IBIEN,IBC,NBCID,IBCF,X,Y,DIE,DA,DR
 S BCID="",(IBCF,IBC)=0
 F  S BCID=$O(^DGCR(399,"AG",BCID)) Q:BCID=""  S IBIEN=0 F  S IBIEN=$O(^DGCR(399,"AG",BCID,IBIEN)) Q:'IBIEN  D
 . S IBC=IBC+1
 . I IBC#100=0 W "."
 . I $L($P(BCID,";"))=7 Q
 . S NBCID=$$BCID^IBNCPDP4(+BCID,$P(BCID,";",2))
 . S DIE="^DGCR(399,",DA=IBIEN,DR="460////^S X=NBCID" D ^DIE
 . S IBCF=IBCF+1
 D MES^XPDUTL("        - "_IBCF_" needed to be fixed")
 D MES^XPDUTL("      >>Done cleaning up the BCID's in 399")
 Q
 ;
CLEANAG ; Clean up of the "AG" node, removing part of the non-fm standard
 ; xref's that are not true x-refs with tasked job 2 days out
 N IBT,ZTRTN,ZTDESC,ZTDTH,ZTIO,ZTSK
 D MES^XPDUTL("  - Queuing task to clean up ""AG"" x-ref in 3 days")
 S ZTRTN="DQ^IB20P411",ZTDESC="Post Install IB*2*411, Clean-up of x-ref"
 S (IBT,ZTDTH)=$$FMADD^XLFDT($$NOW^XLFDT,3),ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK) D
 .D MES^XPDUTL("  - Task Queued, #"_ZTSK_" to run at "_$$FMTE^XLFDT(IBT))
 E  D MES^XPDUTL("  - ERROR:  Task not queued!!!")
 Q
 ;
DQ ; post-install task job
 N BCID,IBIEN,IBT,XMSUB,XMZ,XMTEXT,XMY,XMDUZ
 K ^TMP("IB20P411",$J)
 S BCID="" F  S BCID=$O(^DGCR(399,"AG",BCID))  Q:BCID=""  M ^TMP("IB20P411",$J,BCID)=^DGCR(399,"AG",BCID) K ^DGCR(399,"AG",BCID) S IBIEN=0 F  S IBIEN=$O(^TMP("IB20P411",$J,BCID,IBIEN)) Q:'IBIEN  S ^DGCR(399,"AG",BCID,IBIEN)=""
 K ^TMP("IB20P411",$J)
 ;
 ; notify installer complete
 S IBT(1)="The cleanup of the x-ref from the install of IB*2*411 has finished.  The"
 S IBT(2)="post install routine IB20P411 may now be optionally deleted."
 S XMSUB="IB*2.0*411 installation has been completed"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT(",XMY(DUZ)=""
 D ^XMD
 Q
