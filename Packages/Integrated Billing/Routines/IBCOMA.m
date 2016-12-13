IBCOMA ;ALB/CMS/JNM - IDENTIFY ACTIVE POLICIES W/NO EFFECTIVE DATE; 09-29-2015
 ;;2.0;INTEGRATED BILLING;**103,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
EN ;Entry point from option
 ; IBAIB - 1 (Patient Name Range) or 2 (Terminal Digit Range) sorting method
 ; IBAPPTE - Ending Appointment Date for filtering
 ; IBAPPTS - Starting Appointment Date for filtering
 ; IBBDT - Beginning Verification Date for filtering
 ; IBEDT - Ending Verification Date for filtering
 ; IBEXCEL - 1 for Excel Format, 0 for Report Format
 ; IBRF - First Patient Name or Terminal Digit, depending on sorting method
 ; IBRL - Last Patient Name or Terminal Digit, depending on sorting method
 ; IBPTYPE - 1 (Living Patients), 2 (Deceased Patients) or 3 (Both)
 ; IBSIN - 1 (Verified Policies), 2 (Non-Verified Policies) or 3 (Both)
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBAIB,IBAPPTE,IBAPPTS,IBBDT,IBEDT,IBEXCEL,IBRF
 N IBRL,IBPTYPE,IBQUIT,IBSIN,X,Y
STRT ;
 S (IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBQUIT,IBAPPTS,IBAPPTE,IBEXCEL)=""
 W !!,?10,"Identify Active Policies with NO Effective Date",!
 S DIR("A",1)="Sort report by"
 S DIR("A",2)="  1  - Patient Name Range"
 S DIR("A",3)="  2  - Terminal Digit Range"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Patient Name;2:Terminal Digit"
 S DIR("A")="  Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMA"
 D ^DIR
 I +Y'>0 G EXIT
 S IBAIB=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 W !!
 D @$S(IBAIB=1:"NR",1:"TR")
 I IBQUIT=1 G EXIT
 ;
PATLIFE ; IB*2*549 - Prompt for Living/Deceased Patient filter
 W !!
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A",1)=$$WITEXT()
 S DIR("A",2)="    1 - Living Patients"
 S DIR("A",3)="    2 - Deceased Patients"
 S DIR("A",4)="    3 - Both"
 S DIR("A",5)=" "
 S DIR(0)="SAXB^1:Living Patients;2:Deceased Patients;3:Both"
 S DIR("A")="    Select Number: ",DIR("B")="1",DIR("??")="^D PATLIFEH^IBCOMA"
 D ^DIR
 I $D(DUOUT) G STRT
 I +Y'>0 G EXIT
 S IBPTYPE=Y
 ;
VER ;
 W !!
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR("A",1)=$$WITEXT()
 S DIR("A",2)="    1  - Verified Policies"
 S DIR("A",3)="    2  - Non-Verified Policies"
 S DIR("A",4)="    3  - Both"
 S DIR("A",5)="    "
 S DIR(0)="SAXB^1:Verified Policies;2:Non-Verified Policies;3:Both"
 S DIR("A")="      Select Number: ",DIR("B")="1",DIR("??")="^D ICH^IBCOMA" D ^DIR
 I $D(DUOUT) G PATLIFE
 I +Y'>0 G EXIT
 S IBSIN=+Y
 ;
FILTYPE ; IB.2.0.549 added method
 S (IBBDT,IBEDT,IBAPPTS,IBAPPTE)=0
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 I IBSIN>1 G LADATE
 W !!
 S DIR("A",1)="Filter data by:"
 S DIR("A",2)="  1 - Policy Verification Date"
 S DIR("A",3)="  2 - Last Appointment Date"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Policy Verification Date;2:Last Appointment Date"
 S DIR("A")="  Select Number: ",DIR("B")="1",DIR("??")="^D FILTYPEH^IBCOMA"
 D ^DIR
 I $D(DUOUT) G VER
 I +Y'>0 G EXIT
 I Y=2 G LADATE
 ;
