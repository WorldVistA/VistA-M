IBOHLS ;ALB/JWS,BAA - IB HELD CHARGES LIST MANAGER ;08-SEP-2015
 ;;2.0;INTEGRATED BILLING;**554**;21-MAR-94;Build 81
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for HELD CHARGES LIST
 ; add code to do filters here
 N FILTERS
 I '$$FILTER(.FILTERS) Q
 ;
 ; code to do sort
 D SORT
 ;
 D EN^VALM("IBOH HELD CHARGES LIST")
 D ^%ZISC
 Q
 ;
HDR ; -- header code
 ;
 N BDATE,EDATE,INSTS,PATS,IINS,OLDH
 N VAL,T1,D
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S INSTS=$P(FILTERS(0),U,3),PATS=$P(FILTERS(0),U,4)
 S IINS=FILTERS(3)
 ;
 I 'INSTS S T1="All Divisions Selected"
 I INSTS D
 . S T1="Divisions : "
 . S D=0 F  S D=$O(FILTERS(1,D)) Q:D=""  S T1=T1_$S(T1="Divisions : ":"",1:", ")_$P(FILTERS(1,D),"-",2)
 S VALMHDR(1)=T1
 S VALMSG="* No Associated Clinic"
 Q
 ;
INIT ; -- init variables and list array
 ; input - none
 ; output ^TMP($J,"IBOHLS")
 N BDATE,EDATE,INSTS,PATS,IINS,OLDH
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S INSTS=$P(FILTERS(0),U,3),PATS=$P(FILTERS(0),U,4)
 S IINS=FILTERS(3)
 D BLD
 Q
 ;
SORT ; get the data
 N BDATE,EDATE,INSTS,PATS,IINS,OLDH
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S INSTS=$P(FILTERS(0),U,3),PATS=$P(FILTERS(0),U,4)
 S IINS=FILTERS(3),CNT=0
 S ^TMP($J,"IBOHLSF")=FILTERS(0)
 K ^TMP($J,"IBOHLS")
 K ^TMP($J,"IBHOLD")
 K ^TMP($J,"IBOHLS INS")
 ;
 D SORT^IBOHLS1
 Q
 ;
EXPAND ; -- expand code
 D FULL^VALM1
 N I,J,IBXX,VALMY,ECNT,PNAME,DFN,IBHLD0,REC,IBIEN,LST,CLINIC
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S IBXX=0 F  S IBXX=$O(VALMY(IBXX)) Q:'IBXX  D  ;W !,"Entry ",X,"Selected" D
 . K ^TMP($J,"IBOHLE")
 . S REC=$G(^TMP($J,"IBOHLSX",IBXX))
 . S DFN=$P(REC,U,1),PNAME=$P(REC,U,2),ECNT=$P(REC,U,3)
 . S IBIEN=$P(^TMP($J,"IBOHLS",PNAME,ECNT,"IBND"),U,3)
 . S LST=$P(^TMP($J,"IBOHLS",PNAME,ECNT,"IBND"),U,6)
 . S CLINIC=$P(^TMP($J,"IBOHLS",PNAME,ECNT,"IBND"),U,8)
 . Q:IBIEN=""
 . S ^TMP($J,"IBOHLSE")=DFN_U_ECNT_U_PNAME_U_IBIEN_U_LST_U_CLINIC
 . D EN^VALM("IBOH HELD CHARGES EXPAND")
 . Q
 D BLD
 S VALMBCK="R"
 Q
 ;
