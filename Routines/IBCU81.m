IBCU81 ;ALB/ARH - THIRD PARTY BILLING UTILITIES (AUTOMATED BILLER) ;02 JUL 93
 ;;2.0;INTEGRATED BILLING;**55,91,106,124,160,174,260,347**;21-MAR-94;Build 24
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EABD(IBETYP,IBTDT) ; -- compute earliest auto bill date: date entered plus days delay for event type
 ;the difference betwieen this and EABD^IBTUTL is that the autobill of the event type may be turned off
 ;and this procedure will still return a date
 ; -- input   IBETYPE = pointer to type of entry file
 ;            IBTDT   = episode date, if not passed in uses DT
 ;
 N X,X1,X2,Y,IBETYPD S Y="" I '$G(IBETYP) G EABDQ
 S IBETYPD=$G(^IBE(356.6,+IBETYP,0)) I '$G(IBTDT) S IBTDT=DT
 S X2=+$P(IBETYPD,"^",6) ;set earliest autobill date to entered date plus days delay
 S X1=IBTDT D C^%DTC S Y=X\1
EABDQ Q Y
 ;
EVBILL(IBTRN) ;check if event is auto billable, return EABD if it is, the difference between this and BILL^IBTUTL is that
 ;this procedure will return a date if the auto biller is turned off for this event type
 ;returns "^error message" if it is not billable
 N X,Y,Z,E,IBTRND S (X,Y,E)="" S IBTRND=$G(^IBT(356,+$G(IBTRN),0)) I IBTRND="" G BILLQ
 ;
 ; -- billed and bill not cancelled and not inpt interim first or continuous
 S Z=$$BILLED^IBCU8(IBTRN),Y=$P(Z,U,2) I +Z,'Y S E="^Event already billed on "_$P($G(^DGCR(399,+Z,0)),U,1)_"." G BILLQ
 ;
 ; -- special type (not riem. ins), not billable, inactive
 I +$P(IBTRND,U,12) S E="^Bill may not be Reimbursable Insurance, possibly "_$$EXSET^IBEFUNC(+$P(IBTRND,U,12),356,.12)_"." G BILLQ
 I +$P(IBTRND,U,19) S E="^Event has a Reason Not Billable: "_$P($G(^IBE(356.8,+$P(IBTRND,U,19),0)),U,1)_"." G BILLQ
 I '$P(IBTRND,U,20) S E="^Event is Inactive." G BILLQ
 I 'Y S Y=+$G(^IBT(356,+$G(IBTRN),1)) I 'Y S Y=DT
 S X=$$EABD(+$P(IBTRND,U,18),Y)
BILLQ Q X_E
 ;
RXRF(IBTRN) ; returns rx # and fill date for given claims tracking rx entry
 N IBX,IBY,IBZ,X S (X,IBY)=""
 S IBX=$G(^IBT(356,+$G(IBTRN),0)) I IBX'="" S IBY=$$FILE^IBRXUTL(+$P(IBX,U,8),.01)
 I IBY'="",$P(IBX,U,10)=0 S IBZ=$$FILE^IBRXUTL(+$P(IBX,U,8),"22","I") I +IBZ S X=IBY_"^"_IBZ
 I IBY'="",+$P(IBX,U,10) S IBZ=+$$ZEROSUB^IBRXUTL(+$P(IBX,U,2),+$P(IBX,U,8),+$P(IBX,U,10)) I +IBZ S X=IBY_"^"_IBZ
 Q X
 ;
NABSCT(IBTRN) ; -- true if CT outpatient visit should NOT be auto billed, based only on stop (1) and clinic (2) auto billable
 ; returns true only for those stops (352.3) and clinics (352.4) specifically flagged as not auto billable
 N IBX,IBY,IBTRND S IBX=0,IBTRND="" I +$G(IBTRN) S IBTRND=$G(^IBT(356,+IBTRN,0))
 I +$P(IBTRND,U,4) S IBY=$$SCE^IBSDU(+$P(IBTRND,U,4)) I +IBY D
 . I +$P(IBY,U,3),$$NABST^IBEFUNC($P(IBY,U,3),DT) S IBX=1 Q
 . I +$P(IBY,U,4),$$NABCT^IBEFUNC($P(IBY,U,4),DT) S IBX=2
 Q IBX
 ;
NBOE(IBOE,IBOE0) ; returns true if outpatient encounter is non-billable, "" otherwise
 ; input:  IBOE - pointer to encounter (409.68)
 ;         IBOE0 - 0-node of the encounter (optional)
 ; output: "" or x^message, where x=1 if SC, x=2 if NB Stop code, x=3 if NB Clinic, x=4 if NB Appt Status
 N IBOED,IBOEP,IBX,IBCK,IBZ,IBPB,IBAPST,IBDT,DFN
 S IBX=""
 I $G(IBOE0)="" S IBOE0=$$SCE^IBSDU(IBOE)
 I 'IBOE0 G NBOEQ
 S DFN=$P(IBOE0,"^",2),IBDT=+IBOE0
 F IBZ=7,12,13 S IBCK(IBZ)=""
 S IBZ=$$BILLCK^IBAMTEDU(IBOE,IBOE0,.IBCK,.IBPB)
 S IBAPST="" I $G(IBPB)=13 S IBAPST=$E($$EXPAND^IBTRE(409.68,.12,$P(IBOE0,U,12)),1,10)
 ; check out sc and other questions
 I $G(IBPB)="" S IBAPST=$$CL^IBTRKR41(IBOE0) I $L(IBAPST) S IBPB=$S(IBAPST="SC TREATMENT":11,1:13)
 S:$G(IBPB)'="" IBX=$S(IBPB=11:"1^SC VISIT",IBPB=7:"2^NB STOP CODE",IBPB=12:"3^NB CLINIC",IBPB=13:"4^"_IBAPST,1:"")
NBOEQ Q IBX
 ;
OEDX(IBOE,IBDXA,IBDXB) ; returns arrays containing encounters diagnosis (includes duplicates)
 ; IBDXA(ORDER,DATE/TIME,IBOE,DX IFN)=DX ^ PCE ORDER ^ IBOE ^ DATE/TIME ^  TRUE IF NON-BILLABLE ^ NB MES ^ CLINIC
 ; IBDXB(IBDX) = 1 for each billable dx found
 ;
 N IBNBOE,X,IBPOV,IBDXN,IBPCE,IBPCEI,IBDT,IBOE0,IBZERR
 Q:'$G(IBOE)
 S IBOE0=$$SCE^IBSDU(+IBOE),IBDT=+IBOE0 Q:'IBDT
 I '$$BDSRC^IBEFUNC3($P(IBOE0,U,5)) Q  ; non-billable visit data source
 S IBNBOE=$$NBOE(IBOE,IBOE0)
 ;
 D GETDX^SDOE(IBOE,"IBPOV","IBZERR")
 S IBDXN=0 F  S IBDXN=$O(IBPOV(IBDXN)) Q:'IBDXN  D
 . S IBPCE=IBPOV(IBDXN),IBPCEI=$P(IBPCE,U,12)
 . S IBDXA($S(IBPCEI="P":1,IBPCEI="S":2,1:999),IBDT,IBOE,IBDXN)=+IBPCE_U_IBPCEI_U_IBOE_U_IBDT_U_$P(IBNBOE,U,1)_U_$P(IBNBOE,U,2)_U_+$P(IBOE0,U,4)
 . I 'IBNBOE S IBDXB(+IBPCE)=1
 ;
 Q
 ;
