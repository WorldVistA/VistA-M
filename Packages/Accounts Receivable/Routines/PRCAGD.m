PRCAGD ;WASH-ISC@ALTOONA,PA/CMS-Balance Discrepancy Message ;8/11/93  10:08 AM
V ;;4.5;Accounts Receivable;;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;SEND (DEBTOR,BILL BALANCE,TRAN BAL,PREV BAL,REPRINT FLAG)
EN(DEB,BBAL,TBAL,PBAL,BEG,REP) ;balance discrepancy, transmit mailman message
 N NAM,SSN,XMSUB,XMDUZ,XMTEXT,XMY,X1,X,Y
 S NAM=$$NAM^RCFN01(DEB),SSN=$$SSN^RCFN01(DEB),XMSUB=$E(NAM,1,16)_" ("_$E(NAM)_$E(SSN,6,9)_") Statement Balance Discrepancy",XMDUZ="AR Package",XMTEXT="X1("
 I $D(^XMB(3.8,"B","PRCA ERROR")) S XMY("G.PRCA ERROR")=""
 S Y=DT X ^DD("DD")
 S X1(1)="***** NOTICE: Patient: "_NAM_"   SSN: "_SSN_"   statement was not",X1(2)="generated on "_Y_" because of a discrepancy in the account balances"
 S X1(3)="between the patient statement balance and the Accounts Receivable balance.",X1(4)=""
 S X1(5)="Accounts Receivable (bills) has a balance of:         $ "_$J(BBAL,10,2)
 S X1(6)="Patient Statement (*amount due) has a balance of:     $ "_$J((TBAL+PBAL),10,2)
 S X1(7)="The difference between these two balances is:         $ "_$J((BBAL-(TBAL+PBAL)),10,2),X1(8)=""
 S Y=BEG X ^DD("DD") S X1(9)="*Previous Statement balance  $ "_$J(PBAL,0,2)_$S(Y'=0:"(all activity through "_Y_")",1:"")
 S X1(10)="         + New Transactions  $ "_$J(TBAL,0,2),X1(11)=""
 S X1(12)="",X1(13)="PLEASE REVIEW ACCOUNT, CORRECT THE DISCREPANCY AND PRINT THE PATIENT'S STATEMENT"
 S:$G(REP) X1(14)="",X1(15)="*** ERROR OCCURRED FROM USING THE PRINT PATIENT ***",X1(17)="*** STATEMENT/LETTERS OPTION                    ***"
 S:'$D(XMY) XMY(.5)="" D ^XMD
 Q
REF(DEB,BN,REP) ;Print discrepancy because of unprocessed refund
 N NAM,SSN,XMSUB,XMDUZ,XMTEXT,XMY,X1,X,Y
 S NAM=$$NAM^RCFN01(DEB),SSN=$$SSN^RCFN01(DEB),XMSUB=$E(NAM,1,16)_" ("_$E(NAM)_$E(SSN,6,9)_") Statement Refund Discrepancy",XMDUZ="AR Package",XMTEXT="X1("
 I $D(^XMB(3.8,"B","PRCA ERROR")) S XMY("G.PRCA ERROR")=""
 S X1(1)="***** NOTICE: Patient: "_NAM_"    SSN: "_SSN_"   statement did not"
 S Y=DT X ^DD("DD")
 S X1(2)="print on "_Y_" because the unprocessed prepayment bill "_$P(^PRCA(430,BN,0),U,1)
 S X1(3)="is in the status "_$P(^PRCA(430.3,$P(^PRCA(430,BN,0),U,8),0),U,1)_"!"
 S X1(4)=" "
 S X1(5)="Please complete the process of the prepayment bill then print the statement"
 S X1(6)="using the Print Statements/Letters by Date option."
 S:$G(REP) X1(7)="",X1(8)="*** ERROR OCCURRED FROM USING THE PRINT PATIENT ***",X1(9)="*** STATEMENT/LETTERS OPTION                    ***"
 S:'$D(XMY) XMY(.5)="" D ^XMD
 Q
