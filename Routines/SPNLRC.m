SPNLRC ;ISC-SF/GB-SCD CURRENT INPATIENT REPORT ;6/23/95  11:54
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ASK(QLIST,ABORT) ; Report-specific questions
 Q
GATHER(DFN,FDATE,TDATE,HIUSERS,QLIST) ;
 D GATHER^SPNLGICI(DFN,FDATE) ; gather current inpatients
 Q
PRINT(FACNAME,XFDATE,XTDATE,HIUSERS,QLIST,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 N TITLE,PAGELEN
 S PAGELEN=IOSL-3
 S TITLE(1)=$$CENTER^SPNLRU("SCD - Current Inpatients")
 S TITLE(2)=$$CENTER^SPNLRU(FACNAME)
 I $D(SPNLTRM1) S TITLE(2.5)=$$CENTER^SPNLRU(SPNLTRM1)
 D P1(.TITLE,PAGELEN,.ABORT) Q:ABORT
 Q
P1(TITLE,PAGELEN,ABORT) ;
 N WARD,PAT,ZAD,ADMINFO,CURRLOS,FYTDLOS,ROOMBED,DIAG
 S TITLE(3)=$$CENTER^SPNLRU("Total Inpatients:  "_+$G(^TMP("SPN",$J,"CI")))
 S TITLE(4)=""
 ;          "         1         2         3         4         5         6         7         8"
 S TITLE(5)="                               Last                       Admission  Curr   FYTD"
 S TITLE(6)="Name                           Four   Ward                   Date     LOS    LOS"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S WARD=""
 F  S WARD=$O(^TMP("SPN",$J,"CI",WARD)) Q:WARD=""  D  Q:ABORT
 . S PAT=""
 . F  S PAT=$O(^TMP("SPN",$J,"CI",WARD,PAT)) Q:PAT=""  D  Q:ABORT
 . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . S ADMINFO=^TMP("SPN",$J,"CI",WARD,PAT)
 . . S ZAD=$P(ADMINFO,U,1)
 . . S CURRLOS=$P(ADMINFO,U,2)
 . . S FYTDLOS=$P(ADMINFO,U,3)
 . . S ROOMBED=$P(ADMINFO,U,4)
 . . S DIAG=$P(ADMINFO,U,5)
 . . W !,$P(PAT,U,1),?31,$P(PAT,U,2),?38,$E(WARD,1,20)
 . . W ?59,$E(ZAD,4,5)_"/"_$E(ZAD,6,7)_"/"_$E(ZAD,2,3)
 . . W ?68,$J($FN(CURRLOS,","),5),?75,$J($FN(FYTDLOS,","),5)
 . . W !,?5,"Adm dx: ",$E(DIAG,1,24),?38,"Room-Bed: ",ROOMBED
 . . Q
 . Q
 Q
