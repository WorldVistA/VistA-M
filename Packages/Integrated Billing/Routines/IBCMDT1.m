IBCMDT1 ;ALB/VD - INSURANCE PLANS MISSING DATA REPORT (DRIVER 1) ; 10-APR-15
 ;;2.0;INTEGRATED BILLING ;**549**; 10-APR-15;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
SLAI ; Prompt user to select all or subset of insurance companies 
 ; Count ins. companies with plans
 ;
 ; 0 -- user selects insurance companies
 ; 1 -- run report for all insurance companies with plans
 ;
 N A,B
 S (A,B)=0
 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S B=B+1
 S DIR(0)="SA^1:List All "_B_" Ins. Companies;2:List Only Ins. Companies That You Select"
 W !!,"     There are "_B_" insurance companies associated with plans.",!
 S DIR("A",1)="1. List All "_B_" Active Ins. Companies"
 S DIR("A",2)="2. List Only Active Ins. Companies That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLAIQ
 S IBMDTSPC("IBAI")=(+Y=1) K Y
SLAIQ ;
 Q
 ;
SLAPL ; Prompt user to select all or subset of plans
 ;
 ; 0 -- whether some or all ins. co's., user selects plans (may be
 ;      all for certain companies, some for other companies
 ; 1 -- whether some or all ins. co's., run report for all plans
 ;      associated with those co's.
 ;
 S DIR(0)="YO"
 S DIR("A")="There are "_$P(^IBA(355.3,0),"^",4)_" plans.  List all plans for each company"
 S DIR("B")="No"
 S DIR("?",1)="If you say yes, the report will list all of the plans for each company."
 S DIR("?",2)="If you say no, you must make plan selections for each individual company"
 S DIR("?")="(anywhere from one plan to all)."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLAPLQ
 S IBMDTSPC("IBAPL")=+Y K Y
SLAPLQ ;
 Q
 ;
SLGRN ; Prompt user to report missing Group Numbers
 ;
 ; 0 -- Do not print missing Group Numbers.
 ; 1 -- Print missing Group Numbers.
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing Group Number"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Group Number is missing."
 S DIR("?")="If you say no, missing Group Number will not be indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLGRNQ
 S IBMDTSPC("IBGRN")=+Y K Y
SLGRNQ ;
 Q
 ;
SLPTY ; Prompt user to report missing Type of Plan
 ;
 ; 0 -- Do not print missing Type of Plan.
 ; 1 -- Print missing Type of Plan.
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing Type of Plan"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Type of Plan is missing."
 S DIR("?")="If you say no, missing Type of Plan will not be indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLPTYQ
 S IBMDTSPC("IBPTY")=+Y K Y
SLPTYQ ;
 Q
 ;
SLTFT ; Prompt user to report missing Timely Filing Time Frame
 ;
 ; 0 -- Do not print missing Timely Filing Time Frame.
 ; 1 -- Print missing Timely Filing Time Frame.
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing Timely Filing Time Frame"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Timely Filing Time Frame"
 S DIR("?",2)="is missing."
 S DIR("?")="If you say no, missing Timely Filing Time Frame will not be indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLTFTQ
 S IBMDTSPC("IBTFT")=+Y K Y
SLTFTQ ;
 Q
 ;
SLEPT ; Prompt user to report missing Electronic Plan Type
 ;
 ; 0 -- Do not print missing Electronic Plan Type.
 ; 1 -- Print missing Electronic Plan Type.
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing Electronic Plan Type"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Electronic Plan Type is missing."
 S DIR("?")="If you say no, missing Electronic Plan Type will not be indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLEPTQ
 S IBMDTSPC("IBEPT")=+Y K Y
SLEPTQ ;
 Q
 ;
SLCLM ; Prompt user to report missing Coverage Limitations
 ;
 ; 0 -- Do not print missing Coverage Limitations.
 ; 1 -- Print missing Coverage Limitations.
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing Coverage Limitations"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Coverage Limitations is missing."
 S DIR("?")="If you say no, missing Coverage Limitations will not be indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLCLMQ
 S IBMDTSPC("IBCLM")=+Y K Y
SLCLMQ ;
 Q
 ;
SLBIN ; Prompt user to report missing Banking Identification Numbers (BIN)
 ;
 ; 0 -- Do not print missing Banking Identification Numbers (BIN).
 ; 1 -- Print missing Banking Identification Numbers (BIN).
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing BIN"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Banking Identification Number"
 S DIR("?",2)="(BIN) is missing."
 S DIR("?",3)="If you say no, missing Banking Identification Number (BIN) will not be"
 S DIR("?")="indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLBINQ
 S IBMDTSPC("IBBIN")=+Y K Y
SLBINQ ;
 Q
 ;
SLPCN   ; Prompt user to report missing Processor Control Numbers (PCN)
 ;
 ; 0 -- Do not print missing Processor Control Numbers (PCN).
 ; 1 -- Print missing Processor Control Numbers (PCN).
 ;
 S DIR(0)="YO"
 S DIR("A")="Display Active Group(s) missing PCN"
 S DIR("B")="YES"
 S DIR("?",1)="If you say yes, the report will print X's when Processor Control Number"
 S DIR("?",2)="(PCN) is missing."
 S DIR("?",3)="If you say no, missing Processor Control Number (PCN) will not be"
 S DIR("?")="indicated."
 W ! D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SLPCNQ
 S IBMDTSPC("IBPCN")=+Y K Y
SLPCNQ ;
 Q
 ;
