SDEC50 ;ALB/SAT - VISTA SCHEDULING RPCS ;JAN 15, 2016
 ;;5.3;Scheduling;**627**;Aug 13, 1993;Build 249
 ;
 Q
 ;
FAPPTGET(SDECY,DFN,SDBEG,SDEND,SDANC) ; GET Future appointments for given patient and date range
 ;FAPPTGET(SDECY,DFN,SDBEG,SDEND,SDANC)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN   = (required) Patient ID - Pointer to the PATIENT file 2  (lookup by name is not accurate if duplicates)
 ;  SDBEG = (required) Begin of date range to search for appointments in external format
 ;  SDEND = (required) End of date range to search for appointments in external format
 ;  SDANC = (optional) ancillary flag  0=all appointments; 1=only ancillary appointments
 ;RETURN:
 ; Successful Return:
 ;   Global Array in which each array entry contains Appointment Data from the PATIENT file
 ;   Data is separated by ^:
 ;     1. DFN
 ;     2. CLINIC_IEN  - Clinic IEN
 ;     3. CLINIC_NAME - Clinic Name
 ;     4. APPT_DATE - Appointment Date in external format
 ;     5. STATUS    - Status text
 ;     6. ANCTXT    - Ancillary Text
 ;     7. CONS      -Consult Link pointer to REQUEST/CONSULTATION file 123
 ;   "T00020DFN^T00020CLINIC_IEN^T00030CLINIC_NAME^T00020APPT_DATE^T00020STATUS^T00100ANCTXT^T00030CONS"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 ;
 N SDANCT,SDCL,SDCLN,SDCONS,SDATA,SDDT,SDST,SDT,X,Y,%DT
 S SDECI=0
 K ^TMP("SDEC50",$J)
 S SDECY="^TMP(""SDEC50"","_$J_")"
 ; data header
 S @SDECY@(0)="T00020DFN^T00020CLINIC_IEN^T00030CLINIC_NAME^T00020APPT_DATE^T00020STATUS^T00100ANCTXT^T00030CONS"_$C(30)
 ;validate Patient (required)
 I '+DFN D ERR1^SDECERR(-1,"Invalid Patient ID.",.SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",.SDECI,SDECY) Q
 ;validate begin date/time (required)
 S:$G(SDBEG)="" SDBEG=$P($$NOW^XLFDT,".",1)
 S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y
 I Y=-1 D ERR1^SDECERR(-1,"Invalid Begin Time.",.SDECI,SDECY) Q
 ;validate end date/time (required)
 S:$G(SDEND)="" SDEND=1000000
 S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y
 I Y=-1 D ERR1^SDECERR(-1,"Invalid End Time.",.SDECI,SDECY) Q
 ;validate ancillary flag (optional)
 S SDANC=$G(SDANC)
 S:SDANC'=1 SDANC=0
 S SDT=SDBEG F  S SDT=$O(^DPT(DFN,"S",SDT)) Q:SDT=""  Q:SDT>SDEND  D
 .S SDST=$$GET1^DIQ(2.98,SDT_","_DFN_",",100)      ;current status
 .;Q:SDST'="FUTURE"
 .;Q:'("I"[$P(^DPT(DFN,"S",SDT,0),U,2))  ;removed 6/24/2015
 .S SDANCT=""
 .S SDATA=$G(^DPT(DFN,"S",SDT,0))
 .S SDANCT=$$ANC^SDAM1
 .I +SDANC,SDANCT="" Q  ;quit if not ancillary
 .S SDCL=$$GET1^DIQ(2.98,SDT_","_DFN_",",.01,"I")  ;clinic IEN
 .S SDCLN=$$GET1^DIQ(2.98,SDT_","_DFN_",",.01)     ;clinic name
 .S SDDT=$$GET1^DIQ(2.98,SDT_","_DFN_",",.001)     ;appt time
 .S CONS=$$CONS(SDCL,DFN,SDT)
 .S SDECI=SDECI+1 S @SDECY@(SDECI)=DFN_U_SDCL_U_SDCLN_U_SDDT_U_SDST_U_SDANCT_U_CONS_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
