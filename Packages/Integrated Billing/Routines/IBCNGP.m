IBCNGP ;ALB/CKB - REPORT OF COVERAGE LIMITATIONS (MAIN DRIVER/PROMPTS) ; 07-OCT-2021
 ;;2.0;INTEGRATED BILLING;**702**;21-MAR-94;Build 53
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; ICR #1519-For using the KERNEL routine XUTMDEVQ
 ;
 ; Prompt user to select report type, insurance companies, plans
 ; Output from User Selections:
 ;  IBCNGP("IBOUT")  E-EXCEL, R-REPORT
 ;  IBCNGP("IBI")    0-Selected, 1-All Insurance Companies
 ;  IBCNGP("IBIA")   0-Inactive, 1-Active, 2-Both Active and Inactive Insurance Companies
 ;  IBCNGP("IBIP")   0-Selected, 1-All Group Plans
 ;  IBCNGP("IBIPA")  0-Inactive, 1-Active, 2-Both Active and Inactive Group Plans
 ;  IBCNGP("IBIGN")  1-Group Name, 2-Group Number, 3-Both Group Name and Group Number
 ;  IBCNGP("IBFIL")  A^B^C where"
 ;                    A - 1-Begin with, 2-Contains, 3-Range
 ;                    B - A=1 Begin with text, A=2 Contains text, A=3 Range start text
 ;                    C - only if A=3 Range End text
 ;  IBCNGP("IBICS")  1-Covered, 2-Not Covered, 3-Conditional
 ;                   4-By Default (blank status), 5-All Coverage Statuses 
 ;
 Q   ; Must call EN
 ;
EN ;Main Entry point
 ; Initialize variables 
 N A,DIRUT,DIROUT,DUOUT,DTOUT,FILTER,GIEN,I,IBCNGP,IBCNGPRTN,IBQUIT,IIEN,INACT
 N NGFLG,NGFND,POP,STOP,X,Y,ZTDESC,ZTDEXC,ZTQUEUED,ZTREQ,ZTRTN,ZTSAVE,ZTSTOP,%ZIS
 K ^TMP("IBCNGP",$J)
 S (IBQUIT,STOP)=0
 S IBCNGPRTN="IBCNGP"
 ;
 ; Describe report
 W @IOF
 W !,"Coverage Limitations Report",!
 W !,"This report will generate a list of coverage limitations by company and"
 W !,"group. You must select one, multiple, or all insurance companies and anywhere"
 W !,"from one to all of the plans under each company. The results can be filtered"
 W !,"by coverage limitation status."
 ;
C10 ; All/Selected Insurance Companies
 D SELI I STOP G EXIT
 ;
C20 ; Inactive/Active/Both Insurance Company look-up filter
 D SELA I STOP G EXIT
 ;
C30 ; Insurance Company look-up listman template
 ; Allow user selection of Insurance Companies
 I 'IBCNGP("IBI") D
 . N IBCNS,INSCT,INSNAME
 . D EN^IBCNILK(IBCNGP("IBIA"))
 . I '$D(^TMP("IBCNILKA",$J)) S IBQUIT=1 Q  ; No Insurance Companies selected
 . S INSCT=0
 . S IBCNS="" F  S IBCNS=$O(^TMP("IBCNILKA",$J,IBCNS)) Q:IBCNS=""  D
 . . S INSCT=INSCT+1
 . . ; Add SELECTED Insurance Companies, add to ^TMP("IBCNGP")
 . . S ^TMP("IBCNGP",$J,"INS",INSCT)=IBCNS
 . K ^TMP("IBCNILKA",$J)
 ;
 I IBQUIT W !!,"** No Insurance Companies selected! **",!! S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
 ; If ALL Insurance Companies, add to ^TMP("IBCNGP")
 I IBCNGP("IBI") D
 . S INSCT=0
 . S IIEN=0 F  S IIEN=$O(^DIC(36,IIEN)) Q:'IIEN  D
 . . ; Is the Insurance Company Inactive?
 . . S INACT=+$$GET1^DIQ(36,IIEN_",",.05,"I") ;1=Inactive, 0=Active
 . . I 'INACT,'IBCNGP("IBIA") Q     ; Ins Company is Active and looking for Inactive only
 . . I INACT,(IBCNGP("IBIA")=1) Q   ; Ins Company is Inactive and looking for Active only
 . . S INSCT=INSCT+1
 . . S ^TMP("IBCNGP",$J,"INS",INSCT)=IIEN
 ;
