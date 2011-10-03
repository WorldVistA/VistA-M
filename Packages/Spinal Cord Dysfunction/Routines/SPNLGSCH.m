SPNLGSCH ; ISC-SF/GMB - SCD GATHER LAB TEST (SPECIFIC) DATA;15 JUN 94 [ 07/12/94  6:05 AM ] ;6/23/95  11:44
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
SELECT(DFN,FDATE,TDATE,HI,QLIST) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"CH",
 ; with the following nodes:
 ; "TEST",testnr)          # results for this test
 ; "TEST",testnr,"NAME")   the name of the test
 ; "TEST",testnr,"PAT")    # patients who had this test
 ; "TEST",testnr,"PID",patient)    SSN^# results for this patient's test
 N LFN,LASTDATE,TESTDATE,TESTNR,VALUE,TEST,RESULTS,PNAME,PSSN
 S LFN=+$P($G(^DPT(DFN,"LR")),U,1) ; Internal entry number in LAB DATA file
 Q:'LFN
 I '$D(TDATE) S TDATE=DT
 ; We are interested in any lab test administered within the 'from' and
 ; 'thru' date range.  The record numbers are date/time (of test),
 ; subtracted from 9999999.  This causes the tests to be listed in order
 ; from most recent to oldest.  So we must modify our from & to dates.
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1) ; for each test date in the range
 F  S TESTDATE=$O(^LR(LFN,"CH",TESTDATE)) Q:TESTDATE'>0!(TESTDATE>LASTDATE)  D
 . ;S TESTNR=1                      ; for each test on that date
 . ;; we start after 1 because the first two (0,1) nodes we ignore.
 . ;; Each node thereafter is for a specific test.
 . ;F  S TESTNR=$O(^LR(LFN,"CH",TESTDATE,TESTNR)) Q:TESTNR'>0  D
 . ;. Q:'$D(QLIST(TESTNR))  ; make sure we want this test
 . S TESTNR="" ; for each test we're interested in
 . F  S TESTNR=$O(QLIST(TESTNR)) Q:TESTNR=""  D
 . . Q:'$D(^LR(LFN,"CH",TESTDATE,TESTNR))  ; was this test given?
 . . S VALUE=$G(^LR(LFN,"CH",TESTDATE,TESTNR))
 . . ; make sure the test wasn't cancelled
 . . I VALUE=""!(VALUE["canc")!(VALUE["CANC") Q
 . . S TEST(TESTNR)=$G(TEST(TESTNR))+1 ; number results for this test
 Q:'$D(TEST)
 D:HI GETNAME^SPNLRU(DFN,.PNAME,.PSSN)
 S TESTNR=""
 F  S TESTNR=$O(TEST(TESTNR)) Q:TESTNR=""  D
 . S RESULTS=TEST(TESTNR)
 . S ^(TESTNR)=$G(^TMP("SPN",$J,"CH","TEST",TESTNR))+RESULTS
 . S ^("PAT")=$G(^TMP("SPN",$J,"CH","TEST",TESTNR,"PAT"))+1
 . S:HI ^TMP("SPN",$J,"CH","TEST",TESTNR,"PID",PNAME_U_PSSN)=RESULTS
 Q
