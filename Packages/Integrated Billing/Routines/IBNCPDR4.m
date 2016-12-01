IBNCPDR4 ;ALB/BDB - ROI MANAGEMENT, ROI CHECK ;30-NOV-07
 ;;2.0;INTEGRATED BILLING;**384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
ROICHK(IBPAT,IBDRUG,IBINS,IBDT) ;Check for ROI
 ; Function returns 1 if ROI on file or new ROI added, 0 if no ROI on file
 ; it returns a 2 if not needed, passes checks
 ;
 ; -- input IBPAT  = patient (req)
 ;          IBDRUG = drug  (req)
 ;          IBINS  = insurance file 36 (req)
 ;          IBDT   = fileman format fill date (req)
 N DIC,DIE,DA,DR,DQ,D0,DI,D,X,Y
 I $$ROI(IBPAT,IBDRUG,IBINS,IBDT) Q 1 ;ROI is on file
 K ^TMP($J,"IBDRUG")
 D DATA^PSS50(IBDRUG,,,,,"IBDRUG")
 I '$$SENS^IBNCPDR(IBDRUG) Q 2  ; drug not sensitive, ROI not needed
 D EN^DDIOL("This drug requires a Release of Information(ROI) for:","","!!")
 D EN^DDIOL(" PATIENT: ","","!") D EN^DDIOL($E($P($G(^DPT(IBPAT,0)),U),1,20),"","?0")
 D EN^DDIOL(" DRUG: ","","!") D EN^DDIOL($E($G(^TMP($J,"IBDRUG",IBDRUG,.01)),1,30),"","?0")
 D EN^DDIOL(" INSURANCE COMPANY: ","","!") D EN^DDIOL($P($G(^DIC(36,+IBINS,0)),U),"","?0")
 D EN^DDIOL(" FILL DATE: ","","!") D EN^DDIOL($$DAT1^IBOUTL(IBDT),"","?0")
 I '$$KCHK^XUSRB("IBCNR ROI") Q 0
 K ^TMP($J,"IBDRUG")
 S DIR(0)="Y",DIR("A")="Do you want to add a new ROI for this patient? "
 S DIR("B")="NO"
 S DIR("?")="If you want to add a new ROI, enter 'Yes' - otherwise, enter 'No'"
 D EN^DDIOL("","","!") D ^DIR K DIR
 I 'Y D EN^DDIOL(" *** Rx requires an ROI. Please add the required ROI.","","!") Q 0 ;Stop processing
 I '$$AD(IBPAT,IBDRUG,IBINS,IBDT) D EN^DDIOL(" *** Rx requires an ROI.","","!") D EN^DDIOL(" Please add an ROI before submitting the claim.","","!") Q 0 ;Stop processing
 Q 1 ;Continue processing
 ;
