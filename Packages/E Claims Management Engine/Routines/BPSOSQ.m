BPSOSQ ;BHAM ISC/FCS/DRS/DLF - BPS Transactions Utils ;06/01/2004
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5**;JUN 2004;Build 45
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
 ; Numerous little functions for BPS Transactions
 ; BPS Log of Transaction versions in BPSOS57
 ; All functions assume that IEN59 will exist
 ;
RXI() Q $P(^BPST(IEN59,1),U,11) ; Given IEN59, return RXI
RXR() Q $P(^BPST(IEN59,1),U,1) ; Given IEN59, return RXR
NDC() Q $P(^BPST(IEN59,1),U,2)
QTY() Q $P(^BPST(IEN59,5),U) ; Given IEN59, return quantity
AMT() Q $P(^BPST(IEN59,5),U,5) ; return total $amount
CHG() Q $P(^BPST(IEN59,5),U,5) ; Given IEN59, ret total charge
PATIENT() Q $P(^BPST(IEN59,0),U,6)
USER() N X S X=$P(^BPST(IEN59,0),U,10) S:'X X=$G(DUZ) Q X
NOW() N %,%H,%I,X D NOW^%DTC Q %
