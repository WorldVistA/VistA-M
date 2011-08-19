SPNLRS ;ISC-SF/GB-SCD (SPECIFIC) PHARMACY UTILIZATION REPORT CONTROLLER ;9/1/95  09:29
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 N DIC,Y,DTOUT,DUOUT
 I $$VFILE^DILFD(50)'>0 D  Q
 . W !!?5,"*** DRUG file (#50) not found ***",$C(7)
 . S ABORT=1
 . Q
 S DIC("A")="Select a GENERIC DRUG NAME: "
 ;S DIC("?")="Choose a drug you want to report on."
 S DIC="50",DIC(0)="AEQM"
 F  D ^DIC Q:Y=-1  D
 . S QLIST($P(Y,U,1))=$P(Y,U,2) ; QLIST(drugnr)=drug name
 . S DIC("A")="Another GENERIC DRUG NAME: "
 I $D(DTOUT)!($D(DUOUT))!('$D(QLIST)) S ABORT=1
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D SELECT^SPNLGSRX(DFN,FDATE,TDATE,HIUSERS,.QLIST) ; gather pharmacy data
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 D PRICEIT^SPNLGSRX ; get unit prices (cost) for the drugs
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Pharmacy Prescription Utilization")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
        I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 S TITLE(3)=$$CENTER^SPNLRU("For the Period "_XFDATE_" to "_XTDATE)
 I HIUSERS D P1^SPNLRS1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 E  D P2^SPNLRS1(.TITLE,PAGELEN,.QLIST,.ABORT) Q:ABORT
 Q
