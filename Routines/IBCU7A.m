IBCU7A ;ALB/ARH - BILL PROCEDURE MANIPULATIONS ; 10-OCT-03
 ;;2.0;INTEGRATED BILLING;**245,287**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; Based on Reasonable Charges v2.0+, certain CPT codes should be reported in a certain way
 ; this set of routines manipulates the bill's procedure to conform to the charges and proper billing
 ;
 ; criteria:  bill must be a Reasonable Charges bill
 ;            charges must be v2.0 or greater
 ;
 ; called after bill created and populated to reset procedures
 ;
PROC(IBIFN,EDIT) ; manipulate bill procedures base on charges and the clinical data
 ; EDIT is a flag for which manipulations should be completed, if true then only the charge significant manipulations are preformed
 N IB0,IBBCT,IBPBTYP S EDIT=$G(EDIT)
 I '$O(^DGCR(399,+$G(IBIFN),"CP",0)) Q
 S IB0=$G(^DGCR(399,+IBIFN,0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) Q:'IBBCT
 I +$P($G(^DGCR(399,+IBIFN,"U")),U,2)<$$VERSDT^IBCRU8(2) Q
 I '$$BILLRATE^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IB0,U,3),"RC") Q
 ;
 S IBPBTYP=$P($$RCDV^IBCRU8(+$P(IB0,U,22)),U,3) Q:'IBPBTYP
 ;
 I 'EDIT,IBPBTYP<3 D DELCLN(IBIFN) ; delete TC/26 component clinical procedures from bills
 I 'EDIT,IBPBTYP<3 D ADDCLN(IBIFN) ; add 26 modified clinical procedures to bill
 I 'EDIT,IBPBTYP<3 D DELTC(IBIFN) ; delete all TC modifiers from institutional bills
 ;
 D MOD26(IBIFN) ; if only professional charge is a 26 charge then add or delete modifier 26 on procedure
 ;
 D BNDL^IBCU7A1(IBIFN) ; split or combine bundled procedures
 ;
 K ^UTILITY($J)
 Q
 ;
 ;
 ;
DELTC(IBIFN) ; delete TC modifier from all procedures on RC v2.0+ Institutional bills
 N IB0,IBBCT,IBTC,IBBCPT,IBLN,IBEVDT,IBMODS,IBV2,IBCHANGE S IBCHANGE=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) I IBBCT'=1 Q
 S IBTC=+$$MOD^ICPTMOD("TC","E") Q:IBTC<1  S IBV2=$$VERSDT^IBCRU8(2)
 ;
 S IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP",IBBCPT)) Q:'IBBCPT  D
 . S IBLN=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0)),IBEVDT=$P(IBLN,U,2) Q:IBLN'[";ICPT("
 . I IBEVDT<IBV2 Q
 . S IBMODS=","_$$GETMOD^IBEFUNC(IBIFN,IBBCPT)_","
 . I IBMODS[IBTC D DELMOD^IBCU73(IBIFN,IBBCPT,IBTC) S IBCHANGE=IBCHANGE+1
 I '$D(ZTQUEUED),'$G(IBAUTO),+IBCHANGE W !,"Modifier TC Deleted from all Procedures ("_IBCHANGE_")."
 Q
 ;
DELCLN(IBIFN) ; remove clinical procedures from RC v2.0+ bills
 ; - remove from institutional bill any procedures with a 26 in the clincal data
 ; - remove from professional bill any procedures with a TC in the clinical data
 ; to delete a procedure the outpatient encounter pointer must match the clinical encounter
 ; (checks for non-modified procedure on bill in case modifier was manually removed)
 ;
 N IB0,IBBCT,IBMODE,IBMOD,IBX,IBLN,IBOE,IBCM,IBCPT,IBBCPT,IBLN1,IBFND,IBEND,IBV2,IBCHANGE S IBCHANGE=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) I 'IBBCT Q
 S IBMODE=$S(IBBCT=1:26,IBBCT=2:"TC",1:"") Q:IBMODE=""  S IBV2=$$VERSDT^IBCRU8(2)
 S IBMOD=+$$MOD^ICPTMOD(IBMODE,"E") Q:IBMOD<1
 ;
 D GETSD^IBCU7U(IBIFN)
 S IBX=0 F  S IBX=$O(^UTILITY($J,"CPT-CNT",IBX)) Q:'IBX  D
 . S IBLN=$G(^UTILITY($J,"CPT-CNT",IBX)),(IBEND,IBFND)=0
 . I +$P(IBLN,U,2)<IBV2 Q
 . S IBOE=+$P(IBLN,U,11),IBCM=","_$P(IBLN,U,10)_","
 . ;
 . I IBCM[(","_IBMOD_",") D
 .. S IBCPT=+IBLN_";ICPT(",IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP","B",IBCPT,IBBCPT)) Q:'IBBCPT  D  Q:IBEND
 ... S IBLN1=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0))
 ... I IBOE=$P(IBLN1,U,20) S IBFND=IBBCPT I $O(^DGCR(399,IBIFN,"CP",IBBCPT,"MOD","C",IBMOD,0)) S IBEND=1
 .. I +IBFND,+$$DELCPT^IBCU7U(IBIFN,IBBCPT) S IBCHANGE=IBCHANGE+1
 I '$D(ZTQUEUED),'$G(IBAUTO),+IBCHANGE W !,"Modifier "_IBMODE_" Procedures Deleted ("_IBCHANGE_")."
 Q
 ;
