PRSPCPP1 ; HISC/MGD - DISPLAY CURRENT PP ESR EXCEPTIONS #2 ;05/17/05
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
LOOP ; Loop through employees
 N DATA,NAME
 S NAME="",(PG,QT)=0,DASH="",$P(DASH,"_",80)="_"
 W:$E(IOST,1,2)="C-" @IOF
 F  S NAME=$O(^TMP($J,"PRSPCPPE DATA",NAME)) Q:NAME=""  D  Q:QT
 . S DATA=^TMP($J,"PRSPCPPE DATA",NAME)
 . S PRSIEN=$P(DATA,U,1),IDAYS=$P(DATA,U,2)
 . I $E(IOST,1,2)="C-" D  Q:QT
 . . I PG D PSE Q:QT
 . . S PG=1
 . . D HDR1,DIS
 . I $E(IOST,1,2)'="C-" D  Q:QT
 . . I $Y'>(IOSL-15),'PG D HDR1 S PG=1 D DIS Q
 . . I $Y'>(IOSL-15),PG W !! D HDR1,DIS Q
 . . D PSE Q:QT  S PG=0 D HDR1,DIS Q
 ;
 Q:QT
 I '$D(^TMP($J,"PRSPCPPE DATA")) D
 . I $E(IOST,1,2)="C-" W @IOF
 . W "DISPLAY PP ESR EXCEPTIONS",?50,$$FMTE^XLFDT($$NOW^XLFDT()),!!
 . W "No exceptions were found in the specified T&Ls for pay period ",PPE,!
 I $E(IOST,1,2)="C-" D PSE W @IOF
 Q
 ;
DIS ; Display 14 days
 ;
 S PDT=$G(^PRST(458,PPI,2)),STAT=$P($G(^PRST(458,PPI,"E",PRSIEN,0)),"^",2)
 S IDAYS=0
 F DAY=1:1:14 D  Q:QT
 . S DATA7=$G(^PRST(458,PPI,"E",PRSIEN,"D",DAY,7))
 . S STAT=$P(DATA7,U,1)    ; ESR Daily Status
 . I STAT<4 S IDAYS=IDAYS+1
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
 . Q:STAT>3  ; Only display exceptions
 . S STATEX=$$EXTERNAL^DILFD(458.02,146,"",STAT)
 . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . W !,$P(PDT,U,DAY),?14,$J(T1,4)," ",T1EX,?68," ",STATEX
 . S T2=$P(DATA0,U,13)  ; Tour #2
 . I T2 D  Q:QT
 . . S T2EX=$S(T2:$P($G(^PRST(457.1,T2,0)),U,1),1:"") ; Tour #2 External
 . . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . . W !?14,$J(T2,4)," ",T2EX
 . S EDLSM=$P(DATA7,U,3)   ; ESR DAY LAST SIGN METHOD
 . I EDLSM=2 S STATEX=STATEX_" - EA" ; Posted by Extended Absence
 . S QUIT=0
 . F SEG=1:5:31 D  Q:QT!(QUIT)
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
 . . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . . W !?21,START,"-",STOP,?36,TOTEX,?56,$J(MT,2),"   ",$J(HRS,5)
 . . I RC'="" D  Q:QT!(QUIT)
 . . . S RCEX=$P($G(^PRST(457.4,RC,0)),U,4)
 . . . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . . . W !?38,RCEX
 . . Q:QT!(QUIT)
 . Q:QT!(QUIT)
 . ;
 . ; Display any PTP or Supervisor Remarks
 . S PTPRMKS=$P(DATA6,U,1) ; PTP Remarks
 . I PTPRMKS'="" D  Q:QT
 . . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . . W !,"  PTP Remarks: ",PTPRMKS
 . S SUPRMKS=$P(DATA6,U,2) ; Supervisor Remarks
 . I SUPRMKS'="" D  Q:QT
 . . I $Y>(IOSL-3) D PSE Q:QT  D HDR1
 . . W !,"  Sup Remarks: ",SUPRMKS
 Q
 ;====================================================================
HDR1 S SCRTTL="PT PHYSICIAN ESR FOR PP "_PPE
 D HDR^PRSPUT1(PRSIEN,SCRTTL,,,PPI)
 W !?30,"Incomplete Days: "_$J(IDAYS,2)
 W !,"Day",?14,"Tour Description",?69,"Status"
 W !?21,"Postings",?36,"Time Code",?55,"Meal  Hours"
 W !?38,"Remarks Code"
 W !,DASH
 Q
 ;
PSE I $E(IOST,1,2)="C-" D
 . W !
 . S DIR(0)="E",DIR("A")="Press RETURN to continue"
 . D ^DIR K DIR
 . I $D(DIRUT) S QT=1
 Q:QT
 W @IOF
 Q
