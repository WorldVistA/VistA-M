IBCEMMR ;ALB/ESG - IB MRA Report of Patients w/o Medicare WNR ;20-NOV-2003
 ;;2.0;INTEGRATED BILLING;**155,366**;21-MAR-94;Build 3
 ;
 ; Find patients with Medicare supplemental insurance or Medigap
 ; insurance (etc.) but who do not have MEDICARE (WNR) on file as
 ; one of their insurances.
 ;
 Q
 ;
EN ; Entry Point
 NEW IBMSORT
 D SORT I 'IBMSORT G EX
 D DEVICE
EX ; Exit Point
 Q
 ;
SORT ; Ask user how to sort the report
 NEW CH,DIR,X,Y,DIRUT,DIROUT
 W @IOF,!?20,"Patients Without MEDICARE (WNR) Insurance"
 W !!?2,"This option finds patients who do not have active MEDICARE (WNR) insurance,"
 W !?2,"but who do have active insurance with a Plan Type of Medigap, Carve-Out, or"
 W !?2,"Medicare Secondary.  In these cases, MEDICARE (WNR) should be primary."
 W !!?2,"The insurances for all living patients will be analyzed, but"
 W !?2,"you can determine how this information will be sorted."
 S IBMSORT=""
 W !
 S CH="1:Patient Name;2:SSN - Last 4 Digits;3:Insurance Company;"
 S CH=CH_"4:Type of Plan;5:Appointment Date"
 S DIR(0)="SO^"_CH
 S DIR("A")="Please enter the Sort Criteria"
 S DIR("B")="Patient Name"
 D ^DIR K DIR
 I 'Y G SORTX
 S IBMSORT=Y
SORTX ;
 Q
 ;
COMPILE ; Entry point for both background and foreground task execution
 ;
 NEW RTN,DFN,CNT,MS,DPT,PTNM,SSN,APPT,APDTE,A
 NEW INS,GRP,PLN,INSNM,PLNTYP,SORT,X,IBNEXT
 S RTN="IBCEMMR"
 K ^TMP($J,RTN),^("IBCEPT"),^("IBSDNEXT"),^("IBDPT"),^("IBLAST")
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
 S DFN=0 F  S DFN=$O(^TMP($J,"IBDPT",DFN)) Q:'DFN!($G(ZTSTOP))  D
 . I '$D(ZTQUEUED),CNT#500=0 U IO(0) W "." U IO
 . I $D(ZTQUEUED),CNT#500=0,$$S^%ZTLOAD() S ZTSTOP=1 Q
 . I '$$PTINS(DFN,.MS)  ; get MS data
 . S DPT=$G(^DPT(DFN,0))
 . S PTNM=$P(DPT,U,1)
 . I PTNM="" S PTNM="~UNKNOWN"
 . S SSN=$E($P(DPT,U,9),6,99)_" "
 . I SSN="" S SSN="~UNK"
 . S (APPT,IBNEXT)=$G(^TMP($J,"IBNEXT",DFN),"UNKNOWN")
 . I 'APPT S APPT=$G(^TMP($J,"IBLAST",DFN),"UNKNOWN")
 . S APDTE=$S(APPT:$$FMTE^XLFDT($P(APPT,"."),"2Z"),$L(IBNEXT):IBNEXT,$L(APPT):APPT,1:"N/A")
 . S APPT=+APPT
 . S A=0 F  S A=$O(MS(A)) Q:'A  D
 .. S INS=+$P(MS(A),U,1),GRP=+$P(MS(A),U,2)
 .. S PLN=+$P(MS(A),U,3)
 .. S INSNM=$P($G(^DIC(36,INS,0)),U,1)
 .. I INSNM="" S INSNM="~UNKNOWN"
 .. S PLNTYP=$P($G(^IBE(355.1,PLN,0)),U,1)
 .. I PLNTYP="" S PLNTYP="~UNKNOWN"
 .. S SORT=$S(IBMSORT=1:PTNM,IBMSORT=2:SSN,IBMSORT=3:INSNM,IBMSORT=4:PLNTYP,IBMSORT=5:-APPT,1:PTNM)
 .. S ^TMP($J,RTN,SORT,PTNM,DFN,A)=SSN_U_INSNM_U_PLNTYP_U_APDTE
 .. Q
 . Q
 ;
 I '$G(ZTSTOP) D PRINT             ; print the report
 D ^%ZISC                          ; close the device
 K ^TMP($J,RTN),^("IBCEPT"),^("IBSDNEXT"),^("IBDPT"),^("IBLAST") ;cleanup
 I $D(ZTQUEUED) S ZTREQ="@"        ; purge the task record
COMPX ;
 Q
 ;