BLD ; build data to display
 ; build display
 K ^TMP($J,"IBOHLSX")
 K ^TMP("VALMAR",$J)
 N FIRST,VCNT,CNT,NAME,BCNT,RNB,RX,CLINIC,INST,DNAME,FLAG
 S VALMCNT=0
 S (CNT,VCNT)=0,NAME=""
 F  S NAME=$O(^TMP($J,"IBOHLS",NAME)) Q:NAME=""  D
 . S FIRST=1
 . F  S CNT=$O(^TMP($J,"IBOHLS",NAME,CNT)) Q:CNT=""  D
 .. S FLAG="",FLAG=$P(^TMP($J,"IBOHLS",NAME,CNT,"IBND"),U,7)
 .. S INST="",INST=$P(^TMP($J,"IBOHLS",NAME,CNT,"IBND"),U,6)
 .. S CLINIC="",CLINIC=$P(^TMP($J,"IBOHLS",NAME,CNT,"IBND"),U,8)
 .. S VCNT=VCNT+1
 .. S LINE=$$SETL("",VCNT,"",1,5) ;line#
 .. S XX=^TMP($J,"IBOHLS",NAME,CNT)
 .. S DFN=$P(^TMP($J,"IBOHLS",NAME,CNT,"IBND"),U,1)
 .. S DNAME=FLAG_$P(XX,U)
 .. S LINE=$$SETL(LINE,DNAME,"",6,21)
 .. S LINE=$$SETL(LINE,$P(XX,U,2),"",28,6)
 .. S LINE=$$SETL(LINE,$P(XX,U,3),"",37,6)
 .. S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(XX,U,4),"2DZ"),"",44,8)
 .. S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(XX,U,5),"2DZ"),"",54,8)
 .. S LINE=$$SETL(LINE,$P(XX,U,6),"",64,5)
 .. S LINE=$$SETL(LINE,$J($P(XX,U,7),8,2),"",72,8)
 .. S VALMCNT=VALMCNT+1
 .. D SET^VALM10(VALMCNT,LINE,VCNT)
 .. S LINE=$$SETL("","Division: "_INST_" - "_CLINIC,"",6,60)
 .. S VALMCNT=VALMCNT+1
 .. D SET^VALM10(VALMCNT,LINE,VCNT)
 .. S ^TMP($J,"IBOHLSX",VCNT)=DFN_U_NAME_U_CNT_U_INST_U_FLAG_U_CLINIC
 .. I $D(^TMP($J,"IBOHLS",NAME,CNT,1)) D
 ... S RX=^TMP($J,"IBOHLS",NAME,CNT,1),RX="Rx#:"_RX
 ... S LINE=$$SETL("",RX,"",37,20)
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 .. I $D(^TMP($J,"IBOHLS",NAME,CNT,2)) D
 ... S BCNT=0 F  S BCNT=$O(^TMP($J,"IBOHLS",NAME,CNT,2,BCNT)) Q:BCNT=""  D
 .... S XX=^TMP($J,"IBOHLS",NAME,CNT,2,BCNT)
 .... S LINE=$$SETL("","Bill: ","",6,6)
 .... S LINE=$$SETL(LINE,$P(XX,U),"",14,10)
 .... S LINE=$$SETL(LINE,$P(XX,U,2),"",26,10)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(XX,U,3),"2DZ"),"",38,10)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(XX,U,4),"2DZ"),"",50,10)
 .... S LINE=$$SETL(LINE,$P(XX,U,5),"",62,4)
 .... S LINE=$$SETL(LINE,$J($P(XX,U,6),8,2),"",68,10)
 .... S VALMCNT=VALMCNT+1
 .... D SET^VALM10(VALMCNT,LINE,VCNT)
 .... S RNB=$P(XX,U,7)
 .... I RNB'="" D
 ..... S LINE=$$SETL("","RNB: ","",6,6)
 ..... S LINE=$$SETL(LINE,RNB,"",14,60)
 ..... S VALMCNT=VALMCNT+1
 ..... D SET^VALM10(VALMCNT,LINE,VCNT)
 .. I $D(^TMP($J,"IBOHLS INS",NAME)),FIRST D  ; IF DISPLAYING INSURANCE INFORMATION
 ... S FIRST=0
 ... N ZZ,ZZ1,ZZ2
 ... S LINE=$$SETL("","Insurance","",6,9)
 ... S LINE=$$SETL(LINE,"Subscriber","",24,10)
 ... S LINE=$$SETL(LINE,"Group","",42,5)
 ... S LINE=$$SETL(LINE,"Eff Dt","",58,6)
 ... S LINE=$$SETL(LINE,"Exp Dt","",70,6)
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 ... S VALMCNT=VALMCNT+1
 ... S $P(ZZ2,"-",78)=""
 ... S LINE=$$SETL("",ZZ2,"",6,78)
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 ... S ZZ=0 F  S ZZ=$O(^TMP($J,"IBOHLS INS",NAME,ZZ)) Q:ZZ=""  D 
 .... S ZZ1=^TMP($J,"IBOHLS INS",NAME,ZZ)
 .... S LINE=$$SETL("",$P(ZZ1,U),"",6,15)
 .... S LINE=$$SETL(LINE,$P(ZZ1,U,2),"",24,15)
 .... S LINE=$$SETL(LINE,$P(ZZ1,U,3),"",42,14)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(ZZ1,U,4),"2DZ"),"",58,10)
 .... S LINE=$$SETL(LINE,$$FMTE^XLFDT($P(ZZ1,U,5),"2DZ"),"",70,10)
 .... S VALMCNT=VALMCNT+1
 .... D SET^VALM10(VALMCNT,LINE,VCNT)
 .... I '$O(^TMP($J,"IBOHLS INS",NAME,ZZ,0)) Q
 .... S LINE=$$SETL("","Plan Coverage   Eff. Date     Covered?       Limit Comments","",10,60)
 .... S VALMCNT=VALMCNT+1
 .... D SET^VALM10(VALMCNT,LINE,VCNT)
 .... S ZZ2=0 F  S ZZ2=$O(^TMP($J,"IBOHLS INS",NAME,ZZ,ZZ2)) Q:ZZ2=""  D
 ..... S ZZ1=^TMP($J,"IBOHLS INS",NAME,ZZ,ZZ2)
 ..... S LINE=$$SETL("",$P(ZZ1,U),"",10,15)
 ..... S LINE=$$SETL(LINE,$P(ZZ1,U,2),"",27,8)
 ..... S LINE=$$SETL(LINE,$P(ZZ1,U,3),"",40,12)
 ..... S LINE=$$SETL(LINE,$P(ZZ1,U,4),"",55,25)
 ..... S VALMCNT=VALMCNT+1
 ..... D SET^VALM10(VALMCNT,LINE,VCNT)
 Q
 ;
