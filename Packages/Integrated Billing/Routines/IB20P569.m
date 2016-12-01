IB20P569 ;ALB/CXW - IB*2.0*569 Post Init: Administrative Charge Update;06-27-2016 
 ;;2.0;INTEGRATED BILLING;**569**;21-MAR-94;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
 ;
POST ; post-install of patch installation
 ; use default rate type of rx 3rd party bill to update RS in #363
 ;
 N U,IBA,IBCT,IBI,IBJ,IBT,IBX,IBY,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST,Y
 D MSG("Patch IB*2.0*569 Post-Install starts...")
 D MSG("")
 S IBADFE="",IBCT=0,U="^"
 D MSG("  >>>Effect. JAN 01, 2016 of RX Rate Schedule Adjustment for the Rate Type:")
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";",3) Q:'$L(IBT)  D
 . S IBRS=""
 . S IBRATY=$P(IBT,U),IBRATY=$TR(IBRATY,"/",U)
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . S IBEFFDT=$P(IBT,U,4)
 . F IBI=1:1 S IBJ=$P(IBRATY,U,IBI) Q:IBJ=""  D
 .. S IBRSIN=$O(^DGCR(399.3,"B",IBJ,0))
 .. I 'IBRSIN D MSG("       "_IBJ_" not defined in the Rate Type file (#399.3), not added") Q
 .. ; find the latest ien if multiple
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) S IBRSIN=$O(^DGCR(399.3,"B",IBJ,999999),-1)
 .. I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("       "_IBJ_" inactivated in the Rate Type file (#399.3), not added") Q
 .. I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBJ_" already exists") Q
 .. ; add new entry for cy2016 and inactivate date for cy2015 
 .. D ENT^IB3PSOU(IBJ,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 .. ; double check
 .. I '$$RSEXIST(IBEFFDT,IBRSIN) D MSG("       "_IBJ_" not added") Q
 .. S IBCT=IBCT+1 D MSG("       "_IBJ_" added")
 D MSG("")
 D MSG("     Total "_IBCT_$S(IBCT=1:" entry",1:" entries")_" added to the Rate Schedule file (#363)")
 D MSG("")
 D MSG("Patch IB*2.0*569 Post-Install is complete.")
 Q
 ;
RSEXIST(IBEFFDT,IBRSIN) ; return RS IFN if Rate Schedule exists for Effective Date
 N IBX,IBRSFN,IBRS0 S IBX=0
 S IBRSFN=0 F  S IBRSFN=$O(^IBE(363,IBRSFN))  Q:'IBRSFN  D  I IBX Q
 . S IBRS0=$G(^IBE(363,IBRSFN,0))
 . I $P(IBRS0,U,2)=IBRSIN,$P(IBRS0,U,5)=IBEFFDT S IBX=IBRSFN
 Q IBX
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
 ;
RSF ; rate type separated by '/'^dispensing fee^adjustment^effective date
 ;;HUMANITARIAN/INELIGIBLE/INTERAGENCY/NO FAULT INS./REIMBURSABLE INS./TORT FEASOR/WORKERS' COMP.^14.29^S X=X+14.29^3160101
 ;
