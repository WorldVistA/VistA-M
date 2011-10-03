IBNCPUT3 ;ALB/SS - ePharmacy secondary billing ;12-DEC-08
 ;;2.0;INTEGRATED BILLING;**411**;21-MAR-94;Build 29
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
 ;
 ;used by ECME
 ;ICR #5355 
 ;determine if there is a bill with a given bill #
 ;input: 
 ; IBBIL - bill # entered by the user
 ;returns:
 ; file #399 ien if found
 ; zero if not found 
ISBILL(IBBIL) ;
 N IB399
 S IB399=+$O(^DGCR(399,"B",IBBIL,0))
 I IB399>0 Q IB399  ;bill # was entered
 Q 0  ;nothing was found
 ;
 ;get bill details from file #399
 ;Used by ECME - ICR #5355 
 ;input:
 ;  IB399 - bill ien of (#399)
 ;  IBINFO - output array, by reference
 ;Returns two piece value:
 ; Piece#1 :
 ;  -1 if an error
 ;  the payer sequence (P-primary, S-secondary,...)
 ; Piece#2 :
 ;  error message if piece#1 = -1
 ;  otherwise - patient's DFN
 ;  
 ;Output array, passed in by reference.
 ;Format of data returned in the array:
 ; IBINFO("INS IEN") - insurance ien, ien of the file (#36)
 ; IBINFO("INS NAME") - insurance name as a text
 ; IBINFO("BILL #") - bill number, field (#.01) of the file (#399)
 ; IBINFO("AR STATUS") - Account Receivable status for the bill                    
 ; IBINFO("DOS") - date of service (FM format)
 ; IBINFO("PLAN") - plan ien of (#355.3)
 ; IBINFO("FILL NUMBER") - refill number                                          
 ; IBINFO("PRESCRIPTION") - prescription ien of file (#52)  ;  
BILINF(IB399,IBINFO) ;
 Q:IB399=0 ""
 N IBDFN,IBZZ,IBRXN,IBFIL,IB3624,IBPSEQ
 ;
 S IBDFN=$P($G(^DGCR(399,IB399,0)),U,2)
 S IBPSEQ=$P($G(^DGCR(399,IB399,0)),U,21)
 I IBPSEQ="" Q "-1^Cannot determine payer sequence"
 S IBINFO("INS IEN")=$P($G(^DGCR(399,IB399,"MP")),U)
 S IBINFO("INS NAME")=$P($G(^DIC(36,+IBINFO("INS IEN"),0)),U)
 S IBINFO("BILL #")=$P($G(^DGCR(399,IB399,0)),U,1)
 S IBINFO("IB STATUS")=$P($G(^DGCR(399,IB399,0)),U,13)
 S IBINFO("AR STATUS")=$P($$ARSTATA^IBJTU4(IB399),U,2)
 S IBINFO("DOS")=$P($G(^DGCR(399,IB399,0)),U,3)
 S IBINFO("PLAN")=$$GETPLAN(IB399)
 ;
 S IB3624=0
 S IB3624=$O(^IBA(362.4,"C",IB399,0))
 I IB3624>0 D
 . S IBZZ=^IBA(362.4,IB3624,0)
 . I IBZZ>0 S IBINFO("PRESCRIPTION")=+$P(IBZZ,U,5),IBINFO("FILL NUMBER")=+$P(IBZZ,U,10),IBINFO("DOS")=+$P(IBZZ,U,3)
 I $G(IBINFO("PRESCRIPTION"))="" Q "-1^no RX ien"
 I $G(IBINFO("FILL NUMBER"))="" Q "-1^no Refill No"
 ;
 Q IBPSEQ_U_IBDFN
 ;
GETPLAN(IB399) ;
 N IBPLN,IBNODE
 S IBPLN=0
 S IBNODE=$P($G(^DGCR(399,IB399,0)),"^",21),IBNODE=$S(IBNODE="P":1,IBNODE="S":2,IBNODE="T":3,1:"")
 S IBPLN=$P($G(^DGCR(399,IB399,"I"_IBNODE)),U,18)
 Q IBPLN
 ;
 ;Find bill(s) for the specific RX/refill
 ;Used by ECME - ICR #5355
 ;IBRXIEN RX ien (#52)
 ;IBRXREF refill #
 ;IBRXCOB - (optional) Payer Sequence ("P"- primary,"S" - secondary,"T" -tertiary
 ;IBDOS-(optional)Date of Service 
 ;IBARR - by reference to return the list of bills for the RX#
 ;Return:
 ; return 2 pieces
 ; piece 1 - the number of ANY (cancelled, active, etc) bills found for the RX/refill
 ; piece 2 - the latest active bill's ien
 ;Return all bills in the array IBARR as 
 ; IBARR(IEN of the file #399 )= Bill#^status^date^insurance name^payer sequence^RX ien^Refill No
 ; 
RXBILL(IBRXIEN,IBRXREF,IBRXCOB,IBDOS,IBARR) ;
 N IB3624,IB3624V,IB399,IBRET,IBCNT,IBRXNUM,IB399ACT
 S IBCNT=0
 S IB3624=0
 S IB399ACT=0
 S IBRXNUM=$$RXAPI1^IBNCPUT1(IBRXIEN,.01,"E") ;external format
 Q:IBRXNUM="" 0
 F  S IB3624=$O(^IBA(362.4,"B",IBRXNUM,IB3624)) Q:+IB3624=0  D
 . S IB3624V=$G(^IBA(362.4,IB3624,0))
 . I $P(IB3624V,U,10)'=IBRXREF Q
 . I $G(IBDOS) I $P(IB3624V,U,3)'=IBDOS Q
 . S IB399=+$P(IB3624V,U,2)
 . I IB399=0 Q
 . N IBINFARR
 . S IBRET=$$BILINF(IB399,.IBINFARR)
 . I +IBRET=-1 Q
 . I $G(IBRXCOB)'="",$P(IBRET,U)'=IBRXCOB Q
 . S IBARR(IB399)=$G(IBINFARR("BILL #"))_U_$G(IBINFARR("AR STATUS"))_U_$G(IBINFARR("DOS"))_U_$G(IBINFARR("INS NAME"))_U_($P(IBRET,U))_U_$G(IBINFARR("PRESCRIPTION"))_U_$G(IBINFARR("FILL NUMBER"))_U_$G(IBINFARR("IB STATUS"))
 . I $G(IBINFARR("AR STATUS"))="A" S IB399ACT=IB399
 . S IBCNT=IBCNT+1
 Q IBCNT_U_IB399ACT
 ;
 ;IBRATYP - rate type (ien of file #399.3)
 ;IBDT - date
COSTTYP(IBRATYP,IBDT) ;
 N IBRS,IBRET
 S IBRET=$P($$EVNTITM^IBCRU3(IBRATYP,3,"PRESCRIPTION FILL",IBDT,.IBRS),";",1)
 Q $S(IBRET="VA COST":"C^T",IBRET="1":"T^V",1:"")
 ;
 ;IBNCPUT3
