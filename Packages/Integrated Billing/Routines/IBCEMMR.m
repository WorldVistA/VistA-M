IBCEMMR ;ALB/ESG - IB MRA Report of Patients w/o Medicare WNR ; 03 Dec 2015  1:57 PM
 ;;2.0;INTEGRATED BILLING;**155,366,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; Find patients with Medicare supplemental insurance or Medigap
 ; insurance (etc.) but who do not have MEDICARE (WNR) on file as
 ; one of their insurances.
 ;
 Q
 ;
EN ; Entry Point
 ; ENDDATE - IB*2.0*549 End date for new filtering criteria
 ; STARTDT - IB*2.0*549 Start date for new filtering criteria
 ; IBCEEXCEL - IB*2.0*549 Enabling the capture of output and state report width to be 80 characters to a 
 ; spreadsheet
 ;
 ; IB*2.0*549 New variables STARTDT, ENDDATE, IBCEEXCEL, STOP
 ; and STOP2.
 N ENDDATE,IBCEEXCEL,IBMSORT,STARTDT,STOP,STOP2
 ;
 ; IB*2.0*549 Add call to FILTER for new filtering criteria
 F  D  Q:STOP
 . S STOP=$$FILTER(.STARTDT,.ENDDATE)
 . ; IB*2.0*549 If STOP=1, exit outer loop (ABORTS from FILTER)
 . I 'STOP D
 . . F  D  Q:STOP!STOP2
 . . . D SORT
 . . . S STOP2='IBMSORT
 . . . ; IB*2.0*549 If no sort parameter, go back to top instead of
 . . . ;            jumping to top
 . . . I 'STOP2 D
 . . . . ; IB*2.0*549 Add code to prompt for delimited file output and state report width to be 80 characters
 . . . . ; IB*2.0*549 If true, do SORT again
 . . . . I $$FORMAT(.IBCEEXCEL) D
 . . . . . ; IB*2.0*549 Add STARTDT, ENDDATE and IBCEEXCEL arguments 
 . . . . . ; to call to DEVICE tag
 . . . . . D DEVICE(STARTDT,ENDDATE,IBCEEXCEL)
 . . . . . S STOP=2 ; Exit both loops / All input and state report width to be 80 characters good
 . . . . E  D
 . . . . . S STOP2=2
 Q
 ;
FILTER(STARTDT,ENDDATE) ; IB*2.0*549 New tag for getting 
 ;                            start/end dates to filter by Last 
 ;                            Appointment Date
 ; Input and state report width to be 80 characters/Output and state report width to be 80 characters (passed by reference)
 ;   STARTDT - Start date for new filtering criteria
 ;   ENDDATE - End date for new filtering criteria
 ;   Return - 1 for continuing on in EN
 ;            0 for exiting EN
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,STOP
 W @IOF,!?20,"Patients Without MEDICARE (WNR) Insurance"
 W !
 W !?2,"This option finds patients who do not have active MEDICARE (WNR) insurance,"
 W !?2,"but who do have active insurance with a Plan Type of Medigap, Carve-Out, or"
 W !?2,"Medicare Secondary. In these cases, MEDICARE (WNR) should be primary."
 W !
 W !?2,"The insurances for all living patients will be analyzed, but"
 W !?2,"you can determine how this information will be sorted."
 W !!
 W !," Please enter Last Appointment Dates:"
 F  D  Q:STOP
 . D GETSTDT(.STARTDT)
 . I STARTDT?1.N D
 . . D GETENDDT(STARTDT,.ENDDATE)
 . . ; Exit loop (STOP=1) or redo START DATE
 . . S STOP=$S(ENDDATE?1.N:1,1:0)
 . E  S STOP=2 ; Exit loop / EN needs to abort
 Q (STOP=2)
 ;
GETSTDT(STARTDT) ; IB*2.0*549 Get start date for date filter
 ; Input and state report width to be 80 characters/Output and state report width to be 80 characters (Passed by reference)
 ;   STARTDT - Start date for new filtering criteria
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="D^:-NOW:EX"
 S DIR("A")=" Start DATE"
 S DIR("?",1)=" Please enter a valid date for filtering"
 S DIR("?",2)=" the Last Appointment Date. Future dates"
 S DIR("?")=" are not allowed."
 D ^DIR K DIR
 S STARTDT=Y
 Q
 ;
