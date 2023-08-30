IBCNERP4 ;DAOU/BHS - IBCNE USER INTERFACE eIV PAYER REPORT ;03-JUN-2002
 ;;2.0;INTEGRATED BILLING;**184,271,300,416,528,668,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ;
 ; IB*737/TAZ - Remove refrences to ~NO PAYER
 ;
 ; Input parameter: N/A
 ; Other relevant variables:
 ;   IBCNERTN = "IBCNERP4" (current routine name for queueing the 
 ;                          COMPILE process)
 ;   IBCNESPC("BEGDT") = start date for date range
 ;   IBCNESPC("ENDDT") = end date for date range
 ;   IBCNESPC("PYR") = payer ien for report, if = "", then include all
 ;   IBCNESPC("SORT") = 1 - Payer name OR 2 - Total Inqs (PAYER)
 ;   IBCNESPC("DTL") = 1 - YES OR 0 - NO  Include Rejection Detail in
 ;                     report output - rejections broken down by code
 ;
 ; Enter only from EN tag
 ; 
 ; Added tag DATA as split out from program IBCNERP5 for size restrictions
 QUIT
 ;
 ; Entry point
EN ;
 ; Initialize variables
 NEW STOP,IBCNERTN,POP,IBCNESPC,IBOUT
 ;
 S STOP=0
 S IBCNERTN="IBCNERP4"
 W @IOF
 W !,"eIV Payer Report",!
 W !,"Insurance verification inquiries are created daily."
 W !,"Select a date range in which inquiries were created by the eIV extracts."
 ;
 ; Prompts for Payer Report
 ; Date Range parameters
P10 D DTRANGE I STOP G EXIT
 ; Payer Selection parameter
P20 D PYRSEL^IBCNERP1 I STOP G:$$STOP^IBCNERP1 EXIT G P10
 ; Include Rejection Detail in Payer report
P30 D REJDTL I STOP G:$$STOP^IBCNERP1 EXIT G P20
 ; Sort by parameter - Payer or Total Inquiries
P40 D SORT I STOP G:$$STOP^IBCNERP1 EXIT G P30
 ; Select the output type
P60 S IBOUT=$$OUT I STOP G:$$STOP^IBCNERP1 EXIT G P40
 ; Select the output device
P100 D DEVICE^IBCNERP1(IBCNERTN,.IBCNESPC,IBOUT) I STOP G:$$STOP^IBCNERP1 EXIT G P40
 ;
EXIT ; Quit this routine
 QUIT
 ;
 ;
SORT ; Prompt to allow users to sort the report
 ;  by Payer(default) OR Total Inquiries, then Payer
 ; Initialize variables
 NEW DIR,X,Y,DIRUT
 ;
 S DIR(0)="S^1:Payer Name;2:Total Inquiries"
 S DIR("A")=" Select the primary sort field"
 S DIR("B")=1
 S DIR("?",1)="  1 - Payer Name is the only sort. (Default)"
 S DIR("?",2)="  2 - Total Inquiries is the primary sort, Payer Name is"
 S DIR("?")="      the secondary sort."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBCNESPC("SORT")=Y
 ;
SORTX ; SORT exit point
 QUIT
 ;
 ;
REJDTL ; Prompt to allow users to include the Rejection Detail in the report
 ; Initialize variables
 NEW DIR,X,Y,DIRUT
 ;
 S DIR(0)="Y"
 S DIR("A")="      Include Rejection Detail"
 S DIR("B")="NO"
 S DIR("?",1)="  N - No, exclude Rejection Detail totals from report. (Default)"
 S DIR("?")="  Y - Yes, include Rejection Detail totals in report."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G REJDTLX
 S IBCNESPC("DTL")=Y
 ;
REJDTLX ; REJDTL exit point
 QUIT
 ;
 ;
DTRANGE ; Determine the start and end dates for the date range parameter
 ; Initialize variables
 NEW X,Y,DIRUT
 ;
 W !
 ;
 S DIR(0)="D^::EX"
 S DIR("A")="Start DATE"
 S DIR("?",1)="   Please enter a valid date for which an eIV Inquiry"
 S DIR("?")="   would have been created."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANG1 S DIR(0)="D^::EX"
 S DIR("A")="  End DATE"
 S DIR("?",1)="   Please enter a valid date for which an eIV Inquiry"
 S DIR("?",2)="   would have been created.  This date must not precede"
 S DIR("?")="   the Start Date."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 I Y<IBCNESPC("BEGDT") D  G DTRANG1
 . W !,"     End Date must not precede the Start Date."
 . W !,"     Please reenter."
 S IBCNESPC("ENDDT")=Y
 ;