CONS(SDCL,DFN,SDDT) ;check for consult in file 44
 ; SDCL = (required) clinic IEN
 ; DFN  = (required) patient IEN
 ; SDDT = (required) appointment time in FM format
 N CONS,CSTAT,SDI,SDJ
 S CONS=""
 S SDI=0 F  S SDI=$O(^SC(SDCL,"S",SDDT,1,SDI)) Q:SDI'>0  D  Q:CONS'=""
 .I $P($G(^SC(SDCL,"S",SDDT,1,SDI,0)),U,1)=DFN D
 ..S CONS=$G(^SC(SDCL,"S",SDDT,1,SDI,"CONS"))
 ..I +CONS D
 ...S CSTAT=$P($G(^GMR(123,CONS,0)),U,12)
 ...S:(CSTAT=1!(CSTAT=2)!(CSTAT=13)) CONS=""
 Q CONS
 ;
PCSTGET(SDECY,DFN,SDCL,SDBEG,SDEND)  ;GET patient clinic status for a clinic for a given time frame - has the patient been seen by the given Clinic in the past 24 months
 ;PCSTGET(SDECY,DFN,SDCL,SDBEG,SDEND)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN   = (required) Patient ID - Pointer to the PATIENT file 2  (lookup by name is not accurate if duplicates)
 ;  SDCL  = (required) Clinic code - Pointer to HOSPITAL LOCATION file
 ;  SDBEG = (optional)  Begin date in external format; defaults to 730 days previous (24 months)
 ;  SDEND = (optional)  End date in external format; defaults to today
 ;RETURN:
 ; Successful Return:
 ;   a single entry in the global array indicating that patient has or has
 ;   not been seen.
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDASD,SDECI,SDS,SDSCN,SDSNOD,SDSD,SDSTP,SDT,SDVSP,SDWL,SDYN
 N X,Y,%DT,APIEN
 S SDECI=0
 S SDECY="^TMP(""SDEC50"","_$J_",""PCSTGET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00020RETURNCODE^T00100TEXT"_$C(30)
 ;check for valid Patient
 I '+DFN D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 ;check for valid Clinic
 I '+SDCL D ERR1^SDECERR(-1,"Invalid Clinic ID.",SDECI,SDECY) Q
 I '$D(^SC(SDCL,0)) D ERR1^SDECERR(-1,"Invalid Clinic ID.",SDECI,SDECY) Q
 ;check times
 I $G(SDBEG)'="" S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=""
 S:$G(SDBEG)="" SDBEG=$P($$FMADD^XLFDT($$NOW^XLFDT,-730),".",1)
 I $G(SDEND)'="" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND="" Q
 S:$G(SDEND)="" SDEND=$P($$NOW^XLFDT,".",1)
 S SDSCN=$P($G(^SC(+$G(SDCL),0)),U,7)   ;get stop code number
 I '+SDSCN D ERR1^SDECERR(-1,"Clinic "_$P($G(^SC(+$G(SDCL),0)),U,1)_" does not have a STOP CODE NUMBER defined.",SDECI,SDECY) Q
 S SDYN="NO"
 ;look in SD WAIT LIST file for SDSCN stop code
 S SDWL="" F  S SDWL=$O(^SDWL(409.3,"B",DFN,SDWL)) Q:SDWL=""  D  Q:SDYN="YES"
 .S SDSD=$P($G(^SDWL(409.3,SDWL,0)),U,23)
 .I (SDSD>=SDBEG)&(SDSD<=SDEND) D
 ..S SDSTP=$P($G(^SDWL(409.3,SDWL,"SDAPT")),U,4)
 ..I SDSTP=SDSCN S SDYN="YES"
 .Q:SDYN="YES"
 ;look in PATIENT Appointments
 I SDYN'="YES" D
 .S SDS="" F  S SDS=$O(^DPT(DFN,"S",SDS)) Q:SDS=""  D  Q:SDYN="YES"
 ..S SDSD=$$GET1^DIQ(2.98,SDS_","_DFN_",",.001,"I")
 ..I (SDSD>=SDBEG)&(SDSD<=SDEND) D
 ...I $P($G(^DPT(DFN,"S",SDS,0)),U,1)=SDCL D
 ....S APIEN=$$FIND^SDAM2(DFN,SDS,SDCL)
 ....Q:APIEN=""
 ....S:$G(^SC(SDCL,"S",SDS,1,+APIEN,"C"))'="" SDYN="YES"
 ;look in HOSPITAL LOCATION
 I SDYN'="YES" D
 .S SDS=SDBEG F  S SDS=$O(^SC(SDCL,"S",SDS)) Q:SDS'>0  Q:SDS>SDEND  D  Q:SDYN="YES"
 ..S APIEN=$$FIND^SDAM2(DFN,SDS,SDCL)
 ..Q:APIEN=""
 ..S:$P($G(^SC(SDCL,"S",SDS,1,APIEN,"C")),U,1)'="" SDYN="YES"
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_SDYN_$C(30,31)
 Q
 ;
