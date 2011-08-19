SPNLGERX ; ISC-SF/GMB - SCD GATHER OUTPATIENT PHARMACY DATA;11 MAY 94 [ 07/06/94  9:59 AM ] ;6/23/95  11:25
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N EXPDATE,RECNR,ZEROREC,TWOREC,ISSUDATE,ZDRUGNAM,UNITCOST,PATSTAT
 N SCNUM,FILLDATE,QTY,SUPPLY,REFILLS,SIG,FILLNUM,SUBRECNR,UNITVAL
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; We are interested in any drug whose prescription 'expiration' or
 ; 'cancel' date falls on or after the 'from' date.
 ; We are going to take only the fills or refills which occurred
 ; during the 'from'-'thru' date range.
 S EXPDATE=FDATE-.000001 ; for each expiration date
 F  S EXPDATE=$O(^PS(55,DFN,"P","A",EXPDATE)) Q:EXPDATE'>0  D
 . S RECNR=0 ; for each prescription on that date
 . F  S RECNR=$O(^PS(55,DFN,"P","A",EXPDATE,RECNR)) Q:RECNR'>0  D
 . . S TWOREC=$G(^PSRX(RECNR,2)) ; follow ptr to get prescripton info
 . . Q:TWOREC=""
 . . S FILLDATE=$P(TWOREC,U,2)
 . . Q:FILLDATE>TDATE
 . . S ZEROREC=$G(^PSRX(RECNR,0))
 . . Q:ZEROREC=""
 . . S ISSUDATE=$P(ZEROREC,U,13)
 . . S ZDRUGNAM=$P($G(^PSDRUG(+$P(ZEROREC,U,6),0)),U,1) ; drug name
 . . S UNITVAL=$P($G(^PSDRUG(+$P(ZEROREC,U,6),660)),U,6) ; current price
 . . S FILLNUM=0
 . . I FILLDATE'<FDATE,FILLDATE'>TDATE D
 . . . S QTY=$P(ZEROREC,U,7) ; quantity
 . . . S UNITCOST=$P(ZEROREC,U,17)
 . . . S SUPPLY=$P(ZEROREC,U,8) ; days supply
 . . . S PATSTAT=$P($G(^PS(53,+$P(ZEROREC,U,3),0)),U,1) ; follow ptr
 . . . ; follow ptr to hospital location to stop code number
 . . . S SCNUM=$$STOPCODE^SPNLGU(+$P(ZEROREC,U,5))
 . . . S REFILLS=$P(ZEROREC,U,9) ; max number of refills
 . . . S SIG=$P(ZEROREC,U,10)
 . . . D ADDREC^SPNLGE("RX",FILLDATE_"^"_ZDRUGNAM_"^"_FILLNUM_"^"_ISSUDATE_"^"_QTY_"^"_UNITCOST_"^"_SUPPLY_"^"_UNITVAL_"^"_PATSTAT_"^"_SCNUM_"^"_REFILLS_"^"_SIG)
 . . S SUBRECNR=0 ; for each refill of the drug
 . . F FILLNUM=1:1 S SUBRECNR=$O(^PSRX(RECNR,1,SUBRECNR)) Q:SUBRECNR'>0  D
 . . . S ZEROREC=$G(^PSRX(RECNR,1,SUBRECNR,0))
 . . . S FILLDATE=$P(ZEROREC,U,1)
 . . . Q:FILLDATE<FDATE!(FILLDATE>TDATE)
 . . . S QTY=$P(ZEROREC,U,4)
 . . . S UNITCOST=$P(ZEROREC,U,11)
 . . . S SUPPLY=$P(ZEROREC,U,10)
 . . . D ADDREC^SPNLGE("RX",FILLDATE_"^"_ZDRUGNAM_"^"_FILLNUM_"^"_ISSUDATE_"^"_QTY_"^"_UNITCOST_"^"_SUPPLY_"^"_UNITVAL)
 Q
