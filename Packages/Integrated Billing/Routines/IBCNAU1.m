IBCNAU1 ;ALB/KML/AWC - eIV USER EDIT REPORT (REPORT FILTER SELECTION) ;6-APRIL-2015
 ;;2.0;INTEGRATED BILLING;**528,664,668**;21-MAR-94;Build 28
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
SELR() ;EP - Select Report Type
 ; IB*2.0*664 - Added function
 ; Prompt user to select report for User edits to Insurance Company/Group Plan or Payers or BOTH 
 ; Input: None
 ; Returns: 1 - Insurance Company/Group Plan
 ; 2 - Payers
 ; 3 - Both Insurance Company/Group Plan and Payers
 ; -1 - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,IBV0
 W !!,"Select one of the following:"
 S DIR(0)="SA^1:INSURANCE COMPANY/GROUP PLAN;2:PAYERS;3:BOTH"
 S DIR("A")=" Select 1 or 2 or 3: "
 S DIR("A",1)=" 1. User Edits for Insurance Company/Group Plan"
 S DIR("A",2)=" 2. User Edits for Payers"
 S DIR("A",3)=" 3. BOTH"
 S DIR("?",1)=" 1 - Only report on user edits to Insurance Company/Group Plan"
 S DIR("?",2)=" 2 - Only report on user edits to Payers"
 S DIR("?")=" 3 - Report on user edits to both Insurance Company/Group Plan and Payers"
 S DIR("B")=1
 D ^DIR
 I Y<0!$D(DIRUT) Q -1
 S IBV0=$S(Y=2:2,Y=3:3,1:1)
SELRQ Q IBV0
 ;
SELI() ; Prompt user to select all or subset of insurance companies 
 ; Count ins. companies with plans
 ;
 N IBV1,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Insurance Company Selection:"
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
 W !!,"Group Plan Selection:"
 N IBV2,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 S DIR(0)="YA"
 S DIR("A")="Do you want to report any edits made to Group Plans (Y/N)? "
 ;D ^DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELPQ
 ;/vd - IB*2.0*664 - Replaced the above line with the following line.
 D ^DIR I $D(DIRUT) S IBV2=-1 G SELPQ
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
 S DIR("?")="Enter '1' if edits from all Group Insurance Plans are to be reported. Enter '2' if edits from selected Group Insurance Plans are to be reported."
 ;
 D ^DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELPQ
 S IBV2=(+Y=1),PLANS=1
SELPQ Q IBV2
 ;
 ;/vd-IB*2*664 - Added the following module of code.
SELPY() ; Prompt user if Payer(s) are to be on the report
 ; function output returns 1 or 0 in IBV5
 ;
 W !!,"eIV Payer Selection:"
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBV5,X,Y ;
 ; if payer edits are to be reported, user needs to choose between all payers or some payers
 S DIR(0)="SA^1:Report all Payers;2:Report Payers that are selected"
 S DIR("A",1)="1. Report User Edits for all Payers"
 S DIR("A",2)="2. Report User Edits for selected Payers"
 S DIR("A")=" ENTER 1 or 2: "
 S DIR("?")="Enter '1' if edits from all Payers are to be reported. Enter '2' if edits from selected Payers are to be reported."
 ;
 D ^DIR I Y<0!$D(DIRUT) S IBV5=-1 G SELPYQ
 S IBV5=(+Y=1)
SELPYQ Q IBV5
 ;
 ;/vd-IB*2*664 - Added the following module of code.
GPYR(ALLPYRS) ; Select the Payers to be reported on.
 ; -- allow user to select payers
 K ^TMP("IBPYR",$J)
 I ALLPYRS=1 D GPYRALL Q
 N IBPAYER,IBPYR,IBTXT
 D PAYER^IBCNINSL("EIV",1,.IBPAYER)
 S IBPYR=""
 F  S IBPYR=$O(IBPAYER(IBPYR)) Q:IBPYR=""  S IBTXT=$E(IBPAYER(IBPYR),1,25) D
 . I IBTXT]"" S ^TMP("IBPYR",$J,IBTXT,IBPYR)=""
 Q
 ;
 ;/vd-IB*2*664 - Added the following module of code.
GPYRALL ; User wants to see all PAYERS that have received edits
 N PYRIEN,PYRNAM,PYRTXT
 K ^TMP("IBPYR",$J)
 S PYRNAM="" F  S PYRNAM=$O(^IBE(365.12,"B",PYRNAM)) Q:PYRNAM=""  D
 . S PYRIEN=0 F  S PYRIEN=$O(^IBE(365.12,"B",PYRNAM,PYRIEN)) Q:'PYRIEN  D
 . . ;IB*668/TAZ - Changed Payer Application from IIV to EIV
 . . I '+$$PYRAPP^IBCNEUT5("EIV",PYRIEN) Q   ; Not an eIV Payer...Only want eIV Payers.
 . . S ^TMP("IBPYR",$J,PYRNAM,PYRIEN)=""
 Q
 ;
SELU() ; prompt user to select user id
 W !!,"User Selection:"
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
GETTYP() ; Get display/output type
 ; RETURNS  : Output destination (0=Display; 1=MS Excel)
 ; LOCAL VARIABLES :
 ; DIR,DUOUT - Standard FileMan variables
 ; Y         - User input
 N DIR,DUOUT,DIRUT,Y
 W !
 S DIR(0)="Y"
 S DIR("A")="Export to Microsoft Excel (Y/N): "
 S DIR("B")="NO"
 D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) S Y=-1
 Q Y
 ;
OK(QUIT) ; -- ask okay
 N DIR,Y,X
 W !
 S DIR(0)="Y",DIR("A")="         ...OK",DIR("B")="YES" D ^DIR
 I $D(DUOUT)!$D(DIRUT) S QUIT=1
 Q Y
 ;