G10 ; All/Selected Group Plans
 D SELG I STOP G EXIT
 ; No Groups found (NGFND=1), type enter to continue and exit
 I $G(NGFND)=1 S DIR(0)="E" D ^DIR K DIR G EXIT
 ;
G20 ; Inactive/Active/Both Group Plan filter
 D SELGA I STOP G EXIT
 ;
G30 ; Group Name/Group Number/Both filter
 D SELGN I STOP G EXIT
 ;
G40 ; Group(s)that Begin/Contain/Range XXX
 S FILTER=$$SELFILT^IBCNGP()
 I +FILTER<0 S STOP=1 I STOP G EXIT
 S IBCNGP("IBFIL")=FILTER
 ;
 ; Obtain Groups Plans for selected or All Insurance Companies
 D START
 I '$D(^TMP("IBCNGP",$J,"INS")) W !!,"** No plans selected! **",!! S DIR(0)="E" D ^DIR K DIR G EXIT
 I STOP G EXIT
 ;
G50 ; Group Coverage Status filter
 D SELCS I STOP G EXIT
 ;
O10 ; Report or CSV output 
 D OUT I STOP G EXIT
 D DEVICE
 ;
EXIT ;
 K ^TMP("IBCNILKA",$J)
 K ^TMP("IBCNGP",$J)
 Q
 ;
DEVICE ;
 N I,POP
 W !!,"We recommend you queue this report as it will take awhile."
 I IBCNGP("IBOUT")="E" D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;256;99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 I IBCNGP("IBOUT")="R" D
 . W !!,"*** You will need a 132 column printer for this report. ***",!
 ;
 ;  IBCNGP = Array of Params
 N POP,ZTDESC,ZTRTN,ZTSAVE
 S ZTRTN="COMPILE^IBCNGP1(""IBCNGP"",.IBCNGP)"
 S ZTDESC="CV - REPORT OF COVERAGE LIMITATION"
 S ZTSAVE("^TMP(""IBCNGP"",$J,")=""
 S ZTSAVE("IBCNGP(")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"Q")   ; ICR # 1519
 ;
ENQ ;
 K ^TMP("IBCNILKA",$J)
 K ^TMP("IBCNGP",$J)
 Q
 ; 
START ; Group Plan look-up listman template
 ; Allow user selection of one or more Group Plans
 ; Input: IBCNGP("IBIP")  0-Selected, 1-All Group Plans
 ;        IBCNGP("IBIPA") 0-Inactive, 1-Active, 2-Both Active and Inactive Group Plans
 ;        IBCNGP("IBIGN") 1-Group Name, 2-Group Number, 3-Both Group Name and Group Number
 ;        IBCNGP("IBFIL") A^B^C where"
 ;                        A - 1-Begin with, 2-Contains, 3-Range
 ;                         B - A=1 Begin with text, A=2 Contains text, A=3 Range start text
 ;                          C - only if A=3 Range End text
 N A,B,CT,GCT,GIEN,IBCT,IBOK,IBSEL,PLANOK,SORT
 S IBQUIT=0
 ;
 ;If Selected Group Plans
 I 'IBCNGP("IBIP") D
 . D SORT
 . S CT=0
 . S A="" F  S A=$O(SORT(A)) Q:A=""!IBQUIT  D
 . . S B="" F  S B=$O(SORT(A,B)) Q:B=""!IBQUIT  D
 . . . D GETGRP
STARTQ ;
 K ^TMP($J,"IBSEL")
 Q
 ;
