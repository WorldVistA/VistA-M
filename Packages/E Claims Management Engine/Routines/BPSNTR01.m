BPSNTR01 ; AITC/MRD - NTR-Related Reports; JAN 09, 2020@08:23
 ;;1.0;E CLAIMS MGMT ENGINE;**27**;JUN 2004;Build 15
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
EN ;
 ;
 N BPSCNT,BPSDATE,BPSDATESUB,BPSIEN57
 N BPSQUIT,BPSTOUCH,BPSTYPE,BPSYRMO,DIR,DIRUT
 ;
 ; Display a brief description of the report.
 ;
 W !!,"This report will display a line for each transaction"
 W !,"in the month* specified.  The earliest month possible is"
 W !,"January, 2004."
 W !,"  Note:  The transactions will be displayed according to"
 W !,"  the date last updated, not the date submitted."
 W !
 ;
 ; Prompt user for desired month and year.
 ;
DATE ;
 S DIR(0)="FAO^4:7^K:X'?1.2N1""/""1.2N X"
 S DIR("A")="Enter a month and year (M/YY or MM/YY): "
 S DIR("?")="Example values:  1/18, 01/18, 12/19."
 D ^DIR
 I $G(DIRUT) G QUIT
 S BPSYRMO=$P(X,"/",1)
 I BPSYRMO>12 W !,"Please try again",*7,! G DATE
 I $L(BPSYRMO)<2 S BPSYRMO="0"_BPSYRMO
 S BPSYRMO=3_$P(X,"/",2)_BPSYRMO
 I BPSYRMO<30401 W !,"Please try again",*7,! G DATE
 I $O(^BPSTL("AH",(BPSYRMO_"00")))="" W !,"Please try again",*7,! G DATE
 ;
 W !
 D HEADER
 ;
 S BPSQUIT=0
 S BPSCNT=0
 ;
 ; Initialize the looping variable to be the 0th day of the month
 ; selected by the user.
 ;
 S BPSDATE=BPSYRMO_"00"
 F  S BPSDATE=$O(^BPSTL("AH",BPSDATE)) Q:'BPSDATE  Q:$E(BPSDATE,1,5)>BPSYRMO  D  Q:BPSQUIT
 . S BPSIEN57=0
 . F  S BPSIEN57=$O(^BPSTL("AH",BPSDATE,BPSIEN57)) Q:'BPSIEN57  D  Q:BPSQUIT
 . . ;
 . . ; Skip if non-billable; skip if the Submit Date is earlier than
 . . ; the first day of the selected month.
 . . ;
 . . I $$GET1^DIQ(9002313.57,BPSIEN57,19,"I")="N" Q
 . . I $$GET1^DIQ(9002313.57,BPSIEN57,6,"I")<(BPSYRMO_"01") Q
 . . ;
 . . W !,$$GET1^DIQ(9002313.57,BPSIEN57,1.11,"E")  ; Rx#
 . . W "/",$$GET1^DIQ(9002313.57,BPSIEN57,9,"E")  ; Fill#
 . . ;
 . . W ?11,$$FMTE^XLFDT(BPSDATE,"2D")  ; Date Last Update
 . . S BPSDATESUB=$$GET1^DIQ(9002313.57,BPSIEN57,6,"I")
 . . W ?20,$$FMTE^XLFDT(BPSDATESUB,"2D")  ; Submit Date
 . . ;
 . . W ?29,$$GET1^DIQ(9002313.57,BPSIEN57,1201)  ; RX Action (BWHERE)
 . . ;
 . . S BPSTOUCH=$$TOUCHED^BPSUTIL(BPSIEN57)
 . . W ?34,$S(BPSTOUCH:"Manual",1:"No-Touch")  ; Touched?
 . . ;
 . . S BPSTYPE=$$TYPE(BPSIEN57)
 . . W ?43,$E(BPSTYPE,1,10)  ; Transaction Type
 . . ;
 . . W ?54,$E($$GET1^DIQ(9002313.57,BPSIEN57,5,"E"),1,15)  ; Patient Name
 . . ;
 . . W ?71,BPSIEN57  ; Transaction IEN
 . . ;
 . . S BPSCNT=BPSCNT+1
 . . I BPSCNT#22=0 D
 . . . N DIR,DIRUT
 . . . S DIR(0)="E"
 . . . D ^DIR
 . . . I $G(DIRUT) S BPSQUIT=1 Q
 . . . D HEADER
 . . . Q
 . . Q
 . Q
 ;
 W !
 G DATE
 ;
