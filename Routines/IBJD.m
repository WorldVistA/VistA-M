IBJD ;ALB/CPM - DIAGNOSTIC MEASURES UTILITIES ; 16-DEC-96
 ;;2.0;INTEGRATED BILLING;**69,123**;21-MAR-94
 ;
DS ; Print a (S)ummary or (D)etail Report?
 S DIR(0)="SA^S:SUMMARY;D:DETAILED;"
 S DIR("A")="Do you wish to print a (S)ummary or (D)etailed Report? "
 S DIR("?")="^D HDS^IBJD"
 W ! D ^DIR K DIR S IBRPT=Y
 Q
 ;
SDIV() ; - Sort by division.
 ; Output: SDIV  = 1 - Sort by Division / 0 - Do not sort by Division
 ;                 or "^" - User selected "^"
 ;         VAUTD = 1 - All divisions selected / 0 - Specific divisions
 ;         VAUTD(DIV) = Divsions selected
 ;
 N SDIV,DIR,J
 ;
 K DIR,VAUTD S DIR(0)="Y",DIR("B")="NO" W !
 S DIR("A")="Do you wish to sort this report by division"
 S DIR("T")=DTIME,DIR("?")="^D HDIV^IBJD"
 D ^DIR K DIR
 I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S SDIV="^" G QDIV
 S SDIV=+Y K DIROUT,DTOUT,DUOUT,DIRUT
 I SDIV D PSDR^IBODIV I Y<0 S SDIV="^"
 ;
 ; - Set VAUTD when ALL divisions have been selected
 I SDIV,VAUTD S J=0 F  S J=$O(^DG(40.8,J)) Q:'J  S VAUTD(J)=""
 ;
QDIV Q SDIV
 ;
MLTP(PRPT,OPT,ALL) ; Function for multiple value selection
 ; Input: PRPT - String to be prompted to the user, before listing options
 ;        OPT  - Array containing the possible entries (indexed by code)
 ;               Obs: Code must be sequential starting with 1
 ;        ALL  - Flag indicating if the last option is ALL OF THE ABOVE
 ;
 ; Output: MLTP - User selection, i.e. "1,2,3," or "1," or 0 (nothing
 ;                 was selected)
 ;
 N A,DIR,DIRUT,DTOUT,DUOUT,DIROUT,I,IX,LST,MLTP
 ;