PVDATE ;
 N UPMOD
 I '$$GETDATES("Policy Verification",.IBBDT,.IBEDT) S UPMOD=$S(+$G(IBSIN)>1:"VER",1:"FILTYPE") G @UPMOD
 I IBQUIT=1 G EXIT
 G FORMAT
 ;
LADATE ;
 ;
 ; IB*2*549 - Prompt for Last Appointment Date Range
 N UPMOD
 W !!
 I '$$GETDATES("Last Appointment",.IBAPPTS,.IBAPPTE) S UPMOD=$S(+$G(IBSIN)>1:"VER",1:"FILTYPE") G @UPMOD
 I IBQUIT=1 G EXIT
 ;
FORMAT ;  Prompt for Excel or Report Format
 W !
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report",DIR("??")="^D FORMATH^IBCOMA"
 D ^DIR
 S IBEXCEL=$S(Y="E":1,Y="R":0,1:-1)
 I IBEXCEL<0 G EXIT
 ;
 W !!
 D QUE
 ;
EXIT ;
 Q
 ;
WITEXT() ;
 Q "  Within "_$S(IBAIB=1:"Patient Name",1:"Terminal Digit")_" Include:"
 ;
FORMATH ; Excel or Report Format Help
 W !,?5,"Enter E to Export data in a format readable by Microsoft Excel."
 W !,?5,"Enter R to display output in Report format."
 Q
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
PATLIFEH ; Living/Deceased/Both patient filter help Text 
 W !!,?5,"Enter 1 to only display Living Patients."
 W !,?5,"Enter 2 to only display Deceased Patients."
 W !,?5,"Enter 3 to display both Living and Deceased Patients."
 Q
 ;
FILTYPEH ; Filter by Verification Date or Last Appointment Date Help Text
 W !!,?5,"Enter 1 to only display policies with a Verification Date falling"
 W !,?11,"within a specified date range."
 W !,?5,"Enter 2 to only display patients with a Last Appointment Date falling"
 W !,?11,"within a specified date range."
 Q
 ;
GETDATES(TEXT,STRTDATE,ENDDATE) ; Ask Date Range
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 N %DT,X,Y
 W !!,"      Please enter ",TEXT," Dates:"
 ;
VRBDT ; - get begin date
 S (STRTDATE,ENDDATE)=""
 S %DT="AEX",%DT("A")="        Start with DATE: " D ^%DT K %DT G VRQ:Y<0 S STRTDATE=Y
 ;
VREDT ; - get ending date
 S %DT="EX" R !,"        Go to DATE: ",X:DTIME S:X=" " X=STRTDATE G VRQ:(X="")!(X["^") D ^%DT G VREDT:Y<0 S ENDDATE=Y I Y<STRTDATE W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G VRBDT
 ;  
VRQ ;
 I (STRTDATE="")!(ENDDATE="") W "     <Date Range not entered>" Q 0
 Q 1
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
 N POP,%ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !,?10,"You may want to queue this report!"
 W !,?10,"Report requires 132 columns.",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 . S ZTRTN="BEG^IBCOMA1",ZTSAVE("IBRF")="",ZTSAVE("IBRL")=""
 . S ZTSAVE("IBAIB")="",ZTSAVE("IBBDT")="",ZTSAVE("IBEDT")="",ZTSAVE("IBSIN")=""
 . S ZTSAVE("IBPTYPE")="",ZTSAVE("IBAPPTS")="",ZTSAVE("IBAPPTE")="",ZTSAVE("IBEXCEL")=""
 . S ZTDESC="IB - Identify Active Policies w/no Effective Date"
 . D ^%ZTLOAD
 . K ZTSK
 . D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMA1
 ;
QUEQ ; EXIT CLEAN-UP
 W !
 D ^%ZISC
 K IBAIB,IBRF,IBRL,IBSIN,IBPTYPE,IBAPPTS,IBAPPTE,IBEXCEL,^TMP("IBCOMA",$J)
 Q
 ;IBCOMA
