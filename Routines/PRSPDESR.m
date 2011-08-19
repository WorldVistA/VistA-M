PRSPDESR ; HISC/MGD - Display PT Phy ESR ;05/01/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
PAY ; Payroll Entry
 S PRSTLV=7
 D TOP ; print header
P1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 W ! D ^DIC S PRSIEN=+Y K DIC G:PRSIEN<1 EX
 S TLE=$P($G(^PRSPC(PRSIEN,0)),"^",8)
 S DIC="^PRST(458,",DIC(0)="AEQM",DIC("A")="Select PAY PERIOD: "
 W ! D ^DIC K DIC G:Y<1 EX
 S PPI=+Y
 S PPE=$P(Y,U,2)
 D L1 ;ask device
 G P1 ;ask for employee again
 ;
TK ; TimeKeeper Entry
 S PRSTLV=2 G T0
 ;
SUP ; Supervisor Entry
 S PRSTLV=3
T0 D TOP ; print header
 D ^PRSAUTL G:TLI<1 EX
T1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 S DIC("S")="I $P(^(0),""^"",8)=TLE" S D="ATL"_TLE W ! D IX^DIC
 S PRSIEN=+Y K DIC G:PRSIEN<1 EX
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=3041001 W ! D ^%DT
 G:Y<1 EX
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 G EX:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 D L1 ;ask device
 G T1 ;ask for employee again
 ;
EMP ; Employee Entry
 S PRSTLV=1 D TOP S PRSIEN="",SSN=$P($G(^VA(200,DUZ,1)),"^",9)
 I SSN'="" S PRSIEN=$O(^PRSPC("SSN",SSN,0))
 I 'PRSIEN W !!,*7,"Your SSN was not found in both the New Person & Employee File!" G EX
 S PRSIEN=PRSIEN
 S TLE=$P($G(^PRSPC(PRSIEN,0)),"^",8)
 S %DT="AEPX",%DT("A")="Posting Date: ",%DT(0)=3040101 W ! D ^%DT
 G:Y<1 EX
 S D1=Y S Y=$G(^PRST(458,"AD",D1)),PPI=$P(Y,"^",1)
 S MIEN=+$$MIEN^PRSPUT1(PRSIEN,D1)
 G EX:PPI<1
 S PPE=$P($G(^PRST(458,PPI,0)),U,1)
 D L1 G EX
 ;
TOP W:$E(IOST,1,2)="C-" @IOF W !?26,"VA TIME & ATTENDANCE SYSTEM"
 W !?27,"DISPLAY PT PHYSICIAN ESR" Q
L1 W ! K IOP,%ZIS S %ZIS("A")="Select Device: ",%ZIS="MQ"
 D ^%ZIS K %ZIS,IOP
 Q:POP
 I $D(IO("Q")) D  Q
 . S PRSAPGM="DIS^PRSPDESR",PRSALST="PRSIEN^TLE^PPI^PPE^DATA7"
 . D QUE^PRSAUTL
 U IO D DIS
 I $E(IOST,1,2)="C-",'QT D H1
 D ^%ZISC K %ZIS,IOP Q
 ;
