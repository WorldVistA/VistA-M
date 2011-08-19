SPNLGROP ; ISC-SF/GMB - SCD GATHER OUTPATIENT DATA;20 MAY 94 [ 08/08/94  1:09 PM ] ;6/23/95  11:38
 ;;2.0;Spinal Cord Dysfunction;**7,20**;01/02/1997
ROLLUP(DFN,FDATE,TDATE,HI) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"OP",
 ; with the following nodes:
 ; "PAT")                # patients
 ; "VISITS")             # visits
 ; "VISITS",-visits)     # patients who made this many visits
 ; "STOPS")              # stops
 ; "SC",stopcd)          # patients who stopped at this stop code
 ; "SC",stopcd,"NAME")   name of the stop code
 ; "SC",stopcd,"VISITS") # visits to this stop code
 ; "SC",stopcd,"STOPS")  # stops to this stop code
 ; ... and individual patient usage ...
 ; "HI","H1",-visits,-ndscnums,DFN)
 ; NOTE:  A visit is when a patient goes to a hospital on a given day.
 ;        A stop is when a patient goes to a stop code (clinic) in the
 ;        hospital.  There can be any number of stops per visit.
 ;        Now for the tricky part....
 ;        Visits to a stop code are calculated by dividing the visit (1)
 ;        by the number of >different< stop codes gone to.  So if four
 ;        different clinics were gone to, then each gets .25 visit.
 ; The following global is used as a scratch pad:
 ; ^TMP("SPN",$J,"TMP":
 ; "SC",scnum,date)="" this stop code was visited on these dates
 ; "VI",date,scnum)="" these stop codes were visited on this date
 ; "VI",date)          # different stop codes visited on this date
 N APPT,APPTINFO,SCNUM,SCDATE,VISITS,STOPS,WHEN,RECNR,SCPTR
 N NDSCNUMS,TSTOPS,VASD,SC,VIFRACTN
 I '$D(TDATE) S TDATE=DT
 K ^TMP("SPN",$J,"TMP")
 ; The following call returns all scheduled appointments which were
 ; kept, and all future appointments, within the from/to dates
 S VASD("F")=FDATE,VASD("T")=TDATE D SDA^VADPT
 S APPT=0 ; for each date/time of appt.
 F  S APPT=$O(^UTILITY("VASD",$J,APPT)) Q:APPT=""  D
 . S APPTINFO=$G(^UTILITY("VASD",$J,APPT,"I"))
 . I $P($G(APPTINFO),U,3)="I" Q  ;inpatient appointment 12/2/2002
 . S SCDATE=$P(APPTINFO,U,1)\1
 . ; follow clinic ptr to hospital location to stop code number
 . S SCNUM=$$STOPCODE^SPNLGU($P(APPTINFO,U,2))
 . S SC(SCNUM)=$G(SC(SCNUM))+1 ; # times this stop code was visited
 . S ^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)=""
 . S ^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)=""
 ; Now we count all "walk-ins" without appointments (unscheduled)
 D UNSCH^SPNLGEOP(DFN,FDATE,TDATE,"D CB^SPNLGROP(Y,Y0,.SDSTOP)")
 S (TSTOPS,NDSCNUMS)=0 ; track total stops & # of different stop codes
 S SCNUM="" ; for each stop code the patient visited
 F  S SCNUM=$O(SC(SCNUM)) Q:SCNUM=""  D
 . S STOPS=SC(SCNUM)
 . S ^("STOPS")=$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))+STOPS
 . S TSTOPS=TSTOPS+STOPS
 . S NDSCNUMS=NDSCNUMS+1
 . S ^(SCNUM)=$G(^TMP("SPN",$J,"OP","SC",SCNUM))+1
 . S SCDATE="" ; for every day on which it was visited
 . F  S SCDATE=$O(^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)) Q:SCDATE=""  D
 . . ;   increment the count of different stop codes visited on that date
 . . S ^(SCDATE)=$G(^TMP("SPN",$J,"TMP","VI",SCDATE))+1
 S VISITS=0,SCDATE="" ; for every day the patient visited
 F  S SCDATE=$O(^TMP("SPN",$J,"TMP","VI",SCDATE)) Q:SCDATE=""  D
 . S VISITS=VISITS+1
 . S VIFRACTN=1/^TMP("SPN",$J,"TMP","VI",SCDATE) ; fraction of a visit
 . S SCNUM="" ; for every stop code visited on that day
 . F  S SCNUM=$O(^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)) Q:SCNUM=""  D
 . . ; track what portion of the visits went to a particular stop code
 . . S ^("VISITS")=$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))+VIFRACTN
 Q:VISITS=0
 K ^TMP("SPN",$J,"TMP")
 S ^("VISITS")=$G(^TMP("SPN",$J,"OP","VISITS"))+VISITS
 S ^(-VISITS)=$G(^TMP("SPN",$J,"OP","VISITS",-VISITS))+1
 S ^("STOPS")=$G(^TMP("SPN",$J,"OP","STOPS"))+TSTOPS
 S ^("PAT")=$G(^TMP("SPN",$J,"OP","PAT"))+1
 S:HI ^TMP("SPN",$J,"OP","HI","H1",-VISITS,-NDSCNUMS,DFN)=""
 Q
NAMEIT ;
 N SCNUM,SCNAME,SCPTR
 S SCNUM=""
 F  S SCNUM=$O(^TMP("SPN",$J,"OP","SC",SCNUM)) Q:SCNUM=""  D
 . S SCPTR=$O(^DIC(40.7,"C",SCNUM,0))
 . I SCPTR'>0 D
 . . S SCNAME="Not Identified"
 . E  D
 . . S SCNAME=$E($P($G(^DIC(40.7,SCPTR,0)),U,1),1,35)
 . . I SCNAME="" S SCNAME="Not Identified"
 . S ^TMP("SPN",$J,"OP","SC",SCNUM,"NAME")=SCNAME
 Q
 ;
CB(SPNOE,SPNOE0,SPNSTOP) ;     -- callback code called for each
 ;                                record in query result set
 ;
 ;  input:  SPNOE   := ien of Outpatient Encounter
 ;          SPNOE0  := zeroth node of Outpatient Encounter
 ;          SPNSTOP := tells query to stop processing by setting to 1
 ;
 N SPNDATE,SCDATE,SCDATE,SCPTR,SCNUM
 IF $P(SPNOE0,U,6) G CBQ     ; -- quit if encounter has parent
 IF $P(SPNOE0,U,8)'=2 G CBQ  ; -- quit if not standalone encounter
 ;
 S SPNDATE=+SPNOE0           ; -- encounter date
 S SCDATE=SPNDATE\1
 S SCPTR=+$P(SPNOE0,U,3)     ; -- stop code pointer
 IF 'SCPTR G CBQ
 S SCNUM=$P($G(^DIC(40.7,SCPTR,0)),U,2)
 S SC(SCNUM)=$G(SC(SCNUM))+1 ; # times this stop code was visited
 S ^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)=""
 S ^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)=""
CBQ Q
 ;