DTRANGX ; DTRANGE exit point
 QUIT
 ;
 ;
 ; called from IBCNERP5
 ; Loop through the eIV Response File (#365) 
 ;  By DATE/TIME RECEIVED & PAYER & PATIENT Cross-Reference ("AE")
 ;
 ;IB*737/TAZ - Remove references to Most Popular Payer and "~NO PAYER"
DATA N DEACT,RDATA,RDATA1,TQDATA,IBCNEDT,IBCNEPTR,IBCNEPAT,RPYRIEN,RPYNM,PYRIEN,IBPNM,ERRCON
 N IBPIEN,PC,ERR,ERRTXT,PYRNM,APIEN,IBCNEPTD,TQIEN
 S IBCNEDT=$O(^IBCN(365,"AD",IBCNEDT1),-1)
 F  S IBCNEDT=$O(^IBCN(365,"AD",IBCNEDT)) Q:IBCNEDT=""!($P(IBCNEDT,".",1)>IBCNEDT2)  D  Q:$G(ZTSTOP)
 . I $D(ZTQUEUED),$$S^%ZTLOAD() S ZTSTOP=1 QUIT
 . S IBCNEPAT=0
 . F  S IBCNEPAT=$O(^IBCN(365,"AD",IBCNEDT,IBCNEPAT)) Q:'IBCNEPAT  D  Q:$G(ZTSTOP)
 .. S IBCNEPTD=0
 .. F  S IBCNEPTD=$O(^IBCN(365,"AD",IBCNEDT,IBCNEPAT,IBCNEPTD)) Q:'IBCNEPTD  D  Q:$G(ZTSTOP)
 ... S IBCNEPTR=0
 ... F  S IBCNEPTR=$O(^IBCN(365,"AD",IBCNEDT,IBCNEPAT,IBCNEPTD,IBCNEPTR)) Q:'IBCNEPTR  D  Q:$G(ZTSTOP)
 .... ; Get data from Resp File
 .... S RDATA=$G(^IBCN(365,IBCNEPTR,0))
 .... I RDATA="" Q
 .... ; ONLY select Transmission status 3
 .... I $P($G(RDATA),U,6)'=3 Q
 .... ; Determine Payer name from Payer File (#365.12)
 .... S RPYRIEN=$P($G(RDATA),U,3)
 .... I 'RPYRIEN Q
 .... ; Check payer filter
 .... I IBCNEPY'="",RPYRIEN'=IBCNEPY Q
 .... S RPYNM=$P($G(^IBE(365.12,RPYRIEN,0)),U)
 .... I RPYNM="" Q
 .... ; link to TQ file
 .... S TQIEN=$P($G(RDATA),U,5)
 .... I TQIEN="" Q
 .... ; Get data from TQ file (365.1)
 .... S TQDATA=$G(^IBCN(365.1,TQIEN,0))
 .... I TQDATA="" Q
 .... ; Get TQ Payer from (365.1) File
 .... S PYRIEN=$P($G(TQDATA),U,3) Q:PYRIEN=""
 .... S PYRNM=$P($G(^IBE(365.12,PYRIEN,0)),U)
 .... ;  Cancelled (7) - Payer deactivated
 .... I $P($G(TQDATA),U,4)=7 Q
 .... ;IB*668/TAZ - Call PYRDEACT to get Payer Deactivated from new file location.
 .... ; Determine Deactivation DTM for eIV application
 .... S DEACT=$$PYRDEACT^IBCNINSU(RPYRIEN)
 .... I +DEACT S $P(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*"),U,11)=$P(DEACT,U,2)
 .... ; Determine Deactivation DTM for eIV application
 .... I PYRIEN'=RPYRIEN D
 ..... S DEACT=$$PYRDEACT^IBCNINSU(PYRIEN)
 ..... I +DEACT S $P(^TMP($J,IBCNERTN,PYNM,PYRIEN,"*"),U,11)=$P(DEACT,U,2)
 .... ; Get error text
 .... S ERRTXT=$G(^IBCN(365,IBCNEPTR,4))
 .... ; Now get the data from Response file for the report
 .... S RDATA1=$G(^IBCN(365,IBCNEPTR,1)),ERRCON=$P($G(RDATA1),U,14)
 .... ; Increment for non-error (GOOD) response and quit
 .... I ERRCON="",ERRTXT="" D  Q
 ..... S $P(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*"),U,6)=$P($G(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*")),U,6)+1
 .... ; Rejection is defined as having a value in the Error Condition field or Error Text field
 .... ; Increment for error response
 .... S $P(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*"),U,7)=$P($G(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*")),U,7)+1
 .... ; Store rejection detail only if user requested it
 .... I 'IBCNEDTL Q
 .... I ERRCON S ^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*",ERRCON)=$G(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*",ERRCON))+1
 .... I 'ERRCON,ERRTXT'="" S ^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*",0_U_ERRTXT)=$G(^TMP($J,IBCNERTN,RPYNM,RPYRIEN,"*",0_U_ERRTXT))+1
 Q
 ;
OUT() ; Prompt to allow users to select output format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 D ^DIR I $D(DIRUT) S STOP=1 Q ""
 Q Y
