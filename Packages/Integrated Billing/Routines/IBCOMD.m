IBCOMD ;ALB/CMS - GENERATE INSURANCE COMPANY LISTINGS ;03-AUG-98
 ;;2.0;INTEGRATED BILLING;**103,528,732,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Reference to D EN^XUTMDEVQ in ICR #1519
 Q
EN ; Entry point from option
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ;IB*732/CKB - added IBDEF and STOP
 N IBAIB,IBCASE,IBDEF,IBF,IBFLD,IBOUT,IBQ,IBQUIT,IBTY,STOP,X,Y
 S STOP=0
 W !!,?10,"Generate Insurance Company Listings",!
 S DIR("A",1)="Sort report by"
 S DIR("A",2)="1  - Active Insurance Companies"
 S DIR("A",3)="2  - Inactive Insurance Companies"
 S DIR("A",4)="3  - Both"
 S DIR("A",5)="  "
 ;IB*732/CKB - allow selection to be case insensitive. If user enters
 ; '^', set STOP=1 to exit
 ;S DIR(0)="SAXB^1:Active;2:Inactive;3:Both"
 S DIR(0)="SA^1:Active;2:Inactive;3:Both"
 S DIR("A")=" Select Number: "
 S DIR("B")="1"
 S DIR("??")="^D ENH^IBCOMD"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!(+Y'>0) S STOP=1
 I Y="^" S STOP=1
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I STOP G EXIT
 S IBAIB=+Y
 ;
 W !!,"You may search for specific companies to be included in this report by"
 W !,"'screening' companies based on the company name, street, city, or state."
 W !,"You may select any combination of these fields and specify a 'range' of"
 W !,"values that the field must fall between, or a specific value that the"
 W !,"field must 'contain.'",!
 ;
 K IBFLD
 S STOP=0
 S IBFLD(1)="NAME",IBFLD(2)="STREET",IBFLD(3)="CITY",IBFLD(4)="STATE"
 K IBCASE S IBQ=0 F  D  Q:(IBQ)!(STOP=1)  W !
 .;
 .; - ask for the field
 .S DIR("A",1)="    Select a"_$S($D(IBCASE):"nother",1:"")_" field to screen Insurance Companies"
 .S DIR("A",2)="  "
 .S DIR("A",3)="      1  -  NAME"
 .S DIR("A",4)="      2  -  STREET"
 .S DIR("A",5)="      3  -  CITY"
 .S DIR("A",6)="      4  -  STATE"
 .S DIR("A",7)="  "
 .;IB*732/CKB - allow selection to be case insensitive. If user enters
 .; '^', set STOP=1 to exit
 .;S DIR(0)="SAOXB^1:NAME;2:STREET;3:CITY;4:STATE"
 .S DIR(0)="SAO^1:NAME;2:STREET;3:CITY;4:STATE"
 .S DIR("A")="         Select a field by Number: "
 .S DIR("??")="^D FLD^IBCOMD"
 .D ^DIR
 .I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!(+Y'>0) S IBQ=1
 .I Y="^" S STOP=1
 .K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 .I IBQ Q 
 .S IBF=+Y
 .;
 .; - if state was chosen, select a state and quit
 .I IBF=4 D  Q
 ..S DIC="^DIC(5,",DIC(0)="QEAMZ",DIC("A")="Select STATE: "
 ..I $P($G(IBCASE(4)),"^",2) S DIC("B")=$P($G(^DIC(5,$P($G(IBCASE(4)),"^",2),0)),"^")
 ..;IB*732/CKB - if user enters '^', set STOP to exit
 ..D ^DIC K DIC
 ..I X="^" S STOP=1
 ..I (Y'>0)!(STOP=1) K IBCASE(4) Q
 ..S IBCASE(4)="^"_+Y
 .;
 .; - ask user to select values by 'range' or 'contains'
 .S DIR("A")="Allow a (R)ange of values or a value that (C)ontains a specific string: "
 .;IB*732/CKB - allow selection to case insensitive, properly display previous value
 .; and if user enters '^' set STOP to exit
 .;S DIR(0)="SAXB^R:RANGE;C:CONTAINS",DIR("??")="^D RAN^IBCOMD"
 .S DIR(0)="SA^R:RANGE;C:CONTAINS"
 .S DIR("?")="This response can be free text."
 .S DIR("??")="^D RAN^IBCOMD"
 .I $P($G(IBCASE(IBF)),"^")'="" S DIR("B")=$P($G(IBCASE(IBF)),"^")
 .D ^DIR
 .I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT)!(Y="^") S STOP=1
 .K DIR,DIROUT,DTOUT,DUOUT,DIRUT
 .I Y'="R",Y'="C"!(STOP) K IBCASE(IBF) Q
 .S IBTY=Y
 .;
 .; - ask user to select value that 'contains'
 .;IB*732/CKB - allow selection to case insensitive and properly display previous
 .;value. If user enters '^' set STOP to exit
 .I IBTY="C" D  Q
 ..S IBDEF=$P($G(IBCASE(IBF)),"^",2)
 ..S DIR(0)="FAO"
 ..S DIR("A")=IBFLD(IBF)_" contains the value: "
 ..I $P($G(IBCASE(IBF)),"^",2)'="" S DIR("B")=$P($G(IBCASE(IBF)),"^",2)
 ..S DIR("?")="This response can be free text."
 ..S DIR("??")="^D CON^IBCOMD"
 ..D ^DIR K DIR
 ..I Y="^" S STOP=1
 ..I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT)!(STOP) K IBCASE(IBF),DIROUT,DTOUT,DUOUT,DIRUT Q
 ..I Y="" W !!,?5,"Note: Companies will be selected where ",IBFLD(IBF)," is null."
 ..S IBCASE(IBF)=IBTY_"^"_Y
 .;
 .; - ask user to select a range of values
 .D SELR
 ;
 ;IB*732/CKB - user entered '^', go to exit and quit
 I (Y="^")!(STOP=1) G EXIT
 ;
 I '$D(IBCASE) W !!,"Please note that no screening fields were selected!",!
 ;IB*732/CKB - call DISPLAY tag to display the selected screening fields
 I $D(IBCASE) D DISPLAY W !
 ;E  D  W !
 ;.N I,H
 ;.W !!,"The following conditions were selected:"
 ;.S (H,I)=0 F  S I=$O(IBCASE(I)) Q:'I  D
 ;..W ! I H W ?3,"and"
 ;..S H=1 W ?8,IBFLD(I)
 ;..W ?18,$S(I=4:"Equals ",$P(IBCASE(I),"^")="C":"Contains ",1:"Between ")
 ;..W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"'FIRST'",1:$P(IBCASE(I),"^",2))
 ;..I $P(IBCASE(I),"^")="R" W " and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"'LAST'",1:$P(IBCASE(I),"^",3))
 ;
 S IBOUT=$$OUT G:IBOUT="" EXIT
 ;
 D QUE
 ;
