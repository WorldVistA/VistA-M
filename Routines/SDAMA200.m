SDAMA200 ;BPOIFO/ACS-Scheduling Replacement API Errors and Validation ; 12/13/04 3:13pm
 ;;5.3;Scheduling;**253,275,310,283,347**;13 Aug 1993
 ;
 ;*******************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -------------------------------------
 ;09/20/02  SD*5.3*253    ROUTINE COMPLETED
 ;12/10/02  SD*5.3*275    ADDED PATIENT STATUS FILTER AND VALIDATION
 ;08/15/03  SD*5.3*310    ADD ERROR 114
 ;08/19/03  SD*5.3*283    ADDED 'NT' APPT STATUS  MULTIPLE APPT STATUS
 ;                        VALUES ALLOWED, NULL FIELD LIST ALLOWED.  
 ;                        REMOVED ERROR CODE 107.
 ;07/26/04  SD*5.3*347    NEW VARIABLES USED IN ^%DTC CALL.
 ;                        ALLOW FOR APPOINTMENT STATUSES R,NT OR
 ;                        R AND NT TO BE PASSED IF THE PATIENT STATUS
 ;                        IS SET TO O.
 ;
 ;*******************************************************************
 ;-------------------------------------------------------------------
 ;             *** VALIDATE INPUT PARAMETERS ***
 ;INPUT
 ;  SDIEN         Patient, clinic, or facility IEN (required)
 ;  SDFIELDS      Fields requested (optional)
 ;  SDAPSTAT      Appointment status (optional)
 ;  SDSTART       Start date (optional)
 ;  SDEND         End date (optional)
 ;  SDAPINAM      The API that is calling this routine (required)
 ;  SDRTNNAM      The routine that is calling this routine (required)
 ;  SDIOSTAT      Patient status filter
 ;-------------------------------------------------------------------
 ;
