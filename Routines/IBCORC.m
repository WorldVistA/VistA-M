IBCORC ;ALB/CPM - RANK INSURANCE CARRIERS ; 30-JUN-93
 ;;Version 2.0 ; INTEGRATED BILLING ;**29**; 21-MAR-94
 ;
EN ; Entry point to generate ranking of insurance carriers by amount billed
 ;
 W !!?6,"This report will generate a list of insurance carriers ranked by"
 W !?6,"the total amount billed.  Please note that you may no longer opt"
 W !?6,"to transmit this report to the MCCR Program Office in VACO using"
 W !?6,"this option."
 W !!?6,"You must select a date range in which bills to be used in the"
 W !?6,"totals will be selected."
 ;
START W ! S DIR(0)="DA^2860101:NOW:EX",DIR("A")="Enter Start Date on Bill Search: ",DIR("?")="^D HLPD1^IBCORC"
 D ^DIR K DIR S IBABEG=+Y G:'Y ENQ
 ;
END W ! S DIR(0)="DA^"_+Y_":NOW:EX",DIR("A")="Enter End Date on Bill Search: ",DIR("B")=$$DAT2^IBOUTL(DT),DIR("?")="^D HLPD2^IBCORC"
 D ^DIR K DIR S IBAEND=+Y G:'Y ENQ
 ;
NUM W ! S DIR("A")="Enter number of insurance carriers to rank: ",DIR(0)="NA^1:1000:0",DIR("B")=30,DIR("?")="^D HLPN^IBCORC"
 D ^DIR K DIR S IBNR=+Y G:'Y ENQ
 ;
 ; Allow report transmittal if running in Production.
 S IBFLG=0 ; G:'$$PROD DEVICE
 ;
 ;W ! S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like this report sent to the MCCR Program Office",DIR("?")="^D HLPCO^IBCORC"
 ;D ^DIR K DIR S IBFLG=+Y I $D(DIRUT)!($D(DUOUT)) G ENQ
 ;
DEVICE ; Select device for queueing/printing report
 S %ZIS="QM" D ^%ZIS G:POP ENQ
 I $D(IO("Q")) D  G ENQ
 .S ZTRTN="DQ^IBCORC1",ZTDESC="RANK INSURANCE CARRIERS"
 .F I="IBABEG","IBAEND","IBFLG","IBNR" S ZTSAVE(I)=""
 .D ^%ZTLOAD K IO("Q")
 .W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 .K ZTSK
 U IO
 D DQ^IBCORC1
 ;
ENQ ; Cleanup
 K I,IBABEG,IBAEND,IBFLG,IBNR
 Q
 ;
 ;
PROD() ; Is this the production account?     Output:  1 - YES,  0 - NO
 N X S X=$G(^XMB("NETNAME"))
 Q $L(X,".")=3!($L(X,".")=4&(X[".MED."))
 ;
HLPD1 ; Help for Start date.
 W !!,"This report uses the date the bill was first printed to determine if the"
 W !,"bill should be included in the accumulative total."
 W !!,"Please enter the lower date range for the first printed date, which"
 W !,"should be a past date on or after 10/1/86, or '^' to exit."
 Q
 ;
HLPD2 ; Help for End date.
 W !!,"This report uses the date the bill was first printed to determine if the"
 W !,"bill should be included in the accumulative total."
 W !!,"Please enter the upper date range for the first printed date, which"
 W !,"should be a past date on or after ",$$DAT1^IBOUTL(IBABEG),", or '^' to exit."
 Q
 ;
HLPN ; Help for number of carriers to rank.
 W !!,"This report will rank any number of insurance carriers (from 1 to 1000)"
 W !,"for the total amount billed within a date range."
 W !!,"Please enter a number between 1 and 1000, or '^' to exit."
 Q
HLPCO ; Help for sending report to Central Office.
 W !!,"After the new fiscal year begins, this report should be generated for the"
 W !,"previous fiscal year and transmitted to the MCCR Program Office.  The data"
 W !,"will be compiled nationally to determine which insurance carriers are the"
 W !,"largest customers of VA.  The compiled data will assist the Program Office"
 W !,"in planning for future electronic billing systems."
 W !!,"Even if you are planning to transmit a report to the Program Office, you"
 W !,"should run this report once without transmitting to check the results."
 W !,"You may then re-run the report and transmit it centrally."
 Q