QUIT ;
 ;
 Q
 ;
HEADER ;
 ;
 W !,"Rx#/Fill",?10,"Last Updt",?20,"SubmitDt",?29,"Actn",?34,"Touched?"
 W ?44,"Type",?54,"Patient",?64,"Transaction IEN"
 ;
 Q
 ;
TALLY ;
 ;
 N BPSDATE,BPSENDDATE,BPSIEN57,BPSSTARTDATE,BPSSUBMIT,BPSTOTALS
 N BPSYRMO,DIR,DIRUT,X,Y
 ;
 S BPSTOTALS=""
 ;
 ; Prompt user for desired year.
 ;
 W !!,"This report will display counts of transactions for"
 W !,"each month in fiscal year specified, with sub-totals"
 W !,"by transaction type and by no-touch vs manual."
 W !
 S DIR(0)="NAO^2008:2036"
 S DIR("A")="Enter a year: "
 D ^DIR
 I $G(DIRUT) Q
 ;
 ; Determine the range of months to be included.  Since we wish to
 ; display a year's worth according to fiscal year, the starting
 ; month will be October of the previous year, and the ending month
 ; will be September of the year selected.
 ;
 S Y=Y-1700
 S BPSSTARTDATE=(Y-1)_10
 S BPSENDDATE=Y_"09"
 ;
 ; Loop through all transactions from the start date to today.  All
 ; transactions with a Submit Date in the fiscal year selected by
 ; the user will be counted.
 ;
 S BPSDATE=BPSSTARTDATE_"00"
 F  S BPSDATE=$O(^BPSTL("AH",BPSDATE)) Q:'BPSDATE  D
 . ;
 . S BPSIEN57=0
 . F  S BPSIEN57=$O(^BPSTL("AH",BPSDATE,BPSIEN57)) Q:'BPSIEN57  D
 . . ;
 . . ; Skip if non-billable.
 . . ;
 . . I $$GET1^DIQ(9002313.57,BPSIEN57,19,"I")="N" Q
 . . ;
 . . ; Skip if Submit Date is not in the selected fiscal year.
 . . ;
 . . S BPSSUBMIT=$$GET1^DIQ(9002313.57,BPSIEN57,6,"I")
 . . S BPSSUBMIT=$E(BPSSUBMIT,1,5)
 . . I BPSSUBMIT<BPSSTARTDATE Q
 . . I BPSSUBMIT>BPSENDDATE Q
 . . ;
 . . ; Add this transaction to the totals.
 . . ;
 . . D COUNT(BPSIEN57,BPSSUBMIT,.BPSTOTALS)
 . . ;
 . . Q
 . Q
 ;
 F BPSYRMO=BPSSTARTDATE:1:BPSENDDATE D
 . I $E(BPSYRMO,4,5)=13 S BPSYRMO=($E(BPSYRMO,1,3)+1)_"01"
 . ;
 . ; Write the results for this month.
 . ;
 . D DISPLAY(BPSYRMO,.BPSTOTALS)
 . ;
 . Q
 ;
 W !
 N DIR
 S DIR(0)="E"
 D ^DIR
 ;
 Q
 ;
COUNT(BPSIEN57,BPSSUBMIT,BPSTOTALS) ; Add one transaction to the totals.
 ;
 ; For the given transactions, this procedure will determine a count of the
 ; number of transactions of each type (payable, rejected, duplicate,
 ; captured, accepted, reversal, eligibility, completed) and manual
 ; vs no-touch.
 ;
 ; Input:
 ;     BPSIEN57 is a pointer to 9002313.57, BPS LOG OF TRANSACTIONS.
 ;     BPSSUBMIT is a year+month portion of the Submit Date for the
 ;         transaction passed in (e.g. 31912 = December 2019).
 ; Output:
 ;     BPSTOTALS is passed by reference.  The format returned is:
 ;         BPSTOTALS(YearMonth) = total transactions for that month
 ;         BPSTOTALS(YearMonth,1,Type) = count for a given type
 ;         BPSTOTALS(YearMonth,1,Type,Touched) = count of
 ;                   transactions with a given type + manual/no-touch
 ;         BPSTOTALS(YearMonth,2,Touched) = count for manual/no-touch
 ;
 N BPSTOUCHED,BPSTYPE
 ;
 S BPSTYPE=$$TYPE(BPSIEN57)
 ;
 S BPSTOUCHED=$$TOUCHED^BPSUTIL(BPSIEN57)
 I BPSTOUCHED=1 S BPSTOUCHED="Manual"
 E  S BPSTOUCHED="No-Touch"
 ;
 S BPSTOTALS(BPSSUBMIT)=$G(BPSTOTALS(BPSSUBMIT))+1
 S BPSTOTALS(BPSSUBMIT,1,BPSTYPE)=$G(BPSTOTALS(BPSSUBMIT,1,BPSTYPE))+1
 S BPSTOTALS(BPSSUBMIT,1,BPSTYPE,BPSTOUCHED)=$G(BPSTOTALS(BPSSUBMIT,1,BPSTYPE,BPSTOUCHED))+1
 S BPSTOTALS(BPSSUBMIT,2,BPSTOUCHED)=$G(BPSTOTALS(BPSSUBMIT,2,BPSTOUCHED))+1
 ;
 Q
 ;
