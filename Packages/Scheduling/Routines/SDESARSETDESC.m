SDESARSETDESC  ;ALB/RRM - VISTA SCHEDULING ; Jun 10, 2022@15:02
 ;;5.3;Scheduling;**819**;Aug 13, 1993;Build 5
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Below are the input parameter description for SDES CREATE APPT REQ RPC
 ;
 ; INP - Input parameters array
 ;   ARIEN       =   (integer) IEN point to SDEC APPT REQUEST file 409.85. If null, a new entry will be added
 ;   DFN         =   DFN Pointer to the PATIENT file 2
 ;   EDT         =   DATE/TIME ENTERED (#409.85,9.5) in ISO8601 date/time format to include offset (e.g. CCYY-MM-DDTHH:MM-NNNN)
 ;   INST        =   Institution name from the INSTITUTION file
 ;   TYPE        =   APPT Request Type - 5 types: APPT, MOBILE, W2VA, RTC,and VETERAN
 ;   CLIN        =   REQ Specific Clinic name - NAME field in file 44
 ;   USER        =   Originating User name - NAME field in NEW PERSON file 200
 ;   REQBY       =   Request By - 'PROVIDER' or 'PATIENT'
 ;   PROV        =   Provider name - NAME field in NEW PERSON file 200
 ;   DAPTDT      =   Desired Date of appt in ISO8601 date format (e.g. CCYY-MM-DD)
 ;   COMM        =   Comment must be 1-60 characters.
 ;   ENPRI       =   ENROLLMENT PRIORITY - Valid Values are "GROUP 1" through "GROUP 8"
 ;   MAR         =   MULTIPLE APPT RTC N/Y
 ;   MAI         =  (integer) MULT APPT RTC INTERVAL integer between 1-365
 ;   MAN         =  (integer) MULT APPT NUMBER integer between 1-100
 ;   PATCONT     =   Patient Contacts separated by :: Each :: piece has the following ~~ pieces: 1)=DATE ENTERED (#409.8544,.01) in ISO8601 date/time format including offset
 ;                   2)=PC ENTERED BY USER ID or NAME - Pointer to NEW PERSON file or NAME
 ;                   4)=(opt)ACTION-valid values are: "C"alled, "M"essage left or "L"etter 5)=(opt)PATIENT PHONE Free-Text 4-20 characters 6) = NOT USED (opt) Comment 1-160 characters
 ;   SVCCON      =  (optional) SC Y/N
 ;   SVCCOP      =  (optional) SC % = 0-100
 ;   MRTCPREFDT  =  (optional) MRTC calculated preferred dates separated by pipe "|" dates are in IS08601 date format (no time)  e.g., CCYY-MM-DD  ;vse-2396
 ;   STOP        =  (optional) CLINIC STOP pointer to CLINIC STOP file 40.7 used to populate the REQ SERVICE/SPECIALTY field in 409.85
 ;   APTYP       =  (optional) APPT Type ID pointer to APPT TYPE file 409.1
 ;   PATSTAT     =  (optional) Patient Status  N = NEW  E = ESTABLISHED
 ;   MULTIAPTMADE=  (optional) MULT APPTS MADE  List of child pointers to SDEC APPT and/or SDEC APPT REQUEST files  1. APPT Id pointer to SDEC APPT file 409.84 2. Request Id pointer to SDEC APPT REQUEST file 409.85
 ;   PARENT      =  (optional) PARENT REQUEST pointer to SDEC APPT REQUEST file 409.85
 ;   NLT         =  (optional) NLT (No later than) [CPRS RTC REQUIREMENT]
 ;   PRER        =  (optional) PREREQ (Prerequisites) [CPRS RTC REQUIREMENT]
 ;   ORDN        =  (optional) ORDER IEN [CPRS RTC REQUIREMENT]
 ;   VAOSGUID    =  (optional) VAOS GUID
 ;   EAS         =  (optional) Enterprise APPT Scheduling Tracking Number associated to an appt.
 ;   PCMT        =  (optional) Patient-entered comments when using VAOS or other web-service (stored at 409.85,60 a word processing field)
 ;   INSTIEN     =  (optional) STATION NUMBER (#99),INSTITUTION (#4)
 ;   PATDATEPREFS=  (optional) Array up to 3 date ranges indicating the date preferences for a particular patient
 ;   ARSTOPSEC   =  (optional) Secondary Stop Code Number pointer to CLINIC STOP file #40.7 used to populate the REQ SECONDARY STOP CODE field in 409.85
 ;   MODALITY    =  (optional )MODALITY - 3 types: FACE2FACE, TELEPHONE, VIDEO
 ;
 Q
