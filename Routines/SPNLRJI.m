SPNLRJI ;ISC-SF/GB-SCD IP/OP REPORT (PRINT IP) ;6/23/95  11:57
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
INPAT(TITLE,PAGELEN,HIUSERS,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 S TITLE(3)=$$CENTER^SPNLRU("Inpatient Activity")
 D PIP1 Q:ABORT
 D PIP2 Q:ABORT
 I HIUSERS D
 . D PIP3 Q:ABORT
 . D PIP4
 Q
PIP1 ;
 ; ADM       Number of admissions (stays)
 N ADM,OUT,LINE,STARTLIN,COL,NPATS,DAYS
 S TITLE(5)=""
 S NPATS=+$G(^TMP("SPN",$J,"IP","PAT"))
 S ADM=+$G(^TMP("SPN",$J,"IP","ADM"))
 S DAYS=+$G(^TMP("SPN",$J,"IP","DAYS"))
 S TITLE(6)=$$CENTER^SPNLRU("Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_" for "_$FN(ADM,",")_" stay"_$S(ADM=1:"",1:"s")_" and "_$FN(DAYS,",")_" day"_$S(DAYS=1:"",1:"s")_" inpatient care")
 S ADM=+$O(^TMP("SPN",$J,"IP","ADM","PAT",""))
 F  D  Q:ADM=""!(ABORT)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K OUT,TITLE(5),TITLE(6)
 . S STARTLIN=$Y
 . S OUT(STARTLIN+1)=""
 . F COL=1:1:3 D  Q:ADM=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"    Patients    Stays     "
 . . F LINE=STARTLIN+2:1:PAGELEN D  Q:ADM=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$J($FN($G(^TMP("SPN",$J,"IP","ADM","PAT",ADM)),","),11)_$J($FN(ADM,","),9)_"      "
 . . . S ADM=$O(^TMP("SPN",$J,"IP","ADM","PAT",ADM))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . W !,OUT(LINE)
 Q
PIP2 ;
 ; BS        Bed Section Array
 ; BSNAME    Bed Section Name
 ; BSNR      Bed Section Number
 ; DAYS      Number of days spent in a bed section
 ; NPATS     Number of patients
 ; STAYS     Number of stays in a bed section
 N STAYS,BSNAME,NPATS,DAYS,BS,BSNR
 S TITLE(5)=""
 S TITLE(6)=$$CENTER^SPNLRU("Median Length of Stay (MLOS):  "_$FN($$MEDIAN^SPNLRU($G(^TMP("SPN",$J,"IP","ADM")),"^TMP(""SPN"","_$J_",""IP"",""ADM"",""DAYS"","),",",1)_" days")
 ; TITLE(5)="         1         2         3         4         5         6         7         8"
 S TITLE(7)=""
 S TITLE(8)="Specialty                            Patients       Stays       Days       MLOS"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S BSNR="" ; set up to print bed sections in name order
 F  S BSNR=$O(^TMP("SPN",$J,"IP","BS",BSNR)) Q:BSNR=""  D
 . S BS(^TMP("SPN",$J,"IP","BS",BSNR,"NAME"))=BSNR
 S BSNAME=""
 F  S BSNAME=$O(BS(BSNAME)) Q:BSNAME=""  D  Q:ABORT
 . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . S BSNR=BS(BSNAME)
 . S NPATS=^TMP("SPN",$J,"IP","BS",BSNR)
 . S STAYS=^TMP("SPN",$J,"IP","BS",BSNR,"STAYS")
 . S DAYS=^TMP("SPN",$J,"IP","BS",BSNR,"DAYS")
 . W !,BSNAME,?35,$J($FN(NPATS,","),9),?50,$J($FN(STAYS,","),7),?60,$J($FN(DAYS,","),8),?70,$J($$MEDIAN^SPNLRU(STAYS,"^TMP(""SPN"","_$J_",""IP"",""BS"","""_BSNR_""",""DAYS"","),9,1)
 K TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
PIP3 ;
 ; ADM       Number of admissions (stays)
 ; DAYS      Number of days for these admissions
 ; I         High User Counter
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N ADM,I,DAYS,PID,PNAME,PSSN
 S TITLE(5)=""
 S TITLE(6)=$$CENTER^SPNLRU("Highest Number of Stays")
 S TITLE(7)=""
 S TITLE(8)="Patient Name                        SSN            Stays           Days"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S ADM=""
 F I=1:1:HIUSERS S ADM=$O(^TMP("SPN",$J,"IP","HI","H1",ADM)) Q:ADM=""  D  Q:ABORT
 . S DAYS=""
 . F  S DAYS=$O(^TMP("SPN",$J,"IP","HI","H1",ADM,DAYS)) Q:DAYS=""  D  Q:ABORT
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"IP","HI","H1",ADM,DAYS,PID)) Q:PID=""  D  Q:ABORT
 . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . W !,PNAME,?32,PSSN,?45,$J($FN(-ADM,","),10),?60,$J($FN(-DAYS,","),11)
 K TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
PIP4 ;
 N ADM,I,DAYS,PID,PNAME,PSSN
 S TITLE(5)=""
 S TITLE(6)=$$CENTER^SPNLRU("Highest Number of Days")
 S TITLE(7)=""
 S TITLE(8)="Patient Name                        SSN             Days          Stays"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S DAYS=""
 F I=1:1:HIUSERS S DAYS=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS)) Q:DAYS=""  D  Q:ABORT
 . S ADM=""
 . F  S ADM=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS,ADM)) Q:ADM=""  D  Q:ABORT
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"IP","HI","H2",DAYS,ADM,PID)) Q:PID=""  D  Q:ABORT
 . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . W !,PNAME,?32,PSSN,?45,$J($FN(-DAYS,","),11),?60,$J($FN(-ADM,","),10)
 K TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