PCST2GET(SDECY,DFN,STOP,SDBEG,SDEND)  ;GET patient clinic status for a service/specialty (clinic stop) for a given time frame - has the patient been seen any clinics with the given service/specialty (clinic stop) in the past 24 months
 ;PCST2GET(SDECY,DFN,STOP,SDBEG,SDEND)  external parameter tag is in SDEC
 ;INPUT:
 ;  DFN     = (required) Patient ID - Pointer to the PATIENT file 2  (lookup by name is not accurate if duplicates)
 ;  STOP    = (required) CLINIC STOP or Service/Specialty name - NAME from the SD WL SERVICE/SPECIALTY file - looks for 1st active
 ;                       OR - Pointer to the CLINIC STOP file
 ;  SDBEG   = (optional)  Begin date in external format; defaults to 730 days previous (24 months)
 ;  SDEND   = (optional)  End date in external format; defaults to today
 ;RETURN:
 ; Successful Return:
 ;   a single entry in the global array indicating that patient has or has
 ;   not been seen.
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDASD,SDF,SDSCN,SDECI,SDSNOD,SDSD,SDSTP,SDT,SDVSP,SDWL,SDYN
 N H,WLSRVSP,X,Y,%DT
 S WLSRVSP=""
 S (SDF,SDECI,SDSCN)=0
 S SDECY="^TMP(""SDEC50"","_$J_",""PCST2GET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00020RETURNCODE^T00100TEXT"_$C(30)
 ;check for valid Patient
 I '+DFN D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 I '$D(^DPT(DFN,0)) D ERR1^SDECERR(-1,"Invalid Patient ID.",SDECI,SDECY) Q
 ;check for valid Service/Specialty
 S STOP=$G(STOP)
 ;I +SDSVSP,$D(^SDWL(409.31,SDSVSP,0)) S SDSCN=$P($G(^SDWL(409.31,SDSVSP,0)),U,1) S SDF=1
 I +STOP,'$D(^DIC(40.7,STOP,0)) D ERR1^SDECERR(-1,"Invalid stop code.",SDECI,SDECY) Q
 I +STOP S SDSCN=$$GET1^DIQ(40.7,STOP_",",.01) S SDF=1
 I 'SDF,'+STOP D
 .S H="" F  S H=$O(^DIC(40.7,"B",STOP,H)) Q:H=""  D  Q:+STOP
 ..I $P(^DIC(40.7,H,0),U,3)'="",$P(^DIC(40.7,H,0),U,3)<$$NOW^XLFDT() Q
 ..S STOP=H
 I '+STOP D ERR1^SDECERR(-1,"Invalid Stop code.",SDECI,SDECY) Q
 ;check times
 I $G(SDBEG)'="" S %DT="" S X=$P(SDBEG,"@",1) D ^%DT S SDBEG=Y I Y=-1 S SDBEG=""
 S:$G(SDBEG)="" SDBEG=$P($$FMADD^XLFDT($$NOW^XLFDT,-730),".",1)
 I $G(SDEND)'="" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND="" Q
 S:$G(SDEND)="" SDEND=$P($$NOW^XLFDT,".",1)
 S SDYN="NO"
 D LOOKWL
 I SDYN'="YES" S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:SDCL'>0  D  Q:SDYN="YES"
 .S SDCLN=$P($G(^SC(SDCL,0)),U,7)
 .D:SDCLN=STOP LOOK
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_SDYN_$C(30,31)
 Q
 ;
