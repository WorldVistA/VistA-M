HBHCUTL5 ; LR VAMC(IRMS)/MJT-HBHC Medical Foster Home (MFH) Rate Paid report utility module; Entry points:  EN, EXIT, MFH, PT, PRTPT, PRTMFH; called by: ^HBHCRP28 & ^HBHCTXT ; Dec 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
EN ; Entry point; user selects: patient or MFH; active only, individual, or all pts or MFHs; current rate paid only or entire rate paid history
 ; Prompt for patient or MFH report 
 K DIR S DIR(0)="SB^P:Patient;M:Medical Foster Home (MFH)",DIR("A")="Sort by Patient or Medical Foster Home (MFH)",DIR("?")="Enter P for Patient or M for Medical Foster Home (MFH) for sorting the report." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHCXREF=$S(Y="P":"AJ",1:"AK"),HBHCWHO=$S(HBHCXREF="AJ":" Patient(s)",1:" MFH(s)")
 ; Prompt for inclusion of Active ONLY, Individual, or All
 K DIR S DIR(0)="SB^O:Active ONLY;I:Individual;A:All",DIR("A")="Include:  Active ONLY, Individual, or All "_HBHCWHO
 S DIR("?")="Enter O for Active ONLY, I for Individual, or A for All Patient(s) or Medical Foster Home(s) (MFHs) for inclusion on the report." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHCDIR=$S(Y="O":"O",Y="I":"I",1:"A")
 ; Prompt for individual patient(s) or MFH(s)
 I HBHCDIR="I" K DIC,HBHCTMP D PROMPT
 K DIC
 ; Prompt for Current Rate Paid, or All
 K DIR S DIR(0)="SB^C:Current Rate;A:All Rates Paid",DIR("A")="Include:  Current Rate, or All Rates Paid"
 S DIR("?")="Enter C for Current Rate, or A for All Rates Paid for inclusion on the report." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHC=$S(Y="C":"C",1:"A")
 ; Prompt for inclusion of Discharged Patients on MFH sort
 I HBHCXREF="AK" K DIR S DIR(0)="SB^Y:Yes;N:No",DIR("A")="Include:  Discharged Patients",DIR("?")="Enter Y to Include Discharged Patients, or N to omit them from inclusion on the report." D ^DIR
 I HBHCXREF="AK" G:$D(DIRUT) EXIT S HBHCYN=$S(Y="Y":"Y",1:"N")
 Q
EXIT ; Exit module
 D ^%ZISC
 K DIC,DIR,HBHC,HBHC1,HBHC2,HBHC3,HBHCCC,HBHCCNT,HBHCCOLM,HBHCCURJ,HBHCCURK,HBHCCURL,HBHCDIR,HBHCDLMT,HBHCDPT0,HBHCHDR,HBHCHDRX,HBHCHEAD,HBHCHI,HBHCI,HBHCINFO,HBHCJ,HBHCK,HBHCL,HBHCLOW,HBHCMFHN,HBHCMFHP,HBHCM,HBHCPAGE,HBHCTDY
 K HBHCTMP,HBHCTOT,HBHCTXT,HBHCWHO,HBHCXREF,HBHCY,HBHCYN,HBHCZ,X,Y,^TMP("HBHC",$J)
 Q
PROMPT ; Prompt user for individual Patient or Medical Foster Home (MFH) name
 I HBHCXREF="AJ" S DIC="^HBHC(631,",DIC("S")="I $P($G(^HBHC(631,Y,3)),U)=""Y"""
 I HBHCXREF="AK" S DIC="^HBHC(633.2,"
 S DIC(0)="AEMQZ"
DIC ; Call ^DIC
 D ^DIC
 Q:(Y=-1)!($D(DTOUT))!($D(DUOUT))
 S HBHCTMP(+Y)="" G DIC
 Q
PT ; Process Patient
 D:HBHCDIR="I" INDPT
 D:HBHCDIR'="I" ALLPT
 Q
INDPT ; Process Individual Patients
 S HBHCI=0 F  S HBHCI=$O(HBHCTMP(HBHCI)) Q:HBHCI'>0  D RATE
 Q
ALLPT ; Process All or Active ONLY Patients
 S HBHCI=0 F  S HBHCI=$O(^HBHC(631,"AJ","Y",HBHCI)) Q:HBHCI'>0  D:HBHCDIR'="O" RATE D:(HBHCDIR="O")&($P(^HBHC(631,HBHCI,0),U,40)="") RATE
 Q
MFH ; Process Medical Foster Home (MFH)
 D:HBHCDIR="I" INDMFH
 D:HBHCDIR'="I" ALLMFH
 Q
INDMFH ; Process Individual Medical Foster Home (MFH)
 S HBHCL=0 F  S HBHCL=$O(HBHCTMP(HBHCL)) Q:HBHCL'>0  I $D(^HBHC(631,"AK",HBHCL)) S HBHCCURL=HBHCL S HBHCI=0 F  S HBHCI=$O(^HBHC(631,"AK",HBHCL,HBHCI)) Q:HBHCI'>0  D RATE
 Q
ALLMFH ; Process All or Active ONLY Medical Foster Homes (MFH)
 S HBHCL=0 F  S HBHCL=$O(^HBHC(633.2,HBHCL)) Q:HBHCL'>0  I $D(^HBHC(631,"AK",HBHCL)) S HBHCCURL=HBHCL S HBHCI=0 F  S HBHCI=$O(^HBHC(631,"AK",HBHCL,HBHCI)) Q:HBHCI'>0  D:HBHCDIR'="O" RATE D:(HBHCDIR="O")&($P(^HBHC(633.2,HBHCL,0),U,6)="") RATE
 Q
