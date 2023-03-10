IB20P735 ;ALB/CXW - UPDATE MCCR UTILITY & REVENUE & POS ; 03/25/2022
 ;;2.0;INTEGRATED BILLING;**735**;21-MAR-94;Build 27
 ;;Per VA Directive 6402, this routine should not be modified.
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to ^DIE in ICR #10018
 Q
POST ; 
 ; 1 occurrence span code in mccr utility file 399.1
 ; 1 revenue code in revenue code file 399.2
 ; 1 pos code in place of service file 353.1
 ;
 N IBZ,U S U="^"
 D MSG("    IB*2.0*735 Post-Install starts .....")
 D MCR,RVC,POS
 D MSG("    IB*2.0*735 Post-Install is complete.")
 Q
 ;
MCR ; Occurrence span code  
 N IBCNT,IBCOD,IBPE,IBFD,IBFD2,IBI,IBX
 S IBCNT=0
 ; code flag in fields #.11/piece 4, #.17/piece 10
 S IBPE=4,IBFD=.11,IBFD2=.17
 D MSG(""),MSG(" >>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX="Q"  D MFILE
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility (#399.1) file")
 Q
 ;
MFILE ; Store in mccr utility file
 N IBA,IBB,IBFN,IBMS,IBX3,IBY,DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 S IBY="    #"_IBA_" "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I IBFN D  Q:'IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0)),IBC=IBB_U_IBA
 . I $P(IBX3,U,1,2)=IBC S IBFN=0 D MSG(IBY_" already exists") Q
 . S DA=IBFN,IBMS="updated"
 ;
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding Occurrence Span Code #)"_IBA_" to the #399.1 file, Log a ticket!") Q
 . S DA=+Y,IBMS="added"
 ; 4 slashes to override the span flag
 S DIE="^DGCR(399.1,",DR=".01///"_IBB_";.02///"_IBA_";"_IBFD_"///1"_";"_IBFD2_"////1" D ^DIE
 S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
RVC ; Revenue code in fields #1/piece 2, #2/piece 3, #3/piece 4
 N IBA,IBB,IBC,IBCNT,IBD,IBF,IBI,IBMS,IBX,IBY,IBX3,DA,DIE,DR,X,Y
 S IBCNT=0
 D MSG(""),MSG(" >>>Revenue Code")
 F IBI=1:1 S IBX=$P($T(RVCU+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3)
 . S IBY="    #"_IBA_" "_IBC,IBD=IBA_U_IBB_U_1_U_IBC
 . S IBF=+$O(^DGCR(399.2,"B",IBA,0)) Q:'IBF
 . S IBX3=$G(^DGCR(399.2,IBF,0))
 . I $P(IBX3,U,1,4)=IBD D MSG(IBY_" already exists") Q
 . S IBMS=$S($P(IBX3,U,2)="*RESERVED":"added",1:"updated")
 . ;4 slashes to override the letter '*'
 . S DR="1////"_IBB_";3////"_IBC_";2///1"
 . S DIE="^DGCR(399.2,",DA=+IBF D ^DIE
 . S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 D MSG(" Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Revenue (#399.2) file")
 Q
 ;
POS ; Place Of Service in fields #.01/piece 1, #.02/piece 2, #.03/piece 3
 N IBA,IBB,IBC,IBCNT,IBD,IBF,IBI,IBMS,IBX,IBX3,IBY,DA,DIC,DIE,DLAYGO,DD,DO,DR,X,Y
 S IBCNT=0
 D MSG(""),MSG(" >>>Place of Service Code")
 F IBI=1:1 S IBX=$P($T(POSU+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U,1),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3)
 . S IBY="    #"_IBA_" "_IBB,IBD=IBA_U_IBB_U_IBC
 . S IBF=+$O(^IBE(353.1,"B",IBA,0))
 . I IBF D  Q:'IBF
 .. S IBX3=$G(^IBE(353.1,IBF,0)),DA=IBF,IBMS="updated"
 .. I $P(IBX3,U,1,3)=IBD D MSG(IBY_" already exists") S IBF=0
 . I 'IBF D  Q:Y<1
 .. S DLAYGO=353.1,DIC="^IBE(353.1,",DIC(0)="L",X=IBA D FILE^DICN
 .. I Y<1 D MSG(" >> ERROR when adding #"_IBA_" "_IBB_" to the #353.1 file, Log a ticket!") Q 
 .. S DA=+Y,IBMS="added"
 . S DIE="^IBE(353.1,",DR=".02///"_IBB_";.03///"_IBC D ^DIE
 . S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 D MSG(" Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Place of Service (#353.1) file")
 D MSG("")
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
RVCU ; Revenue code^standard abbreviation^description (1)
 ;;161^RM & BRD-OTHER-HOSP@HOME^RM AND BRD-OTHER-HOSPITAL@HOME
 ;;Q
 ;
OCCPU ; Occurrence Span code^name (1)
 ;;82^HOSP AT HOME CARE DATES
 ;;Q
 ;
POSU ; Place of Service code^name^abbreviation (1)
 ;;10^TELEHEALTH PROVIDED IN PATIENT'S HOME^TELEHEALTH PRVDD
 ;;Q
 ;
