SPNLGEUD ; ISC-SF/GMB - SCD GATHER UNIT DOSE DATA;11 MAY 94 [ 07/12/94  5:44 AM ] ;6/23/95  12:10
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N STRTDATE,STOPDATE,ORDERNUM,ZEROREC,TWOREC,SCHEDULE,RECNR,ZDRUGNAM
 N ZDRUGDOS,ZDRUGREC,SUBRECNR,LIMDOSE,MEDROUTE,ORDERTYP,SCHEDTYP
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; We are interested in any drug whose 'stop date' or 'start date'
 ; falls within the 'from' and 'thru' date range
 ; ('Stop date' is the last date the dose may be given.)
 S STOPDATE=FDATE-.000001 ; for each stop date in the range
 F  S STOPDATE=$O(^PS(55,DFN,5,"AUS",STOPDATE)) Q:STOPDATE'>0  D
 . S RECNR=0 ; for each order on that date
 . F  S RECNR=$O(^PS(55,DFN,5,"AUS",STOPDATE,RECNR)) Q:RECNR'>0  D
 . . S TWOREC=$G(^PS(55,DFN,5,RECNR,2))
 . . Q:TWOREC=""
 . . S STRTDATE=$P(TWOREC,U,2)\1
 . . Q:STRTDATE>STOPDATE!(STRTDATE=0)
 . . S ZEROREC=$G(^PS(55,DFN,5,RECNR,0))
 . . Q:ZEROREC=""
 . . S ORDERNUM=$P(ZEROREC,U) ; get order number
 . . ; Joel does the following, but why?  Since order number is the .01
 . . ; field, it should not be null...If null, get original order number.
 . . ; S:'ORDERNUM ORDERNUM=$P(ZEROREC,U,18)
 . . S SCHEDULE=$P(TWOREC,U,1)
 . . S ORDERTYP=$P(ZEROREC,U,4)
 . . S SCHEDTYP=$P(ZEROREC,U,7)
 . . S LIMDOSE=$P(ZEROREC,U,11)
 . . S MEDROUTE=$P($G(^PS(51.2,+$P(ZEROREC,U,3),0)),U,1) ; follow ptr
 . . I CLEARTXT D  ; translate the sets of codes
 . . . S ORDERTYP=$$TRANSLAT^SPNLGU(ORDERTYP,55.06,4)
 . . . S SCHEDTYP=$$TRANSLAT^SPNLGU(SCHEDTYP,55.06,7)
 . . D ADDREC^SPNLGE("UD",ORDERNUM_"^"_STRTDATE_"^"_STOPDATE\1_"^"_SCHEDULE_"^"_MEDROUTE_"^"_ORDERTYP_"^"_SCHEDTYP_"^"_LIMDOSE_"^"_$$TOTLDISP)
 . . S SUBRECNR="" ; for each drug in the order
 . . F  S SUBRECNR=$O(^PS(55,DFN,5,RECNR,1,SUBRECNR)) Q:SUBRECNR=""  D
 . . . S ZDRUGREC=$G(^PS(55,DFN,5,RECNR,1,SUBRECNR,0))
 . . . S ZDRUGNAM=$P($G(^PSDRUG(+$P(ZDRUGREC,U,1),0)),U,1) ;follow ptr
 . . . S ZDRUGDOS=$P(ZDRUGREC,U,2)
 . . . D ADDREC^SPNLGE("UDD",ORDERNUM_"^"_ZDRUGNAM_"^"_ZDRUGDOS)
 Q
TOTLDISP() ;  compute the total dispensed
 N D0,D1,DA,X
 S (D0,DA(1))=DFN
 S (D1,DA)=RECNR
 X $P(^DD(55.06,39,0),U,5,99)
 Q X
