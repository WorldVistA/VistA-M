RCTCSPD4 ;ALB/LMH - CROSS-SERVICING NON-FINANCIAL TRANSACTIONS ;03/15/14 3:34 PM
 ;;4.5;Accounts Receivable;**315,339,350,366,400**;Mar 20, 1995;Build 13
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q 
 ;
STOP ; CS stop placed non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,33,DUZ,"CS STOP PLACED")
 Q
 ;
DELSTOP ; CS delete stop non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,36,DUZ,"CS STOP DELETED")
 Q
 ;
RCLL ; Recall from Cross-Servicing non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,34,DUZ,"CS BILL RECALL")
 Q
 ;
DELRCLL ; Cross-Servicing Delete Bill Recall non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,37,DUZ,"CS DEL BILL RECALL")
 Q
 ;
NEWDEBTR ; CS add new debtor non-financial tx  PRCA*4.5*400
 ;         Called by RCTCSPD
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,48,DUZ,"CS NEW DBTR NEW BILL")
 Q
 ;
RCRSD ; CS Debtor Recall non-financial tx  PRCA*4.5*400
 ; Set this debtor for Recall from Cross-Servicing
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,35,DUZ,"CS DEBTOR RECALL")
 Q
 ;
DELSETD(BILL) ; CS Delete Debtor Recall non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,38,DUZ,"CS DEL DEBTOR RECALL")
 Q
 ;
DEBTOR ; CS New Bill Existing Debtor non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,39,DUZ,"CS DEBTOR NEW BILL")
 Q
 ;
CSCASE ;  Add Case Info non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,47,DUZ,"CS ADD CASE INFO")
 Q
 ;
DELSETC ; Cross-Servicing delete case recall non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,46,DUZ,"CS DEL CASE RECALL")
 Q
 ;
DECADJ ; non-financial decrease adjustment transaction for 5b cross-servicing record  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,49,DUZ,"CS DECREASE ADJ")
 Q
 ;
DECADJ0 ; decrease adjustment transaction deletes cs date  PRCA*4.5*400
 ; 5B tx takes bal. of bill to 0 
 ; if node 7 balances = 0.  Called by RCTCSPD
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,40,DUZ,"CS DECR ADJ NOT APP")
 D CHKS
 Q
 ;
RCRSC ; Cross-Servicing case recall non-financial tx  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ
 S DUZ=.5,DUZ(0)="@",DUZ(2)=1 ; Server has no DUZ, use Postmaster
 D FILETRN^RCTCSPD5(BILL,45,DUZ,"CS CASE RECALL")
 Q
 ;
RRREQ ; CS RE-REFER BILL REQUEST non-financial tx  PRCA*4.5*400
 ; Request a referral, called from RRSETB^RCTCSPU
 ; INPUT: BILL,REASON,COMMENT
 N CMNT
 Q:$G(REASON)=""
 S CMNT(1)=$S(REASON="R":"Recall in error",REASON="T":"Treasury reversal",REASON="D":"Defaulted RPP",REASON="O":"Other: "_$G(COMMENT),1:" ")
 D FILETRN^RCTCSPD5(BILL,63,DUZ,"CS RE-REFER BILL REQUEST",.CMNT)
 Q
 ;
RRCAN ; CS RE-REFER BILL CANCEL non-financial tx  PRCA*4.5*400
 ; Cancel a referral request, called from RRSETB^RCTCSPU
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 D FILETRN^RCTCSPD5(BILL,65,DUZ,"CS RE-REFER BILL CANCEL")
 Q
RRSEND ; CS New Bill Existing Debtor non-financial tx ;  PRCA*4.5*400
 ;
 ; assumes that BILL variable is defined and contains bill number
 ;
 N DUZ,I
 S I=$O(^PRCA(430,BILL,15.5,99999),-1)
 I I'="" S DUZ=$P($G(^PRCA(430,BILL,15.5,I,0)),U,3)
 S:'$G(DUZ) DUZ=.5 ; Server has no DUZ, use Postmaster if can't find it
 S DUZ(0)="@",DUZ(2)=1
 D FILETRN^RCTCSPD5(BILL,64,DUZ,"CS DEBTOR RE-REFER BILL")
 Q
 ;
CHKS ;Leave validation checks in place
 I $P($G(^PRCA(433,PRCAEN,5)),"^",2)=""!'$P(^PRCA(433,PRCAEN,1),"^") S PRCACOMM="TRANSACTION INCOMPLETE" D DELETE^PRCAWO1 K PRCACOMM Q
 I '$D(PRCAD("DELETE")) S RCASK=1 D TRANUP^PRCAUTL,UPPRIN^PRCADJ
 I $P($G(^RCD(340,+$P(^PRCA(430,PRCABN,0),"^",9),0)),"^")[";DPT(" D
 .;Ensure comment does not appear on patient statement
 .S $P(^PRCA(433,PRCAEN,0),"^",10)=1
 Q
 ; End of RCTCSPD4
