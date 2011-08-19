IBATEP ;ALB/BGA - TRANSFER PRICING RX TRACKER ; 09-APRIL-99
 ;;2.0;INTEGRATED BILLING;**115**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; This routine is invoked by the Rx Pharmacy Event driver interface
 ; PS EVSEND OR. This routine monitors in real time
 ; any Rx that has been released from Pharmacy and determines if the DFN
 ; is a transfer pricing patient. If TP than the routine will price
 ; the Rx and file the transaction in ^IBAT(351.61
 ;
 ;
EN ; Entry point for Rx Transfer Pricing.
 ; Required Pharm 7.0 and Patch PSO*7*27 (Give us the new MSG(6) node)
 ; Only select records that are return to storage or released
 I '$P($G(^IBE(350.9,1,10)),"^",4) Q  ; transfer pricing turned off
 I $G(MSG(1))']" "!($G(MSG(2))']" ")!($G(MSG(3))']" ")!($G(MSG(4))']" ")!($G(MSG(6))']" ") Q
 ; Proposed solution to the partial problem
 Q:$P(MSG(6),"|",7)="P"  ; quit if this is a partial.
 N IBRXIEN,IBRXSTAT,IBDFN,D,IBPREF,IBSOURCE,IBDETM,IBATIEN,IBREL,IBIND
 N IBEDT,IBDRUG,IBQTY,IBCOST,LASTREF
 S D="|" Q:$P(MSG(1),D,3)'="PHARMACY"!($P(MSG(3),D,3)'="O")
 S IBRXIEN=$P($P(MSG(4),D,4),U) Q:IBRXIEN<1
 S IBRXSTAT=$P(MSG(4),D,2) Q:IBRXSTAT'="ZD"
 S IBDFN=$P(MSG(2),D,4) Q:IBDFN<1
 ;============================================================
 ; Check to see if the dfn is a tp member and has a valid facility
 Q:'$$TPP^IBATUTL(IBDFN)
 S IBPREF=$$PPF^IBATUTL(IBDFN) Q:'IBPREF
 ;============================================================
 ; Get the Rx data
 D EN^PSOORDER(IBDFN,IBRXIEN) Q:'$D(^TMP("PSOR",$J,IBRXIEN,0))
 ; Determine if this is a refill or original and 
 ; Return to stock or release from stock
 S IBSEL=$$IBDETM(IBRXIEN) Q:$P(IBSEL,U)="Q"
 ; I IBREL=1 Return to stock ; IBREL=0 Release from stock
 ; I IBIND>0 this is a Refill
 S IBIND=$P($P(IBSEL,U),"|"),IBREL=$P($P(IBSEL,U),"|",2)
 S IBSOURCE=IBRXIEN_";PSRX(;"_IBIND
 Q:'$D(^TMP("PSOR",$J,IBRXIEN,"DRUG",0))  S IBDRUG=$P($P($G(^(0)),U),";")
 ;==============================================================
 ; if transaction already exists and this is a return to stock
 I $D(^IBAT(351.61,"AD",IBSOURCE)),(IBREL) D  Q
 . S IBATIEN=$O(^IBAT(351.61,"AD",IBSOURCE,""))
 . D DEL^IBATFILE(IBATIEN)
 ;==============================================================
 ; Original Rx and Released from stock
 I '$D(^IBAT(351.61,"AD",IBSOURCE)),('IBREL),('IBIND) D  Q
 . S IBQTY=$P(IBSEL,U,7),IBCOST=$P(IBSEL,U,11),IBEDT=$P(IBSEL,U,4)
 . S IBATFILE=$$RX^IBATFILE(IBDFN,IBEDT,IBPREF,IBSOURCE,IBDRUG,IBQTY,IBCOST)
 ;==============================================================
 ; Refill Rx and Released from stock
 I '$D(^IBAT(351.61,"AD",IBSOURCE)),('IBREL),(IBIND) D  Q
 . S IBQTY=$P(IBSEL,U,5),IBCOST=$P(IBSEL,U,7),IBEDT=$P(IBSEL,U,2)
 . S IBATFILE=$$RX^IBATFILE(IBDFN,IBEDT,IBPREF,IBSOURCE,IBDRUG,IBQTY,IBCOST)
 ;==============================================================
 Q
