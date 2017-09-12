IB20P526 ;ALB/CXW - UPDATE MCCR UTILITY ; 07/01/2014
 ;;2.0;INTEGRATED BILLING;**526**;21-MAR-94;Build 17
 ;;Per VHA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update mccr utility file 399.1
 N U S U="^"
 D MES^XPDUTL("Patch Post-Install starts")
 D MCR
 D MES^XPDUTL("Patch Post-Install is complete.")
 Q
 ;
MCR ; 1 type of code
 N IBCNT,IBCOD,IBPE,IBFD,IBFN,IBI,IBX,DA,DIE,DR,X,Y
 ;
 ; Occurrence code flag in field #.11/piece 4
 ; Occurrence span flag in field #.17/piece 10
 S IBCNT=0,IBPE=10,IBFD=.17
 D MES^XPDUTL(""),MES^XPDUTL(">>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX=""  D
 . ; store in mccr utility file
 . S IBFN=+$$EXCODE($P(IBX,U),IBPE)
 . I 'IBFN D MES^XPDUTL("   #"_$P(IBX,U)_" "_$P(IBX,U,2)_" not defined") Q 
 . ; no update if new name exists
 . I $P($G(^DGCR(399.1,IBFN,0)),U,1)=$P(IBX,U,3) D MES^XPDUTL("   #"_$P(IBX,U)_" "_$P(IBX,U,3)_" already updated") Q 
 . S DIE="^DGCR(399.1,",DA=IBFN,DR=".01///"_$P(IBX,U,3) D ^DIE
 . S IBCNT=IBCNT+1 D MES^XPDUTL("   #"_$P(IBX,U)_" "_$P(IBX,U,3)_" updated")
 ;
 D MES^XPDUTL("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility file (#399.1)")
 D MES^XPDUTL("")
 Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
OCCPU ; Occurrence span code^old name^new name
 ;;72^FIRST/LAST VISIT^ID OF OPT TIME ASSOC WITH AN IP HOSP ADMIT & IP CLM FOR PYMT
 ;
