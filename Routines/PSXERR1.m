PSXERR1 ;BIR/WPB-Continuation of Error Processing Utility ; [ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
ERRMSG ;sends an alert and mail message if a user tries to retransmit a batch
 ;that has been retransmitted once.
 S XQAMSG="Batch "_OLDBAT_" can't be retransmitted again. Contact the IRM for help." D GRP1^PSXNOTE,SETUP^XQALERT
 S XMSUB=("RETRANSMISSION ERROR"),XMDUZ=DUZ,LNCT=5
 D XMZ^XMA2
 G:XMZ'>0 EXIT
 S ^XMB(3.9,XMZ,2,1,0)="Batch # "_OLDBAT_" has been retransmitted once."
 S ^XMB(3.9,XMZ,2,2,0)="There is either a system problem or there is a problem with the data in the"
 S ^XMB(3.9,XMZ,2,3,0)="batch.  Please contact your local IRM for assistance in determining and"
 S ^XMB(3.9,XMZ,2,4,0)="correcting the problem.  Once the problem has been corrected the IRM can"
 S ^XMB(3.9,XMZ,2,5,0)="reset the batch and allow you to retransmit."
 S ^XMB(3.9,XMZ,2,0)="^3.9^"_LNCT_U_LNCT_U_DT,XMDUN="CMOP Manager"
 K XMY S XMDUZ=DUZ
 D GRP^PSXNOTE,ENT1^XMD
 G EXIT^PSXRTRAN
ER3 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=""
 Q
ER5 S PSXCT=PSXCT+1,ERRTXT(PSXCT)=""
 Q
ER6 S PSXCT=11
ER4 S PSXCT=11
EXIT K ERRTXT,LNCT,OLDBAT,XMDUN,XMDUZ,XMSUB,XMZ,XQA,XQAMSG,PSXCT
 Q
