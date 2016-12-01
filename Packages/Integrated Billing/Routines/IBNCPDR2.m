IBNCPDR2 ;ALB/BDB - ROI MANAGEMENT, ADD ROI ;30-NOV-07
 ;;2.0;INTEGRATED BILLING;**384,550**;21-MAR-94;Build 25
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
AD ; -- Add tracking entry
 D FULL^VALM1
 N X,Y,DIC,DA,DR,DD,DO,DIR,DIRUT,DTOUT,DUOUT,IBETYP,IBQUIT,IBTDT,VAIN,VAINDT,IBTRN,IBTDTE,IBROIDR
 ;
 L +^IBT(356.25,0):10 I '$T D PAUSE^IBNCPBB("ROI File busy while trying to add a new entry") G ADDQ
 S X=$P($S($D(^IBT(356.25,0)):^(0),1:"^^-1"),"^",3)+1 L -^IBT(356.25,0)
 S DIC="^IBT(356.25,",DIC(0)="L",DLAYGO=356.25
 S DIC("DR")=".02////"_$G(DFN)_";.03;.04;@1;.05;S IBROIDR=X;.06;I (X-IBROIDR)<0 D EN^DDIOL(""   ** The ROI expiration date must be on or after the fill date. **"") S Y=""@1"";.07////1;1.01///NOW;1.02////"
 S DIC("DR")=DIC("DR")_DUZ_";1.03///NOW;1.04////"_DUZ_";1.05///NOW;2.01"
 D FILE^DICN
 N IBNCRPR S IBNCRPR=0 I +Y>0 S IBNCRPR=+Y,ZTIO="",ZTRTN="CTCLN^IBNCPDR2",ZTDTH=$H,ZTSAVE("IBNCRPR")="",ZTDESC="IB - Make ROI Pharmacy entries in Claims Tracking billable"
 I IBNCRPR D ^%ZTLOAD K ZTSK,ZTIO,ZTSAVE,ZTDESC,ZTRTN
 D BLD^IBNCPDR
ADDQ ;
 S VALMBCK="R"
 Q
 ;
CTCLN ; -- make ROI Pharmacy entries in Claims Tracking billable
 ; tasked job with IBNCRPR defined - IEN file(#356.25)
 ; search claims tracking for NBR of no ROI (or related to ROI)
 ; set ROI flag to "obtained"
 ; if RNB is related to ROI, clear the RNB
 N IBNCR0,DFN,IBNCRD,IBDT,IBTRN,IBEFDT,IBEXDT,IBX,IBZ,IBT,IBPL,IBINS
 N DIC,DIE,DR,DA,X,Y,IBRX
 S IBNCR0=$G(^IBT(356.25,IBNCRPR,0))
 S DFN=$P(IBNCR0,U,2),IBNCRD=$P(IBNCR0,U,3),IBEFDT=$P(IBNCR0,U,5),IBEXDT=$P(IBNCR0,U,6)
 I $P(IBNCR0,U,7)="0" G CTCLNQ ; inactive ROI
 I 'DFN!('IBNCRD)!('IBEFDT)!('IBEXDT) G CTCLNQ
 S IBDT=0 F  S IBDT=$O(^IBT(356,"APTY",DFN,4,IBDT)) Q:'IBDT  D:IBDT'<IBEFDT&(IBDT'>IBEXDT)
 . S IBTRN=0 F  S IBTRN=$O(^IBT(356,"APTY",DFN,4,IBDT,IBTRN)) Q:'IBTRN  D
 .. S IBRX=$P(^IBT(356,IBTRN,0),U,8)       ; prescription ien
 .. I IBNCRD'=$$FILE^IBRXUTL(IBRX,6) Q     ; make sure drug ien's match
 .. S DR=".31////2"                        ; set CT SPECIAL CONSENT ROI flag to 'obtained'
 .. ;
 .. ; if the current RNB on file for the CT entry contains "ROI" then clear it out  (IB*2*550)
 .. I $P($G(^IBE(356.8,+$P($G(^IBT(356,IBTRN,0)),U,19),0)),U,1)["ROI" S DR=DR_";.19///@"    ;clean NB reason
 .. S DIE="^IBT(356,",DA=IBTRN D ^DIE
 K IBNCRPR
 ;
CTCLNQ ;
 ;
