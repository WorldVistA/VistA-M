SPNLRK ;ISC-SF/GB-SCD LAB TEST UTILIZATION REPORT ;6/23/95  11:58
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific question
 N DIR,Y,DIRUT
 S DIR(0)="NO^1:999999" ; Number, Optional
 S DIR("A")="Minimum number of results reported for a test to be listed"
 S DIR("B")=3
 S DIR("?")="This number is used to keep from showing long lists of infrequent tests by setting a minimum number of results for display."
 D ^DIR I $D(DIRUT) S ABORT=1 Q
 S QLIST("MIN")=Y
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D ROLLUP^SPNLGRCH(DFN,FDATE,TDATE,HIUSERS) ; gather lab test data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 D NAMEIT^SPNLGRCH ; name the lab tests
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Laboratory Utilization")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 K ^TMP("SPN",$J,"CH","OUT")
 D P1^SPNLRK1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 D P2^SPNLRK1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 D:HIUSERS P3^SPNLRK1(.TITLE,PAGELEN,HIUSERS,.ABORT)
 Q
