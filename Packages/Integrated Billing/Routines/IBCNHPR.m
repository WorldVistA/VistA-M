IBCNHPR ;ALB/CJS - HPID ADDED TO BILLING CLAIM REPORT (DRIVER) ;15-DEC-14
 ;;2.0;INTEGRATED BILLING;**525**;21-MAR-94;Build 105
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Describe report 
 N I,IBBEG,IBEND,IBOUT
 W !!?5,"This report will generate a list of HPID numbers that have been added",!?5,"directly to claims."
 W !!?5,"Please select the date range within which the HPIDs were entered."
 ;
 ; Prompt user to select date range
 ;
 ; Output from user selections:
 ;
 ; IBBEG -- beginning date of report
 ; IBEND -- ending date of report
 ; IBOUT -- (E)xcel or (R)eport output
 ;
 S IBBEG=$$DATES("Beginning") G:'IBBEG ENQ
 S IBEND=$$DATES("Ending",IBBEG) G:'IBEND ENQ
 S IBOUT=$$OUT() G:IBOUT="" ENQ  W !!
 ;
DEVICE ; Ask user to select device
 N %ZIS,POP,ZTDESC,ZTRTN,ZTSAVE,ZTQUEUED,ZTREQ
 ;
 W:$G(IBOUT)="R" !!,"*** You will need a 132 column printer for this report. ***",!
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="EN^IBCNHPR1",ZTDESC="IB - HPID ADDED TO BILLING CLAIM REPORT"
 .F I="^TMP(""IBHPID"",$J,","IBBEG","IBEND","IBOUT" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q") D HOME^%ZIS
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK,IO("Q")
 ;
 ; Compile and print report
 ;
 U IO D EN^IBCNHPR1
 ;
ENQ K DIRUT,DIROUT,DUOUT,DTOUT,I,IBBEG,IBEND,IBOUT
 Q
 ;
DATES(LABEL,IBBEG) ;
 N DIR,X,Y,DIRUT,DUOUT,I,IBARR,IBX,IBB,IBD
 S IBX=""
 I '+$G(IBBEG) D
 .F I="E","F","G" S IBARR(+$O(^DGCR(399,I,0)))=""
 .S IBB=+$O(IBARR(0))
 S IBB=$P($S(+$G(IBBEG):IBBEG,+$G(IBB):IBB,1:+$O(^DGCR(399,"APD",0))),"."),IBD=$S(+$G(IBBEG):DT,1:IBB)
 S DIR("?")="Enter the "_LABEL_" date to include in the report."
 S DIR("?",1)="Enter a date from the date of the first Bill/Claim HPID entry to today."
 S DIR("A")=LABEL_" Date",DIR("B")=$$FMTE^XLFDT(IBD)
 S DIR(0)="DO^"_IBB_":"_DT_":EX" D ^DIR S IBX=Y I $D(DIRUT)!$D(DUOUT) S IBX=""
 Q IBX
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q Y
