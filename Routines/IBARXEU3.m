IBARXEU3 ;ALB/AAS - RX COPAY EXEMPTION PROCESS AR CANCELS ; 8-JAN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**16,34**; 21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
CANCEL ; Cancel Rx copay charges when veteran becomes exempt.
 ;  Required variable input:
 ;        DFN  --  Pointer to the patient in file #2
 ;     IBSTAT  --  patient is non-exempt (0) or exempt (1)
 ;     IBEVTA  --  Zeroth node in #354.1 of CURRENT exemption
 ;     IBEVTP  --  Zeroth node in #354.1 of PRIOR exemption
 ;
 N IBDT,IBEDT,IBCODA,IBCODP,IBSITE,IBAFY,IBATYP,IBCHRG,IBXX
 N IBCRES,IBERR,IBFAC,IBIL,IBL,IBLAST,IBLDT,IBN,IBND,IBNN,IBNOW,IBFOUND
 N IBPARNT,IBPARNT1,IBSEQNO,IBUNIT,IBVLAST,IBCODVL,IBANVD,IBFIL
 ;
 ; - veteran must be currently exempt,
 I 'IBSTAT G CANCELQ
 ;
 ; - due to income < pension,
 S IBCODP=$$ACODE^IBARXEU0(IBEVTP),IBCODA=$$ACODE^IBARXEU0(IBEVTA)
 G:IBCODA'=120 CANCELQ
 ;
 ; - when s/he was previously non-exempt, due to no income data,
 I $S(IBCODP="":0,IBCODP=210:0,1:1) G CANCELQ
 ;
 ; - after having been exempt due to income < pension.
 S IBVLAST=$$LST^IBARXEU0(DFN,+IBEVTP-.01),IBCODVL=$$ACODE^IBARXEU0(IBVLAST)
 G:IBCODVL'=120 CANCELQ
 ;
 ; - calculate 'anniversary date' from original exemption
 S IBANVD=$$PLUS^IBARXEU0(+IBVLAST)
 ;
 ; - 'filing' date of new exemption must be within 90 days of this date
 S IBFIL=$P($G(^DGMT(408.31,+$$LST^DGMTCOU1(DFN,+IBEVTA,3),0)),"^",7)
 I $$FMDIFF^XLFDT(IBFIL,IBANVD)>90 G CANCELQ
 ;
 ; - set start date for cancelling at beginning of non-exempt period.
 ; - end date: today (if the new exemption is the most current), or
 ;             the end of the exemption just started (day before
 ;                 the most current exemption)
 S IBBDT=+IBEVTA I IBEVTP,+IBEVTP<+IBEVTA S IBBDT=+IBEVTP
 S:IBBDT<$$STDATE^IBARXEU IBBDT=$$STDATE^IBARXEU
 S IBXX=$$LST^IBARXEU0(DFN)
 S IBEDT=$S(+IBXX=+IBEVTA:DT,1:$$FMADD^XLFDT(+IBXX,-1))
 ;
 ; - move the start date up past the last cancellation end date
 S X=-$O(^IBA(354.1,"ACAN",DFN,""))
 I X'<IBBDT S IBBDT=X
 ;
 ; - quit if the start date slipped ahead of the end date
 I IBEDT<IBBDT G CANCELQ
 ;
 ; - quit if there are no charges to cancel
 S X=$O(^IB("APTDT",DFN,(IBBDT-.01))) I 'X!(X>(IBEDT+.9)) G CANCELQ
 ;
 ; - cancel the charges in billing
 S Y=1 D ARPARM^IBAUTL I Y<0 G CANCELQ
 ;
 S IBDATE=IBBDT-.0001,IBFOUND=0
 F  S IBDATE=$O(^IB("APTDT",DFN,IBDATE)) Q:'IBDATE!((IBEDT+.9)<IBDATE)  D
 .S IBNN=0 F  S IBNN=$O(^IB("APTDT",DFN,IBDATE,IBNN)) Q:'IBNN  D BILL
 ;
 ; - cancel bills in AR, if at least one charge was cancelled
 I IBFOUND S IBARCAN=1 D ARCAN^IBARXEU4(DFN,IBSTAT,IBBDT,IBEDT)
 ;
