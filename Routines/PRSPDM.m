PRSPDM ; HISC/MGD - DISPLAY PT PHYSICIAN MEMORANDUM ;06/28/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PAY ; Payroll Entry
 S PRSTLV=7
 D TOP ; print header
P1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 W ! D ^DIC S (DFN,PRSIEN)=+Y K DIC G:DFN<1 EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8)
 S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: "
 W ! D ^DIC K DIC G:Y<1 EX
 S PPI=+Y
 S PPE=$P(Y,U,2)
 D L1 ;ask device
 G P1 ;ask for employee again
 ;====================================================================
TK ; TimeKeeper Entry
 S PRSTLV=2 G T0
 ;====================================================================
SUP ; Supervisor Entry
 S PRSTLV=3
T0 D TOP ; print header
 D ^PRSAUTL G:TLI<1 EX
T1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 S DIC("S")="I $P(^(0),""^"",8)=TLE" S D="ATL"_TLE W ! D IX^DIC
 S (DFN,PRSIEN)=+Y K DIC G:DFN<1 EX
 S %DT="AEPX",%DT("A")="Posting Date: " W ! D ^%DT
 G:Y<1 EX
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 G EX:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 D L1 ;ask device
 ; 
 G T1 ;ask for employee again
 ;====================================================================
EMP ; Employee Entry
 S PRSTLV=1 D TOP S DFN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S DFN=$O(^PRSPC("SSN",SSN,0)),PRSIEN=DFN
 I 'DFN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8)
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=3040101 W ! D ^%DT
 G:Y<1 EX
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 G EX:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 D L1 G EX
 ;====================================================================
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?25,"DISPLAY PT PHYSICIAN MEMORANDA" Q
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS K %ZIS,IOP
 Q:POP
 I $D(IO("Q")) D  Q
 . S PRSAPGM="DIS^PRSPDM",PRSALST="PRSIEN^TLE^PPE^PPI"
 . D QUE^PRSAUTL
 U IO D DIS
 ; pause screen when employee to prevent scroll (other users prompted)
 I $E(IOST,1,2)="C-",'QT,PRSTLV=1,'$D(DIRUT) S PG=PG+1 D H1
 D ^%ZISC K %ZIS,IOP Q
 ;====================================================================
DIS ; Display Memorandum
 ;
 S PDT=$G(^PRST(458,PPI,2)),DAY1=$P($G(^PRST(458,PPI,1)),U,1)
 S STAT=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),"^",2)
 S MIEN=+$$MIEN^PRSPUT1(PRSIEN,DAY1),(PG,QT)=0
 I 'MIEN D  Q
 . W !!,"The employee did not have a memorandum during the date specified."
 ;
DISPLAY ; Display memorandum information
 W:$E(IOST,1,2)="C-" @IOF
 S SCRTTL="DISPLAY PT PHYSICIAN MEMORANDA"
 S ARRAY="^TMP($J,""PRSPDM"",",INDEX=1
 D HDR^PRSPUT1(PRSIEN,SCRTTL,ARRAY,INDEX,PPI)
 D MEM^PRSPUT1(PRSIEN,MIEN,ARRAY)
 D AL^PRSPUT3(PRSIEN,ARRAY)
 D PPSUM^PRSPUT2(PRSIEN,MIEN,ARRAY)
 Q:$D(DIRUT)
 I $E(IOST,1,2)="C-" D
 . S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 . I '$D(DIRUT) W @IOF
 Q:$D(DIRUT)
 ;
