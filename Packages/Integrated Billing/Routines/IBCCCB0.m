IBCCCB0 ;ALB/ARH - COPY BILL FOR COB (OVERFLOW) ;06-19-97
 ;;2.0;INTEGRATED BILLING;**51,137,155**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
DSPRB(IBIFN) ; display related bills
 ;
 N IBCOB,IBI,IBLABEL,IBJ,IBK,IBINS,IBAR,IBDS Q:'$G(IBIFN)
 S IBDS="------------------------------------------------------------------"
 D BCOB^IBCU3(IBIFN,.IBCOB) I $O(IBCOB(0)) D
 . W !!!,?13,"Payer Responsible",?33,"Bill #",?41,"Status",?49,"Original",?59,"Collected",?72,"Balance",!,?13,IBDS
 . S IBI=0  F  S IBI=$O(IBCOB(IBI)) Q:'IBI  D
 .. S IBLABEL=$S(IBI=1:"Primary",IBI=2:"Secondary",IBI=3:"Tertiary",1:"Other")_":",IBLABEL=$J(IBLABEL,10)
 .. S IBJ=0 F  S IBJ=$O(IBCOB(IBI,IBJ)) Q:'IBJ  D
 ... S IBK="" F  S IBK=$O(IBCOB(IBI,IBJ,IBK)) Q:IBK=""  D
 .... S IBINS=$G(^DIC(36,+IBJ,0))
 .... W !," ",IBLABEL,?13,$E($P(IBINS,U),1,18) S IBLABEL="" Q:'IBK
 .... S IBAR=$$BILL^RCJIBFN2(IBK)
 .... W ?33,$P($G(^DGCR(399,+IBK,0)),U)
 .... W ?43,$P($$STNO^RCJIBFN2(+$P(IBAR,U,2)),U,2)
 .... W ?47,$J($P(IBAR,U),10,2)
 .... W ?58,$J($P(IBAR,U,4),10,2)
 .... W ?69,$J($P(IBAR,U,3),10,2)
 I +$$IB^IBRUTL(IBIFN,0) W !!,?8,"* There are patient bills on Hold for the date range of this bill."
 W !!
 Q
 ;
CTCOPY(IBIFN,IBMRA) ; based on the type of bill, copy it without cancelling
 ; IBMRA = 1 if an MRA bill and copy for prof components is desired
 ;
 N IB0,IBCTYPE I +$G(IBCBCOPY) Q
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)),IBCTYPE=+$P(IB0,U,27) Q:'IBCTYPE
 I $S('$G(IBMRA):$P(IB0,U,21)'=$E($$BINS^IBCU3(+$G(IBIFN))),1:0) Q  ; don't copy if not first in series, current payer=first payer and not an MRA
 I IBCTYPE=1 D CTCOPY1(IBIFN) Q
 I IBCTYPE=2 D CTCOPY2(IBIFN) Q
 Q
 ;
CTCOPY1(IBIFN) ;  Copy a Reasonable Charges inst bill to create a prof bill:
 ;   - Billing Rate must be Reasonable Charges
 ;   - Bill being copied must be an inst bill
 ;   - Prof bill must not already exist for the event date
 ;   - If the bill is outpt at least one CPT must have prof charges
 ;   - Procedure codes are copied only if the care is outpt
 ;
 N IB0,IBU,IBBTYPE,IBBCTO,IBBCTN,IBBCTOD,IBBCTND,IBNOCPT,IBCTCOPY,IBX,IBHV,IBNOTC
 ;
 S IBCTCOPY=1 ; flag - the copy function entered to auto copy Inst->Prof
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBU=$G(^("U")) Q:'IBU
 S IBBTYPE=$S($P(IB0,U,5)<3:"Inpatient",1:"Outpatient")
 ;
 S IBBCTO=$P(IB0,U,27),IBBCTN=0 I 'IBBCTO Q
 I IBBCTO=1 S IBBCTN=2 ; inst defined, create prof
 I 'IBBCTN Q
 ;
 I '$$BILLRATE^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),"RC") Q  ; copy only reasonable charges bills
 ;
 S IBBCTOD=$S(IBBCTO=1:"INSTITUTIONAL",2:"PROFESSIONAL"),IBBCTND=$S(IBBCTN=1:"INSTITUTIONAL",2:"PROFESSIONAL")
 ;
 I $P(IB0,U,5)>2,'$$CPTCHG^IBCRCU1(IBIFN,"PROF") W !!!,"There are no Reasonable Charges Outpatient Professional charges for this bill,",!,"second bill not created.",!! Q
 ;
 W !!!,"This ",IBBTYPE," ",IBBCTOD," bill may have corresponding ",IBBCTND," charges."
 ;
 I '$G(^DGCR(399,IBIFN,"U1")) W !!,"The current bill has no charges defined, no second bill created." Q
 ;
 S IBX=$$CTCHK^IBCU41(IBIFN) I +IBX W !!,"There is an existing ",IBBTYPE," ",IBBCTND," bill (",$P($G(^DGCR(399,+IBX,0)),U,1),") that appears",!,"to correspond to this ",IBBCTOD," bill, second bill not created.",!! Q
 ;
 W !,"Creating an ",IBBTYPE," ",IBBCTND," bill.",!!
 ;
 S IBCOB(0,27)=IBBCTN
 S IBIDS(.15)=IBIFN D KVAR^IBCCCB
 ;
 I $P(IB0,U,5)<3 S IBNOCPT=1 ; do not copy inpt facility procedures (ICD) to inpt prof bill
 S IBNOTC=1 ; don't copy TC modifier from inst to prof bill
 D STEP2^IBCCC ; copy/create second bill
 ;
 I $G(IBHV("IBIFN1"))!(IBCTCOPY=1) D FTPRV^IBCEU5(+$G(IBHV("IBIFN1")),1) ; Change att to rend prov if new prof bill added
 S IBV=0,IBAC=1
 ;
 ; DSS QuadraMed Interface: CPT Sequence and Diagnosis Linkage
 I +$G(IBHV("IBIFN1")),$$QMED^IBCU1("CTCOPY^VEJDIBE1",IBHV("IBIFN1")) D CTCOPY^VEJDIBE1(IBHV("IBIFN1"))
 Q
 ;
