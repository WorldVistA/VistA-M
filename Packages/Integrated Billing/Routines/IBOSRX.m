IBOSRX ;ALB/ESG - POTENTIAL SECONDARY RX CLAIMS REPORT ;6-JUL-10
 ;;2.0;INTEGRATED BILLING;**411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; DBIA 5361 entry point at COLLECT
 ;
 ; Collect and return potential secondary rx claims
 ; Input: SDT = Start date FM format
 ;        EDT = End date FM format
 ;
 ; Return:
 ; ^TMP("BPSRPT9A",$J,n) = RX IEN^RX#^FILL#^BILL#^DFN^DATE^PRIMARY INS NAME^399 ien^TOTAL CHARGES
 ; ^TMP("BPSRPT9A",$J,n,n,1) = INSURANCE COMPANY IEN^INSURANCE COMPANY NAME
 ; ^TMP("BPSRPT9A",$J,n,n,2) = INSURANCE COMPANY ADDRESS
 ; ^TMP("BPSRPT9A",$J,n,n,7) = COB INDICATOR^COB DESC
 ;
 Q
 ;
COLLECT(SDT,EDT) ; entry point DBIA 5361
 ;
 N CNT,IBSDT,IBBILL,IB0,INS,IBPINS,IBINS,IBRET,RIEN,RXD,RX,FL,RXIEN,SECBLFND,RBIEN,RBD,IB,ST,IBTOTCH
 ;
 ; scratch global should be killed by the calling routine
 ;
 S IBSDT=$O(^DGCR(399,"D",SDT),-1)
 F  S IBSDT=$O(^DGCR(399,"D",IBSDT)) Q:'IBSDT!(IBSDT>EDT)  D
 . S IBBILL=0
 . F  S IBBILL=$O(^DGCR(399,"D",IBSDT,IBBILL)) Q:'IBBILL  D
 .. ;
 .. ; consider only pharmacy bills
 .. Q:'$D(^IBA(362.4,"C",IBBILL))
 .. ;
 .. S IB0=$G(^DGCR(399,IBBILL,0))
 .. I '$F(".3.4.","."_$P(IB0,U,13)_".") Q           ; must be auth/print/tx
 .. I $$COBN^IBCEF(IBBILL)'=1 Q                     ; must be primary
 .. S INS=+$G(^DGCR(399,IBBILL,"I1"))
 .. S IBPINS=$P($G(^DIC(36,INS,0)),U,1)             ; primary ins co name
 .. S IBTOTCH=+$P($G(^DGCR(399,IBBILL,"U1")),U,1)   ; total charges on claim
 .. ;
 .. ; check insurances for this patient on this date
 .. K IBINS
 .. S IBRET=$$INSUR^IBBAPI($P(IB0,U,2),IBSDT,"P",.IBINS,"1,2,7")
 .. I '$D(IBINS("IBBAPI","INSUR",2)) Q   ; do not have at least 2 Rx policies so get out
 .. ;
 .. ; now loop thru all Rx's on this claim - paper claims may have more than one
 .. S RIEN=0 F  S RIEN=$O(^IBA(362.4,"C",IBBILL,RIEN)) Q:'RIEN  D
 ... S RXD=$G(^IBA(362.4,RIEN,0))
 ... S RX=$P(RXD,U,1) Q:RX=""       ; RX#
 ... S FL=+$P(RXD,U,10)             ; fill#
 ... S RXIEN=+$P(RXD,U,5)           ; RX ien to file# 52
 ... ;
 ... S SECBLFND=0   ; flag indicating if secondary bill was found or not for this Rx/fill#
 ... ;
 ... ; now loop thru all entries in this file for this RX
 ... S RBIEN=0 F  S RBIEN=$O(^IBA(362.4,"B",RX,RBIEN)) Q:'RBIEN  I RBIEN'=RIEN D  Q:SECBLFND
 .... S RBD=$G(^IBA(362.4,RBIEN,0))
 .... I +$P(RBD,U,10)'=FL Q               ; fill# check
 .... S IB=+$P(RBD,U,2)                   ; claim#
 .... I $$COBN^IBCEF(IB)'>1 Q             ; looking for payer seq 2 or 3
 .... S ST=$P($G(^DGCR(399,IB,0)),U,13)   ; claim status
 .... I '$F(".3.4.","."_ST_".") Q         ; must be auth/print/tx
 .... ;
 .... ; found a secondary claim!
 .... S SECBLFND=1
 .... Q
 ... ;
 ... ; if we found a secondary claim for this Rx/fill# then get out
 ... I SECBLFND Q
 ... ;
 ... S CNT=$O(^TMP("BPSRPT9A",$J,""),-1)+1
 ... S ^TMP("BPSRPT9A",$J,CNT)=RXIEN_U_RX_U_FL_U_$P(IB0,U,1)_U_$P(IB0,U,2)_U_IBSDT_U_IBPINS_U_IBBILL_U_IBTOTCH
 ... M ^TMP("BPSRPT9A",$J,CNT)=IBINS("IBBAPI","INSUR")
 ... Q
 .. Q
 . Q
 Q
 ;