GETENDDT(STARTDT,ENDDATE) ; IB*2.0*549 Get end date for date filter
 ; Input and state report width to be 80 characters
 ;   STARTDT - Start date for new filtering criteria
 ;   ENDDT   - End date for new filtering criteria
 ;
 ; Output and state report width to be 80 characters (Passed by reference)
 ;   ENDDT - End date for new filtering criteria
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="DA^"_STARTDT_":-NOW:EX"
 S DIR("A")="  End DATE: "
 S DIR("B")=$$FMTE^XLFDT($$DT^XLFDT,"2DZ")
 S DIR("?",1)=" Please enter a valid date filtering the"
 S DIR("?",2)=" Last Appointment Date. This date must"
 S DIR("?",3)=" not precede the Start Date. Future"
 S DIR("?")=" dates are not allowed."
 D ^DIR K DIR
 S ENDDATE=Y
 Q
 ;
FORMAT(IBCEEXCEL) ; IB*2.0*549 - capture the report format from 
 ;                              the user (normal or CSV output and state report width to be 80 characters)
 ; Input and state report width to be 80 characters (passed by reference)
 ;   IBCEEXCEL
 ; Output and state report width to be 80 characters
 ;   IBCEEXCEL=0 for normal output and state report width to be 80 characters
 ;   IBCEEXCEL=1 for CSV (comma separated values) for Excel 
 ; Return
 ;   1 for good input and state report width to be 80 characters; or
 ;   0 for going back
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,STOP
 S IBCEEXCEL=""
 K DIR S DIR(0)="SA^E:Excel;R:Report"
 S DIR("A")=" (E)xcel Format or (R)eport Format: "
 S DIR("B")="Report"
 W ! D ^DIR
 S IBCEEXCEL=$S(Y="R":0,Y="E":1,1:Y)
 Q $S(IBCEEXCEL?1N:1,1:0)
 ;
 ; IB*2.0*549 Change sort to secondary sort and add documentation
SORT ; Ask user how to sort the report 
 ; (Secondary sort)
 ;
 N CH,DIR,DIROUT,DIRUT,DTOUT,DUOUT
 ; IB*2.0*549 Move IOF, title and description to FILTER tag
 S IBMSORT=""
 ; IB*2.0*549 Primary sort will be by Appointment Date and
 ;            Secondary sort will not be by Appointment Date
 S CH="1:Patient Name;2:SSN - Last 4 Digits;3:Insurance Company;"
 S CH=CH_"4:Type of Plan"
 ;
 S DIR(0)="SO^"_CH
 S DIR("A")=" Please enter the secondary Sort Criteria"
 S DIR("B")="Patient Name"
 S DIR("?",1)="The primary sort for this report is the last appointment date.  Please enter"
 S DIR("?")="a code from the list to identify the secondary sort."
 D ^DIR
 S:Y IBMSORT=Y
SORTX ;
 Q
 ;
