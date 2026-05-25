IB20P823 ;ALB/DMR - UPDATE MCCR UTILITY & POS ; 03/12/2024
 ;;2.0;INTEGRATED BILLING;**823**;21-MAR-94;Build 5
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update condition codes in mccr utility file 399.1
 ; and place of service codes in service file 353.1.
 ;
 ; See previous patches for all the other types of files
 ; that can possibly be updated.
 ;
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to ^DIE in ICR #10018
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 Q
POST ;
 D MSG("IB*2.0*823 Post-Install starts .....")
 D MSG("")
 N IBZ,U S U="^"
 D MCR ; Add 1 Condition code(s) and update 3 in mccr utility file 399.1
 D POS ; Add 1 Place of Service(POS) code(s) and update 2 in service file 353.1
 D MSG("IB*2.0*823 Post-Install is complete.")
 D MSG("")
 Q
 ;
MCR ;
 ; Condition code  
 N IBCNT,IBCOD,IBPE,IBFD,IBI,IBX
 ; condition code flag in field #.22/piece 15
 S IBCNT=0,IBPE=15,IBFD=.22
 D MSG(">>> Adding Condition Code")
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ; 
 D MSG("    Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated/added to MCCR UTILITY (#399.1) file")
 D MSG("")
 Q
 ;
MFILE ; Store in fields
 N IBA,IBB,IBC,IBFN,IBMS,IBX3,IBY,DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 S IBY="    #"_IBA_" "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I IBFN D  Q:'IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0)),IBC=IBB_U_IBA
 . I $P(IBX3,U,1,2)=IBC S IBFN=0 D MSG(IBY_" not re-added") Q
 . ; if new code already exists
 . S DA=IBFN,IBMS="updated"
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(">>> ERROR when adding "_$S(IBPE=11:"Value",1:"Condition")_" Code #"_IBA_" to the #399.1 file, Log a ticket!") Q
 . S DA=+Y,IBMS=""
 S DIE="^DGCR(399.1,",DR=".01///"_IBB_";.02///"_IBA_";"_IBFD_"///1" D ^DIE
 S IBCNT=IBCNT+1 D MSG(IBY_$S(IBMS'="":" "_IBMS,1:""))
 Q
 ;
EXCODE(IBCOD,IBPE) ; Returns IEN if code found in the IBPE piece
 N IBX,IBY S IBY=""
 I $G(IBCOD)'="" S IBX=0 F  S IBX=$O(^DGCR(399.1,"C",IBCOD,IBX)) Q:'IBX  I $P($G(^DGCR(399.1,IBX,0)),U,+$G(IBPE)) S IBY=IBX
 Q IBY
 ;
POS ;
 ; Place Of Service in fields #.01/piece 1, #.02/piece 2, #.03/piece 3
 N IBA,IBB,IBC,IBCNT,IBD,IBF,IBI,IBMS,IBX,IBX3,IBY,DA,DIC,DIE,DLAYGO,DD,DO,DR,X,Y
 S IBCNT=0
 D MSG(">>> Place of Service Code")
 F IBI=1:1 S IBX=$P($T(POSU+IBI),";;",2) Q:IBX="Q"  D
 . S IBA=$P(IBX,U,1),IBB=$P(IBX,U,2),IBC=$P(IBX,U,3)
 . S IBY="    #"_IBA_" "_IBB,IBD=IBA_U_IBB_U_IBC
 . S IBF=+$O(^IBE(353.1,"B",IBA,0))
 . I IBF D  Q:'IBF
 .. S IBX3=$G(^IBE(353.1,IBF,0)),DA=IBF,IBMS="updated"
 .. I $P(IBX3,U,1,3)=IBD D MSG(IBY_" already exists") S IBF=0
 . I 'IBF D  Q:Y<1
 .. S DLAYGO=353.1,DIC="^IBE(353.1,",DIC(0)="L",X=IBA D FILE^DICN
 .. I Y<1 D MSG(">>> ERROR when adding #"_IBA_" "_IBB_" to the #353.1 file, Log a ticket!") Q 
 .. S DA=+Y,IBMS="added"
 . S DIE="^IBE(353.1,",DR=".02///"_IBB_";.03///"_IBC D ^DIE
 . S IBCNT=IBCNT+1 D MSG(IBY_" "_IBMS)
 D MSG("    Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" updated/added in the Place of Service (#353.1) file")
 D MSG("")
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ) Q
 ;
CONU ; Condition code^name^update (1)
 ;;35^PACE ELIGIBLE PATIENT DISENROLLS DURING AN IP ADMISSION^1
 ;;92^INTENSIVE OUTPATIENT PROGRAM (IOP)^1
 ;;45^AMBIGUOUS SEX CATEGORY^1
 ;;KX^DOC ON FILE RQRMNTS SPECIFIED IN THE MED PLCY HVE BEEN MT
 ;;Q
 ;
POSU ; Place of Service code^name^abbreviation (1) -- Name, Max Length=50, Abbreviation Max Length=20
 ;;66^PRGM ALL INCL CR FR ELDRLY (PACE)CTR^CR FR ELD (PACE) CTR
 ;;27^OUTREACH SITE/STREET^OUTREACH SITE/STREET
 ;;58^NON-RESIDENTIAL OPIOD TREATMENT FACILITY^NON-RS OPD TRTMT FAC
 ;;Q
 ;
