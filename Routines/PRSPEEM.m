PRSPEEM ;HISC/MGD - ESR EXCEPTIONS FOR ENTIRE MEMORANDA ;06/15/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
PAY ; Payroll Entry
 S PRSTLV=7,QUITX=0
 D T0
 Q
 ;
SUP ; Supervisor Entry
 ;
 S PRSTLV=3,QUITX=0
T0 K DIR,^TMP($J,"PRSPEEM"),^TMP($J,"PRSPEEM EMP")
 D TOP ; print header
 D OMIT ; Prompt to omit current Pay Period
 I X="^" D EX Q
 D TLCHK ; Check for Supervisor of just 1 or mult T&L
 I MULT>1 D TL
 I MULT=1 D
 . S TL="ATL"_TLE
 . D EMP
 I '$D(^TMP($J,"PRSPEEM")) W !,"No exceptions found for input criteria." Q
 D SCRN1
 D EX
 ;
 Q
OMIT ; Prompt for Omit current pay period
 S DIR(0)="Y"
 S DIR("A")="Would you like to omit the current pay period from this report"
 D ^DIR K DIR
 S OMIT=Y
 Q
 ;
TLCHK ; Check for Supervisor of just 1 or mult T&L
 S MULT=0,I=""
 F  S I=$O(^PRST(455.5,"AS",DUZ,I)) Q:'I  D
 . S MULT=MULT+1,TLI=I,TLE=$P(^PRST(455.5,I,0),U,1)
 Q
 ;
TL ; Loop to enter T&Ls and employees
 N SEL ; local array to hold selected t&ls and employees
 S QUIT1=0
 F  D  Q:QUIT1
 . D ^PRSAUTL
 . I 'TLI S QUIT1=1 Q
 . I $D(SEL(TLI,"A")) D  Q
 ..  W !!,?5,"You have already selected all the employees in T&L unit ",$G(TLE),"."
 ..  W !,?5,"Select another T&L OR enter <return> to begin report."
 . D EMP
 Q
 ;
 ; Loop for individual employees in a T&L
EMP S QUIT2=0
 S DIR(0)="SM^A:All PT Physicians in the T&L;I:Individual PT Physicians"
 S DIR("A")="Enter Choice"
 D ^DIR K DIR
 ; Loop for All employee in a T&L
 I Y="A" D  Q
 . K SEL(TLI) S SEL(TLI,"A")=""
 . K ^TMP($J,"PRSPEEM",TLI)
 . S EMP="",TL="ATL"_TLE
 . F  S EMP=$O(^PRSPC(TL,EMP)) Q:EMP=""  D
 . . S PRSIEN=$O(^PRSPC(TL,EMP,0))
 . . Q:'PRSIEN
 . . D MEM ; Check for memos w/ status = ACTIVE or RECONCILIATION STARTED
 . . S QUIT2=1
 Q:QUIT2
 ;
 S PPI=+$G(^PRST(458,"AD",DT)),PRSDT=DT,PTPF=1
 F  D  Q:QUIT2
 . K DIC
 . S DIC("A")=$S('$D(SEL(TLI)):"Select EMPLOYEE: ",1:"Select Another EMPLOYEE: ")
 . S DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE
 . S DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458.7,""B"",+Y)),'$D(SEL(TLI,+Y))"
 . W !
 . D IX^DIC S PRSIEN=+Y
 . I X=""!(X="^") S QUIT2=1 Q
 . S SEL(TLI,PRSIEN)=""
 . D MEM
 Q
 ;
MEM ; Check for memos w/ status of ACTIVE (2) or RECONCILIATION STARTED (3)
 N PPI
 S MIEN=""
 F  S MIEN=$O(^PRST(458.7,"B",PRSIEN,MIEN)) Q:'MIEN  D
 . S DATA0=$G(^PRST(458.7,MIEN,0))
 . S STATUS=$P(DATA0,U,6)
 . Q:STATUS'=2&(STATUS'=3)
 . S TDAT=$P($G(^PRST(458.7,MIEN,4)),U,1)
 . I TDAT S TDAT=+$G(^PRST(458,"AD",TDAT)) ; IEN of termination PP 
 . ; Loop to check for any incomplete days in any PP of the memo
 . S PP=0
 . F I=1:1:26 S PPE=$P($G(^PRST(458.7,MIEN,9,I,0)),U) Q:PPE=""  D
 . . S PPI=$O(^PRST(458,"B",PPE,0))
 . . Q:'PPI
 . . ; If the memo was terminated, only check ESRs up to and
 . . ; including the Termination Date
 . . Q:TDAT&(PPI>TDAT)  ; Don't look past termination PP
 . . S PP=PP+1
 . . S DATA1=$G(^PRST(458,PPI,1)) ; FileMan Dates
 . . Q:'+$$MIEN^PRSPUT1(PRSIEN,$P(DATA1,U,I))
 . . F DAY=1:1:14 D
 . . . S ESRSTAT=$P($G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7)),U,1)
 . . . Q:ESRSTAT>3
 . . . S ESRSTATX=$$EXTERNAL^DILFD(458.02,146,"",ESRSTAT)
 . . . I ESRSTATX="" S ESRSTATX="UNKNOWN"
 . . . S Y=$P(DATA1,U,DAY)
 . . . D DD^%DT
 . . . S ^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP,DAY)=Y_U_ESRSTATX
 . . I $D(^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP)) D
 . . . S ^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP)=PPI_U_PPE
 . ; if no exceptions found set up first pay pereiod with no data message
 .   I '$D(^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN)) D
 ..     S PPE=$P($G(^PRST(458.7,MIEN,9,1,0)),U)
 ..     S PPI=$O(^PRST(458,"B",PPE,0))
 ..     S ^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,1)=PPI_U_PPE_U_"*"
 ..     S ^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,1,0)="no exceptions found fo r entire memo"
 Q
 ;