ROICLN(IBTRN,IBRX,IBFIL) ;Clean NB reason, set CT ROI flag to 'obtained'
 ; Clean ROI non-billable reason on Claims Tracking 356
 ;
 ; -- input IBTRN  = IEN of Claims Tracking #356
 ;          IBRX   = Rx IEN
 ;          IBFIL  = RX fill number
 N DIE,DA,DR
 I '$G(IBTRN) S IBTRN=+$O(^IBT(356,"ARXFL",$G(IBRX),$G(IBFIL),0))
 I IBTRN D
 . S DR=".31////2" ; set CT ROI flag to 'obtained'
 . ;
 . ; If the current RNB contains "ROI", then clear it out - IB*2*550
 . I $P($G(^IBE(356.8,+$P($G(^IBT(356,IBTRN,0)),U,19),0)),U,1)["ROI" S DR=DR_";.19///@"
 . S DIE="^IBT(356,",DA=IBTRN D ^DIE ;clean NB reason
 Q
 ;
 ;Check for Release of Information (ROI) on file
ROI(IBDFN,IBDRUG,IBINS,IBADT) ; -- Check for ROI on file
 ; Function returns 1 if ROI on file, 0 if no ROI on file
 ;
 ; -- input IBDFN  = patient (req)
 ;          IBDRUG = drug  (req)
 ;          IBINS  = insurance file 36 (req)
 ;          IBADT  = fileman format fill date (req)
 ;
 N IBROI,IBFLG
 S IBFLG=0 ;No ROI on file
 S IBROI=0 F  S IBROI=$O(^IBT(356.25,"AC",IBDFN,IBDRUG,IBINS,IBROI)) G:'IBROI ROIQ D  G:IBFLG ROIQ ;Check for ROI on file
  . I IBADT<$P(^IBT(356.25,IBROI,0),U,5)!(IBADT>$P(^IBT(356.25,IBROI,0),U,6)) Q  ;Date out of range
  . I $P(^IBT(356.25,IBROI,0),U,7)="0" Q  ;Inactive ROI
  . S IBFLG=1 ;ROI on file
  . S DIE="^IBT(356.25,",DA=IBROI,DR="1.05///NOW" D ^DIE
ROIQ ;
 Q IBFLG
 ;
AD(IBDFN,IBDRUG,IBINS,IBDT) ; -- Add tracking entry
 ; Function returns 1 if ROI added, 0 if not added
 N X,Y,DIC,DIR,DA,DR,DTOUT,DUOUT,IBQUIT,IBEFFDT,IBEXPDT
 S IBQUIT=0
 F  S DIR("?")="The ROI effective date must be prior to or equal to the fill date.",DIR("A")="Enter the ROI effective date for the ROI: ",DIR(0)="DATE" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBQUIT
 . S X=Y,%DT="E" D ^%DT I Y<0 D EN^DDIOL("Must enter a valid date","","!") Q
 . I Y>IBDT D EN^DDIOL("The ROI effective date must be prior to or equal to the fill date.","","!") Q
 . S IBEFFDT=Y,IBQUIT=1 Q
 G:'IBQUIT ADDQ
 S IBQUIT=0
 F  S DIR("?")="The ROI expiration date must be equal to or after the fill date.",DIR("A")="Enter the ROI expiration date for the ROI: ",DIR(0)="DATE" D ^DIR K DIR Q:$D(DTOUT)!$D(DUOUT)  D  Q:IBQUIT
 . S X=Y,%DT="E" D ^%DT I Y<0 D EN^DDIOL("Must enter a valid date","","!") Q
 . I Y<IBDT D EN^DDIOL("The ROI expiration date must be equal to or after the fill date.","","!") Q
 . S IBEXPDT=Y,IBQUIT=1 Q
 G:'IBQUIT ADDQ
 L +^IBT(356.25,0):10 I '$T D PAUSE^IBNCPBB("ROI File busy while trying to add a new entry") S IBQUIT=0 G ADDQ
 S X=$P($S($D(^IBT(356.25,0)):^(0),1:"^^-1"),"^",3)+1 L -^IBT(356.25,0)
 S DIC="^IBT(356.25,",DIC(0)="L",DLAYGO=356.25,DIC("DR")=".02////"_IBDFN_";.03////"_IBDRUG_";.04////"_IBINS_";.05///"_IBEFFDT_";.06////"_IBEXPDT_";.07////1;1.01///NOW;1.02////"_DUZ_";1.03///NOW;1.04////"_DUZ_";1.05///NOW;2.01" D FILE^DICN
 I Y<1!($D(DUOUT))!($D(DTOUT)) S IBQUIT=0 G ADDQ
 N IBNCRPR I +Y>0 S IBNCRPR=+Y,ZTIO="",ZTRTN="CTCLN^IBNCPDR2",ZTDTH=$H,ZTSAVE("IBNCRPR")="",ZTDESC="IB - Make ROI Pharmacy entries in Claims Tracking billable"
 D ^%ZTLOAD K ZTSK,ZTIO,ZTSAVE,ZTDESC,ZTRTN
ADDQ Q IBQUIT
 ;
 ;Check for ROI on file
ROI399(IBIFN) ; -- ROI Complete? in Bill/Claims (#399;157)
 ; Check drugs that contain the sensitive diagnosis drug field=1,
 ; Claims Tracking ROI file (#356.25) to see if an ROI is on file
 ; 
 ; input - IBIFN = IEN of the Bill/Claims file (#399)
 ; output - 0 = sensitive diagnosis drug and no ROI on file
 ;          1 = default, sensitive diagnosis drug and ROI on file
 N IBX,IBY0,IBRXIEN,IBDT,IBDRUG,ROIQ,IBDFN,IBINS
 N DIC,DIE,DA,DR,DQ,D0,DI,DISYS,D,X,Y,DE,DW,DV,DL,DLB
 S IBDFN=$P(^DGCR(399,IBIFN,0),U,2) ;patient
 S IBINS=$P(^DGCR(399,IBIFN,"MP"),U,1) ;payer insurance company
 I 'IBINS S ROIQ=1 G ROI399Q
 S ROIQ=1
 S IBX=0 F  S IBX=$O(^IBA(362.4,"C",$G(IBIFN),$G(IBX))) Q:'IBX  D
 .S IBY0=^IBA(362.4,IBX,0),IBRXIEN=$P(IBY0,U,5) I 'IBRXIEN Q
 .S IBDT=$P(IBY0,U,3),IBDRUG=$P(IBY0,U,4)
 .K ^TMP($J,"IBDRUG") D ZERO^IBRXUTL(IBDRUG)
 .I $$SENS^IBNCPDR(IBDRUG) D
 .. I $$ROICHK^IBNCPDR4(IBDFN,IBDRUG,IBINS,IBDT) Q
 .. S ROIQ=0
ROI399Q ;
 Q ROIQ
