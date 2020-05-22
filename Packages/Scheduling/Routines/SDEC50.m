SDEC50 ;ALB/SAT/JSM - VISTA SCHEDULING RPCS ; 01 Nov 2019  11:42 AM
 ;;5.3;Scheduling;**627,658,665,672,722,723,737**;Aug 13, 1993;Build 13
 ;;Per VHA Directive 2004-038, this routine should not be modified
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
 ;
 N IEN,SDANCT,SDCL,SDCLN,SDCONS,SDATA,SDDT,SDST,SDT,X,Y,%DT
 N SDTMP,SDTYP,SDTYPN,SDNOD,SDRES,SDNOD2,SDLNK ;alb/sat 672 ;*zeb 723 5/2/19 added SDNOD2,SDLNK
 S SDECI=0
 K ^TMP("SDEC50",$J)
 S SDECY="^TMP(""SDEC50"","_$J_")"
 ; data header
 S SDTMP="T00020DFN^T00020CLINIC_IEN^T00030CLINIC_NAME^T00020APPT_DATE^T00020STATUS^T00100ANCTXT"
 S SDTMP=SDTMP_"^T00030CONS^T00030IEN^T00030APPTYPE_IEN^T00030APPTYPE_NAME"   ;alb/sat 658 add IEN ;alb/sat 672 add APPTYPE
 S @SDECY@(0)=SDTMP_$C(30)
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
 ;*zeb 722 1/9/19 begin new loop over appts instead of pt
 S SDT=SDBEG
 F  S SDT=$O(^SDEC(409.84,"APTDT",DFN,SDT)) Q:SDT=""  Q:$P(SDT,".",1)>SDEND  D
 . S IEN=""
 . F  S IEN=$O(^SDEC(409.84,"APTDT",DFN,SDT,IEN)) Q:IEN=""  D
 .. S SDNOD=$G(^SDEC(409.84,IEN,0))
 .. Q:SDNOD=""  ;appointment data missing
 .. S SDATA=$G(^DPT(DFN,"S",SDT,0))
 .. S SDANCT=$$ANC^SDAM1() ;assumes SDATA ;ancillary
 .. I SDANC  Q:SDANCT=""
 .. ;return appointment data
 .. S SDRES=$P(SDNOD,U,7)
 .. S SDCL="",SDCLN="*CORRUPT DATA" ;*zeb+8 723 5/2/19 support appointments with no resource
 .. I SDRES]"" S SDCL=$$GET1^DIQ(409.831,SDRES_",",.04,"I") S SDCLN=$$GET1^DIQ(409.831,SDRES_",",.04) ;clinic IEN/clinic name
 .. S SDDT=$$GET1^DIQ(409.84,IEN_",",.01) ;appointment start date/time ;used GET1 instead of ^DD("DD") because GUI needs leading zeroes
 .. S SDST=$$APPTSTS(IEN,SDNOD,SDCL) ;current status
 .. S SDTYP=$P(SDNOD,U,6) ;appt type id
 .. I SDTYP S SDTYPN=$P($G(^SD(409.1,SDTYP,0)),U,1) ;appt type name
 .. E  S SDTYPN="REGULAR",SDTYP=$O(^SD(409.1,"B",SDTYPN,0)) ; Handle missing appt type 737 WTC 11/19/2019
 .. S SDNOD2=$G(^SDEC(409.84,IEN,2)),SDLNK=""
 .. S SDLNK=$S(SDNOD2="":"",1:$P(SDNOD2,U,1))
 .. S CONS=$S(SDLNK="":"",$P(SDLNK,";",2)["GMR":$P(SDLNK,";",1),1:"")
 .. S SDECI=SDECI+1 S @SDECY@(SDECI)=DFN_U_SDCL_U_SDCLN_U_SDDT_U_SDST_U_SDANCT_U_CONS_U_IEN_U_SDTYP_U_SDTYPN_$C(30)
 S @SDECY@(SDECI)=@SDECY@(SDECI)_$C(31)
 Q
 ;
 ;*zeb+tag 722 2/19/19 added to get appointment status for pending appointments from appointment file
APPTSTS(APPTIEN,APPTNOD,CLINIEN) ;Get current status for an entry in the SDEC APPOINTMENT file in the style of STATUS^SDAM1
 ;APPTIEN (R) - IEN of entry in the SDEC APPOINTMENT file (#409.84)
 ;APPTNOD (O) - 0 node of appointment entry (will be read if not passed in)
 ;CLINIEN (O) - IEN of entry in the HOSPITAL LOCATION file (#44); non-count will not be checked via clinic if not passed in (can check via OE)
 N STS,OEIEN,DFN,SDT,VAINDT,VADMVT,CHKIO,RET,OESTS,CXLRSN,CXLRSNTP,CXLSTS ; Added variables to list wtc 8/27/19
 I $G(APPTNOD)="" S APPTNOD=$G(^SDEC(409.84,APPTIEN,0))
 S SDT=$P(APPTNOD,U,1)
 S DFN=$P(APPTNOD,U,5)
 S OEIEN=$P($G(^DPT(DFN,"S",SDT,0)),U,20)
 S CHKIO=""
 ; -- set initial status value ; non-count clinic?
 S STS=$P(APPTNOD,U,17)
 I STS]"" S STS=$P($P($P(^DD(409.84,.17,0),"^",3),STS_":",2),";",1) I 1 ;name for status code
 E  I CLINIEN]"" S:$P($G(^SC(CLINIEN,0)),U,17)="Y" STS="NON-COUNT" ;check for non-count clinic ;*zeb+1 723 5/2/19 don't crash if resource/clinic not available
 I CLINIEN'="",STS="NO ACTION TAKEN",OEIEN'="" S STS="" ; wtc 723 8/20/2019
 ; -- no show?
 I $P(APPTNOD,U,10)=1 D
 . I $P(APPTNOD,U,12)]"" D  Q  ;handle cancel after no-show -- appt sts doesn't get updated with cxl but pt status does
 . . S CXLRSN=$P(APPTNOD,U,22)
 . . I CXLRSN="" S STS="CANCELLED" Q  ;cancel reason is required, this should not happen
 . . S CXLRSNTP=$P($G(^SD(409.2,CXLRSN,0)),U,2)
 . . I CXLRSNTP="C" S STS="CANCELLED BY CLINIC" Q
 . . I CXLRSNTP="P" S STS="CANCELLED BY PATIENT" Q
 . . ;only reasons that can be either are left, check pt file status -- could be overlaid after cancel
 . . S CXLSTS=$$GET1^DIQ(2.98,SDT_","_DFN_",",100)
 . . I CXLSTS["CANCELLED" S STS=CXLSTS Q
 . . S STS="CANCELLED BY CLINIC" ;must specify clinic or patient, default to clinic if information is lost
 . S STS="NO-SHOW"
 ; -- inpatient?
 ; WTC 722 3/22/19 ;
 I STS=""!($P(APPTNOD,U,17)="I"),$$INP^SDAM2(DFN,SDT)="I" S STS=$S($P(APPTNOD,U,12)="":"INPATIENT",$P($G(^DPT(DFN,"S",SDT,0)),U,2)="PC":"CANCELLED BY PATIENT",1:"CANCELLED BY CLINIC") ; WTC 722 3/27/2019
 S VAINDT=SDT D ADM^VADPT2 ;ADM^VADPT2 assumes VAINDT and returns in VADMVT
 I STS["INPATIENT",$S('VADMVT:1,'$P(^DG(43,1,0),U,21):0,1:$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),U,6),0)),U,3)="D") S STS=""
 ; -- determine ci/co indicator
 S CHKIO=$S($P(APPTNOD,U,14)]"":"CHECKED OUT",$P(APPTNOD,U,3)]"":"CHECKED IN",SDT>(DT+.2400):"FUTURE",1:"NO ACTION TAKEN") ;DT is a FileMan-assumable variable with the current date
 ;
 ;  Look for check-in time in the Location file (#44) if check-in/out indicator is NO ACTION TAKEN.  Needed 'cause VPS does not update Appointment file. wtc 10/31/2019 737
 I CHKIO="NO ACTION TAKEN",CLINIEN'="" D  ;
 . N SDECD2 S SDECD2=$$FIND^SDAM2(DFN,SDT,CLINIEN) I SDECD2,$P($G(^SC(CLINIEN,"S",SDT,1,SDECD2,"C")),U,1)'="" S CHKIO="CHECKED IN" ;
 ;
 S:STS="" STS=CHKIO
 ;
 ;  If status is NO ACTION TAKEN, check if cancelled in Patient file (by SDCANCEL),  wtc 11/4/2019 737
 ;  Changed to if status not cancelled, check if cancelled in Patient file.  wtc 1/17/2020 737
 ;
 I STS'["CANCELLED" D  ;
 . I $P($G(^DPT(DFN,"S",SDT,0)),U,1)'=CLINIEN Q  ;  If appointment does not match, leave status alone.
 . S STS=$S($P($G(^DPT(DFN,"S",SDT,0)),U,2)="PC":"CANCELLED BY PATIENT",$P($G(^DPT(DFN,"S",SDT,0)),U,2)="C":"CANCELLED BY CLINIC",1:STS) ;
 ;
 I (STS="NO ACTION TAKEN"),($P(SDT,".")=DT),(CHKIO'["CHECKED") S CHKIO="TODAY"
 ; -- determine print status
 I STS["CANCELLED" Q STS
 S RET=$S(STS=CHKIO!(CHKIO=""):STS,1:"")
 I RET="" D
 . I STS["INPATIENT",$P(SDT,".",1)>DT S RET=$P(STS," ",1)_"/FUTURE" Q  ; WTC 3/26/19 722
 . I (STS["INPATIENT"),(CLINIEN]""),($P($G(^SC(CLINIEN,0)),U,17)'="Y"),OEIEN="" S RET=$P(STS," ",1)_"/ACT REQ" Q  ;  wtc 3/22/19 722 no outpatient encounter for inpatient
 . I (STS["INPATIENT"),(CLINIEN]""),($P($G(^SC(CLINIEN,0)),U,17)'="Y"),($P($G(^SCE(OEIEN,0)),U,7)="") S RET=$P(STS," ",1)_"/ACT REQ" Q
 . I (STS="NO ACTION TAKEN"),((CHKIO="CHECKED OUT")!(CHKIO="CHECKED IN")) S RET="ACT REQ/"_CHKIO D  Q
 . . I (OEIEN),($P($G(^SCE(OEIEN,0)),U,7)) S RET="CHECKED OUT" ; wtc 722 8/27/19 changed P to RET to match code in SDAM1, where the code originally came from.
 . I ((STS="NO-SHOW")!(STS="NON-COUNT")) S RET=STS Q:CHKIO="NO ACTION TAKEN"
 . S RET=STS_"/"_CHKIO
 I STS["INPATIENT",((CHKIO="")!(CHKIO="NO ACTION TAKEN")) D
 . I SDT>(DT+.2359) S RET=$P(STS," ")_"/FUTURE" Q
 . S RET=$P(STS," ")_"/NO ACT TAKN"
 I STS["INPATIENT" Q RET
 I STS["NO-SHOW" Q RET
 I ($G(OEIEN)),($D(^SCE(OEIEN,0))) D
 . S OESTS=$P($G(^SCE(OEIEN,0)),U,12)
 . S:OESTS]"" OESTS=$P($G(^SD(409.63,OESTS,0)),U,1)
 . I $G(OESTS)="NON-COUNT" D  Q
 . . I $P(APPTNOD,U,14) S RET="NON-COUNT/CHECKED OUT" Q
 . . I $P(APPTNOD,U,3) S RET="NON-COUNT/CHECKED IN"
 . I $G(OESTS)="CHECKED OUT" S RET="CHECKED OUT" Q
 . I $P(APPTNOD,U,14) S RET="ACT REQ/CHECKED OUT" D  Q
 . . I ($G(OESTS)=""),($P($G(^SCE(OEIEN,0)),U,7)) S RET="CHECKED OUT"
 . I $P(APPTNOD,U,3) S RET="ACT REQ/CHECKED IN"
 Q RET
 ;
GETIEN(DFN,SDCLN,SDDT)  ;get SDEC APPOINTMENT id
 N SDF,SDI,SDNOD,SDR
 Q:$G(DFN)="" ""
 Q:$G(SDCLN)="" ""
 Q:$G(SDDT)="" ""
 S (SDF,SDI)=0 F  S SDI=$O(^SDEC(409.84,"CPAT",DFN,SDI)) Q:SDI=""  D  Q:SDF=1
 .S SDNOD=$G(^SDEC(409.84,SDI,0))
 .Q:SDNOD=""
 .S SDR=$$GETRES^SDECUTL(SDCLN)
 .I $P(SDNOD,U,1)=SDDT,$P(SDNOD,U,7)=SDR S SDF=1
 Q $S(SDI'="":SDI,1:"")
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
 ;
 N SDASD,SDECI,SDS,STOP,SDYN,SDSCL
 ;N SDSNOD,SDSD,SDSTP,SDT,SDVSP,SDWL,SDYN  alb/jsm 658 commented out since variables not used here
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
 I $G(SDEND)'="" S %DT="" S X=$P(SDEND,"@",1) D ^%DT S SDEND=Y I Y=-1 S SDEND=""   ;alb/sat 665 - remove Q
 S:$G(SDEND)="" SDEND=$P($$NOW^XLFDT,".",1)
 S STOP=$$CLSTOP(SDCL)   ;get stop code number  alb/jsm 658 updated to use new CLSTOP call
 I '+STOP D ERR1^SDECERR(-1,"Clinic "_$P($G(^SC(+$G(SDCL),0)),U,1)_" does not have a STOP CODE NUMBER defined.",SDECI,SDECY) Q
 S SDYN="NO"
 D CHKPT
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_SDYN_$C(30,31)
 Q
 ;
CLSTOP(CLINIC)  ;Return clinic stop code for clinic
 Q:$G(CLINIC)="" 0 ;Verify clinic is passed in
 Q $P($G(^SC(CLINIC,0)),U,7) ;Return the stop code for the clinic
 ;
CHKPT  ; alb/jsm 658 added to be used by PCSTGET and PCST2GET
 N SDSCO
 S SDS=0 F  S SDS=$O(^DPT(DFN,"S",SDS)) Q:SDS=""  D  Q:SDYN="YES"   ;alb/sat 665 - start with SDS=0 instead of ""
 .S SDSCL=$P($G(^DPT(DFN,"S",SDS,0)),U,1)
 .I $$CLSTOP(SDSCL)=STOP D
 ..S APIEN=$$FIND^SDAM2(DFN,SDS,SDSCL)
 ..Q:APIEN=""
 ..S SDSCO=$P($P($G(^SC(SDSCL,"S",SDS,1,+APIEN,"C")),U,3),".",1)
 ..S:(SDSCO'="")&(SDSCO'<SDBEG)&(SDSCO'>SDEND) SDYN="YES"
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
 ;
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
 D CHKPT
 S SDECI=SDECI+1 S @SDECY@(SDECI)="0^"_SDYN_$C(30,31)
 Q
 ;
LOOK ;
 ;look in PATIENT Appointments
 I SDYN'="YES" D
 .S SDS="" F  S SDS=$O(^DPT(DFN,"S",SDS)) Q:SDS=""  D  Q:SDYN="YES"
 ..S SDSD=$$GET1^DIQ(2.98,SDS_","_DFN_",",.001,"I")
 ..I (SDSD'<SDBEG)&(SDSD'>SDEND) D
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
 .I (SDSD'<SDBEG)&(SDSD'>SDEND) D
 ..S SDSTP=$P($G(^SDWL(409.3,SDWL,"SDAPT")),U,4)
 ..I SDSTP=STOP S SDYN="YES"
 .Q:SDYN="YES"
 Q
 ;
PCSGET(SDECY,SDSVSP,SDCL)  ;GET clinics for a service/specialty (clinic stop)  ;alb/sat 658 add SDCL
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
 ;
 N SDASD,SDSCN,SDECI,SDSNOD,SDSD,SDSTP,SDT,SDVSP,SDWL
 N H,WLSRVSP,X,Y
 S WLSRVSP=""
 S (SDECI,SDSCN)=0
 S SDECY="^TMP(""SDEC50"","_$J_",""PCSGET"")"
 K @SDECY
 ; data header
 S @SDECY@(0)="T00030CLINSTOP^T00030CLINIEN^T00030CLINNAME"_$C(30)
 ;check clinic   ;alb/sat 658
 S SDCL=$G(SDCL)
 I SDCL'="",$D(^SC(SDCL,0)) D
 .S SDSVSP=$$GET1^DIQ(44,SDCL_",",8,"I")
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
 ;
