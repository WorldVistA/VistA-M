PRSPDEM ; HISC/MGD - DISPLAY PT PHYSICIAN EXPIRING MEMORANDUMS ;06/28/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PAY ; Payroll Entry
 N PPERIOD
 S PRSTLV=7
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 S TEXT="MEMORANDA EXPIRING WITHIN THE NEXT 30 DAYS"
 S SCRTTL=TEXT
 W !?19,TEXT
 ; Prompt for Expiration date
 W !!,"This report identifies PT Physician memorandums that will expire"
 W !,"within the next 30 days.  You may specify a date range other "
 W "than 30."
 W !
EDAT ;
 S %DT="AEFX",%DT("A")="Expiration Date: ",%DT("B")="T+30",%DT(0)=DT
 D ^%DT
 S EDAT=Y
 ;
PRCNT ; Prompt for optional off by percentage 
 W !!,"You have the option to enter an Off By Percentage that will only"
 W !,"list memorandums that are expiring within the specified date and"
 W !,"that are only off by more than the percentage you specify."
 W !!
 S DIR("A")="Would you like to specify an Off By Percentage "
 S DIR(0)="YO"
 S PRCNT=""
 D ^DIR K DIR
 I X="Y" D
 . W !
 . S DIR(0)="NO^1:100:0"
 . S DIR("A")="Select Off By Percentage "
 . D ^DIR
 . I X S PRCNT=X
 ;====================================================================
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP Q:POP
 I $D(IO("Q")) D  Q
 . S PRSAPGM="DIS^PRSPDEM",PRSALST="DT^EDAT^PRCNT^POT"
 . D QUE^PRSAUTL
 U IO D DIS
 ; pause screen when employee to prevent scroll (other users prompted)
 I $E(IOST,1,2)="C-",'QT,PRSTLV=1 S PG=PG+1 D H1
 D ^%ZISC K %ZIS,IOP Q
 ;
DIS ; Display Memorandum
 ;
 S (CNT,MIEN,PG,QT)=0
 F  S MIEN=$O(^PRST(458.7,MIEN)) Q:'MIEN  D  Q:QT
 . S DATA0=$G(^PRST(458.7,MIEN,0)),DATA4=$G(^PRST(458.7,MIEN,4))
 . S DATA3=$G(^PRST(458.7,MIEN,3))
 . Q:$P(DATA3,U,1)  ; Memo has been reconciled
 . ;
 . ; Check for Termination date beyond user selected expiration date
 . S PRSIEN=$P(DATA0,U,1),POT=$P(DATA0,U,17)
 . S TDAT=$P(DATA4,U,1),ENDAT=$P(DATA0,U,3)
 . Q:TDAT&(TDAT>EDAT)
 . ;
 . ; Check for end date beyond user selected expiration date
 . Q:TDAT=""&(ENDAT>EDAT)
 . ;
 . ; Quit if less that Percent Off Target
 . Q:PRCNT&(+$FN(POT,"T")<PRCNT)
 . ;
 . ; Update counter and display memo
 . S CNT=CNT+1
 . D DISPLAY
 . I $D(DIRUT) S QT=1 Q
 . D PSE
 ;
 Q:$D(DIRUT)
 W !!,"There were "_CNT_" PT Physician Memorandums expiring in the"
 W " date range specified"
 I PRCNT D
 . W !,"who were more than "_PRCNT_"% off target"
 W "."
 Q
 ;
DISPLAY ; Display memorandum information
 W @IOF
 S SCRTTL="DISPLAY PT PHYSICIAN MEMORANDA"
 S ARRAY="^TMP($J,""PRSPDM"",",INDEX=1
 D HDR^PRSPUT1(PRSIEN,SCRTTL,ARRAY,INDEX)
 D MEM^PRSPUT1(PRSIEN,MIEN,ARRAY)
 D AL^PRSPUT3(PRSIEN,ARRAY)
 D PPSUM^PRSPUT2(PRSIEN,MIEN,ARRAY)
 I $E(IOST,1,2)="C-" D
 . S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 . I '$D(DIRUT) W @IOF
 Q:$D(DIRUT)
 ;