CTCOPY2(IBIFN) ; Copy a Reasonable Charges prof bill to create another prof bill if user wants another:
 ;   - Billing Rate must be Reasonable Charges
 ;   - Bill being copied must be a prof bill
 ;   - Procedures are not copied
 ;
 N IB0,IBU,IBBTYPE,IBBCTO,IBNOCPT,IBCTCOPY,IBX,DIR,DIRUT,DUOUT,DTOUT,X,Y
 ;
 S IBCTCOPY=2 ; flag indicating the copy function is entered to auto Copy prof->prof
 ;
 S IB0=$G(^DGCR(399,+$G(IBIFN),0)) Q:IB0=""  S IBU=$G(^("U")) Q:'IBU
 S IBBTYPE=$S($P(IB0,U,5)<3:"Inpatient",1:"Outpatient")
 S IBBCTO=$P(IB0,U,27) I IBBCTO'=2 Q  ; prof bills only
 ;
 I '$$BILLRATE^IBCRU3($P(IB0,U,7),$P(IB0,U,5),$P(IBU,U,1,2),"RC") Q  ; copy only reasonable charges bills
 ;
 I '$G(^DGCR(399,IBIFN,"U1")) Q  ; if the current bill has no charges do not allow creation of another one
 ;
 ; ask if they want a second prof bill
 S DIR("?",1)="If answered Yes, the current bill will be copied, without being cancelled,"
 S DIR("?",2)="to create another Professional bill for the same dates of care.",DIR("?",3)=" "
 S DIR("?")="Enter Yes if multiple professional bills are needed for the care provided on this date."
 S DIR("A")="Copy this bill to create another Professional bill for this date now"
 W !! S DIR(0)="Y",DIR("B")="No" D ^DIR I $D(DIRUT)!('Y) Q
 ;
 W !,"Creating an ",IBBTYPE," Professional bill.",!!
 ;
 S IBIDS(.15)=IBIFN D KVAR^IBCCCB
 ;
 S IBNOCPT=1
 D STEP2^IBCCC ; copy/create second prof bill
 S IBV=0,IBAC=1
 Q
 ;
 ;
FINALEOB(IBIFN) ; Returns 1 if user indicates final EOB has been received
 ; from prior payer
 N DIR,X,Y,IBOK
 S IBOK=0
 I '$$MCRONBIL^IBEFUNC(IBIFN) D  G FEOBQ
 . S DIR(0)="YA",DIR("B")="NO",DIR("A")="Has the final EOB been received for this claim?: "
 . S DIR("?",1)="COB should not normally be performed until the claim is fully processed by the",DIR("?",2)="prior payer.  Enter Y (yes) if the prior payer's final EOB has",DIR("?")="been received"
 . D ^DIR K DIR
 . I Y'=0 S IBOK=$S(Y>0:1,1:0)
 I $$SPLTMRA^IBCEMU1(IBIFN)=1 D  G FEOBQ
 . W !!," Only one MRA has been received for this claim.  The MRA on file indicates"
 . W !," that it is a 'split MRA' meaning that additional MRA's are needed."
 . W !," Processing cannot continue until all MRA's have been received for this claim."
 . W ! S DIR(0)="E" D ^DIR K DIR
 . Q
 ;
 I $$SPLTMRA^IBCEMU1(IBIFN)>1 D
 . W !!," At least 2 MRA's have been received for this claim."
 . W !,"Please verify that all possible MRA's have been received for",!,"this claim before processing.",!
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Are you sure you want to continue to process this COB?: "
 D ^DIR K DIR
 W !
 S IBOK=$S(Y'=1:0,1:1)
FEOBQ Q IBOK
 ;
 ;
COBOK(IBIFN) ; Returns 1 if user indicates the COB process should proceed
 ; even though the prior payer's bill is still in ENTERED/NOT REVIEWED
 ; or REQUEST MRA status (1,2)
 N DIR,X,Y,IBOK,IBSTAT
 S IBOK=0,IBSTAT=$P($G(^DGCR(399,IBIFN,0)),U,13)
 I "^1^2"'[(U_IBSTAT_U) S IBOK=1 G COBOKQ
 S DIR(0)="YA",DIR("B")="NO"
 S DIR("A",1)="The bill for the prior ("_$P("primary^secondary",U,+$$COBN^IBCEF(IBIFN))_") payer is still in "_$$EXTERNAL^DILFD(399,.13,,IBSTAT)_" status"
 S DIR("A")="Are you sure you want to continue to process this COB?: "
 D ^DIR K DIR
 W !
 S IBOK=$S(Y'=1:0,1:1)
COBOKQ Q IBOK
 ;
