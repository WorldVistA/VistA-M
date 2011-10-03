RCCPCBAK ;WASHISC/ALTOONA-AR UTILITY ROUTINE ;11/19/96  10:26 AM
 ;;4.5;Accounts Receivable;**34**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;check background job
 N L,X,XMSUB,XMTEXT,XMY
 I $P(^RC(342,1,0),"^",10)<DT D
 .S XMSUB="WARNING!! AR PACKAGE NOT UPDATED -PRCA NIGHTLY PROCESS PROBLEM"
 .S XMY("G.PRCA ERROR")=""
 .S XMY("G.RCCPC STATEMENTS")=""
 .S XMDUZ="AR PACKAGE"
 .S XMTEXT="L("
 .S L(1)=" "
 .S L(2)="WARNING!! The AR Package was last updated on: "_$$SLH^RCFN01($P(^RC(342,1,0),"^",10))
 .S L(3)=" "
 .S L(4)=" "
 .S X=$G(^RC("PRCABJ")) S L(6)="The PRCA NIGHTLY PROCESS seems to have stopped while processing: "
 .S L(7)=" "
 .S L(8)="      "_$S(X:$P($T(@X),";;",2),1:"No processes started.")
 .S L(9)=" "
 .I X<20 S L(10)="This will also affect the following processes: " D
 ..S L(11)=" "
 ..F X=X+1:1:20 S L(X+11)="   "_$P($T(@X),";;",2)_" - NOT COMPLETED"
 .S L(X+30)=" "
 .S L(X+31)="If any process is trying to use a printer, please check the printer."
 .S L(X+32)=" "
 .S L(X+33)="Please start the PRCA NIGHTLY PROCESS"
 .S L(X+34)="with the 'One-time Option Queue' taskmanager option."
 .D ^XMD
 Q
 ;
1 ;;Interest and admin charges being assessed
2 ;;CCPC STATEMENTS build or transmission
3 ;;NON-PATIENT statement dates for billing cycle
4 ;;RECEIPT CHECK for fiscal integrity of deposits
5 ;;IRS MASTER CODE SHEETS (IF APPLICABLE)
6 ;;IRS WEEKLY CODE SHEETS (IF DAY OF THE WEEK)
7 ;;PRE-IRS CHECK (IF APPLICABLE)
8 ;;Purging of event file
9 ;;Validation of bill numbering
10 ;;Validation of event numbers
11 ;;Deposit Management validation
12 ;;FMS document maintenance
13 ;;OBR scheduled
14 ;;National database totals compilation (if applicable)
15 ;;Printing of UB or HCFA forms
16 ;;Printing of non-patient follow-up letters
17 ;;Printing IRS letters (if applicable)
18 ;;Printing of Unprocessed Document List for AR FMS documents
19 ;;Follow-up list
20 ;;Comment log list