GETGRP ; Gather Group Plans by Insurance Companies
 S IBCT=SORT(A,B)
 S CT=CT+1
 W !!,"Insurance Company # "_CT_": "_A
 D OK^IBCNSM3
 I IBQUIT S STOP=1 Q
 I 'IBOK K ^TMP("IBCNGP",$J,"INS",IBCT) Q
 W "   ...building a list of plans..."
 K IBSEL,^TMP($J,"IBSEL")
 ;
 ; The Groups listed will be filtered the based on the users selections above 
 D LKP^IBCNSU21(B,1,IBCNGP("IBIPA"),IBCNGP("IBIGN"),IBCNGP("IBFIL"))
 I IBQUIT S STOP=1 Q
 I $G(^TMP($J,"IBSEL",0))=0 D
 . K SORT(A,B),^TMP("IBCNGP",$J,"INS",IBCT)
 . S IBCNGP("IBAI")=0
 ;
 ; Add SELECTED Plans, add to ^TMP("IBCNGP")
 I $G(^TMP($J,"IBSEL",0))>0 D
 . S GCT=0
 . S GIEN=0 F  S GIEN=$O(^TMP($J,"IBSEL",GIEN)) Q:'GIEN  D
 . . S GCT=GCT+1
 . . S ^TMP("IBCNGP",$J,"INS",IBCT,"GRP",GCT)=GIEN
 Q
 ;
SORT ; Sort the currently selected insurance companies into name order
 N IBCT,IIEN,INSNAME
 ;
 S IBCT=""
 F  S IBCT=$O(^TMP("IBCNGP",$J,"INS",IBCT)) Q:IBCT=""!IBQUIT  D
 . S IIEN=^TMP("IBCNGP",$J,"INS",IBCT)
 . S INSNAME=$$GET1^DIQ(36,IIEN,.01)
 . ;IB*702/CKB - if the Insurance Company name doesn't exist, quit to prevent VistA crash
 . I INSNAME="" Q
 . S SORT(INSNAME,IIEN)=IBCT
 Q
 ;
 ;======================================Prompts==========================
SELI ; Prompt user to select all or subset of insurance companies
 ; Count insurance companies with plans
 ; Returns: 0 - User selects insurance companies
 ;          1 - Run report for all insurance companies with plans
 ;     STOP=1 - No selection made
 ;
 N A,B
 S (A,B)=0
 F  S A=$O(^IBA(355.3,"B",A)) Q:'A  S B=B+1
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:List All "_B_" Ins. Companies;2:List Only Ins. Companies That You Select"
 S DIR("A",1)="1 - List All "_B_" Ins. Companies"
 S DIR("A",2)="2 - List Only Ins. Companies That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2.  Only insurance"
 S DIR("?")="companies with one or more plans can be selected."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELIQ
 S IBCNGP("IBI")=(+Y=1) K Y
SELIQ ;
 Q
 ;
SELA ; Prompt user to select Active/Inactive/Both Insurance Companies
 ; Returns: 0 - INACTIVE Insurance Companies Only
 ;          1 - ACTIVE Insurance Companies Only
 ;          2 - Both ACTIVE and INACTIVE Insurance Companies
 ;     STOP=1 - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:ACTIVE;2:INACTIVE;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)="1 - Select ACTIVE Insurance Companies"
 S DIR("A",2)="2 - Select INACTIVE Insurance Companies"
 S DIR("A",3)="3 - Select BOTH"
 S DIR("?",1)="  1 - Only allow selection of ACTIVE Insurance Companies"
 S DIR("?",2)="  2 - Only allow selection of INACTIVE Insurance Companies"
 S DIR("?")="  3 - Allow selection of ACTIVE and INACTIVE Insurance Companies"
 S DIR("B")=1
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELAQ
 S IBCNGP("IBIA")=$S(Y=1:1,Y=2:0,1:2)
SELAQ ;
 Q
 ;