RATE ; Process Rate Multiple
 ; MFH sort => Q:Discharged patients are to be omitted
 I HBHCXREF="AK" I HBHCYN="N" Q:($P(^HBHC(631,HBHCI,0),U,40)]"")
 D:HBHC="A" ALLRATE
 D:HBHC="C" CURRATE
 Q
ALLRATE ; Process All Rates
 S HBHCJ=0 F  S HBHCJ=$O(^HBHC(631,HBHCI,4,"B",HBHCJ)) Q:HBHCJ'>0  S HBHCK=0 F  S HBHCK=$O(^HBHC(631,HBHCI,4,"B",HBHCJ,HBHCK)) Q:HBHCK'>0  D REPORT
 Q
CURRATE ; Process Current Rate Only
 S HBHCJ=0 F  S HBHCJ=$O(^HBHC(631,HBHCI,4,"B",HBHCJ)) Q:HBHCJ'>0  S HBHCCURJ=HBHCJ,HBHCK=0 F  S HBHCK=$O(^HBHC(631,HBHCI,4,"B",HBHCJ,HBHCK)) Q:HBHCK'>0  S HBHCCURK=HBHCK
 D REPORT
 Q
REPORT ; Set TMP for report format
 S HBHCDPT0=$G(^DPT($P(^HBHC(631,HBHCI,0),U),0))
 S:HBHCXREF="AJ" HBHCMFHP=$P($G(^HBHC(631,HBHCI,3)),U,2)
 I HBHCXREF="AJ" S:HBHCDPT0]"" ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCI,$S(HBHC="A":HBHCJ,1:HBHCCURJ),$S(HBHC="A":HBHCK,1:HBHCCURK))=$P(^HBHC(631,HBHCI,4,$S(HBHC="A":HBHCK,1:HBHCCURK),0),U,2)_U_$E($P(HBHCDPT0,U,9),6,9)_U_HBHCMFHP
 S:(HBHCXREF="AK")&(HBHCDPT0]"") HBHCMFHN=$P($G(^HBHC(633.2,$S(HBHC="A":HBHCL,1:HBHCCURL),0)),U)
 I HBHCXREF="AK" S:(HBHCDPT0]"")&(HBHCMFHN]"") ^TMP("HBHC",$J,HBHCMFHN,$P(HBHCDPT0,U),HBHCI,$S(HBHC="A":HBHCJ,1:HBHCCURJ),$S(HBHC="A":HBHCK,1:HBHCCURK))=$P(^HBHC(631,HBHCI,4,$S(HBHC="A":HBHCK,1:HBHCCURK),0),U,2)_U_$E($P(HBHCDPT0,U,9),6,9)
 Q
PRTPT ; Print loop for Patient sort
 S HBHCM="" F  S HBHCM=$O(^TMP("HBHC",$J,HBHCM)) Q:HBHCM=""  S HBHCI="" F  S HBHCI=$O(^TMP("HBHC",$J,HBHCM,HBHCI)) Q:HBHCI=""  W:(HBHCCNT>0)&('$D(HBHCTXT)) !,HBHCY S HBHCJ="" F  S HBHCJ=$O(^TMP("HBHC",$J,HBHCM,HBHCI,HBHCJ)) Q:HBHCJ=""  D CONTPT
 Q
CONTPT ; Cont Patient Loop
 S HBHCK="" F  S HBHCK=$O(^TMP("HBHC",$J,HBHCM,HBHCI,HBHCJ,HBHCK)) Q:HBHCK=""  S HBHCINFO=^TMP("HBHC",$J,HBHCM,HBHCI,HBHCJ,HBHCK) D:'$D(HBHCTXT) PRINTPT^HBHCRP28 D:$D(HBHCTXT) TXT^HBHCTXT
 Q
PRTMFH ; Print loop for MFH sort
 S HBHCL="" F  S HBHCL=$O(^TMP("HBHC",$J,HBHCL)) Q:HBHCL=""  S HBHCM="" F  S HBHCM=$O(^TMP("HBHC",$J,HBHCL,HBHCM)) Q:HBHCM=""  S HBHCI="" F  S HBHCI=$O(^TMP("HBHC",$J,HBHCL,HBHCM,HBHCI)) Q:HBHCI=""  W:(HBHCCNT>0)&('$D(HBHCTXT)) !,HBHCY D CONTMFH
 Q
CONTMFH ; Cont MFH Loop
 S HBHCJ="" F  S HBHCJ=$O(^TMP("HBHC",$J,HBHCL,HBHCM,HBHCI,HBHCJ)) Q:HBHCJ=""  D CONTMFH2
 Q
CONTMFH2 ; Cont MFH Loop again...
 S HBHCK="" F  S HBHCK=$O(^TMP("HBHC",$J,HBHCL,HBHCM,HBHCI,HBHCJ,HBHCK)) Q:HBHCK=""  S HBHCINFO=^TMP("HBHC",$J,HBHCL,HBHCM,HBHCI,HBHCJ,HBHCK) D:'$D(HBHCTXT) PRINTMFH^HBHCRP28 D:$D(HBHCTXT) TXT^HBHCTXT
 Q
