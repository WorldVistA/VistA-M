SPNLGRRA ; ISC-SF/GMB - SCD GATHER RADIOLOGY DATA;25 MAY 94 [ 08/09/94  9:35 AM ] ;6/23/95  11:41
 ;;2.0;Spinal Cord Dysfunction;**13**;01/02/1997
ROLLUP(DFN,FDATE,TDATE,HI) ;
 ; This entry point is to be used solely for gathering data for reports
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"RA",
 ; with the following nodes:
 ; "PAT")                 # patients with at least 1 procedure
 ; "EXAMS")               # procedures
 ; "EXAMS",-procs)        # patients who had this many procedures
 ; "PROC",cptcode)        # times this procedure was done
 ; "PROC",cptcode,"PAT")  # patients who had this procedure
 ; "PROC",cptcode,"NAME") name of the procedure
 ; "PROC",cptcode,"VAL")  current value of all instances of this procedure
 ; ... and track usage by individual patient ranked by:
 ; "HI","H1",-procs,-diff procs,-value,DFN)
 ; "HI","H2",-value,-procs,-diff procs,DFN)
 N LASTDATE,EXAMDATE,RECNR,PROCNAME,PROCCOST,CPTCODE,EXAMSTAT
 N TPROCS,NPROCS,NDPROCS,VALUE,TVALUE,PROC,PROCREC,PROCPTR,COMPLETE,REC0
 I '$D(TDATE) S TDATE=DT
 ; Need to be able to recognize if an exam has been completed
 ;S COMPLETE=$O(^RA(72,"B","COMPLETE",0)) ; obsolete. See DBIA #996
 ; We are interested in any radiology procedure administered within the
 ; 'from' and 'thru' date range.  The record numbers are date/time (of
 ; procedure), subtracted from 9999999.9999.  This causes the procedures
 ; to be listed in order from most recent to oldest.  So we must modify
 ; our from & to dates.
 S LASTDATE=9999999.9999-FDATE
 S EXAMDATE=9999999.9999-(TDATE+1) ; for each exam date in range
 F  S EXAMDATE=$O(^RADPT(DFN,"DT",EXAMDATE)) Q:EXAMDATE'>0!(EXAMDATE>LASTDATE)  D
 . S COMPLETE=$O(^RA(72,"AA",$P(^RA(79.2,$P(^RADPT(DFN,"DT",EXAMDATE,0),U,2),0),U,1),9,"")) ; updated call to radiology
 . S RECNR=0 ; for each procedure on that date
 . F  S RECNR=$O(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR)) Q:RECNR'>0  D
 . . S REC0=$G(^RADPT(DFN,"DT",EXAMDATE,"P",RECNR,0))
 . . S PROCPTR=+$P(REC0,U,2) ; points to the procedure
 . . Q:PROCPTR=0
 . . S EXAMSTAT=+$P(REC0,U,3) ; exam status
 . . Q:EXAMSTAT'=COMPLETE
 . . S PROC(PROCPTR)=$G(PROC(PROCPTR))+1 ; # times this proc was done
 Q:'$D(PROC)
 S (TPROCS,NDPROCS,TVALUE)=0
 S PROCPTR=""
 F  S PROCPTR=$O(PROC(PROCPTR)) Q:PROCPTR=""  D
 . S PROCREC=$G(^RAMIS(71,PROCPTR,0))
 . Q:PROCREC=""
 . S NDPROCS=NDPROCS+1 ; number of different procedures
 . S NPROCS=PROC(PROCPTR)
 . S TPROCS=TPROCS+NPROCS
 . S CPTCODE=+$P(PROCREC,U,9)
 . S PROCCOST=$P(PROCREC,U,10)
 . S ^(CPTCODE)=$G(^TMP("SPN",$J,"RA","PROC",CPTCODE))+NPROCS
 . S ^("PAT")=$G(^TMP("SPN",$J,"RA","PROC",CPTCODE,"PAT"))+1
 . S VALUE=NPROCS*PROCCOST
 . S TVALUE=TVALUE+VALUE
 S ^("PAT")=$G(^TMP("SPN",$J,"RA","PAT"))+1
 S ^("EXAMS")=$G(^TMP("SPN",$J,"RA","EXAMS"))+TPROCS
 S ^(-TPROCS)=$G(^TMP("SPN",$J,"RA","EXAMS",-TPROCS))+1
 Q:'HI
 S ^TMP("SPN",$J,"RA","HI","H1",-TPROCS,-NDPROCS,-TVALUE,DFN)=""
 S ^TMP("SPN",$J,"RA","HI","H2",-TVALUE,-TPROCS,-NDPROCS,DFN)=""
 Q
NAMEIT ; Name the radiology procedures and get their current values
 N CPTCODE,PROCREC,PROCPTR,PROCNAME,PROCCOST,VALUE,NPROCS
 S CPTCODE=""
 F  S CPTCODE=$O(^TMP("SPN",$J,"RA","PROC",CPTCODE)) Q:CPTCODE=""  D
 . S PROCPTR=+$O(^RAMIS(71,"D",CPTCODE,""))
 . S PROCREC=$G(^RAMIS(71,PROCPTR,0))
 . S PROCNAME=$P(PROCREC,U,1)
 . I PROCNAME="" S PROCNAME="Not identified"
 . S ^TMP("SPN",$J,"RA","PROC",CPTCODE,"NAME")=PROCNAME
 . S PROCCOST=+$P(PROCREC,U,10)
 . S NPROCS=$G(^TMP("SPN",$J,"RA","PROC",CPTCODE))
 . S VALUE=NPROCS*PROCCOST
 . S ^TMP("SPN",$J,"RA","PROC",CPTCODE,"VAL")=VALUE
 Q
