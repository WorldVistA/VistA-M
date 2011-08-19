SPNLRQ ;ISC-SF/GB-SCD (SPECIFIC) IP/OP REPORT CONTROLLER ;10/8/96  09:48
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Ask report-specific questions
 N DIC,Y,DTOUT,DUOUT
 W !
 S DIC("A")="Select a CLINIC STOP: "
 ;S DIC("?")="Choose a clinic you want to report on."
 S DIC="40.7",DIC(0)="AEQMZ"
 F  D ^DIC Q:Y=-1  D
 . S QLIST("SC",+$P(Y(0),U,2))=$P(Y,U,2) ; QLIST("SC",scnum)=clinic name
 . S DIC("A")=" Another CLINIC STOP: "
 I $D(DTOUT)!($D(DUOUT)) S ABORT=1 Q
 W !
 S DIC("A")="Select a SPECIALTY: "
 ;S DIC("?")="Choose a specialty you want to report on."
 S DIC="42.4",DIC(0)="AEQM"
 F  D ^DIC Q:Y=-1  D
 . S QLIST("BS",$P(Y,U,1))=$P(Y,U,2) ; QLIST("BS",bsnr)=bed section name
 . S DIC("A")=" Another SPECIALTY: "
 I $D(DTOUT)!($D(DUOUT))!('$D(QLIST)) S ABORT=1
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D SELECT^SPNLGSOP(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather outpatient data
 D SELECT^SPNLGSIP(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather inpatient data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Specific Inpatient and Outpatient Activity")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(4)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 I HIUSERS D
 . S TITLE(3)=$$CENTER^SPNLRU("Selected Outpatient Activity")
 . D:$D(QLIST("SC")) P1^SPNLRQO(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 . S TITLE(3)=$$CENTER^SPNLRU("Selected Inpatient Activity")
 . D:$D(QLIST("BS")) P1^SPNLRQI(.TITLE,PAGELEN,.QLIST,.ABORT)
 E  D
 . S TITLE(3)=$$CENTER^SPNLRU("Selected Outpatient Activity")
 . D:$D(QLIST("SC")) P2^SPNLRQO(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 . S TITLE(3)=$$CENTER^SPNLRU("Selected Inpatient Activity")
 . D:$D(QLIST("BS")) P2^SPNLRQI(.TITLE,PAGELEN,.QLIST,.ABORT)
 Q