CANCELQ Q
 ;
BILL ; -- process cancelling one bill
 S X=$G(^IB(IBNN,0)) Q:X=""
 Q:+$P(X,"^",4)'=52  ;quit if not pharmacy co-pay
 ;
 ; -- find parent
 S IBPARNT=$P(X,"^",9)
 ;
 S IBPARDT=$P($G(^IB(IBPARNT,1)),"^",2) ; get date of parent charge
 I $S(IBPARDT="":1,IBPARDT<IBBDT:1,IBPARDT>(IBEDT+.9):1,1:0) Q  ; ignore charges started before or after date range
 ;
 ; -- get most recent ibaction
 S IBPARNT1=IBPARNT F  S IBPARNT1=$P($G(^IB(IBPARNT,0)),"^",9) Q:IBPARNT1=IBPARNT  S IBPARNT=IBPARNT1 ;gets parent of parents
 S IBLAST=$$LAST^IBECEAU(IBPARNT)
 ;
 Q:$P(^IBE(350.1,$P(^IB(IBLAST,0),"^",3),0),"^",5)=2  ;quit if already cancelled
 ;
 S IBCRES=$O(^IBE(350.3,"B","RX COPAY INCOME EXEMPTION",0)) ; get cancellation reason
 ;
 D CANRX
 Q
 ;
CANRX ; -- do actual cancellation without calling ar
 ;    input :  iblast := last entry for parnt
 ;             ibparnt := parent charge
 ;             ibnd    := ^(0) node of iblast
 ;
 I $D(^IB(IBLAST,0)),$P(^IBE(350.1,$P(^IB(IBLAST,0),"^",3),0),"^",5)=2 G CANRXQ ;already cancelled
 S IBND=$G(^IB(+IBLAST,0)),IBDUZ=DUZ
 ;
 S IBATYP=$P(^IBE(350.1,+$P($G(^IB(IBPARNT,0)),"^",3),0),"^",6) ;cancellation action type for parent
 I '$D(^IBE(350.1,+IBATYP,0)) G CANRXQ
 S IBSEQNO=$P(^IBE(350.1,+IBATYP,0),"^",5) I 'IBSEQNO G CANRXQ
 S IBIL=$P($G(^IB(IBPARNT,0)),"^",11)
 S IBUNIT=$S($P(IBND,"^",6):$P(IBND,"^",6),$D(^IB(IBPARNT,0)):$P(^(0),"^",6),1:0) I IBUNIT<1 G CANRXQ
 S IBCHRG=$S($P(IBND,"^",7):$P(IBND,"^",7),$D(^IB(IBPARNT,0)):$P(^(0),"^",7),1:0) I IBCHRG<1 G CANRXQ
 ;
 D ADD^IBAUTL I +Y<1 G CANRXQ
 S $P(^IB(IBN,1),"^",1)=IBDUZ,$P(^IB(IBN,0),"^",2,13)=DFN_"^"_IBATYP_"^"_$P(IBND,"^",4)_"^11^"_IBUNIT_"^"_IBCHRG_"^"_$P(IBND,"^",8)_"^"_IBPARNT_"^"_IBCRES_"^"_IBIL_"^^"_IBFAC
 K ^IB("AC",1,IBN)
 S DA=IBN,DIK="^IB(" D IX^DIK
 S IBFOUND=1
 ;
 ; -- update parent to cancelled
 ;    note: parent status=10, cancellation due to exemption reason only
 ;          on charge cancelled so reports work right.
 S DIE="^IB(",DA=IBPARNT,DR=".05////10;.1////"_IBCRES D ^DIE K DIE,DA,DR
CANRXQ Q
