IB20P555 ;ALB/CXW - IB*2*555 POST INIT: DENTAL COST-BASED/INTERAGENCY RATE; 09/12/2015
 ;;2.0;INTEGRATED BILLING;**555**;21-MAR-94;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ; 
 ;
 ; Add FY2015 Dental Cost Based and Interagency Charges to the Charge Master
 Q
 ;
POST ;
 N IBEFFDT,IBA,U S U="^"
 D MSG("    IB*2.0*555 Post-Install .....")
 S IBEFFDT=3141104 ; effective date of 11/04/2014
 D ADDCI(IBEFFDT)  ; add Charge Items (363.2) with new 2 dental rates
 D ADDRS
 D MSG("    IB*2*555 Post-Install Complete")
 Q
 ;
ADDCI(IBEFFDT) ; Add Charge Items (363.2) needs Charge Sets, pass in the effective date of the new charges
 N IBCHG,IBCHZ,IBCNT,IBCNT1,IBCI,IBCS0,IBCS,IBDFLTDT,IBDT,IBFN,IBI,IBLN,IBRVCD,IBX,IBXRF,IBZ,DD,DO,DLAYGO,DIC,DIE,DA,DR,X,Y
 ; 
 D MSG("")
 S (IBCNT,IBCNT1)=0,IBDFLTDT=+$G(IBEFFDT)
 I 'IBDFLTDT D MSG("** Error: No Effective Date, No Charges Added") G CIQ
 ;
 F IBI=1:1 S IBLN=$P($T(CIF+IBI),";;",2) Q:IBLN="QUIT"  D SETCI
 ;
CIQ D MSG("      >> "_IBCNT_" Dental for Cost Based/Interagency Charge Items added (#363.2)")
 D MSG("")
 Q
 ;
SETCI ; set Charge Item (duplicates based on item, CS, eff dt, rev cd)
 ;
 S IBCS0=$P(IBLN,U,2),IBCS=+$O(^IBE(363.1,"B",IBCS0,0)) I 'IBCS D MSG("** Error: Charge Set "_$P(IBLN,U,2)_" undefined") Q
 S IBCI=+$$MCCRUTL($P(IBLN,U,1),5) I 'IBCI D MSG("** Error: Bed Section "_$P(IBLN,U,1)_" undefined") Q
 S IBDT=IBDFLTDT I +$P(IBLN,U,3) S IBDT=+$P(IBLN,U,3)
 S IBRVCD=$$RVCD($P(IBLN,U,4))
 S IBCHG=+$P(IBLN,U,5)
 S IBXRF="AIVDTS"_IBCS
 ;
 S IBX=0 F  S IBX=$O(^IBA(363.2,IBXRF,IBCI,-IBDT,IBX)) Q:'IBX  S IBZ=$G(^IBA(363.2,IBX,0)) I $P(IBZ,U,6)=IBRVCD D
 . S IBCI=0,IBCNT1=IBCNT1+1,IBCHZ=+$P(IBZ,U,5) D MSG("** "_$S(IBCHZ'=IBCHG:"Error: ",1:"")_"Charge Item "_IBCS0_" with "_$S(IBCHZ'=IBCHG:"wrong ",1:"")_"charge $"_$P(IBZ,U,5)_" already exists, not re-added")
 Q:'IBCI
 ;
 K DD,DO S DLAYGO=363.2,DIC="^IBA(363.2,",DIC(0)="L",X=IBCI_";DGCR(399.1," D FILE^DICN K DIC,DLAYGO
 I Y<1 D MSG("** Error: when adding the charge item "_IBCS_" with rate "_IBCHG_" to the file, Log a Remedy ticket!") K X,Y Q
 S IBFN=+Y,IBCNT=IBCNT+1
 ;
 S DR=".02///"_IBCS_";.03///"_IBDT_";.05///"_IBCHG I +IBRVCD S DR=DR_";.06///"_IBRVCD
 S DIE="^IBA(363.2,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 Q
 ;
ADDRS ; add Charge Sets to Rate Schedules (363)
 N IBCNT,IBCS,IBCSY,IBI,IBLN,IBRS,IBRSN,IBX,DA,DD,DO,DLAYGO,DIC,DIE,DR,X,Y
 S IBCNT=0
 F IBI=1:1 S IBLN=$P($T(RSF+IBI),";;",2) Q:IBLN="QUIT"  D
 . S IBRS=$P(IBLN,U)
 . S IBCS=$P(IBLN,U,6)
 . S IBCSY=$O(^IBE(363.1,"B",IBCS,0))
 . I 'IBCSY D MSG("** Error: Charge Set "_IBCS_" undefined, not added") Q
 . ; remove auto add for the old cs ia-opt vst
 . S IBRSN=$O(^IBE(363,"B",IBRS,0))
 . I $O(^IBE(363,"B",IBRS,IBRSN))'="" D
 .. S IBX=$O(^IBE(363,IBRSN,11,"B",+$O(^IBE(363.1,"B","IA-OPT VST",0)),0)) Q:'IBX
 .. S DA(1)=IBRSN,DA=IBX,DIE="^IBE(363,"_DA(1)_",11,"
 .. S DR=".02///@" D ^DIE
 . ; find the latest entry
 . S IBRSN=+$O(^IBE(363,"B",IBRS,99999),-1)
 . I 'IBRSN D MSG("** Error: Rate Schedule "_IBRS_" undefined, Charge Set "_IBCS_" not added") Q
 . I $P($G(^IBE(363,IBRSN,0)),U,6)'="" D MSG("** Error: Rate Schedule "_IBRS_" inactivated, Charge Set "_IBCS_" not added") Q
 . I $O(^IBE(363,IBRSN,11,"B",IBCSY,0)) D MSG("** Rate Schedule "_IBRS_" with "_IBCS_" already exists, not re-added") Q
 . ;
 . K DD,DO S DLAYGO=363,DA(1)=+IBRSN,DIC="^IBE(363,"_DA(1)_",11,",DIC(0)="L",X=+IBCSY,DIC("P")="363.0011P" D FILE^DICN K DIC,DA,DLAYGO
 . I Y<1 D MSG("** Error: when adding the Charge Set "_IBCS_" to Rate Schedule "_IBRS_" in the file, Log a Remedy ticket!") K X,Y Q
 . S IBCNT=IBCNT+1
RSQ ;
 D MSG("      >> "_IBCNT_" Rate Schedules updated (#363)")
 D MSG("")
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Name is found and piece P is true
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"B",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
RVCD(RVCD) ; returns IFN if revenue code is valid and active
 N IBX,IBY S IBY=""
 I +$G(RVCD) S IBX=$G(^DGCR(399.2,+RVCD,0)) I +$P(IBX,U,3) S IBY=+RVCD
 Q IBY
 ;
MSG(IBA) ;
 D MES^XPDUTL(IBA)
 Q
 ;
CIF ; Dental Tortiously Liable/Interagency: Bedsection^Charge Set^Effective Date^Revenue Code^Charge
 ;;OUTPATIENT DENTAL^TL-OPT DENTAL^^^236
 ;;OUTPATIENT DENTAL^IA-OPT DENTAL^^^222
 ;;QUIT
 Q
 ;
RSF ; Rate Schedule: Name^Rate Type^Bill Type^Effective Date^Inactive Date^Charge Set 
 ;;DNTL-OPT DENTAL^DENTAL^OUTPATIENT^^^TL-OPT DENTAL
 ;;IA-OPT^INTERAGENCY^OUTPATIENT^^^IA-OPT DENTAL
 ;;QUIT
 Q 
