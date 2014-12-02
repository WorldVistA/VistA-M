IBTRR1 ;ALB/ARH - CLAIMS TRACKING - ROI SPECIAL CONSENT ACTIONS ; 08-JAN-2013
 ;;2.0;INTEGRATED BILLING;**458**;21-MAR-94;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
AA ; Protocol Action:  Add an ROI Special Consent
 I '$D(^XUSEC("IB ROI EDIT",DUZ)) W !!,"IB ROI EDIT Key Required to Add an ROI" H 2 S VALMBCK="R" Q
 D FULL^VALM1
 ;
 D ADD I +$G(IBRFN) D EDIT
 ;
 D BLD^IBTRR
 S VALMBCK="R"
 Q
 ;
EA ; Protocol Action:  Edit an ROI Special Consent
 I '$D(^XUSEC("IB ROI EDIT",DUZ)) W !!,"IB ROI EDIT Key Required to Edit an ROI" H 2 S VALMBCK="R" Q
 D FULL^VALM1
 ;
 N VALMY,I,J,IBXXR,IBRFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXR=0 F  S IBXXR=$O(VALMY(IBXXR)) Q:'IBXXR  D
 . S IBRFN=$P($G(^TMP("IBTRRX",$J,+$O(^TMP("IBTRR",$J,"IDX",IBXXR,0)))),U,2)
 . D ROIDSP(IBRFN)
 . D EDIT
 ;
 D BLD^IBTRR
 S VALMBCK="R"
 Q
 ;
RA ; Protocol Action:  Revoke an ROI Special Consent
 I '$D(^XUSEC("IB ROI EDIT",DUZ)) W !!,"IB ROI EDIT Key Required to Revoke an ROI" H 2 S VALMBCK="R" Q
 D FULL^VALM1
 ;
 N VALMY,I,J,IBXXR,IBRFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXR=0 F  S IBXXR=$O(VALMY(IBXXR)) Q:'IBXXR  D
 . S IBRFN=$P($G(^TMP("IBTRRX",$J,+$O(^TMP("IBTRR",$J,"IDX",IBXXR,0)))),U,2)
 . D ROIDSP(IBRFN)
 . D REVOKE
 ;
 D BLD^IBTRR
 S VALMBCK="R"
 Q
 ;
DA ; Protocol Action:  Delete an ROI Special Consent
 I '$D(^XUSEC("IB ROI EDIT",DUZ)) W !!,"IB ROI EDIT Key Required to Delete an ROI" H 2 S VALMBCK="R" Q
 D FULL^VALM1
 ;
 N VALMY,I,J,IBXXR,IBRFN
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXXR=0 F  S IBXXR=$O(VALMY(IBXXR)) Q:'IBXXR  D
 . S IBRFN=$P($G(^TMP("IBTRRX",$J,+$O(^TMP("IBTRR",$J,"IDX",IBXXR,0)))),U,2)
 . D ROIDSP(IBRFN)
 . D DELETE
 ;
 D BLD^IBTRR
 S VALMBCK="R"
 Q
 ;
OP ; Protocol Action:  Open ROI Screen - called from CT Editor IBTRE ROI CONSENT
 D EN^IBTRR D HDR^IBTRE,BLD^IBTRE S VALMBCK="R"
 Q
 ;
 ;
ADD ; add a new ROI Special Consent entry, IBRFN set on exit (record incomplete)
 N DD,DO,DA,DR,D0,DIR,DIC,DIE,DLAYGO,X,Y,VALMQUIT S IBRFN=0 W !
 ;
 I '$G(DFN) D PAT^IBCNSM W !! I '$D(DFN) Q
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Add a New ROI Special Consent" D ^DIR I Y'=1 Q
 ;
 W !!,"A New ROI Special Consent has been added for: ",$P($G(^DPT(+DFN,0)),U,1),!
 ;
 S X=$P(^IBT(356.26,0),U,3)+1
 S DIC="^IBT(356.26,",DIC(0)="L",DLAYGO=356.26
 S DIC("DR")=".02////"_DFN_";1.01///NOW;1.02////"_DUZ_";1.03///NOW;1.04////"_DUZ
 D FILE^DICN K DIC,DIE,DLAYGO I Y>0 S IBRFN=+Y
 ;
 Q
 ;
EDIT ; edit an ROI Special Consent entry, IBRFN must be set on entry
 N DIC,DIE,DR,DA,D0,IBROIBG,IBDIFF,X,Y
 ;
 I '$D(^IBT(356.26,+$G(IBRFN),0)) Q
 D SAVE
 ;
 S DIE="^IBT(356.26,",DA=+IBRFN,DIE("NO^")="BACK"
 S DR=".03;@1;.04;S IBROIBG=X;.05;I X<IBROIBG W !!,""Expiraton date must not be before the Effective Date!"",! S Y=""@1"";2.01"
 D ^DIE
 ;
 D COMP I IBDIFF D UPDATE
 K ^TMP($J,"IBTRRS",356.26)
 Q
 ;
REVOKE ; revoke an ROI entry, IBRFN must be defined
 N DIC,DIE,DR,DA,D0,IBDIFF,X,Y
 ;
 I '$D(^IBT(356.26,+$G(IBRFN),0)) Q
 D SAVE
 ;
 S DIE="^IBT(356.26,",DA=+IBRFN,DIE("NO^")="BACK"
 S DR=".06;I X'=1 S Y=""@1"";W !!,""Update the Expiration Date with the Date the revocation becomes effective."",!;.05;@1"
 D ^DIE
 ;
 D COMP I IBDIFF D UPDATE
 K ^TMP($J,"IBTRRS",356.26)
 Q
 ;
