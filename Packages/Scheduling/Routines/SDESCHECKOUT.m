SDESCHECKOUT ;ALB/BWF - VISTA SCHEDULING RPCS ;SEP 22, 2022
 ;;5.3;Scheduling;**826,827**;Aug 13, 1993;Build 10
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to MAS PARAMETERS in ICR #483
 ; Reference to WARD LOCATION in ICR #1377
 ; Reference to MAS PARAMETERS in ICR #2296
 ; Reference to VISIT in ICR #2028
 ;
 Q
CHECKOUT(SDECY,APPTIEN,CHKOUTDT) ;Check Out appointment
 ;CHECKOUT(SDECY,DFN,APPTDTTM,CHKOUTDT,SDECAPTID,VPRV)  external parameter tag is in SDEC
 ; Returns   SDECY
 ; Input  -- APPTIEN     Appointment IEN from 409.84
 ;           CHKOUTDT    Appointment Checkout Date/Time in ISO format
 ;
 N CLINICIEN,SDASK,SDCOACT,SDDA,SDLNE,SDQUIET,APPTIENS,RESOURCE,ERRORS,DFN,APPTDATA,DFN,RESOURCE,CLINICIEN,CHKOUT
 S APPTIEN=$G(APPTIEN),CHKOUTDT=$G(CHKOUTDT)
 D VALKEY^SDESVALUTIL(.ERRORS,$G(DUZ))
 D VALAPPTIEN^SDESVALUTIL(.ERRORS,APPTIEN)
 S APPTIENS=APPTIEN_","
 D GETS^DIQ(409.84,APPTIENS,".01;.05;.07;.12","I","APPTDATA")
 I $G(APPTDATA(409.84,APPTIENS,.12,"I")) D ERRLOG^SDESJSON(.ERRORS,322)
 S APPTDTTM=$G(APPTDATA(409.84,APPTIENS,.01,"I"))
 S DFN=$G(APPTDATA(409.84,APPTIENS,.05,"I"))
 S RESOURCE=$G(APPTDATA(409.84,APPTIENS,.07,"I"))
 S VPRV=$G(APPTDATA(409.84,APPTIENS,.16,"I"))
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCE,.04,"I")
 S CHKOUTDT=$$VALCHKOUTDT(.ERRORS,CHKOUTDT,CLINICIEN)
 I $D(ERRORS) S ERRORS("CheckOut",1)="" D BUILDJSON^SDESBUILDJSON(.SDECY,.ERRORS) Q
 ;
 S SDDA=0
 S SDASK=0
 S SDCOACT="CO"
 S SDLNE=""
 S SDQUIET=1
 ;
 ;  Event driver "BEFORE" actions - from SD*5.3*717 10/25/18
 ;
 N SDATA,SDDA,SDCIHDL ;
 S SDDA=$$FIND(DFN,APPTDTTM,CLINICIEN)
 I 'SDDA D  Q
 .D ERRLOG^SDESJSON(.ERRORS,317)
 .S ERRORS("CheckOut",1)="" D BUILDJSON^SDESBUILDJSON(.SDECY,.ERRORS)
 I '$$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",309,"I") D  Q
 .D ERRLOG^SDESJSON(.ERRORS,318)
 .S ERRORS("CheckOut",1)="" D BUILDJSON^SDESBUILDJSON(.SDECY,.ERRORS)
 ;
 S SDATA=SDDA_U_DFN_U_APPTDTTM_U_CLINICIEN
 S SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 ;  Event driver "BEFORE" actions
 D BEFORE^SDAMEVT(.SDATA,DFN,APPTDTTM,CLINICIEN,SDDA,SDCIHDL) ;
 ; Appointment checkout
 D CHKOUT(DFN,APPTDTTM,CLINICIEN,SDDA,SDASK,CHKOUTDT,SDCOACT,SDLNE,APPTIEN,SDQUIET,VPRV,.ERRORS)
 ; Skip event driver actions if error occurred checking appointment out. - wtc SD*5.3*717 10/25/2018
 I $D(ERRORS) S ERRORS("CheckOut",1)="" D BUILDJSON^SDESBUILDJSON(.SDECY,.ERRORS) Q
 ;  Event driver "AFTER" actions
 D AFTER^SDAMEVT(.SDATA,DFN,APPTDTTM,CLINICIEN,SDDA,SDCIHDL) ;
 ;  Execute event driver.  5=check out (see #409.66), 2=non-interactive
 D EVT^SDAMEVT(.SDATA,5,2,SDCIHDL) ;
 S CHKOUT("CheckOut",1)="Checked Out." D BUILDJSON^SDESBUILDJSON(.SDECY,.CHKOUT)
 Q
VALCHKOUTDT(ERRORS,CHKOUTDT,CLINIC) ;
 N CHKOUTDTFM,CHKIN
 S CHKIN=$$GET1^DIQ(409.84,APPTIEN,.03,"I")
 S CHKOUTDTFM=""
 I CHKOUTDT="" D ERRLOG^SDESJSON(.ERRORS,23) Q CHKOUTDTFM
 S CHKOUTDTFM=$$ISOTFM^SDAMUTDT(CHKOUTDT,CLINIC)
 I CHKOUTDTFM<0 D ERRLOG^SDESJSON(.ERRORS,24) Q CHKOUTDTFM
 I $P(CHKOUTDTFM,".",2)="" D ERRLOG^SDESJSON(.ERRORS,321) Q CHKOUTDTFM
 ; checkout time cannot be in the future
 I CHKOUTDTFM>$$NOW^XLFDT D ERRLOG^SDESJSON(.ERRORS,320) Q CHKOUTDTFM
 ; make sure checkout time is after checkin time
 I CHKOUTDTFM'>CHKIN D ERRLOG^SDESJSON(.ERRORS,52,"Check Out time must be at least 1 minute after the Check In time of "_$TR($$FMTE^XLFDT(CHKIN),"@"," ")_".")
 Q CHKOUTDTFM
 ;
FIND(DFN,APPTDTTM,CLINICIEN) ; -- return appt ifn for pat
 ;   input:        DFN := ifn of pat.
 ;                 APPTDTTM := appt d/t
 ;                CLINICIEN := ifn of clinic
 ;  output: [returned] := ifn if pat has appt on date/time
 ;
 N Y,FOUND,RET
 S RET=""
 S (Y,FOUND)=0
 F  S Y=$O(^SC(CLINICIEN,"S",APPTDTTM,1,Y)) Q:'Y!(FOUND)  D
 .I '$D(^SC(CLINICIEN,"S",APPTDTTM,1,Y,0)) Q
 .I DFN'=$$GET1^DIQ(44.003,Y_","_APPTDTTM_","_CLINICIEN_",",.01,"I") Q
 .I $D(^DPT(DFN,"S",APPTDTTM,0)),$$VALID(DFN,CLINICIEN,APPTDTTM,Y) S FOUND=1,RET=Y Q
 Q RET
 ;
VALID(DFN,CLINICIEN,APPTDTTM,SDDA) ; -- return valid appt.
 ;   input:        DFN := ifn of pat.
 ;            APPTDTTM := appt d/t
 ;                CLINICIEN := ifn of clinic
 ;                SDDA := ifn of appt
 ;  output: [returned] := 1 for valid appt., 0 for not valid
 N APPTCAN44,APPTCAN2
 S APPTCAN44=$$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",310,"I")
 S APPTCAN2=$$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",3,"I")
 Q $S(APPTCAN44'="C":1,APPTCAN2["C":1,1:0)
 ;
 ; from CO^SDEC25A
CHKOUT(DFN,APPTDTTM,CLINICIEN,SDDA,SDASK,CHKOUTDT,SDCOACT,SDLNE,SDECAPTID,SDQUIET,VPRV,ERRORS) ;Appt Check Out
 ; Input  -- DFN      Patient file IEN
 ;           APPTDTTM Appointment Date/Time
 ;           CLINICIEN     Hospital Location file IEN for Appt
 ;           SDDA     IEN in ^SC multiple or null [Optional]
 ;           SDASK    Ask Check Out Date/Time     [Optional]
 ;           CHKOUTDT   Date/Time of Check Out      [Optional]
 ;           SDCOACT  Appt Mgmt Check Out Action  [Optional]
 ;           SDLNE    Appt Mgmt Line Number       [Optional]
 ; Input  -- SDECAPTID Appointment ID
 ;           SDQUIET  No Terminal output 0=allow display 1=do not allow
 ;           VPRV     V Provider IEN - pointer to V PROVIDER file
 ;           ERRORS   Returned Array of errors
 ;
 N SDCOQUIT,SDOE,SDATA
 S SDATA=$G(^DPT(DFN,"S",APPTDTTM,0))
 ;-- if new encounter, pass to PCE
 I $$NEW(APPTDTTM) D  Q
 .N SDCOED
 .S SDOE=$$GETAPT(DFN,APPTDTTM,CLINICIEN)
 .S SDCOED=$$CHK($TR($$STATUS(DFN,APPTDTTM,CLINICIEN,SDATA,SDDA),";","^"))
 .; -- appt has already been checked out
 .I $$CODT(DFN,APPTDTTM,CLINICIEN,SDDA)!(SDCOED) D  Q
 ..D ERRLOG^SDESJSON(.ERRORS,319)
 .D CHKOUT2(SDOE,DFN,APPTDTTM,CLINICIEN,CHKOUTDT,SDECAPTID,SDQUIET,VPRV,.ERRORS)
 Q
CODT(DFN,SDT,SDCL,SDDA) ; -- does appt have co date
 Q $$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",303,"I")
 ;
NEW(DATE) ;-- This function will return 1 if SD is turned on for
 ;   Visit Tracking and optionally check if the date is past
 ;   the cut over date for the new PCE interface.
 ; INPUT : DATE (Optional) Date to check for cut over.
 ; OUTPUT: 1 Yes, 0 No
 N SDRES,SDX,SDY
 I '$G(DATE) S DATE=DT
 ;-- is Scheduling on ?
 S SDRES=0,SDY=$$PKGON^VSIT("SD")
 ;-- if date is it pass cut over?
 S SDX=1 I $G(DATE) S SDX=$$SWITCHCK^PXAPI(DATE)
 ;-- And together
 I SDX,SDY S SDRES=1
 Q SDRES
 ;
GETAPT(DFN,SDT,SDCL,SDVIEN) ;Look-up Outpatient Encounter IEN for Appt
 ; This utility will return the existing IEN for an Outpatient
 ; Encounter. If it fails to find an existing encounter,
 ; it will create a new Encounter and return the new IEN.
 ;
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time
 ;           SDCL     Hospital Location file IEN for Appt
 ;           SDVIEN   Visit file pointer [optional]
 ; Output -- Outpatient Encounter file IEN
 N Y
 S Y=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 I 'Y D APPT(DFN,SDT,SDCL,$G(SDVIEN)) S Y=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 I Y D VIEN(Y,$G(SDVIEN))
 Q +$G(Y)
 ;
 ; FROM APPT^SDVSIT
APPT(DFN,SDT,SDCL,SDVIEN) ; -- process appt
 ; input        DFN = ien of patient file entry
 ;              SDT = visit date internal format
 ;             SDCL = ien of hospital location file entry
 ;           SDVIEN = Visit file pointer [optional]
 ;
 N SDVSIT,SDOE,DA,DIE,DR,SDPT,SDSC,SDCL0,SDDA,SDLOCK
 ;
 ; -- set lock data and lock
 S SDLOCK("DFN")=DFN
 S SDLOCK("EVENT DATE/TIME")=SDT
 D LOCK(.SDLOCK)
 ;
 ; -- set node vars
 S SDPT=$G(^DPT(DFN,"S",SDT,0))
 S SDCL0=$G(^SC(SDCL,0)),SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S SDSC=$G(^SC(SDCL,"S",SDT,1,SDDA,0))
 S SDVSIT("CLN")=$P(SDCL0,U,7),SDVSIT("DIV")=$$DIV($P(SDCL0,U,15))
 ;
 ; -- do checks
 I 'SDPT!('SDSC)!($P(SDCL0,U,3)'="C") D UNLOCK(.SDLOCK) Q
 I SDCL,+SDPT'=SDCL D UNLOCK(.SDLOCK) Q
 I $P(SDPT,U,20) D UNLOCK(.SDLOCK) Q
 I 'SDVSIT("CLN")!('SDVSIT("DIV")) D UNLOCK(.SDLOCK)
 ;
 ; -- set the rest
 S SDVSIT("DFN")=DFN,SDVSIT("LOC")=SDCL
 S:$P(SDSC,U,10) SDVSIT("ELG")=$P(SDSC,U,10)
 S:$P(SDPT,U,16) SDVSIT("TYP")=$P(SDPT,U,16)
 ;
 ; -- call logic to add opt encounter(s)
 S SDVSIT("ORG")=1,SDVSIT("REF")=SDDA,SDOE=$$SDOE(SDT,.SDVSIT,$G(SDVIEN))
 I SDOE D
 .N DA,DIE,DR
 .S DA=SDT,DA(1)=DFN,DR="21////"_SDOE,DIE="^DPT("_DFN_",""S""," D ^DIE
 D CSTOP(SDOE,SDCL,.SDVSIT,SDT)  ;Process credit stop if applicable
 D UNLOCK(.SDLOCK)
 Q
 ; FROM LOCK^SDVSIT
LOCK(SDLOCK) ; -- lock "ADFN" node
 F  L +^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME"))):$G(DILOCKTM,3) Q:$T  ;LLS - 05-JAN-15 - SD*5.3*630 added timeout on lock
 Q
 ; FROM UNLOCK^SDVSIT
UNLOCK(SDLOCK) ; -- unlock "ADFN" node
 L -^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME")))
 Q
 ; FROM SDOE^SDVSIT
SDOE(SDT,SDVSIT,SDVIEN,SDOEP) ; -- get visit & encounter
 N SDTR,SDI ;LLS 22-DEC-2014 - SD*5.3*630 - added
 S SDTR=9999999-$P(SDT,".") ;LLS 22-DEC-2014 - SD*5.3*630 - added
 I SDT["." S SDTR=SDTR_"."_$P(SDT,".",2) ;LLS 22-DEC-2014 - SD*5.3*630 - added
 I '$D(SDVSIT("PAR")),$G(SDVIEN)="" D  ;LLS 22-DEC-2014 - SD*5.3*630 - added the following section
 .N SDVISARR,SDVIEN1
 .S SDVIEN1="" F  S SDVIEN1=$O(^AUPNVSIT("AA",DFN,SDTR,SDVIEN1)) Q:SDVIEN1=""  D  Q:$G(SDVIEN)]""
 ..; COMPARE VISIT: SERVICE CATEGORY, POINTER TO CLINIC STOP FILE, POINTER TO HOSPITAL LOCATION
 ..; FILE, & ENCOUNTER TYPE BEFORE SELECTING EXISTING VISIT INSTEAD OF CREATING A NEW ONE
 ..D GETS^DIQ(9000010,SDVIEN1_",",".07;.08;.22;15003","I","SDVISARR")
 ..;Q:SDVISARR(9000010,SDVIEN1_",",.07,"I")'=$S($G(SDVSIT("SVC"))]"":SDVSIT("SVC"),$$INP^SDAM2(DFN,SDTR)="I":"I",1:"A")
 ..Q:SDVISARR(9000010,SDVIEN1_",",.07,"I")'=$S($G(SDVSIT("SVC"))]"":SDVSIT("SVC"),$$INP(DFN,SDTR)="I":"I",1:"A")
 ..Q:SDVISARR(9000010,SDVIEN1_",",.08,"I")'=$G(SDVSIT("CLN"))
 ..Q:SDVISARR(9000010,SDVIEN1_",",.22,"I")'=$G(SDVSIT("LOC"))
 ..Q:SDVISARR(9000010,SDVIEN1_",",15003,"I")'="P"
 ..S SDVIEN=SDVIEN1
 S SDVSIT("VST")=$G(SDVIEN)
 ; bwf - SD*826 - leaving calls to SDVSIT0 - consider bringing into SDES* namespace in the future
 I 'SDVSIT("VST") D VISIT^SDVSIT0(SDT,.SDVSIT)
 Q $$NEW^SDVSIT0(SDT,.SDVSIT)
 ;
INP(DFN,VDATE) ; -- determine inpatient status ; dom is not an inpatient appt
 N SDINP,VAINDT,VADMVT,WARDLOC
 S SDINP="",VAINDT=VDATE D ADM^VADPT2 I 'VADMVT Q SDINP
 S WARDLOC=$$GET1^DIQ(405,VADMVT,.06,"I")
 I $$GET1^DIQ(43,1,16,"I"),$$GET1^DIQ(42,WARDLOC,.03,"I")="D" Q SDINP
 S SDINP="I"
 Q SDINP
 ;
DIV(DIV) ; -- determine med div
 ; multi-div
 I $$GET1^DIQ(43,1,11,"I"),$D(^DG(40.8,+DIV,0)) Q DIV
 S DIV=+$O(^DG(40.8,0))
 Q DIV
 ;
 ; FROM CSTOP^SDVSIT
CSTOP(SDOE,SDCL,SDVSIT,SDT) ;Process credit stop
 ;Input: SDOE=encounter ien
 ;Input: SDCL0=zeroeth node of HOSPITAL LOCATION file record
 ;Input: SDVSIT=visit data array (pass by reference)
 ;Input: SDT=encounter date/time
 ; -- does clinic have a credit stop code?
 ; -- process only if non non-count and not equal to credit
 ;
 N CREDSCODE,NONCOUNT,CLINSTOPCODE,CSTOPINACTDT,IENS,CLINDAT
 S IENS=SDCL_","
 D GETS^DIQ(44,IENS,"8;2502;2503","I","CLINDAT","ERR")
 S CREDSCODE=$G(CLINDAT(44,IENS,2503,"I"))
 S NONCOUNT=$G(CLINDAT(44,IENS,2502,"I"))
 S CLINSTOPCODE=$G(CLINDAT(44,IENS,8,"I"))
 S CSTOPINACTDT=$$GET1^DIQ(40.7,CLINSTOPCODE,2,"I")
 I SDOE,CREDSCODE,(CREDSCODE'=SDVSIT("CLN")),NONCOUNT'="Y" D
 .N X,SDVIENSV,SDVIENOR
 .; -- is stop code active?
 .I $S('CSTOPINACTDT:1,1:SDT<CSTOPINACTDT) D
 ..S SDVSIT("CLN")=CREDSCODE
 ..S SDVIENOR=$G(SDVSIT("ORG"))
 ..S SDVSIT("ORG")=4
 ..S SDVSIT("PAR")=SDOE
 ..S SDVIENSV=$G(SDVSIT("VST"))
 ..K SDVSIT("VST")
 ..S X=$$SDOE(SDT,.SDVSIT)
 ..I X D LOGDATA(X)
 ..; -- restore SDVSIT
 ..S SDVSIT("CLN")=CLINSTOPCODE
 ..S SDVSIT("ORG")=SDVIENOR
 ..S SDVSIT("VST")=SDVIENSV
 ..K SDVSIT("PAR")
 ..Q
 .Q
 Q
LOGDATA(SDOE,SDLOG) ; -- log user, date/time and other data
 N DIE,DA,DR,Y,X
 S SDLOG("USER")=$G(DUZ)                       ; -- editing user
 S SDLOG("DATE/TIME")=$$NOW^XLFDT()            ; -- last edited
 S DIE="^SCE(",DA=SDOE,DR="[SD ENCOUNTER LOG]" D ^DIE
 Q
 ;
VIEN(SDOE,SDVIEN) ; -- stuff in Visit IEN if not already set
 ;                 -- needed for those sites that don't have
 ;                    scheduling turned on in Visit Tracking
 ; Required input   SDOE = Outpatient Encounter pointer
 ;                SDVIEN = Visit file pointer or null or zero
 ;
 ; -- quit if no vien passed
 Q:'SDVIEN
 ; -- quit is no encounter
 Q:'$D(^SCE(+SDOE,0))
 ; -- set visit ien if vien not already set
 I '$$GET1^DIQ(409.68,+SDOE,.05,"I") D
 .N DIE,DA,DR
 .S DIE="^SCE(",DA=SDOE,DR=".05////"_SDVIEN D ^DIE
 I '$$GET1^DIQ(409.68,+SDOE,.04,"I") D
 .N DIE,DA,DR,SDLOC
 .S SDLOC=$$GET1^DIQ(9000010,SDVIEN,.22,"I")
 .I SDLOC S DIE="^SCE(",DA=SDOE,DR=".04////"_SDLOC D ^DIE
 Q
 ;
 ;CO^SDEC25B
CHKOUT2(SDOE,DFN,APPTDTTM,CLINICIEN,CHKOUTDT,SDECAPTID,SDQUIET,VPRV,ERRORS) ;EP; called to ask check-out date/time   ;SAT ADDED PARAMETERS CHKOUTDT, SDECAPTID, & SDQUIET
 ;  Called by SDCO1
 ; SDOE      = Outpatient Encounter IEN
 ; DFN       = Patient IEN
 ; APPTDTTM  = Appointment Date/Time
 ; CLINICIEN = Clinic IEN
 ; CHKOUTDT  = APPOINTMENT CHECKOUT TIME [OPTIONAL - USED WHEN SDQUIET=1] USER ENTERED FORMAT
 ; SDECAPTID = APPOINTMENT ID - POINTER TO ^SDECAPPT
 ; SDQUIET   = ALLOW NO TERMINAL INPUT/OUTPUT 0=ALLOW; 1=DO NOT ALLOW
 ; VPRV      = V Provider IEN - pointer to V PROVIDER file
 ; ERRORS    = Returned Array of errors
 ;
 N DIE,DA,DR,SDECNOD,SDN,SDV,AUPNVSIT,PROVIEN40984,PSTAT
 S DIE="^SC("_CLINICIEN_",""S"","_APPTDTTM_",1,"
 S DA(2)=CLINICIEN,DA(1)=APPTDTTM
 S (DA,SDN)=$$SCIEN(DFN,CLINICIEN,APPTDTTM)
 ;
 S DR="303///"_CHKOUTDT_";304///`"_DUZ_";306///"_$$NOW^XLFDT
 D ^DIE
 ; if checked out and status not updated, do it now
 I $$GET1^DIQ(44.003,DA_","_APPTDTTM_","_CLINICIEN_",",303,"I")]"" D
 .;UPDATE APPOINTMENT SCHEDULE GLOBAL ^SDEC(409.84
 .I $G(SDECAPTID) D
 ..S PSTAT=$$GET1^DIQ(409.68,SDOE,.12,"I")
 ..S DIE="^SDEC(409.84,"
 ..S DA=SDECAPTID
 ..S DR=".14///"_$G(CHKOUTDT)_";.19///"_PSTAT
 ..D ^DIE
 ..;possibly update VProvider
 ..S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 ..S PROVIEN40984=$$GET1^DIQ(409.84,SDECAPTID,.15,"I")
 ..I $G(VPRV),PROVIEN40984 D
 ...;get SDEC appointment schedule
 ...S DIE="^AUPNVPRV("
 ...S DA=PROVIEN40984
 ...S DR=".01///"_VPRV
 ...D ^DIE
 .;
 .Q:$$GET1^DIQ(409.68,SDOE,.12)="CHECKED OUT"
 .S DIE=409.68,DA=SDOE,DR=".12///14;101///"_DUZ_";102///"_$$NOW^XLFDT
 .D ^DIE
 .; if visit pointer stored, update visit checkout date/time
 .S SDV=$$GET1^DIQ(409.68,SDOE,.05,"I") Q:'SDV
 .Q:'$D(^AUPNVSIT(SDV,0))  Q:$$GET1^DIQ(9000010,SDV,.05,"I")'=DFN
 .Q:$$GET1^DIQ(9000010,SDV,.11,"I")=1    ;deleted
 .;cmi/maw 5/1/2009 PATCH 1010 RQMT 34
 .S DIE="^AUPNVSIT(",DA=SDV
 .S DR=".18///"_$$GET1^DIQ(44.003,SDN_","_APPTDTTM_","_CLINICIEN_",",303,"I")
 .D ^DIE
 Q
 ;
SCIEN(PAT,CLINIC,DATE) ;PEP; returns ien for appt in ^SC
 NEW X,IEN
 S X=0 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  Q:$G(IEN)  D
 . Q:$P($G(^SC(CLINIC,"S",DATE,1,X,0)),U,9)="C"  ;cancelled
 . I +$G(^SC(CLINIC,"S",DATE,1,X,0))=PAT S IEN=X
 Q $G(IEN)
 ;
 ;
CHK(SDSTB) ; -- is appointment checked out
 N Y
 I "^2^8^12^"[("^"_+SDSTB_"^"),$P(SDSTB,"^",3)["CHECKED OUT" S Y=1
 Q +$G(Y)
 ;
STATUS(DFN,SDT,SDCL,SDATA,SDDA) ; -- return appt status
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;               SDATA := 0th node of pat appt entry
 ;                SDDA := ifn for ^SC(clinic,"S",date,1,ifn) {optional}
 ;  output: [returned] := appt status ifn ^ status name ^ print status ^
 ;                        check in d/t ^ check out d/t ^ adm mvt ifn
 ;
 ;S = status ; C = ci/co indicator ; Y = 'C' node ; P = print status
 N S,C,Y,P,VADMVT,VAINDT,STATUS,SDSCE,SDIEN,CHKINDT,CHKOUTDT
 ;
 ; -- get data for evaluation
 S:'$G(SDDA) SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S CHKINDT=$$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",309,"I")
 S CHKOUTDT=$$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",303,"I")
 ;retrieve CHECK OUT from OUTPATIENT ENCOUNTER file if not in Hospital Location file/PURGED or edited
 S SDSCE=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 I SDSCE D  ;pointer to OE
 .I CHKOUTDT="" S CHKOUTDT=$$GET1^DIQ(409.68,SDSCE,.07,"I")
 .S SDIEN=SDSCE_"," S STATUS=$$GET1^DIQ(409.68,SDIEN,.12)
 ;
 ; -- set initial status value ; non-count clinic?
 S S=$S($P(SDATA,"^",2)]"":$P($P($P(^DD(2.98,3,0),"^",3),$P(SDATA,"^",2)_":",2),";"),$P($G(^SC(SDCL,0)),U,17)="Y":"NON-COUNT",1:"")
 I SDSCE&(S="NO ACTION TAKEN") S S=""
 ;
 ; -- inpatient?
 S VAINDT=SDT D ADM^VADPT2
 I S["INPATIENT",$S('VADMVT:1,'$P(^DG(43,1,0),U,21):0,1:$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),U,6),0)),U,3)="D") S S=""
 ;
 ; -- determine ci/co indicator
 S C=$S(CHKOUTDT:"CHECKED OUT",CHKINDT:"CHECKED IN",S]"":"",SDT>(DT+.2359):"FUTURE",1:"NO ACTION TAKEN") S:S="" S=C
 ;
 I S="NO ACTION TAKEN",$P(SDT,".")=DT,C'["CHECKED" S C="TODAY"
 ; -- $$REQ & $$COCMP in SDM1A not used for speed
 I S="CHECKED OUT"!(S="CHECKED IN"),SDT'<$P(^DG(43,1,"SCLR"),U,23),'$P(SDATA,U,20) S S="NO ACTION TAKEN"
 ;
 ; -- determine print status
 S P=$S(S=C!(C=""):S,1:"")
 I P="" D
 .I S["INPATIENT",$P($G(^SC(SDCL,0)),U,17)'="Y",$P($G(^SCE(+$P(SDATA,U,20),0)),U,7)="" S P=$P(S," ")_"/ACT REQ" Q
 .I S="NO ACTION TAKEN",C="CHECKED OUT"!(C="CHECKED IN") S P="ACT REQ/"_C D  Q
 ..I SDSCE I $P($G(^SCE(SDSCE,0)),U,7) S P="CHECKED OUT"
 .S P=$S(S="NO ACTION TAKEN":S,1:$P(S," "))_"/"_C
 I S["INPATIENT",C="" D
 .I SDT>(DT+.2359) S P=$P(S," ")_"/FUTURE" Q
 .S P=$P(S," ")_"/NO ACT TAKN"
 I S["INPATIENT" Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
 I S["NO-SHOW" Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
 I $G(SDSCE) I $D(^SCE(SDSCE,0)) D
 .I $G(STATUS)="NON-COUNT" D  Q
 ..I CHKOUTDT S P="NON-COUNT/CHECKED OUT" Q
 ..I CHKINDT S P="NON-COUNT/CHECKED IN"
 .I $G(STATUS)="CHECKED OUT" S P="CHECKED OUT" Q
 .I CHKOUTDT S P="ACT REQ/CHECKED OUT" D  Q
 ..I $G(STATUS)="ACTION REQUIRED" S S="NO ACTION TAKEN" Q
 ..I $G(STATUS)="" I $P($G(^SCE(SDSCE,0)),U,7) S P="CHECKED OUT"
 .I CHKINDT S P="ACT REQ/CHECKED IN" D
 ..I $G(STATUS)="ACTION REQUIRED" S S="NO ACTION TAKEN"
 Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_CHKINDT_";"_CHKOUTDT_";"_+VADMVT
