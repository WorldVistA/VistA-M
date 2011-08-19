SPNLGE ; ISC-SF/GMB - SCD GATHER EXTRACTS FOR SHIPMENT ;6/29/95  09:18
 ;;2.0;Spinal Cord Dysfunction;;01/02/1997
INIT(ABORT) ; Call this once, before you start the extract process
 S SPNDATE=DT ; variables used by ADDREC & FINISHUP subroutines
 ; Get facility number from the site parameters file
 S SPNFACNR=$P($G(^SPNL(154.91,1,0)),U,1)
 Q:SPNFACNR>0
 W !,"Facility number in site parameters file ^SPNL(154.91 is not initialized!"
 S ABORT=1
 Q
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ; Call this for each registry patient
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 ; ABORT     Set and returned by this routine.  Initially set to 0
 ;           Set to 1 if any errors are noticed.
 ;           (Actually, right now, ABORT will always be 0)
 N SPNSSN,SPNRECNR ; variables used by ADDREC subroutine
 N VADM,VA
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 S ABORT=0
 D DEM^VADPT
 S SPNSSN=$$EN^SPNLGUCD(VA("PID"))
 S SPNRECNR=0 D EXTRACT^SPNLGEAA(DFN,CLEARTXT,.ABORT) Q:ABORT
 S SPNRECNR=0 D EXTRACT^SPNLGEFM(DFN,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGECH(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGEDM(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGEIP(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGEOP(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGERA(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGERX(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 ;S SPNRECNR=0 D EXTRACT^SPNLGEUD(DFN,FDATE,TDATE,CLEARTXT,.ABORT) Q:ABORT
 S ^TMP("SPNX",$J,SPNDATE,SPNFACNR,SPNSSN)=TDATE
 Q
ADDREC(TYPE,RECORD) ; Add the record to the others gathered.
 ; This routine is called by the above extractors.
 S SPNRECNR=SPNRECNR+1
 S ^TMP("SPNX",$J,SPNDATE,SPNFACNR,SPNSSN,TYPE,SPNRECNR)=RECORD
 Q
FINISHUP(FACINFO) ; Call this once, after the extract process is finished
 S ^TMP("SPNX",$J,SPNDATE,SPNFACNR)=FACINFO
 K SPNDATE,SPNFACNR
 Q