ADDCLN(IBIFN) ; add 26 modified clinical procedures to RC v2.0+ bills
 ; - add to professional bill any procedures with a 26 in the clinical data
 ; to add the clinical procedure the bill must not already have that procedure for the date
 ; (checks for non-modified procedure on bill in case modifier was manually removed)
 ;
 N IB0,IBBCT,IBMOD,IBX,IBLN,IBEVDT,IBCM,IBCPT,IBBCPT,IBLN1,IBFND,IBEND,IBV2,IBCHANGE S IBCHANGE=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) I IBBCT'=2 Q
 S IBMOD=+$$MOD^ICPTMOD("26","E") Q:IBMOD<1  S IBV2=$$VERSDT^IBCRU8(2)
 ;
 D GETSD^IBCU7U(IBIFN)
 S IBX=0 F  S IBX=$O(^UTILITY($J,"CPT-CNT",IBX)) Q:'IBX  D
 . S IBLN=$G(^UTILITY($J,"CPT-CNT",IBX)),(IBEND,IBFND)=0
 . S IBEVDT=+$P(IBLN,U,2),IBCM=","_$P(IBLN,U,10)_","
 . I IBEVDT<IBV2 Q
 . ;
 . I IBCM[(","_IBMOD_",") D
 .. S IBCPT=+IBLN_";ICPT(",IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP","B",IBCPT,IBBCPT)) Q:'IBBCPT  D  Q:IBEND
 ... S IBLN1=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0))
 ... I IBEVDT=$P(IBLN1,U,2) S IBFND=IBBCPT I $O(^DGCR(399,IBIFN,"CP",IBBCPT,"MOD","C",IBMOD,0)) S IBEND=1
 .. I 'IBFND,+$$ADDCPT^IBCU7U(IBIFN,IBLN) S IBCHANGE=IBCHANGE+1
 I '$D(ZTQUEUED),'$G(IBAUTO),+IBCHANGE W !,"Modifier 26 Procedures Added ("_IBCHANGE_")."
 Q
 ;
MOD26(IBIFN) ; add/delete modifier 26 to procedure if that is the only professional charge available
 ; added on professional bill, deleted from institutional bill
 N IB0,IBBCT,IB26,IBBCPT,IBLN,IBEVDT,IBMODS,IBV2,IBCHANGE,IBCHGS S IBCHANGE=0
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBBCT=$P(IB0,U,27) I 'IBBCT Q
 S IB26=+$$MOD^ICPTMOD("26","E") Q:IB26<1  S IBV2=$$VERSDT^IBCRU8(2)
 ;
 S IBBCPT=0 F  S IBBCPT=$O(^DGCR(399,IBIFN,"CP",IBBCPT)) Q:'IBBCPT  D
 . S IBLN=$G(^DGCR(399,IBIFN,"CP",IBBCPT,0)),IBEVDT=$P(IBLN,U,2) Q:IBLN'[";ICPT("
 . I IBEVDT<IBV2 Q
 . S IBMODS=","_$$GETMOD^IBEFUNC(IBIFN,IBBCPT)_","
 . ;
 . S IBCHGS=$$CHGMOD^IBCRCU1(IBIFN,+IBLN,IBEVDT,2) I (+IBCHGS'=1)!(+$P(IBCHGS,":",3)'=IB26) Q
 . ;
 . I IBBCT=1,IBMODS[IB26 D DELMOD^IBCU73(IBIFN,IBBCPT,IB26) S IBCHANGE=IBCHANGE+1
 . I IBBCT=2,IBMODS'[IB26 D ADDMOD^IBCU73(IBIFN,IBBCPT,IB26) S IBCHANGE=IBCHANGE+1
 ;
 I '$D(ZTQUEUED),'$G(IBAUTO),+IBCHANGE W !,"Modifier 26 "_$S(IBBCT=1:"Deleted from",1:"Added to")_" Procedures ("_IBCHANGE_")."
 Q
 ;
 ;
ASK(IBIFN) ; ask if the bill procedure modifications should be executed
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 I '$O(^DGCR(399,+$G(IBIFN),"CP",0)) Q
 S DIR("?")="Enter Yes to apply the bill procedure modifications for charges."
 S DIR("?",1)="For Reasonable Charges some procedures must be billed in a certain way to"
 S DIR("?",2)="receive a charge.  The bill procedure modifications apply rules to the bill"
 S DIR("?",3)="procedures to ensure the correct Reasonable Charge.",DIR("?",4)=""
 S DIR("?",5)="- Modifier 26 will be added/removed from procedures if it affects the charges."
 S DIR("?",6)="- Certain global procedures with no charge will be split into their component"
 S DIR("?",7)="  procedures which do have charges.",DIR("?",8)=""
 ;
 S DIR("A")="Apply Procedure Updates for Charges" W !!
 S DIR(0)="Y",DIR("B")="YES" D ^DIR K DIR,X I Y=1 D PROC(+IBIFN,1) W !
 Q
