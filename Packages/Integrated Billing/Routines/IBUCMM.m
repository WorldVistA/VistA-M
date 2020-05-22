IBUCMM ;WOIFO/AAT-IBUC VISIT SUMMARY/DETAIL REPORT;30-JUL-02
 ;;2.0;INTEGRATED BILLING;**663,671**;21-MAR-94;Build 13
 ;; Per VHA Directive 6402, this routine should not be modified
 ;
 N IBQUIT,IBSD,IBCA,IBEXCEL
 N IBBDT,IBEDT,%DT,X,Y,DIC
 F  S IBQUIT=0 D  Q:IBQUIT
 . W !
 . D DATE I IBBDT<0 S IBQUIT=1 Q
 . ;
 . W !!   ;Add a couple of lines of spacer before the next set of prompts
 . ; Ask the user if they want a detailed or summary version of the report
 . S IBSD=$$GETPRMPT("SD") I IBSD=-1 S IBQUIT=1 Q
 . ;
 . ; Ask the user if they want to report on visits at their site only or all sites
 . S IBCA=$$GETPRMPT("CA") I IBCA=-1 S IBQUIT=1 Q
 . ;
 . S IBEXCEL=$$GETEXCEL I IBEXCEL=-1 S IBQUIT=1 Q
 . I IBEXCEL D PRTEXCEL
 . D ASKDEV ;Choose device and run/schedule printing
 . S IBQUIT=1 ;Probably the report will not be printed repeatedly
 Q
 ;
ASKDEV ; Ask about output device and print the report (or run task)
 N %ZIS,POP
 W:'IBEXCEL !!,"Report requires 132 columns.",!
 S %ZIS="QM"
 W ! D ^%ZIS Q:POP  ; Quit and ask for patient again. Otherwise Set IBSTOP=1
 ; If it was queued
 I $D(IO("Q")) D RUNTASK Q
 U IO D REPORT^IBUCMM1 ; Generate report directly
 D ^%ZISC ; Close the device
 Q
 ;
 ;
RUNTASK ; Start Taskman job
 N ZTRTN,ZTSK,IBVAR,ZTSAVE,ZTDESC
 S ZTRTN="REPORT^IBUCMM1",ZTDESC="IB Urgent Care Visit Summary/Detail Report"
 F IBVAR="IBBDT","IBEDT","IBSD","IBCA","IBEXCEL" S ZTSAVE(IBVAR)=""
 D ^%ZTLOAD
 I $G(ZTSK) W !!,"This request has been queued.  The task number is "_ZTSK_"."
 E  W !!,"Unable to queue this job."
 K IO("Q")
 D HOME^%ZIS W !
 Q
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
 ; Get ending date
 S IBEDT=$$ASKDT("Go to DATE: ",$$LAST(IBNOW))
 I IBEDT<1 S IBBDT=-1 Q  ;User cancelled
 I IBEDT<IBBDT W !,"Ending date must follow start date!",! G DATAGN
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
 ;
 ;Ask the user some questions about what to report
GETPRMPT(IBPRMPT) ;
 ;
 ;RCMNFLG - Ask to print the Main report (Detailed) report.  0=No, 1=Yes
 N X,Y,DTOUT,DUOUT,DIR,DIROUT,DIRUT
 ;
 ; Prompt Summary or Detail version
 I $G(IBPRMPT)="SD" D
 . S DIR("A")="(S)ummary or (D)etailed Report: "
 . S DIR("B")="S"
 . S DIR(0)="SA^S:SUMMARY;D:DETAILED"
 . S DIR("?")="Select the type of report to Generate."
 ;
 ; Prompt Current or All Sites
 I $G(IBPRMPT)="CA" D
 . S DIR("A")="(C)urrent or (A)ll Sites: "
 . S DIR(0)="SA^C:CURRENT;A:ALL SITES"
 . S DIR("B")="A"
 . S DIR("?")="Select C to run for your site only, otherwise, select A to report on all sites with Urgent Care visits Tracked at this site."
 ;
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!($G(Y)="")  Q -1
 Q Y
 ;
 ;
GETEXCEL() ; Export the report to MS Excel?
 ; Function return values:
 ;   0 - User selected "No" at prompt.
 ;   1 - User selected "Yes" at prompt.
 ;   ^ - User aborted.
 ; This function allows the user to indicate whether the report should be
 ; printed in a format that could easily be imported into an Excel
 ; spreadsheet.  If the user wants to print in EXCEL format, the variable 
 ; IBEXCEL will be set to '1', otherwise IBEXCEL will be set to '0' for "No" 
 ; or "^" to abort.
 ;
 N DIR,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export the report to Microsoft Excel (Y/N)"
 I $G(IBEXCEL)=1 S DIR("B")="YES"
 E  S DIR("B")="NO"
 S DIR("?",1)="If you want to capture the output from this report in a format that"
 S DIR("?",2)="could easily be imported into an Excel spreadsheet, then answer YES here."
 S DIR("?")="If you want a normal report output, then answer NO here."
 W !
 D ^DIR
 K DIR
 I $D(DIRUT) Q -1 ; Abort
 Q +Y
 ;
PRTEXCEL() ;Print the MS Excel instructions.
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data and save the detail report data in a text file"
 W !?5,"to a local drive. This report may take a while to run."
 W !!?5,"Note: To avoid undesired wrapping of the data saved to the file,"
 W !?11,"please enter '0;256;99999' at the 'DEVICE:' prompt.",!
 Q
