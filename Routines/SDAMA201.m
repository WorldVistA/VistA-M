SDAMA201 ;BPOIFO/ACS-Scheduling Replacement APIs ; 12/13/04 3:14pm
 ;;5.3;Scheduling;**253,275,283,316,347**;13 Aug 1993
 ;
 ;GETAPPT  - Returns appointment information for a patient
 ;NEXTAPPT - Returns next appointment information for a patient
 ;
 ;**   BEFORE USING THE APIS IN THIS ROUTINE, PLEASE SUBSCRIBE   **
 ;**   TO DBIA #3859                                             **
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;09/20/02  SD*5.3*253    ROUTINE COMPLETED
 ;12/10/02  SD*5.3*275    ADDED PATIENT STATUS FILTER
 ;07/03/03  SD*5.3*283    REMOVED 'NO ACTION TAKEN' EDIT
 ;09/16/03  SD*5.3*316    CHANGED 'NEXTAPPT' TO START LOOKING 'NOW'
 ;07/26/04  SD*5.3*347    NEW VARIABLES USED IN ^%DTC CALL.
 ;                        NEXTAPPT TO GET DATA FROM SDAPI NOT VISTA.
 ;                        GETAPPT WILL RETRIEVE APPT DATA THROUGH
 ;                        SDAPI API.  PATIENT STATUS TO OVERWRITE 
 ;                        APPOINTMENT STATUS OF "R" OR "R;I".
 ;                        GETAPPT CALLS GETAPPT^SDAMA205.
 ;
 ;*****************************************************************
GETAPPT(SDPATIEN,SDFIELDS,SDAPSTAT,SDSTART,SDEND,SDRESULT,SDIOSTAT) ;
 ;*****************************************************************
 ;
 ;               GET APPOINTMENTS FOR PATIENT
 ;
 ;INPUT
 ;  SDPATIEN     Patient IEN (required)
 ;  SDFIELDS     Fields requested (optional)
 ;  SDAPSTAT     Appointment Status Filter (optional)
 ;  SDSTART      Start date/time (optional)
 ;  SDEND        End date/time (optional)
 ;  SDRESULT     Record count returned here (optional)
 ;  SDIOSTAT     Patient Status filter (optional)
 ;  
 ;OUTPUT
 ;  ^TMP($J,"SDAMA201","GETAPPT",X,Y)=FieldYdata
 ;  where "X" is an incremental appointment counter and
 ;  "Y" is the field number requested
 ;  
 ;*****************************************************************
 ; Call API to Get Appointment(s) for Patient.
 D GETAPPT^SDAMA205(.SDPATIEN,.SDFIELDS,.SDAPSTAT,.SDSTART,.SDEND,.SDRESULT,.SDIOSTAT)
 Q
 ;
