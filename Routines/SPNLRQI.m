SPNLRQI ;ISC-SF/GB-SCD (SPECIFIC) IP/OP REPORT (PRINT IP) ;6/23/95  12:01
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
P1(TITLE,PAGELEN,QLIST,ABORT) ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR,PNAME,PSSN,PID,PDATA
 S TITLE(5)=""
 S BSNR="" ; create list in bed section name order
 F  S BSNR=$O(QLIST("BS",BSNR)) Q:BSNR=""  D
 . S BS(QLIST("BS",BSNR))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D  Q:ABORT
 . S TITLE(6)=$$CENTER^SPNLRU(BSNAME)
 . ; TITLE(8)="         1         2         3         4         5         6         7         8"
 . S TITLE(8)=""
 . S TITLE(9)="Patient Name                        SSN              Stays         Days"
 . S BSNR=BS(BSNAME)
 . S NPATS=+$G(^TMP("SPN",$J,"IP","BS",BSNR))
 . S STAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))
 . S DAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))
 . S TITLE(7)=$$PAD^SPNLRU("Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s"),45)_$J($FN(STAYS,","),13)_$J($FN(DAYS,","),13)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K TITLE(7)
 . S PID=""
 . F  S PID=$O(^TMP("SPN",$J,"IP","BS",BSNR,"PID",PID)) Q:PID=""  D  Q:ABORT
 . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . S PNAME=$P(PID,U,1),PSSN=$P(PID,U,2)
 . . S PDATA=^TMP("SPN",$J,"IP","BS",BSNR,"PID",PID)
 . . S STAYS=$P(PDATA,U,1),DAYS=$P(PDATA,U,2)
 . . W !,PNAME,?32,PSSN,?45,$J($FN(STAYS,","),12),$J($FN(DAYS,","),13)
 K TITLE(5),TITLE(6),TITLE(8),TITLE(9)
 Q
P2(TITLE,PAGELEN,QLIST,ABORT) ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR
 S TITLE(5)=""
 S TITLE(6)="Specialty                            Patients       Stays       Days"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S BSNR="" ; create list in bed section name order
 F  S BSNR=$O(QLIST("BS",BSNR)) Q:BSNR=""  D
 . S BS(QLIST("BS",BSNR))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D  Q:ABORT
 . S BSNR=BS(BSNAME)
 . S NPATS=+$G(^TMP("SPN",$J,"IP","BS",BSNR))
 . S STAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))
 . S DAYS=+$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))
 . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . W !,BSNAME,?33,$J($FN(NPATS,","),11),?45,$J($FN(STAYS,","),11),$J($FN(DAYS,","),12)
 K TITLE(5),TITLE(6)
 Q
