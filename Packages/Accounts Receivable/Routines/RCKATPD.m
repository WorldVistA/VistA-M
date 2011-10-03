RCKATPD ;ALB/CPM/TJK - ADJUST ACCOUNTS FOR KATRINA VETS (CON'T) - 03-MAR-06
 ;;4.5;Accounts Receivable;**241**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
EN(ACCT,BUCKET,RCMSG) ; Entry point to credit an account for a Katrina vet
 ;  Input:    ACCT  --  value of .01 field for debtor in file 340
 ;          BUCKET  --  Amount to credit the account
 ;           RCMSG  --  Bill or transaction comment
 ;
 N DFN,RCDEBTDA,RCCOM
 S DFN=+ACCT,RCDEBTDA=$$DEBT^RCEVUTL(ACCT)
 I 'DFN!($G(^DPT(DFN,0))="") Q
 K ^TMP($J)
 N BILL,B0,OLDBAL,PREPAY,TRAN,TDATE,T0,T1,TRAMT,X,TTYPE,STATUS,BN7
 N DECAMT,EXTOT,I,PRCAEN,DIC,DIE,DA,DR,MSG,PERROR,NBILL,NTRAN,MSGCNTS,ERR
 S PREPAY=$O(^PRCA(430.2,"B","PREPAYMENT",0)),RCCOM(1)=RCMSG
 F STATUS=16,42 S BILL=0 F  S BILL=$O(^PRCA(430,"AS",RCDEBTDA,STATUS,BILL)) Q:'BILL!'BUCKET  D PROC,APPLY:OLDBAL
 D REFUND:BUCKET
 S ERR=$G(PERROR) K ^TMP($J)
 Q
 ;
PROC ; Determine the bill's balance
 S B0=$G(^PRCA(430,BILL,0)),BN7=$G(^(7))
 S OLDBAL=0 F I=1:1:5 S OLDBAL=OLDBAL+$P(BN7,U,I)
 Q
 ;
APPLY ; Exempt interest and decrease a bill
 S EXTOT=0 F I=2:1:5 S EXTOT=EXTOT+$P(BN7,U,I)
 ;
 ; - interest balance is zero - do a decrease
 G DEC:'EXTOT
 ;
 S TRAMT=0 S:EXTOT'<BUCKET EXTOT=BUCKET
INT F I=5:-1:2 Q:'EXTOT  I $P(BN7,U,I) D
 .S X=$P(BN7,U,I),DECAMT=$S(X>BUCKET:BUCKET,1:X)
 .S $P(BN7,U,I)=$P(BN7,U,I)-DECAMT,BUCKET=BUCKET-DECAMT
 .S EXTOT=EXTOT-DECAMT,TRAMT=TRAMT+DECAMT
 S OLDBAL=OLDBAL-TRAMT
 ;
 ; - create exemption transaction
 D SETTR^PRCAUTL
 S TTYPE=14,DIE="^PRCA(433,",DA=PRCAEN
 S DR=".03////"_BILL_";11////"_DT_";12////"_TTYPE_";15///"_TRAMT_";41///"_RCMSG_";89///1;4///2"
 S DIC=DIE D ^DIE
 K DA,DIC,DIE,DR,TRAMT
 ;
 ; - update the balance of the bill
 S $P(^PRCA(430,BILL,7),U,2,5)=$P(BN7,U,2)_U_$P(BN7,U,3)_U_$P(BN7,U,4)_U_$P(BN7,U,5)
 ;
 ; - if the bill was decreased by its entire balance, set the
 ;   bill status to Cancellation
 I 'OLDBAL D CHGSTAT^RCBEUBIL(BILL,39),ADDCOMM^RCBEUBIL(BILL,.RCCOM) Q
 ;
 ; - no need for decrease if the amount to credit the account is zero
 Q:'BUCKET
 ;
DEC ; - create a decrease adjustment
 S PRCAEN=0,DECAMT=BUCKET
 D DEC^PRCASER1(BILL,.DECAMT,DUZ,RCMSG,"",.PRCAEN)
 S BUCKET=DECAMT
 Q
 ;
 ;
REFUND ; Create a prepayment in an Open status
 S PERROR="" D EN^PRCAPAY3(DFN_";DPT(",BUCKET,DT,DUZ,"","","",.PERROR)
 Q:PERROR]""
 ;
 ; - find the Open prepayment just increased to add a comment
 S NBILL=0 F  S NBILL=$O(^PRCA(430,"AS",RCDEBTDA,$O(^PRCA(430.3,"AC",112,0)),NBILL)) Q:'NBILL  I $P(^PRCA(430,NBILL,0),U,2)=PREPAY Q
 I NBILL D ADDCOMM^RCBEUBIL(NBILL,.RCCOM)
 Q
