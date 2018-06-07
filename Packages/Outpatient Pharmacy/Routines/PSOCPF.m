PSOCPF ;BIR/BAA - Pharmacy CO-PAY Application Utilities for IB ;02/06/92
 ;;7.0;OUTPATIENT PHARMACY;**463**;DEC 1997;Build 36
 ;
EN ; -- main entry point for HELD CHARGES LIST
 ;
 ; add code to do filters here
 N FILTERS,PNAME
 I '$$FILTER(.FILTERS) Q
 ;
 ; code to do sort
 D SORT
 ;
 K XQORS,VALMEVL D EN^VALM("PSO PATIENT MEDICATION LIST")
 D ^%ZISC
 Q
 ;
HDR ; -- header code
 ;
 S VALM("TITLE")=" Patient Medications "
 Q
 ;
INIT ; -- init variables and list array
 ; input - ^TMP($J,"PSOCPF")
 ; output - ^TMP("VALMAR",$J)
 N BDATE,EDATE,MEDSA,PAT,RXS
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S RXS=$P(FILTERS(0),U,3),PAT=$P(FILTERS(0),U,4)
 D BLD
 Q
 ;
SORT ; get the data
 N BDATE,EDATE,MEDS,PAT,RXS
 S BDATE=$P(FILTERS(0),U,1),EDATE=$P(FILTERS(0),U,2)
 S MEDS=$P(FILTERS(0),U,3),PAT=$P(FILTERS(0),U,4)
 S RXS=$P(FILTERS(0),U,3)
 S ^TMP($J,"PSOCPFF",0)=FILTERS(0)
 ;
 D SORT^PSOCPF1
 Q
 ;
