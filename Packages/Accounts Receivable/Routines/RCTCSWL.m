RCTCSWL ;ALB/PAW-Cross Servicing Worklist ;30-SEP-2015
 ;;4.5;ACCOUNTS RECEIVABLE;**315**;Mar 20, 1995;Build 67
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Call to EN^DGRPD supported by DBIA# 10037
 ; Call to EN1AR^IBECEA supported by DBIA# 4047
 ;
EN ; -- Main entry point for RCTCSP RECONCILIATION WORKLIST
 N FILTERS,RCRPT,RCDIVS,RCBEG,RCEND,DAT,RCSC1,RCSC2,DIV,RCDPFXIT,RCRSN,RCRPTX,RCIENS,RCDIV
 I '$$FILTER(.FILTERS) Q
 S RCRPT=$P($G(FILTERS(0)),U,1)
 K XQORS,VALMEVL
 D EN^VALM("RCTCSP WORKLIST")  ;Looks at List Template RCTCSP WORKLIST
 Q
 ;
INIT ; Initialize variables
 D KILLGLB
 S RCRPT=$P(FILTERS(0),U,1)
 ;
 I RCRPT["," F RCRSN=1:1 S RCRPTX=$P(RCRPT,",",RCRSN) Q:RCRPTX=""  D GETRPT^RCTCSWL1(RCRPTX)
 I RCRPT'["," D GETRPT^RCTCSWL1(RCRPT)
 I '$D(^TMP("RCTCSWL",$J)) D  Q
 .W !!,*7,"The report found no patient data that meets the criteria selected.",!
 .S DIR(0)="E"
 .D ^DIR
 .S VALMQUIT=1
 .D EXIT
 ; If Excel Selected
 I EXCEL D  Q
 .D EXCEL^RCTCSWL1
 .S DIR(0)="E"
 .D ^DIR
 .S VALMQUIT=1
 .D EXIT
 ; If List Manager Selected
 I 'EXCEL D BLDWL^RCTCSWL1
 Q
 ;
HDR ; Set header for CS Worklist
 N RCDIVS,RCX
 I SORTBY=2 S VALMCAP="    Bill No.     Pt ID  Patient                   Balance  Ret Rsn       "
 I SORTBY=3 S VALMCAP="    Ret Rsn Bill No.     Pt ID  Patient                    Balance       "
 S RCX=$P(FILTERS(0),U,1)  ;Report
 S VALMHDR(1)=$S(RCX=1:"Bankruptcy",RCX=2:"Deaths",RCX=3:"Uncollectible",RCX=4:"Paymt. in Full",RCX=5:"Satisfied PA",RCX=6:"Compromise",RCX=7:"All Returns",1:"")
 D
 . I RCX[7 S VALMHDR(1)="Reconciliation "_VALMHDR(1)_" Report" Q
 . ;I RCX'[7 S VALMHDR(1)="Reconciliation Reports Selected: "_$P(RCX,",",$TR(1,"Bankruptcy"))_", "_$TR(2,"Deaths")_", "_$TR(3,"Uncollectible")_", "_$TR(4,"Payment in Full")_", "_$TR(5,"Satisfied PA")_", "_$TR(6,"Compromise")
 . N X S X="" F I=1:1:6 I RCX[I S X=X_$S(X="":"",1:", "),X=X_$S(I=1:"Bankruptcy",I=2:"Deaths",I=3:"Uncollectbl.",I=4:"Pmt. In Full",I=5:"Satisfied PA",I=6:"Compromise",1:"")
 . S VALMHDR(1)="Types: "_X
 . W !,VALMHDR(1)
 ;S VALMHDR(1)=$S(RCX=1:"Bankruptcy",RCX=2:"Deaths",RCX=3:"Uncollectible",RCX=4:"Paymt. in Full",RCX=5:"Satisfied PA",RCX=6:"Compromise",RCX=7:"All Returns",1:"")
 ;I RCX[7 S VALMHDR(1)="Reconciliation "_VALMHDR(1)_" Report"
 ;I RCX'[7 S VALMHDR(1)="Reconciliation Reports Selected: "_$P(RCX,",",$TR(1,"Bankruptcy"))_", "_$TR(2,"Deaths")_", "_$TR(3,"Uncollectible")_", "_$TR(4,"Payment in Full")_", "_$TR(5,"Satisfied PA")_", "_$TR(6,"Compromise")
 S VALMHDR(2)="Selected Division(s): "
 I VAUTD=1 S VALMHDR(2)=VALMHDR(2)_"ALL"
 I VAUTD=0 D
 .S RCY=0 F  S RCY=$O(VAUTD(RCY)) Q:RCY=""  D 
 ..S VALMHDR(2)=VALMHDR(2)_RCY_" "
 Q
 ;
FILTER(FILTERS) ; Set filters
 ; Sets an array of filters to determine which entries to include in display
 ; Input:   None
 ; Output:  
 ; Returns: 0 if the user entered '^' or timed out, 1 otherwise
 ; FILTERS(0) = Piece 1 = 1=Bankruptcy,2=Deaths,3=Uncollectable,4=Payment in Full,5=Satisfied PA,6=Compromise,7=All Returns
 ;              Piece 3 = All (0) or Select (1) Patients
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,RCXX,X,XX,RCRRC,Y
 K FILTERS
 ;
 ; Select type of report
 W !,"Please Select Type of Report"
 W !!?11,"1        Bankruptcy"
 W !?11,"2        Deaths"
 W !?11,"3        Uncollectible"
 W !?11,"4        Payment in Full"
 W !?11,"5        Satisfied PA"
 W !?11,"6        Compromise"
 W !?11,"7        All Returns"
 W !
 S DIR(0)="L^1:7"
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U)=Y
 I Y[7 S $P(FILTERS(0),U)=$P(Y,",")
 I Y'[7 S $P(FILTERS(0),U)=Y
 ;
 ; Site (Division) Filter - Uses MEDICAL CENTER DIVISION file
 S DIR(0)="S",DIR("A")="Select(A)ll or (S)elected Division(s) ",DIR("B")="All"
 S DIR("?",1)="Enter 'A' to not filter by Division."
 S DIR("?")="Enter 'S' to view entries for selected Division(s)."
 S $P(DIR(0),U,2)="A:All Divisions;S:Selected Divisions"
 W ! D ^DIR K DIR
 I $G(DIRUT)!($G(DUOUT)) W !!,*7,"No Division(s) selected.  Quitting.",! Q 0
 S X=$$UP^XLFSTR(X)
 S $P(FILTERS(0),U,3)=$S(Y="S":1,1:0) S VAUTD=$S(Y="A":1,1:0)
 ; Set Division filter
 I $G(VAUTD)=1 S $P(FILTERS(0),U,3)=0,RCDIVS="All"
 I $P(FILTERS(0),U,3)=1 D
 .D ASKDIV(.FILTERS)
 ;
 I 'FILTERS(0) Q 0
 ;
 S SORTBY=1
 ; 
 ; Display Selection Criteria to Screen
 D SHOWFILT(.FILTERS)
 ;
 ; Excel or List Manager
 S DIR(0)="S^1:List Manager;2:Excel Format",DIR("A")="List Manager or Excel Format",DIR("B")=1
 S DIR("?",1)="Enter 1 to select List Manager."
 S DIR("?")="Enter 2 to select Excel Format."
 W ! D ^DIR K DIR
 I $G(DIRUT) Q 0
 S X=$$UP^XLFSTR(X)
 S EXCEL=$S(Y=1:0,1:1)
 S STOP=0
 I EXCEL=1 D
 .D EXCMSG^RCTCSJR ; Display Excel display message
 .S %ZIS="AEQ" D ^%ZIS I POP S STOP=1
 I STOP Q 0
 ;
 Q 1
 ;
SHOWFILT(FILTERS) ; Display
 ; Displays the currently selected filter selections for the
 ; Billing and NVC Precert Worklist display
 ; Input:   FILTERS()   - Array of filter settings. See FILTERS for a detailed
 ;                explanation of the FILTERS array
 ; Output:  Current Filter settings are displayed
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,IEN,LEN,RCXX,RCY,RCZ,RCYY
 W !!!,"Type of Report: "
 S RCRPT=$P(FILTERS(0),U,1)
 W $S(RCRPT[99:"All Returns",1:"Selected")
 ;
 W !,"Show All or Selected Divisions: "
 W $S($G(VAUTD)=0:"Selected",1:"All")
 ;
 W !,"All Patients"   ; or Selected Patients: "
 K DIR
 Q
 ;
ASKDIV(FILTERS) ; Sets a list of Divisions to be displayed in the Reconciliation Worklist
 ; Input: FILTERS - Current Array of filter settings
 ; Output: FILTERS - Updated Array of filter settings
 N DIC,DIR,DIVS,FIRST,IBIENS,IBIENS2,IEN,N,X,XX,Y
 S DIC=40.8,DIC(0)="AEM",FIRST=1
 F  D  Q:+IEN<1
 . D ONEDIV(.DIC,.IEN,.FIRST) ; One Division prompt
 . Q:+IEN<1
 . S IBIENS($P(IEN,U,2))=$P(IEN,U,1)
 . S IBIENS2($P(IEN,U,1))=$P(IEN,U,2)
 . S DIV=$P(IEN,U)
 . S RCDIV=$$GET1^DIQ(40.8,DIV_",",1,"E")
 . S VAUTD(RCDIV)=RCDIV
 I ($G(DUOUT))!('$D(IBIENS)) S FILTERS(0)=0 Q 0
 I '$D(IBIENS) S $P(FILTERS(0),U,3)=0
 ;
 ; Set the filter node responses in alphabetical order
 S XX=""
 F  D  Q:XX=""
 . S XX=$O(IBIENS(XX))
 . Q:XX=""
 . S N=IBIENS(XX)
 . S FILTERS(1,N)=""
 . D CHKFILT
 Q
 ;
ONEDIV(DIC,IEN,FIRST) ; Prompts the user for a Division
 ; Input: DIC - Variable/Array of settings needed for ^DIC call
 ; FIRST - Set to 1 initially and then 0 for subsequent calls
 ; Output: FIRST - Set to 0
 ; IEN - IEN of the selected Division
 ; null if no selection was made
 S DIC("A")=$S(FIRST:"Select a Division: ",1:"Select Another Division: ")
 D ^DIC
 I FIRST,X="" W !!,*7,"Division entry is required!",! D ONEDIV(.DIC,.IEN,.FIRST)
 I $G(DUOUT) W !!,*7,"User exited the option with '^',quitting.",! S IEN=Y,FILTERS(0)=0 Q 0
 S FIRST=0,IEN=Y_U_X
 Q
 ;
EXPAND ; ACTION - Expand Patient (EP)
 D FULL^VALM1
 N I,J,RCBILL,RCBILLEX,RCDFN,RCNAME,RCPTID,RCXX,VALMY,ECNT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D
 .K ^TMP("RCTCSWE",$J)
 .S ECNT=$G(^TMP("RCTCSWLX",$J,RCXX))
 .S RCDFN=$P(ECNT,U,1),RCNAME=$P(ECNT,U,2),RCPTID=$P(ECNT,U,3),RCBILL=$P(ECNT,U,5),RCBILLEX=$P(ECNT,U,6)
 .S ^TMP("RCTCSWE",$J)=RCDFN_U_RCNAME_U_RCPTID_U_RCBILL_U_RCBILLEX
 .D EN^VALM("RCTCSP WORKLIST EXPAND")
 .Q
 K ^TMP("RCTCSWE",$J)
 S VALMBCK="R"
 Q
 ;  
LINKI ; ACTION - View Patient Insurance (VI)
 D FULL^VALM1
 N I,J,DFN,RCXX,VALMY,ECNT,GOTPAT,REC,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D
 .S (ECNT,REC)=$G(^TMP("RCTCSWLX",$J,RCXX))
 .S DFN=$P(ECNT,U,1)  ;Need DFN for VI
 .I DFN="" W !!,"Debtor is not a VA Patient" D PAUSE^VALM1 Q
 .S ^TMP($J,"PATINS")=$P(REC,U,1),GOTPAT=1
 .D EN^VALM("IBCNS VIEW PAT INS")
 S VALMBCK="R"
 Q
 ;
ACCTPR ; ACTION - Account Profile (AP)
 D FULL^VALM1
 N I,J,DFN,RCXX,VALMY,ECNT,REC,RCDEBTDA
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D  Q:$G(RCDPFXIT)     ; also get out of loop upon fast exit
 . S (ECNT,REC)=$G(^TMP("RCTCSWLX",$J,RCXX))
 . S RCDEBTDA=$P(ECNT,U,4)  ;Need DEBTOR for AP
 . D EN^VALM("PRCA TCSP ACCOUNT PROFILE")
 . Q
 S VALMBCK="R"
 I $G(RCDPFXIT) S VALMBCK="Q"    ; user wants to exit entirely
 Q
 ;
PTVW ; ACTION - View Patient (PT)
 D FULL^VALM1
 N I,J,DFN,RCXX,VALMY,ECNT,GOTPAT,REC,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D
 .S (ECNT,REC)=$G(^TMP("RCTCSWLX",$J,RCXX))
 .S DFN=$P(ECNT,U,1)  ;Need DFN for PT
 .I DFN="" W !!,"Debtor is not a VA Patient." D PAUSE^VALM1 Q
 .D EN^DGRPD         ; DBIA# 10037
 S VALMBCK="R"
 Q
 ;
CEA ; ACTION - CANCEL EDIT ADD (CN)
 N DFN,RCDEBTDA,GOTPAT
 D FULL^VALM1
 I '$D(ECNT) G CEAX    ; ECNT is set by the ACCTPR - Account Profile action protocol code and must be defined
 ;
 S DFN=+$P(ECNT,U,1)           ; patient ien
 S RCDEBTDA=+$P(ECNT,U,4)      ; AR debtor ien
 ;
 ; check on security key - same one used in the IB option IB CANCEL/EDIT/ADD CHARGES
 I '$D(^XUSEC("IB AUTHORIZE",DUZ)) D  G CEAX
 . W *7,!!?3,"You must hold the IB AUTHORIZE security key in order to access this option.",!
 . D PAUSE^VALM1
 . Q
 ;
 ; check to make sure we have a DFN here.  Debtor may not be a patient
 I 'DFN D  G CEAX
 . N DP,DEBTTYP
 . S DP=$P($G(^RCD(340,RCDEBTDA,0)),U,1)
 . S DEBTTYP=$S(DP["VA(200":"a VistA user",DP["DIC(36":"a 3rd party payer",DP["DIC(4":"a VA institution",DP["PRC(440":"an IFCAP vendor",1:"UNKNOWN!?")
 . W *7,!!?3,"The AR Debtor must be a patient for this action."
 . W !?3,"For this account, the AR Debtor is ",DEBTTYP,".",!
 . D PAUSE^VALM1
 . Q
 ;
 ; new a bunch of variables left hanging around after this call
 N %X,%Y,C,D,DA,DESC,DI,DIC,DICR,DIE,DIG,DIH,DILN,DIU,DIV,DIW,DQ,DR,ENT,FMSNUM1,IBAFY,IBATYPN,IBSTAR80,PRCA,RCREF
 N RCVXCTY,RCXQFL,RCXVBDT,RCXVBST,RCXVDA,X,Y
 S GOTPAT=1
 W !
 D EN1AR^IBECEA      ; DBIA 4047
 D INIT^RCDPAPLM     ; refresh account profile data
CEAX ;
 S VALMBCK="R"
 Q
 ;
PRTSTAT ; ACTION - PRINT A PAYMENT STATEMENT (PR)
 D FULL^VALM1
 N I,J,DFN,RCXX,VALMY,ECNT,GOTBILL,REC,PRCABN,DIR,X,Y,DIRUT,DUOUT,DTOUT,DIROUT
 D EN^VALM2($G(XQORNOD(0)))
 I $D(VALMY) S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D  Q:$D(DIRUT)
 . S (ECNT,REC)=$G(^TMP("RCTCSWLX",$J,RCXX))
 . S PRCABN=$P(ECNT,U,5)  ;Need Bill IEN for PR
 . I $G(DIRUT) Q
 . S GOTBILL=1
 . D ^PRCACM K DTOUT
 . D PAUSE^VALM1
 . Q
 S VALMBCK="R"
 Q
 ;
REMOVE ; ACTION - REMOVE FROM WORKLIST (RM)
 D FULL^VALM1
 S VALMBCK="R"
 N I,J,DFN,RCXX,VALMY,ECNT,GOTPAT,REC,RCBILLDA,RCBILLEX,RCDATE,RCNAME,RCRRSN,RCEXTBL
 D EN^VALM2($G(XQORNOD(0))) Q:'$D(VALMY)
 S RCXX=0 F  S RCXX=$O(VALMY(RCXX)) Q:'RCXX  D
 .S (ECNT,REC)=$G(^TMP("RCTCSWLX",$J,RCXX))
 .S RCNAME=$P(ECNT,U,2)
 .S RCBILLDA=$P(ECNT,U,5)
 .S RCBILLEX=$P(ECNT,U,6)
 .S RCEXTBL=$P($G(^PRCA(430,+RCBILLDA,0)),U,1)   ; external bill#
 .S RCDATE=$P(ECNT,U,7)
 .S RCRRSN=$P(ECNT,U,8)
 .W !!,"Remove BILL "_RCBILLEX_" from Reconciliation Worklist Y/N? "
 .S %=2 D YN^DICN
 .I %=1 D
 ..N PRCAEN,PRCAA1,DR,DIE,DA,D0,PRCAD,RCASK,PRCAA2,PRCA,PRCATY,RCUSER
 ..S DIE="^PRCA(430,",DA=RCBILLDA
 ..S DR="309////1"
 ..D ^DIE ;Set flag to not display this bill on the reconciliation worklist
 ..K ^TMP("RCTCSWL",$J,RCNAME,RCEXTBL)
 ..W !,"BILL "_RCBILLEX_" has been removed from the worklist."
 ..D PAUSE^VALM1
 ..D CLEAN^VALM10
 ..;File AR transaction indicating CS RECON WORKED
 ..S RCUSER=DUZ
 ..S PRCABN=RCBILLDA
 ..D SETTR^PRCAUTL,PATTR^PRCAUTL Q:'$D(PRCAEN)
 ..S PRCAA1=$S($D(^PRCA(433,PRCAEN,4,0)):+$P(^(0),U,4),1:0)
 ..Q:PRCAA1'>0  S PRCAA2=$P(^(0),U,3)
 ..S DIE="^PRCA(433,",DA=PRCAEN
 ..S DR=".03///"_PRCABN ;Bill Number
 ..S DR=DR_";3///0" ;Calm Code Done
 ..S DR=DR_";12///"_$O(^PRCA(430.3,"AC",50,0)) ;Transaction Type
 ..S DR=DR_";15///0" ;Transaction Amount
 ..S DR=DR_";42///"_RCUSER ;Processed by user
 ..S DR=DR_";4///2" ;Transaction status (complete)
 ..D ^DIE
 ..; DIE seemed to fail with too many variables, so we run it twice.
 ..S DR="5.02///CS RECON WORKED"  ;Brief comment
 ..S DR=DR_";11///"_DT ;Transaction date
 ..D ^DIE
 ..I $P($G(^PRCA(433,PRCAEN,5)),"^",2)=""!('$P(^PRCA(433,PRCAEN,1),"^")) S PRCACOMM="TRANSACTION INCOMPLETE" D DELETE^PRCAWO1 K PRCACOMM Q
 ..I '$D(PRCAD("DELETE")) S RCASK=1 D TRANUP^PRCAUTL,UPPRIN^PRCADJ
 ..I $P($G(^RCD(340,+$P(^PRCA(430,PRCABN,0),"^",9),0)),"^")[";DPT(" S $P(^PRCA(433,PRCAEN,0),"^",10)=1
 ..Q
 .Q
 ;
 D BLDWL^RCTCSWL1
 S VALMBCK="R"
 Q
 ;
KILLGLB ; Kill Worklist Globals
 K ^TMP("RCTCSWL",$J)
 K ^TMP("RCTCSWLX",$J)
 K ^TMP("RCTCSWE",$J)
 K ^TMP("VALMAR",$J)
 K ^TMP("XQORS",$J)
 K ^TMP("RCTPAPLM",$J)
 K ^TMP("RCTCBPLM",$J)
 K RCFP,RCFPNO,RCFPNOT,RCFPNUM,RCINLN2,RCINV
 D CLEAR^VALM1
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D KILLGLB
 K EXCEL,POP,SORTBY,VAUTC,VAUTD
 D CLEAN^VALM10
 D ^%ZISC
 Q
EXDIV ;
 D KILLGLB
 K EXCEL,POP,SORTBY,VAUTC,VAUTD
 Q
 ;
CHKFILT ; Check Filters
 N RCSTAT,RCXX,RCXXX,RCXXXX,RCFST,RCDIVS
 I '$D(RCIENS)=1 S $P(FILTERS(0),U,3)=0,RCDIVS="All"
 I $G(VAUTD)=0 D
 .I $D(RCIENS) S $P(FILTERS(0),U,3)=1
 .S RCSTAT=0,RCFST=1
 .F  S RCSTAT=$O(VAUTD(RCSTAT)) Q:RCSTAT=""  D
 ..S RCXX=$E($$GET1^DIQ(40.8,RCSTAT_",",.01),1,15)
 ..S RCXXX=$$GET1^DIQ(40.8,RCSTAT_",",1,"E")
 ..S RCXXXX=$$GET1^DIQ(40.8,RCSTAT_",",.07,"I")
 ..I 'RCFST S RCDIVS=RCDIVS_","_RCXX_"-"_RCXXX
 ..I RCFST S RCFST=0,RCDIVS=RCXX_"-"_RCXXX
 Q
