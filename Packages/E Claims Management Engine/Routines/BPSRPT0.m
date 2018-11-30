BPSRPT0 ;BHAM ISC/BEE - ECME REPORTS ;14-FEB-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1,5,7,10,11,19,20**;JUN 2004;Build 27
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
 ;                          
 ; Passed variables - The following local variables are passed around the BPSRPT* routines
 ;                    and are not passed as parameters but are assumed to be defined:
 ;                    BPACREJ,BPAUTREV,BPBEGDT,BPBLINE,BPCCRSN,BPDRGCL,BPDRUG,BPENDDT,BPEXCEL,
 ;                    BPINSINF,BPGRPLN,BPMWC,BPNOW,BPPAGE,BPPHARM,BPQ,BPQSTDRG,
 ;                    BPRLNRL,BPRTBCK,BPSDATA,BPSUMDET,BPRTYPE,BPNBSTS,BPALRC,BPELIG1
 ;                          
EN(BPRTYPE) N %,BPACREJ,BPAUTREV,BPBEGDT,BPCCRSN,BPDRGCL,BPDRUG,BPENDDT,BPEXCEL,BPNOW,BPPHARM,BPINSINF,BPMWC,BPQ,BPQSTDRG
 N BPREJCD,BPRLNRL,BPRPTNAM,BPRTBCK,BPSCR,BPSUMDET,CODE,POS,STAT,X,Y,BPINS,BPARR,BPELIG,BPOPCL
 N BPNBSTS,BPALRC,BPELIG1
 ;
 ;Verify that a valid report has been requested
 I ",1,2,3,4,5,6,7,8,9,"'[(","_$G(BPRTYPE)_",") W "<Invalid Menu Definition - Report Undefined>" H 3 Q
 S BPRPTNAM=$P("PAYABLE CLAIMS^REJECTED CLAIMS^SUBMIT,NOT RELEASED CLAIMS^REVERSED CLAIMS^RECENT TRANSACTIONS^TOTALS^CLOSED CLAIMS^SPENDING ACCOUNT REPORT^RXS WITH NON-BILLABLE STATUS","^",BPRTYPE)
 ;
 ;Get current Date/Time
 D NOW^%DTC S Y=% D DD^%DT S BPNOW=Y
 ;
 ;Prompt for ECME Pharmacy Division(s) (No Default)
 ;Sets up BPPHARM variable and array, BPPHARM =0 ALL or BPPHARM=1,BPPHARM(ptr) for list
 S X=$$SELPHARM^BPSRPT3() I X="^" G EXIT
 ;
 ;Prompt to Display Summary or Detail Format (Default to Detail)
 ;Returns 1 for Summary, 0 for Detail
 S BPSUMDET=$$SELSMDET^BPSRPT3(2) I BPSUMDET="^" G EXIT
 ;
 ;Prompt to allow selection of Multiple Insurances or All (Default to ALL)
 ;See description for $$INSURSEL^BPSSCRCU
 S BPINS=$$INSURSEL^BPSSCRCU(.BPARR,DUZ) I BPINS<1 G EXIT
 S BPINSINF=$S(BPARR(1.11)="I":BPARR("INS"),1:0)
 ;
 ;Prompt to Display (C)MOP or (M)ail or (W)indow or (A)LL (Default to ALL)
 ;Returns (A-ALL,M-Mail,W-Window,C-CMOP)
 S BPMWC=$$SELMWC^BPSRPT3("A") I BPMWC="^" G EXIT
 ;
 ;Prompt to Display (R)ealTime Fills or (B)ackbills or (P)RO Option or Re(S)ubmission or (A)LL (Default to ALL)
 ;Returns (1-ALL,2-RealTime Fills,3-Backbills,4-PRO Option,5-Resubmission)
 S BPRTBCK=1
 I BPRTYPE'=9 S BPRTBCK=$$SELRTBCK^BPSRPT3(1) I BPRTBCK="^" G EXIT
 ;
 ;Prompt to Display Specific (D)rug or Drug (C)lass or (A)ll (Default to ALL)
 ;Returns (1-ALL,2-Drug,3-Drug Class)
 S BPQSTDRG=$$SELDRGAL^BPSRPT3(1) I BPQSTDRG="^" Q
 ;
 ;Prompt to Select Drug (No Default)
 S BPDRUG=0 I BPQSTDRG=2 S BPDRUG=$$SELDRG^BPSRPT3() I BPDRUG="^" G EXIT
 ;
 ;Prompt to Select Drug Class (No Default)
 S BPDRGCL=0 I BPQSTDRG=3 S BPDRGCL=$$SELDRGCL^BPSRPT3() I BPDRGCL="^" G EXIT
 ;
 ;Report Specific Prompts
 ;
 ;Prompt to select Date Range
 ;Returns (Start Date^End Date)
 I (",1,2,3,4,5,6,7,8,9,")[BPRTYPE S BPBEGDT=$$SELDATE^BPSRPT3(BPRTYPE) D  I BPBEGDT="^" G EXIT
 .I BPBEGDT="^" Q
 .S BPENDDT=$P(BPBEGDT,U,2)
 .S BPBEGDT=$P(BPBEGDT,U)
 ;
 ;Prompt to Include (R)ELEASED or (N)OT RELEASED or (A)LL (Default to RELEASED)
 ;Returns (1-ALL,2-RELEASED,3-NOT RELEASED)
 S BPRLNRL=$S(BPRTYPE=3:3,1:1) I (",1,2,4,6,7,8,9,")[BPRTYPE S BPRLNRL=$$SELRLNRL^BPSRPT4($S(BPRTYPE=9:1,1:2)) I BPRLNRL="^" G EXIT
 ;
 ;Prompt to Include (S)pecific Reject Code or (A)LL (Default to ALL)
 ;Returns (0-ALL,ptr-Pointer to Selected Reject Code in #9002313.93)
 S BPREJCD=0 I (",2,")[BPRTYPE S BPREJCD=$$SELREJCD^BPSRPT4(0) I BPREJCD="^" G EXIT
 ;
 ;Prompt to Include Auto(R)eversed or (A)LL (Default to ALL)
 ;Returns (0-All,1-AutoReversed)
 S BPAUTREV=0 I (",4,")[BPRTYPE S BPAUTREV=$$SELAUREV^BPSRPT4(0) I BPAUTREV="^" G EXIT
 ;
 ;Prompt to Include A(C)cepted or (R)ejected or (A)LL (Default to REJECTED)
 ;Returns (0-All,1-Rejected,2-Accepted)
 S BPACREJ=0 I (",4,")[BPRTYPE S BPACREJ=$$SELACREJ^BPSRPT4(1) I BPACREJ="^" G EXIT
 ;
 ;Prompt to Include (S)pecific Close Claim Reason or (A)ll (Default to All)
 ;Returns (0-All,ptr-Pointer to #356.8)
 S BPCCRSN=0 I (",7,")[BPRTYPE S BPCCRSN=$$SELCCRSN^BPSRPT4(0) I BPCCRSN="^" G EXIT
 ;
 ;Prompt for Eligibility Indicator for payable, rejected, reversed and closed claims report
 ;Returns (V=VETERAN,T=TRICARE,C=CHAMPVA,0=All)
 S BPELIG=0 I (",1,2,4,7,")[BPRTYPE S BPELIG=$$SELELIG^BPSRPT3(1) I BPELIG="^" G EXIT
 ;
 ;Prompt for Open/Closed/All claims
 ;Returns (1=Closed,2=Open,0=All)
 S BPOPCL=0 I (",2,")[BPRTYPE S BPOPCL=$$SELOPCL^BPSRPT3(2) I BPOPCL="^" G EXIT
 ;
 ;Prompt for All or Most Recent (Non-Billable Status Report only)
 ;Returns A - All, R - Most Recent
 S BPALRC=0 I (",9,")[BPRTYPE S BPALRC=$$SELALRC^BPSRPT3() I BPALRC="^" G EXIT
 ;
 ;Prompt for multiple Eligibility Indicator for Non-Billable Status Report
 ;Sets up BPELIG1 variable and array, BPELIG1=0 ALL or BPELIG1=1,BPELIG1(xx) for list
 S BPELIG1=0 I (",9,")[BPRTYPE S BPELIG1=$$SELELIG1^BPSRPT3() I BPELIG1="^" G EXIT
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
