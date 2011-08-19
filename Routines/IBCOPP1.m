IBCOPP1 ;ALB/NLR - LIST INS. PLANS BY CO. (DRIVER 1) ; 15-SEP-94 
 ;;Version 2.0 ; INTEGRATED BILLING ;**28**; 21-MAR-94
 ;
SELR() ; Prompt user to select report type
 ;
 ; IBV1=0 -- list insurance plans by company
 ; IBV1=1 -- list insurance plans by company with subscriber information
 ;
 N IBV1
 S DIR(0)="SA^1:1. List Insurance Plans by Company;2:2. List Insurance Plans by Company With Subscriber Information"
 S DIR("A")="     SELECT REPORT (1 OR 2): "
 S DIR("A",1)="1. List Insurance Plans by Company"
 S DIR("A",2)="2. List Insurance Plans by Company With Subscriber Information"
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBV1=-1 G SELRQ
 S IBV1=(+Y=2) K Y
SELRQ Q IBV1
 ;
SELI() ; Prompt user to select all or subset of insurance companies 
 ; Count ins. companies with plans
 ;
 ; IBV2=0 -- user selects insurance companies
 ; IBV2=1 -- run report for all insurance companies with plans
 ;
 N A,B,IBV2
 S (A,B)=0 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S B=B+1
 S DIR(0)="SA^1:1. List All "_B_" Ins. Companies;2:2. List Only Ins. Companies That You Select"
 W !!,"     There are "_B_" insurance companies associated with plans.",!
 S DIR("A",1)="1. List All "_B_" Ins. Companies"
 S DIR("A",2)="2. List Only Ins. Companies That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBV2=-1 G SELIQ
 S IBV2=(+Y=1) K Y
SELIQ Q IBV2
 ;
SELP() ; Prompt user to select all or subset of plans
 ;
 ; IBV3=0 -- whether some or all ins. co's., user selects plans (may be
 ;           all for certain companies, some for other companies
 ; IBV3=1 -- whether some or all ins. co's., run report for all plans
 ;           associated with those co's.
 ;
 N IBV3
 S DIR(0)="YO",DIR("A")="There are "_$P(^IBA(355.3,0),"^",4)_" plans.  List all plans for each company",DIR("B")="No"
 S DIR("?",1)="If you say yes, the report will list all of the plans for each company."
 S DIR("?",2)="If you selected 2. List Insurance Plans by Company With Subscriber"
 S DIR("?",3)="Information and 1. List All "_$P(^IBA(355.3,0),"^",4)_" Ins. Companies,"
 S DIR("?",4)="this will result in the most complete report possible.  However, it"
 S DIR("?",5)="may take awhile to run.  If you say no, you must make plan selections"
 S DIR("?")="for each individual company (anywhere from one plan to all)."
 W ! D ^DIR W ! K DIR I Y<0!$D(DIRUT) S IBV3=-1 G SELPQ
 S IBV3=+Y K Y
SELPQ Q IBV3
