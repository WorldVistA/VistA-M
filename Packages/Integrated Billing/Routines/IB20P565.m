IB20P565 ;ALB/CXW - IB*2.0*565 Post Init:Fix Visit Date/Time in CT;8-31-2016 
 ;;2.0;INTEGRATED BILLING;**565**;21-MAR-94;Build 41
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; post-install of patch installation
 ; remove unnecessary visit date/time for INPAT in field/file (#.03/#356)
 N IBA,IBCNT,IBCTIEN,IBCTY,IBVDTM,DA,DIE,DR,X,Y S U="^"
 D MSG("  IB*2.0*565 Post-Install .....")
 D MSG("")
 D MSG("     >> Removing Existing Visit Date/Time for Inpatient Events, Please Wait...")
 S IBCNT=0,IBVDTM=""
 S IBCTY=$O(^IBE(356.6,"B","INPATIENT ADMISSION",0))
 F  S IBVDTM=$O(^IBT(356,"AVSIT",IBVDTM)) Q:IBVDTM=""  D
 . ; no change if visit is a pointer
 . I $D(^AUPNVSIT(IBVDTM)) Q
 . S IBCTIEN=0
 . F  S IBCTIEN=$O(^IBT(356,"AVSIT",IBVDTM,IBCTIEN)) Q:'IBCTIEN  D
 .. ; no change if not inpatient event
 .. I IBCTY'=+$P($G(^IBT(356,IBCTIEN,0)),U,18) Q
 .. S DA=IBCTIEN
 .. ; override the input transform
 .. S DIE="^IBT(356,",DR=".03////@" D ^DIE K DA,DIE,DR,X,Y
 .. S IBCNT=IBCNT+1
 D MSG("        Done.  "_IBCNT_" existing inpatient claims tracking entries updated (#356)")
 D MSG("")
 D MSG("  IB*2.0*565 Post-Install Complete")
 ; 
 Q
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