TOP W:$E(IOST,1,2)="C-" @IOF
 W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?22,"ESR EXCEPTIONS FOR ENTIRE MEMORANDA",!!
 Q
 ;
TOP1 W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 S SCRTTLX="ESR EXCEPTIONS FOR ENTIRE MEMORANDA"
 I OMIT S SCRTTLX=SCRTTLX_" - CURRENT PP OMITTED"
 S $E(SCRTTL,$S(OMIT:12,1:22))=""
 S SCRTTL=SCRTTL_SCRTTLX
 W !,SCRTTL
 Q
 ;
SCRN1 ; Loop through employees and display data
 W:$E(IOST,1,2)="C-" @IOF
 S TLI="",QUITX=0
 F  S TLI=$O(^TMP($J,"PRSPEEM",TLI)) Q:'TLI  D  Q:QUITX
 . S PRSIEN="",INDEX=1
 . F  S PRSIEN=$O(^TMP($J,"PRSPEEM",TLI,PRSIEN)) Q:'PRSIEN  D  Q:QUITX
 . . K ^TMP($J,"PRSPEEM EMP") ; Kill temporary employee array
 . . S MIEN="",(EMPQT,LIST)=0
 . . F  S MIEN=$O(^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN)) Q:'MIEN  D  Q:QUITX
 . . . S PP="",DAYCNT=0
 . . . F  S PP=$O(^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP)) Q:'PP  D  Q:QUITX
 . . . . S DATA=^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP),LIST=LIST+1
 . . . . S PPI=$P(DATA,U,1),PPE=$P(DATA,U,2)
 . . . . S ITEM(LIST)=DATA
 . . . . I DAYCNT=0 D  ; Display header prior to 1st PP in a memo
 . . . . . S ARRAY="^TMP($J,""PRSPEEM EMP"","
 . . . . . S SCRTTL="ESR EXCEPTIONS FOR ENTIRE MEMORANDA"
 . . . . . D HDR^PRSPUT1(PRSIEN,SCRTTL,ARRAY,INDEX,PPI)
 . . . . . D MEM^PRSPUT1(PRSIEN,MIEN,ARRAY)
 . . . . . D AL^PRSPUT3(PRSIEN,ARRAY)
 . . . . . S INDEX="",INDEX=$O(^TMP($J,"PRSPEEM EMP",INDEX),-1)
 . . . . . S TEXT="",INDEX=INDEX+1
 . . . . . D A1^PRSPUT1 ; Blank Line
 . . . . . S TEXT=" #  Pay Period  Date          Status"
 . . . . . D A1^PRSPUT1
 . . . . . S TEXT="------------------------------------"
 . . . . . D A1^PRSPUT1
 . . . . I $P(DATA,U,3)="*" S TEXT="No exceptions found for entire memo" D A1^PRSPUT1 Q
 . . . . S TEXT=$J(PP,2),$E(TEXT,5)="",TEXT=TEXT_PPE
 . . . . F DAY=1:1:14 D  Q:QUITX
 . . . . . Q:'$D(^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP,DAY))
 . . . . . S DATA=^TMP($J,"PRSPEEM",TLI,PRSIEN,MIEN,PP,DAY)
 . . . . . S $E(TEXT,17)="",TEXT=TEXT_$P(DATA,U,1) ; External Date
 . . . . . S $E(TEXT,31)="",TEXT=TEXT_$P(DATA,U,2) ; External Status
 . . . . . S DAYCNT=DAYCNT+1
 . . . . . D A1^PRSPUT1
 . . . . . I $Y>(IOSL-3) D PSE
 . . . Q:QUITX
 . . . S $E(TEXT,31,36)="------",INDEX=INDEX+1
 . . . D A1^PRSPUT1
 . . . S $E(TEXT,20)="",TEXT=TEXT_"Total Days: "_DAYCNT
 . . . D A1^PRSPUT1
 . . . I $P(DATA,U,3)="*" D
 . . . .  S QUITX=$$ASK^PRSLIB00(1)
 . . . E  D
 . . . .  D ACTION
 . . . I $E(IOST,1,2)="C-" W @IOF
 Q
 ;
