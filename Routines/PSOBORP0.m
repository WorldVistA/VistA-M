PSOBORP0 ;ALBANY/BLD - TRICARE BYPASS/OVERRIDE AUDIT REPORT ;7/1/2010
 ;;7.0;OUTPATIENT PHARMACY;**358**;DEC 1997;Build 35
 ;
 ;***********copied from routine BPSRPT0************
 ;
 Q
 ;
 ; Front End for ECME Reports
 ;
 ;
 ;
 ; Passed variables - The following local variables are passed around the PSSRPT* routines
 ;                    and are not passed as parameters but are assumed to be defined:
 ;                    PSACREJ,PSAUTREV,PSBEGDT,PSBLINE,PSCCRSN,PSDRGCL,PSDRUG,PSENDDT,PSEXCEL,
 ;                    PSINSINF,PSGRPLN,PSMWC,PSNOW,PSPAGE,PSPHARM,PSQ,PSQSTDRG,
 ;                    PSRLNRL,PSRTBCK,PSSDATA,PSSUMDET,PSRTYPE
 ;
EN(PSORTYPE) ;
 N %,ACTDT,AMT,BPQ,CODE,IO,PSOACREJ,PSOAUTREV,PSOBEGDT,PSOCCRSN,PSODRGCL,PSODRUG,PSOENDDT,PSOEXCEL,PSONOW
 N PSOPHARM,PSOINSINF,PSOMWC,PSOQ,PSOUT,PSOPROV,PSOQSTDRG,PSOREJCD,PSORLNRL,PSORPTNAM,PSORTBCK
 N PSOSEL,PSOSCR,PSOSMDET,PSOSEL,PSOTOTAL,POS,PSOINS,PSOARR,PSOELIG,PSOOPCL,PSOPHMST,PSORPTNM,STAT,X,Y
 ;
 K PSOSEL
 ;
 S PSORPTNM="TRICARE BYPASS/OVERRIDE REPORT"
 ;
 ;Verify that a valid report has been requested
 I PSORTYPE'=1 W "<Invalid Menu Definition - Report Undefined>" H 3 Q
 ;
 ;Get current Date/Time
 S PSONOW=$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 ;Prompt for ECME Pharmacy Division(s) (No Default)
 ;Sets up PSOPHARM variable and array, PSOPHARM =0 ALL or PSOPHARM=1,PSOPHARM(ptr) for list
 S X=$$SELPHARM^PSOBORP1(.PSOSEL) I X="^" Q
 ;
 ;Prompt to Display Summary or Detail Format (Default to Detail)
 ;Returns 1 for Summary, 0 for Detail
 S PSOSMDET=$$SELSMDET^PSOBORP1(2) I PSOSMDET="^" Q
 S PSOSEL("SUM_DETAIL")=PSOSMDET
 ;
 ;
 ;Prompt to select Date Range
 ;Returns (Start Date^End Date)
 S PSOBEGDT=$$SELDATE^PSOBORP1("TRANSACTION") D  I PSOBEGDT="^" Q
 .I PSOBEGDT="^" Q
 .S PSOENDDT=$P(PSOBEGDT,U,2)
 .S PSOBEGDT=$P(PSOBEGDT,U)
 S PSOSEL("BEGIN DATE")=PSOBEGDT
 S PSOSEL("END DATE")=PSOENDDT
 ;
 ;
 ;Prompt to Include (S)pecific TC Code or (A)LL (Default to ALL)
 S PSOREJCD=$$SELTCCD^PSOBORP1(.PSOSEL)
 I PSOREJCD="^" Q
 ;
 ;Prompt to select One of the following: Specific Pharmacist or ALL Pharmacist
 S PSOPHMST=$$SELPHMST^PSOBORP1(.PSOSEL)
 I PSOPHMST="^" Q
 ;
 ;prompt to select one of the following: Specific Provider or ALL Providers
 ;
 S PSOPROV=$$SELPROV^PSOBORP1(.PSOSEL)
 I PSOPROV="^" Q
 ;
 ;
 ;Prompt to Include Group/Subtotal Report by (R) Pharmacy or (P)rovider/Prescriber Name
 ;Returns ()
 S PSOTOTAL=$$PSOTOTAL^PSOBORP1()
 I PSOTOTAL="^" Q
 S PSOSEL("TOTALS BY")=PSOTOTAL
 ;
 ;Prompt for Excel Capture (Detail Only)
 S PSOEXCEL=0 I PSOSEL("SUM_DETAIL")="D" D  I PSOEXCEL="^" Q
 .S PSOEXCEL=$$SELEXCEL^PSOBORP1() I PSOEXCEL="^" Q
 .S PSOSEL("EXCEL")=PSOEXCEL
 ;
 ;Prompt for the Device
 I 'PSOEXCEL D
 .W !!,"WARNING - THIS REPORT REQUIRES THAT A DEVICE WITH 132 COLUMN WIDTH BE USED."
 .W !,"IT WILL NOT DISPLAY CORRECTLY USING 80 COLUMN WIDTH DEVICES",!
 S PSOQ=0 D DEVICE(PSORPTNM) Q:PSOQ
 ;
 ;Compile and Run the Report
 D RUN(.PSOSEL)
 I '$G(PSOUT) D PAUSE^PSOBORP1
 ;
 ;
 ;Compile and Run the Report
 ;
RUN(PSOEXCEL,PSORPTNAM,PSOSMDET) ;
 N PSOPAGE,PSOTMP
 ;
 D RUNRPT^PSOBORP2(.PSOSEL)
 ;
 ;
 Q
 ;
 ;Prompt For the Device
 ;
 ; Returns Device variables and PSOSCR
 ;
DEVICE(PSORPTNAM) N %ZIS,ZTSK,ZTRTN,ZTIO,ZTDESC,ZTSAVE,POP
 S %ZIS="QM"
 D ^%ZIS
 I POP S PSOQ=1
 ;
 ;Check for exit
 I $G(PSOQ) G XDEV
 ;
 S PSOSCR=$S($E($G(IOST),1,2)="C-":1,1:0)
 I $D(IO("Q")) D  S PSOQ=1
 . S ZTRTN="RUN^PSOBORP0(PSOEXCEL,PSORPTNAM,PSOSMDET)"
 . S ZTIO=ION
 . S ZTSAVE("*")=""
 . S ZTDESC="PSO REPORT: "_PSORPTNM
 . D ^%ZTLOAD
 . W !,$S($D(ZTSK):"REQUEST QUEUED TASK="_ZTSK,1:"REQUEST CANCELLED")
 . D HOME^%ZIS
 U IO
XDEV Q
