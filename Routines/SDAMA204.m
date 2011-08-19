SDAMA204 ;BPOIFO/NDH-Scheduling Replacement APIs ; 12/13/04 3:16pm
 ;;5.3;Scheduling;**310,347**;13 Aug 1993
 ;
 ;PATAPPT - Determines if an appointment exists for a patient.
 ;
 ;**   BEFORE USING THE API IN THIS ROUTINE, PLEASE SUBSCRIBE    **
 ;**   TO DBIA #4216                                             **
 ;
 ;*****************************************************************
 ;              CHANGE LOG
 ;
 ;  DATE      PATCH       DESCRIPTION
 ;--------  ----------    -----------------------------------------
 ;08/11/03  SD*5.3*310    API PATIENT APPOINTMENT EXISTS
 ;07/26/04  SD*5.3*347    API Patient Appointment supports distributed
 ;                        appointment files (whether actual files are
 ;                        located in VistA DB or Oracle DB).
 ;
 ;*****************************************************************
 ;
PATAPPT(SDDFN) ; Check for existence of any appointment for a patient
 ; 
 ;       This API is an extrinsic function that returns 1 of 3 values.
 ;       The API checks for the existence of appointment records.
 ; 
 ;       INPUT    SDDFN : Patient's DFN number (required)
 ; 
 ;       OUTPUT       1 : Appointment(s) on file
 ;                    0 : No appointment(s) on file
 ;                   -1 : Error
 ;                   
 ; ERROR CODES - 101 : Database is Unavailable
 ;               102 : Patient ID is required
 ;               110 : Patient ID must be numeric
 ;               114 : Invalid Patient ID
 ;               117 : SDAPI Error
 ; 
 ; ERROR LOCATION : ^TMP($J,"SDAMA204","PATAPPT","ERROR")
 ; 
 ; Check for proper parameter and return -1 if bad DFN
 ; 
 ; Initialize node for error reporting
 K ^TMP($J,"SDAMA204","PATAPPT")
 N SDARRAY,SDCOUNT,SDX,SDY,DFN,VAERR
 ; 
 ; Check for no input parameter
 I '$D(SDDFN) D  Q -1
 .D ERROR^SDAMA200(102,"PATAPPT",0,"SDAMA204")
 ; Check if SDDFN is numeric
 I SDDFN'?1.N D  Q -1
 .D ERROR^SDAMA200(110,"PATAPPT",0,"SDAMA204")
 ; Check if DFN exists or is 0
 S DFN=SDDFN
 D DEM^VADPT
 I SDDFN=0!VAERR=1 D  Q -1
 .D ERROR^SDAMA200(114,"PATAPPT",0,"SDAMA204")
 D KVAR^VADPT
 ; Check for patient appointments and return 1 if appointment found
 ; and 0 if no appointments found.
 ;
 S SDARRAY(4)=DFN,SDARRAY("FLDS")=1,SDARRAY("MAX")=1
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)
 I SDCOUNT=0 Q 0 ; No Appt found.
 I SDCOUNT=1 K ^TMP($J,"SDAMA301") Q 1  ; Appt(s). found.
 ; Error Encountered.
 I SDCOUNT=-1 D
 .S SDX=$O(^TMP($J,"SDAMA301",""))
 .S SDX=$S(SDX=101:101,SDX=115:114,SDX=116:114,1:117)
 .D ERROR^SDAMA200(SDX,"PATAPPT",0,"SDAMA204")
 .K ^TMP($J,"SDAMA301")
 Q -1
