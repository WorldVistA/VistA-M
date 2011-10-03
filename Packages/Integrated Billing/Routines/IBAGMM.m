IBAGMM ;WOIFO/AAT-GMT MONTHLY TOTALS REPORT;30-JUL-02
 ;;2.0;INTEGRATED BILLING;**183**;21-MAR-94
 ;; Per VHA Directive 10-93-142, this routine should not be modified
 ;
 N IBQUIT
 F  S IBQUIT=0 D  Q:IBQUIT
 . N IBBDT,IBEDT,%DT,X,Y,DIC
 . W !
 . D DATE I IBBDT<0 S IBQUIT=1 Q
 . D ASKDEV ;Choose device and run/schedule printing
 . S IBQUIT=1 ;Probably the report will not be printed repeatedly
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS,POP
 S %ZIS="QM"
 W ! D ^%ZIS Q:POP  ; Quit and ask for patient again. Otherwise Set IBSTOP=1
 ; If it was queued
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT^IBAGMM1 ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT^IBAGMM1",ZTDESC="IB GMT MONTHLY TOTALS REPORT"
 F IBVAR="IBBDT","IBEDT" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"This request has been queued.  The task number is "_ZTSK_"."
 E  W !!,"Unable to queue this job."
 K IO("Q")
 D HOME^%ZIS W !
 Q
 ;
 ;
 ; Ask begin/end dates, with default values
 ; Input:  none
 ; Output: IBBDT,IBEDT - begin/end dates
DATE N %DT,Y,IBNOW
 S IBNOW=$$NOW()
DATAGN ;Loop entry point
 S (IBBDT,IBEDT)=-1
 ; Get beginning date
 S IBBDT=$$ASKDT("Start with DATE: ",$$FIRST(IBNOW))
 I IBBDT<1 Q
 I IBBDT'=$$FIRST(IBBDT) W !!,"Warning! The Start date is not the first day of the month.",!
 ; Get ending date
 S IBEDT=$$ASKDT("Go to DATE: ",$$LAST(IBNOW))
 I IBEDT<1 S IBBDT=-1 Q  ;User cancelled
 I IBEDT<IBBDT W !,"Ending date must follow start date!",! G DATAGN
 I IBBDT<$$GMTEFD^IBAGMT() W !!,"Warning! The Start date is earlier than the GMT Effective Date - ",$$DAT^IBAGMM1($$GMTEFD^IBAGMT)
 I IBEDT'=$$LAST(IBEDT) W !!,"Warning! The Ending date is not the last day of the month."
 Q
 ;
 ;Define the first day of the given month
FIRST(IBDT) S $E(IBDT,6,7)="01"
 Q IBDT
 ;
 ;Define the last day of the given month
LAST(IBDT) N IBM,IBY,X1,X2,X
 S IBY=$E(IBDT,1,3),IBM=+$E(IBDT,4,5)
 S IBM=IBM+1 I IBM>12 S IBM=1,IBY=IBY+1
 I $L(IBM)<2 S IBM="0"_IBM
 S X1=IBY_IBM_"01",X2=-1
 D C^%DTC
 Q X
 ;       
 ;Returns today's date in FM format
NOW() N %,%H,%I,X
 D NOW^%DTC
 Q X
 ;
 ; Input: prompt, default value (FM format)
 ; Output: date (FM) or -1, if cancelled
ASKDT(IBPRMT,IBDFLT) ;Date input
 N DIR,Y,Y0,X,DIROUT,DIRUT
 I $G(IBPRMT)'="" S DIR("A")=IBPRMT
 I $G(IBDFLT)'="" S DIR("B")=$$FMTE^XLFDT(IBDFLT,"1D")
 S DIR(0)="DA"
 D ^DIR I $D(DIRUT) Q -1
 W " (",$$FMTE^XLFDT(Y),")"
 Q Y
