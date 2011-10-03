SPNLRJO ;ISC-SF/GB-SCD IP/OP REPORT (PRINT OP) ;4 JUNE 94 [ 08/08/94  12:37 PM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
OUTPAT(TITLE,PAGELEN,HIUSERS,ABORT) ;
 ; PAGELEN   Number of lines per page
 ; TITLE     Array of header lines (titles)
 S TITLE(3)=$$CENTER^SPNLRU("Outpatient Activity")
 D POP1 Q:ABORT
 D POP2 Q:ABORT
 D:HIUSERS POP3
 Q
POP1 ;
 ; VISITS    Number of visits
 N VISITS,OUT,LINE,STARTLIN,COL,STOPS,NPATS
 S TITLE(5)=""
 S NPATS=+$G(^TMP("SPN",$J,"OP","PAT"))
 S VISITS=+$G(^TMP("SPN",$J,"OP","VISITS"))
 S STOPS=+$G(^TMP("SPN",$J,"OP","STOPS"))
 S TITLE(6)=$$CENTER^SPNLRU("Totals:  "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s")_" for "_$FN(VISITS,",")_" visit"_$S(VISITS=1:"",1:"s")_" ("_$FN(STOPS,",")_" stop"_$S(STOPS=1:"",1:"s")_")")
 S VISITS=+$O(^TMP("SPN",$J,"OP","VISITS",""))
 F  D  Q:VISITS=""!(ABORT)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K OUT,TITLE(5),TITLE(6)
 . S STARTLIN=$Y
 . S OUT(STARTLIN+1)=""
 . F COL=1:1:3 D  Q:VISITS=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"    Patients    Visits    "
 . . F LINE=STARTLIN+2:1:PAGELEN D  Q:VISITS=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$J($FN($G(^TMP("SPN",$J,"OP","VISITS",VISITS)),","),11)_$J($FN(-VISITS,","),10)_"     "
 . . . S VISITS=$O(^TMP("SPN",$J,"OP","VISITS",VISITS))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . W !,OUT(LINE)
 Q
POP2 ;
 ; SCNUM     Clinic Stop Code Number
 ; SCNAME    Clinic Stop Code Name
 ; NPATS     Number of patients who stopped at this stop code
 ; VISITS    Number of visits made to this stop code
 ; STOPS     Number of stops made at this stop code
 N SCNUM,SCNAME,NPATS,STOPS,VISITS
 S TITLE(5)=""
 S TITLE(6)="Clinic                                       Patients       Visits        Stops"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S SCNUM=""
 F  S SCNUM=$O(^TMP("SPN",$J,"OP","SC",SCNUM)) Q:SCNUM=""  D  Q:ABORT
 . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . S NPATS=^TMP("SPN",$J,"OP","SC",SCNUM)
 . S STOPS=^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS")
 . S VISITS=^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS")
 . S SCNAME=^TMP("SPN",$J,"OP","SC",SCNUM,"NAME")
 . W !,$J(SCNUM,3),". ",SCNAME,?40,$J($FN(NPATS,","),13),$J($FN(VISITS,",",2),13),$J($FN(STOPS,","),13)
 K TITLE(5),TITLE(6)
 Q
POP3 ;
 ; I         High user counter
 ; PID       Patient ID
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 ; VISITS    Number of visits made to this stop code
 ; NDSCNUMS  Number of different stop codes
 N VISITS,PID,PNAME,PSSN,I,NDSCNUMS
 S TITLE(5)=""
 S TITLE(6)=$$CENTER^SPNLRU("Highest Utilization of Visits")
 S TITLE(7)=""
 S TITLE(8)="                                                                    Different"
 S TITLE(9)="Patient Name                        SSN               Visits       Stop Codes"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S VISITS=""
 F I=1:1:HIUSERS S VISITS=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS)) Q:VISITS=""  D  Q:ABORT
 . S NDSCNUMS=""
 . F  S NDSCNUMS=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS,NDSCNUMS)) Q:NDSCNUMS=""  D  Q:ABORT
 . . S PID=""
 . . F  S PID=$O(^TMP("SPN",$J,"OP","HI","H1",VISITS,NDSCNUMS,PID)) Q:PID=""  D  Q:ABORT
 . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . W !,PNAME,?32,PSSN,?53,$J($FN(-VISITS,","),6),?68,$J(-NDSCNUMS,5)
 K TITLE(5),TITLE(6),TITLE(7),TITLE(8),TITLE(9)
 Q
