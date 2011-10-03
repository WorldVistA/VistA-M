SPNLRM ;ISC-SF/GB-SCD RADIOLOGY UTILIZATION REPORT CONTROLLER ;6/23/95  12:00
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 N DIR,DIRUT,Y
 S DIR(0)="NO^1:99999" ; Number, Optional
 S DIR("A")="Minimum number of procedures to display"
 S DIR("B")=2
 S DIR("?")="This determines the minimum number of procedures necessary in order for a radiology procedure to be displayed in the listing by order of number of procedures"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("MINNUM")=Y
 K DIR
 S DIR(0)="NO^0:999" ; Number, Optional
 S DIR("A")="Minimum dollar cost of procedures to display"
 S DIR("B")=10
 S DIR("?")="This determines the minimum total cost of procedures necessary in order for a radiology procedure to be displayed in the listing by order of cost of procedures"
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("MINCOST")=Y
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D ROLLUP^SPNLGRRA(DFN,FDATE,TDATE,HIUSERS) ; gather radiology data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 D NAMEIT^SPNLGRRA ; name the radiology procedures & price 'em
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Radiology Utilization")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 K ^TMP("SPN",$J,"RA","OUT")
 D P1^SPNLRM1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 D P2^SPNLRM1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 D P3^SPNLRM1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 I HIUSERS D  Q:ABORT
 . D P4^SPNLRM2(.TITLE,PAGELEN,HIUSERS,.ABORT) Q:ABORT
 . D P5^SPNLRM2(.TITLE,PAGELEN,HIUSERS,.ABORT) Q:ABORT
 Q
