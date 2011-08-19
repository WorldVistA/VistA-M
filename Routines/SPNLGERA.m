SPNLGERA ; ISC-SF/GMB - SCD GATHER RADIOLOGY DATA;25 MAY 94 [ 08/09/94  9:45 AM ] ;6/23/95  11:23
 ;;2.0;Spinal Cord Dysfunction;**13**;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; This entry point is to be used solely for gathering data to be sent
 ; to the national registry
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N LASTDATE,EXAMDATE,RECNR,REALDATE,MODLIST,MRECNR,MOD,MODPTR
 N PROCPTR,PROCREC,PROCNAME,CPTCODE,PROCCOST,COMPLETE,REC0,EXAMSTAT
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; Need to be able to recognize if an exam has been completed.
 ;S COMPLETE=$O(^RA(72,"B","COMPLETE",0)) ; obsolete. See DBIA #996
 ; We are interested in any radiology procedure administered within the
 ; 'from' and 'thru' date range.  The record numbers are date/time (of
 ; procedure), subtracted from 9999999.9999.  This causes the procedures
 ; to be listed in order from most recent to oldest.  So we must modify
 ; our from & to dates.
 S LASTDATE=9999999.9999-FDATE
 S EXAMDATE=9999999.9999-(TDATE+1) ; for each exam date in range
 F  S EXAMDATE=$O(^RADPT(DFN,"DT",EXAMDATE)) Q:EXAMDATE'>0!(EXAMDATE>LASTDATE)  D
 . S REALDATE=9999999.9999-EXAMDATE\1
 . S COMPLETE=$O(^RA(72,"AA",$P(^RA(79.2,$P(^RADPT(DFN,"DT",EXAMDATE,0),U,2),0),U,1),9,"")) ; updated call to radiology
 . S RECNR=0 ; for each procedure on that date
 . F  S RECNR=$O(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR)) Q:RECNR'>0  D
 . . S REC0=$G(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR,0))
 . . S EXAMSTAT=+$P(REC0,U,3)
 . . Q:EXAMSTAT'=COMPLETE
 . . S PROCPTR=+$P(REC0,U,2)
 . . Q:PROCPTR=0
 . . S PROCREC=$G(^RAMIS(71,PROCPTR,0))
 . . Q:PROCREC=""
 . . S PROCNAME=$P(PROCREC,U,1)
 . . S CPTCODE=$P(PROCREC,U,9)
 . . S PROCCOST=$P(PROCREC,U,10)
 . . S MODLIST=""
 . . S MRECNR=0 ; for each modifier
 . . F  S MRECNR=$O(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR,"M",MRECNR)) Q:MRECNR'>0  D
 . . . S MODPTR=+$G(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR,"M",MRECNR,0))
 . . . S MOD=$P($G(^RAMIS(71.2,MODPTR,0)),U,1)
 . . . S:MOD'="" MODLIST=MODLIST_"^"_MOD
 . . S MODLIST=$P(MODLIST,U,2,5) ; just take first four modifiers
 . . D ADDREC^SPNLGE("RA",REALDATE_"^"_PROCNAME_"^"_CPTCODE_"^"_MODLIST)
 Q
