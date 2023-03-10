BPSRPT0 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10,11,19,20,23,24,28**;JUN 2004;Build 22
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
 ; Front End for ECME Reports
 ; 
 ; Input variable: BPRTYPE -> 1 = Payable Claims
 ;                          2 = Rejected Claims
 ;                          3 = Claims Submitted, Not Yet Released
 ;                          4 = Reversed Claims
 ;                          5 = Recent Transactions
 ;                          6 = Totals By Date
 ;                          7 = Closed Claims
 ;                          8 = Spending Account Report
 ;                          9 = ECME RXs with Non-Billable Status
 ;                         10 = Duplicate Claims Report
 ;                          
 ; Passed variables:
 ;  The following local variables are set in BPSPRT0 and are passed throughout
 ;  the BPSRPT* routines. They are used during the looping/filtering of transactions
 ;  and when creating the reports.
 ;  These local variable are not passed as parameters but assumed to be defined.
 ; 
 ;    BPRTYPE -  report number (1-10) 
 ;      1 = Payable Claims, 2 = Rejected Claims, 3 = Claims Submitted, Not Yet Released, 
 ;      4 = Reversed Claims, 5 = Recent Transactions, 6 = Totals By Date,
 ;      7 = Closed Claims, 8 = Spending Account Report, 9 = ECME RXs with Non-Billable Status,
 ;      10 = Duplicate Claims
 ;    BPRPTNAM - report name 
 ;      1-PAYABLE CLAIMS, 2-REJECTED CLAIMS, 3-SUBMIT,NOT RELEASED CLAIMS,
 ;      4-REVERSED CLAIMS, 5-RECENT TRANSACTIONS, 6-TOTALS, 7-CLOSED CLAIMS,
 ;      8-SPENDING ACCOUNT REPORT, 9-RXS WITH NON-BILLABLE STATUS,
 ;      10-DUPLICATE CLAIMS REPORT
 ;    BPSLC - all lower case letters (used to convert from lower to upper)
 ;    BPSUC - all upper case letters (used to convert from lower to upper)
 ;    BPPHARM - Pharmacy Divisions or ALL
 ;      BPPHARM=0 - ALL
 ;        if Pharmacy Divisions was selected, returns BPPHARM variable and an array
 ;      BPPHARM=1
 ;      BPPHARM(ptr) for each selection - Pointer to BPS PHARMACIES 
 ;    BPSUMDET - 1=Display Summary  or 0=Detail Format 
 ;    BPINS - allow selection of Insurance or ALL, returns BPINS variable and BPARR array
 ;      0="^" Exit
 ;      1=if ALL - BPARR(1.11)="A",BPARR(2.04)="",BPARR("INS")=""
 ;      1=if INSURANCE
 ;        BPARR(1.11)="I",
 ;        BPARR(2.04)=";1;ptr;"   if multiple entries - BPARR(2.04)=";ptr;ptr;."
 ;        BPARR("INS")=";1;ptr;"  if multiple entries - BPARR("INS")=";ptr;ptr;."
 ;      ptr - Pointer to the INSURANCE file
 ;    BPINSINF - BPINSINF=0 - if ALL Insurances was selected above
 ;      BPINSINF=BPARR("INS") 
 ;    BPMWC - Fill location C-CMOP, W-WINDOW, M-MAIL
 ;      BPMWC=A-ALL, ^-Exit
 ;      BPMWC=(C,W,M)
 ;       if multiple entries - BPMWC=(a comma delimited string of users selection, e.g. "C,M")
 ;    BPRTBCK - Fill Type - 2-RealTime Fills, 3-Backbills, 4-PRO Option, 5-Resubmission
 ;      BPRTBCK=1-ALL,^-exit
 ;      BPRTBCK=(2,3,4,5)
 ;       if multiple entries - BPRTBCK=(a comma delimited string of users selection, e.g. "3,5")
 ;    BPQSTDRG - Drug-2 or Drug Class-3 or All-1 or Exit-^
 ;      BPQSTDRG=(1,2,3,^)
 ;    BPDRUG - select Drug - ptr=Pointer to the DRUG file #50
 ;      BPDRUG= ptr - if multiple entries - BPDRUG="ptr,ptr,."
 ;    BPDRGCL - select Drug - ptr= Pointer to the DRUG CLASS file #50.5
 ;      BPDRGCL= ptr - if multiple entries - BPDRGCL= ptr,ptr,.
 ;    BPBEGDT - Date Range
 ;      BPBEGDT=^-Exit
 ;      BPBEGDT= beginning date ^ ending date
 ;      BPBEGDT=$P(BPBEGDT,U) - beginning date
 ;      BPENDDT=$P(BPBEGDT,U,2) - ending date
 ;    BPRLNRL - 2-Released, 3-Not Released or 1-All
 ;      BPRLNRL=(1,2,3,^) ^=exit
 ;    BPQSTRC - select Reject Code-1 or All-0
 ;      BPQSTRC=(0,1,^)
 ;    BPREJCD - if Reject Code=1 was selected above
 ;      BPREJCD=ptr - if multiple entries - BPREJCD=ptr,ptr,.
 ;       ptr=Pointer to Reject Code in #9002313.93
 ;    BPAUTREV - AutoReversed-1 or All-0
 ;      BPAUTREV=(0,1,^)
 ;    BPACREJ - Accepted-2, Rejected-1 or All-0
 ;      BPACREJ=(0,1,2,^)
 ;    BPQSTCR - select Close Claim Reason-1 or All-0
 ;      BPQSTCR=(0,1,^)
 ;    BPCCRSN - if Specific Close Claim Reason=1 1 was selected above
 ;      BPCCRSN=ptr - if multiple entries - BPCCRSN=ptr,ptr  ptr=Pointer to file #356.8
 ;    BPELIG - Eligibility V-Veteran, T-Tricare, C-Champva or 0-All
 ;      BPELIG=(V,T,C,0,^)
 ;    BPELIG1 - multiple Eligibilities or All-0 
 ;      BPELIG1=(0,^)
 ;      BPELIG1=(V,T,C)   V-Veteran, T-Tricare, C-Champva
 ;       if multiple entries BPELIG1=(a comma delimited string of users selection, e.g. "C,T")
 ; BPDUP - Dup Claims S-Duplicate of Approved, D-Duplicate of Paid, Q-Duplicate of Capture or 0-All
 ; BPDUP=(S,D,Q,0,^)
 ;    BPOPCL - Open-2, Closed-1 or All-0
 ;      BPOPCL=(0,1,2,^)
 ;    BPQSTPR - select Prescriber-1 or All-0
 ;      BPQSTPR=(0,1,^)
 ;    BPRESC - if Prescribers=1 was selected above
 ;      BPRESC=ptr - if multiple entries - BPRESC=ptr,ptr  ptr=Pointer to file #200
 ;    BPQSTPAT - select Patients-1 or All-0
 ;      BPQSTPAT=(0,1,^)
 ;    BPPAT - if Patients=1 was selected above
 ;      BPPAT=ptr - if multiple entries - BPPAT=ptr,ptr  ptr=Pointer to file #2
 ;    BPBILL - Range of Billed Amount-1 or All-0
 ;      BPBILL=(0,1,^) 
 ;    BPMIN - if BPBILL=1 enter minimum billed amount
 ;      BPMIN=amount entered, default is 0
 ;    BPMAX - if BPBILL=1 enter maximum billed amount
 ;      BPMAX=amount entered, default is 999999
 ;    BPALRC - All-A or Most Recent-R (Non-Billable Status report only, BPRTYPE=9)
 ;      BPALRC=(A,R,^)
 ;    BPNBSTS - Non-Billable Status (Non-Billable Status report only, BPRTYPE=9)
 ;      BPNBSTS=(0-All,1-certain Non-billable status,^)
 ;       if BPNBSTS=1 there is a BPNBSTS array for each status selected
 ;      BPNBSTS(ptr)=status  - for each status selected
 ;       ptr=Pointer to file #366.17 - status=non-billable reason from file #366.17 field #.01
 ;    BPEXCEL - Excel capture-detail only, if BPSUMDET=0 (detail format)
 ;      BPEXCEL=(0-No, 1-Yes, ^)
 ;    BPQ - device variable - I POP S BPQ=1 otherwise BPQ=0
 ;
 ; The following local variables are not set in BPSRPT0 however they are used in several
 ; BPSRPT* routines.  They are not passed as parameters but assumed to be defined.
 ;    BPBLINE - blank line indicator, 1-print blank line
 ;    BPGRPLAN - insurance plan name
 ;    BPSDATA - tells whether data has been displayed to the screen (0-No,1-Yes)
 ;                          
