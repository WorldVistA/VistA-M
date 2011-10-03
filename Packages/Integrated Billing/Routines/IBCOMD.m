IBCOMD ;ALB/CMS - GENERATE INSURANCE COMPANY LISTINGS; 03-AUG-98
 ;;2.0;INTEGRATED BILLING;**103**;21-MAR-94
 Q
EN ; Entry point from option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 N IBAIB,IBQUIT,IBCASE,IBFLD,IBQ,IBF,IBTY,X,Y
 W !!,?10,"Generate Insurance Company Listings",!
 S DIR("A",1)="Sort report by"
 S DIR("A",2)="1  - Active Insurance Companies"
 S DIR("A",3)="2  - Inactive Insurance Companies"
 S DIR("A",4)="3  - Both"
 S DIR("A",5)="  "
 S DIR(0)="SAXB^1:Active;2:Inactive;3:Both"
 S DIR("A")=" Select Number: ",DIR("B")="1",DIR("??")="^D ENH^IBCOMD"
 D ^DIR K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 I +Y'>0 G EXIT
 S IBAIB=+Y
 ;
 W !!,"You may search for specific companies to be included in this report by"
 W !,"'screening' companies based on the company name, street, city, or state."
 W !,"You may select any combination of these fields and specify a 'range' of"
 W !,"values that the field must fall between, or a specific value that the"
 W !,"field must 'contain.'",!
 ;
 K IBFLD S IBFLD(1)="NAME",IBFLD(2)="STREET",IBFLD(3)="CITY",IBFLD(4)="STATE"
 K IBCASE S IBQ=0 F  D  Q:IBQ  W !
 .;
 .; - ask for the field
 .S DIR("A",1)="    Select a"_$S($D(IBCASE):"nother",1:"")_" field to screen Insurance Companies"
 .S DIR("A",2)="  "
 .S DIR("A",3)="      1  -  NAME"
 .S DIR("A",4)="      2  -  STREET"
 .S DIR("A",5)="      3  -  CITY"
 .S DIR("A",6)="      4  -  STATE"
 .S DIR("A",7)="  "
 .S DIR(0)="SAOXB^1:NAME;2:STREET;3:CITY;4:STATE"
 .S DIR("A")="         Select a field by Number: ",DIR("??")="^D FLD^IBCOMD"
 .D ^DIR K DIR,DIROUT,DTOUT,DUOUT,DIRUT I +Y'>0 S IBQ=1 Q
 .S IBF=+Y
 .;
 .; - if state was chosen, select a state and quit
 .I IBF=4 D  Q
 ..S DIC="^DIC(5,",DIC(0)="QEAMZ",DIC("A")="Select STATE: "
 ..I $P($G(IBCASE(4)),"^",2) S DIC("B")=$P($G(^DIC(5,$P($G(IBCASE(4)),"^",2),0)),"^")
 ..D ^DIC K DIC I Y'>0 K IBCASE(4) Q
 ..S IBCASE(4)="^"_+Y
 .;
 .; - ask user to select values by 'range' or 'contains'
 .S DIR("A")="Allow a (R)ange of values or a value that (C)ontains a specific string: "
 .S DIR(0)="SAXB^R:RANGE;C:CONTAINS",DIR("??")="^D RAN^IBCOMD"
 .I $P($G(IBCASE(IBF)),"^")'="" S DIC("B")=$P($G(IBCASE(IBF)),"^")
 .D ^DIR K DIR,DIROUT,DTOUT,DUOUT,DIRUT I Y'="R",Y'="C" K IBCASE(IBF) Q
 .S IBTY=Y
 .;
 .; - ask user to select value that 'contains'
 .I IBTY="C" D  Q
 ..S DIR(0)="FAO",DIR("A")=IBFLD(IBF)_" contains the value: "
 ..I $P($G(IBCASE(IBF)),"^",2)'="" S DIC("B")=$P($G(IBCASE(IBF)),"^",2)
 ..S DIR("??")="^D CON^IBCOMD" D ^DIR K DIR
 ..I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K IBCASE(IBF),DIROUT,DTOUT,DUOUT,DIRUT Q
 ..I Y="" W !!,?5,"Note: Companies will be selected where ",IBFLD(IBF)," is null."
 ..S IBCASE(IBF)=IBTY_"^"_Y
 .;
 .; - ask user to select a range of values
 .D SELR
 ;
 ;
 I '$D(IBCASE) W !!,"Please note that no screening fields were selected!",!
 E  D  W !
 .N I,H
 .W !!,"The following conditions were selected:"
 .S (H,I)=0 F  S I=$O(IBCASE(I)) Q:'I  D
 ..W ! I H W ?3,"and"
 ..S H=1 W ?8,IBFLD(I)
 ..W ?18,$S(I=4:"Equals ",$P(IBCASE(I),"^")="C":"Contains ",1:"Between ")
 ..W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"'FIRST'",1:$P(IBCASE(I),"^",2))
 ..I $P(IBCASE(I),"^")="R" W " and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"'LAST'",1:$P(IBCASE(I),"^",3))
 ;
 D QUE
 ;
