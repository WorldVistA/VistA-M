SDAMA203 ;BPIOFO/ACS-Scheduling API for IMO ;15 April 2003
 ;;5.3;Scheduling;**285,406**;13 Aug 1993
 ;
 ;Scheduling API to return encounter or appointment date/time for
 ;a patient that can receive inpatient medication from an
 ;authorized clinic
 ;
 ;**********************************************************************
 ;                        CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION                 DEVELOPER
 ;--------  ----------    ----------------------------------------------
 ;04/15/03  SD*5.3*285    ROUTINE WRITTEN             A SAUNDERS
 ;10/12/06  SD*5.3*406    FIXED ERROR CODE -3         A SAUNDERS
 ;
 ;**********************************************************************
 ;
 ;          **** TO BE CALLED WITH AN EXTRINISIC CALL ****
 ;Example:  I $$SDIMO^SDAMA203(CLIEN,DFN) S APPTDT=SDIMO(1) K SDIMO(1)
 ;
 ;INPUT
 ;  SDCLIEN      Clinic IEN (required)
 ;  SDPATDFN     Patient DFN (required)
 ;  
 ;OUTPUT
 ;  The extrinsic call will return one of the following values:
 ;     1   Patient has at least one scheduled appointment or checked-in
 ;         visit in an authorized clinic
 ;     0   Patient has no scheduled appointments or checked-in visits
 ;         in an authorized clinic
 ;    -1   Clinic is not an authorized clinic, clinic is inactive,
 ;         or SDCLIEN is null
 ;    -2   SDPATDFN is null
 ;    -3   Scheduling database is unavailable
 ;  
 ;  If a 1 is returned, then SDIMO(1) = Encounter or appointment 
 ;  date/time in FileMan format
 ;   
 ;**********************************************************************
 ;   Special Logic:
 ; - In line tag SDVISIT, the ACRP Toolkit API EXOE^SDOE is called 
 ;   multiple times as needed.  This API returns the NEXT encounter, 
 ;   given a start and end date/time.  We want to check ALL encounters
 ;   for a match on clinic IEN
 ; - In line tag SDDATE, if the current time is between midnight and 6am,
 ;   the API will start to look for encounters and/or appointments on the 
 ;   previous day
 ;
 ;  Internal variables:
 ;  SDBACK   Contains the value to be returned from this call.  See 
 ;           above for OUTPUT values and corresponding definitions
 ;  SDCONT   Flag to indicate if processing should continue.  If
 ;           the patient has an encounter in an authorized clinic
 ;           today, then we can skip the last step and not look for
 ;           a scheduled appointment
 ;  SDFROM   The date to start searching for an encounter or appointment
 ;  SDAPPTDT Encounter or appointment date/time returned in SDIMO(1)
 ;
 ;**********************************************************************
SDIMO(SDCLIEN,SDPATDFN) ;
 ;
 ;--INITIALIZATION--
 K SDIMO(1)
 N SDBACK,SDCONT,SDFROM,SDAPPTDT
 S SDBACK=1,SDCONT=1,SDAPPTDT=0,SDFROM=0
 ;
 ;--MAIN--
 ; Valid variables passed in?
 D SDVALVAR($G(SDPATDFN),$G(SDCLIEN),.SDBACK)
 ; If no error, is clinic active and authorized?
 I SDBACK=1 D SDAUTHCL(SDCLIEN,.SDBACK)
 ; If no error, set up search "start" date
 I SDBACK=1 D SDDATE(.SDFROM)
 ; If no error, does patient have an encounter in that clinic?
 I SDBACK=1 D SDVISIT(SDPATDFN,SDCLIEN,.SDAPPTDT,.SDCONT,.SDBACK,SDFROM)
 ; If no error and no encounter, does patient have an appointment in that
 ; clinic?
 I SDBACK=1,SDCONT=1 D SDAPPT(SDPATDFN,SDCLIEN,.SDAPPTDT,.SDBACK,SDFROM)
 ;
 ;--FINALIZATION--
 ; If no error
 I SDBACK=1 D
 . ; Set up output array with the encounter or appointment date/time
 . ; Make sure the appointment date/time exists in SDAPPTDT
 . I $G(SDAPPTDT)]"" D
 .. S SDIMO(1)=SDAPPTDT
 . I $G(SDAPPTDT)']"" D
 .. S SDBACK=0
 ; Return value
 Q SDBACK
 ;
 ;----------------------------------------------------------------------
 ;-Validate input variables
SDVALVAR(SDPATDFN,SDCLIEN,SDBACK) ;
 ; Clinic IEN and patient DFN cannot be null
 I $G(SDCLIEN)="" S SDBACK=-1 Q
 I $G(SDPATDFN)="" S SDBACK=-2 Q
 Q
 ;
 ;-Clinic must be type "C", authorized to administer inpatient meds,
 ;-and active