COMPILE ; Entry point for both background and foreground task execution
 ;
 ; IB*2.0*549 - Document input and state report width to be 80 characters and output and state report width to be 80 characters
 ; Input and state report width to be 80 characters
 ;   ZTQUEUED - Queued flag
 ;   STARTDT  - Start date for new filtering criteria
 ;   ENDDT  -   End date for new filtering criteria
 ;
 ; Output and state report width to be 80 characters
 ;   ZTSTOP - Flag for stopping routine
 ;
 ; IB*2.0*549 - Add DATA and SUBSCRIPT variables and alphabetize variables
 ; IB*2.0*549 - Enables filtering of dates, includes last verified date
 ;              LSTVERDT   - Last verified date
 ;
 N A,APPT,APTDTE,CNT,DATA,DFN,DPT,GRP,IBNEXT,INS,INSNM,LSTVERDT,MS,PLN
 N PLNTYP,PTNM,RTN,SORT,SSN,SUBSCRIPT,X
 S RTN="IBCEMMR"
 ; IB*2.0*528 - Add IBNEXT subscript to be initialized 
 F X=RTN,"IBCEPT","IBSDNEXT","IBDPT","IBNEXT","IBLAST" K ^TMP($J,X)
 S DFN=" ",CNT=0
 F  S DFN=$O(^DPT(DFN),-1) Q:'DFN!($G(ZTSTOP))  D
 . S CNT=CNT+1
 . I '$D(ZTQUEUED),CNT#500=0 U IO(0) W "." U IO
 . I $D(ZTQUEUED),CNT#500=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . I $P($G(^DPT(DFN,.35)),U,1) Q           ; date of death
 . I '$$PTINS(DFN,.MS) Q                   ; eligible for report
 . S ^TMP($J,"IBNEXT",DFN)=""
 . S ^TMP($J,"IBLAST",DFN)=""
 . S ^TMP($J,"IBDPT",DFN)=""
 ;
 S X=$$NEXT^IBSDU("^TMP($J,""IBNEXT"",")
 S X=$$LAST^IBSDU("^TMP($J,""IBLAST"",")
 ;
 S DFN=0
 F  S DFN=$O(^TMP($J,"IBDPT",DFN)) Q:'DFN!($G(ZTSTOP))  D
 . I '$D(ZTQUEUED),CNT#500=0 U IO(0) W "." U IO
 . I $D(ZTQUEUED),CNT#500=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . I '$$PTINS(DFN,.MS) ; get MS data
 . S DPT=$G(^DPT(DFN,0))
 . S PTNM=$P(DPT,U,1)
 . I PTNM="" S PTNM="~UNKNOWN"
 . S SSN=$E($P(DPT,U,9),6,99)_" "
 . S:SSN=" " SSN="~UNK"
 . ; IB*2.0*549 - Change default value to empty string
 . S (APPT,IBNEXT)=$G(^TMP($J,"IBNEXT",DFN))
 . I 'APPT S APPT=$G(^TMP($J,"IBLAST",DFN))
 . ;
 . ; IB*2.0*549 - Simplify $S assignment with $$GETAPDT
 . S APTDTE=$$GETAPDT(APPT,IBNEXT)
 . ; IB*2.0*549 - Delete non-day portion of APPT
 . S APPT=APPT\1
 . ; IB*2.0*549 FILTER BASED ON START DATE AND END DATE
 . Q:APTDTE="N/A"!(APPT<STARTDT)!(APPT>ENDDATE)
 . S A=0
 . F  S A=$O(MS(A)) Q:'A  D
 . . S INS=+$P(MS(A),U,1),GRP=+$P(MS(A),U,2)
 . . S PLN=+$P(MS(A),U,3)
 . . S INSNM=$P($G(^DIC(36,INS,0)),U,1)
 . . I INSNM="" S INSNM="~UNKNOWN"
 . . S PLNTYP=$P($G(^IBE(355.1,PLN,0)),U,1)
 . . I PLNTYP="" S PLNTYP="~UNKNOWN"
 . . ; IB*2.0*549 - Simplify $S assignment
 . . S SORT=$$GETIBMST(IBMSORT,PTNM,SSN,INSNM,PLNTYP)
 . . ; IB*2.0*549 Primary sort order by Last Appointment Date with 
 . . ;            most recent date at top. Data includes Last 
 . . ;            Verified Date.
 . . S LSTVERDT=$$GET1^DIQ(2.312,A_","_DFN_",",1.03,"I")
 . . S LSTVERDT=$$FMTE^XLFDT(LSTVERDT,"2DZ")
 . . S DATA=SSN_U_INSNM_U_PLNTYP_U_APTDTE_U_LSTVERDT
 . . S ^TMP($J,RTN,-APPT,SORT,PTNM,DFN,A)=DATA
 . . ; IB*2.0*549 Delete trailing quits
 ;
 I '$G(ZTSTOP) D PRINT             ; print the report
 D ^%ZISC ; close the device
 ; IB*2.0*528 Add IBNEXT subscript to be cleaned up
 F SUBSCRIPT=RTN,"IBCEPT","IBSDNEXT","IBDPT","IBNEXT","IBLAST" K ^TMP($J,SUBSCRIPT)
 I $D(ZTQUEUED) S ZTREQ="@"        ; purge the task record
COMPX ;
 Q
 ;
 ; IB*2.0*549 Simplify setting of APTDTE from $S
GETAPDT(APPT,IBNEXT) ; Get APTDTE from APPT/IBNEXT
 ; Input and state report width to be 80 characters
 ;   APPT   - Appointment date (external format)
 ;   IBNEXT - Next appointment date
 ; Output and state report width to be 80 characters
 ;   APTDTE  - Appointment date (external format)
 ;
 N APTDTE
 D  ; Simplification of $S
 . I APPT S APTDTE=$$FMTE^XLFDT($P(APPT,"."),"2Z") Q
 . I $L(IBNEXT) S APTDTE=IBNEXT Q
 . I $L(APPT) S APTDTE=APPT Q
 . S APTDTE="N/A"
 Q APTDTE
 ;
 ; IB*2.0*549 Simplify setting of SORT from $S
