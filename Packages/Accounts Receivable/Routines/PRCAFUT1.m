PRCAFUT1 ;WASH-ISC@ALTOONA/CLH-FMS Utilities ;10/8/96  11:35 AM
V ;;4.5;Accounts Receivable;**39,78**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Determine beginning/ending budget fiscal year
FY N DIR,X,Y
 S DIR(0)="F^2:2",DIR("B")=$$FY^RCFN01
BEGFY S DIR("A")="Budget FISCAL YEAR"
 D ^DIR
 I $D(DIRUT) S FYERROR=1 G FYOUT
 I Y'?2N W !!,"Enter 2 DIGIT Fiscal Year. i.e. Enter 96 for 1996.",!,*7 G BEGFY
 S BGFY=Y
FYOUT K DIRUT,DIROUT,DTOUT,DUOUT
 Q
 ;
