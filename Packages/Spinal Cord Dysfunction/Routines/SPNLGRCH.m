SPNLGRCH ; ISC-SF/GMB - SCD GATHER LAB TEST (GENERAL) DATA;19 MAY 94 [ 08/23/94  10:03 AM ] ;6/23/95  11:33
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
ROLLUP(DFN,FDATE,TDATE,HI) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"CH",
 ; with the following nodes:
 ; "PAT")                  # patients with at least 1 order
 ; "ORDERS")               # orders
 ; "ORDERS",-orders)       # patients who had this many orders
 ; "RESULTS")              # test results
 ; "RESULTS",-results)     # patients who had this many test results
 ; "TEST",testnr)          # results for this test
 ; "TEST",testnr,"NAME")   the name of the test
 ; "TEST",testnr,"PAT")    # patients who had this test
 ; "TEST",testnr,"RESULTS",-results) # patients who had this many results for this test
 ; ... and usage by individual patient
 ; "HI","H1",-orders,-results,-diff tests,DFN)
 N LFN,LASTDATE,TESTDATE,TESTNR,VALUE,ORDERS
 N TRESULTS,RESULTS,TEST,NDTESTS
 S LFN=+$P($G(^DPT(DFN,"LR")),U,1) ; Internal entry number in LAB DATA file
 Q:'LFN
 I '$D(TDATE) S TDATE=DT
 ; We are interested in any lab test administered within the 'from' and
 ; 'thru' date range.  The record numbers are date/time (of test),
 ; subtracted from 9999999.  This causes the tests to be listed in order
 ; from most recent to oldest.  So we must modify our from & to dates.
 S (ORDERS,TRESULTS)=0
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1) ; for each test date in the range
 F  S TESTDATE=$O(^LR(LFN,"CH",TESTDATE)) Q:TESTDATE'>0!(TESTDATE>LASTDATE)  D
 . S RESULTS=0
 . S TESTNR=1 ; for each test on that date
 . ; we start after 1 because the first two (0,1) nodes we ignore.
 . ; Each node thereafter is for a specific test.
 . F  S TESTNR=$O(^LR(LFN,"CH",TESTDATE,TESTNR)) Q:TESTNR'>0  D
 . . S VALUE=$G(^LR(LFN,"CH",TESTDATE,TESTNR))
 . . ; make sure the test wasn't cancelled
 . . I VALUE=""!(VALUE["canc")!(VALUE["CANC") Q
 . . S TEST(TESTNR)=$G(TEST(TESTNR))+1 ; number results for this test
 . . S RESULTS=RESULTS+1
 . Q:RESULTS=0
 . S TRESULTS=TRESULTS+RESULTS
 . S ORDERS=ORDERS+1
 Q:ORDERS=0
 S ^(-ORDERS)=$G(^TMP("SPN",$J,"CH","ORDERS",-ORDERS))+1
 S ^("PAT")=$G(^TMP("SPN",$J,"CH","PAT"))+1
 S ^("RESULTS")=$G(^TMP("SPN",$J,"CH","RESULTS"))+TRESULTS
 S ^(-TRESULTS)=$G(^TMP("SPN",$J,"CH","RESULTS",-TRESULTS))+1
 S ^("ORDERS")=$G(^TMP("SPN",$J,"CH","ORDERS"))+ORDERS
 S TESTNR="",NDTESTS=0
 F  S TESTNR=$O(TEST(TESTNR)) Q:TESTNR=""  D
 . S NDTESTS=NDTESTS+1 ; number of different tests
 . S RESULTS=TEST(TESTNR)
 . S ^(TESTNR)=$G(^TMP("SPN",$J,"CH","TEST",TESTNR))+RESULTS
 . S ^("PAT")=$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"PAT"))+1
 . S ^(-RESULTS)=$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"RESULTS",-RESULTS))+1
 Q:'HI
 S ^TMP("SPN",$J,"CH","HI","H1",-ORDERS,-TRESULTS,-NDTESTS,DFN)=""
 Q
NAMEIT ;
 N TESTNR,TESTNAME
 S TESTNR=""
 F  S TESTNR=$O(^TMP("SPN",$J,"CH","TEST",TESTNR)) Q:TESTNR=""  D
 . ; Get the name from the DD.  Is there a better way?
 . S TESTNAME=$P($G(^DD(63.04,TESTNR,0)),U,1)
 . I TESTNAME="" S TESTNAME="Not Identified"
 . S ^TMP("SPN",$J,"CH","TEST",TESTNR,"NAME")=TESTNAME
 Q
