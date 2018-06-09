IB20P613 ;ALB/CXW - UPDATE MCCR UTILITY FILE ;01/02/2017
 ;;2.0;INTEGRATED BILLING;**613**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
POST ; 
 ; 2018 Update condition/occurrence/value codes in #399.1
 N IBZ,U S U="^"
 D MSG("    IB*2.0*613 Post-Install starts .....")
 D MCR
 D MSG("    IB*2.0*613 Post-Install is complete.")
 Q
 ;
MCR ; 3 types of codes
 N IBCNT,IBCOD,IBPE,IBFD,IBI,IBX
 S IBCNT=0
 ; Condition code flag in field #.22/piece 15
 S IBPE=15,IBFD=.22
 D MSG(""),MSG(" >>>Condition Code")
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ; Remove A7 or A8 pointer in field #.01/subfile #399.04/file #399  
 D RMCON
 ;
 ; Occurrence code flag in field #.11/piece 4
 S IBPE=4,IBFD=.11
 D MSG(""),MSG(" >>>Occurrence Code")
 F IBI=1:1 S IBX=$P($T(OCCPU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 ; Value code flag in field #.18/piece 11
 S IBPE=11,IBFD=.18
 D MSG(""),MSG(" >>>Value Code")
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX="Q"  D MFILE
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated in the MCCR UTILITY (#399.1) file")
 D MSG("")
 Q
 ;
MFILE ; Update to the mccr utility file
 N IBA,IBB,IBC,IBFN,IBMS,IBX2,IBX3,IBY,DLAYGO,DIC,DIE,DIK,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3)
 S IBMS=$S(IBC=1:"updated",IBC=2:"removed",1:"added")
 S IBY="    #"_IBA_" "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I 'IBFN,IBC=2 D MSG(IBY_" already removed") Q
 I IBFN D  Q:'IBFN
 . S DA=IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0))
 . S IBX2=IBB_U_IBA
 . I IBC'=2,$P(IBX3,U,1,2)=IBX2 S IBFN=0 D MSG(IBY_" already exists") Q
 . I IBC=1 Q
 . S IBCOD(IBFN)="",DIK="^DGCR(399.1," D ^DIK
 . S IBFN=0,IBCNT=IBCNT+1
 . D MSG(IBY_" "_IBMS)
 ; 
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding "_$S(IBPE=11:"Value",IBPE=15:"Condition",1:"Occurrence")_" Code #"_IBA_" to the #399.1 file, Log a ticket!") Q
 . S DA=+Y
 ; add value code amount by override flag
 S DIE="^DGCR(399.1,",DR=".01///"_IBB_";.02///"_IBA_";"_IBFD_"///1"
 S:IBPE=11 DR=DR_";.19////1" D ^DIE
 S IBCNT=IBCNT+1
 D MSG(IBY_" "_IBMS)
 Q
 ;
RMCON ; Remove A7 or A8 pointer on bill entry 
 ; - bill# & pointer store in xtmp for 30 days for tracking purpose
 ; - xtmp(patch#,0)=purge dt^today dt^patch#^total bill
 ; - xtmp(patch#,file#,ibien,conien)=bill#^pointer 
 N IB613,IBC,IBI,IBFN,IBMS,IBX,IBY,DIE,DR,DT,X,X1,X2,Y
 S IBI=0,IB613="IB20P613"
 S DT=$$DT^XLFDT,X1=DT,X2=30 D C^%DTC
 K ^XTMP(IB613)
 S ^XTMP(IB613,0)=X_U_DT_U_"IB*2.0*613 POST-INIT"_U_0
 I $O(IBCOD(0))="" G RMCONQ
 S IBX=0 F  S IBX=$O(^DGCR(399,IBX)) Q:'IBX  D
 . S IBMS=$G(^DGCR(399,IBX,0)) Q:IBMS=""
 . ; effective date 03/16/2011 of a7 & a8 with name
 . Q:$P(IBMS,U,3)<3110316
 . S (IBFN,IBY)=0 F  S IBY=$O(^DGCR(399,IBX,"CC",IBY)) Q:'IBY  D 
 .. S IBC=$G(^DGCR(399,IBX,"CC",IBY,0)) Q:'IBC
 .. Q:'$D(IBCOD(IBC))
 .. S DA(1)=IBX,DA=IBY,IBFN=1
 .. S DIK="^DGCR(399,"_DA(1)_","_"""CC"""_"," D ^DIK
 .. S ^XTMP(IB613,399,IBX,IBY)=$P($G(^DGCR(399,IBX,0)),U,1)_U_IBC
 . S:IBFN IBI=IBI+1
 S $P(^XTMP(IB613,0),U,4)=IBI
RMCONQ D MSG("    Note: #A7 or #A8 removed on total "_IBI_" bill"_$S(IBI'=1:"s",1:"")_" of the BILL/CLAIMS (#399) file")
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
CONU ; Condition code (5)^name^update or remove
 ;;30^QUALIFY CLINICAL TRIALS^1
 ;;A7^RZD FOR NATIONAL ASSIGNMENT^2
 ;;A8^RZD FOR NATIONAL ASSIGNMENT^2
 ;;M3^SNF 3 DAY STAY BYPASS FOR NG/PIONEER ACD WAIVER
 ;;MG^GRANDFATHERED TRIBAL FQHC (MEDICARE ONLY CODE)
 ;;Q
 ;
OCCPU ; Occurrence code (1)^name^update
 ;;56^ORIGINAL HOSPICE ELECTION OR REVOCATION DATE^1
 ;;Q
 ;
VALU ; Value code (4)^name
 ;;62^HHA VISITS - PART A
 ;;63^HHA VISITS - PART B
 ;;64^HHA REIMBURSEMENT - PART A
 ;;65^HHA REIMBURSEMENT - PART B
 ;;Q
 ;
