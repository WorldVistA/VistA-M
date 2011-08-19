IBTUTL4 ;ALB/AAS - CLAIMS TRACKING UTILITY ROUTINE ; 21-JUN-93
 ;;2.0;INTEGRATED BILLING;**60,91**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
AEA(IBTRC,X) ; -- dd input call for authorize entire admission (field 1.08)
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 I X,$P($G(^IBT(356.2,+IBTRC,1)),"^",7) D NOTOK("Deny Entire Admission already answered 'YES'.") G AEAQ
 D ARRAY^IBTUTL3(IBTRC)
 I $G(ARRAY(0)) D NOTOK("Entired Admission already denied on "_$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY(0),0))))
 I $G(ARRAY),ARRAY'=IBTRC D NOTOK("Entire Admission has already be authorized on "_$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY,0))))
AEAQ Q IBOK
 ;
DEA(IBTRC,X) ; -- dd input call for deny entry admission (field 1.07)
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 I X,$P($G(^IBT(356.2,+IBTRC,1)),"^",8) D NOTOK("Authorize Entire Admission already answered 'YES'.") G DEAQ
 D ARRAY^IBTUTL3(IBTRC)
 I $G(ARRAY(0)),+ARRAY(0)'=IBTRC D NOTOK("Entired Admission already denied on "_$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY(0),0))))
 I $G(ARRAY) D NOTOK("Entire Admission has already be authorized on "_$$FMTE^XLFDT(+$G(^IBT(356.2,+ARRAY,0))))
DEAQ Q IBOK
 ;
AFDT(IBTRC,X) ; -- dd input call for check to approved from date (field .12)
 ; -- returns 1 if date okay, 0 if not, let input transform kill x
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 ;
 D CHK I 'IBOK G AFDTQ
 ;
 I $P(^IBT(356.2,+IBTRC,0),U,13),X>$P(^(0),"^",13) D NOTOK("Care Authorized From Date must be before the Care Authorized To Date ("_$$FMTE^XLFDT($P(^IBT(356.2,+IBTRC,0),"^",13))_")!") G AFDTQ
 ;
 D CHK2 I '$D(ARRAY) G AFDTQ
 S M=0 F  S M=$O(ARRAY(M)) Q:'M  S N=0 F  S N=$O(ARRAY(M,N)) Q:'N  I IBTRC'=+ARRAY(M,N),X'<M,X'>N D NOTOK("Date entered is already covered by another entry.")
AFDTQ Q IBOK
 ;
ATDT(IBTRC,X) ; -- dd input call for check to approved to date (field .13)
 ; -- returns 1 if date okay, 0 if not, let input transform kill x
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 D CHK G:'IBOK ATDTQ
 ;
 I $P(^IBT(356.2,+IBTRC,0),U,12),X<$P(^(0),"^",12) D NOTOK("Care Authorized To Date must not be before the Care Authorized From Date ("_$$FMTE^XLFDT($P(^IBT(356.2,+IBTRC,0),"^",13))_")!") G ATDTQ
 ;
 D CHK2 I '$D(ARRAY) G ATDTQ
 S M=0 F  S M=$O(ARRAY(M)) Q:'M  S N=0 F  S N=$O(ARRAY(M,N)) Q:'N  I IBTRC'=+ARRAY(M,N),X'<M,X'>N D NOTOK("Date entered is already covered by another entry.")
ATDTQ Q IBOK
 ;
DFDT(IBTRC,X) ; -- dd input call for check to denied from date (field .15)
 ; -- returns 1 if date okay, 0 if not, let input transform kill x
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 D CHK G:'IBOK DFDTQ
 ;
 I $P(^IBT(356.2,+IBTRC,0),U,16),X>$P(^(0),"^",16) D NOTOK("Care Denied From Date must be before the Care Denied To Date ("_$$FMTE^XLFDT($P(^IBT(356.2,+IBTRC,0),"^",13))_")!") G DFDTQ
 ;
 D CHK2 I '$D(ARRAY) G DFDTQ
 S M=0 F  S M=$O(ARRAY(M)) Q:'M  S N=0 F  S N=$O(ARRAY(M,N)) Q:'N  I IBTRC'=+ARRAY(M,N),X'<M,X'>N D NOTOK("Date entered is already covered by another entry.")
DFDTQ Q IBOK
 ;