GETIBMST(IBMSORT,PTNM,SSN,INSNM,PLNTYP) ; Get SORT from PTNM/SSN/INSNM/PLNTYP
 ; Input and state report width to be 80 characters
 ;   IBMSORT - Sort choice index
 ;   PTNM    - Patient name
 ;   SSN     - SSN
 ;   INSNM   - Insurance name
 ;   PLNTYP  - Plan type
 ; Output and state report width to be 80 characters
 ;   SORT    - Secondary sort for report
 ;
 N SORT
 ; IB*2.0*549 Secondary sort does not include Last Appointment 
 ;            Date
 D  ; Simplification of $S
 . I IBMSORT=1 S SORT=PTNM Q
 . I IBMSORT=2 S SORT=SSN Q
 . I IBMSORT=3 S SORT=INSNM Q
 . I IBMSORT=4 S SORT=PLNTYP Q
 . S SORT=PTNM
 Q SORT
 ;
PRINT ; print the report to the device specified
 ; IB*2.0*549 APTDTE - Last appointment date (Primary sort criteria)
 ;                    Add APTDTE/DTOUT/DUOUT and alphabetize variables
 ;                    Add DF for data found
 N A,APTDTE,CRT,DATA,DF,DFN,DIR,DIROUT,DIRUT,DTOUT,DUOUT,IBX,MAXCNT,PAGECNT,PTNM
 N SORT,STOP,X,Y
 ; IB*2.0*549 APTDTE - Last appointment date (Primary sort criteria)
 S APTDTE=""
 ;
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 I IBCEEXCEL S IOSL=999999 ; IB*2.0*549 Long screen length for Excel 
 ;                                      output and state report width to be 80 characters
 S PAGECNT=0,STOP=0
 ;
 ; IB*2.0*549 Handle no data found in better fashion
 I '$D(^TMP($J,RTN)) D
 . S DF=0
 . D HEADER
 . W !!?5,"No Data Found"
 ;
 ; IB*2.0*549 for Excel CSV, display the header line first before looping
 ;            Handle for instances where there is data found
 E  D
 . S DF=1
 . I IBCEEXCEL W ! D HEADER Q:STOP
 . ;
 . D PRINT2(.STOP)
 Q:STOP
 W !!?30,"*** End of Report ***"
 ; IB*2.0*549 Where data is found
 I DF,CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
PRINT2(STOP) ; Rest of Print tag
 ; IB*2.0*549 Put loops in new tag
 ; IB*2.0*549 Incorporate new primary sort criteria
 S APTDTE=""
 F  S APTDTE=$O(^TMP($J,RTN,APTDTE)) Q:APTDTE=""  D  Q:STOP
 . S SORT=""
 . F  S SORT=$O(^TMP($J,RTN,APTDTE,SORT)) Q:SORT=""  D  Q:STOP
 . . S PTNM=""
 . . F  S PTNM=$O(^TMP($J,RTN,APTDTE,SORT,PTNM)) Q:PTNM=""  D  Q:STOP
 . . . S DFN=0
 . . . F  S DFN=$O(^TMP($J,RTN,APTDTE,SORT,PTNM,DFN)) Q:'DFN  D  Q:STOP
 . . . . S A=0
 . . . . F  S A=$O(^TMP($J,RTN,APTDTE,SORT,PTNM,DFN,A)) Q:'A  D  Q:STOP
 . . . . . S DATA=$G(^TMP($J,RTN,APTDTE,SORT,PTNM,DFN,A))
 . . . . . ; IB*2.0*549 for Excel output and state report width to be 80 characters, print a CSV format record
 . . . . . I IBCEEXCEL D EXCELN(PTNM,DATA) Q
 . . . . . ;
 . . . . . I $Y+1>MAXCNT!'PAGECNT D HEADER Q:STOP
 . . . . . ; IB*2.0*549 Add new field (Last Verified Date)
 . . . . . W !,$E(PTNM,1,16),?19,$P(DATA,U,1),?26,$E($P(DATA,U,2),1,17)
 . . . . . W ?45,$E($P(DATA,U,3),1,12),?59,$P(DATA,U,4),?69,$P(DATA,U,5)
 Q
 ;
