IBCOMN ;ALB/CMS - PATIENTS NO COVERAGE VERIFIED REPORT;10-09-98
 ;;2.0;INTEGRATED BILLING;**103,528,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 Q
EN ;Entry point from option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBOUT,IBQUIT,X,Y
 S (IBAIB,IBBDT,IBEDT,IBRF,IBRL)=""
 ;
VR ; Ask Verification Date Range
 W !!,?2,"Patients with No Insurance Coverage Verification"
 W !!,"Enter Verification Date Range"
 D DATE^IBOUTL
 I IBBDT=""!(IBEDT="") W "     <Date Range not entered>" G EXIT
 ;
 W ! S DIR("A",1)="Sort report by"
 S DIR("A",2)="1  - Patient Name Range"
 S DIR("A",3)="2  - Terminal Digit Range"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Patient Name;2:Terminal Digit"
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMN" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBAIB=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 W !! D @$S(IBAIB=1:"NR",1:"TR")
 I $G(IBQUIT)=1 G EXIT
 ;
 S IBOUT=$$OUT G:IBOUT="" EXIT
 ;
 W !! D QUE
 ;
EXIT Q
 ;
 S DIR(0)="FO",DIR("A")="START WITH PATIENT NAME"
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR ;
 ;IB*743/TAZ - Updated code to accept NULL to mean beginning of list.
 W !!,"Enter Start With value or Press <ENTER> to start at the beginning of the list.",!
 S DIR(0)="FO",DIR("A")="START WITH PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCOMN(""BEGIN"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRF=Y
 ;
 ;IB*743/TAZ - Updated code to accept NULL to mean end of list.
 W !!,"Enter Go To value or Press <ENTER> to finish at the end of the list.",!
 S DIR(0)="FO",DIR("A")="GO TO PATIENT NAME"
 S DIR("?")="^D NRRHLP^IBCOMN(""END"")"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="" Y="zzzzzz" S IBRL=Y
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The Go to Patient Name must follow after the Start with Name. *",! G NRR
 Q
 ;
NRRHLP(LEVEL) ; ?? Help for the Range Prompt
 W !!,?5,"Enter a value the Patient Name should ",LEVEL," with."
 I LEVEL="BEGIN" W !,?5,"Press <ENTER> to start at the beginning of the list."
 I LEVEL="END" W !,?5,"Press <ENTER> to finish at the end of the list."
 Q
 ;
 ;
TR ; Ask Terminal Digit Range
 N DIR,DIRUT,DUOUT,DTOUT,X,Y
 S DIR(0)="FO^1:9^K:X'?1.9N X"
 S DIR("?")="Enter up to 9 digits of the Terminal Digit to include in Report"
 S DIR("B")="0000",DIR("A")="Start with Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRF=$E((Y_"000000000"),1,9)
 S DIR("B")="9999",DIR("A")="GO to Terminal Digit"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S IBRL=$E((Y_"999999999"),1,9)
 I IBRF>IBRL W !!,?5,"* The Go to Terminal Digit must follow after the Start with Digit. *",! G TR
 Q
 ;
ENH ; Sort help Text
 W !!,?5,"Enter 1 to search by a Patient Name Range. (i.e. ADAMS to ADAMSZ)"
 W !!,?5,"Enter 2 to search by Terminal Digit.  The output will be sorted"
 W !,"by the 8th and 9th digits and then the 6th and 7th digits of the"
 W !,"Patient's SSN.",!
 Q
 ;
QUE ; Ask Device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !,?10,"You may want to queue this report!",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="BEG^IBCOMN1",ZTSAVE("IBRF")="",ZTSAVE("IBRL")=""
 .S ZTSAVE("IBAIB")="",ZTSAVE("IBBDT")="",ZTSAVE("IBEDT")="",ZTSAVE("IBOUT")=""
 .S ZTDESC="IB - Patients w/no Coverage Verification"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMN1
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBOUT,IBRF,IBRL,VA,VAERR,VADM,VAPA,^TMP("IBCOMN",$J)
 Q
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q Y
