IB20P637 ;ALB/CXW - UPDATE MCCR UTILITY FILE ;01/16/2019
 ;;2.0;INTEGRATED BILLING;**637**;21-MAR-94;Build 29
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; 2019 Update occurrence span/value codes in #399.1
 N IBZ,U S U="^"
 D MSG("    IB*2.0*637 Post-Install starts .....")
 D MCCR
 D MSG("    IB*2.0*637 Post-Install is complete.")
 Q
 ;
MCCR ; 2 types of codes
 N IBCNT,IBCOD,IBPE,IBFD,IBFD2,IBI,IBX
 S IBCNT=0
 ; Occurrence span code in fields #.11/piece 4, #.17/piece 10
 S IBPE=4,IBFD=.11,IBFD2=.17
 D MSG(""),MSG(" >>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCSPU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 ; Value code in field #.18/piece 11
 S IBPE=11,IBFD=.18
 D MSG(""),MSG(" >>>Value Code")
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX="Q"  D MFILE
 D MSG(""),MSG(" Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR UTILITY (#399.1) file")
 D MSG("")
 Q
 ;
MFILE ; Update to the mccr utility file
 N IBA,IBB,IBC,IBFN,IBMS,IBX2,IBX3,IBY,DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3)
 S IBMS=$S(IBC=1:"updated",1:"added")
 S IBY="    #"_IBA_" "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I IBFN D  Q:'IBFN
 . S DA=IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0))
 . S IBX2=IBB_U_IBA
 . I $P(IBX3,U,1,2)=IBX2 D MSG(IBY_" already exists") S IBFN=0 Q
 ; 
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding "_$S(IBPE=11:"Value",1:"Occurrence Span")_" Code #"_IBA_" to the #399.1 file, Log a ticket!") Q
 . S DA=+Y
 ; add override flag for new code if no found
 S DIE="^DGCR(399.1,",DR=".01///"_IBB_";.02///"_IBA_";"_IBFD_"///1"
 S:IBPE=11 DR=DR_";.19////1" S:IBPE=4 DR=DR_";"_IBFD2_"////1" D ^DIE
 S IBCNT=IBCNT+1
 D MSG(IBY_" "_IBMS)
 Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
OCSPU ; Occurrence span code (2)^name^1 - update
 ;;72^FIRST/LAST DAY^1
 ;;74^LEAVE OF ABSENCE DATES^1
 ;;Q
 ;
VALU ; Value code (2)^name^1 - update
 ;;04^PROFESSIONAL COMPONENT CHARGES, COMBINED BILLED^1
 ;;Q
 ;