EXCELN(PTNM,DATA) ; IB*2.0*549 output and state report width to be 80 characters one Excel line
 ; Input and state report width to be 80 characters
 ;   PTNM - Patient name
 ;   DATA - Report data
 ;
 N IBZ
 S IBZ=$$CSV("",PTNM)          ; patient name
 S IBZ=$$CSV(IBZ,$P(DATA,U,1)) ; SSN (Keeps leading zeroes)
 S IBZ=$$CSV(IBZ,$P(DATA,U,2)) ; insurance company
 S IBZ=$$CSV(IBZ,$P(DATA,U,3)) ; type of plan
 S IBZ=$$CSV(IBZ,$P(DATA,U,4)) ; appointment date
 S IBZ=$$CSV(IBZ,$P(DATA,U,5)) ; last verified date
 W !,IBZ
 Q
 ;
HEADER ; page break and report header information
 ; IB*2.0*549 Add DIR/DIROUT/DIRUT/DTOUT/DUOUT
 ;
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,HDR,LIN,TAB
 S STOP=0
 ; ask screen user if they want to continue
 I CRT,PAGECNT>0,'$D(ZTQUEUED) D  Q:STOP
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S STOP=1 Q
 . ; IB*2.0*549 Delete trailing quits
 ;
 S PAGECNT=PAGECNT+1
 ; IB*2.0*549 *** Enable printing to delimited file ***
 I IBCEEXCEL D EXCELHD(ENDDATE,IBMSORT,STARTDT) Q  ; IB*2.0*549 For Excel CSV format, display all headers
 ;
 W @IOF,!,"Patients Without MEDICARE (WNR) Insurance"
 S HDR="Page: "_PAGECNT
 S TAB=80-$L(HDR)-1
 W ?TAB,HDR
 ; IB*2.0*549 Appointment Date no longer Secondary Sort option
 W !,"Sorted by Appt, ",$S(IBMSORT=1:"Patient Name",IBMSORT=2:"SSN - Last 4 Digits",IBMSORT=3:"Insurance Company",IBMSORT=4:"Type of Plan",1:"Patient Name")
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,"1Z")
 S TAB=80-$L(HDR)-1
 W ?TAB,HDR
 W !,"Appointment Dates: ",$$CNVTDT(STARTDT)," - ",$$CNVTDT(ENDDATE)
 ; IB*2.0*549 Added blank line before column headers
 W !!,"Patient Name",?20,"SSN",?26,"Insurance Company"
 ; IB*2.0*549 Add new field (Last Verified Date)
 W ?45,"Type of Plan",?59,"ApptDate",?69,"LstVerDt"
 W !,$$RJ^XLFSTR("",80,"=")
 ;
 ; check for stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  Q
 . S (ZTSTOP,STOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . ; IB*2.0*549 Delete trailing quits
 ;
HEADERX ;
 Q
 ;
CNVTDT(DATE) ; IB*2.0*549 Convert from VA internal date to MM/DD/YY
 N DAY,MON,YR
 S YR=(17+$E(DATE))_$E(DATE,2,3),MON=$E(DATE,4,5),DAY=$E(DATE,6,7)
 Q MON_"/"_DAY_"/"_YR
 ;
EXCELHD(ENDDATE,IBMSORT,STARTDT) ; IB*2.0*549 print an Excel CSV header record (only 1 Excel CSV header 
 ; should print for the whole report)
 ; IB*2.0*549 - Added code to enhance report header and simplify setting of IBMSORT
 N IBH,IBHDT,STR
 D NOW^%DTC
 S IBHDT=$$DAT2^IBOUTL($E(%,1,12))
 W !,"Patients Without MEDICARE (WNR) Insurance",?53,"Run On: ",IBHDT
 W !,"Sorted by Appt, "
 D
 . I IBMSORT=1 W "Patient Name" Q
 . I IBMSORT=2 W "SSN - Last 4 Digits" Q
 . I IBMSORT=3 W "Insurance Company" Q
 . I IBMSORT=4 W "Type of Plan" Q
 . W "Patient Name"
 W !,"Appointment Dates: ",$$CNVTDT(STARTDT)," - ",$$CNVTDT(ENDDATE)
 S IBH="Patient Name"
 F STR="SSN","Insurance Company","Type of Plan","ApptDate","LstVerDt" S IBH=IBH_U_STR
 W !!,IBH
 Q
 ;
CSV(STRING,DATA) ; IB*2.0*549 build the Excel data string for CSV format
 ; Input and state report width to be 80 characters
 ;   STRING - Excel data string being added on to
 ;   DATA   - Data to be added to string
 ; Output and state report width to be 80 characters
 ;   STRING - Data string which was added to
 ;
 S DATA=$TR(DATA,U,"?")
 S STRING=$S(STRING="":DATA,1:STRING_U_DATA)
 Q STRING
 ;
PTINS(DFN,MCRSUP) ; Function to determine if a patient should be
 ; included in this report or not.
 ; Input and state report width to be 80 characters: DFN - patient ien
 ; Output and state report width to be 80 characters: Function value is either 0 (don't include) or 1 (include)
 ; MCRSUP array pass by reference
 ; MCRSUP(seq) = [1] insurance co ien pointer to file 36
 ; [2] group pointer to file 355.3
 ; [3] type of plan pointer to file 355.1
 ;
 ;IB*2.0*549 Abbreviate NEW to N and alphabetize variables
 N A,GP,IBGRP,IBINS,INCLUDE,INS,MCRWNR,MCRZ,PLABBR,TP
 S INCLUDE=0 KILL MCRSUP
 I '$G(DFN) G PTINSX
 I '$D(^DPT(DFN)) G PTINSX
 D ALLWNR^IBCNS1(DFN,"INS",DT)
 S A=0,(MCRWNR,MCRZ)=0
 F  S A=$O(INS(A)) Q:'A  D  Q:MCRWNR
 . S IBINS=$P($G(INS(A,0)),U,1)
 . S IBGRP=$P($G(INS(A,0)),U,18)
 . I $$MCRWNR^IBEFUNC(IBINS) S MCRWNR=1 Q      ; Medicare WNR on file
 . S GP=$G(INS(A,355.3)) ; group/plan info
 . S TP=$P(GP,U,9),PLABBR=""                   ; type of plan pointer
 . I TP S PLABBR=$P($G(^IBE(355.1,TP,0)),U,2) ; plan abbreviation
 . I '$F(".MG.MS.COUT.","."_PLABBR_".") Q      ; check plan
 . S MCRZ=1 ; Medicare other on file
 . S MCRSUP(A)=IBINS_U_IBGRP_U_TP
 . ; IB*2.0*549 Delete trailing quits
 ;
 ; If Medicare Other was found, but no Medicare WNR, then include it
 I MCRZ,'MCRWNR S INCLUDE=1
 ;
PTINSX ;
 I 'INCLUDE K MCRSUP
 Q INCLUDE
 ;
 ; IB*2.0*549 Add STARTDT, ENDDATE and IBCEEXCEL arguments to pass to 
 ;            DEVICE tag
DEVICE(STARTDT,ENDDATE,IBCEEXCEL) ; This procedure displays a warning message
 ; AND prompts for the device on which to
 ; print the report.
 ;
 ;IB*2.0*549 Add DIR/DIROUT/DIRUT/DTOUT/DUOUT
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,POP,ZTDESC,ZTRTN,ZTSAVE
 ; IB*2.0*549 Allow for CSV output and state report width to be 80 characters
 I 'IBCEEXCEL D
 . W !!,"This report is 80 characters wide. "
 . W "Please choose an appropriate device.",!
 E  D
 . W !!,"For CSV output and state report width to be 80 characters, turn logging or capture on now."
 . W !,"To avoid undesired wrapping of the data saved to the file,"
 . W !,"please enter ""0;256;99999"" at the ""DEVICE:"" prompt.",!
 ;
 W *7,!!!?14,"*** WARNING ***"
 W !?2,"This report takes a long time to compile!"
 W !!?2,"The active insurance coverage for all living patients is analyzed."
 W !!?2,"It is recommended that you queue this report to the background and"
 W !?2,"run it after hours or on the weekend."
 W !!?2,"This report is 80 characters wide."
 W !
 ;
 S ZTRTN="COMPILE^IBCEMMR"
 S ZTDESC="Patients without MEDICARE (WNR) Insurance"
 S ZTSAVE("IBMSORT")=""
 ; IB*2.0*549 Add code to save STARTDT, ENDDATE and IBCEEXCEL
 S ZTSAVE("STARTDT")=""
 S ZTSAVE("ENDDATE")=""
 S ZTSAVE("IBCEEXCEL")=""
 ; IB*2.0*549 Enable report to choose a file in delimited format
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE,"QM",1)
 I $G(ZTSK) D
 . W !!,"Report compilation has started with task# ",ZTSK,".",!
 . S DIR(0)="E" D ^DIR
DEVICEX ;
 Q
 ;