SELG ; Prompt user to select all or subset of group plans
 ; Count of group plans
 ; Returns: 0 - Selected Group Plans
 ;          1 - All Group Plans
 ;     STOP=1 - No selection made
 ;
 N A,A0,A1,CT,INACT
 ;
 ; Get count of Group Plans from Insurance Company(s), ALL or Selected
 S (NGFLG,NGFND)=0
 S CT=0
 S A0=0 F  S A0=$O(^TMP("IBCNGP",$J,"INS",A0)) Q:A0=""  D
 . S A=^TMP("IBCNGP",$J,"INS",A0)
 . I '$D(^IBA(355.3,"B",A)) S NGFLG=1 Q
 . S B=0 F  S B=$O(^IBA(355.3,"B",A,B)) Q:'B  D
 . . S CT=CT+1
 ;
 ; If there are no groups for the selected Ins Company(s),display the following and set NGFND=1
 I 'IBCNGP("IBI"),CT=0 D  Q
 . W !!,"The selected Company(s) does not contain any Groups",!!
 . S NGFND=1,IBCNGP("IBIP")=0
 ;
 ; If there are No Groups found when one or more Ins Company(s) are selected
 ; display the following message
 I NGFLG W !!,"Some Selected Companies do not contain groups and will not display on the report"
 ;
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:List All "_CT_" Group Plans;2:List Only Group Plans That You Select"
 S DIR("A",1)="1 - List All "_CT_" Group Plans"
 S DIR("A",2)="2 - List Only Group Plans That You Select"
 S DIR("A")="     SELECT 1 or 2:  "
 S DIR("?",1)="Enter a code from the list:  1 or 2."
 S DIR("?")="One or more group plans can be selected."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELGQ
 S IBCNGP("IBIP")=(+Y=1) K Y
SELGQ ;
 Q
 ;
SELGA ; Prompt user to select Active/Inactive/Both Group Plans
 ; Input:   None
 ; Returns: 0 - INACTIVE Group Plans Only
 ;          1 - ACTIVE Group Plans Only
 ;          2 - Both ACTIVE and INACTIVE Group Plans
 ;         -1 - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:ACTIVE;2:INACTIVE;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)="1 - Select ACTIVE Group Plans"
 S DIR("A",2)="2 - Select INACTIVE Group Plans"
 S DIR("A",3)="3 - Select BOTH"
 S DIR("?",1)="  1 - Only allow selection of ACTIVE Group Plans"
 S DIR("?",2)="  2 - Only allow selection of INACTIVE Group Plans"
 S DIR("?")="  3 - Allow selection of ACTIVE and INACTIVE Group Plans"
 S DIR("B")=1
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELGAQ
 S IBCNGP("IBIPA")=$S(Y=1:1,Y=2:0,1:2)
SELGAQ ;
 Q
 ;
SELGN ; Prompt user to select Group Name/Group Number/Both filter
 ; Returns: 1   - Group Name
 ;          2   - Group Number
 ;          3   - Both Group Name and Group Number
 ;         -1   - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^1:GROUP NAME;2:GROUP NUMBER;3:BOTH"
 S DIR("A")="     Select 1 or 2 or 3: "
 S DIR("A",1)="1 - Select GROUP NAME"
 S DIR("A",2)="2 - Select GROUP NUMBER"
 S DIR("A",3)="3 - Select BOTH"
 S DIR("?",1)="  1 - Only allow selection of GROUP NAME"
 S DIR("?",2)="  2 - Only allow selection of GROUP NUMBER"
 S DIR("?")="  3 - Allow selection of GROUP NAME and GROUP NUMBER"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELGNQ
 S IBCNGP("IBIGN")=Y
SELGNQ ;
 Q
 ;
