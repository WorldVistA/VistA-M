SDSCRPT1 ;ALB/JAM/RBS - ASCD Reports for Service Connected Automated Monitor ; 4/24/07 4:30pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 ; Routine should be called at specified tags only.
 Q
RDPOV ; 'ROUTINE' tag called by option "SDSC ENC REPORT - Service Connected Encounters Report"
 N ZTDESC,SDRTN,SDOPT,DIR,DIRUT,X,Y
 W !,"Service Connected Encounters Report"
 S DIR(0)="SO^S:Service Connected;N:Non-Service Connected;A:All"
 S DIR("B")="S",DIR("A")="Which option do you want to run?"
 D ^DIR I $D(DIRUT) Q
 S SDOPT=$S(Y="S":1,Y="N":0,1:2)
 S ZTDESC="COMPARE DISABILITY/POV PER ENCOUNTER",SDRTN="PRINT^SDSCRPT1"
 G LOAD
 ;
NSCCOP ; 'ROUTINE' tag called by option "SDSC FIRST PARTY REPORT - First Party Billable Service Connected Report"
 N ZTDESC,SDRTN
 S ZTDESC="SERVICE CONNECTED CO-PAY REPORT",SDRTN="COPPRT^SDSCRPT1"
 G LOAD
 ;
NSCINS ; 'ROUTINE' tag called by option "SDSC THIRD PARTY REPORT - Third Party Billable Service Connected Report"
 N ZTDESC,SDRTN
 S ZTDESC="SERVICE CONNECTED BILLING INSURANCE REPORT",SDRTN="INSPRT^SDSCRPT1"
 G LOAD
 ;
SCPRV ;Provider Service Connected Encounters Report
 N SDDET,DIR,DIRUT,X,Y,ZTDESC,SDRTN
 W !,"Provider Service Connected Encounters Report"
 S DIR(0)="SO^D:Detail;S:Summary",DIR("B")="S"
 S DIR("A")="Which option do you want to run?"
 D ^DIR I $D(DIRUT) Q
 S SDDET=$S(Y="D":1,1:0)
 S ZTDESC="SERV CONN REVIEW REPORT BY PROVIDER",SDRTN="PRVPRT^SDSCRPT1"
 G LOAD
 ;
SCUSR ;User Service Connected Encounters Report
 N SDDET,DIR,DIRUT,X,Y,ZTDESC,SDRTN
 W !,"User Service Connected Encounters Report"
 S DIR(0)="SO^D:Detail;S:Summary",DIR("B")="S"
 S DIR("A")="Which option do you want to run?"
 D ^DIR I $D(DIRUT) Q
 S SDDET=$S(Y="D":1,1:0)
 S ZTDESC="SERV CONN REVIEW REPORT BY USER",SDRTN="RVWPRT^SDSCRPT1"
 G LOAD
 ;
LOAD ; Standard start tag for all current reports.
 ; Initialize variables if necessary.
 N ZTIO,ZTSAVE,ZTRTN,P,L,SDABRT
 K %ZIS D HOME^%ZIS
 ; Select division
 D DIV I SDQFL G END
 ; Get start and end date for report.
 D GETDATE^SDSCOMP I SDSCTDT="" G END
 ; Initialize page counts
 S (P,L,SDABRT)=0
 ; Prompt user for DEVICE and handle TaskMan queuing if required.
 S %ZIS="QM" D ^%ZIS G END:POP
 I '$D(IO("Q")) U IO K ZTDESC G LOOP
 S ZTIO=ION,ZTSAVE("*")="",ZTRTN="LOOP^SDSCRPT1" D ^%ZTLOAD
 G END
LOOP ; Loop through each division and display the selected report.
 N CT,SDSCDIV,SDSCDNM,SDI,THDR
 S CT=0,SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:SDSCDVSL,1:"")
 I SDSCDIV="" S SDSCDNM="ALL" D @SDRTN
 I SDSCDIV'="" D
 . S THDR=""
 . F SDI=1:1:$L(SDSCDVSL,",") S SDSCDIV=$P(SDSCDVSL,",",SDI) Q:SDSCDIV=""  D  Q:$G(SDABRT)=1
 .. S SDSCDNM=$P(^DG(40.8,SDSCDIV,0),"^",1),THDR=THDR_SDSCDNM_",",CT=CT+1 D @SDRTN
 D RPTEND
 G END
 ;
