IB20P297 ;OAK/ELZ - POST INSTALL ROUTINE FOR IB*2*297 ;03-JAN-2005
 ;;2.0;INTEGRATED BILLING;**297**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This is the post install routine for IB*2*297.  This routine will
 ; run through the patient's insurance companies and identify insurance
 ; companies that do not have a plan associated with them.
 ; This routine can be deleted after the install, but you may want to
 ; keep it to review the insurance data again in the future.
 ;
POST ;
 N IBMSG,ZTRTN,ZTDESC,ZTSK
 S IBMSG(1)="I need to search for patient's with bad insurance data.  You should queue"
 S IBMSG(2)="this task to run a non-peek hours."
 D MES^XPDUTL(.IBMSG)
 ;
 S ZTRTN="DQ^IB20P297",ZTDESC="BAD INSURANCE DATA LIST",ZTIO=""
 D ^%ZTLOAD
 D MES^XPDUTL($S($G(ZTSK):"Task Queued #"_ZTSK,1:"Task not scheduled, you can run this by calling POST^IB20P297"))
 ;
 Q
 ;
DQ ; tasked entry point
 N DFN,IBINS,IBINSM,IBGRP,IBLINE,IBSAVE,XMDUZ,XMSUBJ,XMBODY,XMTO,XMINSTR,XMZ,DIK,DA
 K ^TMP("IB297",$J)
 S IBLINE=8,IBSAVE=""
 ;
 ;
 ; first check out the AB xref to make sure everything is there
 S DFN=0 F  S DFN=$O(^DPT(DFN)) Q:'DFN  S IBINSM=0 F  S IBINSM=$O(^DPT(DFN,.312,IBINSM)) Q:'IBINSM  S IBINS=+$G(^DPT(DFN,.312,IBINSM,0)) D
 . I $D(^DPT("AB",IBINS,DFN,IBINSM)) Q
 . I IBINS,DFN,IBINSM S DIK="^DPT("_DFN_",.312,",DA(1)=DFN,DA=IBINSM,DIK(1)=.01 D EN^DIK
 ;
 ;
 S IBINS=0 F  S IBINS=$O(^DPT("AB",IBINS)) Q:'IBINS  S DFN=0 F  S DFN=$O(^DPT("AB",IBINS,DFN)) Q:'DFN  S IBINSM=0 F  S IBINSM=$O(^DPT("AB",IBINS,DFN,IBINSM)) Q:'IBINSM  D
 . ;
 . ; first verify good x-ref or clean up
 . S IBINS0=$G(^DPT(DFN,.312,IBINSM,0))
 . I 'IBINS0 K ^DPT("AB",IBINS,DFN,IBINSM) Q
 . ;
 . ; do i have a plan?
 . I '$P(IBINS0,"^",18) D SET(DFN,IBINS,IBINSM,"No Plan in Patient File") Q
 . ;
 . ; good pointer to 36?
 . I '$D(^DIC(36,+IBINS0,0)) D SET(DFN,IBINS,IBINSM,"Ins Co not in File 36") Q
 . ;
 . ; good pointer in 355.3?
 . I '$D(^IBA(355.3,+$P(IBINS0,"^",18),0)) D SET(DFN,IBINS,IBINSM,"Plan pointer not found") Q
 . ;
 . ; check out 355.3 to 36
 . I $P(IBINS0,"^")'=$P($G(^IBA(355.3,+$P(IBINS0,"^",18),0)),"^") D SET(DFN,IBINS,IBINSM,"Plan to Ins Co Mis-match")
 ;
 ; data all looks good
 I '$D(^TMP("IB297",$J)) S ^TMP("IB297",$J,IBLINE,0)="Data looks good, no problems to report"
 ;
 ; start message
 S IBGRP=$P($G(^IBE(350.9,1,4)),"^",4),IBGRP=$S(IBGRP:$$EXTERNAL^DILFD(350.9,4.04,"",IBGRP),1:"IB NEW INSURANCE")
 ;
 ; build header
 S ^TMP("IB297",$J,1,0)="The following insurance entries have been found with errors that need to"
 S ^TMP("IB297",$J,2,0)="be resolved.  You should use the ""Patient Insurance Info View/Edit [IBCN"
 S ^TMP("IB297",$J,3,0)="PATIENT INSURANCE]"" option to edit the patient's insurance information"
 S ^TMP("IB297",$J,4,0)="and correct as needed.  If you just see a NULL value in a field that"
 S ^TMP("IB297",$J,5,0)="indicates either the pointer value in a field is invalid or missing.  You"
 S ^TMP("IB297",$J,6,0)="may need to involve your IRM to resolve some of the issues on this report."
 S ^TMP("IB297",$J,7,0)=""
 ;
 ; send away
 S XMDUZ=$S(DUZ:DUZ,1:.5)
 S XMSUBJ="INSURANCE FILE CLEAN UP NEEDED"
 S XMBODY="^TMP(""IB297"",$J)"
 S (XMTO("G.IB NEW INSURANCE"),XMTO($S(DUZ:DUZ,1:.5)))=""
 S XMINSTR("FROM")="INTEGRATED BILLING PACKAGE"
 D SENDMSG^XMXAPI(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZ)
 ;
 ;
 K ^TMP("IB297",$J)
 ;
 Q
 ;
SET(DFN,IBINS,IBINSM,IBERR) ;
 N IBDFN0,IBINS0
 ;
 ; new ins co?
 I IBSAVE'=IBINS S IBLINE=IBLINE+1,^TMP("IB297",$J,IBLINE,0)="",IBLINE=IBLINE+1,^TMP("IB297",$J,IBLINE,0)="     Insurance Co: "_$$EXTERNAL^DILFD(2.312,.01,"",IBINS),IBSAVE=IBINS
 ;
 ; get some data
 S IBDFN0=$G(^DPT(DFN,0)),IBINS0=$G(^DPT(DFN,.312,+IBINSM,0))
 ;
 ; set the line
 S IBLINE=IBLINE+1
 S ^TMP("IB297",$J,IBLINE,0)=$$LJ^XLFSTR($P(IBDFN0,"^"),"20T")_"  "_$$LJ^XLFSTR($P(IBDFN0,"^",9),"10T")_"  "_$$LJ^XLFSTR($$EXTERNAL^DILFD(2.312,.18,"",$P(IBINS0,"^",18)),"15T")_"  "_IBERR
 ;S ^TMP("IB297",$J,IBLINE,0)=$E($P(IBDFN0,"^"),1,20)_"  "_$P(IBDFN0,"^",9)_"  "_$E($$EXTERNAL^DILFD(2.312,.18,"",$P(IBINS0,"^",18)),1,15)_"  "_IBERR
 ;
 Q
