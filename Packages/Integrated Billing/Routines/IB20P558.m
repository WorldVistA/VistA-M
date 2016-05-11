IB20P558 ;ALB/CXW - UPDATE POS & TRICARE RX ADMINISTRATIVE FEE; 11/23/2015
 ;;2.0;INTEGRATED BILLING;**558**;21-MAR-94;Build 32
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update pos code in place of service file 353.1
 ; Update tricare pharmacy administrative fee in Rate Schedule file 363
 N IBA,U S U="^"
 D MSG("IB*2.0*558 Post-Install starts.....")
 D TRXAF,POS
 D MSG("IB*2.0*558 Post-Install is complete.")
 Q
 ;
POS ; Place Of Service
 N IBCNT,IBI,IBX,IBY,IBZ,DA,DD,DO,DLAYGO,DIC,DIE,DR,X,Y
 S IBCNT=0
 D MSG(" >>>Place of Service Code")
 F IBI=1:1 S IBX=$P($T(POSU+IBI),";;",2) Q:IBX="Q"  D
 . S IBY=$P(IBX,U,1)
 . S IBZ=$P(IBX,U,1)_" "_$P(IBX,U,2)
 . S IBY=$O(^IBE(353.1,"B",IBY,0))
 . I 'IBY D  Q
 .. S DLAYGO=353.1,DIC="^IBE(353.1,",DIC(0)="L",X=$P(IBX,U,1) D FILE^DICN
 .. I Y<1 K X,Y D MSG(" >>>ERROR when adding #"_IBZ_" to the file, Log a Remedy ticket!") Q
 .. S DA=+Y,DIE=DIC,DR=".02///"_$P(IBX,U,2)_";.03///"_$P(IBX,U,3) D ^DIE
 .. D MSG("    "_IBZ_" added")
 .. S IBCNT=IBCNT+1
 . I $G(^IBE(353.1,IBY,0))=$P(IBX,U,1,3) D MSG("    "_IBZ_" already exists, no change") Q
 . S DA=IBY,DIE="^IBE(353.1,",DR=".02///"_$P(IBX,U,2)_";.03///"_$P(IBX,U,3) D ^DIE
 . D MSG("    "_IBZ_" updated")
 . S IBCNT=IBCNT+1
 D MSG(" Total "_IBCNT_" code"_$S(IBCNT>1:"s",1:"")_" updated in the Place of Service file (#353.1)")
 D MSG("")
 Q
 ;
TRXAF ; Rate Schedule
 N IBCT,IBI,IBT,IBMSG,IBX,IBRS,IBRSIN,IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST
 D MSG(""),MSG(" >>>Rate Schedule")
 S IBMSG="Rx Administrative Fee "
 S IBADFE="",IBEFFDT="3160101",IBCT=0
 F IBX=1:1 S IBT=$P($T(RSF+IBX),";;",2) Q:IBT="Q"  D
 . S IBRATY=$P(IBT,U)
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,0))
 . I 'IBRSIN D MSG("    "_IBRATY_" Rate Type not defined, the "_IBMSG_"not added") Q
 . ; latest entry
 . S IBRSIN=$O(^DGCR(399.3,"B",IBRATY,99999),-1)
 . I $P($G(^DGCR(399.3,+IBRSIN,0)),U,3) D MSG("    "_IBRATY_" Rate Type not active, the "_IBMSG_" not added") Q
 . I $$RSEXIST(IBEFFDT,IBRSIN) D MSG("    CY2016 "_IBRATY_" "_IBMSG_"already exists, no change") Q
 . S IBDISP=$P(IBT,U,2)
 . S IBADJUST=$P(IBT,U,3)
 . ; procedure of outpatient rx administrative fee update
 . D ENT^IB3PSOU(IBRATY,IBEFFDT,IBADFE,IBDISP,IBADJUST)
 . ; double check
 . I $$RSEXIST(IBEFFDT,IBRSIN) S IBCT=IBCT+1 D MSG("    CY2016 "_IBRATY_" "_IBMSG_"added")
 D MSG(" Total "_IBCT_$S(IBCT>1:" entries",1:" entry")_" updated in the Rate Schedule file (#363)")
 D MSG("")
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
POSU ; Place of Service code^name^abbreviation
 ;;17^WALK-IN RETAIL HEALTH CLINIC^WLK-IN RET HLTH CL
 ;;19^OFF CAMPUS-OUTPATIENT HOSPITAL^OFF CAMP OP HOSP
 ;;22^ON CAMPUS-OUTPATIENT HOSPITAL^ON CAMP OP HOSP
 ;;Q
 ;
RSF ; Rate type^dispensing fee^adjustment
 ;;TRICARE REIMB. INS.^12.19^S X=X+12.19
 ;;TRICARE^12.19^S X=X+12.19
 ;;Q
 ;