EXIT Q
 ;
 ;
 ;
SELR ; Select a range of values
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,IBRF,IBRL
SELRR S DIR(0)="FO",DIR("A")="START WITH '"_IBFLD(IBF)_"' VALUE"
 S DIR("B")=$S($P($G(IBCASE(IBF)),"^",2)'="":$P($G(IBCASE(IBF)),"^",2),1:"FIRST")
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K IBCASE(IBF) Q
 S:Y="FIRST" Y="" S IBRF=Y
 ;
 S DIR(0)="FO",DIR("A")="GO TO '"_IBFLD(IBF)_"' VALUE"
 S DIR("B")=$S($P($G(IBCASE(IBF)),"^",3)'="":$P($G(IBCASE(IBF)),"^",3),1:"LAST")
 D ^DIR I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) K IBCASE(IBF) Q
 S:Y="LAST" Y="zzzzzz" S IBRL=Y
 ;
 ; - the 'go to' value must follow the 'start with' value
 I $G(IBRL)']$G(IBRF) W !!,?5,"* The 'Go To' value must follow after the 'Start With' value. *",! G SELRR
 S IBCASE(IBF)="R^"_IBRF_"^"_IBRL
 Q
 ;
 ;
ENH ; Active, Inactive or Both help Text
 W !!,?5,"Enter 1 to search Active Insurance Companies"
 W !,?5,"Enter 2 to search Inactive Insurance Companies"
 W !,?5,"Enter 3 to include Active and Inactive Insurance Companies in Report",!
 Q
 ;
FLD ;Field selection help text
 W !!,?5,"Enter 1 to screen insurance company by Name"
 W !,?5,"Enter 2 to screen insurance company by Street"
 W !,?5,"Enter 3 to screen insurance company by City"
 W !,?5,"Enter 4 to screen insurance company by State"
 Q
 ;
RAN ; Help for the Range/Contains prompt.
 W !!,?5,"Enter 'R' to enter a 'Start From' and 'Go To' range, or 'C' to enter"
 W !,?5,"a specific string that the field value must contain.  Enter '^' to"
 W !,?5,"eliminate this screen field and select another field."
 Q
 ;
CON ; Help for the 'Contains' prompt.
 W !!,?5,"Enter a string that the field value should contain.  Enter a <CR> to"
 W !,?5,"find entries where the field value is null.  Enter '^' to eliminate"
 W !,?5,"this screen field and select another field."
 Q
 ;
 ;
QUE ; Ask Device
 N %ZIS,ZTRTN,ZTSAVE,ZTDESC
 S %ZIS="QM" D ^%ZIS G:POP QUEQ
 I $D(IO("Q")) K IO("Q") D  G QUEQ
 .S ZTRTN="BEG^IBCOMD1"
 .S ZTSAVE("IBAIB")="",ZTSAVE("IBFLD(")=""
 .I $D(IBCASE) S ZTSAVE("IBCASE(")=""
 .S ZTDESC="IB - Identify Dup Insurance Companies"
 .D ^%ZTLOAD K ZTSK D HOME^%ZIS
 ;
 U IO
 I $E(IOST,1,2)["C-" W !!,?15,"... One Moment Please ..."
 D BEG^IBCOMD1
QUEQ Q
