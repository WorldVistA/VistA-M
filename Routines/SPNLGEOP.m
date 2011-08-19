SPNLGEOP ; ISC-SF/GMB - SCD GATHER OUTPATIENT DATA;11 MAY 94 [ 08/08/94  1:09 PM ] ;6/23/95  12:09
 ;;2.0;Spinal Cord Dysfunction;**7**;01/02/1997
EXTRACT(DFN,FDATE,TDATE,CLEARTXT,ABORT) ;
 ; DFN       Patient's internal entry number in the Patient file
 ; FDATE     "From" date
 ; TDATE     "Thru" date, default=today
 ; CLEARTXT  1=translate all codes to their meaning,
 ;           0=don't translate codes (default=0)
 N APPT,APPTINFO,APPTDATE,YYY,MM,SCNUM,COUNT,WHEN,RECNR,SCPTR,VASD
 I '$D(TDATE) S TDATE=DT
 I '$D(CLEARTXT) S CLEARTXT=0
 ; We change the days in the dates, because we track only whole months.
 S FDATE=$E(FDATE,1,5)_"01"
 S TDATE=$E(TDATE,1,5)_"31"
 ; The following call returns all scheduled appointments which were
 ; kept, and all future appointments, within the from/to dates
 S VASD("F")=FDATE,VASD("T")=TDATE D SDA^VADPT
 S APPT=0 ; date/time of appt.
 F  S APPT=$O(^UTILITY("VASD",$J,APPT)) Q:APPT=""  D
 . S APPTINFO=^UTILITY("VASD",$J,APPT,"I")
 . S APPTDATE=$P(APPTINFO,U,1)\1
 . S YYY=$E(APPTDATE,1,3)
 . S MM=$E(APPTDATE,4,5)
 . ; follow clinic ptr to hospital location to stop code number
 . S SCNUM=$$STOPCODE^SPNLGU($P(APPTINFO,U,2))
 . S $P(COUNT(SCNUM,YYY),U,MM)=$P($G(COUNT(SCNUM,YYY)),U,MM)+1
 ; Now we count all "walk-ins" without appointments (unscheduled)
 D UNSCH(DFN,FDATE,TDATE,"D CB^SPNLGEOP(Y,Y0,.SDSTOP)")
 ; Now create transactions...
 S SCNUM=""
 F  S SCNUM=$O(COUNT(SCNUM)) Q:SCNUM=""  D
 . S YYY=""
 . F  S YYY=$O(COUNT(SCNUM,YYY)) Q:YYY=""  D
 . . D ADDREC^SPNLGE("OP",SCNUM_"^"_YYY_"0000"_"^"_COUNT(SCNUM,YYY))
 Q
 ;
UNSCH(SPNDFN,SPNST,SPNED,SPNCB) ; -- find Unscheduled encounter for patient for a date range
 ;   input:   SPNDFN := ien of patient
 ;            SPNST  := start date
 ;            SPNED  := end date
 ;            SPNCB  := callback code executed for each encounter in
 ;                      query's result set
 ;
 ; -- set up scan
 N SPNQRY
 D OPEN^SDQ(.SPNQRY)                        ; -- initialize query
 D INDEX^SDQ(.SPNQRY,"PATIENT/DATE","SET")  ; -- which index to use
 D PAT^SDQ(.SPNQRY,SPNDFN,"SET")            ; -- patient
 D DATE^SDQ(.SPNQRY,SPNST,SPNED,"SET")      ; -- date range
 D SCANCB^SDQ(.SPNQRY,SPNCB,"SET")          ; -- callback code to use
 D ACTIVE^SDQ(.SPNQRY,"TRUE","SET")         ; -- activate query
 ;
 D SCAN^SDQ(.SPNQRY,"FORWARD")              ; -- scan entries in query
 ;                                               result set
 ;
 D CLOSE^SDQ(.SPNQRY)                       ; -- close query
 Q
 ;
CB(SPNOE,SPNOE0,SPNSTOP) ;     -- callback code called for each
 ;                                record in query result set
 ;
 ;  input:  SPNOE   := ien of Outpatient Encounter
 ;          SPNOE0  := zeroth node of Outpatient Encounter
 ;          SPNSTOP := tells query to stop processing by setting to 1
 ;
 N SPNDATE,YYY,MM,SCPTR,SCNUM
 IF $P(SPNOE0,U,6) G CBQ     ; -- quit if encounter has parent
 IF $P(SPNOE0,U,8)'=2 G CBQ  ; -- quit if not standalone encounter
 ;
 S SPNDATE=+SPNOE0           ; -- encounter date
 S YYY=$E(SPNDATE,1,3)
 S MM=$E(SPNDATE,4,5)
 S SCPTR=+$P(SPNOE0,U,3)     ; -- stop code pointer
 IF 'SCPTR G CBQ
 S SCNUM=$P($G(^DIC(40.7,SCPTR,0)),U,2)
 S $P(COUNT(SCNUM,YYY),U,MM)=$P($G(COUNT(SCNUM,YYY)),U,MM)+1
CBQ Q
 ;