SETL(LINE,DATA,LABEL,COL,LNG) ; Creates a line of data to be set into the body
 ; of the worklist
 ; Input: LINE - Current line being created
 ; DATA - Information to be added to the end of the current line
 ; LABEL - Label to describe the information being added
 ; COL - Column position in line to add information add
 ; LNG - Maximum length of data information to include on the line
 ; Returns: Line updated with added information
 S LINE=LINE_$J("",(COL-$L(LABEL)-$L(LINE)))_LABEL_$E(DATA,1,LNG)
 Q LINE
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP($J,"IBOHLSF")
 K ^TMP($J,"IBOHLS")
 K ^TMP($J,"IBHOLD")
 K ^TMP($J,"IBOHLS INS")
 ;
 D CLEAR^VALM1,CLEAN^VALM10
 D ^%ZISC
 Q
 ;
FILTER(FILTERS) ; filter display
 ; Sets an array of filters to determine which entris to include in display
 ; Input:   None
 ; Output:  
 ; Returns: 0 if the user entered '^' or timed out, 1 otherwise
 ; FILTERS(0) = from date ^ to date ^ 0 (all) 1 (selected) institutions ^ 0 (all) 1 (selected) patients
 ; FILTERS(1,inst ien) = "" 
 ; FILTERS(2,pat ien) = ""
 ; FILTERS(3) = 0 (NO) 1 (YES) to include insurance information
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y,IBDATES
 K FILTERS
 ; get date range
 S IBDATES="Date of Service",IBDATES=$$FMDATES(IBDATES) I IBDATES=0 Q 0
 S FILTERS(0)=IBDATES
 ;
 ; Site (Division) filter
 W !
 D PSDR^IBODIV
 D CHKFILT
 ;
 ; Patient filter
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Patient(s):",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to not filter by Patient."
 S DIR("?")="Enter 'S' to view entries for selected Patients."
 S $P(DIR(0),U,2)="A:All Patients;S:Selected Patients"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U,4)=$S(Y="A":0,1:1)
 ; Set Patient / Veteran filter
 I $P(FILTERS(0),U,4)=1 D ASKPAT(.FILTERS)
 ;
 S DIR(0)="Y",DIR("A")="Include Insurance information on the Held Charges list",DIR("B")="NO"
 S DIR("?",1)="     Enter:  'Y'  -  to include patient insurance information on the Held Charges list"
 S DIR("?",2)="             'N'  -  to exclude patient insurance information on the Held Charges list"
 S DIR("?",3)="             '^'  -  to exit this option"
 D ^DIR K DIR
 I $G(DIRUT) Q 0
 S FILTERS(3)=+Y
 D SHOWFILT(.FILTERS)
 I X="^" Q 0
 Q 1
 ;