DTDT(IBTRC,X) ; -- dd input call for check to denied  to date (field .16)
 ; -- returns 1 if date okay, 0 if not, let input transform kill x
 N ARRAY,IBOK,IBTRN,IBTRND,Y,I,J,M,N S IBOK=1
 D CHK G:'IBOK DTDTQ
 ;
 I $P(^IBT(356.2,+IBTRC,0),U,15),X<$P(^(0),"^",15) D NOTOK("Date must not be before the Care Denied From Date ("_$$FMTE^XLFDT($P(^IBT(356.2,+IBTRC,0),"^",13))_")!") G DTDTQ
 ;
 D CHK2 I '$D(ARRAY) G DTDTQ
 S M=0 F  S M=$O(ARRAY(M)) Q:'M  S N=0 F  S N=$O(ARRAY(M,N)) Q:'N  I IBTRC'=+ARRAY(M,N),X'<M,X'>N D NOTOK("Date entered is already covered by another entry.")
DTDTQ Q IBOK
 ;
CHK ; -- generic check functions
 I '$G(X)!('$G(IBTRC))!($G(^IBT(356.2,+$G(IBTRC),0))="") S IBOK=0 Q
 S IBTRND=$G(^IBT(356,+$P($G(^IBT(356.2,+IBTRC,0)),"^",2),0))
 ;
 I X<($P(IBTRND,"^",6)\1) D NOTOK("Date can't be before admission or visit date ("_$$FMTE^XLFDT($P(IBTRND,"^",6))_")!") Q
 ;
 S Y=$$DISCH(+$P(IBTRND,"^",5)) I Y,X>Y D NOTOK("Date can not be after Discharge Date ("_$$FMTE^XLFDT(Y)_")!") Q
 Q
 ;
CHK2 ; -- if pass first set of check do these
 D ARRAY^IBTUTL3(IBTRC)
 I $G(ARRAY) D NOTOK("Whole Admission has already been Authorized, can not add partial dates!")
 I $G(ARRAY(0)) D NOTOK("Whole Admission has already been Denied, can not add partial dates!")
 Q
 ;
NOTOK(MESS) ; -- process not okays
 S IBOK=0
 I '$D(ZTQUEUED),$G(MESS)'="" W !,MESS,!
 Q
 ;
DISCH(DGPM) ; -- find discharge date for an admission
 ;
 N X S X=""
 I '$G(^DGPM(+$G(DGPM),0)) G DISCHQ
 S X=+$G(^DGPM(+$P($G(^DGPM(DGPM,0)),"^",17),0))
DISCHQ Q X
 ;
 ;
ASK(IBTRN,IBW) ; Prompt for Provider or Diagnosis from PCE
 ;  Input:  IBTRN  --  Pointer to Claims Tracking entry in #356
 ;            IBW  --  1 - Provider  |  2 - Diagnosis
 ;
 N DFN,IBVSIT,IBTRND,IBPKG,IBOEDATA,IBRESULT,IBCLIN,IBERROR
 S IBERROR=""
 I '$G(IBTRN) S IBERROR="No Claims Tracking entry has been provided!" G ASKQ
 I "^1^2^"'[("^"_$G(IBW)_"^") S IBERROR="The prompt type was not specified!" G ASKQ
 ;
 S IBPKG=$O(^DIC(9.4,"C","IB",0))
 I 'IBPKG S IBERROR="Cannot determine the Package file entry for IB!" G ASKQ
 ;
 S IBTRND=$G(^IBT(356,IBTRN,0)),IBOEDATA=$$SCE^IBSDU(+$P(IBTRND,"^",4))
 S IBVSIT=$P(IBTRND,"^",3),IBCLIN=$P(IBOEDATA,"^",4),DFN=$P(IBTRND,"^",2)
 I 'IBVSIT S IBVSIT=$P(IBOEDATA,"^",5)
 I 'IBVSIT S IBERROR="Cannot determine the Visit file entry!" G ASKQ
 I 'IBCLIN S IBERROR="Cannot determine the Clinic location of the visit!" G ASKQ
 ;
 S IBRESULT=$$INTV^PXAPI($S(IBW=1:"PRV",1:"POV"),IBPKG,"IB DATA",IBVSIT,IBCLIN,DFN)
 ;
ASKQ I IBERROR]"" W !!,IBERROR,! S DIR(0)="E" D ^DIR K DIR
 Q