PRINT ; Display the encounters previously stored for this date.
 ; This is a detailed report, set flag
 N SDDET,SDOEDT,SDOE,SCVAL
 S SDDET=1
 U IO D HEADER^SDSCRPT2 I $G(SDABRT)=1 Q
 ; Loop through all encounters found in that date range.
 S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT  Q:SDOEDT=""  D  Q:$G(SDABRT)=1
 . S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:'SDOE  D  Q:$G(SDABRT)=1
 .. I $G(SDSCDIV)'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. ; Get data
 .. I '$$STDGET Q
 .. S SCVAL=$P(^SDSC(409.48,SDOE,0),U,6)
 .. I $S(SCVAL=SDOPT:1,SDOPT=2:1,1:0) D
 ... D ENCBDDT^SDSCRPT2
 Q
 ;
INSPRT ;Display all encounters that may be billable to insurance.
 N SDHDR,SDOEDT,SDOE,SCVAL
 S SDHDR="OUTPATIENT ENCOUNTERS POTENTIALLY BILLABLE TO INSURANCE"
 U IO D NBILLHD^SDSCRPT2 I $G(SDABRT)=1 Q
 ; Loop through all encounters found in that date range.
 S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT  Q:SDOEDT=""  D  Q:$G(SDABRT)=1
 . S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:'SDOE  D  Q:$G(SDABRT)=1
 .. I $G(SDSCDIV)'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. ; Get data
 .. I '$$STDGET Q
 .. ; Check for ability of patients insurance to be billed
 .. I $$NBTP^SDSCUTL() Q
 .. ; If Not Service Connected (NSC) after reviews, print.
 .. S SCVAL=$$SCHNG^SDSCUTL(SDOE) I '+SCVAL Q
 .. I '($P(SCVAL,U,3)) D NBILLBD^SDSCRPT2
 Q
 ;
COPPRT ;Display all encounters that may be billable for co-payment.
 N SDHDR,SDOEDT,SDOE,SDVAL
 S SDHDR="OUTPATIENT ENCOUNTERS POTENTIALLY BILLABLE FOR CO-PAYS"
 U IO D NBILLHD^SDSCRPT2 I $G(SDABRT)=1 Q
 ; Loop through all encounters found in that date range.
 S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"AE",SDOEDT)) Q:SDOEDT\1>SDEDT  Q:SDOEDT=""  D  Q:$G(SDABRT)=1
 . S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"AE",SDOEDT,SDOE)) Q:'SDOE  D  Q:$G(SDABRT)=1
 .. I $G(SDSCDIV)'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 .. ; Get data
 .. I '$$STDGET Q
 .. ; Check for patients ability to be billed
 .. I $$NBFP^SDSCUTL(SDOE) Q
 .. ; If Not Service Connected (NSC) after reviews, print.
 .. S SDVAL=$$SCHNG^SDSCUTL(SDOE) I '+SDVAL Q
 .. I '$P(SDVAL,U,3) D NBILLBD^SDSCRPT2
 Q
 ;
RVWPRT ;Display all User Reviewed encounters
 ;SDDET=1 - Detailed Report; SDDET=0 - Summary Report
 N SDHDR,SDLEB,SDNWPV,SDPVCN,SDPCT,SDOEDT,SDOE
 S SDHDR="OUTPATIENT ENCOUNTERS SERVICE CONNECTED REVIEW BY USER"
 U IO D RVWHD^SDSCRPT2 I $G(SDABRT)=1 Q
 ; Loop through all encounters found in that date range.
 S SDLEB=0 F  S SDLEB=$O(^SDSC(409.48,"AG",SDLEB)) Q:'SDLEB  D  Q:$G(SDABRT)=1
 . ; Reset flag to print provider name
 . S SDNWPV=1,SDPVCN=0,SDPCT=0
 . S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"AG",SDLEB,SDOEDT)) Q:SDOEDT\1>SDEDT  Q:SDOEDT=""  D  Q:$G(SDABRT)=1
 .. S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"AG",SDLEB,SDOEDT,SDOE)) Q:'SDOE  D  Q:$G(SDABRT)=1
 ... I $G(SDSCDIV)'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 ... ; Get data
 ... I '$$STDGET Q
 ... S SDPCT=SDPCT+1
 ... D RVWBD^SDSCRPT2
 . I SDPCT'=0 W ?3,"Total: "_SDPCT,! S L=L+1 Q
 Q
 ;
