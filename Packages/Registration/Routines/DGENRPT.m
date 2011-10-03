DGENRPT ;ALB/DW - Enrollment Group Threshold Impact Reports ; 5 MAY 1999
 ;;5.3;Registration;**232**;Aug 13,1993
 ;
 ;
 N RPAP,RPDS,DIR,X,Y
 S (RPAP,RPDS)=""
 ;ASK USER TO SELECT ACTUAL OR PRELIMINARY REPORT.
 S DIR(0)="F^1:11^D CHK1^DGENRPT"
 S DIR("A")="Select Actual or Preliminary"
 S DIR("?")="Enter ""A"" or ""ACTUAL"" to select EGT actual impact report, or ""P"" or ""PRELIMINARY"" to select EGT preliminary impact report."
 D ^DIR
 I X="^" Q
 I $D(DTOUT) W *7 Q
 S RPAP=$E(X,1)
 ;ASK USER TO SELECT DETAIL OR SUMMARY REPORT.
 S DIR(0)="F^1:7^D CHK2^DGENRPT"
 S DIR("A")="Select Detail or Summary"
 S DIR("?")="Enter ""D"" or ""DETAIL"" to select EGT detail impact report, or ""S"" or ""SUMMARY"" to select EGT summary impact report."
 D ^DIR
 I X="^" Q
 I $D(DTOUT) W *7 Q
 S RPDS=$E(X,1)
 ;DECIDE THE NEXT STEP ACCORDING TO USER INPUTS.
 I RPAP="P"&(RPDS="S") D ^DGENRPT1 Q
 I RPAP="P"&(RPDS="D") D ^DGENRPT2 Q
 I RPAP="A"&(RPDS="S") D ^DGENRPT3 Q
 I RPAP="A"&(RPDS="D") D ^DGENRPT4 Q
 Q
 ;
CHK1 ;CHECK USER INPUT.
 S X=$E(X,1)
 I X'="A",(X'="P") K X
 Q
 ;
CHK2 ;CHECK USER INPUT.
 S X=$E(X,1)
 I X'="D",(X'="S") K X
 Q
