RCRPRPU ;EDE/YMG - REPAYMENT PLAN REPORT UTILITIES; 11/23/2020
 ;;4.5;Accounts Receivable;**377**;Mar 20, 1995;Build 45
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
DASH(LEN) ; print line of dashes
 N DASH
 S $P(DASH,"-",LEN+1)="" W DASH
 Q
 ;
PAUSE ; display "press return to continue" prompt
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="EA"
 S DIR("A")="Press <return> to continue "
 D ^DIR
 Q
 ;
ASKEXCEL() ; display "export to excel" prompt
 ;
 ; returns 1 for Yes, 0 for No, -1 for user exit / timeout
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="Y",DIR("B")="YES"
 S DIR("A")="Export to Excel (Y/N)"
 D ^DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(Y>0:1,1:0)
 ;
BALANCE(BILL) ; calculate total balance for the given bill
 ;
 ; BILL - file 430 ien
 ;
 ; returns sum of fields 430/71, 430/72, 430/73, 430/74, and 430/75
 ;
 N DATA,RES,Z
 S RES=0
 I BILL>0 D
 .S DATA=$P($G(^PRCA(430,BILL,7)),U,1,5)
 .I DATA'="" F Z=1:1:5 S RES=RES+$P(DATA,U,Z)
 .Q
 Q RES
