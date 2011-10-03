SPNLGRIP ; ISC-SF/GMB - SCD GATHER INPATIENT ADMISSIONS DATA;17 MAY 94 [ 07/11/94  10:21 AM ] ;6/23/95  12:10
 ;;2.0;Spinal Cord Dysfunction;**10**;01/02/1997
ROLLUP(DFN,FDATE,TDATE,HI) ;
 ; This entry point is to be used solely for rolling up data to be used
 ; in a report.
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"IP",
 ; with the following nodes:
 ; "PAT")                 # patients
 ; "DAYS")                # admit days
 ; "ADM")                 # admits
 ; "ADM","PAT",admits)    # patients with this many admits
 ; "ADM","DAYS",days)     # admits lasting this many days (for MLOS)
 ; "BS",bsnr)             # different patients in this bedsec
 ; "BS",bsnr,"NAME")      name of the bedsec
 ; "BS",bsnr,"DAYS")      # days in this bedsec
 ; "BS",bsnr,"STAYS")     # stays in this bedsec
 ; "BS",bsnr,"DAYS",days) # stays lasting this many days in this bedsec (for MLOS)
 ; "HI","H1",-admits,-days,DFN) track usage by individual patient,
 ;                        ranked by number of admits and admit days
 ; "HI","H2",-days,-admits,DFN) track usage by individual patient,
 ;                        ranked by number of admit days and admits
 N RECNR,NODE0,NODE70,ZDD,ZAD,BS,ADMDAYS,NUMADMS,BSNR,X,X1,X2
 I '$D(TDATE) S TDATE=DT
 ; We will take all admissions which overlap the desired range, and adjust
 ; the admit and/or discharge dates to conform with the desired range.
 S (ADMDAYS,NUMADMS,RECNR)=0 ; for each inpatient record
 F  S RECNR=$O(^DGPT("B",DFN,RECNR)) Q:RECNR=""  D
 . S NODE0=$G(^DGPT(RECNR,0))
 . Q:$P(NODE0,U,11)'=1  ; 1=PTF record, 2=census record
 . ;wde/line added below to block fee basis records in the count 2/18/99
 . I $P(NODE0,U,4)=1 Q
 . S NODE70=$G(^DGPT(RECNR,70))
 . S ZDD=$P(NODE70,U,1)\1 ; Discharge date
 . Q:ZDD'=0&(ZDD<FDATE)
 . S ZAD=$P(NODE0,U,2)\1 Q:ZAD>TDATE  ; Admit date
 . D ADMIT
 . D BSMOVE
 Q:NUMADMS=0
 S ^("PAT")=$G(^TMP("SPN",$J,"IP","PAT"))+1
 S ^("DAYS")=$G(^TMP("SPN",$J,"IP","DAYS"))+ADMDAYS
 S ^("ADM")=$G(^TMP("SPN",$J,"IP","ADM"))+NUMADMS
 S ^(NUMADMS)=$G(^TMP("SPN",$J,"IP","ADM","PAT",NUMADMS))+1
 S BSNR="" ; for each bedsection stayed in
 F  S BSNR=$O(BS(BSNR)) Q:BSNR=""  D
 . S ^(BSNR)=$G(^TMP("SPN",$J,"IP","BS",BSNR))+1
 . S ^("STAYS")=$G(^TMP("SPN",$J,"IP","BS",BSNR,"STAYS"))+BS(BSNR)
 Q:'HI
 S ^TMP("SPN",$J,"IP","HI","H1",-NUMADMS,-ADMDAYS,DFN)=""
 S ^TMP("SPN",$J,"IP","HI","H2",-ADMDAYS,-NUMADMS,DFN)=""
 Q
ADMIT ;  deal with inpatient admission data
 ; Figure out length, in days, of adjusted (if necessary) admission
 S X2=$S(ZAD<FDATE:FDATE,1:ZAD)
 S X1=$S(ZDD>TDATE:TDATE,ZDD=0:TDATE,1:ZDD)
 D ^%DTC
 S ^(X+1)=$G(^TMP("SPN",$J,"IP","ADM","DAYS",X+1))+1
 S ADMDAYS=ADMDAYS+X+1 ; total admit days
 S NUMADMS=NUMADMS+1 ; number of admissions
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
 . D BS(SUBRECNR)
 ; The following could also be Q:ZDD'=""
 Q:$G(SUBRECNR)=1  ; The current (and last) bedsection is always in
 ; subrecord 1.  If we get past this Quit, then the patient is still in
 ; hospital and the current bedsection would not be in the "AM" index
 ; because the patient hasn't yet moved out.
 S MOVEIN=MOVEOUT
 S MOVEOUT=TDATE
 Q:MOVEIN>TDATE
 D BS(1)
 Q
BS(SUBRECNR) ;
 N BSDAYS,BSNR
 S X2=$S(MOVEIN<FDATE:FDATE,1:MOVEIN)
 S X1=$S(MOVEOUT>TDATE:TDATE,1:MOVEOUT)
 D ^%DTC
 S BSDAYS=X+1
 S BSNR=+$P($G(^DGPT(RECNR,"M",SUBRECNR,0)),U,2)
 S BS(BSNR)=$G(BS(BSNR))+1 ; number of stays in this bedsection
 S ^("DAYS")=$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS"))+BSDAYS
 S ^(BSDAYS)=$G(^TMP("SPN",$J,"IP","BS",BSNR,"DAYS",BSDAYS))+1
 Q
NAMEIT ;
 N BSNR,BSNAME
 S BSNR=""
 F  S BSNR=$O(^TMP("SPN",$J,"IP","BS",BSNR)) Q:BSNR=""  D
 . S BSNAME=$P($G(^DIC(42.4,BSNR,0)),U,1)
 . S:BSNAME="" BSNAME="Not Identified"
 . S ^TMP("SPN",$J,"IP","BS",BSNR,"NAME")=BSNAME
 Q