LOOK ;
 ;look in PATIENT Appointments
 I SDYN'="YES" D
 .S SDS="" F  S SDS=$O(^DPT(DFN,"S",SDS)) Q:SDS=""  D  Q:SDYN="YES"
 ..S SDSD=$$GET1^DIQ(2.98,SDS_","_DFN_",",.001,"I")
 ..I (SDSD>=SDBEG)&(SDSD<=SDEND) D
 ...I $P($G(^DPT(DFN,"S",SDS,0)),U,1)=SDCL D
 ....S APIEN=$$FIND^SDAM2(DFN,SDS,SDCL)
 ....I APIEN'="",$G(^SC(SDCL,"S",SDS,1,APIEN,"C"))'="" S SDYN="YES"
 ;look in HOSPITAL LOCATION
 I SDYN'="YES" D
 .S SDS=SDBEG F  S SDS=$O(^SC(SDCL,"S",SDS)) Q:SDS'>0  Q:SDS>SDEND  D  Q:SDYN="YES"
 ..S APIEN=$$FIND^SDAM2(DFN,SDS,SDCL)
 ..Q:APIEN=""
 ..S:$P($G(^SC(SDCL,"S",SDS,1,APIEN,"C")),U,1)'="" SDYN="YES"
 Q
 ;
LOOKWL ;
 ;look in SD WAIT LIST file for STOP stop code
 S SDWL="" F  S SDWL=$O(^SDWL(409.3,"B",DFN,SDWL)) Q:SDWL=""  D  Q:SDYN="YES"
 .S SDSD=$P($G(^SDWL(409.3,SDWL,0)),U,23)
 .I (SDSD>=SDBEG)&(SDSD<=SDEND) D
 ..S SDSTP=$P($G(^SDWL(409.3,SDWL,"SDAPT")),U,4)
 ..I SDSTP=STOP S SDYN="YES"
 .Q:SDYN="YES"
 Q
 ;
PCSGET(SDECY,SDSVSP)  ;GET clinics for a service/specialty (clinic stop)
 ;PCSGET(SDECY,SDSVSP)  external parameter tag is in SDEC
 ;INPUT:
 ;  SDSVSP  = (required) Service/Specialty name - NAME from the SD WL SERVICE/SPECIALTY file - looks for 1st active
 ;                       OR - Pointer to the SD WL SERVICE/SPECIALTY file
 ;RETURN:
 ; Successful Return:
 ;   global array containing Clinic IEN and Name of matching Hospital Locations
 ;   CLINSTOP  - pointer to CLINIC STOP file 40.7
 ;   CLINIEN   - pointer to the HOSPITAL LOCATION file 44
 ;   CLINNAME  - NAME from the HOSPITAL LOCATION file
 ; Caught Exception Return:
 ;   A single entry in the Global Array in the format "-1^<error text>"
 ;   "T00020RETURNCODE^T00100TEXT"
 ; Unexpected Exception Return:
 ;     Handled by the RPC Broker.
 ;     M errors are trapped by the use of M and Kernel error handling.
 ;     The RPC execution stops and the RPC Broker sends the error generated
 ;     text back to the client.
 N SDASD,SDSCN,SDECI,SDSNOD,SDSD,SDSTP,SDT,SDVSP,SDWL
 N H,WLSRVSP,X,Y
 S WLSRVSP=""
 S (SDECI,SDSCN)=0
 S SDECY="^TMP(""SDEC50"","_$J_",""PCSGET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030CLINSTOP^T00030CLINIEN^T00030CLINNAME"_$C(30)
 ;check for valid Service/Specialty
 S SDSVSP=$G(SDSVSP)
 I SDSVSP="" D ERR1^SDECERR(-1,"Service/Specialty ID required",SDECI,SDECY) Q
 I +SDSVSP,$D(^SDWL(409.31,+SDSVSP,0)) S SDSCN=$P($G(^SDWL(409.31,SDSVSP,0)),U,1)
 I '+SDSVSP D
 .S H=0 F  S H=$O(^DIC(40.7,"B",SDSVSP,H)) Q:H=""  D  Q:SDSCN'=0
 ..I $P(^DIC(40.7,H,0),U,3)'="",$P(^DIC(40.7,H,0),U,3)<$$NOW^XLFDT() Q
 ..S SDSCN=H
 I '+SDSCN D ERR1^SDECERR(-1,"Invalid Service/Specialty.",SDECI,SDECY) Q
 S SDCL=0 F  S SDCL=$O(^SC(SDCL)) Q:SDCL'>0  D
 .S SDCLN=$P($G(^SC(SDCL,0)),U,7)
 .I $$GET1^DIQ(44,SDCL_",",2505,)'="",$$GET1^DIQ(44,SDCL_",",2506)="" Q   ;only active
 .I SDCLN=SDSCN S SDECI=SDECI+1 S @SDECY@(SDECI)=SDSCN_U_SDCL_U_$P($G(^SC(SDCL,0)),U,1)_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