ESRCHK ; Check for any incomplete ESR within the memoranda.
 ;
 F I=1:1:26 D
 . S PPE=$P($G(^PRST(458.7,MIEN,9,I,0)),U)
 . I PPE="" S ^TMP($J,"INCESR","NO DATA")="" Q
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:'PPI  ; Pay Period is not opened yet.
 . S QUIT=0
 . F DAY=1:1:14 D  Q:QUIT
 . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . I ESRSTAT<5 S ^TMP($J,"INCESR",PPE)="",QUIT=1
 S INDEX=INDEX+1
 S TEXT=""
 D A1^PRSPUT1,A1^PRSPUT1 ; Blank Lines
 S TEXT="The following Pay Periods have days with incomplete daily ESRs: "
 D A1^PRSPUT1
 S (PPE,PPEX)=""
 F  S PPE=$O(^TMP($J,"INCESR",PPE)) Q:PPE=""  D
 . S PPEX=$S(PPEX="":PPE,1:PPEX_", "_PPE)
 S TEXT="" D A1^PRSPUT1 ; Blank Line
 S TEXT=PPEX
 D A1^PRSPUT1
 K ^TMP($J,"INCESR")
 ;
 ; Load and display any HR Initial comments
 S MESSAGE=$G(^PRST(458.7,MIEN,1))
 I MESSAGE'="" D
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"HR Initial Comments: ",1:"")
 . . D TEXT^PRSPDM(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 ;
 ; Load and display Termination information if any
 S DATA4=$G(^PRST(458.7,MIEN,4))
 S TDAT=$P(DATA4,U,1),TERMBY=$P(DATA4,U,2),TERMDT=$P(DATA4,U,3)
 I TDAT'="" D
 . S Y=TDAT
 . D DD^%DT
 . S TDAT=Y
 . I TDAT'="" D
 . . S TEXT=""
 . . D A1^PRSPUT1 ; Blank Line
 . . S TEXT="    Termination date: "_TDAT
 . . D A1^PRSPUT1
 ;
 I TERMBY'="" D
 . S TERMBY=$P($G(^VA(200,TERMBY,0)),U,1)
 . S TEXT="       Terminated by: "_TERMBY
 . D A1^PRSPUT1
 ;
 I TERMDT'="" D
 . S Y=TERMDT
 . D DD^%DT
 . S TERMDT=Y
 . I TERMDT'="" D
 . . S TEXT="Date/Time Terminated: "_TERMDT
 . . D A1^PRSPUT1
 I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 ;
 S MESSAGE=$G(^PRST(458.7,MIEN,4.1))
 I MESSAGE'="" D
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"HR's Termination Comments: ",1:"")
 . . D TEXT^PRSPDM(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 Q
PSE ; Pause for screen breaks
 Q:$E(IOST,1,2)'="C-"
 W !
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR
 I $D(DIRUT) S QT=1
 W @IOF
 Q
 ;
 ;====================================================================
 ;
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 S PG=PG+1
 Q
EX ; Clean up variables
 K ARRAY,CNT,D,D1,DASH,DATA0,DATA2,DATA3,DATA31,DATA4,DATA41,DATA4580
 K DAY,DAY1,DFN,DIRUT,EDAT,ENDAT,ESRSTAT,HEADER,HRS,I,ICOM
 K IDAYS,IEN,INDEX,J,MESSAGE,MIEN,MT,PDT,PG,POP,POT,PPEX,PRCNT,PRSIEN
 K PTPRC,PTPRCOM,RECONBY,RECONDAT,SDAT,TDAT,TERMBY,TERMDT,TEXT,TL
 K PPE,PPI,PRSALST,PRSAPGM,PRSTLV,PTPRMKS,QUIT,QT,RC,RCEX,SCRTTL
 K SEG,SSN,START,STAT,STATEX,STOP,T1,T1EX,TLI,TLSCREEN,TOT,TOTEX
 K X,Y,%DT,%ZIS
 Q