PRPT S MLTP=0,ALL=+$G(ALL)
 S LST=$O(OPT(""),-1)
 S DIR(0)="LO^1:"_LST_"^K:+$P(X,""-"",2)>"_LST_" X"
 S DIR("A",1)=$G(PRPT),DIR("A",2)=""
 S A="",IX=3
 F  S A=$O(OPT(A))  Q:A=""  D
 . S DIR("A",IX)="   "_A_" - "_$G(OPT(A)),IX=IX+1
 S DIR("A",IX)="",DIR("A")="Select",DIR("B")=LST,DIR("T")=DTIME W !
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) G QT
 S MLTP=Y K DIROUT,DTOUT,DUOUT,DIRUT
 ;
 I ALL,MLTP[LST S MLTP=LST_","
 ;
 S DIR(0)="Y",DIR("A",1)="You have selected",DIR("A",2)=""
 S A="",IX=3
 F I=1:1:($L(MLTP,",")-1) D
 . S DIR("A",IX)="    "_$P(MLTP,",",I)_" - "_$G(OPT($P(MLTP,",",I)))
 . S IX=IX+1
 S DIR("A",IX)=""
 S DIR("A")="Are you sure",DIR("B")="NO",DIR("T")=DTIME W !
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) S MLTP=0 G QT
 K DIROUT,DTOUT,DUOUT,DIRUT I 'Y K DIR G PRPT
 ;
 I ALL,MLTP[LST D
 . S MLTP="" F I=(LST-1):-1:1 S MLTP=I_","_MLTP
 ;
QT Q MLTP
 ;
SNL() ; - Determine the sorting of the patient (By Name or Last 4 SSN)
 ; Output: SNL = "N" (Name)/"L" (Last 4 SSN) ^ "NAME" or "LAST 4"
 ;
 N DIR,DIRUT,DTOUT,DUOUT,DIROUT,SNL
 S SNL=""
 S DIR(0)="SA^N:NAME;L:LAST 4"
 S DIR("A")="Sort Patients by (N)AME or (L)AST 4 of the SSN: "
 S DIR("B")="NAME",DIR("T")=DTIME,DIR("?")="^D HNL^IBJD"
 W ! D ^DIR K DIR I Y=""!(X="^") Q "^"
 S SNL=Y
 ;
 Q SNL
 ;
INTV(SORT) ; Selects the interval
 ; Output: First value ^ Last Value ^ "ALL"/"NULL"/""
 ;
 N ALNU,FRST,LAST,X
 ;
 S (ALNU,FRST,LAST)=""
FRST W !!?3,"START WITH "_SORT_": FIRST// " R X:DTIME I '$T!(X["^") Q "^"
 I $E(X)="?" D HFST G FRST
 S FRST=X
LAST W !?8,"GO TO "_SORT_": LAST// " R X:DTIME I '$T!(X["^") Q "^"
 I $E(X)="?" D HLST G LAST
 I X="" S LAST="zzzzz" S:FRST="" ALNU="ALL" G QINT
 I X="@",FRST="@" S LAST="@",ALNU="NULL" G QINT
 I FRST'="@",FRST]X D  G LAST
 .W *7,!!?7,"The LAST value must follow the FIRST.",!
 S LAST=X
 ;
QINT Q (FRST_"^"_LAST_"^"_ALNU)
 ;
EXCEL() ; - Returns whether to catpture data for Excel report.
 ; Output: EXCEL = 1 - YES (capture data) / 0 - NO (DO NOT capture data)
 ;
 N EXCEL,DIR,DIRUT,DTOUT,DUOUT,DIROUT
 ;
 S DIR(0)="Y",DIR("B")="NO",DIR("T")=DTIME W !
 S DIR("A")="Do you want to capture report data for an Excel document"
 S DIR("?")="^D HEXC^IBJD"
 D ^DIR K DIR I $D(DIRUT)!$D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q "^"
 K DIROUT,DTOUT,DUOUT,DIRUT
 S EXCEL=0 I Y S EXCEL=1
 ;
 Q EXCEL
 ;
CLMACT(X,Y) ; - Check if AR has a corresponding claim or IB action.
 ;    Input: X=Claim/AR pointer to file #399/#430
 ;           Y=AR category pointer to file #430.2
 ;   Output: Z=1-IB action, 2-Claim, 3-No IB action or claim
 ;             ^ IB action IEN (if 1) or AR/claim IEN (if 2 or 3)
 ;             OR null=Invalid IB action or claim
 N ACT,BILL,NODE,NODE1,Z S Z="" G:'$G(X)!('$G(Y)) CLACQ
 S BILL=$P($G(^PRCA(430,X,0)),U) G:BILL="" CLACQ
 ;
 ; - Check for most recent IB action.
 S ACT=+$O(^IB("ABIL",BILL,9999999),-1) G:'ACT CLAC1
 S NODE=$G(^IB(ACT,0)) G:NODE="" CLAC1
 I $P(NODE,U,5)'=3!($P(NODE,U,10)) G CLACQ ; Not billed/cancelled. 
 I $P($G(^IBE(350.1,+$P(NODE,U,3),0)),U,3)=Y S Z=1_U_ACT G CLACQ
 ;
CLAC1 ; - Check for IB claim.
 I '$D(^DGCR(399,X,0)) S Z=3_U_X G CLACQ ;           No IB action/claim.
 S NODE=$G(^DGCR(399,X,0)) G:$P(NODE,U,13)=7 CLACQ ; Cancelled claim.
 S NODE1=$G(^DGCR(399.3,+$P(NODE,U,7),0)) G:NODE1="" CLACQ
 I '$P(NODE1,U,3),$P(NODE1,U,6)=Y S Z=2_U_X
CLACQ Q Z
 ;
ALSP(PRPT,FILE,ARR) ; Selection of (A)LL or (S)pecific values from a given file
 ; Input: PRPT  - Piece 1: Label for the PROMPT to be asked for the 
 ;                         selection (in the plural) - e.g. "Providers"
 ;                Piece 2: Singular of piece 1 -  e.g. "Provider"
 ;                Exaple: "Specialties^Specialty"
 ;        FILE  - File global root (e.g., "^IBE(356.8," ) that the values
 ;                will be selected from
 ;        ARR   - Name of the array that will contain the specific values
 ;                (must be passed as a refernce value ".ARR")
 ; Output: ARR  - "A" - ALL values OR "S" - Specific values OR "^"
 ;                The values will be returned in the array indicated in
 ;                ARR parameter 
 ;
 N DIC,PRL,SNG,X
 K ARR S PRL=$P(PRPT,"^"),SNG=$P(PRPT,"^",2) S:SNG="" SNG=PRL