DIS ; Display 14 days
 ;
 S PDT=$G(^PRST(458,PPI,2)),STAT=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),"^",2)
 S QT=0,DASH="",$P(DASH,"_",80)="_"
 S IDAYS=0
 F DAY=1:1:14 D  Q:QT
 . S DATA7=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7))
 . S STAT=$P(DATA7,U,1)    ; ESR Daily Status
 . I STAT<4 S IDAYS=IDAYS+1
 D HDR1
 ; Check to see if the PTP had a memorandum during this PP.
 S DAY1=$P($G(^PRST(458,PPI,1)),U,1)
 I +$$MIEN^PRSPUT1(PRSIEN,DAY1)=0 D  Q:QT
 . W !!,"This employee did not have an active Memorandum during this Pay Period."
 . S QT=1
 F DAY=1:1:14 D  Q:QT
 . S DATA0=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,0))
 . S DATA5=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,5))
 . S DATA6=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,6))
 . S DATA7=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7))
 . S T1=$P(DATA0,U,2)      ; Tour #1
 . S T1EX=$S(T1:$P($G(^PRST(457.1,T1,0)),U,1),1:"") ; Tour #1 External
 . S STAT=$P(DATA7,U,1)    ; ESR Daily Status
 . S STATEX=$$EXTERNAL^DILFD(458.02,146,"",STAT)
 . W !,$P(PDT,U,DAY),?14,$J(T1,4)," ",T1EX,?68," ",STATEX
 . S T2=$P(DATA0,U,13)  ; Tour #2
 . I T2 D
 . . S T2EX=$S(T2:$P($G(^PRST(457.1,T2,0)),U,1),1:"") ; Tour #2 External
 . . W !?14,$J(T2,4)," ",T2EX
 . S EDLSM=$P(DATA7,U,3)   ; ESR DAY LAST SIGN METHOD
 . I EDLSM=2 S STATEX=STATEX_" - EA" ; Posted by Extended Absence
 . S QUIT=0
 . F SEG=1:5:31 D:$Y>(IOSL-3) HDR Q:QT!(QUIT)  D  Q:QT!(QUIT)
 . . S START=$P(DATA5,U,SEG)
 . . I START="",SEG>1 S QUIT=1
 . . Q:START=""
 . . S STOP=$P(DATA5,U,SEG+1),TOT=$P(DATA5,U,SEG+2)
 . . S TOTEX=""
 . . I TOT'="" D
 . . . S TOTEX=$O(^PRST(457.3,"B",TOT,0))
 . . . S TOTEX=$E($P($G(^PRST(457.3,TOTEX,0)),U,2),1,14)
 . . . S TOTEX=TOT_" "_TOTEX
 . . S RC=$P(DATA5,U,SEG+3),MT=$P(DATA5,U,SEG+4)
 . . S HRS=$$ELAPSE^PRSPESR2(MT,START,STOP)
 . . W !?21,START,"-",STOP,?36,TOTEX,?56,$J(MT,2),"   ",$J(HRS,5)
 . . D:$Y>(IOSL-3) HDR
 . . Q:QT!(QUIT)
 . . I RC'="" D  Q:QT!(QUIT)
 . . . S RCEX=$P($G(^PRST(457.4,RC,0)),U,4)
 . . . W !?38,RCEX
 . . . D:$Y>(IOSL-3) HDR
 . . Q:QT!(QUIT)
 . Q:QT
 . ;
 . ; Display any PTP or Supervisor Remarks
 . S PTPRMKS=$P(DATA6,U,1) ; PTP Remarks
 . I PTPRMKS'="" D  Q:QT!(QUIT)
 . . W !,"  PTP Remarks: ",PTPRMKS
 . . D:$Y>(IOSL-3) HDR
 . S SUPRMKS=$P(DATA6,U,2) ; Supervisor Remarks
 . I SUPRMKS'="" D  Q:QT!(QUIT)
 . . W !,"  Sup Remarks: ",SUPRMKS
 . . D:$Y>(IOSL-3) HDR
 Q
 ;====================================================================
HDR ; Display Header
 D H1 Q:QT  W @IOF
HDR1 S SCRTTL="PT PHYSICIAN ESR FOR PP "_PPE
 D HDR^PRSPUT1(PRSIEN,SCRTTL,,,PPI)
 W !?30,"Incomplete Days: "_$J(IDAYS,2)
 W !,"Day",?14,"Tour Description",?69,"Status"
 W !?21,"Postings",?36,"Time Code",?55,"Meal  Hours"
 W !?38,"Remarks Code"
 W !,DASH
 Q
 ;
H1 I $E(IOST,1,2)="C-" D
 . W !
 . S DIR(0)="E",DIR("A")="Press RETURN to continue"
 . D ^DIR K DIR
 . I $D(DIRUT) S QT=1
 Q
EX ; Clean up variables
 K D,D1,DASH,DATA0,DATA5,DATA6,DATA7,DAY,DAY1,DIRUT,EDLSM,HRS,IDAYS
 K MIEN,MT,PDT,POP,PPE,PPI,PRSALST,PRSAPGM,PRSIEN,PRSTLV,PTPRMKS,QUIT
 K QT,RC,RCEX,SCRTTL,SEG,SSN,START,STAT,STATEX,SUPRMKS,STOP,T1,T1EX
 K T2,T2EX,TLE,TLI,TLSCREEN,TOT,TOTEX,X,Y,%DT,%ZIS
 Q
