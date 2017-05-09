IBYP584A ;ALB/CXW - IB*2.0*584 POST INIT: BILLING REGION UPDATE ;12-27-2016
 ;;2.0;INTEGRATED BILLING;**584**;21-MAR-94;Build 40
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
TYPE ; change facility type from 3-NPB to 2-PBO for primary division
 N IBA,IBARY,IBCNT,IBI,IBLN,IBLND,IBHDV,IBBDV,IBBIEN,DA,DIE,DR,X,Y S IBCNT=0
 D MSG("")
 D MSG("      >> Updating Billing Regions with Provider Based (Facility Type 2)")
 F IBI=1:1 S IBLN=$P($T(NPBTX+IBI),";;",2) Q:IBLN=""  D
 . S IBHDV=$P(IBLN,U) Q:IBHDV=""
 . S ^TMP("IB584",$J,IBHDV,IBI)=""
 ;
 ; update type with 2 if not match
 S IBBIEN=0 F  S IBBIEN=$O(^IBE(363.31,IBBIEN)) Q:'IBBIEN  D
 . S IBLND=$G(^IBE(363.31,IBBIEN,0)) Q:IBLND=""
 . Q:$E(IBLND,1,3)'="RC "
 . S IBBDV=$P(IBLND," ",2) Q:IBBDV=""
 . Q:'$D(^TMP("IB584",$J,IBBDV))
 . Q:$P(IBLND,U,3)=2
 . ;
 . S DIE="^IBE(363.31,",DA=IBBIEN,DR=".03///2"
 . D ^DIE K DIE,DR,DA,X,Y
 . S IBCNT=IBCNT+1,IBARY($P(IBLND,U))=""
 ;
 ; display region name by order
 S IBBDV="" F  S IBBDV=$O(IBARY(IBBDV)) Q:IBBDV=""  D MSG("         "_IBBDV)
 D MSG("         Done.  "_IBCNT_" facility type of billing regions changed")
 K ^TMP("IB584",$J)
 Q
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
 ; 13 from Non-Provider Based (type 3) to Provider Based Outpt (type 2)
NPBTX ; station^location^state^zip 3^VN
 ;;402QB^HOULTON VA CLINIC, ME^ME^047^1
 ;;436GJ^MILES CITY VA CLINIC, MT^MT^593^19
 ;;568HA^NEWCASTLE, WY^WY^827^23
 ;;573GN^PERRY VA CLINIC, FL^FL^323^8
 ;;573QJ^JACKSONVILLE 2 VA CLINIC, FL^FL^322^8
 ;;626GJ^HOPKINSVILLE VA CLINIC, KY^KY^422^9
 ;;626GN^ATHENS VA CLINIC, TN^TN^373^9
 ;;631QA^PLANTATION STREET VA CLINIC, MA^MA^016^1
 ;;652GB^FREDERICKSBURG 2 VA CLINIC, VA^VA^224^6
 ;;655QB^GRAND TRAVERSE VA CLINIC, MI^MI^496^10
 ;;658GA^TAZEWELL VA CLINIC, VA^VA^246^6
 ;;659BZ^SOUTH CAHRLOTTE VA CLINIC, NC^NC^282^6
 ;;671GC^DEL RIO VA CLINIC, TX^TX^788^17
 ;
 Q