ESRCHK ; Check for any incomplete ESR within the memoranda.
 ;
 S QUIT=0
 S PPIT=+$G(^PRST(458.7,MIEN,4)),PPIT=+$G(^PRST(458,"AD",PPIT))
 F I=1:1:26 D
 . S PPE=$P($G(^PRST(458.7,MIEN,9,I,0)),U)
 . I PPE="" S ^TMP($J,"INCESR","NO DATA")="" S QUIT=1 Q
 . S PPI=$O(^PRST(458,"B",PPE,0))
 . Q:'PPI
 . I PPIT,PPIT<PPI Q  ; Don't display PP ESR beyond termination of memo
 . F DAY=1:1:14 D  Q:QUIT
 . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . I ESRSTAT<5 S ^TMP($J,"INCESR",PPE)="",QUIT=1
 ;
 ; List any PP exceptions
 I $D(^TMP($J,"INCESR")) D
 . S INDEX=INDEX+1
 . S TEXT=""
 . D A1^PRSPUT1,A1^PRSPUT1 ; Blank Lines
 . S TEXT="The following Pay Periods have days with incomplete daily ESRs: "
 . D A1^PRSPUT1
 . S (PPE,PPEX)=""
 . S TEXT="" D A1^PRSPUT1 ; Blank Line
 . F  S PPE=$O(^TMP($J,"INCESR",PPE)) Q:PPE=""  D
 . . S PPEX=$S(PPEX="":PPE,1:PPEX_", "_PPE)
 . S TEXT=PPEX
 I '$D(^TMP($J,"INCESR")) D
 . S TEXT="  There are no pay periods with incomplete daily ESRs."
 D A1^PRSPUT1
 K ^TMP($J,"INCESR")
 ;
 ; Load and display any HR Initial comments
 I PRSTLV'=1 D
 . S MESSAGE=$G(^PRST(458.7,MIEN,1))
 . Q:MESSAGE=""
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"HR Initial Comments: ",1:"")
 . . D TEXT(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 ;
 ; Load and display Termination information if any
 I PRSTLV'=1 D
 . S DATA4=$G(^PRST(458.7,MIEN,4))
 . S TDAT=$P(DATA4,U,1),TERMBY=$P(DATA4,U,2),TERMDT=$P(DATA4,U,3)
 . I TDAT'="" D
 . . S Y=TDAT
 . . D DD^%DT
 . . S TDAT=Y
 . . I TDAT'="" D
 . . . S TEXT=""
 . . . D A1^PRSPUT1 ; Blank Line
 . . . S TEXT="    Termination date: "_TDAT
 . . . D A1^PRSPUT1
 . ;
 . I TERMBY'="" D
 . . S TERMBY=$P($G(^VA(200,TERMBY,0)),U,1)
 . . S TEXT="       Terminated by: "_TERMBY
 . . D A1^PRSPUT1
 . ;
 . I TERMDT'="" D
 . . S Y=TERMDT
 . . D DD^%DT
 . . S TERMDT=Y
 . . I TERMDT'="" D
 . . . S TEXT="Date/Time Terminated: "_TERMDT
 . . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 . ;
 . S MESSAGE=$G(^PRST(458.7,MIEN,4.1))
 . Q:MESSAGE=""
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"HR's Termination Comments: ",1:"")
 . . D TEXT(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 ;
 ; Load and display PTP's reconciliation choice and comments
 S DATA2=$G(^PRST(458.7,MIEN,2))
 S PTPRC=$P(DATA2,U,1),MESSAGE=$P(DATA2,U,2)
 I PTPRC'="" D
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . S TEXT=$$EXTERNAL^DILFD(458.7,17,"",PTPRC)
 . S TEXT="  PTP's Reconciliation Choice: "_TEXT
 . D A1^PRSPUT1
 I MESSAGE'="" D
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"PTP's Reconciliation Comments: ",1:"")
 . . D TEXT(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 ;
 ; Load and display HR's reconciliation info and comments
 I PRSTLV'=1 D
 . I $Y>(IOSL-7) D PSE Q:$D(DIRUT)
 . S DATA3=$G(^PRST(458.7,MIEN,3))
 . S RECONBY=$P(DATA3,U,1),RECONDAT=$P(DATA3,U,2)
 . I RECONBY'="" D
 . . S TEXT=""
 . . D A1^PRSPUT1 ; Blank Line
 . . S RECONBY=$P($G(^VA(200,RECONBY,0)),U,1)
 . . S TEXT="Reconciled by: "_RECONBY
 . . D A1^PRSPUT1
 . I $Y>(IOSL-5) D PSE Q:$D(DIRUT)
 . I RECONDAT'="" D
 . . S Y=RECONDAT
 . . D DD^%DT
 . . S RECONDAT=Y
 . . I RECONDAT'="" D
 . . . S TEXT="Reconciled on: "_RECONDAT
 . . . D A1^PRSPUT1
 . I $Y>(IOSL-7) D PSE Q:$D(DIRUT)
 ;
 ; HR Reconciliation Comments
 I PRSTLV'=1 D
 . S MESSAGE=$G(^PRST(458.7,MIEN,3.1))
 . Q:MESSAGE=""
 . S TEXT=""
 . D A1^PRSPUT1 ; Blank Line
 . F J=1:1:3 D
 . . S HEADER=$S(J=1:"HR's Reconciliation Comments: ",1:"")
 . . D TEXT(HEADER,.MESSAGE)
 . . D A1^PRSPUT1
 Q
 ;
PSE ; Pause for screen breaks
 Q:$E(IOST,1,2)'="C-"
 W !
 S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 W @IOF
 Q
 ;
H1 I PG,$E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 S PG=PG+1
 Q
 ;
TEXT(HEADER,MESSAGE) ;
 N BREAK
 S BREAK=0
 I $L(HEADER)+$L(MESSAGE)<80 D  Q
 . S TEXT=HEADER_MESSAGE
 . S MESSAGE=""
 F I=(80-$L(HEADER)):-1:0 D  Q:BREAK
 . Q:$E(MESSAGE,I)'=" "
 . S TEXT=HEADER_$E(MESSAGE,1,I)
 . S MESSAGE=$E(MESSAGE,I+1,999)
 . S BREAK=1
 Q
 ;
EX ; Clean up variables
 K ARRAY,D,D1,DASH,DATA0,DATA2,DATA3,DATA4,DAY
 K DAY1,DFN,DIRUT,ESRSTAT,HRS,I,ICOM,IDAYS,INDEX,J,HEADER,MESSAGE
 K MIEN,MT,PDT,PG,POP,PPE,PPEX,PPI,PPIT,PRSALST,PRSAPGM,PRSIEN,PRSTLV
 K PTPRC,PTPRCOM,PTPRMKS,QUIT,QT,RC,RCEX,RECONBY,RECONDAT,SCRTTL,SEG
 K SSN,START,STAT,STATEX,STOP,T1,T1EX,TDAT,TERMBY,TERMDT,TEXT,TLI,TLE
 K TLSCREEN,TOT,TOTEX,X,Y,%DT,%ZIS
 Q
