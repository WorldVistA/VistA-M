IBNCPDP3 ;OAK/ELZ - STORES NDC/AWP UPDATES ;11/14/07  13:18
 ;;2.0;INTEGRATED BILLING;**223,276,342,363,383,384,411,435**;21-MAR-94;Build 27
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Reference to ^PRCASER1 supported by IA# 593
 ; Reference to BPS RESPONSES file (#9002313.03) supported by IA# 4813
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
ELIG(DFN,IBD) ; process an Eligibility response
 N IBRES,ERACT,IDUZ,IBFDA,BPRIEN,IBUSR,IBCDFN,IBPL,IBERR,EPHSRC,INSIEN,BUDA,PTDA,PLDA,ICDA,BUFF,BPSR,ZR,BPRSUB,BPRGRP,IBNCPDPELIG
 S IBRES=""
 I '$G(DFN) S IBRES="0^No patient - ELIG response" G ELIGX
 S BPRIEN=+$G(IBD("RESPIEN"))     ; response file ien
 S IBUSR=+$G(IBD("USER"))         ; DUZ of user
 S IBCDFN=+$G(IBD("POLICY"))      ; pt. ins. policy subfile 2.312 ien
 S IBPL=+$G(IBD("PLAN"))          ; plan 355.3 ien
 ;
 ; data integrity checks
 I 'BPRIEN S IBRES="0^No BPS RESPONSES file ien" G ELIGX
 I '$D(^BPSR(BPRIEN,0)) S IBRES="0^No BPS RESPONSES file data exists for this ien" G ELIGX
 S ZR=BPRIEN_","
 D GETS^DIQ(9002313.03,ZR,"103;301;302","IEN","BPSR")
 I $G(BPSR(9002313.03,ZR,103,"E"))'="E1" S IBRES="0^BPS Response is not an E1 Transaction Code" G ELIGX
 I 'IBCDFN S IBRES="0^No pt. policy ien" G ELIGX
 I '$D(^DPT(DFN,.312,IBCDFN,0)) S IBRES="0^Pt. insurance policy data not found" G ELIGX
 I +$P($G(^DPT(DFN,.312,IBCDFN,0)),U,18)'=IBPL S IBRES="0^Mismatch on plan ien" G ELIGX
 ;
 ; build a buffer entry based primarily on the ins. policy in the pt. file
 K IBERR
 S IDUZ=IBUSR
 S IBNCPDPELIG=1   ; special variable indicating to eIV where the buffer entry is coming from
 D PT^IBCNEBF(DFN,IBCDFN,"","",1,.IBERR)     ; build and add buffer entry
 I $G(IBERR)'="" S IBRES="0^"_IBERR G ELIGX
 I '$G(IBFDA) S IBRES="0^No Buffer entry was created" G ELIGX
 I '$D(^IBA(355.33,IBFDA,0)) S IBRES="0^Buffer entry doesn't exist" G ELIGX
 S EPHSRC=+$O(^IBE(355.12,"C","E-PHARMACY",0))    ; source of information
 I 'EPHSRC S IBRES="0^Cannot find e-Pharmacy Source of Information in dictionary" G ELIGX
 S INSIEN=+$P($G(^DPT(DFN,.312,IBCDFN,0)),U,1)
 I 'INSIEN S IBRES="0^Insurance Company pointer not there" G ELIGX
 ;
 ; complete the buffer entry
 S BUDA=+IBFDA_","              ; IENS for the buffer entry
 S PTDA=IBCDFN_","_DFN_","      ; IENS for the pt. ins. policy subfile entry 2.312
 S PLDA=IBPL_","                ; IENS for the plan entry 355.3
 S ICDA=INSIEN_","              ; IENS for the insurance company entry 36
 ;
 S BUFF(355.33,BUDA,60.1)=$$GET1^DIQ(2.312,PTDA,4.01,"I")
 S BUFF(355.33,BUDA,60.11)=$$GET1^DIQ(2.312,PTDA,4.02,"I")
 ;
 S BUFF(355.33,BUDA,40.01)=$$GET1^DIQ(355.3,PLDA,.02,"I")
 S BUFF(355.33,BUDA,40.04)=$$GET1^DIQ(355.3,PLDA,.05,"I")
 S BUFF(355.33,BUDA,40.05)=$$GET1^DIQ(355.3,PLDA,.06,"I")
 S BUFF(355.33,BUDA,40.06)=$$GET1^DIQ(355.3,PLDA,.12,"I")
 S BUFF(355.33,BUDA,40.07)=$$GET1^DIQ(355.3,PLDA,.07,"I")
 S BUFF(355.33,BUDA,40.08)=$$GET1^DIQ(355.3,PLDA,.08,"I")
 S BUFF(355.33,BUDA,40.09)=$$GET1^DIQ(355.3,PLDA,.09,"I")
 S BUFF(355.33,BUDA,40.1)=$$GET1^DIQ(355.3,PLDA,6.02,"I")
 S BUFF(355.33,BUDA,40.11)=$$GET1^DIQ(355.3,PLDA,6.03,"I")
 ;
 S BUFF(355.33,BUDA,20.02)=$$GET1^DIQ(36,ICDA,.131,"I")
 S BUFF(355.33,BUDA,20.05)=$$GET1^DIQ(36,ICDA,1,"I")
 S BUFF(355.33,BUDA,21.01)=$$GET1^DIQ(36,ICDA,.111,"I")
 S BUFF(355.33,BUDA,21.02)=$$GET1^DIQ(36,ICDA,.112,"I")
 S BUFF(355.33,BUDA,21.03)=$$GET1^DIQ(36,ICDA,.113,"I")
 S BUFF(355.33,BUDA,21.04)=$$GET1^DIQ(36,ICDA,.114,"I")
 S BUFF(355.33,BUDA,21.05)=$$GET1^DIQ(36,ICDA,.115,"I")
 S BUFF(355.33,BUDA,21.06)=$$GET1^DIQ(36,ICDA,.116,"I")
 ;
 ; update buffer entry with some additional information
 S BUFF(355.33,BUDA,.03)=EPHSRC      ; source of info
 S BUFF(355.33,BUDA,.12)=""          ; make sure eIV related fields are blank
 S BUFF(355.33,BUDA,.13)=""
 S BUFF(355.33,BUDA,.14)=""
 S BUFF(355.33,BUDA,.15)=""
 S BUFF(355.33,BUDA,.17)=BPRIEN      ; BPS response file ien
 ;
 ; update buffer entry with data pulled from BPS response file
 ; only 2 fields are applicable here:  group# and cardholder ID
 ;
 S BPRSUB=$G(BPSR(9002313.03,ZR,302,"E"))         ; subscriber/cardholder ID
 I BPRSUB'="" S BUFF(355.33,BUDA,60.04)=BPRSUB    ; update buffer if field exists
 ;
 S BPRGRP=$G(BPSR(9002313.03,ZR,301,"E"))         ; group number
 I BPRGRP'="" S BUFF(355.33,BUDA,40.03)=BPRGRP    ; update buffer if field exists
 ;
 D FILE^DIE(,"BUFF")
 ;
 S IBRES=1  ; all good
 ;
ELIGX ;
 Q IBRES
 ;
 ;IBNCPDP3