DISPLAY(BPSYRMO,BPSTOTALS) ; Write the results for one month.
 ;
 W !!,$E(BPSYRMO,1,3)+1700,"/",$E(BPSYRMO,4,5)
 W ?11,"Payable",?20,"Rejected",?30,"Duplicate",?41,"Captured",?51,"Reversal",?61,"Unstranded",?73,"Total"
 ;
 W !,"  Manual"
 W ?11,$J(+$G(BPSTOTALS(BPSYRMO,1,"Payable","Manual")),7)
 W ?20,$J(+$G(BPSTOTALS(BPSYRMO,1,"Rejected","Manual")),8)
 W ?30,$J(+$G(BPSTOTALS(BPSYRMO,1,"Duplicate","Manual")),9)
 W ?41,$J(+$G(BPSTOTALS(BPSYRMO,1,"Captured","Manual")),8)
 W ?51,$J(+$G(BPSTOTALS(BPSYRMO,1,"Reversal","Manual")),8)
 W ?61,$J(+$G(BPSTOTALS(BPSYRMO,1,"Unstranded","Manual")),10)
 W ?73,$J(+$G(BPSTOTALS(BPSYRMO,2,"Manual")),5)
 ;
 W !,"No-Touch"
 W ?11,$J(+$G(BPSTOTALS(BPSYRMO,1,"Payable","No-Touch")),7)
 W ?20,$J(+$G(BPSTOTALS(BPSYRMO,1,"Rejected","No-Touch")),8)
 W ?30,$J(+$G(BPSTOTALS(BPSYRMO,1,"Duplicate","No-Touch")),9)
 W ?41,$J(+$G(BPSTOTALS(BPSYRMO,1,"Captured","No-Touch")),8)
 W ?51,$J(+$G(BPSTOTALS(BPSYRMO,1,"Reversal","No-Touch")),8)
 W ?61,$J(+$G(BPSTOTALS(BPSYRMO,1,"Unstranded","No-Touch")),10)
 W ?73,$J(+$G(BPSTOTALS(BPSYRMO,2,"No-Touch")),5)
 ;
 W !,"  Totals"
 W ?11,$J(+$G(BPSTOTALS(BPSYRMO,1,"Payable")),7)
 W ?20,$J(+$G(BPSTOTALS(BPSYRMO,1,"Rejected")),8)
 W ?30,$J(+$G(BPSTOTALS(BPSYRMO,1,"Duplicate")),9)
 W ?41,$J(+$G(BPSTOTALS(BPSYRMO,1,"Captured")),8)
 W ?51,$J(+$G(BPSTOTALS(BPSYRMO,1,"Reversal")),8)
 W ?61,$J(+$G(BPSTOTALS(BPSYRMO,1,"Unstranded")),10)
 W ?73,$J(+$G(BPSTOTALS(BPSYRMO)),5)
 ;
 Q
 ;
TYPE(BPSIEN57) ; Determine the type of this transaction.
 ;
 N BPSSTATUS
 ;
 S BPSSTATUS=$$GET1^DIQ(9002313.57,BPSIEN57,4.0098)
 ;
 I BPSSTATUS="E CAPTURED" Q "Captured"
 I BPSSTATUS="E DUPLICATE" Q "Duplicate"
 I BPSSTATUS="E PAYABLE" Q "Payable"
 I BPSSTATUS="E REJECTED" Q "Rejected"
 I BPSSTATUS["REVERSAL" Q "Reversal"
 I BPSSTATUS="E UNSTRANDED" Q "Unstranded"
 ;
 Q "Other"
 ;
