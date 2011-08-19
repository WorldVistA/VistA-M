SPNJRPC1 ;BP/JAS - Returns list of patients with their date last seen ;JUL 22, 2008
 ;;3.0;Spinal Cord Dysfunction;;OCT 01, 2006;Build 39
 ;
 ; Reference to ^DPT(D0,"LR" supported by IA #998
 ; References to file #45 supported by IA #92
 ; Reference to ^LR(D0,"CH" supported by IA #554
 ; Reference to ^PS(55,D0,"P","A" supported by IA #552
 ; Reference to ^RADPT(D0,"DT" supported by IA #3125
 ; Reference to API DEM^VADPT supported by IA #10061
 ; Reference to API SDA^VADPT supported by IA #10061
 ; Reference to API RX^PSO52API supported by IA #4820
 ; Reference to API $$FMTE^XLFDT supported by IA #10103
 ; API $$DATEMATH^SPNLRUDT is part of Spinal Cord Version 2.0
 ; API $$FLIP^SPNRPCIC is part of Spinal Cord Version 3.0
 ;
 ; Parm values:
 ;     ICNLST is the list of patient ICNs to process
 ;     CUTDATE: is the earliest date to search to for services 
 ;     RETURN: is the sorted data from the earliest date of listing
 ;     DAYS: is the range of days that a patient hasn't been seen
 ;
 ; ^TMP($J) returns:
 ;     LAST SEEN DATE ^ PATIENT NAME ^ SSN(LAST FOUR) ^ EOL999
 ;
COL(RETURN,ICNLST,DAYS) ;
 ;***************************
 K ^TMP($J),^UTILITY("VASD",$J)
 S RETURN=$NA(^TMP($J))
 S DAYS=DAYS_"D"
 S SINCE=$$DATEMATH^SPNLRUDT(DT,"-"_DAYS)
 S YRS="6Y"
 S CUTDATE=$$DATEMATH^SPNLRUDT(DT,"-"_YRS)
 ;***************************
 S ICNNM=""
 F  S ICNNM=$O(ICNLST(ICNNM)) Q:ICNNM=""  D
 . S ICN=ICNLST(ICNNM) D IN
 D CLNUP
 Q
IN Q:$G(ICN)=""
 S DFN=$$FLIP^SPNRPCIC(ICN)
 Q:$G(DFN)=""
 ;***************************
 D DEM^VADPT
 S NAME=VADM(1),SSNLAST4=VA("BID")
 D SEEN(DFN,CUTDATE,DT,.SEEN,.LASTSEEN)
 S LASTDTE=$$FMTE^XLFDT(LASTSEEN,"5DZP")
 I LASTDTE=0 S LASTDTE="**Not Seen in 6 Years**"
 I LASTSEEN<CUTDATE S LASTDTE="**Not Seen in 6 Years**"
 I LASTSEEN<SINCE S ^TMP($J,NAME,ICNNM)=LASTDTE_"^"_NAME_"^"_SSNLAST4_"^EOL999"
 Q
 ;;;
SEEN(DFN,FDATE,TDATE,SEEN,LASTSEEN)  ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; During the time period FDATE thru TDATE,
 ; SEEN      (1/0) patient was (not) seen
 ; LASTSEEN  Date patient was last seen
 ; SEENIP    (1/0) patient was (not) seen as an inpatient
 ; SEENOP    (1/0) patient was (not) seen as an outpatient 
 ; SEENCH    (1/0) patient was (not) seen for a lab test
 ; SEENRX    (1/0) patient was (not) seen in pharmacy
 ; SEENRA    (1/0) patient was (not) seen in radiology
 N LASTIP,LASTOP,LASTCH,LASTRX,LASTRA
 I '$D(TDATE) S TDATE=DT
 S LASTSEEN=0
 D IP(.SEENIP,.LASTIP)
 I SEENIP,(LASTIP>LASTSEEN) S LASTSEEN=LASTIP
 D OP(.SEENOP,.LASTOP)
 I SEENOP,(LASTOP>LASTSEEN) S LASTSEEN=LASTOP
 D CH(.SEENCH,.LASTCH)
 I SEENCH,(LASTCH>LASTSEEN) S LASTSEEN=LASTCH
 D RX(.SEENRX,.LASTRX)
 I SEENRX,(LASTRX>LASTSEEN) S LASTSEEN=LASTRX
 D RA(.SEENRA,.LASTRA)
 I SEENRA,(LASTRA>LASTSEEN) S LASTSEEN=LASTRA
 S SEEN=(SEENIP)!(SEENOP)!(SEENCH)!(SEENRX)!(SEENRA)
 Q
IP(SEEN,LASTSEEN) ;
 N RECNR,RTYP,ZDD,ZAD
 S LASTSEEN=0
 ; We will take all admissions which overlap the desired range, and adjust
 ; the admit and/or discharge dates to conform with the desired range.
 S RECNR=0 ; for each inpatient record
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S RTYP=$$GET1^DIQ(45,RECNR_",",11,"I")
 . Q:RTYP'=1   ; 1=PTF record, 2=census record
 . S ZDD=$$GET1^DIQ(45,RECNR_",",70,"I")\1   ; Discharge date
 . Q:ZDD'=0&(ZDD<FDATE)
 . S ZAD=$$GET1^DIQ(45,RECNR_",",2,"I")\1   ; Admit date
 . Q:ZAD>TDATE
 . S LASTSEEN=$S(ZDD>TDATE:TDATE,ZDD=0:TDATE,1:ZDD)
 S SEEN=$S(LASTSEEN=0:0,1:1)
 Q
OP(SEEN,LASTSEEN) ;
 N VASD,APPT,LASTAPPT
 S VASD("F")=FDATE,VASD("T")=TDATE D SDA^VADPT
 S (APPT,LASTAPPT)=0
 F  S APPT=$O(^UTILITY("VASD",$J,APPT)) Q:APPT=""  D
 . S LASTAPPT=APPT
 I LASTAPPT=0 D
 . S (SEEN,LASTSEEN)=0
 E  D
 . S LASTSEEN=+^UTILITY("VASD",$J,LASTAPPT,"I")\1
 . S SEEN=1
 Q
CH(SEEN,LASTSEEN) ;
 N LFN,LASTDATE,TESTDATE
 S (SEEN,LASTSEEN)=0
 S LFN=+$P($G(^DPT(DFN,"LR")),U,1)
 Q:'LFN
 S LASTDATE=9999999-FDATE
 S TESTDATE=9999999-(TDATE+1)
 S TESTDATE=$O(^LR(LFN,"CH",TESTDATE))
 Q:TESTDATE'>0!(TESTDATE>LASTDATE)
 S LASTSEEN=9999999-TESTDATE\1
 S SEEN=1
 Q
RX(SEEN,LASTSEEN) ;
 N EXPDATE,RECNR,FILLDATE,SUBRECNR
 S LASTSEEN=0
 S EXPDATE=FDATE-.000001 ; For each expiration date
 F  S EXPDATE=$O(^PS(55,DFN,"P","A",EXPDATE)) Q:EXPDATE'>0  D
 . S RECNR=0 ; For each prescription on that date
 . F  S RECNR=$O(^PS(55,DFN,"P","A",EXPDATE,RECNR)) Q:RECNR'>0  D
 . . D RX^PSO52API(DFN,"PSRX",RECNR)
 . . S FILLDATE=$P(^TMP($J,"PSRX",DFN,RECNR,22),"^",1)
 . . Q:FILLDATE=""
 . . Q:FILLDATE>TDATE
 . . S:FILLDATE'<FDATE LASTSEEN=FILLDATE ; original fill
 . . S SUBRECNR=0 ; For each refill
 . . F  S SUBRECNR=$O(^TMP($J,"PSRX",DFN,RECNR,"RF",SUBRECNR)) Q:SUBRECNR=""  D  Q:FILLDATE>TDATE
 . . . S FILLDATE=$P(^TMP($J,"PSRX",DFN,RECNR,"RF",SUBRECNR,.01),"^",1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . S:FILLDATE>LASTSEEN LASTSEEN=FILLDATE
 . . K ^TMP($J,"PSRX")
 S SEEN=$S(LASTSEEN=0:0,1:1)
 Q
RA(SEEN,LASTSEEN) ;
 N LASTDATE,EXAMDATE
 S (SEEN,LASTSEEN)=0
 S LASTDATE=9999999.9999-FDATE
 S EXAMDATE=9999999.9999-(TDATE+1)
 S EXAMDATE=$O(^RADPT(DFN,"DT",EXAMDATE))
 Q:EXAMDATE'>0!(EXAMDATE>LASTDATE)
 S LASTSEEN=9999999.9999-EXAMDATE\1
 S SEEN=1
 Q
CLNUP ;
 K AICN,CUTDATE,I,ICN,ICNNM,LASTDTE,NAME,PATLIST,PATSTR
 K SEENCH,SEENIP,SEENOP,SEENRA,SEENRX,SINCE,SPN,SSNLAST4
 K VA,VADM,YRS
 Q
