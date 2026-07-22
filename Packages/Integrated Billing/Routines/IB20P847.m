IB20P847 ;ALB/JWB - UPDATE MCCR UTILITY VALUE/CONDITION CODES ; 03/25/2026
 ;;2.0;INTEGRATED BILLING;**847**;21-MAR-94;Build 2
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine is used as a post-init in a KIDS build to
 ; update value and condition codes in MCCR utility file 399.1.
 ;
 ; Reference to FILE^DICN in ICR #10009
 ; Reference to ^DIE in ICR #10018
 ; Reference to MES^XPDUTL in ICR #10141
 ;
 Q
POST ;
 ; Update value/condition codes effective 2025/2026 in file 399.1
 N IBZ,U S U="^"
 D BMSG("    IB*2.0*847 Post-Install starts .....")
 D MCR
 D BMSG("    IB*2.0*847 Post-Install is complete.")
 Q
 ;
MCR ; Two types of codes
 N IBCNT,IBPE,IBFD,IBI,IBX
 ;
 ; value code flag in field #.18/piece 11
 S IBCNT=0,IBPE=11,IBFD=.18
 D BMSG(" >> Adding Value Code")
 F IBI=1:1 S IBX=$P($T(VALU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 ; condition code flag in field #.22/piece 15
 S IBPE=15,IBFD=.22
 D BMSG(" >> Adding Condition Code")
 F IBI=1:1 S IBX=$P($T(CONU+IBI),";;",2) Q:IBX="Q"  D MFILE
 ;
 D MSG("Total "_IBCNT_" code"_$S(IBCNT'=1:"s",1:"")_" added to MCCR UTILITY (#399.1) file")
 Q
 ;
MFILE ; Store in fields
 N IBA,IBB,IBC,IBFN,IBMS,IBX3,IBY,DLAYGO,DIC,DIE,DA,DD,DO,DR,X,Y
 S IBA=$P(IBX,U),IBB=$P(IBX,U,2)
 S IBY="    "_IBA_"  "_IBB
 S IBFN=+$$EXCODE(IBA,IBPE)
 I IBFN D  Q:'IBFN
 . S IBX3=$G(^DGCR(399.1,IBFN,0)),IBC=IBB_U_IBA
 . I $P(IBX3,U,1,2)=IBC S IBFN=0 D MSG(IBY_" not re-added") Q
 . ; if new code already exists
 . S DA=IBFN,IBMS="updated"
 I 'IBFN D  Q:Y<1
 . S DLAYGO=399.1,DIC="^DGCR(399.1,",DIC(0)="L",X=IBB D FILE^DICN
 . I Y<1 D MSG(" >> ERROR when adding "_$S(IBPE=11:"Value",1:"Condition")_" Code #"_IBA_" to the #399.1 file, Log a ticket!") Q
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
BMSG(IBZ) ;
 D BMES^XPDUTL(IBZ)
 Q
 ;
MSG(IBZ) ;
 D MES^XPDUTL(IBZ)
 Q
 ;
VALU ; Value code^name (1)
 ;;92^DRG/BIOLGC INV CST
 ;;Q
CONU ; Condition code^name (2)
 ;;CA^CYBERATTACK OR OTHER SYSTEM OUTAGE
 ;;63^INCARCERATED BENEFICIARIES
 ;;Q
