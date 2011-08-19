SPNLRR ;ISC-SF/GB-SCD SELECTED LAB TEST UTILIZATION REPORT ;9/1/95  09:29
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific question
 N DIC,Y,DTOUT,DUOUT,LOC
 I $$VFILE^DILFD(60)'>0 D  Q
 . W !!?5,"*** LABORATORY TEST file (#60) not found ***",$C(7)
 . S ABORT=1
 . Q
 ;S DIC("?")="The lab test may not be a panel of tests."
 S DIC("S")="I '$D(^LAB(60,+Y,2))"
 S DIC="60",DIC(0)="AEQMZ"
 F  D ^DIC Q:Y=-1  D
 . S LOC=$P(Y(0),U,5)
 . I LOC="" D  Q
 . . W !,"Sorry, can't use this test."
 . . W !,"LOCATION (DATA NAME) not defined in ^LAB(60.",!
 . S QLIST($P(LOC,";",2))=$P(Y,U,2) ; QLIST(testnr)=test name
 . S DIC("A")="Another LABORATORY TEST NAME: "
 I $D(DTOUT)!($D(DUOUT))!('$D(QLIST)) S ABORT=1
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D SELECT^SPNLGSCH(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather lab test data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Laboratory Utilization (Specific)")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 I HIUSERS D P1^SPNLRR1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 E  D P2^SPNLRR1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 Q