SELFILT() ; Group Plan filter
 ; Returns: A^B^C Where:
 ;           A - 1 - Search for Group(s) that begin with
 ;                   the specified text (case insensitive)
 ;               2 - Search for Group(s) that contain
 ;                   the specified text (case insensitive)
 ;               3 - Search for Group(s) in a specified
 ;                   range (inclusive, case insensitive)
 ;               4 - Search for Group(s) that are BLANK or null 
 ;           B - Begin with text if A=1, Contains Text if A=2 or
 ;               the range start if A=3
 ;           C - Range End text (only present when A=3)
 ;         -1 if a valid filter was not selected
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,FILTER,X,XX,Y
 ;
 ; First ask what kind of filter to use
 W !
 S DIR(0)="SA^1:Begins with;2:Contains;3:Range;4:Blank"
 S DIR("A")="     Select 1, 2, 3 or 4: "
 S DIR("A",1)="1 - Select Group(s) that Begin with: XXX"
 S DIR("A",2)="2 - Select Group(s) that Contain: XXX"
 S DIR("A",3)="3 - Select Group(s) in Range: XXX - YYY"
 S DIR("A",4)="4 - Select Group(s) that are BLANK"
 S DIR("?",1)="Select the type of filter to determine what Group(s) will be "
 S DIR("?",2)="displayed as follows:"
 S DIR("?",3)="  Begins with - Displays all group(s) that begin with the"
 S DIR("?",4)="                specified text (inclusive, case insensitive)"
 S DIR("?",5)="  Contains    - Displays all group(s) that contain the"
 S DIR("?",6)="                specified text (inclusive, case insensitive)"
 S DIR("?",7)="  Range       - Displays all group(s) within the "
 S DIR("?",8)="                specified range (inclusive, case insensitive)"
 S DIR("?")="  Blank       - Displays all group(s) that are Blank or null"
 S XX="1:Begins with;2:Contains;3:Range;4:Blank"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S FILTER=Y
 I FILTER=4 G SELFILTQ
 ;
 ; Next ask for 'Begin with', 'Contains' or 'Range Start' text
 W !
 K DIR
 S DIR(0)="F^1;30"
 S XX=$S(FILTER=1:"that begin with",FILTER=2:"that contain",1:"Start of Range")
 S DIR("A")="     Select Group(s) "_XX
 I FILTER=1 D
 . S DIR("?")="Enter the text that each Group(s) will begin with"
 I FILTER=2 D
 . S DIR("?")="Enter the text that each Group(s) will contain"
 I FILTER=3 D
 . S DIR("?")="Enter the starting range text"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S $P(FILTER,"^",2)=Y
 Q:$P(FILTER,"^",1)'=3 FILTER
 ;
 ; Finally, ask for 'Range End' text if using a range filter
 W !
 K DIR
 S DIR(0)="F^1;30"
 S DIR("A")="     Select Group(s) End of Range"
 S DIR("B")=$P(FILTER,"^",2)
 S DIR("?")="Enter the ending Range text"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) Q -1           ; No valid search selected
 S $P(FILTER,"^",3)=Y
SELFILTQ ;
 Q FILTER
 ;
 ;
SELCS ; Prompt user to select Coverage Status of the Group Plan(s)
 ; Input:   None
 ; Returns: 1 - Coverage Status COVERED only
 ;          2 - Coverage Status NOT COVERED only
 ;          3 - Coverage Status CONDITIONAL only
 ;          4 - Coverage Status BY DEFAULT only
 ;          5 - ALL Coverage Statuses
 ;         -1 - No selection made
 ;
 N DIR,DIROUT,DIRUT,DTOUT,XX
 W !
 S DIR(0)="SA^1:COVERED;2:NOT COVERED;3:CONDITIONAL;4:BY DEFAULT(blank status);5:ALL"
 S DIR("A")="     Select 1, 2, 3, 4 or 5: "
 S DIR("A",1)="1 - Select Coverage Status COVERED"
 S DIR("A",2)="2 - Select Coverage Status NOT COVERED"
 S DIR("A",3)="3 - Select Coverage Status CONDITIONAL"
 S DIR("A",4)="4 - Select Coverage Status BY DEFAULT (blank status)"
 S DIR("A",5)="5 - Show all Coverage Statuses"
 S DIR("?",1)="1 - Only allow selection of Coverage Status COVERED"
 S DIR("?",2)="2 - Only allow selection of Coverage Status NOT COVERED"
 S DIR("?",3)="3 - Only allow selection of Coverage Status CONDITIONAL"
 S DIR("?",4)="4 - Only allow selection of Coverage Status BY DEFAULT (blank status)"
 S DIR("?")="5 - Allow selection of All Coverage Statuses"
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G SELCSQ
 S IBCNGP("IBICS")=Y
SELCSQ ;
 Q
 ;
OUT ; Prompt to allow users to select output format
 ; Returns: E - Output to excel
 ;          R - Output to report
 ;     STOP=1 - No Selection made
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 S DIR("?",1)="Select 'E' to create CSV output for import into Excel."
 S DIR("?")="Select 'R' to create a standard report."
 D ^DIR K DIR
 I $D(DIROUT)!$D(DIRUT)!$D(DTOUT)!$D(DUOUT) S STOP=1 G OUTQ
 S IBCNGP("IBOUT")=Y
OUTQ ;  
 Q
