IB20P553 ;ALB/CXW - UPDATE OCCURRENCE SPAN CODES ;07/01/2015
 ;;2.0;INTEGRATED BILLING;**553**;21-MAR-94;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update occurrence span codes in mccr utility file 399.1
 N IBZ,U S U="^"
 D MSG("     IB*2.0*553 Post-Install starts .....")
 D MCR
 D MSG("     IB*2.0*553 Post-Install is complete.")
 Q
 ;
MCR ; Occurrence span codes update
 N IBA,IBB,IBCNT,IBFN,IBPE4,IBPE10,IBI,IBX,DA,DR,DIE,X,Y
 ; Occurrence span code flags in fields #.11/piece 4, #.17/piece 10
 S IBPE4=4,IBPE10=10,IBCNT=0
 D MSG(""),MSG(" >>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 . S IBFN=+$$EXCODE(IBA,IBPE4,IBPE10)
 . I 'IBFN D MSG("   #"_IBA_" not found, no update") Q
 . I $P(^DGCR(399.1,IBFN,0),U)=IBB D MSG("   #"_IBA_" "_IBB_" already exists, no update") Q
 . S DIE="^DGCR(399.1,",DA=IBFN,DR=".01///"_IBB D ^DIE
 . S IBCNT=IBCNT+1
 . D MSG("   #"_IBA_" "_IBB_" updated")
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility file (#399.1)")
 D MSG("")
 Q
 ;
EXCODE(IBA,IBPE4,IBPE10) ; Returns IEN if code found in IBPE4/IBPE10 pieces
 N IBX,IBY,IBOSC S IBY=""
 I $G(IBA)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBA,IBX)) Q:'IBX  S IBOSC=$G(^DGCR(399.1,IBX,0)) I $P(IBOSC,U,+$G(IBPE4)),$P(IBOSC,U,+$G(IBPE10)) S IBY=IBX
 Q IBY
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
OCCPU ; Occurrence span code^name^update (11)
 ;;70^QUALIFYING STAY DATES FOR SNF USE ONLY^1
 ;;71^PRIOR STAY DATES^1
 ;;72^ID OF OPT TIME ASSOC WITH AN IP HOSP ADMIT & IP CLM FOR PYMT^1
 ;;73^BENEFITS ELIGIBILITY PERIOD^1
 ;;74^NONCOVERED LEVEL OF CARE^1
 ;;75^SNF LEVEL OF CARE^1
 ;;76^PATIENT LIABILITY^1
 ;;77^PROVIDER LIABILITY PERIOD^1
 ;;78^SNF PRIOR STAY DATES^1
 ;;79^PAYER CODE^1
 ;;80^PRIOR SAME-SNF STAY DATES FOR PAYMENT BAN PURPOSES^1
 ;;Q
 ;
