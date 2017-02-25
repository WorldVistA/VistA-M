IBYP573A ;ALB/CXW - IB*2.0*573 POST INIT: BILLING REGION UPDATE ;09-30-2016
 ;;2.0;INTEGRATED BILLING;**573**;21-MAR-94;Build 42
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
TYPE ; change facility type from 3-NPB to 2-PBO for primary division
 N IBA,IBARY,IBCNT,IBI,IBLN,IBLND,IBHDV,IBBDV,IBBIEN,DA,DIE,DR,X,Y S IBCNT=0
 D MSG("")
 D MSG("      >> Updating Billing Regions with Provider Based (Facility Type 2)")
 F IBI=1:1 S IBLN=$P($T(NPBTX+IBI^IBYP573B),";;",2) Q:IBLN=""  D
 . S IBHDV=$P(IBLN,U) Q:IBHDV=""
 . S ^TMP("IB573",$J,IBHDV,IBI)=""
 ;
 ; update type with 2 if not match
 S IBBIEN=0 F  S IBBIEN=$O(^IBE(363.31,IBBIEN)) Q:'IBBIEN  D
 . S IBLND=$G(^IBE(363.31,IBBIEN,0)) Q:IBLND=""
 . Q:$E(IBLND,1,3)'="RC "
 . S IBBDV=$P(IBLND," ",2) Q:IBBDV=""
 . Q:'$D(^TMP("IB573",$J,IBBDV))
 . Q:$P(IBLND,U,3)=2
 . ;
 . S DIE="^IBE(363.31,",DA=IBBIEN,DR=".03///2"
 . D ^DIE K DIE,DR,DA,X,Y
 . S IBCNT=IBCNT+1,IBARY($P(IBLND,U))=""
 ;
 ; display region name by order
 S IBBDV="" F  S IBBDV=$O(IBARY(IBBDV)) Q:IBBDV=""  D MSG("         "_IBBDV)
 D MSG("         Done.  "_IBCNT_" facility type of billing regions changed")
 K ^TMP("IB573",$J)
 Q
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
