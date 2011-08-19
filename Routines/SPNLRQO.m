SPNLRQO ;ISC-SF/GB-SCD (SPECIFIC) IP/OP REPORT (PRINT OP) ;6/23/95  12:01
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
P1(TITLE,PAGELEN,QLIST,ABORT) ;
 ; SCNAME    Clinic Stop Name
 ; SCNUM     Clinic Stop Number
 ; STOPS     Number of stops at a Clinic Stop
 ; NPATS     Number of patients
 ; VISITS    Number of visits to a Clinic Stop
 N VISITS,SCNAME,NPATS,STOPS,SCNUM,PNAME,PSSN,PID,PDATA
 S TITLE(5)=""
 S SCNUM="" ; list clinics in stop code number order
 F  S SCNUM=$O(QLIST("SC",SCNUM)) Q:SCNUM=""  D  Q:ABORT
 . S SCNAME=QLIST("SC",SCNUM)
 . S TITLE(6)=$$CENTER^SPNLRU(SCNUM_". "_SCNAME)
 . ; TITLE(8)="         1         2         3         4         5         6         7         8"
 . S TITLE(8)=""
 . S TITLE(9)="Patient Name                        SSN              Visits         Stops"
 . S NPATS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM))
 . S VISITS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))
 . S STOPS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))
 . S TITLE(7)=$$PAD^SPNLRU("Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s"),45)_$J($FN(VISITS,",",2),14)_$J($FN(STOPS,","),14)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K TITLE(7)
 . S PID=""
 . F  S PID=$O(^TMP("SPN",$J,"OP","SC",SCNUM,"PID",PID)) Q:PID=""  D  Q:ABORT
 . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . S PNAME=$P(PID,U,1),PSSN=$P(PID,U,2)
 . . S PDATA=^TMP("SPN",$J,"OP","SC",SCNUM,"PID",PID)
 . . S VISITS=+$P(PDATA,U,1),STOPS=+$P(PDATA,U,2)
 . . W !,PNAME,?32,PSSN,?45,$J($FN(VISITS,",",2),13),$J($FN(STOPS,","),14)
 K TITLE(5),TITLE(6),TITLE(8),TITLE(9)
 Q
P2(TITLE,PAGELEN,QLIST,ABORT) ;
 ; SCNAME    Clinic Stop Name
 ; SCNUM     Clinic Stop Number
 ; STOPS     Number of stops at a Clinic Stop
 ; NPATS     Number of patients
 ; VISITS    Number of visits to a Clinic Stop
 N VISITS,SCNAME,NPATS,STOPS,SC,SCNUM
 S TITLE(5)=""
 S TITLE(6)="Clinic                                    Patients       Visits       Stops"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S SCNUM="" ; list clinics in stop code number order
 F  S SCNUM=$O(QLIST("SC",SCNUM)) Q:SCNUM=""  D  Q:ABORT
 . S SCNAME=QLIST("SC",SCNUM)
 . S NPATS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM))
 . S VISITS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))
 . S STOPS=+$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))
 . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . W !,$J(SCNUM,3),". ",SCNAME,?38,$J($FN(NPATS,","),11),?50,$J($FN(VISITS,",",2),12),$J($FN(STOPS,","),12)
 K TITLE(5),TITLE(6)
 Q
