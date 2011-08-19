IBCOMA ;ALB/CMS - IDENTIFY ACTIVE POLICIES W/NO EFFECTIVE DATE; 08-03-98
 ;;2.0;INTEGRATED BILLING;**103**;21-MAR-94
 Q
EN ;Entry point from option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBQUIT,IBSIN,IBSTR,X,Y
 S (IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBSTR)=""
 W !!,?10,"Identify Active Policies with NO Effective Date",!
 S DIR("A",1)="Sort report by"
 S DIR("A",2)="  1  - Patient Name Range"
 S DIR("A",3)="  2  - Terminal Digit Range"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Patient Name;2:Terminal Digit"
 S DIR("A")="  Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMA" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBAIB=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 W !! D @$S(IBAIB=1:"NR",1:"TR")
 I $G(IBQUIT)=1 G EXIT
 ;
VER W !!
 S DIR("A",1)="    Within "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_" Include:"
 S DIR("A",2)="      1  - Verified Policies"
 S DIR("A",3)="      2  - Non-Verified Policies"
 S DIR("A",4)="      3  - Both"
 S DIR("A",5)="  "
 S DIR(0)="SAXB^1:Verified Policies;2:Non-Verified Policies;3:Both"
 S DIR("A")="      Select Number: ",DIR("B")="1",DIR("??")="^D ICH^IBCOMA" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBSIN=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 I IBSIN'=2 D VR I IBBDT=""!(IBEDT="") W "     <Date Range not entered>" G VER
 I $G(IBQUIT)=1 G EXIT
 ;
 W !! D QUE
 ;
EXIT Q
 ;
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR S DIR(0)="FO",DIR("B")="FIRST",DIR("A")="  START WITH PATIENT NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="FIRST" Y="A" S IBRF=Y
 S DIR(0)="FO",DIR("B")="LAST",DIR("A")="  GO TO PATIENT NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="LAST" Y="zzzzzz" S IBRL=Y
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The Go to Patient Name must follow after the Start with Name. *",! G NRR
 Q
 ;
TR ; Ask Terminal Digit Range
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="FO^1:9^K:X'?1.9N X"
 S DIR("?")="Enter up to 9 digits of the Terminal Digit to include in Report"
 S DIR("B")="0000",DIR("A")="  Start with Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRF=$E((Y_"000000000"),1,9)
 S DIR("B")="9999",DIR("A")="  GO to Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRL=$E((Y_"999999999"),1,9)
 I IBRF>IBRL W !!,?5,"* The Go to Terminal Digit must follow after the Start with Digit. *",! G TR
 Q
 ;
VR ; Ask Verification Date Range
 N %DT,X,Y
 W !!,"      Please enter Policy Verification Dates:"
 ;
VRBDT ; - get begin date
 S (IBBDT,IBEDT)=""
 S %DT="AEX",%DT("A")="        Start with DATE: " D ^%DT K %DT G VRQ:Y<0 S IBBDT=Y
 ;
VREDT ; - get ending date
 S %DT="EX" R !,"        Go to DATE: ",X:DTIME S:X=" " X=IBBDT G VRQ:(X="")!(X["^") D ^%DT G VREDT:Y<0 S IBEDT=Y I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G VRBDT
 ;
VRQ Q
 ;
ENH ; Sort help Text
 W !!,?5,"Enter 1 to search by a Patient Name Range. (i.e. ADAMS to ADAMSZ)"
 W !!,?5,"Enter 2 to search by Terminal Digit.  The output will be sorted"
 W !?5,"by the 8th and 9th digits and then the 6th and 7th digits"
 W !?5,"of the Patient's SSN.",!
 Q
 ;
ICH ; Search criteria help Text
 W !!,?5,"Enter 1 to list active policies by Verification Date Range"
 W !,?15,"(i.e. Sort Date By: 10-1-96  Go to Date: 01-1-97)"
 W !,?5,"Enter 2 to list active policies with no Verification Date."
 W !,?5,"Enter 3 to include active policies with or without a Verification Date."
 Q
QUE ; Ask Device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !,?10,"You may want to queue this report!",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="BEG^IBCOMA1",ZTSAVE("IBRF")="",ZTSAVE("IBRL")=""
 .S ZTSAVE("IBAIB")="",ZTSAVE("IBBDT")="",ZTSAVE("IBEDT")="",ZTSAVE("IBSIN")=""
 .S ZTDESC="IB - Identify Active Policies w/no Effective Date"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMA1
 ;
QUEQ ; EXIT CLEAN-UP
 W ! D ^%ZISC K IBAIB,IBRF,IBRL,IBSIN,IBSTR,^TMP("IBCOMA",$J)
 Q
 ;IBCOMA