FMDATES(PROMPT) ; ask for date range
 N %DT,X,Y,DT1,DT2,IB0,IB1,IB2
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Date(s):",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to view all Dates."
 S DIR("?")="Enter 'S' to view entries for selected Dates."
 S $P(DIR(0),U,2)="A:All Dates;S:Selected Dates"
 W ! D ^DIR K DIR
 I X="^" Q 0
 I $G(DIRUT) Q 0
 I $E(Y)="A" S DT1=0_U_DT G FMDQ
 S DT1="",IB1="Start with date entered: ",IB2="Go to date entered: "
 I $G(PROMPT)'="" S IB1="Start with "_PROMPT_": ",IB2="Go to "_PROMPT_": "
 S %DT="AEX",%DT("A")=IB1 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>DT S %DT("B")="Today"
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S DT1=DT2_U_$P(Y,".",1)
FMDQ Q DT1
 ;
 ;
ASKPAT(FILTERS)   ; Sets a list of patients
 ; the HCSR Worklist
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N CLINS,DIC,DIR,DIRUT,IBDIVS,DUOUT,FIRST,IBIENS,IBIENS2,IEN,N,NM,NODE,WARDS,X,XX,Y
 S DIC(0)="AEQMN",DIC="^DPT(",FIRST=1
 F  D  Q:+IEN<1
 . D ONEPAT(.DIC,.IEN,.FIRST)               ; One patient
 . Q:+IEN<1
 . S IBIENS($P(IEN,U,2))=$P(IEN,U,1)
 . S IBIENS2($P(IEN,U,1))=$P(IEN,U,2)
 I '$D(IBIENS) S $P(FILTERS(0),U,4)=0 Q
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(IBIENS(XX))
 . Q:XX=""
 . S N=IBIENS(XX)
 . S FILTERS(2,N)=""
 . ;S FILTERS(2)=$S($G(FILTERS(2))'="":FILTERS(2)_U_N,1:N)
 Q
 ;
ONEPAT(DIC,IEN,FIRST)  ; Prompts the user for a clinic or ward
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Ward or clinic Entry
 ;                    null of no selection was made
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC("A")=$S(FIRST:"Select Patient: ",1:"Select Another Patient: ")
 D ^DIC
 S FIRST=0,IEN=Y
 S DFN=+Y
 Q
 ;
SHOWFILT(FILTERS)   ;EP
 ; Displays the currently selected filter selections for the
 ; Held Charges ListManager display
 ; Input:   FILTERS()   - Array of filter settings. See FILTERS for a detailed
 ;                        explanation of the FILTERS array
 ; Output:  Current Filter settings are displayed
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,IX,LEN,XX,PFLG,STDT
 S STDT=$P(FILTERS(0),U)
 W !!!,"Show From Date: ",$S(STDT=0:"First",1:$$FMTE^XLFDT(STDT,"2DZ"))
 W !,"     Thru Date: ",$$FMTE^XLFDT($P(FILTERS(0),U,2),"2DZ")
 W !,"Show All Divisions or Selected Divisions: "
 W $S($P(FILTERS(0),U,3)=0:"All",1:"Selected")
 ;
 ; Division list (if any)
 I ($P(FILTERS(0),U,3)=1) D
 . S LINE="Divisions to Display: "
 . S IEN=0,PFLG=0
 . F  S IEN=$O(FILTERS(1,IEN)) Q:IEN=""  D
 . . S XX=$$GET1^DIQ(4,IEN_",",.01)
 . . S LINE=LINE_$S(LINE="Divisions to Display: ":"",1:", ")_XX
 . W !,$$WRAP(.LINE,.PFLG,80)
 . F I=0:0 Q:'PFLG  W !,?22,$$WRAP(.LINE,.PFLG,58)
 ;
 W !,"Show All Patients or Selected Patients: "
 W $S($P(FILTERS(0),U,4)=0:"All",1:"Selected")
 ; Patient Inclusion list (if any)
 I ($P(FILTERS(0),U,4)=1) D
 . S LINE="Patients to Display: "
 . S IEN=0,PFLG=0
 . F  S IEN=$O(FILTERS(2,IEN)) Q:IEN=""  D
 . . S XX=$$GET1^DIQ(2,IEN_",",.01)
 . . S LINE=LINE_$S(LINE="Patients to Display: ":"",1:", ")_XX
 . W !,$$WRAP(.LINE,.PFLG,80)
 . F I=0:0 Q:'PFLG  W !,?21,$$WRAP(.LINE,.PFLG,60)
 ;
 W !,"Include Insurance information on the Held Charges list? ",$S(FILTERS(3)=1:"Yes",1:"No")
 K DIR
 D PAUSE^VALM1
 Q
 ;
WRAP(STR,FLG,CL) ;
 ; STR - STRING TO BE WRAPPED PASSED IN BE REFERENCE SO IT CONTAINS THE REMAING PORTION OF STRING
 ; FLG - FLAG TO INDICATE WRAPPING NEEDS TO OCCUR
 ; CL - COLUMN LENGTH
 ;
 ; NO WRAPPING REQUIRED
 I $L(STR)'>CL S FLG=0 Q STR
 S FLG=1
 N A,B,C
 ; POSITION AFTER COLUMN WIDTH BREAK IS A SPACE
 I $E(STR,CL+1)=" " S B=$E(STR,1,CL),STR=$E(STR,CL+2,999) Q B
 S A=$E(STR,1,CL)
 ; NO SPACES WITHIN COLUMN WITH, JUST BREAK AT COLUMN WIDTH
 I $L(A," ")=1 S STR=$E(STR,CL+1,999) Q A
 ; BREAK ON LAST SEMICOLON PIECE WITHIN COLUMN WIDTH
 S C=$L(A," ")
 S B=$P(A," ",1,C-1)
 S STR=$P(A," ",C)_$E(STR,CL+1,999)
 Q B
 ;
CHKFILT ; Check Filters
 N IBSTAT,IBXX,IBXXX,IBXXXX,IBFST,IBDIVS
 I $G(VAUTD)=1 S $P(FILTERS(0),U,3)=0,IBDIVS="All"
 I $G(VAUTD)=0 D
 .S $P(FILTERS(0),U,3)=1
 .S IBSTAT=0,IBFST=1
 .F  S IBSTAT=$O(VAUTD(IBSTAT)) Q:IBSTAT=""  D
 ..S IBXX=$E($$GET1^DIQ(40.8,IBSTAT_",",.01),1,15)
 ..S IBXXX=$$GET1^DIQ(40.8,IBSTAT_",",1,"E")
 ..S IBXXXX=$$GET1^DIQ(40.8,IBSTAT_",",.07,"I")
 ..I 'IBFST S IBDIVS=IBDIVS_","_IBXX_"-"_IBXXX
 ..I IBFST S IBFST=0,IBDIVS=IBXX_"-"_IBXXX
 ..S FILTERS(1,IBXXXX)=IBXX_"-"_IBXXX
 Q