DELETE ; delete and ROI entry, IBRFN must be defined
 N DIR,DIK,DA,DIRUT,X,Y
 ;
 I '$D(^IBT(356.26,+$G(IBRFN),0)) Q
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Delete this ROI Special Consent" D ^DIR I Y'=1 W "  Not Deleted!" Q
 ;
 I Y=1 S DA=IBRFN,DIK="^IBT(356.26," D ^DIK W "  Entry Deleted!"
 ;
 Q
 ;
 ;
SAVE ; save entry before editing
 K ^TMP($J,"IBTRRS",356.26)
 S ^TMP($J,"IBTRRS",356.26,IBRFN,0)=$G(^IBT(356.26,+IBRFN,0))
 S ^TMP($J,"IBTRRS",356.26,IBRFN,1)=$G(^IBT(356.26,+IBRFN,1))
 S ^TMP($J,"IBTRRS",356.26,IBRFN,2)=$G(^IBT(356.26,+IBRFN,2))
 Q
 ;
COMP ; compare before editing global with current global entry
 S IBDIFF=0
 I $G(^IBT(356.26,+IBRFN,0))'=$G(^TMP($J,"IBTRRS",356.26,IBRFN,0)) S IBDIFF=1
 I $G(^IBT(356.26,+IBRFN,1))'=$G(^TMP($J,"IBTRRS",356.26,IBRFN,1)) S IBDIFF=1
 I $G(^IBT(356.26,+IBRFN,2))'=$G(^TMP($J,"IBTRRS",356.26,IBRFN,2)) S IBDIFF=1
 Q
 ;
UPDATE ; update last edited fields for entry
 N DIC,DIE,DR,DA,D0,X,Y
 S DIE="^IBT(356.26,",DA=+IBRFN,DR="1.03///NOW;1.04////"_DUZ D ^DIE
 Q
 ;
 ;
ROIDSP(IBRFN) ; display an ROI entry
 N IBR0,IBR1,IBR2,IBDS S IBDS="",$P(IBDS,"-",IOM+1)=""
 S IBR0=$G(^IBT(356.26,+$G(IBRFN),0)) Q:IBR0=""
 S IBR1=$G(^IBT(356.26,IBRFN,1)),IBR2=$G(^IBT(356.26,IBRFN,2))
 ;
 W !!,IBDS,!,"ROI Special Consent for ",$P($G(^DPT(+$P(IBR0,U,2),0)),U,1),":"
 W !!,$$EXPAND^IBTRE(356.26,.03,$P(IBR0,U,3)),?37,$$DATE^IBTRR($P(IBR0,U,4))," - ",$$DATE^IBTRR($P(IBR0,U,5))
 W ?60,$S(+$$ACTIVE^IBTRR(IBRFN,DT):"ACTIVE",1:"INACTIVE"),?70,$S(+$P(IBR0,U,6):"REVOKED",1:"")
 W !!,"Comment: ",IBR2
 W !!,"Entered by:   ",$E($$EXPAND^IBTRE(356.26,1.02,$P(IBR1,U,2)),1,21),?37,"Last Edited By:   ",$E($$EXPAND^IBTRE(356.26,1.04,$P(IBR1,U,4)),1,21)
 W !,"Date Entered: ",$$FMTE^XLFDT($P(IBR1,U,1)),?37,"Date Last Edited: ",$$FMTE^XLFDT($P(IBR1,U,3)),!,IBDS,!
 Q
 ;
 ;
ROIPAT(DFN,DATE) ; return Indicators of Conditions Active for Patient on Date (LM Patient List header)
 ; outputs alpha characters of sensitive conditions with active ROI
 N IBX,IBY,IBZ,IBRFN,IBR0 S (IBX,IBY,IBZ)="" S DFN=+$G(DFN) S DATE=$G(DATE)\1 I DATE'?7N S DATE=DT
 ;
 S IBRFN=0 F  S IBRFN=$O(^IBT(356.26,"C",DFN,IBRFN)) Q:'IBRFN  D
 . S IBR0=$G(^IBT(356.26,IBRFN,0))
 . I IBR0'="",DATE'<$P(IBR0,U,4),DATE'>$P(IBR0,U,5) S IBY(+$P(IBR0,U,3))=""
 S IBZ="" F IBY=1:1:4 I $D(IBY(IBY)) S IBZ=IBZ_IBY
 S IBX=$TR(IBZ,"1234","DAHS")
 Q IBX
 ;
ROIEVT(IBTRN,SHRT) ; return ROI Consent and Indicators for a specific CT Event and Date (LM Event Detail)
 ; outputs CT entries ROI Consent and alpha characters of sensitive conditions with active ROI
 ; 
 N IBX,IBY,IBTRN0,IBRSC S IBX="" S IBTRN0=$G(^IBT(356,+$G(IBTRN),0)),IBRSC=$P(IBTRN0,U,31)
 I +IBRSC S IBX=$$EXPAND^IBTRE(356,.31,IBRSC)_" "
 I +IBRSC=2 S IBY=$$ROIPAT(+$P(IBTRN0,U,2),+$P(IBTRN0,U,6)) I IBY'="" S:$G(SHRT) IBX=$E(IBX,1,6) S IBX=IBX_"("_IBY_")"
 Q IBX