BLD ; build data to display
 ; build display
 ; ^TMP($J,"PSOCPF",PTNM,RIEN,RFL)=PTNM_U_PID_U_MED_U_RIEN_U_RFL_U_ARTRN_U_RX_U_FILDT_U_BLNO_U_ARST1_U_SC_U_SCP_U_MTSD_U_MTS_U_DFN_U_PBIL_U_ARST_U_PRIEN
 K ^TMP($J,"PSOCPFX"),^TMP($J,"PSOCPFE")
 K ^TMP("VALMAR",$J)
 N LINE,VCNT
 I '$D(^TMP($J,"PSOCPF")) D  Q
 . S VCNT=1
 . S LINE=$$SETL("","","",1,4)
 . S LINE=$$SETL(LINE,"NO DATA FOUND FOR ENTERED CRITERIA","",5,50)
 . S VALMCNT=1
 . D SET^VALM10(VALMCNT,LINE,VCNT)
 N RFL,VCNT,MED,NAME,RFL,SC,SCP,FILDT,BLN,IBST1,MTS,RX,REC,VALMY,ARST1,BLNO,CPY,CPYO
 N DFN,MTO,MTSD,MTSO,PBIL,PID,PRIEN,RIEN,RXO,RXS,SCO,SCOO,SCPO,DEBTOR
 S VALMCNT=0
 S (RIEN,VCNT)=0,(NAME,RFL)=""
 F  S NAME=$O(^TMP($J,"PSOCPF",NAME)) Q:NAME=""  D
 . F  S RIEN=$O(^TMP($J,"PSOCPF",NAME,RIEN)) Q:RIEN=""  D
 .. F  S RFL=$O(^TMP($J,"PSOCPF",NAME,RIEN,RFL)) Q:RFL=""  D
 ... S VCNT=VCNT+1
 ... S LINE=$$SETL("",VCNT,"",1,4) ;line#
 ... S REC=^TMP($J,"PSOCPF",NAME,RIEN,RFL),PID=$P(REC,U,2),ARST1=$P(REC,U,10),PBIL=$P(REC,U,16)
 ... S MED=$P(REC,U,3),RX=$P(REC,U,7),BLN=$P(REC,U,9),FILDT=$P(REC,U,8),DFN=$P(REC,U,15)
 ... S PRIEN=$P(REC,U,18),CPY=$P(REC,U,20),DEBTOR=$P(REC,U,21)
 ... S ^TMP($J,"PSOCPFX",VCNT)=NAME_U_DFN_U_MED_U_RIEN_U_BLN_U_PRIEN_U_RFL_U_RX_U_DEBTOR
 ... I $D(^TMP($J,"PSOCPFC",NAME,RIEN,RFL)) S ARST1="CANCELLED CHARGE"
 ... S RXO="Rx#:"_RX_"-"_RFL
 ... S BLNO="BIL#:"_BLN
 ... S SC=$P(REC,U,11),SCO=$S(SC=1:"YES",1:"NO"),SCOO="SC:"_SCO
 ... S SCP=$P(REC,U,12),SCPO="SC%:"_+SCP
 ... S MTSD=$P(REC,U,13),MTO="DT:"_MTSD
 ... S MTS=$P(REC,U,14),MTSO="MT:"_MTS
 ... S CPYO="RX:"_CPY
 ... S ^TMP($J,"PSOCPFE",NAME,RIEN,RFL)=NAME_U_PID_U_MED_U_RX_"-"_RFL_U_$$FMTE^XLFDT(FILDT,"2DZ")_U_BLN_U_ARST1_U_SCO_U_SCP_"%"_U_MTS_U_MTSD_U_CPY
 ... S LINE=$$SETL(LINE,NAME,"",5,22)
 ... S LINE=$$SETL(LINE,PID,"",28,6)
 ... S LINE=$$SETL(LINE,MED,"",35,16)
 ... S LINE=$$SETL(LINE,$$FMTE^XLFDT(FILDT,"2DZ"),"",53,8)
 ... S LINE=$$SETL(LINE,ARST1,"",62,17)
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 ... S LINE=$$SETL("",SCOO,"",5,8)
 ... S LINE=$$SETL(LINE,SCPO,"",14,8)
 ... S LINE=$$SETL(LINE,RXO,"",35,20)
 ... S LINE=$$SETL(LINE,BLNO,"",62,17)
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 ... S LINE=$$SETL("",MTSO,"",5,20)
 ... S LINE=$$SETL(LINE,MTO,"",35,16)
 ... S LINE=$$SETL(LINE,CPYO,"",53,25)
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
 ... S LINE=""
 ... S VALMCNT=VALMCNT+1
 ... D SET^VALM10(VALMCNT,LINE,VCNT)
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
 K ^TMP($J,"PSOCPF")
 K ^TMP($J,"PSOCPFX")
 K ^TMP($J,"PSOCPFE")
 K ^TMP($J,"PSOCPFC")
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
 ; FILTERS(0) = from date ^ to date ^ 0 (all) 1 (selected) prescriptions ^ patient ^
 ;                                    0 (no) 1 (yes) exclued canceled bills
 ; FILTERS(1,RX ien) = ""
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,XX,Y,IBDATES,DFN,R
 K FILTERS
 ;
 S DIC(0)="AEQMN",DIC="^DPT(",FIRST=1
 S PAT=$$ONEPAT()
 I PAT=-1 Q 0
 S PNAME=$P(PAT,U,2)
 S (DFN,PAT,$P(FILTERS(0),U,4))=$P(PAT,U,1)
 ;
 ; get date range
 S IBDATES="Fill Dates",IBDATES=$$FMDATES(IBDATES) I IBDATES=0 Q 0
 S $P(FILTERS(0),U,1)=$P(IBDATES,U,1)
 S $P(FILTERS(0),U,2)=$P(IBDATES,U,2)
 ;
 ; Prescription filter
 D ADDRX
 I Y=-1 Q 0
 ;
 S ^TMP($J,"PSOCPFF",0)=FILTERS(0)
 S R=""
 F  S R=$O(FILTERS(1,R)) Q:R=""  S ^TMP($J,"PSOCPFF",1,R)=FILTERS(1,R)
 ;
 D SHOWFILT(.FILTERS)
 I X="^" Q 0
 Q 1
 ;
ADDRX ; 
 ; Prescription filter
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Prescription(s)",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to not filter by Prescriptions."
 S DIR("?")="Enter 'S' to view entries for selected Prescription(s)."
 S $P(DIR(0),U,2)="A:All Prescriptions;S:Selected Prescriptions"
 W ! D ^DIR K DIR
 I Y=-1 Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U,3)=$S(Y="A":0,1:1)
 ;
 I $P(FILTERS(0),U,3)=1 D ASKRX(.FILTERS)
 ;
 Q
 ;
