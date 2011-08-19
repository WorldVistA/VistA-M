SPNPSR20 ; HIRMFO/JWR,WAA - HUNT LAB TEST; APR 1 96  11:44
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EN1(D0,FDATE,TDATE,ACTION,SEQUENCE) ;
 ; ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"LAB TEST",IEN)= LAB TEST
 ; D0       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; ACTION    ACTION TYPE
 ; SEQUENCE  SEQUENCE SORT ORDER
 N LFN,LASTDATE,TESTDATE,TESTNR,VALUE,TEST,RESULTS,PNAME,PSSN
 S LFN=+$P($G(^DPT(D0,"LR")),U,1) ; IEN in LAB DATA File
 S MEETSRCH=0 G:'LFN Q
 I '$D(TDATE) S TDATE=DT
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1) ; for each test date in the range
 F  S TESTDATE=$O(^LR(LFN,"CH",TESTDATE)) Q:TESTDATE'>0!(TESTDATE>LASTDATE)  D  Q:MEETSRCH=1
 . S TESTNR="" ; for each test we're interested in
 . F  S TESTNR=$O(QLIST(TESTNR)) Q:TESTNR=""  D  Q:MEETSRCH=1
 . . Q:'$D(^LR(LFN,"CH",TESTDATE,TESTNR))  ; was this test given?
 . . S VALUE=$G(^LR(LFN,"CH",TESTDATE,TESTNR))
 . . ; make sure the test wasn't cancelled
 . . I VALUE=""!(VALUE["canc")!(VALUE["CANC") Q
 . . S MEETSRCH=1 Q
Q Q MEETSRCH
 ;
EN2(ACTION,SEQUENCE) ; Prompt Entry Point
 N DIC,Y,DTOUT,DUOUT,LOC
 S SPNLEXIT=0
 I $$VFILE^DILFD(60)'>0 D  Q
 . W !!?5,"*** LABORATORY TEST file (#60) not found ***",$C(7)
 . Q
 S DIC("S")="I '$D(^LAB(60,+Y,2))"
 S DIC="60",DIC(0)="AEQMZ"
 S CN=0 F  D ^DIC Q:Y=-1  D
 . S LOC=$P(Y(0),U,5)
 . I LOC="" D  Q
 . . W !,"Sorry, can't use this test."
 . . W !,"LOCATION (DATA NAME) not defined in ^LAB(60.",!
 . S CN=CN+1
 . S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,"LAB TEST",CN)=Y
 . S QLIST($P(LOC,";",2))=$P(Y,U,2)
 . S DIC("A")="Another LABORATORY TEST NAME: "
 I $D(DTOUT)!($D(DUOUT))!('$D(^TMP($J,"SPNPRT",ACTION,SEQUENCE,"LAB TEST",1))) S SPNLEXIT=1
 I SPNLEXIT=1 K ^TMP($J,"SPNPRT",ACTION,SEQUENCE) Q
 S (BDATE,EDATE)=""
 D EN1^SPNPSR00(ACTION,SEQUENCE+.1,.BDATE,.EDATE)
 S ^TMP($J,"SPNPRT",ACTION,SEQUENCE,0)="$$EN1^SPNPSR20(D0,"_BDATE_","_EDATE_","""_ACTION_""","_SEQUENCE_")"
 Q
