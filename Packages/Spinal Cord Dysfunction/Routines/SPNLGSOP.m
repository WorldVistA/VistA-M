SPNLGSOP ; ISC-SF/GMB - SCD GATHER (SPECIFIC) OUTPATIENT DATA;16 JUN 94 [ 08/08/94  1:11 PM ] ;6/23/95  11:48
 ;;2.0;Spinal Cord Dysfunction;**7**;01/02/1997
SELECT(DFN,FDATE,TDATE,HI,QLIST) ;
 ; Note:  Because of the need to gather VISIT data, we must gather all
 ;        clinic stop code data, not only those selected on QLIST.
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; HI        1=keep track of individual patient usage
 ;           0=don't keep track
 ; Data will be rolled up into the following global:
 ; ^TMP("SPN",$J,"OP",
 ; with the following nodes:
 ; "SC",stopcd)          # patients who stopped at this stop code
 ; "SC",stopcd,"VISITS") # visits to this stop code
 ; "SC",stopcd,"STOPS")  # stops to this stop code
 ; "SC",stopcd,"PID",patient name^SSN)  visits^stops
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
 N VASD,VIFRACTN,PNAME,PSSN
 I '$D(TDATE) S TDATE=DT
 K ^TMP("SPN",$J,"TMP")
 ; The following call returns all scheduled appointments which were
 ; kept, and all future appointments, within the from/to dates
 S VASD("F")=FDATE,VASD("T")=TDATE D SDA^VADPT
 S APPT=0 ; for each date/time of appt.
 F  S APPT=$O(^UTILITY("VASD",$J,APPT)) Q:APPT=""  D
 . S APPTINFO=$G(^UTILITY("VASD",$J,APPT,"I"))
 . S SCDATE=$P(APPTINFO,U,1)\1
 . ; follow clinic ptr to hospital location to stop code number
 . S SCNUM=$$STOPCODE^SPNLGU($P(APPTINFO,U,2))
 . S STOPS(SCNUM)=$G(STOPS(SCNUM))+1 ; # times this stop code was visited
 . S ^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)=""
 . S ^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)=""
 ; Now we count all "walk-ins" without appointments (unscheduled)
 D UNSCH^SPNLGEOP(DFN,FDATE,TDATE,"D CB^SPNLGSOP(Y,Y0,.SDSTOP)")
 S SCNUM="" ; for each stop code the patient visited
 F  S SCNUM=$O(STOPS(SCNUM)) Q:SCNUM=""  D
 . S ^("STOPS")=$G(^TMP("SPN",$J,"OP","SC",SCNUM,"STOPS"))+STOPS(SCNUM)
 . S ^(SCNUM)=$G(^TMP("SPN",$J,"OP","SC",SCNUM))+1
 . S SCDATE="" ; for every day on which it was visited
 . F  S SCDATE=$O(^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)) Q:SCDATE=""  D
 . . ;   increment the count of different stop codes visited on that date
 . . S ^(SCDATE)=$G(^TMP("SPN",$J,"TMP","VI",SCDATE))+1
 S SCDATE="" ; for every day the patient visited
 F  S SCDATE=$O(^TMP("SPN",$J,"TMP","VI",SCDATE)) Q:SCDATE=""  D
 . S VIFRACTN=1/^TMP("SPN",$J,"TMP","VI",SCDATE) ; fraction of a visit
 . S SCNUM="" ; for every stop code visited on that day
 . F  S SCNUM=$O(^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)) Q:SCNUM=""  D
 . . ; track what portion of the visits went to a particular stop code
 . . S VISITS(SCNUM)=$G(VISITS(SCNUM))+VIFRACTN
 Q:$D(VISITS)<10  ; make sure there are descendants
 D:HI GETNAME^SPNLRU(DFN,.PNAME,.PSSN)
 S SCNUM=""
 F  S SCNUM=$O(QLIST("SC",SCNUM)) Q:SCNUM=""  D
 . Q:'$G(VISITS(SCNUM))
 . S ^("VISITS")=$G(^TMP("SPN",$J,"OP","SC",SCNUM,"VISITS"))+$G(VISITS(SCNUM))
 . S:HI ^TMP("SPN",$J,"OP","SC",SCNUM,"PID",PNAME_U_PSSN)=$G(VISITS(SCNUM))_U_$G(STOPS(SCNUM))
 K ^TMP("SPN",$J,"TMP")
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
 N SPNDATE,SCDATE,SCPTR,SCNUM
 IF $P(SPNOE0,U,6) G CBQ     ; -- quit if encounter has parent
 IF $P(SPNOE0,U,8)'=2 G CBQ  ; -- quit if not standalone encounter
 ;
 S SPNDATE=+SPNOE0           ; -- encounter date
 S SCDATE=SPNDATE\1
 S SCPTR=+$P(SPNOE0,U,3)     ; -- stop code pointer
 IF 'SCPTR G CBQ
 S SCNUM=$P($G(^DIC(40.7,SCPTR,0)),U,2)
 S STOPS(SCNUM)=$G(STOPS(SCNUM))+1 ; # times this stop code was visited
 S ^TMP("SPN",$J,"TMP","SC",SCNUM,SCDATE)=""
 S ^TMP("SPN",$J,"TMP","VI",SCDATE,SCNUM)=""
CBQ Q
 ;
