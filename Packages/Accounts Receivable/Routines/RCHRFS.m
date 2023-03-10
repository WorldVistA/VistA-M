RCHRFS ;SLC/SS - High Risk for Suicide Patients Report ; JAN 22,2021@14:32
 ;;4.5;Accounts Receivable;**379**;Mar 20, 1995;Build 16
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;
 ;External References  Type         ICR #
 ;-------------------  -----------  -----
 ; HOME^%ZIS           Supported    10086
 ; ^%ZISC              Supported    10089
 ; $$S^%ZTLOAD         Supported    10063
 ; $$GETFLAG^DGPFAPIU  Contr. Sub.  5491
 ; ^DIC                Supported    10006
 ; WAIT^DICD           Supported    10024
 ; RECALL^DILFD        Supported    2055
 ; ^DIR                Supported    10026
 ; $$SITE^VASITE       Supported    10112
 ; $$FMTE^XLFDT        Supported    10103
 ; $$NOW^XLFDT         Supported    10103
 ; $$CJ^XLFSTR         Supported    10104
 ; EN^XUTMDEVQ         Supported    1519
 ;
 ;Access to files
 ; ICR#  TYPE          Description
 ;----- -----------    --------------------------------------------------------------------
 ; 7229 Controlled     File (#26.13) access to the "C" cross-reference for patient look-up.  
 ;
 ;Global References    Supported by
 ;-----------------    --------------
 ; ^TMP($J             SACC 2.3.2.5.1
 ;
 ;No direct call
 Q
 ;
 ;Entry point for PRCA HRFS RECONCILIATION RPT
MAIN ; Initial Interactive Processing
 N RCPATMOD,RCEXLOOP,RCEXPRG,RCZZ
 N RCSORT   ;array of report parameters for ZTSAVE
 W @IOF
 N ZTDESC,ZTQUEUED,ZTREQ,ZTSAVE,ZTSTOP,%ZIS
 ;check for database
 W "*** CPAC High Risk Veteran Reconciliation Report *** "
 W !!,"This report captures detailed 1st party bill information for Veterans"
 W !,"with a High Risk for Suicide flag (HRfS) within a user specified range of"
 W !,"dates of service. This report can be run for a single Veteran or all Veterans."
 W !,"This report output requires screen size of 256 characters wide."
 W !
 ; select the mode
 S RCSORT=""
 S RCPATMOD=$$YESNO("Do you want to run the report for ALL Veterans","YES")
 ; quit if no answer
 I RCPATMOD<0 Q
 ;if "ALL then set RCSORT to ALL
 S RCSORT=$S(RCPATMOD=1:"ALL",1:"")
 ;select the patient if single patient mode: 
 I RCPATMOD=0 Q:'$$PROMPTPT(.RCSORT)  Q:RCSORT<1  D RECALL^DILFD(2,+RCSORT_",",DUZ)
 ;Prompt user for the start date and end dates
 S RCEXLOOP=0,RCEXPRG=0
 F  D  Q:RCEXLOOP=1 
 .N RCZ,RCZ2
 .W !
 .S RCZ=$$ASKDATE("Enter From Date:  ",,DT,,"^D HELP^RCHRFS(1)")
 .I RCZ'>0 S RCEXLOOP=1,RCEXPRG=1 Q
 .S RCSORT("RCBEG")=RCZ
 .;Prompt user for TO Date of Eligibility Change
 .S RCZ=$$ASKDATE("Enter To Date:  ",RCSORT("RCBEG"),DT,"TODAY","^D HELP^RCHRFS(2,"_RCSORT("RCBEG")_")")
 .I RCZ'>0 S RCEXLOOP=1,RCEXPRG=1 Q
 .S RCSORT("RCEND")=RCZ
 .;if ALL patients mode then do not check for HRfS for the range and ask only once 
 .I RCSORT="ALL" S RCEXLOOP=1 Q
 .;if single patient mode then check the HRfS for the range and ask for dates again if necessary 
 .S RCZ2=$$HASHRFS^RCHRFSUT(RCSORT,RCSORT("RCBEG"),RCSORT("RCEND"))
 .I RCZ2=0 W !!,"Veteran's HRfS flag was not active during the selected date range.",!,"Please enter a new date range.",! Q
 .S RCEXLOOP=1
 .W !
 ;if the user wanted to quit at the date prompts
 I RCEXPRG=1 Q
 ;Select copay type
 S RCZZ=$$SELCOTYP(3)
 I RCZZ="^" Q
 S RCSORT("COPAYTYPE")=RCZZ
 ;Select IB status
 S RCZZ=$$SELIBST(5)
 I RCZZ="^" Q
 S RCSORT("IBSTATUS")=RCZZ
 ;prompt for device
 W !!,"The number of characters per row should be set to 256.",!
 W !,"Please use the following path to modify the display settings:"
 W !,"In Reflections. File >>> Terminal Configuration >>> "
 W !,"Setup Display Setting >>> Number of characters per row.",!
 W !,"To capture as a spreadsheet format, it is recommended that you"
 W !,"enter the following at the DEVICE prompt: 0;256;99999."
 W !,"This should help avoid wrapping problems.",!
 W !,"For pagination, please use "";256;"" for the device value instead of the default.",!
 ;
 ;set the prompt and run the report in background
PRMPT ;
 S %ZIS=""
 S %ZIS("B")="0;256;99999"
 S ZTSAVE("RCSORT(")=""
 S X="CPAC High Risk Veteran Reconciliation Report"
 D EN^XUTMDEVQ("START^RCHRFS",X,.ZTSAVE,.%ZIS)
 D HOME^%ZIS
 Q
 ;
START ; compile and print report
 I $E(IOST)="C" D WAIT^DICD
 N HERE S HERE=$$SITE^VASITE ;extract the IEN and facility name where the report is run
 N TRM S TRM=($E(IOST)="C")
 D REPORT(.RCSORT)
 I '$G(IBQUIT) D ASKCONT(0)
 D EXIT
 Q
 ;
 ;Main entry point for report body
REPORT(RCSORT) ;
 N DDASH,RCPAGE,RCDFN,DATA,SORTENCBY,RCREF,RCFL
 S $P(DDASH,"=",81)=""
 S (RCPAGE,SORTENCBY)=0
 ;
 I RCSORT="ALL" D
 . S RCREF=$$GETFLAG^DGPFAPIU("HIGH RISK FOR SUICIDE","N")
 . S RCDFN=0
 . F  S RCDFN=$O(^DGPF(26.13,"C",RCDFN)) Q:'RCDFN  D
 .. S RCFL=""
 .. F  S RCFL=$O(^DGPF(26.13,"C",RCDFN,RCFL)) Q:'RCFL  I RCFL=RCREF D
 ... D RUNRPT^RCHRFS1(+RCDFN,RCSORT("RCBEG"),RCSORT("RCEND"),+RCSORT("IBSTATUS"),+RCSORT("COPAYTYPE"))
 ;
 I RCSORT>0 D RUNRPT^RCHRFS1(+RCSORT,RCSORT("RCBEG"),RCSORT("RCEND"),+RCSORT("IBSTATUS"),+RCSORT("COPAYTYPE"))
 ;
 ;No data found , display message and quit
 I '$D(^TMP($J,"RCHRFS")) S POP=1 D  Q
 . D HEADER,COLHEAD
 . W !!!," >>> No records were found in the selected date range.",!!
 ;
 ;I data was found then do the rest 
 S TRM=1
 S IBQUIT=0
 ;
 D HEADER,COLHEAD
 D OUTPRPT^RCHRFS1
 Q
 ;
HEADER ;Display header for the report
 N RCHRFSDT
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 Q
 I TRM!('TRM&RCPAGE) W @IOF
 S RCPAGE=$G(RCPAGE)+1
 S RCHRFSDT=$$HRFSDATE^RCHRFSUT()
 W !,$G(ZTDESC)
 W !,"Legislation Date: "_$S(RCHRFSDT="":"TBD",1:$$FMTE^XLFDT(RCHRFSDT,"5Z"))
 W !,"Run date: ",$$FMTE^XLFDT($$NOW^XLFDT,"MP")
 W !,"Service Dates From ",?12,$$FMTE^XLFDT(RCSORT("RCBEG"),"5Z")_" To "_$$FMTE^XLFDT(RCSORT("RCEND"),"5Z")
 W !,"Copay Type Selected: "_$P(RCSORT("COPAYTYPE"),U,2)
 W !,"IB Status Selected: "_$P(RCSORT("IBSTATUS"),U,2)
 W !
 Q
 ;
ASKCONT(FLAG) ; display "press <Enter> to continue" prompt
 N Z
 W !!,$$CJ^XLFSTR("Press <Enter> to "_$S(FLAG=1:"continue.",1:"exit."),20)
 R !,Z:DTIME
 Q
 ;
 ;
 ;------PRCA 393 utilities ------------------------------------------
EXIT ;
 I $D(ZTQUEUED) S ZTREQ="@"  ;tell TaskMan to delete Task log entry
 I '$D(ZTQUEUED) D
 . I 'TRM,$Y>0 W @IOF
 . K %ZIS,POP
 . D ^%ZISC,HOME^%ZIS
 Q
 ;
 ;
 ; Ask Yes/No questions
 ; Input:
 ;  PROMPT - question
 ;  DFLANSW - default answer 
 ; Output: 
 ; 1 YES
 ; 0 NO
 ; -1 if cancelled
YESNO(PROMPT,DFLANSW) ;
 N DIR
 N DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y"
 I $G(PROMPT)'="" S DIR("A")=PROMPT
 S:$L($G(DFLANSW)) DIR("B")=DFLANSW
 S DIR("?")="ENTER Y(ES) OR N(O)"
 D ^DIR
 Q $S($G(DUOUT)!$G(DUOUT)!(Y="^"):-1,1:Y)
 ;
 ;prompt for FROM and TO dates
 ; RCDIRA - prompt
 ; RCBEGDT - default date in FM format
ASKDATE(RCPROMPT,RCMINDT,RCMAXDT,RCDFLANS,RCHELP) ;
 N RCASK,RCDIRO
 S RCMINDT=$G(RCMINDT)
 S RCMAXDT=$G(RCMAXDT)
 S RCDFLANS=$G(RCDFLANS)
 I RCDFLANS="" I RCMINDT>0 S RCDFLANS=$$FMTE^XLFDT(RCMINDT)
 S RCDIRO="DAO^"_RCMINDT_":"_RCMAXDT_":EX"
 S RCASK=$$ANSWER(RCPROMPT,RCDFLANS,RCDIRO,RCHELP)
 Q RCASK
 ;
 ;Generic code to ask questions
ANSWER(RCDIRA,RCDIRB,RCDIR0,RCDIRH) ;
 ; Input
 ; RCDIR0 - DIR(0) string
 ; RCDIRA - DIR("A") string
 ; RCDIRB - DIR("B") string
 ; RCDIRH - DIR("?") string
 ; Output
 ; Function Value - Internal value returned from ^DIR or -1 if user
 ; up-arrows, double up-arrows or the read times out.
 N X,Y,Z,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 I $D(RCDIR0) S DIR(0)=RCDIR0
 I $D(RCDIRA) M DIR("A")=RCDIRA
 I $G(RCDIRB)]"" S DIR("B")=RCDIRB
 I $D(RCDIRH) S DIR("?")=RCDIRH,DIR("??")=RCDIRH
 D ^DIR K DIR
 S Z=$S($D(DTOUT):-2,$D(DUOUT):-1,$D(DIROUT):-1,1:"")
 I Z="" S Z=$S(Y=-1:"",X="@":"@",1:$P(Y,U)) Q Z
 I $D(DTOUT)!$D(DUOUT)!$D(DIROUT) Q -1
 Q $S(X="@":"@",1:$P(Y,U))
 ;
 ;provide extended DIR("?") help text.
HELP(RCSEL,RCFRDT) ;
 ; Input: RCSEL - prompt var for help text word selection
 ; Output: none
 I (X="?")!(X="??") D  Q
 . I RCSEL=1 D
 . . W !,"  Enter the FROM date"
 . I $D(Y) K Y
 . I RCSEL=2 D
 . . W !,"  Enter the TO date"
 . I $D(Y) K Y
 I $D(Y),Y<1 D HELP1 I $D(Y) K Y Q
 I $D(Y),Y>DT D HELP2 I $D(Y) K Y Q
 I $D(Y),Y<$G(RCFRDT) D HELP3 I $D(Y) K Y Q
 Q
 ;
HELP1 ;
 W !,"  Invalid Date"
 Q
 ;
HELP2 ;
 W !,"  Date cannot be a future date."
 Q
 ;
HELP3 ;
 W !,"  Date cannot be earlier than the From date."
 Q
 ;
 ;select copay type
SELCOTYP(DFLT) ;
 ;Return Value ->
 ;     1         Medical Care"
 ;     2         Outpatient Medication"
 ;     3         Both (Medical Care and Outpatient Medication)"
 ;     ^         Exit
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Which type of copayment do you wish to see?"
 S DIR(0)="S^1:Medical Care;2:Outpatient Medication;3:Both (Medical Care and Outpatient Medication)"
 S DIR("A")="Enter selection (1,2 or 3)"
 S DIR("B")=DFLT
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     1         Medical Care"
 S DIR("L",4)="     2         Outpatient Medication"
 S DIR("L",5)="     3         Both (Medical Care and Outpatient Medication)"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 I Y="^" Q Y
 Q Y_U_Y(0)
 ;
 ;
 ;select copay type
SELIBST(DFLT) ;
 ;Return Value ->   
 ;     1         Medical Care"
 ;     2         Outpatient Medication"
 ;     3         Both (Medical Care and Outpatient Medication)"
 ;     ^         Exit
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 W !!,"Which IB status for the selected copayment(s) do you wish to see?"
 S DIR(0)="S^1:Billed;2:On Hold;3:Cancelled;4:Billed and On Hold;5:ALL (Billed, On Hold, Cancelled)"
 S DIR("A")="Enter Status selection (1,2,3,4 or 5)"
 S DIR("B")=DFLT
 S DIR("L",1)="Select one of the following:"
 S DIR("L",2)=""
 S DIR("L",3)="     1         Billed"
 S DIR("L",4)="     2         On Hold"
 S DIR("L",5)="     3         Cancelled"
 S DIR("L",6)="     4         Billed and On Hold"
 S DIR("L",7)="     5         ALL (Billed, On Hold, Cancelled)"
 D ^DIR
 I ($G(DUOUT)=1)!($G(DTOUT)=1) S Y="^"
 I Y="^" Q Y
 Q Y_U_Y(0)
 ;
 ;select the patient
PROMPTPT(RCSORT) ;
 N RCHRFSFL,RCLOOP,RCPTNM
 S RCLOOP=0
 ;keep prompting for patient name
 F  D  Q:RCLOOP
 . ;Prompt user for patient name
 . S RCPTNM=$$SELPAT(.RCSORT)
 . I +RCSORT'>0 S RCLOOP=1 Q
 . S RCHRFSFL=$$HRFSINFO^RCHRFSUT(RCSORT) ;check if this patient has HRfS flag at all
 . I RCHRFSFL<1 D  Q
 . . W !!,"  The Veteran does not have a HRfS flag on file."
 . . W !,"  Please enter another Veteran.",!!
 . S RCLOOP=1
 Q RCLOOP
 ;
 ;prompt for veteran's name
SELPAT(RCSORT) ;prompt for veteran's name
 ;- input vars for ^DIC call
 N DIC,DTOUT,DUOUT,X,Y
 S DIC="^DPT(",DIC(0)="AEMQZV"
 S DIC("A")="Enter Veteran Name: "
 S DIC("?PARAM",2,"INDEX")="B"
 ;- lookup patient
 D ^DIC K DIC
 ;- result of lookup
 S RCSORT=Y
 ;- if success, setup return array using output vars from ^DIC call
 I (+RCSORT>0) D  Q Y(0,0)  ;patient name
 . S RCSORT=+Y              ;patient ien
 . S RCSORT(0)=$G(Y(0))     ;zero node of patient in (#2) file
 Q -1
 ;
COLHEAD ;report column header
 W !
 W "Veteran Name"
 W ?26,"^SSN"
 W ?36,"^HRfS Active Date"
 W ?53,"^HRfS Inactive Date"
 W ?72,"^HRfS Active"
 W ?84,"^Bill Number"
 W ?96,"^Category"
 W ?123,"^Medical DOS"
 W ?135,"^Rx Fill Date"
 W ?148,"^Rx Release Date"
 W ?164,"^Rx Number"
 W ?177,"^Rx Name"
 W ?194,"^Charge"
 W ?206,"^Unit"
 W ?211,"^IB Status"
 W ?225,"^AR Status"
 W !
 W ""
 W ?26,"^"
 W ?36,"^"
 W ?53,"^"
 W ?72,"^On DOS"
 W ?84,"^"
 W ?96,"^"
 W ?123,"^"
 W ?135,"^"
 W ?148,"^"
 W ?164,"^"
 W ?177,"^"
 W ?194,"^Amount"
 W ?206,"^Day"
 W ?211,"^"
 W ?225,"^"
 Q
 ;
