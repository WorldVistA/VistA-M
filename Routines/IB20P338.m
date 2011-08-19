IB20P338 ;ALB/CXW - IB*2.0*338 POST INIT: MCCR UTILITY CODES (#399.1) ; 1/20/06
 ;;2.0;INTEGRATED BILLING;**338**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
POST ;
 N U S U="^"
 D START,MUCODES,END
 Q
START ;
 D MES^XPDUTL("")
 D MES^XPDUTL("    IB*2.0*338 Post-Install .....")
 Q
END ;
 D MES^XPDUTL("")
 D MES^XPDUTL("    IB*2.0*338 Post-Install Complete")
 Q
 ;
MUCODES ; Add MCCR UTILITY Codes to 399.1
 N DLAYGO,DIC,DIE,DD,DO,DA,DR,X,Y,IBA,IBI,IBLN,IBCNT,IBFN,IBTYPE
 S IBCNT=0,IBTYPE="UB-92 Value Codes"
 ;
 F IBI=1:1 S IBLN=$P($T(MUCF+IBI),";;",2) Q:IBLN=""  I $E(IBLN)'=" " D
 . ;
 . I $P(IBLN,U,1)="" Q  ;if no code enters quit 
 . ;
 . I +$$MCCRUTL($P(IBLN,U,3),+IBLN) D  Q  ; if code exists quit
 . . D BMES^XPDUTL("  Duplication of "_IBTYPE_": "_$P(IBLN,U,3))
 . ;
 . K DD,DO S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=$E($P(IBLN,U,8),1,60) D FILE^DICN K DIC I Y<1 K X,Y Q
 . S IBFN=+Y,IBCNT=IBCNT+1
 . ;
 . S DR=".02////"_$P(IBLN,U,3)_";"_$P(IBLN,U,2)_"////"_1
 . S DR=DR_$S($P(IBLN,U,4)'="":";.03////"_$P(IBLN,U,4),1:"")_$S($P(IBLN,U,5)'="":";.16////"_$P(IBLN,U,5),1:"")
 . S DR=DR_$S($P(IBLN,U,6)'="":";.17////"_$P(IBLN,U,6),1:"")_$S($P(IBLN,U,7)'="":";.19////"_$P(IBLN,U,7),1:"")
 . ;
 . S DIE="^DGCR(399.1,",DA=+IBFN D ^DIE K DIE,DA,DR,X,Y
 ;
MSG ;add message to install giving count and type of codes added
 D BMES^XPDUTL("  "_IBCNT_" "_IBTYPE_" added to file (#399.1)")
 Q
 ;
MCCRUTL(X,P) ; returns IFN of item in 399.1 if Code is found and piece P is true
 ;
 N IBX,IBY S IBY=""
 I $G(X)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",X,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(P)) S IBY=IBX
 Q IBY
 ;
 ;
MUCF ; TYPE #^TYPE FLD^.02 CODE ^.03 ABBR^.16 OCC REL^.17 OCC SPAN^.19 VC AMNT^.01 NAME
 ;; 
 ;;^UB-92 Value Codes
 ;;11^.18^A0^^^^^SPECIAL ZIP CODE REPORTING
 ;;