VALIDATE(SDIEN,SDFIELDS,SDAPSTAT,SDSTART,SDEND,SDAPINAM,SDRTNNAM,SDIOSTAT) ;
 ;
 N SDERRFLG
 S SDERRFLG=0
 ;Validate IEN
 I $G(SDIEN)="" D ERROR($S(SDAPINAM="GETPLIST":104,1:102),SDAPINAM,.SDERRFLG,SDRTNNAM)
 I $G(SDIEN)'="",+$G(SDIEN)'=$G(SDIEN) D ERROR(110,SDAPINAM,.SDERRFLG,SDRTNNAM)
 ;
 ;Validate Appointment Status Filter
 I $L($G(SDAPSTAT))>0 D
 . ;validate each status, build new status list if necessary
 . N SDNUM,SDPIECE,SDQUIT,SDAPVAL,SDNEWAP
 . S SDQUIT=0
 . ;get count of values passed in
 . S SDNUM=$L(SDAPSTAT,";")
 . S SDNEWAP=";"
 . ;check each value passed in
 . F SDPIECE=1:1:SDNUM S SDAPVAL=$P(SDAPSTAT,";",SDPIECE) D  Q:SDQUIT=1
 .. I $G(SDAPVAL)="" D ERROR(109,SDAPINAM,.SDERRFLG,SDRTNNAM) S SDQUIT=1 Q
 .. I ";R;C;N;NT;"'[(";"_SDAPVAL_";") D ERROR(109,SDAPINAM,.SDERRFLG,SDRTNNAM) S SDQUIT=1 Q
 .. ;build status string
 .. S SDNEWAP=SDNEWAP_SDAPVAL_";"
 .S SDAPSTAT=SDNEWAP
 ;set appointment status filter to 'all' if null or undefined
 I $G(SDAPSTAT)="" S SDAPSTAT=";R;C;N;NT;"
 ;
 ;Validate start and end date/time variables if they are passed in
 N SDSTVAL,SDENDVAL,%H,%T,%Y,X
 S (SDSTVAL,SDENDVAL)=0
 I $G(SDSTART)'="" D
 . I +SDSTART'=SDSTART D ERROR(105,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 . S X=SDSTART D H^%DTC I %H=0 D ERROR(105,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 . S SDSTVAL=1
 I $G(SDEND)'="" D
 . I +SDEND'=SDEND D ERROR(106,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 . S X=SDEND D H^%DTC I %H=0 D ERROR(106,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 . S SDENDVAL=1
 ;If start and end dates are valid, make sure start date not > end date
 I SDSTVAL,SDENDVAL D
 . I SDSTART>SDEND D ERROR(111,SDAPINAM,.SDERRFLG,SDRTNNAM)
 ;
 ;Remove beginning and ending semi-colons from SDFIELDS list if present
 I $L($G(SDFIELDS))>0 D
 . I $E($G(SDFIELDS),1,1)=";" D
 .. S SDFIELDS=$E(SDFIELDS,2,$L(SDFIELDS))
 .. I $G(SDFIELDS)="" D ERROR(103,SDAPINAM,.SDERRFLG,SDRTNNAM)
 .I $L($G(SDFIELDS))>0 D
 .. I $E($G(SDFIELDS),$L($G(SDFIELDS)),$L($G(SDFIELDS)))=";" D
 ... S SDFIELDS=$E(SDFIELDS,1,$L(SDFIELDS)-1)
 ... I $G(SDFIELDS)="" D ERROR(103,SDAPINAM,.SDERRFLG,SDRTNNAM)
 ;
 ;Validate SDFIELDS list 
 N SDI,SDFIELD,SDNUM,SDEND
 S (SDI,SDFIELD,SDNUM,SDEND)=0
 ;Check field list for valid numbers requested
 I $G(SDFIELDS)]"" D
 . ;get number of pieces
 . S SDNUM=$L(SDFIELDS,";")
 . ;validate each piece
 . F SDI=1:1:SDNUM S SDFIELD=$P(SDFIELDS,";",SDI) D  Q:SDEND
 .. I $G(SDFIELD)="" D ERROR(103,SDAPINAM,.SDERRFLG,SDRTNNAM) S SDEND=1 Q
 .. I '$D(^SDAM(44.3,SDFIELD)) D ERROR(103,SDAPINAM,.SDERRFLG,SDRTNNAM) S SDEND=1 Q
 ;If field list is null and API is not NEXTAPPT, set up to include all
 I ($G(SDFIELDS)="")&(SDAPINAM'="NEXTAPPT") S SDI=0 D
 . F  S SDI=$O(^SDAM(44.3,SDI)) Q:+$G(SDI)=0  D
 .. S SDFIELDS=$G(SDFIELDS)_SDI_";"
 . ;remove ending semi-colon
 . S SDFIELDS=$E(SDFIELDS,1,$L(SDFIELDS)-1)
 ;
 ;Validate Patient Status Filter
 I $L($G(SDIOSTAT))>0 D
 . I $L(SDIOSTAT)>1 D ERROR(112,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 . I "IO"'[SDIOSTAT D ERROR(112,SDAPINAM,.SDERRFLG,SDRTNNAM) Q
 ;set patient status filter to 'both' if null or undefined
 I $G(SDIOSTAT)="" S SDIOSTAT="IO"
 ;
 ;Validate Appt Status and Patient Status Filter Combination 
 ;if they specify a patient status, they must specify scheduled/kept appt type "R"
 I $G(SDIOSTAT)="I",$G(SDAPSTAT)'=";R;" D ERROR(113,SDAPINAM,.SDERRFLG,SDRTNNAM)
 I $G(SDIOSTAT)="O",$S($G(SDAPSTAT)=";R;":0,$G(SDAPSTAT)=";NT;":0,$G(SDAPSTAT)=";R;NT;":0,$G(SDAPSTAT)=";NT;R;":0,1:1) D ERROR(113,SDAPINAM,.SDERRFLG,SDRTNNAM)
 ;
 I SDERRFLG>0 Q -1
 Q 1
 ;
ERROR(SDERRNUM,SDAPINAM,SDERRFLG,SDRTNNAM) ;
 ;Put error message in ^TMP global
 S SDERRFLG=1
 S $P(^TMP($J,SDRTNNAM,SDAPINAM,"ERROR",SDERRNUM),"^",1)=$P($T(@SDERRNUM),";;",2)
 Q
 ;
 ;***************************************************************
 ; ERROR CODES AND MESSAGES USED FOR PARAMETER VALIDATION
 ;***************************************************************
 ;
101 ;;DATABASE IS UNAVAILABLE
102 ;;PATIENT ID IS REQUIRED
103 ;;INVALID FIELD LIST
104 ;;CLINIC ID IS REQUIRED
105 ;;INVALID START DATE
106 ;;INVALID END DATE
108 ;;FACILITY ID IS REQUIRED
109 ;;INVALID APPOINTMENT STATUS FILTER
110 ;;ID MUST BE NUMERIC
111 ;;START DATE CAN'T BE AFTER END DATE
112 ;;INVALID PATIENT STATUS FILTER
113 ;;APPT STATUS AND PATIENT STATUS FILTER COMBINATION UNSUPPORTED IN VISTA
114 ;;INVALID PATIENT ID
116 ;;DATA MISMATCH
117 ;;SDAPI ERROR
 ;
 ;------------------------------------------------------------------
 ;Additional APIs called from GETAPPT, GETPLIST, NEXTAPPT, GETALLCL
 ;------------------------------------------------------------------
 ;
PATAPPT(SDPATIEN) ;For a patient IEN, return Boolean value for existence of appointments on ^DPT
 I $D(^DPT(SDPATIEN,"S")) Q 1
 Q 0
 ;
CLNAPPT(SDCLIEN) ;For a clinic IEN, return Boolean value for existence of appointments on ^SC
 I $D(^SC($G(SDCLIEN),"S")) Q 1
 Q 0
GETCLIEN(SDPATIEN,SDAPPTDT) ; For a patient and appt date, return the clinic IEN on ^DPT
 Q $P($G(^DPT($G(SDPATIEN),"S",$G(SDAPPTDT),0)),"^",1)
 ;
GETPTIEN(SDCLIEN,SDAPPTDT,SDPATCNT) ; For a clinic, appt date, and node, return the patient IEN on ^SC
 Q $P($G(^SC($G(SDCLIEN),"S",$G(SDAPPTDT),1,$G(SDPATCNT),0)),"^",1)
 ;
GETSDDA(SDCLIEN,SDAPPTDT,SDPATIEN) ; For a clinic, appt date, and patient, return the SDDA node number on ^SC
 N SDPATCNT,SDMATCH
 S SDPATCNT=0,SDMATCH=0
 F  S SDPATCNT=$O(^SC($G(SDCLIEN),"S",$G(SDAPPTDT),1,SDPATCNT)) D  Q:('SDPATCNT!SDMATCH)
 . I 'SDPATCNT Q
 . I $P($G(^SC(SDCLIEN,"S",SDAPPTDT,1,SDPATCNT,0)),"^",1)=SDPATIEN S SDMATCH=1
 Q $G(SDPATCNT)
 ;
GETASTAT(SDPATIEN,SDAPPTDT) ;For a patient and appt date, return Appointment Status (N, C, R, or NT)
 N SDSTAT
 S SDSTAT=$P($G(^DPT(SDPATIEN,"S",SDAPPTDT,0)),"^",2)
 S SDSTAT=$S($G(SDSTAT)="NT":"NT",$G(SDSTAT)="I":"R",$G(SDSTAT)["N":"N",$G(SDSTAT)["C":"C",1:"R")
 Q SDSTAT
 ;
GETPSTAT(SDPATIEN,SDAPPTDT) ;For a patient and appt date, return Patient Status (I or O)
 N SDSTAT
 S SDSTAT=$P($G(^DPT(SDPATIEN,"S",SDAPPTDT,0)),"^",2)
 S SDSTAT=$S($G(SDSTAT)="I":"I",1:"O")
 Q SDSTAT
 ;
