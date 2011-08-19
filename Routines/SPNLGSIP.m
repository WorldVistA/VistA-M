SPNLGSIP ; ISC-SF/GMB - SCD GATHER (SPECIFIC) INPATIENT ADMISSIONS DATA;16 JUN 94 [ 07/11/94  10:48 AM ] ;6/23/95  11:46
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
SELECT(DFN,FDATE,TDATE,HI,QLIST) ;
 ; This entry point is to be used solely for selecting data to be used
 ; in a report.
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"IP",
 ; with the following nodes:
 ; "BS",bsnr)             # different patients in this bedsec
 ; "BS",bsnr,"DAYS")      # days in this bedsec
 ; "BS",bsnr,"STAYS")     # stays in this bedsec
 ; "BS",bsnr,"PID",patient name^SSN)  stays^days
 N RECNR,NODE0,NODE70,ZDD,ZAD,STAYS,DAYS,BSNR,PNAME,PSSN
 I '$D(TDATE) S TDATE=DT
 ; We will take all admissions which overlap the desired range, and adjust
 ; the admit and/or discharge dates to conform with the desired range.
 S RECNR=0 ; for each inpatient record
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S NODE0=$G(^DGPT(RECNR,0))
 . Q:$P(NODE0,U,11)'=1  ; 1=PTF record, 2=census record
 . S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$P(NODE70,U,1)\1 ; Discharge date
 . Q:ZDD'=0&(ZDD<FDATE)
 . S ZAD=$P(NODE0,U,2)\1 Q:ZAD>TDATE  ; Admit date
 . D BSMOVE
 Q:'$D(STAYS)
 D:HI GETNAME^SPNLRU(DFN,.PNAME,.PSSN)
 S BSNR="" ; for each bedsection stayed in
 F  S BSNR=$O(STAYS(BSNR)) Q:BSNR=""  D
 . S ^(BSNR)=$G(^TMP("SPN",$J,"IP","BS",BSNR))+1
 . S ^("STAYS")=$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))+STAYS(BSNR)
 . S ^("DAYS")=$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))+DAYS(BSNR)
 . S:HI ^TMP("SPN",$J,"IP","BS",BSNR,"PID",PNAME_U_PSSN)=STAYS(BSNR)_U_DAYS(BSNR)
 Q
BSMOVE ; Deal with inpatient bedsection movements.
 ; Completed movements (those with moveout dates) are in the "AM" index.
 N MOVEIN,MOVEOUT,MOVEDATE,SUBRECNR
 S MOVEOUT=ZAD
 S MOVEDATE=""
 F  S MOVEDATE=$O(^DGPT(RECNR,"M","AM",MOVEDATE)) Q:MOVEDATE'>0  D  Q:MOVEIN>TDATE
 . S MOVEIN=MOVEOUT
 . S MOVEOUT=MOVEDATE\1
 . Q:MOVEOUT<FDATE!(MOVEIN>TDATE)
 . S SUBRECNR=$O(^DGPT(RECNR,"M","AM",MOVEDATE,0))
 . D STAYS(SUBRECNR)
 ; The following could also be Q:ZDD'=""
 Q:$G(SUBRECNR)=1  ; The current (and last) bedsection is always in
 ; subrecord 1.  If we get past this Quit, then the patient is still in
 ; hospital and the current bedsection would not be in the "AM" index
 ; because the patient hasn't yet moved out.
 S MOVEIN=MOVEOUT
 S MOVEOUT=TDATE
 Q:MOVEIN>TDATE
 D STAYS(1)
 Q
STAYS(SUBRECNR) ;
 N BSDAYS,BSNR,X,X1,X2
 S BSNR=+$P($G(^DGPT(RECNR,"M",SUBRECNR,0)),U,2)
 Q:'$D(QLIST("BS",BSNR))
 S STAYS(BSNR)=$G(STAYS(BSNR))+1 ; # of stays in this bedsection
 S X2=$S(MOVEIN<FDATE:FDATE,1:MOVEIN)
 S X1=$S(MOVEOUT>TDATE:TDATE,1:MOVEOUT)
 D ^%DTC
 S BSDAYS=X+1
 S DAYS(BSNR)=$G(DAYS(BSNR))+BSDAYS ; # of days in this bedsection
 Q