ACTION ; Prompt for action
 S EMPQT=0
 F  D  Q:QUITX!(EMPQT)
 . S TEXT="(P)rint list, (S)elect Item or press Enter to "
 . S TEXT=TEXT_"continue to next employee"
 . W !!,TEXT
 . W !!,"Enter Choice: "
 . R CHOICE:DT
 . S CHOICE=$$UPPER^PRSRUTL(CHOICE)
 . I CHOICE="" S EMPQT=1 Q   ; Go to next employee
 . I CHOICE="^" S QUITX=1 Q  ; Terminate report
 . I CHOICE'="P"&(CHOICE'="S") D  Q
 . . W !!,"Enter P, S or ^ to Quit or press Enter to continue to next employee."
 . I CHOICE="P" D  Q:EMPQT
 . . D DVC1
 . . I POP S EMPQT=1
 . I CHOICE="S" D
 . . F  D  Q:EMPQT!(QUITX)
 . . . I $E(IOST,1,2)="C-" W @IOF
 . . . F I=1:1 Q:'$D(ITEM(I))  W !,I,?5,$P(ITEM(I),U,2)
 . . . W !!,"Select a number between 1 and ",LIST_" : "
 . . . R ITEM:DT
 . . . S ITEM=$$UPPER^PRSRUTL(ITEM)
 . . . I ITEM="" S EMPQT=1 Q   ; Go to next employee
 . . . I ITEM="^" S QUITX=1 Q  ; Terminate report
 . . . Q:'$D(ITEM(ITEM))
 . . . S PPI=+ITEM(ITEM)
 . . . D DVC2
 ;
 Q
 ;
LOOP1 ; Loop to display Summary Screen with list of outstanding ESRs
 I '$D(^TMP($J,"PRSPEEM EMP")) W !,"No part-time physician ESR Exceptions found for selected criteria." Q
 S INDX=""
 F  S INDX=$O(^TMP($J,"PRSPEEM EMP",INDX)) Q:'INDX  D
 . S TEXT=^TMP($J,"PRSPEEM EMP",INDX)
 . W !,TEXT
 Q
 ;
DVC1 ; Display Summary Screen with list of outstanding ESRs
 W !
 K IOP,%ZIS
 S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS K %ZIS,IOP
 Q:POP
 I $D(IO("Q")) D  Q
 .  S ZTRTN="LOOP1^PRSPEEM"
 .  S ZTSAVE("^TMP($J,""PRSPEEM EMP"",")=""
 .  S ZTDESC="PRS PTP EXCEPTS"
 .  D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .  K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .  D HOME^%ZIS
 U IO D LOOP1
 D ^%ZISC K %ZIS,IOP
 D H1 ; pause screen
 Q
 ;
DVC2 ; Display PP ESR
 W !
 K IOP,%ZIS
 S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS K %ZIS,IOP
 Q:POP
 I $D(IO("Q")) D  Q
 .  S ZTRTN="DIS^PRSPDESR"
 .  S ZTSAVE("PRSIEN")="",ZTSAVE("PPI")="",ZTSAVE("PPE")=""
 .  S ZTDESC="PRS PTP DISPLAY ESR"
 .  D ^%ZTLOAD W !,$S($D(ZTSK):"Request Queued!",1:"Request Canceled!")
 .  K ZTSK,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE
 .  D HOME^%ZIS
 .  N HOLD S HOLD=$$ASK^PRSLIB00(1)
 U IO D DIS^PRSPDESR
 D ^%ZISC K %ZIS,IOP
 D H1 ; pause screen
 Q
 ;
 ;====================================================================
 ;
PSE ; Pause for screen breaks
 W !
 S DIR(0)="E",DIR("A")="Press RETURN to continue"
 D ^DIR
 I X="^" S QUITX=1 Q
 W @IOF
 Q
 ; 
H1 I $E(IOST,1,2)="C-" R !!,"Press RETURN to Continue.",X:DTIME S:'$T!(X["^") QT=1
 Q
EX ; Clean up variables
 K ARRAY,CHOICE,D,DASH,DATA,DATA0,DATA1,DAY,DAYCNT,DFN
 K EMP,EMPQT,ESRSTAT,ESRSTATX,I,IDAYS,INDEX,INDX,ITEM,LIST,MIEN
 K MULT,OMIT,POP,PP,PPE,PPI,PRSAPGM,PRSDT,PRSIEN,PRSTLV,PTPF
 K QT,QUIT1,QUIT2,QUITX,SCRTTL,SCRTTLX,STATUS,TDAT,TEXT,TL,TLE,TLI,X,Y
 Q