SDAUTHCL(SDCLIEN,SDBACK) ;
 N SDAUTH,SDTYPE
 S SDAUTH=0,SDTYPE=0
 ; clinic must be type "C"
 S SDTYPE=$P($G(^SC(SDCLIEN,0)),"^",3)
 I $G(SDTYPE)="C" D
 . ; clinic must be authorized to administer inpatient meds
 . I $D(^SC("AE",1,SDCLIEN)) S SDAUTH=1
 I SDAUTH'=1 S SDBACK=-1 Q
 ; clinic must be active
 ; if clinic inactivate date exists, check further
 N SDINACT,SDREACT
 S SDINACT=$P($G(^SC(SDCLIEN,"I")),"^",1)
 I $G(SDINACT)]"" D
 . ; if inactivate date is today or earlier, get reactivate date
 . I SDINACT'>DT D
 .. S SDREACT=$P($G(^SC(SDCLIEN,"I")),"^",2)
 .. ; reactivate date can't be null
 .. I $G(SDREACT)="" S SDBACK=-1
 .. ; if reactivate date exists
 .. E  D
 ... ; reactivate date must be less than or equal to today
 ... ; but greater than or equal to inactivate date
 ... I (SDREACT>DT!(SDREACT<SDINACT)) S SDBACK=-1
 Q
 ;-Set up start date for encounters and appointments
SDDATE(SDFROM) ;
 N %,X
 D NOW^%DTC
 ;if the current time is before 6am, set 'start' date to yesterday
 I ("."_$P(%,".",2))<.060000 S SDFROM=(X-1)
 E  S SDFROM=X
 Q
 ;-Look for encounter that occurred in the authorized clinic
SDVISIT(SDPATDFN,SDCLIEN,SDAPPTDT,SDCONT,SDBACK,SDFROM) ;
 N SDSTART,SDEND,SDENCNUM,SDENCDT,SDENCCL
 ; set up start and end date/time
 S SDSTART=SDFROM_".0000"
 S SDEND=DT_".2359"
 ; get encounters
 F  D  Q:+SDENCNUM=0
 . ; call API to get next encounter
 . S SDENCNUM=+$$EXOE^SDOE(SDPATDFN,SDSTART,SDEND)
 . I $G(SDENCNUM) D
 .. ; encounter found.  call API to get more encounter data
 .. D GETGEN^SDOE(SDENCNUM,"SDDATA")
 .. I $G(SDDATA(0)) D
 ... ; get encounter date/time and clinic IEN
 ... S SDENCDT=$P($G(SDDATA(0)),"^",1),SDENCCL=$P($G(SDDATA(0)),"^",4)
 ... ; if encounter clinic matches authorized clinic, set flags
 ... I $G(SDENCCL)=SDCLIEN S SDENCNUM=0,SDCONT=0,SDAPPTDT=$G(SDENCDT)
 ... ; if no match on clinic, reset start date for next encounter
 ... I $G(SDENCCL)'=SDCLIEN S SDSTART=(SDENCDT+.000001)
 ... K SDDATA
 Q
 ;-Look for scheduled appointment in the authorized clinic
SDAPPT(SDPATDFN,SDCLIEN,SDAPPTDT,SDBACK,SDFROM) ;
 N SDRESULT,SDAPPTCL,SDMATCH
 S SDMATCH=0
 ; call API to get appointments for this patient
 D GETAPPT^SDAMA201(SDPATDFN,"1;2","R;NT",SDFROM,,.SDRESULT)
 ; SDRESULT contains a count of the returned appointments
 I SDRESULT>0 D
 . N SDI
 . ; spin through returned appointments and look for match on clinic IEN
 . F SDI=1:1:SDRESULT D  Q:SDMATCH=1
 .. S SDAPPTCL=$G(^TMP($J,"SDAMA201","GETAPPT",SDI,2))
 .. I +$G(SDAPPTCL)=SDCLIEN D
 ... S SDAPPTDT=$G(^TMP($J,"SDAMA201","GETAPPT",SDI,1))
 ... S SDMATCH=1
 . ; delete appointment array returned from Scheduling API
 . K ^TMP($J,"SDAMA201","GETAPPT")
 I ((SDRESULT=0)!(SDMATCH=0)) S SDBACK=0
 I SDRESULT=-1 D
 . S SDBACK=0
 . ; if database unavailable, set database-specific flag
 . I $D(^TMP($J,"SDAMA201","GETAPPT","ERROR",101)) S SDBACK=-3
 . ; delete error array returned from Scheduling API
 . K ^TMP($J,"SDAMA201","GETAPPT")
 Q