FMDATES(PROMPT,SDT,EDT) ; ask for date range
 N %DT,X,Y,DT1,DT2,IB0,IB1,IB2
 S DT1="",IB1="Start with date entered: ",IB2="Go to date entered: "
 I $G(PROMPT)'="" S IB1="Start with "_PROMPT_": ",IB2="Go to "_PROMPT_": "
 I $D(SDT) K %DT S Y=SDT D DD^%DT S %DT("B")=Y
 ;
 S %DT="AEX",%DT("A")=IB1 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S (%DT(0),DT2)=$P(Y,".",1) I DT2'>DT,'$D(EDT) S %DT("B")="Today"
 ; 
 I $D(EDT) K %DT S Y=EDT D DD^%DT S %DT("B")=Y
 ;
 S %DT="AEX",%DT("A")=IB2 D ^%DT K %DT I Y<0!($P(Y,".",1)'?7N) G FMDQ
 S DT1=DT2_U_$P(Y,".",1)
FMDQ Q DT1
 ;
ASKRX(FILTERS)   ; Sets a list of PrescriptionS to be displayed
 ; Input:   FILTERS - Current Array of filter settings
 ; Output:  FILTERS - Updated Array of filter settings
 N DIC,DIR,DIRUT,DIVS,DUOUT,FIRST,PSOIENS,PSOIENS2,IEN,N,X,XX,Y
 S DIC=52,DIC(0)="AEQMN",FIRST=1
 K FILTERS(1)
 F  D  Q:+IEN<1
 . D ONERX(.DIC,.IEN,.FIRST)                   ; One Prescription prompt
 . Q:+IEN<1
 . S PSOIENS($P(IEN,U,2))=$P(IEN,U,1)
 . S PSOIENS2($P(IEN,U,1))=$P(IEN,U,2)
 I '$D(PSOIENS) S $P(FILTERS(0),U,3)=0 Q
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(PSOIENS(XX))
 . Q:XX=""
 . S N=PSOIENS(XX)
 . S FILTERS(1,N)=XX
 Q
 ;
ONERX(DIC,IEN,FIRST)  ; Prompts the user for a Medication
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Division
 ;                    null of no selection was made
 S DIC("A")=$S(FIRST:"Select a Prescription: ",1:"Select Another Prescription: ")
 D ^DIC
 S FIRST=0,IEN=Y
 Q
 ;
ONEPAT(DIC,IEN,FIRST)  ; Prompts the user for a clinic or ward
 ; Input:   DIC     - Variable/Array of settings needed for ^DIC call
 ;          FIRST   - Set to 1 initially and then 0 for subsequent calls
 ; Output:  FIRST   - Set to 0
 ;          IEN     - IEN of the selected Patient
 ;                    null of no selection was made
 N DPTNOFZY S DPTNOFZY=1  ;Suppress PATIENT file fuzzy lookups
 S DIC(0)="AEQMN",DIC="^DPT("
 S DIC("A")="Select Patient: "
 D ^DIC
 Q Y
 ;
 ;
SHOWFILT(FILTERS)   ;EP
 ; Displays the currently selected filter selections for the
 ; Held Charges ListManager display
 ; Input:   FILTERS()   - Array of filter settings. See FILTERS for a detailed
 ;                        explanation of the FILTERS array
 ; Output:  Current Filter settings are displayed
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,IX,LEN,LINE,XX,PFLG,STDT,R,PAT,ENDT,STDT,I
 ;
 W !!,"Selected Patient: ",PNAME
 ;
 S STDT=$P(FILTERS(0),U),ENDT=$P(FILTERS(0),U,2)
 W !,"Show From Date: ",$S(STDT=0:"First",1:$$FMTE^XLFDT(STDT,"2DZ"))
 W !,"     Thru Date: ",$$FMTE^XLFDT(ENDT,"2DZ")
 W !,"Show All Prescriptions or Selected Prescriptions: "
 W $S($P(FILTERS(0),U,3)=0:"All",1:"Selected")
 ;
 ; RX list (if any)
 I ($P(FILTERS(0),U,3)=1) D
 . S LINE="Prescriptions to Display: "
 . S IEN=0,PFLG=0
 . F  S IEN=$O(FILTERS(1,IEN)) Q:IEN=""  D
 . . S XX=FILTERS(1,IEN)
 . . S LINE=LINE_$S(LINE="Prescriptions to Display: ":"",1:", ")_XX
 . W !,$$WRAP(.LINE,.PFLG,80)
 . F I=0:0 Q:'PFLG  W !,?22,$$WRAP(.LINE,.PFLG,58)
 ;
 K DIR
 D PAUSE^VALM1
 Q
 ;
WRAP(STR,FLG,CL) ;
 ; STR - STRING TO BE WRAPPED PASSED IN BY REFERENCE SO IT CONTAINS THE REMAING PORTION OF STRING
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