PRINT ; print the report to the device specified
 N MAXCNT,CRT,PAGECNT,STOP,SORT,PTNM,DFN,A,DATA,DIR,X,Y,DIRUT,DIROUT,IBX
 I IOST["C-" S MAXCNT=IOSL-3,CRT=1
 E  S MAXCNT=IOSL-6,CRT=0
 S PAGECNT=0,STOP=0
 ;
 ; Check for no data
 I '$D(^TMP($J,RTN)) D HEADER W !!?5,"No Data Found"
 ;
 S SORT=""
 F  S SORT=$O(^TMP($J,RTN,SORT)) Q:SORT=""  D  Q:STOP
 . S PTNM=""
 . F  S PTNM=$O(^TMP($J,RTN,SORT,PTNM)) Q:PTNM=""  D  Q:STOP
 .. S DFN=0
 .. F  S DFN=$O(^TMP($J,RTN,SORT,PTNM,DFN)) Q:'DFN  D  Q:STOP
 ... S A=0
 ... F  S A=$O(^TMP($J,RTN,SORT,PTNM,DFN,A)) Q:'A  D  Q:STOP
 .... S DATA=$G(^TMP($J,RTN,SORT,PTNM,DFN,A))
 .... I $Y+1>MAXCNT!'PAGECNT D HEADER Q:STOP
 .... W !,$E(PTNM,1,20),?23,$P(DATA,U,1),?30,$E($P(DATA,U,2),1,20)
 .... W ?53,$E($P(DATA,U,3),1,13),?69,$P(DATA,U,4)
 .... Q
 ... Q
 .. Q
 . Q
 ;
 I STOP G PRINTX
 W !!?30,"*** End of Report ***"
 I CRT,'$D(ZTQUEUED) S DIR(0)="E" D ^DIR K DIR
PRINTX ;
 Q
 ;
HEADER ; page break and report header information
 NEW LIN,HDR,TAB
 S STOP=0
 ; ask screen user if they want to continue
 I CRT,PAGECNT>0,'$D(ZTQUEUED) D  I STOP G HEADERX
 . I MAXCNT<51 F LIN=1:1:(MAXCNT-$Y) W !
 . S DIR(0)="E" D ^DIR K DIR
 . I 'Y S STOP=1 Q
 . Q
 ;
 S PAGECNT=PAGECNT+1
 W @IOF,!,"Patients Without MEDICARE (WNR) Insurance"
 S HDR="Page: "_PAGECNT
 S TAB=80-$L(HDR)-1
 W ?TAB,HDR
 W !,"Sorted by ",$S(IBMSORT=1:"Patient Name",IBMSORT=2:"SSN - Last 4 Digits",IBMSORT=3:"Insurance Company",IBMSORT=4:"Type of Plan",IBMSORT=5:"Appointment Date",1:"Patient Name")
 S HDR=$$FMTE^XLFDT($$NOW^XLFDT,"1Z")
 S TAB=80-$L(HDR)-1
 W ?TAB,HDR
 W !,"Patient Name",?24,"SSN",?30,"Insurance Company"
 W ?53,"Type of Plan",?69,"ApptDate"
 W !,$$RJ^XLFSTR("",80,"=")
 ;
 ; check for stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD() D  G HEADERX
 . S (ZTSTOP,STOP)=1
 . W !!!?5,"*** Report Halted by TaskManager Request ***"
 . Q
 ;
HEADERX ;
 Q
 ;
PTINS(DFN,MCRSUP) ; Function to determine if a patient should be 
 ; included in this report or not.
 ; Input:  DFN - patient ien
 ; Output:  Function value is either 0 (don't include) or 1 (include)
 ;    MCRSUP array pass by reference
 ;    MCRSUP(seq) = [1] insurance co ien pointer to file 36
 ;                  [2] group pointer to file 355.3
 ;                  [3] type of plan pointer to file 355.1
 ;
 NEW INCLUDE,INS,A,MCRWNR,MCRZ,IBINS,IBGRP,GP,TP,PLABBR
 S INCLUDE=0 KILL MCRSUP
 I '$G(DFN) G PTINSX
 I '$D(^DPT(DFN)) G PTINSX
 D ALLWNR^IBCNS1(DFN,"INS",DT)
 S A=0,(MCRWNR,MCRZ)=0
 F  S A=$O(INS(A)) Q:'A  D  Q:MCRWNR
 . S IBINS=$P($G(INS(A,0)),U,1)
 . S IBGRP=$P($G(INS(A,0)),U,18)
 . I $$MCRWNR^IBEFUNC(IBINS) S MCRWNR=1 Q      ; Medicare WNR on file
 . S GP=$G(INS(A,355.3))                       ; group/plan info
 . S TP=$P(GP,U,9),PLABBR=""                   ; type of plan pointer
 . I TP S PLABBR=$P($G(^IBE(355.1,TP,0)),U,2)  ; plan abbreviation
 . I '$F(".MG.MS.COUT.","."_PLABBR_".") Q      ; check plan
 . S MCRZ=1                                    ; Medicare other on file
 . S MCRSUP(A)=IBINS_U_IBGRP_U_TP
 . Q
 ;
 ; If Medicare Other was found, but no Medicare WNR, then include it
 I MCRZ,'MCRWNR S INCLUDE=1
 ;
PTINSX ;
 I 'INCLUDE K MCRSUP
 Q INCLUDE
 ;
 ;
DEVICE ; This procedure displays a warning message and prompts for the 
 ; device on which to print the report.
 ;
 NEW ZTRTN,ZTDESC,ZTSAVE,POP
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
 D EN^XUTMDEVQ(ZTRTN,ZTDESC,.ZTSAVE)
DEVICEX ;
 Q
 ;
