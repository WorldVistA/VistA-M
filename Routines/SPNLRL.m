SPNLRL ;ISC-SF/GB-SCD PHARMACY UTILIZATION REPORT CONTROLLER ;6/23/95  12:00
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 N DIR,Y,DIRUT
 S DIR(0)="NO^1:999999" ; Number, Optional
 S DIR("A")="Minimum number of fills to display"
 S DIR("B")=2
 S DIR("?")="This determines the minimum number of fills for which a drug will be displayed in the listing by order of number of fills"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("MINFILL")=Y
 K DIR
 S DIR(0)="NO^0:9999999" ; Number, Optional
 S DIR("A")="Minimum dollar cost of dispensed fills to display"
 S DIR("B")=10
 S DIR("?")="This determines the minimum cost of fills for which a drug will be displayed in the listing by order of cost of drugs dispensed"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("MINCOST")=Y
 K DIR
 S DIR(0)="SO^1:Actual cost at the time;2:Current cost today"
 S DIR("A")="How should dollar costs of prescription drugs be reported?"
 S DIR("?")="Do you want to see what actual costs were or do you want to see what it would cost today?"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("COST")=$S(Y=1:"ACTUAL",1:"CURRENT")
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D ROLLUP^SPNLGRRX(DFN,FDATE,TDATE,HIUSERS) ; gather pharmacy data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 D NAMEIT^SPNLGRRX ; name the drugs and price 'em
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Pharmacy Prescription Utilization")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 K ^TMP("SPN",$J,"RX","OUT") ; used for temporary data shuffling
 D P1^SPNLRL1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 D P2^SPNLRL1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 D P3^SPNLRL2(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 D P4^SPNLRL2(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 I HIUSERS D  Q:ABORT
 . D P5^SPNLRL3(.TITLE,PAGELEN,.QLIST,HIUSERS,.ABORT) Q:ABORT
 . D P6^SPNLRL3(.TITLE,PAGELEN,.QLIST,HIUSERS,.ABORT) Q:ABORT
 Q