EXIT ;
 Q
 ;
 ;
SELR ; Select a range of values
 ;IB*732/CKB - made code easier to read and if user enters '^', set STOP to exit
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBRF,IBRL,X,Y
SELRR ;
 ;IB*743/TAZ - Updated code to accept NULL to mean beginning of list.
 W !!,"Enter Start With value or Press <ENTER> to start at the beginning of the list.",!
 S DIR(0)="FO"
 S DIR("A")="START WITH '"_IBFLD(IBF)_"' VALUE"
 I $P($G(IBCASE(IBF)),"^",2)'="" S DIR("B")=$P($G(IBCASE(IBF)),"^",2)
 S DIR("?")="^D RANGE^IBCOMD(""BEGIN"")"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(Y="^") S STOP=1 K IBCASE(IBF) Q
 S IBRF=Y
 ;
 ;IB*743/TAZ - Updated code to accept NULL to mean end of list.
 W !!,"Enter Go To value or Press <ENTER> to finish at the end of the list.",!
 S DIR(0)="FO"
 S DIR("A")="GO TO '"_IBFLD(IBF)_"' VALUE"
 ; IB*743/DTG do not dispay 'zzzzzz' on edit
 I ($P($G(IBCASE(IBF)),"^",3)'="")&($P($G(IBCASE(IBF)),"^",3)'="zzzzzz") S DIR("B")=$P($G(IBCASE(IBF)),"^",3)
 S DIR("?")="^D RANGE^IBCOMD(""END"")"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT)!(Y="^") S STOP=1 K IBCASE(IBF) Q
 S IBRL=$S(Y="":"zzzzzz",1:Y)
 ;
 ; - the 'go to' value must follow the 'start with' value
 ;IB*732/CKB - make selection case insensitive
 I $$UP^XLFSTR($G(IBRL))']$$UP^XLFSTR($G(IBRF)) D  G SELRR
 . W !!,?5,">>>>> The 'Go To' value must follow after the 'Start With' value. <<<<<",!
 S IBCASE(IBF)="R^"_IBRF_"^"_IBRL
 Q
 ;
DISPLAY ;IB*732/CKB - Display the selected screening conditions
 N I,H
 W !!,"The following conditions were selected:"
 S (H,I)=0 F  S I=$O(IBCASE(I)) Q:'I  D
 .W ! I H W ?3,"and"
 .S H=1 W ?8,IBFLD(I)
 .W ?18,$S(I=4:"Equals ",$P(IBCASE(I),"^")="C":"Contains ",1:"Between ")
 .W $S(I=4:$P($G(^DIC(5,+$P(IBCASE(I),"^",2),0)),"^"),$P(IBCASE(I),"^",2)="":"'FIRST'",1:$P(IBCASE(I),"^",2))
 .I $P(IBCASE(I),"^")="R" W " and ",$S($P(IBCASE(I),"^",3)="zzzzzz":"'LAST'",1:$P(IBCASE(I),"^",3))
 Q
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
 ;IB*743/TAZ - Help for the Range Prompt
RANGE(LEVEL) ; ?? Help for the Range Prompt
 W !!,?5,"Enter a value the entries in the list should ",LEVEL," with."
 I LEVEL="BEGIN" W !,?5,"Press <ENTER> to start at the beginning of the list."
 I LEVEL="END" W !,?5,"Press <ENTER> to finish at the end of the list."
 Q
 ;
QUE ; Ask Device
 ;IB*732/CKB - Modified to allow Queuing of the report, and added Excel
 ; warning to prevent wrapping
 N ZTDESC,ZTRTN,ZTSAVE
 ;
 I IBOUT="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;256;99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 ;
 S ZTRTN="BEG^IBCOMD1"
 S ZTSAVE("IBAIB")="",ZTSAVE("IBFLD(")="",ZTSAVE("IBOUT")=""
 I $D(IBCASE) S ZTSAVE("IBCASE(")=""
 S ZTDESC="IB - Identify Dup Insurance Companies"
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")  ; ICR #1519
QUEQ ;
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
