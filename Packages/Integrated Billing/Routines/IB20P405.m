IB20P405 ;OAK/ELZ - IB*2*405 POST-INIT TO POPULATE 362.4; 9/2/08
 ;;2.0;INTEGRATED BILLING;**405**;21-MAR-94;Build 4
 ;;Per VHA Directive 10-93-142 this routine should not be modified.
 ;
POST ;
 D BMES^XPDUTL("Queuing Post-init to populate 362.4...")
 N ZTDESC,ZTSAVE,ZTIO,ZTDTH,ZTRTN,ZTSK
 S ZTDTH=$$NOW^XLFDT,ZTIO="",ZTDESC="IB*2*405 POST INSTALL"
 S ZTRTN="DQ^IB20P405"
 D ^%ZTLOAD
 D BMES^XPDUTL("Post install queued task #"_ZTSK)
 Q
 ;
DQ ; queued entry point
 N IBX,IBDATA,IBCT,IBRX,IBDT,DFN,IBLIST,IBY,IBMSG,XMDUZ,XMTEXT,XMSUB,XMY,XMZ,IBRXN
 ;
 S (IBCT,IBX)=0,IBLIST="IB20P405"
 ;
 ; loop through all 362.4 entries and try to populate the new .1 field
 ; if it is not already populated.
 F  S IBX=$O(^IBA(362.4,IBX)) Q:'IBX  D
 . S IBDATA=$G(^IBA(362.4,IBX,0))
 . I '$L(IBDATA)!($L($P(IBDATA,"^",10))) Q
 . S DFN=$P($G(^DGCR(399,+$P(IBDATA,"^",2),0)),"^",2) Q:'DFN
 . S IBDT=$P(IBDATA,"^",3) Q:'IBDT
 . S IBRXN=$P(IBDATA,"^")
 . S IBRX=$P(IBDATA,"^",5)
 . I '$L(IBRXN),'IBRX Q
 . K ^TMP($J,IBLIST)
 . D
 .. I IBRX D RX^PSO52API(DFN,IBLIST,IBRX,,"0,2,R") Q
 .. D RX^PSO52API(DFN,IBLIST,,IBRXN,"0,2,R")
 .. S IBRX=$O(^TMP($J,IBLIST,DFN,0))
 . Q:'IBRX
 . ; matches original fill (old way)
 . I IBDT=+$G(^TMP($J,IBLIST,DFN,IBRX,22)) D SET(IBX,0,.IBCT) Q
 . ; look for match on refill (old way)
 . S IBRF=0
 . S IBY=0 F  S IBY=$O(^TMP($J,IBLIST,DFN,IBRX,"RF",IBY)) Q:'IBY  I IBDT=+$G(^TMP($J,IBLIST,DFN,IBRX,"RF",IBY,.01)) S IBRF=IBY Q
 . I IBRF D SET(IBX,IBRF,.IBCT) Q
 . ; look for original fill for Released Date, Dispense Date, Issue Date
 . I IBDT=+$P($G(^TMP($J,IBLIST,DFN,IBRX,1)),".") D SET(IBX,0,.IBCT) Q
 . I IBDT=+$P($G(^TMP($J,IBLIST,DFN,IBRX,25)),".") D SET(IBX,0,.IBCT) Q
 . I IBDT=+$P($G(^TMP($J,IBLIST,DFN,IBRX,31)),".") D SET(IBX,0,.IBCT) Q
 . ; look for refills based on Release Date or Dispense Date
 . S IBY=0 F  S IBY=$O(^TMP($J,IBLIST,DFN,IBRX,"RF",IBY)) Q:'IBY  I IBDT=+$P($G(^TMP($J,IBLIST,DFN,IBRX,"RF",IBY,17)),".")!(IBDT=+$P($G(^(10.1)),".")) S IBRF=IBY Q
 . I IBRF D SET(IBX,IBRF,.IBCT) Q
 K ^TMP($J,IBLIST)
 ;
 S IBMSG(1)=""
 S IBMSG(2)="The post-install for IB*2*405 finished.  "_IBCT_" records in 362.4 were"
 S IBMSG(3)="populated with fill/refill data."
 S XMSUB="IB*1*405 Post-Install Completed"
 S XMDUZ="INTEGRATED BILLING PACKAGE"
 S XMTEXT="IBMSG("
 S XMY(DUZ)=""
 D ^XMD
 Q
 ;
SET(DA,IBRF,IBCT) ;
 S IBCT=IBCT+1
 S $P(^IBA(362.4,DA,0),"^",10)=IBRF
 Q
