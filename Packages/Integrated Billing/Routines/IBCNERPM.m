IBCNERPM ;AITC/VD - IBCNE eIV PAYER DOD REPORT ;22-JAN-2020
 ;;2.0;INTEGRATED BILLING;**664,668,737**;21-MAR-94;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; eIV - Insurance Verification Interface
 ; DOD - Date of Death
 ;
 ; Input parameters: N/A
 ; Other relevant variables ZTSAVED for queueing:
 ;  IBCNERTN = "IBCNERPM" (current routine name for queueing the 
 ;             GENERATE process)
 ;  IBCNESPC("BEGDT")=start dt for rpt
 ;  IBCNESPC("ENDDT")=end dt for rpt
 ;  IBCNESPC("PYR")=payer ien (365.12) or "" for all payers
 ;  IBCNESPC("SORT")=1 (Patient name) OR 2 (Payer name)
 ;  IBCNESPC("TYPE")=1 (Only Not Deceased Patients)
 ;                   2 (Only Deceased Patients)
 ;                   3 (Both Deceased and Not Deceased Patients)
 ;                   for the selected date range (by Payer)
 ;  IBOUT="R" for Report format or "E" for Excel format
 ;
 ; Only call this routine at a tag
 Q
 ;
EN ; Main entry point
 N IBCNERTN,IBCNESPC,IBOUT,POP,STOP
 S STOP=0
 S IBCNERTN="IBCNERPM"
 W @IOF
 W !,"eIV Payer Date of Death Report",!
 W !,"Electronic Insurance Verification responses are received daily."
 W !,"Please select a Date range in which Date of Death eIV responses were received"
 W !,"to determine the appropriate patient Date of Death information."
 ;
 ; Date Range Selection
R10 D DTRANGE I STOP G:$$STOP EXIT G R10
 ; Payer Selection
R20 D PYRSEL I STOP G:$$STOP EXIT G R10
 ; Type of Deceased Data Selection
R30 D TYPE I STOP G:$$STOP EXIT G R20
 ; Sort Selection
R40 D SORT I STOP G:$$STOP EXIT G R30
 ; Output Type Selection
R50 S (IBCNESPC("IBOUT"),IBOUT)=$$OUT I STOP G:$$STOP EXIT G R40
 I $G(IBCNESPC("IBOUT"))="E" W !!,"To avoid undesired wrapping, please enter '0;132;999' at the 'DEVICE:' prompt.",!
 ; Select output device
R100 D DEVICE(IBCNERTN,.IBCNESPC,IBOUT) I STOP Q:$G(IBOUT)="E"  G:$$STOP EXIT G R50
 G EXIT
 ;
EXIT ; Exit point
 Q
 ;
GENERATE(IBCNERTN,IBCNESPC,IBOUT) ; 
 ; Entry point called from EN^XUTMDEVQ in either direct or queued mode.
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;
 K ^TMP($J,IBCNERTN)
 D COMPILE(.IBCNESPC)        ; Compile the data
 I '$G(ZTSTOP) D OUTPUT(IBCNERTN,.IBCNESPC)     ; Print Output
 D ^%ZISC                   ; Close device
 ; Kill scratch globals
 K ^TMP($J,IBCNERTN),^TMP($J,IBCNERTN_"X")
 ; Purge task record
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
 ;
STOP() ; Determine if user wants to exit out of the whole option
 N DIR,X,Y,DIRUT
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit point
 Q Y
 ;
DTRANGE ; Determine start and end dates for date range param
 ; Initialize variables
 N X,Y,DIRUT
 W !!
 S DIR(0)="D^::EX"
 S DIR("A",1)="eIV RESPONSE RECEIVED DATE:"
 S DIR("A")="Earliest Date Received"
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?")="   would have been received. Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 I Y>DT W !!,?3,"Future dates are not allowed.  Please try again." G DTRANGE
 S IBCNESPC("BEGDT")=Y
 ; End date
DTRANG1 ;
 S DIR(0)="D^::EX",DIR("B")="Today"
 S DIR("A")="  Latest Date Received"
 S DIR("?",1)="   Please enter a valid date for which an eIV Response"
 S DIR("?",2)="   would have been received.  This date must not precede"
 S DIR("?")="   the Start Date.  Future dates are not allowed."
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G DTRANGX
 I Y>DT W !!,?3,"Future dates are not allowed.  Please try again." G DTRANG1
 I Y<IBCNESPC("BEGDT") W !!,?3,"Latest date must be greated than Earliest Date.  Please try again." G DTRANG1
 S IBCNESPC("ENDDT")=Y
 ;
DTRANGX ; DTRANGE exit point
 Q
 ;