IBDETM(X) ; Check to see if we have a original or refill
 ;  if original return 0|0 or 1 ^the node ^TMP("PSOR",$J,RXIEN,0)
 ;  if refill return n=refill#|0 or 1^the node ^TMP("PSOR",$J,RXIEN,"REF",n,0)
 ;  piece 1 0|0 means we have a original fill and released from stock
 ;  piece 1 0|1 means we have a original fill and returned to stock
 ;  ==========================================
 ;  If this is a refill return the following:
 ;  piece 1 (n|0 or 1) where "n" is the refill number and 
 ;  0="released from stock" and 1="returned to stock"
 ;  ==========================================
 ;  all other conditions return "Q"
 ; Note: You need to Invoke EN^PSOORDER first
 ;
 N RX0,FND,REFILL,Z,REFILLN,RTSFILL,ACT,ACTN,ACTON
 I '$D(^TMP("PSOR",$J,X,0)) S IBDETM="Q^Could not fine the global TMP('PSOR',$J) for RXIEN="_X Q IBDETM
 S RX0=$G(^TMP("PSOR",$J,X,0)) I $P(RX0,U,4)'["A;" S IBDETM="Q^This RXIEN="_X_" is not active." Q IBDETM
 ;====================================================================
 ; (1). Determine if the Orig RX was Returned to Stock (rts)
 S (RTSFILL,ACTON)=" "
 I $D(^TMP("PSOR",$J,X,"ACT")) D
 . S ACT=$O(^TMP("PSOR",$J,X,"ACT",""),-1) Q:'$G(ACT)
 . S ACTN=$G(^TMP("PSOR",$J,X,"ACT",ACT,0)),ACTON=1
 . ; P14 is only for ORIG Rx's that have been rts, check no refill, orig rts
 . I $P(RX0,U,14),'$D(^TMP("PSOR",$J,X,"REF",1,0)),$P(ACTN,U,2)["RETURN",$P(ACTN,U,4)["ORIGINAL" S IBDETM="0|1^"_X,RTSFILL=1 Q
 . ;
 . ;=================Decision code for Refill or RTS====================
 . I "^DELETED^RETURNED TO STOCK^"[(U_$P(ACTN,U,2)_U),$P(ACTN,U,4)["REFILL" D  Q
 . . S RTSFILL=$P($P(ACTN,U,4)," ",2) Q:'RTSFILL
 . . S LASTREF=$O(^TMP("PSOR",$J,X,"REF",""),-1)  ;always compare the last ref node 
 . . I LASTREF,$D(^TMP("PSOR",$J,X,"REF",LASTREF,0)),(LASTREF'<RTSFILL) D
 . . . ; REFILL:
 . . . ; must compare the last REFILL node with the last return to stock date on the "ACT" node
 . . . ;  if this is a REFILL than the LASTREF'<RTSFILL
 . . . ;  otherwise your last activity shows a rts for x refill
 . . . ;  and you have a remaining refill node x-1
 . . . S REFILLN=$G(^TMP("PSOR",$J,X,"REF",LASTREF,0))
 . . . S IBDETM=LASTREF_"|0^"_REFILLN Q
 . . E  S IBDETM=RTSFILL_"|1^"_X Q
 . I $P(ACTN,U,2)["RETURN",$P(ACTN,U,4)["ORIG",$D(^TMP("PSOR",$J,X,"REF",1,0)) D  Q
 . . ; Case where the previous action was a return to stock of the orig
 . . ; the new action is a FILL 1
 . . S RTSFILL=1,REFILLN=$G(^TMP("PSOR",$J,X,"REF",1,0)),IBDETM=RTSFILL_"|0^"_REFILLN Q
 I RTSFILL Q IBDETM
 ;====================================================================
 ; (2). Check for an original Rx.  [last fill dt=Fill dt]
 I $P(RX0,U,2)=$P(RX0,U,3),'ACTON D  Q IBDETM
 . S IBDETM="0|0^"_RX0 ; Case of released from stock.
 ;====================================================================
 ; (3). Check for Refills
 S (FND,REFILL)=0
 F  S REFILL=$O(^TMP("PSOR",$J,X,"REF",REFILL)) Q:'REFILL!(FND)!(ACTON)  D
 . S Z="",Z=$O(^TMP("PSOR",$J,X,"REF",REFILL,Z)) Q:Z=""
 . S REFILLN=$G(^TMP("PSOR",$J,X,"REF",REFILL,Z))
 . ; i lastfill date=the refill date [we have a refill]
 . I $P(RX0,U,3)=$P(REFILLN,U) S FND=1 D
 . . S IBDETM=REFILL_"|0^"_REFILLN
 ;====================================================================
 I 'FND S IBDETM="Q^No Refill or Original found for RXIEN="_X
 Q IBDETM
