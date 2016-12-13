IBCOPP1 ;ALB/NLR - LIST INS. PLANS BY CO. (DRIVER 1) ; 20-OCT-2015 
 ;;2.0;INTEGRATED BILLING;**28,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SELR() ; Prompt user to select report type
 ; Returns: IBV1    0 - List insurance plans by company
 ;                  1 - List insurance plans by company with subscriber information
 ;                 -1 - No selection made
 N IBV1
 S DIR(0)="SA^1:1. List Insurance Plans by Company;2:2. List Insurance Plans by Company With Subscriber Information"
 S DIR("A")="     Select Report (1 OR 2): "
 S DIR("A",1)="1. List Insurance Plans by Company"
 S DIR("A",2)="2. List Insurance Plans by Company With Subscriber Information"
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBV1=-1 G SELRQ
 S IBV1=(+Y=2) K Y
SELRQ ;
 Q IBV1
 ;
SELI() ; Prompt user to select all or subset of insurance companies 
 ; Count ins. companies with plans
 ; Returns: IBV2    0 - User selects insurance companies
 ;                  1 - Run report for all insurance companies with plans
 ;                 -1 - No selection made
 ;
 N A,B,IBV2
 S (A,B)=0
 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S B=B+1
 S DIR(0)="SA^1:1. List All "_B_" Ins. Companies;2:2. List Only Ins. Companies That You Select"
 W !!,"     There are "_B_" insurance companies associated with "
 ;
 ; IB*2.0*549 Added Plan count below
 W $P(^IBA(355.3,0),"^",4)_" group plans.",!
 S DIR("A",1)="1. List All "_B_" Ins. Companies"
 S DIR("A",2)="2. List Only Ins. Companies That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELIQ
 S IBV2=(+Y=1) K Y
SELIQ ;
 Q IBV2
 ;
SELA() ;EP
 ; IB*2.0*549 - Added function
 ; Prompt user to select Active/Inactive/Both Insurance Companies
 ; Input:   None
 ; Returns: 0   - Inactive Insurance Companies Only
 ;          1   - Active Insurance Companies Only
 ;          2   - Both Active and Inactive Insurance Companies
 ;         -1   - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,XX
 W !
 S DIR(0)="SA^1:ACTIVE;2:INACTIVE;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)=" 1. Select ACTIVE Insurance Companies"
 S DIR("A",2)=" 2. Select INACTIVE Insurance Companies"
 S DIR("A",3)=" 3. Select BOTH"
 S DIR("?",1)=" 1 - Only allow selection of ACTIVE Insurance Companies"
 S DIR("?",2)=" 2 - Only allow selection of INACTIVE Insurance Companies"
 S DIR("?")=" 3 - Allow selection of ACTIVE and INACTIVE Insurance Companies"
 S DIR("B")=1
 D ^DIR
 I Y<0!$D(DIRUT) Q -1
 S XX=$S(Y=1:1,Y=2:0,1:2)
 Q XX
 ;
SELPA() ;EP
 ; IB*2.0*549 - Added function
 ; Prompt user to select Active/Inactive/Both Insurance Company Plans
 ; Input:   None
 ; Returns: 0   - Inactive Insurance Company Plans Only
 ;          1   - Active Insurance Company Plans Only
 ;          2   - Both Active and Inactive Insurance Company Plans
 ;         -1   - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,XX
 W !
 S DIR(0)="SA^1:ACTIVE;2:INACTIVE;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)=" 1. Select ACTIVE Group Plans"
 S DIR("A",2)=" 2. Select INACTIVE Group Plans"
 S DIR("A",3)=" 3. Select BOTH"
 S DIR("?",1)=" 1 - Only allow selection of ACTIVE Insurance Company Plans"
 S DIR("?",2)=" 2 - Only allow selection of INACTIVE Insurance Company Plans"
 S DIR("?")=" 3 - Allow selection of ACTIVE and INACTIVE Insurance Company Plans"
 S DIR("B")=1
 D ^DIR
 I Y<0!$D(DIRUT) Q -1
 S XX=$S(Y=1:1,Y=2:0,1:2)
 Q XX
 ;
SELP() ; Prompt user to select all or subset of plans
 ; Returns: IBV3    0 - Whether some or all ins. co's., user selects plans (may be
 ;                      all for certain companies, some for other companies
 ;                  1 - Whether some or all ins. co's., run report for all plans
 ;                      associated with those co's.
 ;                 -1 - No selection made
 ;
 N IBV3
 ;
 ; IB*2.0*549 Removed total plan count sentence from line below
 S DIR(0)="YO",DIR("A")="List all plans for each company",DIR("B")="No"
 S DIR("B")="No"
 S DIR("?",1)="If you say yes, the report will list all of the plans for each company."
 S DIR("?",2)="If you selected 2. List Insurance Plans by Company With Subscriber"
 S DIR("?",3)="Information and 1. List All "_$P(^IBA(355.3,0),"^",4)_" Ins. Companies,"
 S DIR("?",4)="this will result in the most complete report possible.  However, it"
 S DIR("?",5)="may take awhile to run.  If you say no, you must make plan selections"
 S DIR("?")="for each individual company (anywhere from one plan to all)."
 W ! D ^DIR W ! K DIR I Y<0!$D(DIRUT) S IBV3=-1 G SELPQ
 S IBV3=+Y K Y
SELPQ ;
 Q IBV3
 ;
OUT() ; Prompt to allow users to select output format
 ; Returns: E       - Output to excel
 ;          R       - Output to report
 ;         -1       - No Selection made
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 S DIR("?",1)="Select 'E' to create CSV output for import into Excel."
 S DIR("?")="Select 'R' to create a standard report."
 D ^DIR
 I $D(DIRUT) Q -1
 Q Y
