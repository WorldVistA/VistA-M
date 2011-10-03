SPNLGECH ; ISC-SF/GMB - SCD GATHER LAB TEST (GENERAL) DATA;11 MAY 94 [ 07/06/94  9:57 AM ] ;6/23/95  11:18
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N LFN,LASTDATE,TESTDATE,TESTNR,VALUE,REALDATE,YYY,MM,TESTNAME,TESTCOST
 S LFN=+$P($G(^DPT(DFN,"LR")),U,1) ; Internal entry number in LAB DATA file
 Q:'LFN
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; We change the days in the dates, because we track only whole months'
 ; worth of data.
 S FDATE=$E(FDATE,1,5)_"01"
 S TDATE=$E(TDATE,1,5)_"31"
 ; We are interested in any lab test administered within the 'from' and
 ; 'thru' date range.  The record numbers are date/time (of test),
 ; subtracted from 9999999.  This causes the tests to be listed in order
 ; from most recent to oldest.  So we must modify our from & to dates.
 K ^TMP("SPN",$J,"CH")
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1) ; for each test date in the range
 F  S TESTDATE=$O(^LR(LFN,"CH",TESTDATE)) Q:TESTDATE'>0!(TESTDATE>LASTDATE)  D
 . S REALDATE=9999999-TESTDATE\1
 . S YYY=$E(REALDATE,1,3)
 . S MM=+$E(REALDATE,4,5)
 . S TESTNR=1 ; for each test on that date
 . ; we start after 1 because the first two (0,1) nodes we ignore.
 . ; Each node thereafter is for a specific test.
 . F  S TESTNR=$O(^LR(LFN,"CH",TESTDATE,TESTNR)) Q:TESTNR'>0  D
 . . S VALUE=$G(^LR(LFN,"CH",TESTDATE,TESTNR))
 . . ; make sure the test wasn't cancelled
 . . I VALUE=""!(VALUE["canc")!(VALUE["CANC") Q
 . . ; now we increment a count of the number of times this test was
 . . ; given in this month of this year
 . . S $P(^(YYY),U,MM)=$P($G(^TMP("SPN",$J,"CH",TESTNR,YYY)),U,MM)+1
 S TESTNR=""
 F  S TESTNR=$O(^TMP("SPN",$J,"CH",TESTNR)) Q:TESTNR=""  D
 . ; Get the name from the DD.  Is there a better way?
 . ; If the name is so firm, why are we sending it?
 . S TESTNAME=$P($G(^DD(63.04,TESTNR,0)),U,1)
 . ; We might also use $O(^LAB(60,"B",TESTNAME,0)) in the following...
 . ; I think either should work fine.
 . S TESTCOST=$P($G(^LAB(60,+$O(^LAB(60,"C","CH;"_TESTNR_";1",0)),0)),U,11)
 . S YYY=""
 . F  S YYY=$O(^TMP("SPN",$J,"CH",TESTNR,YYY)) Q:YYY=""  D
 . . D ADDREC^SPNLGE("CH",YYY_"0000"_"^"_TESTNAME_"^"_TESTNR_"^"_TESTCOST_"^"_^TMP("SPN",$J,"CH",TESTNR,YYY))
 K ^TMP("SPN",$J,"CH")
 Q
