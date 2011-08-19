SROQ ;B'HAM ISC/ADM - QUARTERLY REPORT ; [ 07/31/00  10:07 AM ]
 ;;3.0; Surgery ;**62,70,95**;24 Jun 93
 ;
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 S (SRSOUT,SRT)=0 W @IOF,!,"QUARTERLY/SUMMARY REPORT FOR SURGICAL SERVICE"
 W !!,"NOTE:  Listed below are the CPT codes for the index procedures on these reports."
 W !!,?4,"Procedure",?30,"CPT Code(s)",!,?4,"---------",?30,"-----------"
 D SHOW^SROQ0A W ! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1 G END
 W @IOF,!,"Run which report ?",!!,?3,"1. Summary Report for Selected Date Range",!,?3,"2. Quarterly Report for Central Office"
SEL W !!,"Select Report Number:  1// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 S:X="" X=1 I X["?"!(X<1)!(X>2) G HELP
 I X=1 G ^SROQ2
 W @IOF,!,"QUARTERLY REPORT FOR SURGICAL SERVICE"
QTR W !!,"Run report for which quarter of the fiscal year ?",!!,?5,"(1) October 1 - December 31",!,?5,"(2) January 1 - March 31",!,?5,"(3) April 1 - June 30",!,?5,"(4) July 1 - September 30"
 W !!,"Select Quarter:  " R X:DTIME I '$T!(X["^")!(X="") S SRSOUT=1 G END
 I X["?"!(X<1)!(X>4) W !,"Enter a number between 1 and 4 corresponding to the quarter of the fiscal year",!,"for which you want to run the report.  The quarter selected must have ended",!,"at least 30 days in the past." G QTR
 S SRQTR=X
MO S SRYR=$E(DT,1,3),SRSMO=$S(SRQTR=1:"1001",SRQTR=2:"0101",SRQTR=3:"0401",1:"0701"),SRY=0
 S SREMO=$S(SRQTR=1:"1231",SRQTR=2:"0331",SRQTR=3:"0630",1:"0930")
 S SRDT=SRYR_SREMO,SRYR=SRYR+1700,X1=SRDT,X2=31 D C^%DTC I X>DT S SRDT=SRDT-10000,SRYR=$E(SRDT,1,3)+1700,SRYR=$S(SRQTR=1:SRYR+1,1:SRYR)
YR W !!,"Select FISCAL YEAR: ",SRYR,"// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X["?" W !,"Enter the fiscal year for the quarter you have selected.  The quarter",!,"selected must have ended at least 30 days in the past." G MO
 I X="" S X=SRYR
 I X?2N S SRY=$E(DT)_X
 I X?4N S SRY=X-1700 I SRY'>0 W "  ??" G MO
 I X?7N,$E(X,4,7)="0000" S SRY=$E(X,1,3)
 I 'SRY W "  ??" G MO
 S:SRQTR=1 SRY=SRY-1 S SRSTART=SRY_SRSMO I SRSTART>DT W !!,"The report cannot be run for the future !!" G QTR
 S SREND=SRY_SREMO,X1=SREND,X2=31 D C^%DTC I X>DT W !!,"At least 30 days have not passed since the end of the quarter selected." G QTR
 S SRAC=$O(^SRF("AC",0)) I SREND<SRAC S Y=SRAC D DD^%DT S SRAC1=$E(Y,1,12) W !!,$S(SRAC:"No surgical data exists before "_SRAC1_".",1:"There are no surgical cases on record !") G QTR
 W "  (",$S(SRQTR=1:SRY+1701,1:SRY+1700),")" S SRFLG=1
ASK W !!,"Do you want this report to be transmitted to the Surgical Service",!,"central database ?  NO// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X["?" W !!,"Enter 'Y' to have this report automatically transmitted to the Central Office",!,"Surgical Service database.  Enter 'N' or press RETURN if you do NOT want this",!,"report transmitted." G ASK
 S X=$E(X) S:X="" X="N" I "YyNn"'[X G ASK
 I "Nn"[X G IO
PRT S SRT=1 W !!,"Do you also want to print this report ?  YES// " R X:DTIME I '$T!(X["^") S SRSOUT=1 G END
 I X["?" W !!,"Enter 'NO' if you want to have this report transmitted, but do not want to",!,"have it printed.  Enter 'YES' or press RETURN if you do want to print the",!,"report as well as have it transmitted." G PRT
 S:X="" X="Y" I "YyNn"'[X G PRT
 I "Nn"[X G QUE^SROQT
IO W ! K %ZIS,IO("Q"),POP S %ZIS("A")="Print report on which Device: ",%ZIS="Q" D ^%ZIS I POP S SRSOUT=1 G END
 I $D(IO("Q")) K IO("Q") S ZTDESC="Quarterly Report - Surgical Service",(ZTSAVE("SRSTART"),ZTSAVE("SREND"),ZTSAVE("SRFLG"),ZTSAVE("SRT"))="",ZTRTN="EN^SROQ" D ^%ZTLOAD S SRSOUT=1 G END
EN ; entry point when queued
 K SRINSTP N SRDVSN,SRIEN,SRMULT S SRDVSN="",(SRCOUNT,SRIEN,SRMULT,X)=0 D
 .F  S X=$O(^SRO(133,X)) Q:'X  I '$P($G(^SRO(133,X,0)),"^",21) S SRCOUNT=SRCOUNT+1,SRDVSN(X)=$P(^SRO(133,X,0),"^")
 .I SRCOUNT>1 S SRMULT=1
 D SET^SROQ2 I SRT D ^SROQT,^SROQ1 I SRMULT=1 D
 .S SRIEN=0 F  S SRIEN=$O(SRDVSN(SRIEN)) Q:'SRIEN  D
 ..S SRINSTP=SRDVSN(SRIEN),SRINST=$$GET1^DIQ(4,SRINSTP,.01),SRSTATN=$$GET1^DIQ(4,SRINSTP,99)
 ..D SET^SROQ2,^SROQT
 I 'SRT D ^SROQ1
 D END^SROQ2
 Q
END W ! I 'SRSOUT W !!,"Press <RET> to continue  " R X:DTIME
 D ^%ZISC,^SRSKILL W @IOF
 Q
HELP W !!,"Enter '1' or press RETURN to get a summary report based on the same criteria",!,"and in the same format as the Quarterly Report for Central Office except",!,"that the date range is selectable."
 W !!,"Enter '2' to generate the Quarterly Report for Central Office for an entire",!,"quarter at least 30 days in the past."
 G SEL
 Q
