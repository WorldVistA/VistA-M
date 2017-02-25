IB20P580 ;ALB/CXW - IB*2*580 POST INIT:COST-BASED/INTERAGENCY FIX ;11-07-2016
 ;;2.0;INTEGRATED BILLING;**580**;21-MAR-94;Build 38
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 
 ;
 ; Cost Based/Interagency Rate fix for Polytrauma in Charge Item (363.2)
 Q
POST ;
 N IBEFFDT,IBA,U S U="^"
 D MSG("   IB*2.0*580 Post-Install .....")
 S IBEFFDT=3160707 ; effective date of 07/07/2016
 D UPDTCI(IBEFFDT)  ; update Charge Items (363.2) with 4 rates            
 D MSG("   IB*2.0*580 Post-Install Complete")
 Q
 ;
UPDTCI(IBEFFDT) ; Update Charge Items (363.2) needs Charge Sets, pass in the effective date of the new charges
 N IBC,IBCHG,IBCNT,IBCNT1,IBC,IBCI,IBCS,IBDFLTDT,IBDT,IBI,IBLN,IBPE,IBRVCD,IBX,IBXRF,IBZ,DA,DIE,DR,X,Y
 ; 
 D MSG("")
 S IBCNT=0,IBDFLTDT=+$G(IBEFFDT)
 I 'IBDFLTDT D MSG("** Error: No Effective Date, No Charges Updated") G CIQ
 ;
 F IBI=1:1 S IBLN=$P($T(CIF+IBI),";;",2) Q:+IBLN!(IBLN="")  I $E(IBLN)?1A D SETCI
 ;
CIQ D MSG(">> "_IBCNT_" Cost Based/Interagency for Polytrauma/PM&RS charge items updated (#363.2).")
 D MSG("")
 Q
 ;
SETCI ; set Charge Item (duplicates based on item, CS, eff dt, rev cd)
 ;
 S IBCS=$P(IBLN,U,2),IBCS=+$O(^IBE(363.1,"B",IBCS,0)) I 'IBCS D MSG("** Error: Charge Set "_$P(IBLN,U,2)_" undefined") Q
 S IBCI=+$$MCCRUTL($P(IBLN,U,1),5) I 'IBCI D MSG("** Error: Bed Section "_$P(IBLN,U,2)_" undefined") Q
 S IBDT=IBDFLTDT I +$P(IBLN,U,3) S IBDT=+$P(IBLN,U,3)
 S IBRVCD=$$RVCD($P(IBLN,U,4))
 S IBCHG=+$P(IBLN,U,5)
 S IBXRF="AIVDTS"_IBCS
 ; check for duplicate charge items
 S IBCNT1=0
 ;
 S IBX=0 F  S IBX=$O(^IBA(363.2,IBXRF,IBCI,-IBDT,IBX)) Q:'IBX  S IBZ=$G(^IBA(363.2,IBX,0)) I $P(IBZ,U,6)=IBRVCD D
 . S IBCNT1=IBCNT1+1
 . I +$P(IBZ,U,5)=IBCHG D MSG("   "_$P(IBLN,U,2)_" with $"_IBCHG_" charge item already exists") Q
 . S DIE="^IBA(363.2,",DA=+IBX,DR=".05///"_IBCHG D ^DIE K DIE,DA,DR,X,Y
 . S IBCNT=IBCNT+1
 I IBCNT1>1 D MSG("** Error: "_$P(IBLN,U,2)_" duplicate charge items on 07/07/2016")
 Q
 ;
MCCRUTL(IBC,IBPE) ; returns IEN in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(IBC)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",IBC,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
RVCD(IBRVCD) ; returns IFN if revenue code is valid and active
 N IBX,IBY S IBY=""
 I +$G(IBRVCD) S IBX=$G(^DGCR(399.2,+IBRVCD,0)) I +$P(IBX,U,3) S IBY=+IBRVCD
 Q IBY
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
 ;
CIF ; 4 Charge Items (363.2): Bedsection ^ Charge Set ^Effective Date ^ Revenue Code ^ Charge
 ;;     
TORT ;; Cost Based (Tortiously Liable) for outpatient care
 ;;PM&RS OUTPATIENT VISIT^TL-OPT VST PM&RS^^^212
 ;;POLYTRAUMA OUTPATIENT VISIT^TL-OPT VST POLYTRAUMA^^^537
 ;;          
IA ;; Interagency for outpatient care
 ;;PM&RS OUTPATIENT VISIT^IA-OPT VST PM&RS^^^199
 ;;POLYTRAUMA OUTPATIENT VISIT^IA-OPT VST POLYTRAUMA^^^510
 ;;
 Q
