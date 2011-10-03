IBCOMC ;ALB/CMS - IDENTIFY PT BY AGE WITH OR WITHOUT INSURANCE; 10-09-98
 ;;2.0;INTEGRATED BILLING;**103**;21-MAR-94
 Q
EN ;Entry point from option
 N DA,DIC,DIE,DIR,DIROUT,DIRUT,DTOUT,DR,DUOUT,X,Y
 N IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBSINF,IBSINL,IBAGEF,IBAGEL,IBQUIT
 S (IBAIB,IBBDT,IBEDT,IBRF,IBRL,IBSIN,IBSINF,IBSINL,IBAGEF,IBAGEL,IBQUIT)=""
 ;
 W !!,"This report will identify patients who were treated within a specified"
 W !,"date range who do or do not have insurance coverage."
 ;
INS ; -- sort by Insurance Company or no Insurance
 W !!,"Sort by Insurance Company or No Insurance"
 S DIR("A",1)="1  - Insurance Company Range"
 S DIR("A",2)="2  - Selected Insurance Companies"
 S DIR("A",3)="3  - Patients with No Insurance"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Insurance Range;2:Specific Companies;3:No Insurance"
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D INSH^IBCOMC2" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBSIN=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 I IBSIN=1 D INSR
 I IBSIN=2 D INSS
 I $G(IBQUIT)=1 G EXIT
 ;
VISIT ; -- sort by Treated Date Range
 W !!,"Sort by Date Last Treated Range."
 D DATE^IBOUTL
 I IBBDT="" W *7,"    <Date Last Treated Range not entered>" G EXIT
 I IBBDT,IBEDT="" S IBEDT=DT_".2400"
 ;
 W !! S DIR("A",1)="Sort report by"
 S DIR("A",2)="1  - Patient Name Range"
 S DIR("A",3)="2  - Terminal Digit Range"
 S DIR("A",4)="  "
 S DIR(0)="SAXB^1:Patient Name;2:Terminal Digit"
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMC2" D ^DIR
 I +Y'>0 S IBQUIT=1 G EXIT
 S IBAIB=+Y
 K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 W !! D @$S(IBAIB=1:"NR",1:"TR")
 I $G(IBQUIT)=1 G EXIT
 ;
AGE ; -- sort by AGE optional
 W !!,"Sort by Patient Age Range.  (Optional)"
 S DIR("A")="Start AGE: ",DIR(0)="NAO^1:250",DIR("??")="^D AGEH^IBCOMC2" D ^DIR
 I X["^" S IBQUIT=1 G EXIT
 I +Y'>0 G AGEQ
 S IBAGEF=+Y,DIR(0)="NO^"_+IBAGEF_":250",DIR("B")="250",DIR("A")="To AGE" D ^DIR
 I X["^" S IBQUIT=1 G EXIT
 S IBAGEL=+Y
AGEQ K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 ;
 W !! D QUE
 ;
EXIT Q
 ;
NR ; Ask Name Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
NRR S DIR(0)="FO",DIR("B")="FIRST",DIR("A")="START WITH PATIENT NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="FIRST" Y="A" S IBRF=Y
 S DIR(0)="FO",DIR("B")="LAST",DIR("A")="GO TO PATIENT NAME"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="LAST" Y="zzzzzz" S IBRL=Y
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The Go to Patient Name must follow after the Start with Name. *",! G NRR
 Q
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
INSR ; -- sort by Insurance Company Range
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
INSR1 S DIR(0)="FO",DIR("B")="FIRST",DIR("A")="START WITH INSURANCE COMPANY"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="FIRST" Y="A" S IBSINF=Y
 S DIR(0)="FO",DIR("B")="LAST",DIR("A")="GO TO INSURANCE COMPANY"
 D ^DIR I ($D(DTOUT))!($D(DUOUT)) S IBQUIT=1 Q
 S:Y="LAST" Y="zzzzzz" S IBSINL=Y
 I $G(IBSINL)']$G(IBSINF) W !!,?5,"* The Go to Insurance Company must follow after the Start with Company Name. *",! G INSR1
 Q
 ;
INSS ; -- select up to six Insurance Companies
 N DIC,DA,IBX,X,Y S IBX=1
 S DIC(0)="AEQMZ",DIC="^DIC(36,",DIC("S")="I $$ANYGP^IBCNSJ(+Y,0,1),'$P($G(^DIC(36,+Y,0)),U,5)"
 S DIC("A")="Select INSURANCE COMPANY: " D ^DIC
 I Y<0 W "  <No Insurance Companies selected>" S IBQUIT=1 G INSSQ
 S IBSIN(IBX)=+Y_U_Y(0),DIC("A")="Select Another INSURANCE COMPANY: "
 F IBX=IBX+1:1:6 D  Q:(Y<0)
 .D ^DIC Q:Y<0
 .S IBSIN(IBX)=+Y_U_Y(0)
INSSQ Q
 ;
QUE ; Ask Device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 W !,?10,"You may want to queue this report!",!
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="BEG^IBCOMC1"
 .F IBX="IBAIB","IBBDT","IBEDT","IBRF","IBRL","IBSIN","IBSIN(","IBSINF","IBSINL","IBAGEF","IBAGEL","IBQUIT" S ZTSAVE(IBX)=""
 .S ZTDESC="IB - Identify Patients with/without Insurance"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMC1
 ;
QUEQ ; Exit clean-UP
 W ! D ^%ZISC K IBTMP,IBAIB,IBRF,IBRL,IBSIN,IBSTR,VA,VAERR,VADM,VAPA,^TMP("IBCOMC",$J)
 Q
 ;IBCOMC
