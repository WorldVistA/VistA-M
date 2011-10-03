SPNLRA ;ISC-SF/GB-SCD CURRENT PATIENT REPORT ;6/23/95  11:52
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D GATHER^SPNLGICP(DFN) ; Gather current patients
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Current Patients")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
 I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 D P1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 Q
P1(TITLE,PAGELEN,ABORT) ;
 N STATUS,PAT
 S TITLE(3)=$$CENTER^SPNLRU("Total Patients:  "_+$G(^TMP("SPN",$J,"CP")))
 S TITLE(4)=""
 ;          "         1         2         3         4         5         6         7         8"
 S TITLE(5)="Name                                SSN"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S PAT=""
 F  S PAT=$O(^TMP("SPN",$J,"CP",PAT)) Q:PAT=""  D  Q:ABORT
 . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . S STATUS=$G(^TMP("SPN",$J,"CP",PAT))
 . W !,$P(PAT,U,1),?32,$P(PAT,U,2),?50,STATUS
 Q