NEXTAPPT(SDPATIEN,SDFIELDS,SDAPSTAT,SDIOSTAT) ;
 ;*****************************************************************
 ;
 ;               GET NEXT APPOINTMENT FOR PATIENT
 ;
 ; This API should be called with an EXTRINISIC call.  It will
 ; return "-1" if an error occurs, "1" if a future appointment
 ; exists, or "0" if no future appointment exists.  If the user
 ; enters field numbers into the optional SDFIELDS parameter and a
 ; next appointment is found, the requested fields for that next
 ; appointment will be retrieved and put into: 
 ; ^TMP($J,"SDAMA201","NEXTAPPT")
 ;
 ;INPUT
 ;  SDPATIEN     Patient IEN (required)
 ;  SDFIELDS     Fields requested (optional)
 ;  SDAPSTAT     Appointment status filter (optional)
 ;  SDIOSTAT     Patient status filter (optional)
 ;
 ;OUTPUT
 ;  -1: error
 ;   0: no future appointment
 ;   1: future appointment exists
 ;
 ;  If "1" is returned and the user has requested fields in the 
 ;  SDFIELDS  parameter, the following global is populated:
 ;  ^TMP($J,"SDAMA201","NEXTAPPT",Y)=FieldYdata
 ;  where "Y" is the field number requested
 ;  
 ;*****************************************************************
 N SDAPINAM,SDRTNNAM,SDSTART,SDRESULT,%,%H,%I,X
 S SDAPINAM="NEXTAPPT",SDRTNNAM="SDAMA201",SDRESULT=0
 K ^TMP($J,SDRTNNAM,SDAPINAM)
 ;
 ;Validate input parameters
 S SDRESULT=$$VALIDATE^SDAMA200(.SDPATIEN,.SDFIELDS,.SDAPSTAT,,,SDAPINAM,SDRTNNAM,.SDIOSTAT)
 I SDRESULT=-1 Q -1
 ;
 ;Get current date/time
 D NOW^%DTC
 S SDSTART=$E(%,1,12)
 ;GET NEXT APPOINTMENT DATA
 ;If an appt was found and the user wants data returned, get fields requested
 N SDICN,SDARRAY,SDCOUNT,SDAPLST,SDI,SDTMP,SDNUM,SDERR,SDFLDCNT,SDR,SDFLD,SD310
 N SDAPT,SDCLN,SDFFLD,SDFS
 S SDAPLST=""
 ;
 S SDARRAY(1)=SDSTART ; set searchpoint to current date/time
 ; Translate and set up Appointment Status List
 I $L($G(SDAPSTAT))>0 D
 . ;Remove a leading and a trailing semicolon
 . I $E(SDAPSTAT,$L(SDAPSTAT))=";" S SDAPSTAT=$E(SDAPSTAT,1,($L(SDAPSTAT)-1))
 . I $E(SDAPSTAT)=";" S SDAPSTAT=$E(SDAPSTAT,2,$L(SDAPSTAT))
 . ;IO/Appt Statuses have been validated by SDAMA200 to be I or O/R NT
 . I $L($G(SDIOSTAT))=1 S SDAPLST=$S(SDIOSTAT="I":"I;",SDIOSTAT="O":SDAPSTAT_";")
 . I $L($G(SDIOSTAT))'=1 D
 .. ;Reset appointment status R=R;I C=CC;CP;CCR;CPR N=NS,NSR
 .. S SDNUM=$L(SDAPSTAT,";") F SDI=1:1:SDNUM D
 ... S SDTMP=$P(SDAPSTAT,";",SDI)
 ... S SDTMP=$S(SDTMP="R":"R;I",SDTMP="C":"CC;CP;CCR;CPR",SDTMP="N":"NS;NSR",1:SDTMP)
 ... S SDAPLST=SDAPLST_SDTMP_";"
 . S SDARRAY(3)=$E(SDAPLST,1,($L(SDAPLST)-1)) ; Axe trailing semicolon
 S SDARRAY(4)=SDPATIEN
 S SDARRAY("MAX")=1
 ; Must request at least 1 field, will ask for date/time which is field 1
 S SDFIELDS=$G(SDFIELDS),(SDFFLD,SDFIELDS)=$S(SDFIELDS'="":SDFIELDS,1:1)
 ; Strip out field 12 if it exists, replace with 3 if 3 is not already there
 ; If we have both 3 and 12 in the field list, remove the 12 and a semicolon
 I (";"_SDFIELDS_";")[";12;",((";"_SDFIELDS_";")[";3;") D
 . S SDNUM=$L(SDFFLD,";"),SDI=$F(SDFFLD,12)
 . I SDI=3 S SDFFLD=$E(SDFFLD,4,$L(SDFFLD)) Q
 . S SDFFLD=$E(SDFFLD,1,(SDI-4))_$E(SDFFLD,SDI,$L(SDFFLD))
 I ((";"_SDFIELDS_";")[";12;")&((";"_SDFIELDS_";")'[";3;") S SDNUM=$L(SDFFLD,";") D
 . F SDI=1:1:SDNUM S SDR=$P(SDFFLD,";",SDI) I SDR=12 S $P(SDFFLD,";",SDI)=3 Q
 ;
 S SDARRAY("FLDS")=$S(SDFFLD'="":SDFFLD,1:1)
 F SDI=1:1 S SDTMP=$P(SDFIELDS,";",SDI) Q:SDTMP=""  S SDFS(SDTMP)=SDI
 ; Setup done, call SDAPI, quit if no appointment (SDCOUNT=0) and return 0
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY) Q:SDCOUNT=0 0
 ;If we have an appointment, process it
 I SDCOUNT=1,SDFIELDS'="" S SDFLDCNT=$L(SDFIELDS,";") D:SDPATIEN'=""
 . ;If malformed appointment data, set SDCOUNT to 0, quit
 . S SDCLN=$O(^TMP($J,"SDAMA301",SDPATIEN,"")) I SDCLN="" S SDCOUNT=0 Q
 . S SDAPT=$O(^TMP($J,"SDAMA301",SDPATIEN,SDCLN,"")) I SDAPT="" S SDCOUNT=0 Q
 . S SD310=$G(^TMP($J,"SDAMA301",SDPATIEN,SDCLN,SDAPT)) I SD310="" S SDCOUNT=0 Q
 . S SDTMP="" F SDI=1:1:SDFLDCNT S SDTMP=$O(SDFS(SDTMP)) Q:SDTMP=""  D
 .. I "^1^5^9^11^"[(U_SDTMP_U) S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=$P(SD310,U,SDTMP) Q
 .. I "^2^4^8^10^"[(U_SDTMP_U) S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=$TR($P(SD310,U,SDTMP),";","^") Q
 .. I SDTMP=7 S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=$S($P(SD310,"^",SDTMP)="":"N",1:$P(SD310,"^",SDTMP)) Q
 .. S SDFLD="FLD"_SDTMP
 .. I "^3^6^12^"[(U_SDTMP_U) D @(SDFLD)
 ;If err, set up err node
 I SDCOUNT=-1 D
 . S SDERR=$O(^TMP($J,"SDAMA301",""))
 . S SDERR=$S(SDERR=101:101,SDERR=115:114,SDERR=116:114,1:117)
 . D ERROR^SDAMA200(SDERR,"NEXTAPPT",0,"SDAMA201")
 K ^TMP($J,"SDAMA301")
 Q SDCOUNT
 ;Xlate output from SDAPI as required
FLD3 S SDR=$P($P(SD310,U,SDTMP),";",1)
 S SDR=$S(SDR="I":"R",SDR?1(1"CC",1"CP",1"CPR"):"C",SDR?1(1"NS",1"NSR"):"N",1:SDR)
 S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=SDR Q
FLD6 S SDR=$G(^TMP($J,"SDAMA301",SDPATIEN,SDCLN,SDAPT,"C"))
 S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=SDR Q
FLD12 S SDR=$P($P(SD310,U,3),";",1)
 S SDR=$S(SDR="I":"I",SDR="R":"O",SDR="NT":"O",1:"")
 S ^TMP($J,"SDAMA201","NEXTAPPT",SDTMP)=SDR Q
