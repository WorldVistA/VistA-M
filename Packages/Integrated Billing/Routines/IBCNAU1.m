IBCNAU1 ;ALB/KML/AWC - eIV USER EDIT REPORT (REPORT FILTER SELECTION) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 Q
 ;
SELI() ; Prompt user to select all or subset of insurance companies 
 ; Count ins. companies with plans
 ;
 N IBV1,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !,!,"Insurance Company Selection:"
 S DIR(0)="SA^1:Report all Insurance Companies;2:Report Insurance Companies that are selected"
 S DIR("A",1)="1. Report User Edits for all "_$P(^DIC(36,0),U,4)_" Insurance Companies"
 S DIR("A",2)="2. Report User Edits for selected Insurance Companies"
 S DIR("A")="     ENTER 1 or 2:  "
 S DIR("?",1)="Enter '1' if edits from all Insurance Companies are to be reported."
 S DIR("?")="Enter '2' if you want to select the Insurance Company(s) to be reported."
 D ^DIR I Y<0!$D(DIRUT) S IBV1=-1 G SELIQ
 S IBV1=(+Y=1)
SELIQ Q IBV1
 ;
SELP(ALLINS,PLANS) ; Prompt user if Group Plans is to be on the report
 ; input/output - PLANS passed by reference. Returned with 1 or 0
 ;   function output returns 1 or 0 in IBV2
 ;
 W !,!,"Group Plan Selection:"
 N IBV2,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="Do you want to report any edits made to Group Plans (Y/N)? "
 D ^DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELPQ
 ; user does not want to report Group Plan edits
 I 'Y S (PLANS,IBV2)=+Y G SELPQ
 ;
 ; -- if report all insurance companies - quit and report to include group plans or not
 I ALLINS S IBV2=(+Y=1),PLANS=1 Q IBV2
 ;
 ; if group plan edits are to be reported, user needs to choose between all group plans or some group plans
 S DIR(0)="SA^1:Report all Group Insurance Plans;2:Report Group Insurance Plans that are selected"
 S DIR("A",1)="1. Report User Edits for all Group Insurance Plans"
 S DIR("A",2)="2. Report User Edits for selected Group Insurance Plans"
 S DIR("A")="     ENTER 1 or 2:  "
 S DIR("?")="Enter '1' if edits from all Group Gnsurance Plans are to be reported. Enter '2' if edits from selected Group Insurance Plans are to be reported."
 ;
 D ^DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELPQ
 S IBV2=(+Y=1),PLANS=1
SELPQ Q IBV2
 ;
SELU() ; prompt user to select user id
 W !,!,"User Selection:"
 N DIR,IBV3,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="SA^1:All Users;2:Specified Users"
 S DIR("A",1)="1. All User IDs"
 S DIR("A",2)="2. Select One or Multiple User IDs"
 S DIR("A")="     ENTER 1 or 2:  "
 S DIR("?")="Enter '1' if edits from all users are to be report. Enter '2' if edits from selected users are to be reported."
 D ^DIR I Y<0!$D(DIRUT) S IBV3=-1 G SELUQ
 S IBV3=(+Y=1)
SELUQ Q IBV3
 ;
SELDTS() ;
 N DIR,IBV3,DIROUT,DIRUT,DTOUT,DUOUT,X,Y,IBV4
 W !,"Date Selection",!
 S DIR(0)="SA^1:All Dates;2:Date Range"
 S DIR("A",1)="1. All Dates"
 S DIR("A",2)="2. Date Range"
 S DIR("A")="     ENTER 1 or 2:  "
 S DIR("?")="Enter '1' if edits for all dates are to be reported. Enter '2' if edits are to be reported using a specified date range."
 D ^DIR I Y<0!$D(DIRUT) S IBV4=-1 G SELDTQ
 S IBV4=(+Y=1)
SELDTQ Q IBV4
  ;
GETTYP() ; Get display/output type
 ; RETURNS  : Output destination (0=Display; 1=MS Excel)
 ; LOCAL VARIABLES :
 ; DIR,DUOUT - Standard FileMan variables
 ; Y         - User input
 N DIR,DUOUT,DIRUT,Y
 S DIR(0)="Y"
 S DIR("A")="Export to Microsoft Excel (Y/N): "
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
OK(QUIT) ; -- ask okay
 N DIR,Y,X
 S DIR(0)="Y",DIR("A")="         ...OK",DIR("B")="YES" D ^DIR
 I $D(DUOUT)!$D(DIRUT) S QUIT=1
 Q Y
 ;
LKP(IBCNS,QUIT) ;Build the list of plans.
 N IBP,IB0,X,GNAME,OK
 S IBP=0 F  S IBP=$O(^IBA(355.3,"B",IBCNS,IBP)) Q:'IBP  Q:QUIT  D
 . S IB0=$G(^IBA(355.3,IBP,0)),GNAME=$G(^IBA(355.3,IBP,2),U)
 . I $P(IB0,"^",11) Q  ;      plan is inactive
 . W !!,"Group Plan: "_GNAME
 . S OK=$$OK(.QUIT)
 . Q:QUIT
 . I OK S ^TMP("IBGPLANS",$J,IBP)=""
 Q
