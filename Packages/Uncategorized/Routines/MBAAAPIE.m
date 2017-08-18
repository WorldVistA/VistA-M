MBAAAPIE ;OIT-PD/CBR - Scheduling Error provider ;02/10/2016
 ;;1.0;Scheduling Calendar View;**1**;Aug 27, 2014;Build 85
 ;
ERRX(RETURN,ERRNO,TEXT,LVL) ; adds error to RETURN Called by RPC MBAA APPOINTMENT MAKE, MBAA RPC: MBAA CANCEL APPOINTMENT
 N ERRTXT,IND,ST,STR,TXT,I
 Q:'$D(RETURN)
 Q:'$D(ERRNO)
 S:$G(LVL)="" LVL=1
 S TEXT=$G(TEXT)
 F I=0:1 Q:$O(RETURN(I))=""!('+$O(RETURN(I)))
 I I=0,$D(RETURN(0)) S I=I+1
 E  S:I>0 I=I+1
 S ERRTXT=$P($T(@ERRNO),";;",2)
 S IND=1,TXT=1,STR=""
 F  Q:IND=0  D
 . S ST=$P(ERRTXT,"^",IND)
 . I ST=""&(IND>1) S IND=0 Q
 . I ST["$TXT" D  S:$D(TEXT(TXT)) STR=STR_TEXT(TXT),TXT=TXT+1
 . E  S STR=STR_ST
 . S IND=IND+1
 S RETURN(I)=ERRNO_U_STR_U_LVL
 Q
 ;
ERRTXT(RETURN) ; MBAA RPC: used by multiple MBAA RPCS
 Q $P($G(RETURN(0)),U,2)
 ; 
ERRTABLE ; Error table
INVPARAM ;;Invalid parameter value - ^$TXT1^.
CLNINV ;;Invalid Clinic.
CLNNFND ;;Clinic not found.
CLNNDFN ;;Clinic not define or has no zero node.
CLNSCIN ;;Invalid Clinic Stop Code ^$TXT1^.
CLNSCRD ;;Clinic's Stop Code ^$TXT1^ cannot be used. Restriction date is ^$TXT2^ ^$TXT3^.
CLNSCPS ;;Clinic's Stop Code ^$TXT1^ cannot be ^$TXT2^.
CLNSCNR ;;Clinic's Stop Code ^$TXT1^ has no restriction type ^$TXT2^.
CLNURGT ;;Access to ^$TXT1^ is prohibited!^$TXT2^Only users with a special code may access this clinic.
CLNNOSL ;;No 'SL' node defined - cannot proceed with this clinic.
PATDIED ;;PATIENT HAS DIED.
PATNFND ;;Patient not found.
PATSENS ;;Do you want to continue processing this patient record
NOAVSLO ;;No available slots found on the same day in all the selected clinics for this date range
APTCRGT ;;Appt. in ^$TXT1^ NOT CANCELLED^$TXT2^Access to this clinic is restricted to only privileged users!
APTCCHO ;;>>> Appointment has a check out date and cannot be cancelled.
APTCAND ;;Appointment already cancelled
APTCNPE ;;You cannot cancel this appointment.
APTCIPE ;;You cannot check in this appointment.
APTCITS ;;It is too soon to check in this appointment.
APTPPAB ;;That date is prior to the patient's date of birth.
APTPCLA ;;That date is prior to the clinic's availability date.
APTCLUV ;;There is no availability for this date/time.
APTEXCD ;;EXCEEDS MAXIMUM DAYS FOR FUTURE APPOINTMENT!!
APTSHOL ;;^$TXT1^??
APTPAHA ;;PATIENT ALREADY HAS APPOINTMENT ^$TXT1^ THEN.
APTPAHU ;;o  Patient already has an appt on ^$TXT1^
APTPHSD ;;PATIENT ALREADY HAS APPOINTMENT ON THE SAME DAY ^$TXT1^
APTPPCP ;;THIS TIME WAS PREVIOUSLY CANCELLED BY THE PATIENT
APTOVBK ;;OVERBOOK!
APTOVOS ;;THAT TIME IS NOT WITHIN SCHEDULED PERIOD!
APTOAPD ;;ONLY ^$TXT1^ OVERBOOK^$TXT2^ PER DAY!!
APTCBCP ;;CAN'T BOOK WITHIN A CANCELLED TIME PERIOD
APTNOST ;;NO OPEN SLOTS THEN
APTEXOB ;;WILL EXCEED MAXIMUM ALLOWABLE OVERBOOKS,
APTLOCK ;;Another user is editing this record.  Trying again.
APTCINV ;;*** Note: Clinic is scheduled to be inactivated on ^$TXT1^$TXT2^
APTNSCE ;;You cannot execute no-show processing for this appointment.
APTNSTS ;;It is too soon to no-show this appointment.
APTNSAL ;;ALREADY RECORDED AS NO-SHOW... WANT TO ERASE
APTNSAR ;;THIS APPOINTMENT ALREADY A NO-SHOW AND REBOOKED... ARE YOU SURE YOU WANT TO ERASE
APTNSIA ;;Inpatient Appointments cannot reflect No-Show status!
PATDARD ;;PATIENT ALREADY DISCHARGED FROM '^$TXT1^' CLINIC
PATDNEN ;;>>> Patient not enrolled in '^$TXT1^' clinic.
PATDHFA ;;PATIENT HAS FUTURE APPOINTMENTS, MUST BE CANCELLED PRIOR TO DISCHARGE !!
APTDCOD ;;>>> The appointment must have a check out date/time to delete.
APTDCOO ;;>>> Editing and deleting old encounters not allowed.
APTCOCE ;;>>> You cannot check out this appointment.
APTCOTS ;;>>> It is too soon to check out this appointment.
APTCOCN ;;>>> You cannot check out this appointment.
APTCOAC ;;Appointment already checked out
APTCONW ;;Appointment new encounter
APTCOSU ;;You must have the 'SD SUPERVISOR' key to delete an appointment check out.
APTWHEN ;;WHEN??