ALSP1 W !!,"Run report for (A)LL or (S)PECIFIC "_PRL_": A// "
 R X:DTIME I '$T!(X["^") S ARR="^" G QALSP
 S X=$S(X="":"A",1:$E(X)) I "AaSs"'[X D HALSP G ALSP1
 W " ",$S("Ss"[X:"SPECIFIC",1:"ALL") I "Aa"[X K ARR S ARR="A" G QALSP
 S ARR="S"
ALSP2 S DIC=FILE,DIC(0)="AEQMZ"
 S DIC("A")="   Select a"_$S($O(ARR(""))'="":"nother",1:"")_" "
 S DIC("A")=DIC("A")_SNG_": "
 D ^DIC K DIC I $D(DTOUT)!($D(DUOUT)) K ARR S ARR="^" G QALSP
 I Y'>0 G ALSP1:$O(ARR(""))="" G QALSP
 I $D(ARR(+Y)) D  G ALSP2
 . W !!?3,"Already selected. Choose another "_SNG,*7,!
 S ARR(+Y)="" G ALSP2
 ;
QALSP Q
 ;
HDS ; Help for Summary/Detail prompt.
 W !,"Please enter 'S' for 'Summary' or 'D' for a Detailed Report."
 W !,"Note that if you select the Detailed report, the Summary will also print."
 Q
 ;
HDIV ; - 'Sort by division...' prompt
 W !!,"      Enter:  '<CR>' -  To print the report without regard to division"
 W !!,"              'Y'    -  To select those divisions for which a separate"
 W !,"                        report should be created"
 W !,"              '^'    -  To quit this option"
 Q
 ;
HNL ; - 'Sort Patients by (N)AME... ' prompt
 W !!,"      Enter:  '<CR>' -  To select and sort patients by name"
 W !!,"              'L'    -  To select and sort patients by the last 4"
 W !,"                        of the SSN"
 W !,"              '^'    -  To quit this option"
 Q
 ;
HFST ; - 'START WITH PATIENT/DEBTOR...' prompt 
 W !!,"      Enter a valid field value, or"
 W !!,"        '@'    -  To include null values"
 W !,"        '<CR>' -  To start from the 'first' value for this field"
 W !,"        '^'    -  To quit this option"
 Q
 ;
HLST ; - 'GO TO PATIENT/DEBTOR' prompt 
 W !!,"      Enter a valid field value, or"
 W !!,"        '@'    -  To include only null values, if 'Start with'"
 W !,"                  value is @"
 W !,"        '<CR>' -  To go to the 'last' value for this field"
 W !,"        '^'    -  To quit this option",!
 Q
 ;
HEXC ; - 'Do you want to capture data...' prompt
 W !!,"      Enter:  'Y'    -  To capture detail report data to transfer"
 W !,"                        to an Excel document"
 W !,"              '<CR>' -  To skip this option"
 W !,"              '^'    -  To quit this option"
 Q
 ;
HALSP ; - 'Run report for (A)LL or (S)pecific...' prompt.
 W !!?6,"Enter: '<CR>' - To select all "_PRL
 W !?16,"'S' - To select one or more "_PRL
 W !?16,"'^' - To quit this option"
 Q
 ;
EXMSG ; - Displays the message about capturing to an Excel file format
 ;
 W !!?5,"Before continuing, please set up your terminal to capture the"
 W !?5,"detail report data. On some terminals, this can  be  done  by"
 W !?5,"clicking  on the 'Tools' menu above, then click  on  'Capture"
 W !?5,"Incoming  Data' to save to  Desktop. This  report  may take a"
 W !?5,"while to run."
 W !!?5,"Note: To avoid  undesired  wrapping of the data  saved to the"
 W !?5,"      file, please enter '0;256;999' at the 'DEVICE:' prompt.",!
 Q
 ;
EXPAND(FILE,FIELD,VALUE) ; Resolve coded data.
 N Y,C S Y=VALUE
 I 'FILE!('FIELD)!(VALUE="") G EXPQ
 S Y=VALUE,C=$P(^DD(FILE,FIELD,0),"^",2) D Y^DIQ
EXPQ Q Y
 ;
DT(X,Y) ; - Return date.
 ;    Input: X=Date in Fileman format
 ;   Output: Z=Date in MMM DD,YYYY format or MMDDYY format if Y=1
 N Z S Z="" G:'$G(X) DTQ
 I $G(Y) S Z=$E(X,4,7)_$E(X,2,3) G DTQ
 N Y S Y=X X ^DD("DD") S Z=$P(Y,"@")
DTQ Q Z
