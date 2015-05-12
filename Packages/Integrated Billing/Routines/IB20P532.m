IB20P532 ;ALB/CXW - UB-04 BILL CLASSIFICATION UPDATE; 07/15/2014 
 ;;2.0;INTEGRATED BILLING;**532**;21-MAR-94;Build 26
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; UB-04 bill classification in mccr utility file 399.1
 N IBX,U S U="^"
 D MSG("     IB*2.0*532 Post-Install starts .....")
 D MCR
 D MSG("     IB*2.0*532 Post-Install is complete.")
 Q
 ;
MCR ; UB-04 bill classification in field (#.23/piece 2)
 ; #4 HUMANIT. EMERG (OPT/ESRD) needs to be replaced
 N IBCOD,IBFN,IBPE,IBI,IBNW,IBX,DA,DD,DO,DIC,DIE,DLAYGO,DR,X,Y
 S IBPE=23 D MSG("")
 D MSG(">>> Adding new UB-04 Bill Classification entries to MCCR Utility file (#399.1)")
 F IBI=1:1 S IBX=$P($T(BILCS+IBI),";;",2) Q:IBX=""  D
 . S IBNW=$P(IBX,U),IBCOD=$P(IBX,U,2)
 . S IBFN=+$$EXCODE(IBCOD,IBPE)
 . ; quit if it's found in the file 
 . I IBFN,($P($G(^DGCR(399.1,IBFN,0)),U)=IBNW) D MSG("    #"_IBCOD_" "_IBNW_" already exists in the file") Q
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBNW D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding the UB-04 Bill Classification for "_IBNW_" to the file, Log a Remedy ticket!") Q 
 . S DIE=DIC,DA=+Y,DR=".02///"_IBCOD_";.23///"_$P(IBX,U,3)_";.24///"_$P(IBX,U,4) D ^DIE
 . D MSG("    #"_IBCOD_" "_IBNW_" added")
 D MSG("")
 Q
 ;
MSG(IBX) ;
 D MES^XPDUTL(IBX) Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
BILCS ; name^code^bill classification^valid location of care values
 ;;LABORATORY SERVICES PROVIDED TO NON-PATIENTS^4^1^1,3
 ;
