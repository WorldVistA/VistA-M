SPNLRK1 ;ISC-SF/GB-SCD LAB TEST UTILIZATION REPORT (PART 1 OF 1) ;4 JUNE 94 [ 08/23/94  10:03 AM ]
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
P1(TITLE,PAGELEN,ABORT) ;
 ; NDTESTS   Number of different lab tests
 ; TESTNR    Type of Lab test (lab test number)
 ; ORDERS    Number of orders places
 N NDTESTS,TESTNR,OUT,LINE,STARTLIN,COL,ORDERS,NPATS,RESULTS
 S TITLE(4)=""
 S ORDERS=+$G(^TMP("SPN",$J,"CH","ORDERS"))
 S RESULTS=+$G(^TMP("SPN",$J,"CH","RESULTS"))
 S NPATS=+$G(^TMP("SPN",$J,"CH","PAT"))
 S TITLE(5)=$$CENTER^SPNLRU("Totals:  "_$FN(ORDERS,",")_" order"_$S(ORDERS=1:"",1:"s")_" placed ("_$FN(RESULTS,",")_" result"_$S(RESULTS=1:"",1:"s")_" reported) for "_$FN(NPATS,",")_" patient"_$S(NPATS=1:"",1:"s"))
 S TESTNR=""
 F NDTESTS=0:1 S TESTNR=$O(^TMP("SPN",$J,"CH","TEST",TESTNR)) Q:TESTNR=""
 S:NDTESTS=1&(RESULTS>1) TITLE(6)=$$CENTER^SPNLRU("(This includes just one type of lab test)")
 S:NDTESTS>1 TITLE(6)=$$CENTER^SPNLRU("(These include "_$FN(NDTESTS,",")_" different lab tests)")
 S ORDERS=+$O(^TMP("SPN",$J,"CH","ORDERS",""))
 F  D  Q:ORDERS=""!(ABORT)
 . D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . K OUT,TITLE(4),TITLE(5),TITLE(6)
 . S STARTLIN=$Y
 . S OUT(STARTLIN+1)=""
 . F COL=1:1:3 D  Q:ORDERS=""
 . . S OUT(STARTLIN)=$G(OUT(STARTLIN))_"   Patients     Orders    "
 . . F LINE=STARTLIN+2:1:PAGELEN D  Q:ORDERS=""
 . . . S OUT(LINE)=$G(OUT(LINE))_$J($FN($G(^TMP("SPN",$J,"CH","ORDERS",ORDERS)),","),10)_$J($FN(-ORDERS,","),11)_"     "
 . . . S ORDERS=$O(^TMP("SPN",$J,"CH","ORDERS",ORDERS))
 . S LINE=""
 . F  S LINE=$O(OUT(LINE)) Q:LINE=""  D
 . . W !,OUT(LINE)
 Q
P2(TITLE,PAGELEN,QLIST,ABORT) ;
 N NPATS,TESTNR,RESULTS,MAXPATS,MAXTESTS,NAME
 S TITLE(4)=""
 S TITLE(5)=$$CENTER^SPNLRU("Lab Tests with "_$FN(QLIST("MIN"),",")_" or more Results")
 S TITLE(6)=""
 ; TITLE(5)="         1         2         3         4         5         6         7         8"
 S TITLE(7)="                                                                  Max # Results"
 S TITLE(8)="Lab Test                                Results      Patients      (# patients)"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S TESTNR=""
 F  S TESTNR=$O(^TMP("SPN",$J,"CH","TEST",TESTNR)) Q:TESTNR=""  D
 . S RESULTS=^TMP("SPN",$J,"CH","TEST",TESTNR)
 . Q:RESULTS<QLIST("MIN")
 . S NPATS=^TMP("SPN",$J,"CH","TEST",TESTNR,"PAT")
 . S NAME=^TMP("SPN",$J,"CH","TEST",TESTNR,"NAME")
 . S ^TMP("SPN",$J,"CH","OUT",-RESULTS,-NPATS,NAME)=TESTNR
 S RESULTS=""
 F  S RESULTS=$O(^TMP("SPN",$J,"CH","OUT",RESULTS)) Q:RESULTS=""  D  Q:ABORT
 . S NPATS=""
 . F  S NPATS=$O(^TMP("SPN",$J,"CH","OUT",RESULTS,NPATS)) Q:NPATS=""  D  Q:ABORT
 . . S NAME=""
 . . F  S NAME=$O(^TMP("SPN",$J,"CH","OUT",RESULTS,NPATS,NAME)) Q:NAME=""  D  Q:ABORT
 . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . S TESTNR=^TMP("SPN",$J,"CH","OUT",RESULTS,NPATS,NAME)
 . . . S MAXTESTS=$O(^TMP("SPN",$J,"CH","TEST",TESTNR,"RESULTS",""))
 . . . S MAXPATS=^TMP("SPN",$J,"CH","TEST",TESTNR,"RESULTS",MAXTESTS)
 . . . W !,NAME,?35,$J($FN(-RESULTS,","),11),?50,$J($FN(-NPATS,","),10)
 . . . I RESULTS'=NPATS&(-RESULTS>1)&(-NPATS>1) W ?65,$J(-MAXTESTS,8)," (",MAXPATS,")"
 . . . ; See what IMRWRBP does here for national report.
 K ^TMP("SPN",$J,"CH","OUT"),TITLE(5),TITLE(6),TITLE(7),TITLE(8)
 Q
P3(TITLE,PAGELEN,HIUSERS,ABORT) ;
 ; I         High user counter
 ; PID       Patient ID (Coded SSN)
 ; PNAME     Patient Name
 ; PSSN      Patient SSN
 N RESULTS,NDTESTS,PID,PNAME,PSSN,I,ORDERS
 ; TITLE(6)="         1         2         3         4         5         6         7         8"
 S TITLE(6)="                                                                       Different"
 S TITLE(7)="Patient Name                        SSN       Orders      Results      Lab Tests"
 D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 S ORDERS=""
 F I=1:1:HIUSERS S ORDERS=$O(^TMP("SPN",$J,"CH","HI","H1",ORDERS)) Q:ORDERS=""  D  Q:ABORT
 . S RESULTS=""
 . F  S RESULTS=$O(^TMP("SPN",$J,"CH","HI","H1",ORDERS,RESULTS)) Q:RESULTS=""  D  Q:ABORT
 . . S NDTESTS=""
 . . F  S NDTESTS=$O(^TMP("SPN",$J,"CH","HI","H1",ORDERS,RESULTS,NDTESTS)) Q:NDTESTS=""  D  Q:ABORT
 . . . S PID=""
 . . . F  S PID=$O(^TMP("SPN",$J,"CH","HI","H1",ORDERS,RESULTS,NDTESTS,PID)) Q:PID=""  D  Q:ABORT
 . . . . I $Y>PAGELEN D HEADER^SPNLRU(.TITLE,.ABORT) Q:ABORT
 . . . . D GETNAME^SPNLRU(PID,.PNAME,.PSSN)
 . . . . W !,PNAME,?32,PSSN,?45,$J($FN(-ORDERS,","),6),?55,$J($FN(-RESULTS,","),9),?70,$J(-NDTESTS,8)
 Q