PRVPRT ;Display all User Reviewed encounters by Provider
 ;SDDET=1 - Detailed Report; SDDET=0 - Summary Report
 N SDHDR,SDPROV,SDNWPV,SDPVCN,SDPCT,SDOE,SDOEDT
 S SDHDR="OUTPATIENT ENCOUNTERS SERVICE CONNECTED REVIEW BY PROVIDER"
 U IO D PRVHD^SDSCRPT2 I $G(SDABRT)=1 Q
 ; Loop through all encounters found in that date range.
 S SDPROV=0 F  S SDPROV=$O(^SDSC(409.48,"AF",SDPROV)) Q:'SDPROV  D  Q:$G(SDABRT)=1
 . ; Reset flag to print provider name, without the continued label.
 . S SDNWPV=1,SDPVCN=0,SDPCT=0
 . S SDOEDT=SDSCTDT F  S SDOEDT=$O(^SDSC(409.48,"AF",SDPROV,SDOEDT)) Q:SDOEDT\1>SDEDT  Q:SDOEDT=""  D  Q:$G(SDABRT)=1
 .. S SDOE=0 F  S SDOE=$O(^SDSC(409.48,"AF",SDPROV,SDOEDT,SDOE)) Q:'SDOE  D  Q:$G(SDABRT)=1
 ... I $G(SDSCDIV)'="" Q:$P(^SDSC(409.48,SDOE,0),U,12)'=SDSCDIV
 ... ; Get data
 ... I '$$STDGET Q
 ... S SDPCT=SDPCT+1
 ... D PRVBD^SDSCRPT2
 . I SDPCT'=0 W ?3,"Total: "_SDPCT,! S L=L+1 Q
 Q
 ;
RPTEND ;Report cleSDp.
 I '$G(SDABRT) W !,"<End of Report>" I $E(IOST,1,2)="C-" D
 .N DIR S DIR(0)="E" D ^DIR
 I $G(SDABRT)=1 W !,"<Report Aborted>"
 D ^%ZISC
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
STDGET() ; All standard data retrieval from SD, Encounter and Visit.
 ; Get compiled data
 S SDDATA=$G(^SDSC(409.48,SDOE,0)) Q:SDDATA="" 0
 ; Get encounter data
 S SDOEDAT=$$GETOE^SDOE(SDOE) Q:SDOEDAT="" 0
 ; Get patient
 S SDPAT=$P(SDOEDAT,U,2) Q:SDPAT="" 0
 ; Get clinic info
 S SDCLIN=$P(SDOEDAT,U,4) Q:SDCLIN="" 0
 ; Get clinic stop code info
 S SDCST=$P(SDOEDAT,U,3) Q:SDCST="" 0
 ; Retrieving the visit number, quit if no visit number found
 S SDV0=$P(SDOEDAT,U,5) Q:SDV0="" 0
 Q 1
 ;
END ; Clear all variables before exiting.
 K SDSCTDT,SDEDT,SDFILEOK,X,X1,X2,Y,SDV0,SDDATA,SDPAT,SDCLIN,SDCST
 K ZTQUEUED,ZTREQ,SDPOV,SDVPOV0,SDPROV,DTOUT,DUOUT,POP,SDSCBDT,SDSCEDT
 K SDQFL,SDPCTS,SDSCDVSL,SDSCDVLN,SDRTN,SCLN,SDOEDAT
 Q
 ;
DIV ;  Ask Division
 N DIR,X,Y
 S SDQFL=0
 D DIV^SDSCUTL
 D ^DIR
 I $G(DTOUT)!($G(DUOUT)) S SDQFL=1 Q
 S SDSCDVSL=Y,SDSCDVLN=SCLN
 Q
