PRCAMRKC ;WASH-ISC@ALTOONA,PA/LDB-CHECK MARK/UNMARK TRANSACTION FOR ACCOUNT BALANCE ;9/27/93  10:34 AM
V ;;4.5;Accounts Receivable;**399**;Mar 20, 1995;Build 67
 ;;Per VHA Directive 6402, this routine should not be modified.
 ;PRCA*4.5*399 Added capture ^TMP("PRCAMRCK",$J,1) 
 ;             for displayed accounts recalculation
 ;
EN(DEB) ;Called from PRCAMARK  o find balance discrepancy
 N PBAL,DAT,TBAL,BBAL,RR S PRCARFRW=0
 S (PBAL,BBAL,TBAL,PRCARFRW)=0 K ^TMP("PRCAGT",$J)
 D BBAL^PRCAGU(DEB,.BBAL)
 S DAT=$$LST^RCFN01(DEB,2) I DAT<1 S DAT=0
 I DAT S DAT=9999999.999999-DAT D PBAL^PRCAGU(DEB,.DAT,.PBAL)
 D EN^PRCAGT(DEB,DAT)
 D TBAL^PRCAGT(DEB,.TBAL)
 S PRCARFRW=$$REFUREVW(DEB)
CHK I (PBAL+TBAL'=BBAL)!PRCARFRW S Y=1,^TMP("PRCAMRKC",$J,DEB)=PBAL_U_TBAL_U_BBAL_U_PRCARFRW_U_$P(^DPT(+$P(^RCD(340,DEB,0),";"),0),U)
 E  S Y=0
 Q Y
REFUREVW(DEB) ;  return prepayment bills in status refund review (44)
 ;  returns total of prepayment bills in refund review
 ;  returns rcprepay(billda)=amt in refund review
 N BILLDA,PRINCPAL,RCPREPAY,TOTAL
 K RCPREPAY
 S BILLDA=0,TOTAL=0 F  S BILLDA=$O(^PRCA(430,"AS",DEB,44,BILLDA)) Q:'BILLDA   D
 .;  not a prepayment bill
 .I $P($G(^PRCA(430,BILLDA,0)),"^",2)'=26 Q
 .;  prepayment bill in refund review
 .;  no money
 .S PRINCPAL=+$P($G(^PRCA(430,BILLDA,7)),"^") I 'PRINCPAL S TOTAL=0 Q
 .S RCPREPAY(BILLDA)=PRINCPAL
 .S TOTAL=$G(TOTAL)+PRINCPAL
 Q +$G(TOTAL)