PYRSEL ; Get Payer(s) selection.
 ;IB*737/TAZ - Removed reference to Most Popular Payer and "~NO PAYER"
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR("A")="Run for (A)ll Payers or (S)elected Payers: "
 S DIR("A",1)="PAYER SELECTION:"
 S DIR("?")="^"
 S DIR(0)="SA^A:All;S:Selected",DIR("B")="A"
 D ^DIR
 I $D(DIRUT) S STOP=1 Q
 ;
 I Y="A" S IBCNESPC("PYR")="A" Q  ; "All Payers" selected
 S DIC(0)="ABEQ"
 S DIC("A")="Select Payer(s): "
 ; Do not allow selection of non-eIV payers
 ;IB*668/TAZ - Changed IIV to EIV
 S DIC("S")="I $$PYRAPP^IBCNEUT5(""EIV"",$G(Y))'="""""
 S DIC="^IBE(365.12,"
PYRSEL1 ; Prompt for Payer Selection
 W !
 D ^DIC
 I $D(DUOUT)!$D(DTOUT)!(Y=-1) S STOP=1 K IBCNESPC("PYR") Q
 S IBCNESPC("PYR",$P(Y,U,1))=""
 I $$ANOTHER G PYRSEL1
 Q
 ;
TYPE ; Prompt to select to display All or Most Recent Responses for Patient/Payer combos
 N DIR,X,Y,DIRUT
 W !!,"DECEASED OR NOT DECEASED IN VISTA:"
 S DIR(0)="S^1:Patient is not deceased in VistA;2:Patient is deceased in VistA;3:Both"
 S DIR("A")="Select the type of patient to display"
 S DIR("B")=3
 S DIR("?")="^"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G TYPEX
 S IBCNESPC("TYPE")=Y
 ;
TYPEX ; TYPE exit point
 Q
 ;
SORT ; Prompt to allow users to sort the report by Patient(default) or Payer
 N DIR,X,Y,DIRUT
 W !
 S DIR(0)="S^1:Patient Name;2:Payer Name"
 S DIR("A")="  Select the primary sort field"
 S DIR("B")=1
 S DIR("?")="^"
 D ^DIR K DIR
 I $D(DIRUT) S STOP=1 G SORTX
 S IBCNESPC("SORT")=Y
 ;
SORTX ; SORT exit point
 Q
 ;
DEVICE(IBCNERTN,IBCNESPC,IBOUT) ; Device Handler and possible TaskManager calls
 ; Input params:
 ;  IBCNERTN = Routine name for ^TMP($J,...
 ;  IBCNESPC = Array passed by ref of the report params
 ;  IBOUT    = "R" for Report format or "E" for Excel format 
 ;
 ; Output params:
 ;  STOP = Flag to stop routine
 ;
 N POP,ZTDESC,ZTRTN,ZTSAVE
 W:$G(IBOUT)="R" !!!,"*** This report is 132 characters wide ***",!
 S ZTRTN="GENERATE^IBCNERPM("""_IBCNERTN_""",.IBCNESPC,"""_IBOUT_""")"
 S ZTDESC="eIV Payer Date of Death Report"
 S ZTSAVE("IBCNESPC(")=""
 S ZTSAVE("IBCNERTN")=""
 S ZTSAVE("IBOUT")=""
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I POP S STOP=1
 ;
DEVICEX ; DEVICE exit point
 Q
 ;
OUT() ; Prompt to allow users to select output format
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")="(E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 S DIR("?")="^"
 D ^DIR I $D(DIRUT) S STOP=1 Q ""
 Q Y
 ;
ANOTHER() ; "Select Another" prompt
 ; returns 1, if response was "YES", returns 0 otherwise
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 W !
 S DIR("A")="Select Another" S DIR(0)="Y",DIR("B")="NO"
 D ^DIR I $D(DIRUT) S STOP=1
 Q Y
 ;
COMPILE(IBCNESPC) ; Compile the data to be included on the report.
 N BEGDT,DOD365,DODEX,DODIN,ENDDT,IBDT,IBPAT,IBPTR,IBPYR,IBRIEN,IBTOT,IBTRNO
 N LSTDT,PATDOB,PATIEN,PATNAM,PATSSN,PATSSN4,PYR,PYRIEN,PYRNAM,SORT,SORT1,SORT2,TYPE
 S BEGDT=IBCNESPC("BEGDT")
 S ENDDT=IBCNESPC("ENDDT")
 S PYR=$G(IBCNESPC("PYR"))
 S SORT=IBCNESPC("SORT")
 S TYPE=IBCNESPC("TYPE")
 ;
 S IBDT=BEGDT-.000001    ; Initialize IBDT to start date
 S LSTDT=ENDDT+.999999   ; Initialize LSTDT to be the latest possible date for the end date.
 ; Loop thru the eIV Response File (#365) by Date/Time Response Rec X-Ref
 F  S IBDT=$O(^IBCN(365,"AD",IBDT)) Q:IBDT=""!(IBDT>LSTDT)  D  Q:$G(ZTSTOP)
 . S PYRIEN=""
 . F  S PYRIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN)) Q:PYRIEN=""  D  Q:$G(ZTSTOP)
 .. I PYR'="A",'$D(IBCNESPC("PYR",PYRIEN)) Q   ; Not a selected Payer.
 .. S PYRNAM=$$GET1^DIQ(365.12,PYRIEN,.01) Q:'$L(PYRNAM)    ; Get the Payer Name.
 .. S PATIEN=""
 .. F  S PATIEN=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN)) Q:PATIEN=""  D  Q:$G(ZTSTOP)
 ... S DODIN=$$GET1^DIQ(2,PATIEN_",",.351,"I")    ; Get Patient Internal DOD Date
 ... I TYPE="1",+DODIN Q    ; User selected "Not Deceased" and this patient has a Deceased Date.
 ... I TYPE="2",'+DODIN Q   ; User selected "Deceased" and this patient does not have a Deceased Date.
 ... S PATNAM=$$GET1^DIQ(2,PATIEN_",",.01)    ; Get Patient Name
 ... S DODEX=$$FMTE^XLFDT($$GET1^DIQ(2,PATIEN_",",.351,"I"),"5DZ")    ; Get Patient DOD Date in mm/dd/yyyy format
 ... S PATSSN=$$GET1^DIQ(2,PATIEN_",",.09),PATSSN4=$E(PATSSN,$L(PATSSN)-3,$L(PATSSN))   ; Get last 4 of SSN.
 ... S PATDOB=$$FMTE^XLFDT($$GET1^DIQ(2,PATIEN_",",.03,"I"),"5DZ")    ; Get Patient DOB Date in mm/dd/yyyy format.
 ... ; Set Sort Fields
 ... S SORT1=$S(SORT=1:PATNAM,1:PYRNAM)
 ... S SORT2=$S(SORT=1:PYRNAM,1:PATNAM)
 ... S IBPTR=""
 ... F  S IBPTR=$O(^IBCN(365,"AD",IBDT,PYRIEN,PATIEN,IBPTR)) Q:IBPTR=""  D
 .... S DOD365=$$FMTE^XLFDT($$GET1^DIQ(365,IBPTR_",",1.16,"I"),"5DZ")   ; Get the DOD for the Reponse Record in mm/dd/yyyy format.
 .... I DOD365="" Q   ; No DOD is being filed with this eIV Response entry.
 .... S IBTRNO=$$GET1^DIQ(365,IBPTR_",",.09)    ; Get the Trace #
 .... S ^TMP($J,IBCNERTN,SORT1,SORT2,IBTRNO)=PATNAM_U_PATSSN4_U_PATDOB_U_DODEX_U_PYRNAM_U_IBTRNO_U_DOD365
 Q
 ;
OUTPUT(IBCNERTN,INCNESPC) ; Generate the output of the report.
 N CRT,DASHES,DDATA,DEFSTAT,DLINE,EORMSG,HDR1,HDR2,IBOUT,IBPGC,IBPXT,LOUT,MAXCNT,NONEMSG
 N PATNAM,PYRNAM,RECVD,SENT,SPACES,SRT1,SRT2,SSN,SSNLEN,TRNO,TSTAMP,TYPE,VDATE,X,Y
 S (IBPGC,IBPXT)=0
 S NONEMSG="* * * N O  D A T A  F O U N D * * *"
 S EORMSG="*** END OF REPORT ***"
 S TSTAMP=$$FMTE^XLFDT($$NOW^XLFDT,1) ; time of report
 S IBOUT=$G(IBCNESPC("IBOUT"))  ; Output type
 S TYPE=$G(IBCNESPC("TYPE")) ; report type
 S $P(DASHES,"-",132)=""
 S $P(SPACES," ",40)=""
 S HDR1="Date Range: "_$$FMTE^XLFDT($G(IBCNESPC("BEGDT")),"5Z")_"-"_$$FMTE^XLFDT($G(IBCNESPC("ENDDT")),"5Z")_"       "
 S HDR1=HDR1_$S($G(IBCNESPC("PYR"))="A":"All Payers",1:"Selected Payers")
 S HDR1=HDR1_", Patients "_$S(TYPE="1":"Not ",TYPE="3":"Deceased and Not ",1:"")_"Deceased in VistA"
 S HDR2=""
 I IBOUT="E" S HDR2="Patient Name"_U_"Last 4 SSN"_U_"DOB VISTA"_U_"DOD VISTA"_U_"Payer Name"_U_"Trace #"_U_"DOD Payer"
 I IBOUT="R" S HDR2="Patient Name"_$E(SPACES,1,20)_"Last 4 SSN  DOB VISTA   DOD VISTA   Payer Name"_$E(SPACES,1,31)_"Trace #"_$E(SPACES,1,5)_"DOD Payer"
 ; Determine IO parameters
 S MAXCNT=IOSL-6,CRT=0
 S:IOST["C-" MAXCNT=IOSL-3,CRT=1
 ; print data
 S SRT1=""
 D HEADER I $G(ZTSTOP)!IBPXT Q
 ; If global does not exist - display No Data message
 I '$D(^TMP($J,IBCNERTN)) D LINE($$FO^IBCNEUT1(NONEMSG,$$CENTER(NONEMSG),"R")) G OUTPUTX
 I IBOUT="E" D  Q:$G(ZTSTOP)!IBPXT
 .; excel format
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D
 ...S TRNO=0 F  S TRNO=$O(^TMP($J,IBCNERTN,SRT1,SRT2,TRNO)) Q:TRNO=""  D
 ....S LOUT=^TMP($J,IBCNERTN,SRT1,SRT2,TRNO)
 ....D LINE(LOUT)
 ;
 I IBOUT="R" D  Q:$G(ZTSTOP)!IBPXT
 .; report format
 .F  S SRT1=$O(^TMP($J,IBCNERTN,SRT1)) Q:SRT1=""!$G(ZTSTOP)!IBPXT  D
 ..S SRT2="" F  S SRT2=$O(^TMP($J,IBCNERTN,SRT1,SRT2)) Q:SRT2=""!$G(ZTSTOP)!IBPXT  D 
 ...S TRNO=0 F  S TRNO=$O(^TMP($J,IBCNERTN,SRT1,SRT2,TRNO)) Q:TRNO=""  D PRINT
 ;
OUTPUTX ;
 W !
 D LINE($$FO^IBCNEUT1(EORMSG,$$CENTER(EORMSG),"R"))
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL
 Q
 ;
PRINT ; Get Print Info
 ; "Patient Name",?34,"Last 4 SSN",?44,"DOB VISTA",?56,"DOD VISTA",?68,"Payer Name",?100,"Trace #",?122,"DOD Payer"
 S DDATA=$G(^TMP($J,IBCNERTN,SRT1,SRT2,TRNO)),DLINE=""
 S $E(DLINE,1,30)=$E($P(DDATA,U),1,30)  ;PATIENT NAME
 S $E(DLINE,36,39)=$P(DDATA,U,2)  ;LAST 4 OF SSN
 S $E(DLINE,45,54)=$P(DDATA,U,3)  ;DATE OF BIRTH VISTA
 S $E(DLINE,57,66)=$P(DDATA,U,4)  ;DATE OF DEATH VISTA
 S $E(DLINE,69,108)=$E($P(DDATA,U,5),1,40)  ;PAYER NAME
 S $E(DLINE,110,119)=$P(DDATA,U,6)  ;TRACE #
 S $E(DLINE,122,131)=$P(DDATA,U,7)  ;DATE OF DEATH PAYER
 D LINE(DLINE)
 Q
 ;
EOL ; display "end of page" message and set exit flag
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,LIN
 I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 S DIR(0)="E" D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) S IBPXT=1
 Q
 ;
HEADER ; print header for each page
 N HDR,OFFSET,SRT
 ;
 I CRT,IBPGC>0,'$D(ZTQUEUED) D EOL I IBPXT Q
 I $D(ZTQUEUED),$$S^%ZTLOAD() S (ZTSTOP,IBPXT)=1 Q
 S IBPGC=IBPGC+1
 W @IOF,!,"eIV Payer Date of Death Report"
 S HDR=TSTAMP_$S(IBOUT="R":"  Page: "_IBPGC,1:""),OFFSET=(132-($L(HDR)+1))
 W ?OFFSET,HDR
 W !,HDR1,!!,HDR2
 I IBOUT'="E" W !,DASHES
 Q
 ;
LINE(LINE) ; Print line of data
 I $Y+1>MAXCNT D HEADER I $G(ZTSTOP)!IBPXT Q
 W !,LINE
 Q
 ;
CENTER(LINE) ; return length of a centered line
 ; LINE - line to center
 N LENGTH,OFFSET
 S LENGTH=$L(LINE),OFFSET=132-$L(LINE)\2
 Q OFFSET+LENGTH
 ;
