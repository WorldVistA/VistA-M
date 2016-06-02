IBCNGPF1 ;ALB/CJS - LIST GRP. PLANS W/O ANNUAL BENEFITS (DRIVER 1) ;21-JAN-15 
 ;;2.0;INTEGRATED BILLING;**528**;21-MAR-94;Build 163
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SELY() ; Prompt user to select annual benefit year
 ;
 ; IBY -- annual benefit year
 ;
 N DIR,X,Y,DIRUT,DUOUT,IBD,IBY
 S IBY=""
 S IBD=+$O(^IBA(355.4,"B",""),-1),IBD=$E($$FMTE^XLFDT(IBD,"7D"),1,4)
 S DIR("?")="Enter the year for which you would like to list Group Plans without Annual Benefits"
 S DIR("A")="Select the Annual Benefit Year",DIR("B")=IBD
 S DIR(0)="DO^::EM" D ^DIR S IBY=$E(Y,1,3)_"1232" I $D(DIRUT)!$D(DUOUT) S IBY=""
 ;
SELYQ Q IBY
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
SELIF() ; Prompt user to select active or inactive insurance companies
 ;
 ; IBIF=0 -- user selects active insurance companies
 ; IBIF=1 -- user selects inactive insurance companies
 ;
 N IBIF
 S DIR(0)="SA^1:1. Active;2:2. Inactive"
 W !!,"     Select a Filter for Insurance Company:",!
 S DIR("A",1)="1. Active"
 S DIR("A",2)="2. Inactive"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 to include active insurance companies"
 S DIR("?")="or 2 to include inactive insurance companies."
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBIF=-1 G SELIFQ
 S IBIF=(+Y=2) K Y
SELIFQ Q IBIF
 ;
SELP() ; Prompt user to select all or subset of plans
 ;
 ; IBV3=0 -- whether some or all ins. co's., user selects plans (may be
 ;           all for certain companies, some for other companies
 ; IBV3=1 -- whether some or all ins. co's., run report for all plans
 ;           associated with those co's.
 ;
 N IBV3
 S DIR(0)="YO",DIR("A")="There are "_$P(^IBA(355.3,0),"^",4)_" plans.  List all plans for each company",DIR("B")="Yes"
 S DIR("?",1)="If you say yes, the report will list all of the plans for each company."
 S DIR("?",2)="If you selected 2. List Insurance Plans by Company With Subscriber"
 S DIR("?",3)="Information and 1. List All "_$P(^IBA(355.3,0),"^",4)_" Ins. Companies,"
 S DIR("?",4)="this will result in the most complete report possible.  However, it"
 S DIR("?",5)="may take awhile to run.  If you say no, you must make plan selections"
 S DIR("?")="for each individual company (anywhere from one plan to all)."
 W ! D ^DIR W ! K DIR I Y<0!$D(DIRUT) S IBV3=-1 G SELPQ
 S IBV3=+Y K Y
SELPQ Q IBV3
 ;
SELPF() ; Prompt user to select active or inactive group plans
 ;
 ; IBPF=0 -- user selects active insurance companies
 ; IBPF=1 -- user selects inactive insurance companies
 ;
 N IBPF
 S DIR(0)="SA^1:1. Active;2:2. Inactive"
 W !!,"     Select a Filter for Group:",!
 S DIR("A",1)="1. Active"
 S DIR("A",2)="2. Inactive"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 to include active group plans"
 S DIR("?")="or 2 to include inactive group plans."
 D ^DIR K DIR I Y<0!$D(DIRUT) S IBPF=-1 G SELPFQ
 S IBPF=(+Y=2) K Y
 ;
SELPFQ Q IBPF
 ;
OUT() ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) Q ""
 Q Y
