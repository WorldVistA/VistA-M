SDAMA301 ;BPOIFO/ACS-Filter API Main Entry ; 1/3/06 12:45pm
 ;;5.3;Scheduling;**301,347,426,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
 ;**   THIS IS A SUPPORTED API: SEE DBIA #4433                   **
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;12/04/03  SD*5.3*301    ROUTINE COMPLETED
 ;08/06/04  SD*5.3*347    ADDITION OF A NEW FILTER - DATE APPOINTMENT
 ;                        MADE (FIELD #16) AND 2 NEW FIELDS TO RETURN:
 ;                        1) AUTO-REBOOKED APPT DATE/TIME (FIELD #24)
 ;                        2) NO-SHOW/CANCEL APPT DATE/TIME (FIELD #25)
 ;02/22/07  SD*5.3*508    ADDITION OF A NEW PARAMETER - "PURGED"
 ;                        RETURNS NON-CANCELED VISTA APPTS THAT EXIST
 ;                        ONLY IN SUB-FILE (#2.98).  ADDITION OF 8
 ;                        NEW FIELDS TO RETURN:
 ;                        1) RSA APPT ID (FIELD #26)
 ;                        2) 2507 REQUEST IEN (FIELD #27)
 ;                        3) DATA ENTRY CLERK (FIELD #28)
 ;                        4) NO-SHOW/CANCELED BY (FIELD #29)
 ;                        5) CHECK-IN USER (FIELD #30)
 ;                        6) CHECK-OUT USER (FIELD #31)
 ;                        7) CANCELLATION REASON (FIELD #32)
 ;                        8) CONSULT IEN (FIELD #33)
 ;*****************************************************************
 ;
 ;*****************************************************************
 ;
 ;               GET APPOINTMENT DATA
 ;
 ;INPUT
 ;  SDINPUT   Appointment Filters (required)
 ;  
 ;OUTPUT
 ;  Extrinsic call returns: 
 ;    -1 if error
 ;    Appointment count if no error
 ;  If no error, data returned in:
 ;    ^TMP($J,"SDAMA301",SORT1,SORT2,Appt Date/Time)=DATAn^DATAn^..
 ;    where SORT1 is first sort (patient or clinic), SORT2 is
 ;    second sort (patient or clinic), and DATAn
 ;    is the appointment data requested for Fields 1-27
 ;    ^TMP($J,"SDAMA301",SORT1,SORT2,Appt Date/Time,0)=DATAn^DATAn^..
 ;    where DATAn is the appointment data requested for Fields 28-32
 ;    (Use the MODULO Operator Ie. Field 28#27 = 1, 29#27=2 ...)
 ;    ^TMP($J,"SDAMA301",SORT1,SORT2,Appt Date/Time,"C")=COMMENTS
 ;  If RSA appointments are returned then the following global
 ;    will exist detailing the source of the RSA appointments.
 ;    ^TMP($J,"SDAMA301","SOURCE")="RSA" - From Remote RSA Database
 ;    ^TMP($J,"SDAMA301","SOURCE")="VistA Backup" - From Local VistA
 ;  If errors, error codes and messages returned in:
 ;    ^TMP($J,"SDAMA301",error_code)=error_message
 ;  
 ;*****************************************************************
SDAPI(SDINPUT) ;main API controller
 N SDARRAY,SDFLTR,SDQUIT
 S SDQUIT=0
 S SDQUIT=$$INIT(.SDINPUT,.SDARRAY,.SDFLTR)  ;initialize environment
 Q:(SDQUIT) -1  ;input array error
 Q $$APPTS(.SDARRAY,.SDFLTR)  ;Retrieve VistA and RSA Appointments
 ;
 ;*****************************************************************
 ;INPUT
 ;  SDINPUT   Appointment Filters (Required / By Reference)
 ;  SDARRAY   Array to hold working copy of Appt Filter Array
 ;            (Required / By Reference)
 ;  SDFLTR    Filter Flag Array (Required / By Reference)
 ;  
 ;OUTPUT
 ;    Extrinsic call returns: 
 ;      1 if error occurred initializing environment
 ;      0 if no error occurred  
 ;*****************************************************************
INIT(SDINPUT,SDARRAY,SDFLTR) ;
 K ^TMP($J,"SDAMA301")
 ;Initialize global variables
 N SDI,SDQUIT
 S (SDARRAY("CNT"),SDARRAY("RSA"),SDQUIT,SDFLTR)=0
 ;Set Field Count and Max Filter variables
 S SDARRAY("FC")=33,SDARRAY("MF")=6
 ;Copy input array into "working" array
 F SDI=1:1:SDARRAY("FC") S SDARRAY(SDI)=$G(SDINPUT(SDI))
 S SDARRAY("FLDS")=$G(SDINPUT("FLDS"))  ;fields to return to app.
 S SDARRAY("MAX")=$G(SDINPUT("MAX"))  ;# of records to return (-/+)
 S SDARRAY("SORT")=$G(SDINPUT("SORT"))  ;removes clinic ien from root
 S SDARRAY("VSTAPPTS")=$G(SDINPUT("VSTAPPTS"))  ;get only VistA Appts
 S SDARRAY("PURGED")=$G(SDINPUT("PURGED"))  ;get Purged VistA Appts
 ;Initialize Input Array Filters as needed. Quit if error
 D INITAE^SDAMA306(.SDARRAY)
 Q:SDQUIT 1
 ;Validate Input Array Filters.  Quit if error
 I ($$VALARR^SDAMA300(.SDARRAY,.SDFLTR)=-1) S SDQUIT=1
 Q SDQUIT
 ;
 ;*****************************************************************
 ;INPUT
 ;  SDARRAY   Array to hold working copy of Appt Filter Array
 ;            (Required / By Reference)
 ;  SDFLTR    Filter Flag Array (Required / By Reference)
 ;  
 ;OUTPUT
 ;    Extrinsic call returns: 
 ;      #<0 if error occurred retrieving appointments
 ;      0 if no appointments exist (Based on Filter Criteria)
 ;      #>0 Number of Appointments returned 
 ;*****************************************************************
APPTS(SDARRAY,SDFLTR) ;retrieve appointments
 ;initialize variables
 N SDDV
 ;If Patient DFN populated, process by patient
 I $G(SDARRAY(4))]"" D
 . ;set RSA flag to true if clinic filter not defined
 . S:($G(SDARRAY(2))']"") SDARRAY("RSA")=1
 . ;get data
 . D PAT^SDAMA303(.SDARRAY,.SDDV,.SDFLTR)
 . ;if clinic filter defined and RSA flag is false
 . ;ensure RSA does not need to be called.
 . D:(($G(SDARRAY(2))]"")&(SDARRAY("RSA")=0)) CALLRSA^SDAMA307(.SDARRAY)
 ;
 ;If Patient DFN is not populated, process by clinic
 I $G(SDARRAY(4))']"" D
 . D CLIN^SDAMA302(.SDARRAY,.SDDV,.SDFLTR)
 ;
 ;--Phase II--
 ;If RSA flag = "true" and RSA is implemented, and the user has not
 ;requested only VistA appointments ("VSTAPPTS"=1), then get data 
 ;from RSA
 D:(('+SDARRAY("VSTAPPTS"))&(SDARRAY("RSA"))&($$IMP^SDAMA307())) DATA^SDAMA307(.SDARRAY)
 ;
 ;Pass back appointment count
 Q SDARRAY("CNT")
