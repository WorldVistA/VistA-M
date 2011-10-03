SDAMA306 ;BPOIFO/ACS-Filter API Utilities ; 6/21/05 1:50pm
 ;;5.3;Scheduling;**301,347,508**;13 Aug 1993
 ;PER VHA DIRECTIVE 2004-038, DO NOT MODIFY THIS ROUTINE
 ;
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
 ;02/22/07  SD*5.3*508    SEE SDAMA301 FOR CHANGE LIST
 ;*****************************************************************
 ;*****************************************************************
 ;
 ;INPUT
 ;  SDARRAY   Appointment Filter array (by reference)
 ;  
 ;*****************************************************************
INITAE(SDARRAY) ;Initialize Array Entries as needed
 ;Initialize Appointment "From" and "To" dates if null
 N SDI
 F SDI=1,16  D INITDTS(SDI)
 ;
 ;Initialize Fields Array if ALL Fields Requested
 D:($$UPCASE(SDARRAY("FLDS"))="ALL") INITFLDS(.SDARRAY)
 ;
 ;Remove leading and trailing semi-colons from filter lists if present
 N SDNODE
 F SDNODE=2,3,4,13,"FLDS" D
 . I $L($G(SDARRAY(SDNODE)))>0 D
 .. I $E(SDARRAY(SDNODE),$L(SDARRAY(SDNODE)))=";" D
 ... S SDARRAY(SDNODE)=$E(SDARRAY(SDNODE),1,($L(SDARRAY(SDNODE))-1))
 .. I $E(SDARRAY(SDNODE),1)=";" D
 ... S SDARRAY(SDNODE)=$E(SDARRAY(SDNODE),2,$L(SDARRAY(SDNODE)))
 ;
 ;If the patient list is in a global, add comma at end if needed
 S SDARRAY("PATGBL")=0
 I $G(SDARRAY(4))["(" D
 . ;flag as patient global input
 . S SDARRAY("PATGBL")=1
 . ;add comma to end of global root if needed
 . N SDLCHAR S SDLCHAR=$E(SDARRAY(4),$L(SDARRAY(4)))
 . I SDLCHAR="," Q
 . E  I SDLCHAR'="(" S SDARRAY(4)=SDARRAY(4)_","
 ;
 ;If the clinic list is in a global, add comma at end if needed
 S SDARRAY("CLNGBL")=0
 I $G(SDARRAY(2))["(" D
 . ;flag as clinic global input
 . S SDARRAY("CLNGBL")=1
 . ;add comma to end of global root if needed
 . N SDLCHAR S SDLCHAR=$E(SDARRAY(2),$L(SDARRAY(2)))
 . I SDLCHAR="," Q
 . E  I SDLCHAR'="(" S SDARRAY(2)=SDARRAY(2)_","
 ;Initialize Encounter Filter
 S SDARRAY("ENCTR")=$$UPCASE($G(SDARRAY(12)))
 Q
 ;
 ;***************************************************
 ;INPUT
 ;      SDFLTR    Filter to initialize
 ;***************************************************
INITDTS(SDFLTR) ;initialize Appt Date/Time and Date Appt Made
 N SDFROM,SDTO,SDYR,SDDAY,SDMNTH,SDTIME,SDVAR
 ;initialize variables to passed in values
 S SDFROM=$P($G(SDARRAY(SDFLTR)),";",1)
 S SDTO=$P($G(SDARRAY(SDFLTR)),";",2)
 ;replace day and month to Jan 01 (0101) if 0s or "" are passed
 ;replace time with 2359 if time is greater than 2359
 F SDVAR="SDFROM","SDTO"  D
 .I @SDVAR'="" D
 ..S SDYR=$E(@SDVAR,1,3),SDMNTH=$E(@SDVAR,4,5),SDDAY=$E(@SDVAR,6,7)
 ..S SDTIME=$P(@SDVAR,".",2) S:(SDTIME'="") SDTIME="."_SDTIME
 ..S:(+SDDAY'>0) SDDAY="01"
 ..S:(+SDMNTH'>0) SDMNTH="01"
 ..S:((+SDTIME'=0)&(+SDTIME>.2359)) SDTIME=.2359
 ..S @SDVAR=SDYR_SDMNTH_SDDAY
 ..S:(SDTIME'="") @SDVAR=@SDVAR_SDTIME
 ;initialize SDTO to default if null
 I $G(SDTO)="" D
 .S:SDFLTR=1 SDTO="9999999.9999"
 .S:SDFLTR=16 SDTO="9999999"
 ;if date passed in without time for Appt Date/Time filter add time
 I SDFLTR=1,SDTO'["." S SDTO=SDTO_".2359"
 ;create new variables to reference Date(/Time)s
 I SDFLTR=1 D
 .S SDARRAY("FR")=$G(SDFROM)
 .S SDARRAY("TO")=$G(SDTO)
 I SDFLTR=16 D
 .S SDARRAY("DAMFR")=$G(SDFROM)
 .S SDARRAY("DAMTO")=$G(SDTO)
 Q
 ;
 ;*****************************************************************
 ;INPUT
 ;  SDARRAY   Appointment Filter array (by reference)
 ;*****************************************************************
INITFLDS(SDARRAY) ;initialize Fields Requested
 N SDFLD
 S SDARRAY("FLDS")=""  ;Reset Field Array
 ;add all available fields to Field Request
 F SDFLD=1:1:26,28:1:SDARRAY("FC") S SDARRAY("FLDS")=SDARRAY("FLDS")_SDFLD_";"
 Q
UPCASE(SDDATA) ;ensure RSA text is upper case
 Q $TR(SDDATA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
