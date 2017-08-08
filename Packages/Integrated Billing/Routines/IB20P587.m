IB20P587 ;ALB/CXW - UPDATE MCCR UTILITY & REVENUE & POS & RNB ;01/31/2017
 ;;2.0;INTEGRATED BILLING;**587**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; Update value/occurrence/condition codes in mccr utility file 399.1
 ; Update revenue codes in revenue code file 399.2
 ; Update pos code in place of service file 353.1
 ; Update CT non-billable reasons file 356.8
 N IBZ,U S U="^"
 D MSG("    IB*2.0*587 Post-Install starts .....")
 D MCR,RVC,POS,RNB
 D MSG("    IB*2.0*587 Post-Install is complete.")
 Q
 ;
MCR ; 3 types of codes
 N IBCNT,IBCOD,IBPE,IBFD,IBFD2,IBI,IBX S IBFD2=""
 ; Value code flag in field #.18/piece 11
 S IBCNT=0,IBPE=11,IBFD=.18
 D MSG(""),MSG(" >>>Value Code")
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 ; Condition code flag in field #.22/piece 15
 S IBPE=15,IBFD=.22
 D MSG(""),MSG(" >>>Condition Code")
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 ; Occurrence span code flag in fields #.11/piece 4, #.17/piece 10
 S IBPE=4,IBFD=.11,IBFD2=.17
 D MSG(""),MSG(" >>>Occurrence Span Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ; 
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR Utility (#399.1) file")
 Q
 ;
MFILE ; store in mccr utility file
 N IBA,IBB,IBC,IBFN,IBMS,IBX3,IBY,DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 S IBY="    #"_IBA_" "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I IBFN D  Q:'IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0)),IBC=IBB_U_IBA
 . I $P(IBX3,U,1,2)=IBC S IBFN=0 D MSG(IBY_" already exists") Q
 . S DA=IBFN,IBMS="updated"
 ;
 ; 4 slashes to override flag in #.17
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding "_$S(IBPE=11:"Value",IBPE=15:"Condition",1:"Occurrence Span")_" Code #"_IBA_" to the #399.1 file, Log a ticket!") Q
 . S DA=+Y,IBMS="added"
 S DIE="^DGCR(399.1,",DR=".01///"_IBB_";.02///"_IBA_";"_IBFD_"///1"
 S:IBFD2 DR=DR_";"_IBFD2_"////1" D ^DIE
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
 . S IBMS=$S($P(IBX3,U,2)="*RESERVED":"added",$P(IBX3,U,4)="*RESERVED":"added",1:"updated")
 . ;4 slashes to override the letter '*'
 . S DR="1////"_IBB_";3////"_IBC_";2///1"
 . S DIE="^DGCR(399.2,",DA=+IBF D ^DIE
 . S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Revenue (#399.2) file")
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
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Place of Service (#353.1) file")
 Q
 ;
RNB ; RNB in fields #.01/piece 1, #.02/piece 2, #.03/piece 3, #.04/piece
 N IBA,IBB,IBC,IBCNT,IBD,IBE,IBF,IBI,IBMS,IBX,IBY,IBX3,DA,DLAYGO,DIE,DINUM,DR,X,Y
 S IBCNT=0
 D MSG(""),MSG(" >>>Reasons Not Billable")
 F IBI=1:1 S IBX=$P($T(NRNB+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3),IBD=$P(IBX,U,4)
 . S IBY="    #"_IBA_" "_IBB,IBE=IBB_U_IBC_U_IBD_U_IBA
 . S IBF=+$O(^IBE(356.8,"B",IBB,0))
 . I IBF D  Q:'IBF
 .. S IBX3=$G(^IBE(356.8,IBF,0)),DA=IBF,IBMS="updated"
 .. I $P(IBX3,U,1,4)=IBE D MSG(IBY_" already exists") S IBF=0 Q
 . I 'IBF D  Q:Y<1
 .. F IBF=100:1 S IBX3=$G(^IBE(356.8,IBF,0)) I IBX3="" S DINUM=IBF Q 
 .. S DLAYGO=356.8,DIC="^IBE(356.8,",DIC(0)="L",X=IBB D FILE^DICN
 .. I Y<1 D MSG(" >> ERROR when adding "_IBY_" to the #356.8 file, log a ticket!") Q
 .. S DA=+Y,IBMS="added"
 . S DIE="^IBE(356.8,",DR=".04///"_IBA_";.02///"_IBC_";.03///"_IBD D ^DIE
 . S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the Claims Tracking Non-Billable Reasons (#356.8) file")
 D MSG("")
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
RVCU ; Revenue code^standard abbreviation^description^update (2)
 ;;815^ACQUISITION OF BODY COMPONENTS-STEM CELLS-ALLOGENIC^ACQUISITION OF BODY COMPONENTS-STEM CELLS-ALLOGENIC^1
 ;;826^HEMODIALYSIS OP/HOME HEMODIALYSIS SHORT DURATION^HEMODIALYSIS OP/HOME HEMODIALYSIS SHORT DURATION
 ;;Q
 ;
VALU ; Value code^name (1)
 ;;84^SHORTER DURATION HEMODIALYSIS
 ;;Q
 ;
CONU ; Condition code^name^update (7)
 ;;53^INIT PLCMNT MED DEV PART CLINICAL TRIAL OR A FREE SAMPLE
 ;;55^SNF BED NOT AVAILABLE^1
 ;;70^SELF ADMINISTERED ANEMIA MANAGEMENT DRUG^1
 ;;84^DIALYSIS FOR ACUTE KIDNEY INJURY (AKI)
 ;;85^DELAYED RECERTIFICATION OF HOSPICE TERMINAL ILLNESS
 ;;86^ADDNL HEMODIALYSIS TREATMENTS WITH MEDICAL JUSTIFICATION
 ;;87^ESRD SELF CARE RE-TRAINING
 ;;Q
 ;
OCCPU ; Occurrence span code^name (1)
 ;;MR^RESERVED FOR DISASTER RELATED OCCURRENCE SPAN CODE
 ;;Q
 ;
POSU ; Place of Service code^name^abbreviation (1)
 ;;02^TELEHEALTH-LOCAT-HLTH SVCS/RELATED SVCS TELEC SYS^TELEHEALTH SVCS
 ;;Q
 ;
NRNB ; code^name^ecme flag^ecme paper flag (2)
 ;;CV28^CHAMPVA PT SEEN AS VETERAN^1^0
 ;;MC26^LOD NOT OBTAINED
 ;;Q
 ;
