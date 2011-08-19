IBNCPDP3 ;OAK/ELZ - STORES NDC/AWP UPDATES ;11/14/07  13:18
 ;;2.0;INTEGRATED BILLING;**223,276,342,363,383,384,411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
UPAWP(IBNDC,IBAWP,IBADT) ; updates AWP prices for NDCs
 ;
 N IBITEM,IBCS
 ;
 ;
 S IBCS=$P($G(^IBE(350.9,1,9)),"^",12)
 I 'IBCS Q "0^Unable to find Charge Set"
 ;
 S IBNDC=$$NDC^IBNCPNB(IBNDC)
 ;
 S IBITEM=+$$ADDBI^IBCREF("NDC",IBNDC) I IBITEM Q "0^Unable to add item"
 ;
 I '$$ADDCI^IBCREF(IBCS,IBITEM,IBADT,IBAWP) Q "0^Unable to add charge"
 ;
 Q 1
 ;
 ;
 ;
 ;
REVERSE(DFN,IBD,IBAUTO) ;process reversed claims
 N IBIFN,I,IB,IBIL,IBCHG,IBCRES,IBY,X,Y,DA,DIE,DR,IBADT,IBLOCK,IBLDT
 N IBNOW,IBDUZ,IBCR,IBRELC,IBCC,IBPAP,IBRXN,IBFIL,IBRTS,IBARES,IBUSR
 N IBLGL,IBLDT
 S IBDUZ=.5
 S IBLOCK=0
 ; find bill number
 I 'DFN S IBY="0^No patient" G REVQ
 I '$L($G(IBD("CLAIMID"))) S IBY="0^Missing ECME Number" G REVQ
 S IBADT=+$G(IBD("FILL DATE")) I 'IBADT S IBY="0^Missing Fill Date" G REVQ
 S IBRXN=+$G(IBD("PRESCRIPTION")) I 'IBRXN S IBY="0^No Rx IEN" G REVQ
 S IBFIL=+$G(IBD("FILL NUMBER"),-1) I IBFIL<0 S IBY="0^No fill number" G REVQ
 I $E($G(IBD("RESPONSE")),1)="R" D  G REVQ:+'$G(IBRTS)
 . S IBY="0^REVERSAL rejected by payer"
 . S IBRTS=$$RTS(IBD("REVERSAL REASON"))
 ;
 D CANC^IBNCPDP6(IBRXN_";"_IBFIL) ; cancel 1st party charge for Tricare
 ;
 S IBD("BCID")=$$BCID^IBNCPDP4(IBD("CLAIMID"),IBADT)
 L +^DGCR(399,"AG",IBD("BCID")):15 E  S IBY="0^Cannot lock ECME number" G REVQ
 S IBLOCK=1
 S IBUSR=$S(+$G(IBD("USER"))=0:DUZ,1:IBD("USER"))
 S IBLDT=$$FMADD^XLFDT(DT,1) F  S IBLGL=$O(^XTMP("IBNCPLDT"_IBLDT),-1),IBLDT=$E(IBLGL,9,15) Q:IBLDT<$$FMADD^XLFDT(DT,-3)!(IBLGL'["IBNCPLDT")  I $D(^XTMP(IBLGL,IBD("BCID"))) S ^(IBD("BCID"))="" Q
 S IBIFN=$$MATCH^IBNCPDP2(IBD("BCID"),$G(IBD("RXCOB")))
 I $D(IBD("CLOSE REASON")),'$D(IBD("DROP TO PAPER")) S IBD("DROP TO PAPER")=""
 S IBCR=+$G(IBD("CLOSE REASON"))
 S IBPAP=$G(IBD("DROP TO PAPER"))
 S IBRELC=$G(IBD("RELEASE COPAY"))
 S IBCC=$G(IBD("CLOSE COMMENT"))
 D NONBR^IBNCPNB(DFN,IBRXN,IBFIL,IBADT,IBCR,IBPAP,IBRELC,IBCC,IBUSR)
 I 'IBIFN S IBY="0^"_$S(IBPAP:"Dropped to paper",IBCR>1:"Set non-billable reason in CT",1:"Cannot find the bill to reverse") G REVQ
 ;
 F I=0,"S" S IB(I)=$G(^DGCR(399,IBIFN,I))
 I IB(0)="" S IBY="0^No data in bill" G REVQ
 I +$P(IB("S"),U,16),$P(IB("S"),U,17)]"" S IBY="0^Bill already cancelled" G REVQ
 ;
 S:'$D(IBCRES) IBCRES="ECME PRESCRIPTION REVERSED"
 S DA=IBIFN,DR="16////1;19////"_IBCRES,DIE="^DGCR(399,"
 D ^DIE K DA,DIE,DR
 ;
 ; - decrease out the receivable in AR
 S IB("U1")=$G(^DGCR(399,IBIFN,"U1"))
 S IBIL=$P($G(^PRCA(430,IBIFN,0)),"^")
 S IBCHG=$S(IB("U1")']"":0,$P(IB("U1"),"^",1)]"":$P(IB("U1"),"^",1),1:0)
 ;
 S X="21^"_IBCHG_"^"_IBIL_"^"_IBDUZ_"^"_DT_"^"_IBCRES
 D ^PRCASER1
 S IBARES=Y
 I IBARES<0 S IBY=IBARES D BULL
 ;
 S IBY=$S(IBARES<0:"0^"_$P(IBARES,"^",2),1:1)
 ;
 I IBDUZ'=DUZ D  ; set the real user
 . N IBI,IBT S IBI=18,IBT(399,IBIFN_",",IBI)=IBDUZ D FILE^DIE("","IBT")
 ;
REVQ ; perform end of job tasks
 D LOG^IBNCPDP2($S($G(IBAUTO)=1:"AUTO REVERSE",$G(IBAUTO)=2:"BILL CANCELLED",1:"REVERSE"),IBY)
 I IBLOCK L -^DGCR(399,"AG",IBD("BCID"))
 I IBY=1,$G(IBIFN) S IBY=+IBIFN
 Q IBY
 ;
RTS(IBRR) ; Return to Stock processing on Released Rx
 ; input - IBRR = reversal reason
 ;         IBCRSN = passed in by reference
 ; output - 0 = reversal not due to a Rx RETURN TO STOCK or Rx DELETE
 ;          1 = reversal due to a Rx RETURN TO STOCK or Rx DELETE
 ;          IBCRSN = charge removal reason
 N IBTRKRN,IBLOCK2,IBCMT,DA,DIE,DR
 ;
 I IBRR'="RX RETURNED TO STOCK"&(IBRR'="RX DELETED") Q 0
 S IBTRKRN=+$O(^IBT(356,"ARXFL",IBRXN,IBFIL,0))
 I 'IBTRKRN Q 0  ; CT record does not exist
 I '$P($G(^IBT(356,IBTRKRN,0)),U,11) Q 0  ; BILL does not exist
 S IBCRES=$$GETRSN(DFN,IBRXN,IBFIL)  ; recorded in file 399 entry
 L +^IBT(356,IBTRKRN):5 S IBLOCK2=$T
 S DIE="^IBT(356,",DA=IBTRKRN,IBCMT="Rx RTS - May Need Refund"
 S DR="1.08////"_IBCMT
 D ^DIE
 I IBLOCK2 L -^IBT(356,IBTRKRN)
 Q 1
 ;