EN(BPRTYPE) ;
 N %,BPACREJ,BPAUTREV,BPBEGDT,BPCCRSN,BPDRGCL,BPDRUG,BPENDDT,BPEXCEL,BPNOW,BPPHARM,BPINSINF,BPMWC,BPQ,BPQSTDRG
 N BPREJCD,BPRLNRL,BPRPTNAM,BPRTBCK,BPSCR,BPSUMDET,BPINS,BPARR,BPELIG,BPDUP,BPOPCL
 N BPNBSTS,BPALRC,BPELIG1,BPRESC,BPPAT,BPQSTPAT,BPBILL,BPMIN,BPMAX,BPSLC,BPSUC,BPSCOMMENT
 N BPQSTCR,BPQSTPR,BPQSTRC,CODE,POS,STAT,X,Y
 ;
 ;Verify that a valid report has been requested
 I ",1,2,3,4,5,6,7,8,9,10,"'[(","_$G(BPRTYPE)_",") W "<Invalid Menu Definition - Report Undefined>" H 3 Q
 S BPRPTNAM=$P("PAYABLE CLAIMS^REJECTED CLAIMS^SUBMIT,NOT RELEASED CLAIMS^REVERSED CLAIMS^RECENT TRANSACTIONS^TOTALS^CLOSED CLAIMS^SPENDING ACCOUNT REPORT^RXS WITH NON-BILLABLE STATUS^DUPLICATE CLAIMS","^",BPRTYPE)
 ;
 ;Needed to convert lower case entries to upper case
 S BPSLC="abcdefghijklmnopqrstuvwxyz"
 S BPSUC="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 ;
 ;Get current Date/Time
 D NOW^%DTC S Y=% D DD^%DT S BPNOW=Y
 ;
