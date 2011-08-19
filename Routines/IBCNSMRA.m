IBCNSMRA ;ALB/AAS - MEDICARE BILLS ; 02-SEPT-97
 ;;2.0; INTEGRATED BILLING ;**92**; 21-MAR-94
 ;
RPRT ; -- Create list of all bills for an insurance company
 ;    by year, by inpatient/outpatient, by w/wo procs and dia, 
 ;    by IB Status, by leaving and dead patients.
 ;
 ;    store in ^tmp("ib-mra",$j, ins co, calendar year of care, inpt/opt,
 ;                  w/wo proc and diag, ar status, ib status, 
 ;                  leaving/dead,entry in 399) := bill no ^ dfn ^
 ;
 ; -- cnt      := no. bills checked
 ;    ;cnt("a") := no. patients alive ; Not used per group
 ;    cnt("b") := no. bills with both procedure and diagnosis
 ;    cnt("c") := no. bills canceled before completion
 ;    cnt("d") := no. bills w/ diagnosis
 ;    cnt("f") := no. bills never printed
 ;    cnt("p") := no. bills w/ procedures
 ;    cnt("m") := no. bills meeting criteria
 ;    cnt("n") := no. bills w/ no diag no proc (neither)
 ;    cnt("r") := no. bills w/ rate type not billable to medicare
 ;    cnt("t") := no. bills w/ bill class. (type of bill) = 2 or 4
 ;    cnt("w") := no. bills who's responsible not = "i"
 ;    cnt("x") := no. bills for RX
 ;    cnt("z") := no. bills for prosthetics
 ;    cnt( ,0) := total dollar amount of bills
 ;    cnt( ,1) := no. bills with paid principal
 ;    cnt( ,2) := Total dollar amount of payments received
 ;    cnt(m,4) := no. bills meeting criteria and referred to dc
 ;    cnt(m,5) := Total $$ of bills criteria and referred to dc
 ;    cnt(m,6) := no. bills meeting criteria with $$ and referred to dc
 ;    cnt(m,7) := Total payment $$ bills meeting criteria and refer to dc
 ;    cnt(3,   := insurance company specific data, follows above format
 ;    cnt("in" := totals for inpatients
 ;    cnt("op" := totals for outpatients
 ;
 D HOME^%ZIS
 I '$D(DT) D DT^DICRW
 S IBQUIT=0
 ;
 W !!,"Build statistics on Insurance Companies that are withholding Medicare",!,"Supplemental Policy Payments.",!!
 ;
 I '$O(^IBE(350.9,1,99,0)) W !!,"You must enter the list of Insurance Companies Withholding Supplimental Payments first",!! D BLD1^IBCNSMRE
 I '$O(^IBE(350.9,1,99,0)) G END
 ;
 D ASKRPRT I IBQUIT G END
 D ASKPRNT I IBQUIT G END
 I IBPRNT="N",IBSNDRPT=0 W !!,"You didn't select anything to do!  Try again.",!! G END
 ;
QUE ; -- que compilation to run
 I IBPRNT="N",IBSNDRPT D  G Q
 .W !!,"This will automatically be tasked to run.  A mail message containing",!,"the data will be sent to you.",!
 .S ZTIO="",IO("Q")=1
 ;
Q I $D(IO("Q")) D
 .S ZTDESC="IB-Compile MRA statistics",ZTRTN="DQ^IBCNSMR",ZTSAVE("IB*")=""
 .D ^%ZTLOAD
 I '$D(ZTSK) D DQ^IBCNSMR
 K ZTSK,ZTIO,ZTDESC,ZTRTN,ZTSAVE,IO("Q")
 G END
 Q
 ;
END ; -- end of program
 K ^TMP("IB-MRA",$J),^TMP("IB-MRA-CNT",$J)
 I $D(ZTQUEUED),'IBQUIT S ZTREQ="@"
 Q:$D(ZTQUEUED)
 K C,I,J,POP,X,Y,ZTSK,ZTSAVE,ZTDESC,ZTRTN,IBPRNT,IBSNDRPT,IBQUIT
 D ^%ZISC
 Q
 ;
ASKPRNT ; -- should a report be printed, summary, detail, none
 N %ZIS,DIR,DIRUT,DUOUT,DTOUT,X,Y
 W !
 S DIR("A")="Print Report, [S]ummary, [D]etail, [None]: "
 S DIR("?")="Select whether you want to print a summary report, a detail report, or No report.  A detail report will list every claim.  No report will automatically send data for national rollup."
 S DIR(0)="SMA^S:Summary;D:Detail;N:None"
 S DIR("B")="Summary"
 D ^DIR
 S IBPRNT=Y
 I $D(DIRUT) S IBQUIT=1 Q
 I IBPRNT'="N" D
 .S %ZIS="QM" D ^%ZIS I POP S IBQUIT=1
 Q
 ;
ASKRPRT ; -- should a report be sent to the ISC
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR("A")="Send Data for National Rollup"
 S DIR("?")="Answer 'Yes' if you wish to send a report for national rollup purposes or answer 'No' if you just want to print a report."
 S DIR(0)="Y"
 S DIR("B")="NO"
 D ^DIR
 I $D(DIRUT) S IBQUIT=1
 S IBSNDRPT=Y
 Q
