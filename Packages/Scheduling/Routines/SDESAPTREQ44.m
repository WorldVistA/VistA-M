SDESAPTREQ44 ;ALB/ANU,KML - APPOINTMENT REQUEST CREATE/UPDATE IN FILE44 ;Feb 16, 2022
 ;;5.3;Scheduling;**805,809**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ; This entry point is used for both the SDES SET APT REQ 44 CREATE and SDES SET APT REQ 44 UPDATE RPCs.
 ; The parameter list for each RPC must be kept in sync.  This includes in the Remote Procedure file definition.
 ;
ARSET(RETURN,ARUPD,ARIEN,DFN,ARDAPTDT,ARLEN,ARRSN,ARUSER,ARODT,PATELG,AROVR) ; Create/Update Appointment Request
 ; INP - Input parameters array
 ;  ARUPD     = (integer)   1 for Update and 0 for Create Appointment
 ;  ARIEN     = (integer)   IEN point to HOSPTIAL LOCATION file 44
 ;                          If null, a new entry will be added
 ;  DFN       = (text)      DFN Pointer to the PATIENT file 2
 ;  ARDAPTDT  = (date/time) APPOINTMENT DATE/TIME in ISO8601 extended format (e.g. 2021-12-22T20:30-0500) ;vse-2097
 ;  ARLEN     = (integer)   Appointment length in minutes (5 - 120)
 ;  ARRSN     = (text)      Reason for Appointment upto 150 characters
 ;  ARUSER    = (text)      Originating User name  - NAME field in NEW PERSON file 200
 ;  ARODT     = (date ONLY) DATE APPOINTMENT MADE in ISO8601 extended format (e.g. 2021-12-22)
 ;  PATELG    = (text)      Eligibility of Visit
 ;  AROVR    = (integer)    Overbook flag - 1=yes
 ;
 N POP,SDAPTREQ,ARORIGDT,AUDF,FNUM
 ;
 D VALIDATE
 I 'POP D
 .I +ARUPD=1 D UPDATE Q
 .I +ARUPD=0 D CREATE Q
 D BUILDER
 Q
 ;
VALIDATE ;
 S POP=0,AUDF=0,FNUM=44
 ;
 ;
 I ARUPD'=1,ARUPD'=0 S SDAPTREQ("Error",1)="Invalid Update Flag." Q
 ;
 ; Clinic IEN
 S ARIEN=$G(ARIEN,"")
 I ARIEN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,18) Q
 I '$D(^SC(+ARIEN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,19) Q
 I $$INACTIVE^SDEC32(+ARIEN) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,19) Q
 ;
 ; Patient DFN
 S DFN=$G(DFN,"")
 I DFN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,1) Q
 I DFN'="",'$D(^DPT(+DFN,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,2) Q
 ;
 ; Desired date/time of appt
 S ARDAPTDT=$G(ARDAPTDT,"")
 I ARDAPTDT="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,57) Q
 S ARDAPTDT=$$ISOTFM^SDAMUTDT(ARDAPTDT,ARIEN) ; vse-2397  clinic time zone
 I ARDAPTDT=-1 S ARDAPTDT="",POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,58) Q
 I ARUPD=0,ARDAPTDT<DT S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,59) Q  ;Only validate on Create
 ;
 ; Originating Dt/Tm
 S ARODT=$G(ARODT,"")
 I ARODT'="" S ARODT=$$ISOTFM^SDAMUTDT(ARODT) ;vse-2397  date only, NO TIME
 I ARODT=-1 S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,49) Q
 I ARODT="" S ARODT=$$DT^XLFDT  ;vse-2397  ARODT is date only; stored at DATE APPOINTMENT MADE field (44.003,8)
 ;
 ; Appointment Length in Minutes
 S ARLEN=$G(ARLEN,"")
 I ARUPD=0,ARLEN="" S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,115) Q
 I ARLEN'="",((+ARLEN<5)!(+ARLEN>120)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,116) Q
 ;
 ; Appointment Reason
 S ARRSN=$G(ARRSN,"")
 S ARRSN=$TR($G(ARRSN),"^"," ")
 ;
 ; Requesting User
 S ARUSER=$G(ARUSER,"")
 I '$D(^VA(200,+$G(ARUSER),0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,44) Q
 ;
 ; Overbook
 S AROVR=$G(AROVR,"")
 I AROVR'="" D
 . I AROVR'=1,AROVR'=0 S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,112) Q
 ;
 ; Patient Eligibility
 S PATELG=$G(PATELG,"")
 I PATELG'="",'$D(^DIC(8,+PATELG,0)) S POP=1 D ERRLOG^SDESJSON(.SDAPTREQ,143) Q
 ;
 Q
 ;
CREATE ;Build FDA array to creat a new entry in 44
 ; add appt to file 44
 N IEN
 S IEN=$$SCIEN^SDECU2(DFN,ARIEN,ARDAPTDT)
 I IEN S SDAPTREQ("Error",1)="Appointment already exists." Q
 I '$D(^SC(ARIEN,"S",0)) S ^SC(ARIEN,"S",0)="^44.001DA^^"
 I '$D(^SC(ARIEN,"S",ARDAPTDT,0)) S ^SC(ARIEN,"S",ARDAPTDT,0)=ARDAPTDT,^(1,0)="^44.003PA^^"
 K DIC,DA,X,Y,DLAYGO,DD,DO,DINUM
 S DIC="^SC("_ARIEN_",""S"","_ARDAPTDT_",1,"
 S DA(2)=ARIEN,DA(1)=ARDAPTDT,X=DFN
 S DIC("DR")="1////"_ARLEN_";3///"_$E($G(ARRSN),1,150)_";7////"_ARUSER_";8////"_ARODT_";30////"_PATELG_$S(+AROVR:";9////O",1:"")
 S DIC("P")="44.003PA",DIC(0)="L",DLAYGO=44.003
 D FILE^DICN
 I Y<0 S SDAPTREQ("Error",1)="Error in creating Appointment." Q
 S SDAPTREQ("Success")="Appointment is successfully created."
 Q
 ;
UPDATE ;Find ien for appt in file 44
 N IEN,SDFDA,SDERR
 S IEN=$$SCIEN^SDECU2(DFN,ARIEN,ARDAPTDT)
 I 'IEN S SDAPTREQ("Error",1)="Error trying to find appointment to update." Q
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",1)=ARLEN
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",3)=ARRSN
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",30)=PATELG
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",9)=AROVR
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",7)=ARUSER
 S SDFDA(44.003,IEN_","_ARDAPTDT_","_ARIEN_",",8)=ARODT
 K SDERR D UPDATE^DIE("","SDFDA","","SDERR")
 I $D(SDERR) S SDAPTREQ("Error",1)="Error trying to find appointment to update." Q
 S SDAPTREQ("Success")="Appointment is successfully updated."
 Q
 ;
BUILDER ;Convert data to JSON
 N JSONERR
 S JSONERR=""
 D ENCODE^SDESJSON(.SDAPTREQ,.RETURN,.JSONERR)
 Q