DIV ;
 ;Prompt for ECME Pharmacy Division(s) (No Default)
 ;Sets up BPPHARM variable and array, BPPHARM =0 ALL or BPPHARM=1,BPPHARM(ptr) for list
 S X=$$SELPHARM^BPSRPT3() G:(X="^")&($G(BPPHARM)="") EXIT G:(X="^")&(BPPHARM=1) DIV
 ;
 ;Prompt to Display Summary or Detail Format (Default to Detail)
 ;Returns 1 for Summary, 0 for Detail
 S BPSUMDET=$$SELSMDET^BPSRPT3(2) I BPSUMDET="^" G EXIT
 ;
INSUR ;
 ;Prompt to allow selection of Multiple Insurances or All (Default to ALL)
 ;See description for $$INSURSEL^BPSSCRCU
 S BPINS=$$INSURSEL^BPSSCRCU(.BPARR,DUZ) I BPINS<1 G EXIT
 S BPINSINF=$S(BPARR(1.11)="I":BPARR("INS"),1:0)
 ;If "I" Specific Insurance(s) was selected and the user didn't select
 ;an Insurance re-prompt for Specific Insurance(s) or All
 I BPINSINF=";" G INSUR
 ;
 ;Prompt to Display (C)MOP or (M)ail or (W)indow or (A)LL (Default to ALL)
 ;Returns (A-ALL,M-Mail,W-Window,C-CMOP)
 I (",5,6,8,")[BPRTYPE S BPMWC=$$SELMWC^BPSRPT3("A") I BPMWC="^" G EXIT
 I (",1,2,3,4,7,9,")[BPRTYPE S BPMWC=$$SELMWC1^BPSRPT3("A") I BPMWC="^" G EXIT
 I BPRTYPE=10 S BPMWC="A"   ;DEFAULT TO ALL, do not prompt for report 10
 ;
 ;Prompt to Display (R)ealTime Fills or (B)ackbills or (P)RO Option or Re(S)ubmission or (A)LL (Default to ALL)
 ;Returns (1-ALL,2-RealTime Fills,3-Backbills,4-PRO Option,5-Resubmission)
 S BPRTBCK=1
 I (",5,6,8,")[BPRTYPE S BPRTBCK=$$SELRTBCK^BPSRPT3(1) I BPRTBCK="^" G EXIT
 I (",1,2,3,4,7,")[BPRTYPE S BPRTBCK=$$SELRBPS^BPSRPT3() I BPRTBCK="^" G EXIT
 I BPRTYPE=10 S BPMWC="A"   ;DEFAULT TO ALL, do not prompt for report 10
 ;
DGDGCL ;
 ;Prompt to Display Specific (D)rug or Drug (C)lass or (A)ll (Default to ALL)
 ;Returns (1-ALL,2-Drug,3-Drug Class)
 I BPRTYPE'=10 S BPQSTDRG=$$SELDRGAL^BPSRPT3(1) I BPQSTDRG="^" Q
 I BPRTYPE=10 S BPQSTDRG=1 ;DEFAULT TO 1-ALL, do not prompt for report 10
 ;
 ;Prompt to Select Drug (No Default)
 S BPDRUG=0 I BPQSTDRG=2 D  G:BPDRUG="^" EXIT G:BPDRUG=0 DGDGCL
 . I (",5,6,8,")[BPRTYPE S BPDRUG=$$SELDRG^BPSRPT3()
 . I (",1,2,3,4,7,9,")[BPRTYPE S BPDRUG=$$SELDRG1^BPSRPT3A()
 ;
 ;Prompt to Select Drug Class (No Default)
 S BPDRGCL=0 I BPQSTDRG=3 D  G:BPDRGCL="^" EXIT G:BPDRGCL=0 DGDGCL
 . I (",5,6,8,")[BPRTYPE S BPDRGCL=$$SELDRGCL^BPSRPT3()
 . I (",1,2,3,4,7,9,")[BPRTYPE S BPDRGCL=$$SELDC^BPSRPT3A()
 ;
 ;Report Specific Prompts
 ;
 ;Prompt to select Date Range
 ;Returns (Start Date^End Date)
 S BPBEGDT=$$SELDATE^BPSRPT3(BPRTYPE) D  I BPBEGDT="^" G EXIT
 .I BPBEGDT="^" Q
 .S BPENDDT=$P(BPBEGDT,U,2)
 .S BPBEGDT=$P(BPBEGDT,U)
 ;
 ;Prompt to Include (R)ELEASED or (N)OT RELEASED or (A)LL (Default to RELEASED)
 ;Returns (1-ALL,2-RELEASED,3-NOT RELEASED)
 S BPRLNRL=$S(BPRTYPE=3:3,1:1) I (",1,2,4,6,7,8,9,10,")[(","_BPRTYPE_",") S BPRLNRL=$$SELRLNRL^BPSRPT4($S(BPRTYPE=9!(BPRTYPE=10):1,1:2)) I BPRLNRL="^" G EXIT
 ;
REJCD ;
 ;Prompt to Include (S)pecific Reject Code or (A)LL (Default to ALL)
 ;Returns (0-All,1-Reject Code,^=exit)
 S BPQSTRC=0 I (",2,")[BPRTYPE S BPQSTRC=$$SELRC^BPSRPT4(0) I BPQSTRC="^" G EXIT
 ;
 ;If Specific Reject Code was selected, prompt for one or more Reject Codes
 ;Returns: BPREJCD=a string of reject code ien's separated by a comma (file #9002313.93)
 S BPREJCD=0
 I BPQSTRC=1 S BPREJCD=$$SELREJCD^BPSRPT4() G:BPREJCD=0 REJCD G:BPREJCD="^" EXIT
 ;
 ;Prompt to Include Auto(R)eversed or (A)LL (Default to ALL)
 ;Returns (0-All,1-AutoReversed)
 S BPAUTREV=0 I (",4,")[BPRTYPE S BPAUTREV=$$SELAUREV^BPSRPT4(0) I BPAUTREV="^" G EXIT
 ;
 ;Prompt to Include A(C)cepted or (R)ejected or (A)LL (Default to REJECTED)
 ;Returns (0-All,1-Rejected,2-Accepted)
 S BPACREJ=0 I (",4,")[BPRTYPE S BPACREJ=$$SELACREJ^BPSRPT4(1) I BPACREJ="^" G EXIT
 ;
CCR ;
 ;Prompt to Include (S)pecific Close Claim Reason or (A)ll (Default to All)
 ;Returns (0-All,1-Close Claim Reason,^=exit)
 S BPQSTCR=0 I (",7,")[BPRTYPE S BPQSTCR=$$SELCCR^BPSRPT4(0) I BPQSTCR="^" G EXIT
 ;
 ;If Specific Close Claim Reason was selected, prompt for one or more Close Claim Reasons
 ;Returns: BPCCRSN=a string of close claim reason ien's separated by a comma
 S BPCCRSN=0
 I BPQSTCR=1 S BPCCRSN=$$SELCCRSN^BPSRPT4() G:BPCCRSN=0 CCR I BPCCRSN="^" G EXIT
 ;
 ;;Prompt for Eligibility Indicator for payable, rejected, reversed and closed claims report
 ;;Returns (V=VETERAN,T=TRICARE,C=CHAMPVA,0=All)
 ;;S BPELIG=0 I (",1,4,7,")[BPRTYPE S BPELIG=$$SELELIG^BPSRPT3(1) I BPELIG="^" G EXIT
 ;
 ;Prompt for All or Most Recent (Non-Billable Status Report only)
 ;Returns A - All, R - Most Recent
 S BPALRC=0 I (",9,")[BPRTYPE S BPALRC=$$SELALRC^BPSRPT3() I BPALRC="^" G EXIT
 ;
 ;Prompt for one, multiple or (A)ll Eligibility Indicator
 ;Returns (0-All, 1-selection)
 ; If 1, BPARR("ELIG",xx) is set for each eligibility selected - xx="V", "T" or "C"
 S BPELIG1=0 I (",1,2,3,4,7,9,10,")[(","_BPRTYPE_",") S BPELIG1=$$SELELIG1^BPSRPT3() I BPELIG1="^" G EXIT
 ;
 ;Prompt to Display S - DUPLICATE OF APPROVED, D - DUPLICATE OF PAID, Q - DUPLICATE OF CAPTURE, A - ALL
 ;Returns 0-ALL,^-quit, or selection separated by comma's
 I BPRTYPE=10 S BPDUP=$$SELDUP^BPSRPT3A() I BPDUP="^" G EXIT
 ;
 ;Prompt for Open/Closed/All claims
 ;Returns (1=Closed,2=Open,0=All)
 S BPOPCL=0 I (",2,")[BPRTYPE S BPOPCL=$$SELOPCL^BPSRPT3(2) I BPOPCL="^" G EXIT
 ;
PRESCR ;
 ;Prompt to select SPECIFIC PRESCRIBER(S) or (A)ll Prescribers
 ;Returns: (0=ALL,1=Prescriber,^=exit)
 S BPQSTPR=0 I (",2,")[BPRTYPE S BPQSTPR=$$SELPR^BPSRPT3A() I BPQSTPR="^" G EXIT
 ;
 ;If Specific Prescriber was selected, prompt for one or more prescribers
 ;Returns: BPRESC=a string of prescriber ien's separated by a comma
 S BPRESC=0
 I BPQSTPR=1 S BPRESC=$$SELPRESC^BPSRPT3A() G:BPRESC=0 PRESCR I BPRESC="^" G EXIT
 ;
PATIENT ;    
 ;Prompt to select (P)atients or (A)LL Patients
 ;Returns: (0=ALL,1=Patient,^=exit)
 S BPQSTPAT=0 I (",1,2,3,4,7,9,10,")[(","_BPRTYPE_",") S BPQSTPAT=$$SELPA^BPSRPT3A() I BPQSTPAT="^" G EXIT
 ;
 ;If (P)atients was selected, prompt for one or more patients
 ;Returns: BPPAT=a string of patient ien's separated by a comma
 S BPPAT=0
 I BPQSTPAT=1 S BPPAT=$$SELPAT^BPSRPT3A() G:BPPAT="^" EXIT G:BPPAT=0 PATIENT
 ;
 ;Prompt to select(R)ange for Billed Amount or (A)LL
 ;Returns: (0=ALL,1=Range,^=exit)
 S BPBILL=0 I (",1,2,3,4,9,10,")[(","_BPRTYPE_",") S BPBILL=$$SELBAMT^BPSRPT3A() I BPBILL="^" G EXIT
 ;If Range of Billed Amount was selected prompt for Minimum and Maximum
 ;Returns: BPMIN=minimum amount entered, BPMAX=maximum amount entered
 S (BPMIN,BPMAX)=0
 I BPBILL=1 W !,"Range for the Billed Amount" D  I (BPMIN="^")!(BPMAX="^") G EXIT
 . S BPMIN=$$SELBMIN^BPSRPT3A() I BPMIN="^" Q
 . S BPMAX=$$SELBMAX^BPSRPT3A()
 ;
 ;Prompt for Non-Billable Status (Non-Billable Status Report only)
 ;Sets up BPNBSTS variable and array, BPNBSTS=0 ALL or BPNBSTS=1,BPNBSTS(xx) for list
 S BPNBSTS=0 I (",9,")[BPRTYPE S BPNBSTS=$$SELNBSTS^BPSRPT3() I BPNBSTS="^" G EXIT
 ;
 ;Prompt for Excel Capture (Detail Only)
 S BPEXCEL=0 I 'BPSUMDET S BPEXCEL=$$SELEXCEL^BPSRPT4() I BPEXCEL="^" G EXIT
 ;
 ;Prompt for the Device
 I 'BPEXCEL D
 .W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH 132 COLUMN WIDTH BE USED."
 .W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 S BPQ=0 D DEVICE(BPRPTNAM) Q:BPQ
 ;
 ;Compile and Run the Report
 D RUN(BPEXCEL,BPRPTNAM,BPSUMDET)
 I 'BPQ D PAUSE2^BPSRPT1
 ;
EXIT Q
 ;
 ;Compile and Run the Report
 ;
RUN(BPEXCEL,BPRPTNAM,BPSUMDET) N BPPAGE,BPTMP
 S BPTMP=$NA(^TMP($J,"BPSRPT"))
 K @BPTMP
 S BPPAGE=0
 W:BPSCR&'BPEXCEL !,"Please wait...",!
 ;
 ;Compile the report
 Q:$$COLLECT^BPSRPT1(BPTMP)=-1
 U IO
 ;
 ;Display the report
 D REPORT^BPSRPT5(BPTMP,BPEXCEL,BPSCR,BPRPTNAM,BPSUMDET,BPPAGE)
 I 'BPSCR W !,@IOF
 K @BPTMP
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 Q
 ;
 ;Prompt For the Device
 ;
 ; Returns Device variables and BPSCR
 ;
DEVICE(BPRPTNAM) N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S BPQ=1
 ;
 ;Check for exit
 I $G(BPQ) G XDEV
 ;
 S BPSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S BPQ=1
 . S ZTRTN="RUN^BPSRPT0(BPEXCEL,BPRPTNAM,BPSUMDET)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="BPS REPORT: "_BPRPTNAM
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
XDEV Q