BULL ; Generate a bulletin if there is an error in cancelling the claim.
 N IBC,IBT,IBPT,IBGRP,XMDUZ,XMTEXT,XMSUB,XMY
 ;
 S IBPT=$$PT^IBEFUNC(DFN)
 S XMSUB=$E($P(IBPT,"^"),1,14)_"  "_$P(IBPT,"^",3)_" - ERROR ENCOUNTERED"
 S XMDUZ="INTEGRATED BILLING PACKAGE",XMTEXT="IBT("
 S XMY(IBDUZ)=""
 S XMY("G.IBCNR EPHARM")=""
 ;
 S IBT(1)="An error occurred while cancelling the Pharmacy claim from ECME"
 S IBT(2)="fiscal intermediary for the following patient:"
 S IBT(3)=" " S IBC=3
 D PAT^IBAERR1 ; Accepts IBDUZ
 S IBC=IBC+1,IBT(IBC)="   Bill #: "_IBIL
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="The following error was encountered:"
 S IBC=IBC+1,IBT(IBC)=" "
 D ERR^IBAERR1
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please review the circumstances surrounding this error and decrease"
 S IBC=IBC+1,IBT(IBC)="out this receivable in Accounts Receivable if necessary."
 D ^XMD
 Q
 ;
GETRSN(DFN,IBRXN,IBFIL) ;
 ; retrieve charge removal reason from file 354.71
 ; input - DFN,IBRXN=Rx ien,IBFIL=fill number
 ; output - charge removal reason
 N IBDT,IBDA,IBXRSN,IBRXFIL,IB0
 S (IBDT,IBDA)=0,IBXRSN=""
 S IBRXFIL=$S('IBFIL:IBRXN,1:IBRXN_";"_IBFIL)
 F  S IBDT=$O(^IBAM(354.71,"AD",DFN,IBDT)) Q:'IBDT  Q:IBXRSN]""  D
 . F  S IBDA=$O(^IBAM(354.71,"AD",DFN,IBDT,IBDA)) Q:'IBDA  Q:IBXRSN]""  D
 . . S IB0=^IBAM(354.71,IBDA,0)
 . . Q:$P(IB0,"^",6)'[IBRXFIL
 . . S IBXRSN=$$GET1^DIQ(354.71,IBDA_",",.19)
 S:IBXRSN']"" IBXRSN="CHARGE REMOVAL REASON NOT FOUND"
 Q "Reversal Rej, no pymt due<>"_IBXRSN
 ;
 ;IBNCPDP3
