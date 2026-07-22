SDES2SETCHECKOUT ;ALB/JAS,LAB,ANU,JHC,MGD - SDES2 SET APPT CHECKOUT DATE/TIME ; MAY 28,2026
 ;;5.3;Scheduling;**867,877,880,909,945**;Aug 13, 1993;Build 2
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 Q
 ;
 ; Documented API's and Integration Agreements:
 ;
 ; Reference to MAS PARAMETERS in ICR #483
 ; Reference to WARD LOCATION in ICR #1377
 ; Reference to MAS PARAMETERS in ICR #2296
 ; Reference to VISIT in ICR #2028
 ; Reference to DUZ^XUP is supported by IA #7487
 ;
 ; RPC: SDES2 SET APPT CHECKOUT
 ;
 ; SDCONTEXT("ACHERON AUDIT ID") = 36 character unique ID number. Ex: 11d9dcc6-c6a2-4785-8031-8261576fca37
 ; SDCONTEXT("USER DUZ") = The DUZ of the user taking action on the calling application.
 ; SDCONTEXT("USER SECID") = The name of the user taking action on the calling application.
 ; SDCONTEXT("PATIENT DFN") = The DFN of the Veteran/user taking action on the calling application.
 ; SDCONTEXT("PATIENT ICN") = The ICN of the Veteran/user taking action on the calling application.
 ;
 ; PARAMS("APPT IEN") = IEN of SDEC APPOINTMENT (#409.84) file record to be Checked Out (required)
 ; PARAMS("CHECKOUT DATE") = Checkout date/time in ISO format (required)
 ;
SETCHECKOUT(JSONRETURN,SDCONTEXT,PARAMS) ; Set Checkout Date/Time for Appointment
 ;
 N APPTDATA,APPTIENS,CLINICIEN,RESOURCE,SDASK,SDCOACT,SDDA,DFN,SDERRORS,SDLNE,SDQUIET,SDRETURN
 ; Leaking variables from external calls
 N %,%DT,%H,%I,ANS,APPTDTTM,APPTIEN,C,CHKIN,CHKOUTDT,D0,DA,DDER,DI,DIC,DIERR,DIG,DIH,DIU,DIV,DK,DL,DQ,DSIHCL,DSIHFS,DSPV150
 N EVN,FS,HL16,HL7STRG,HLA,HLECH,HLFS,HLGS,HLHDR,HLN,HLPARAM,HLQ,HLSAN,HLTYPE,HLX,IEN,J,PIVOT,R,REF,S,SUBIEN
 N VA,VACNTRY,VAERR,VPRV,X,XQXFLG,XX,Y,Z0,ZMID,ZTSK
 ;
 ; Validate SDCONTEXT
 ;
 D VALCONTEXT^SDES2VALCONTEXT(.SDERRORS,.SDCONTEXT)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 I $G(SDCONTEXT("USER DUZ"))'="" N DUZ D DUZ^XUP(SDCONTEXT("USER DUZ"))
 ;
 ; Validate APPT IEN
 ;
 S APPTIEN=$G(PARAMS("APPT IEN"))
 S APPTIENS=$$VALAPPTIEN(APPTIEN,.SDERRORS)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 ; Get APPT data
 ;
 D GETS^DIQ(409.84,APPTIENS,".01;.03;.05;.07;.12;.16","I","APPTDATA")
 I $G(APPTDATA(409.84,APPTIENS,.12,"I")) D  Q
 . D ERRLOG^SDES2JSON(.SDERRORS,322) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)=""
 . D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 ;
 S APPTDTTM=$G(APPTDATA(409.84,APPTIENS,.01,"I"))
 S CHKIN=$G(APPTDATA(409.84,APPTIENS,.03,"I"))
 S DFN=$G(APPTDATA(409.84,APPTIENS,.05,"I"))
 S RESOURCE=$G(APPTDATA(409.84,APPTIENS,.07,"I"))
 S VPRV=$G(APPTDATA(409.84,APPTIENS,.16,"I"))
 S CLINICIEN=$$GET1^DIQ(409.831,RESOURCE,.04,"I")
 ;
 ; Validate Checkout Date/Time
 ;
 S CHKOUTDT=$G(PARAMS("CHECKOUT DATE"))
 S CHKOUTDT=$$VALCHCKOUT(CHKOUTDT,CHKIN,CLINICIEN,.SDERRORS)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)="" D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN) Q
 ;
 S SDDA=0,SDASK=0,SDCOACT="CO",SDLNE="",SDQUIET=1
 ;
 ;  Event driver "BEFORE" actions
 ;
 N SDATA,SDDA,SDCIHDL ;
 S SDDA=$$FIND(DFN,APPTDTTM,CLINICIEN)
 I 'SDDA D  Q
 . D ERRLOG^SDES2JSON(.SDERRORS,317) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)=""
 . D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 I '$$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",309,"I") D  Q
 . D ERRLOG^SDES2JSON(.SDERRORS,318) M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)=""
 . D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 ;
 S SDATA=SDDA_U_DFN_U_APPTDTTM_U_CLINICIEN
 S SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 ;  Event driver "BEFORE" actions
 D BEFORE^SDAMEVT(.SDATA,DFN,APPTDTTM,CLINICIEN,SDDA,SDCIHDL) ;
 ; Appointment checkout
 D CHKOUT(DFN,APPTDTTM,CLINICIEN,SDDA,SDASK,CHKOUTDT,SDCOACT,SDLNE,APPTIEN,SDQUIET,VPRV,.SDERRORS)
 ; Skip event driver actions if error occurred checking appointment out.
 I $D(SDERRORS) D  Q
 . M SDRETURN=SDERRORS S SDRETURN("Checkout",1)="",SDRETURN("Appointment",1)=""
 . D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 ;  Event driver "AFTER" actions
 D AFTER^SDAMEVT(.SDATA,DFN,APPTDTTM,CLINICIEN,SDDA,SDCIHDL) ;
 ;  Execute event driver.  5=Checkout (see #409.66), 2=non-interactive
 D EVT^SDAMEVT(.SDATA,5,2,SDCIHDL) ;
 S SDRETURN("Checkout",1)="Checked Out."
 D BUILDAPPTOBJ^SDES2BLDAPPTOBJ(.SDRETURN,APPTIEN,1,.SDERRORS)
 I $D(SDERRORS) M SDRETURN=SDERRORS S SDRETURN("Appointment",1)="" Q
 D BUILDJSON^SDES2JSON(.JSONRETURN,.SDRETURN)
 Q
 ;
VALAPPTIEN(APPTIEN,SDERRORS) ; Validate Appt IEN
 ;
 N VALRET
 D VALFILEIEN^SDES2VALUTIL(.VALRET,.SDERRORS,409.84,APPTIEN,1,0,14,15)
 Q APPTIEN_","
 ;
VALCHCKOUT(CHKOUTDT,CHKIN,CLINICIEN,SDERRORS) ; Validate and Process Checkout Date/Time
 ;
 N CHKOUTDTFM S CHKOUTDTFM=""
 S CHKOUTDTFM=$$VALISODTTM^SDES2VALISODTTM(.SDERRORS,CHKOUTDT,CLINICIEN,1,23,24)
 I $D(SDERRORS) Q 0
 ; checkout time must be included
 I $P(CHKOUTDTFM,".",2)="" D ERRLOG^SDES2JSON(.SDERRORS,321) S SDRETURN("Appointment",1)="" Q 0
 ; checkout time cannot be in the future
 I CHKOUTDTFM>$$NOW^XLFDT D ERRLOG^SDES2JSON(.SDERRORS,320) S SDRETURN("Appointment",1)="" Q 0
 ; make sure checkout time is after checkin time
 I CHKOUTDTFM'>CHKIN D ERRLOG^SDES2JSON(.SDERRORS,52,"Checkout time must be at least 1 minute after the Check-In time of "_$TR($$FMTE^XLFDT(CHKIN),"@"," ")_".") Q 0
 Q CHKOUTDTFM
 ;
FIND(DFN,APPTDTTM,CLINICIEN) ; return appt ifn for pat
 ;   input:       DFN := ifn of pat.
 ;           APPTDTTM := appt d/t
 ;          CLINICIEN := ifn of clinic
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
VALID(DFN,CLINICIEN,APPTDTTM,SDDA) ; return valid appt.
 ;   input:       DFN := ifn of pat.
 ;           APPTDTTM := appt d/t
 ;          CLINICIEN := ifn of clinic
 ;               SDDA := ifn of appt
 ;  output: [returned] := 1 for valid appt., 0 for not valid
 N APPTCAN44,APPTCAN2
 S APPTCAN44=$$GET1^DIQ(44.003,SDDA_","_APPTDTTM_","_CLINICIEN_",",310,"I")
 S APPTCAN2=$$GET1^DIQ(2.98,APPTDTTM_","_DFN_",",3,"I")
 Q $S(APPTCAN44'="C":1,APPTCAN2["C":1,1:0)
 ;
 ; from CO^SDEC25A
CHKOUT(DFN,APPTDTTM,CLINICIEN,SDDA,SDASK,CHKOUTDT,SDCOACT,SDLNE,SDECAPTID,SDQUIET,VPRV,SDERRORS) ;Appt Check Out
 ; Input
 ;  DFN        Patient file IEN
 ;  APPTDTTM   Appointment Date/Time
 ;  CLINICIEN  Hospital Location file IEN for Appt
 ;  SDDA       IEN in ^SC multiple or null [Optional]
 ;  SDASK      Ask Checkout Date/Time      [Optional]
 ;  CHKOUTDT   Date/Time of Checkout       [Optional]
 ;  SDCOACT    Appt Mgmt Checkout Action   [Optional]
 ;  SDLNE      Appt Mgmt Line Number       [Optional]
 ;  SDECAPTID  Appointment ID
 ;  SDQUIET    No Terminal output 0=allow display 1=do not allow
 ;  VPRV       V Provider IEN - pointer to V PROVIDER file
 ;  SDERRORS   Returned Array of errors
 ;
 N SDCOQUIT,SDOE,SDATA
 S SDATA=$G(^DPT(DFN,"S",APPTDTTM,0))
 ; if new encounter, pass to PCE
 I $$NEW(APPTDTTM) D  Q
 .N SDCOED
 .S SDOE=$$GETAPT(DFN,APPTDTTM,CLINICIEN,.SDERRORS)
 .I $D(SDERRORS) Q
 .;
 .S SDCOED=$$CHK($TR($$STATUS^SDES2SETCHKOUT2(DFN,APPTDTTM,CLINICIEN,SDATA,SDDA),";","^"))
 .; appt has already been checked out
 .I $$CODT(DFN,APPTDTTM,CLINICIEN,SDDA)!(SDCOED) D  Q
 ..D ERRLOG^SDES2JSON(.SDERRORS,319)
 .D CHKOUT2(SDOE,DFN,APPTDTTM,CLINICIEN,CHKOUTDT,SDECAPTID,SDQUIET,VPRV,.SDERRORS)
 Q
CODT(DFN,SDT,SDCL,SDDA) ; does appt have co date
 Q $$GET1^DIQ(44.003,SDDA_","_SDT_","_SDCL_",",303,"I")
 ;
NEW(DATE) ; This function will return 1 if SD is turned on for
 ; Visit Tracking and optionally check if the date is past
 ; the cut over date for the new PCE interface.
 ; INPUT : DATE (Optional) Date to check for cut over.
 ; OUTPUT: 1 Yes, 0 No
 N SDRES,SDX,SDY
 I '$G(DATE) S DATE=DT
 ; is Scheduling on ?
 S SDRES=0,SDY=$$PKGON^VSIT("SD")
 ; if date is it pass cut over?
 S SDX=1 I $G(DATE) S SDX=$$SWITCHCK^PXAPI(DATE)
 ; And together
 I SDX,SDY S SDRES=1
 Q SDRES
 ;
GETAPT(DFN,SDT,SDCL,SDVIEN,SDERRORS) ;Look-up Outpatient Encounter IEN for Appt
 ; This utility will return the existing IEN for an Outpatient
 ; Encounter. If it fails to find an existing encounter,
 ; it will create a new Encounter and return the new IEN.
 ;
 ; Input:  DFN      Patient file IEN
 ;         SDT      Appointment Date/Time
 ;         SDCL     Hospital Location file IEN for Appt
 ;         SDVIEN   Visit file pointer [optional]
 ; Output  Outpatient Encounter file IEN
 N Y
 S Y=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 I 'Y D APPT(DFN,SDT,SDCL,$G(SDVIEN),.SDERRORS)
 I $D(SDERRORS) Q +$G(Y)
 I '$D(SDERRORS) S Y=$$GET1^DIQ(2.98,SDT_","_DFN_",",21,"I")
 ;
 I Y D VIEN(Y,$G(SDVIEN))
 Q +$G(Y)
 ;
 ; FROM APPT^SDVSIT
APPT(DFN,SDT,SDCL,SDVIEN,SDERRORS) ; process appt
 ; input     DFN = ien of patient file entry
 ;           SDT = visit date internal format
 ;          SDCL = ien of hospital location file entry
 ;        SDVIEN = Visit file pointer [optional]
 ;
 N SDVSIT,SDOE,DA,DIE,DR,SDPT,SDSC,SDCL0,SDDA,SDLOCK,SDLCKS
 ;
 ; set lock data and lock
 S SDLOCK("DFN")=DFN
 S SDLOCK("EVENT DATE/TIME")=SDT
 I '$$LOCK(.SDLOCK) D ERRLOG^SDES2JSON(.SDERRORS,174) Q
 ;
 ; set node vars
 S SDPT=$G(^DPT(DFN,"S",SDT,0))
 S SDCL0=$G(^SC(SDCL,0)),SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S SDSC=$G(^SC(SDCL,"S",SDT,1,SDDA,0))
 S SDVSIT("CLN")=$P(SDCL0,U,7),SDVSIT("DIV")=$$DIV($P(SDCL0,U,15))
 ;
 ; do checks
 I 'SDPT!('SDSC)!($P(SDCL0,U,3)'="C") D UNLOCK(.SDLOCK) Q
 I SDCL,+SDPT'=SDCL D UNLOCK(.SDLOCK) Q
 I $P(SDPT,U,20) D UNLOCK(.SDLOCK) Q
 I 'SDVSIT("CLN")!('SDVSIT("DIV")) D UNLOCK(.SDLOCK)
 ;
 ; set the rest
 S SDVSIT("DFN")=DFN,SDVSIT("LOC")=SDCL
 S:$P(SDSC,U,10) SDVSIT("ELG")=$P(SDSC,U,10)
 S:$P(SDPT,U,16) SDVSIT("TYP")=$P(SDPT,U,16)
 ;
 ; call logic to add opt encounter(s)
 S SDVSIT("ORG")=1,SDVSIT("REF")=SDDA,SDOE=$$SDOE(SDT,.SDVSIT,$G(SDVIEN))
 I SDOE D
 .N FDAIENS,ERR298,FDA298
 .S FDAIENS=SDT_","_DFN_","
 .S FDA298(2.98,FDAIENS,21)=SDOE
 .D FILE^DIE(,"FDA298","ERR298")
 .;
 D CSTOP(SDOE,SDCL,.SDVSIT,SDT)  ;Process credit stop if applicable
 D UNLOCK(.SDLOCK)
 Q
 ; FROM LOCK^SDVSIT
 ; Return Status = 1 if success, 0 if fail
LOCK(SDLOCK) ; lock "ADFN" node
 N SDC
 F SDC=1:1:5 L +^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME"))):$G(DILOCKTM,3) Q:$T
 I $T Q 1
 Q 0
 ; FROM UNLOCK^SDVSIT
UNLOCK(SDLOCK) ; unlock "ADFN" node
 L -^SCE("ADFN",+$G(SDLOCK("DFN")),+$G(SDLOCK("EVENT DATE/TIME")))
 Q
 ; FROM SDOE^SDVSIT
SDOE(SDT,SDVSIT,SDVIEN,SDOEP) ; get visit & encounter
 N SDTR,SDI
 S SDTR=9999999-$P(SDT,".")
 I SDT["." S SDTR=SDTR_"."_$P(SDT,".",2)
 I '$D(SDVSIT("PAR")),$G(SDVIEN)="" D
 .N SDVISARR,SDVIEN1
 .S SDVIEN1="" F  S SDVIEN1=$O(^AUPNVSIT("AA",DFN,SDTR,SDVIEN1)) Q:SDVIEN1=""  D  Q:$G(SDVIEN)]""
 ..; COMPARE VISIT: SERVICE CATEGORY, POINTER TO CLINIC STOP FILE, POINTER TO HOSPITAL LOCATION
 ..; FILE, & ENCOUNTER TYPE BEFORE SELECTING EXISTING VISIT INSTEAD OF CREATING A NEW ONE
 ..D GETS^DIQ(9000010,SDVIEN1_",",".07;.08;.22;15003","I","SDVISARR")
 ..Q:SDVISARR(9000010,SDVIEN1_",",.07,"I")'=$S($G(SDVSIT("SVC"))]"":SDVSIT("SVC"),$$INP(DFN,SDTR)="I":"I",1:"A")
 ..Q:SDVISARR(9000010,SDVIEN1_",",.08,"I")'=$G(SDVSIT("CLN"))
 ..Q:SDVISARR(9000010,SDVIEN1_",",.22,"I")'=$G(SDVSIT("LOC"))
 ..Q:SDVISARR(9000010,SDVIEN1_",",15003,"I")'="P"
 ..S SDVIEN=SDVIEN1
 S SDVSIT("VST")=$G(SDVIEN)
 ; consider bringing SDVSIT0 calls into SDES* namespace in the future
 I 'SDVSIT("VST") D VISIT^SDVSIT0(SDT,.SDVSIT)
 Q $$NEW^SDVSIT0(SDT,.SDVSIT)
 ;
INP(DFN,VDATE) ; determine inpatient status ; dom is not an inpatient appt
 N SDINP,VAINDT,VADMVT,WARDLOC
 S SDINP="",VAINDT=VDATE D ADM^VADPT2 I 'VADMVT Q SDINP
 S WARDLOC=$$GET1^DIQ(405,VADMVT,.06,"I")
 I $$GET1^DIQ(43,1,16,"I"),$$GET1^DIQ(42,WARDLOC,.03,"I")="D" Q SDINP
 S SDINP="I"
 Q SDINP
 ;
DIV(DIV) ; determine med div
 ; multi-div
 I $$GET1^DIQ(43,1,11,"I"),$D(^DG(40.8,+DIV,0)) Q DIV
 S DIV=+$O(^DG(40.8,0))
 Q DIV
 ;
 ; FROM CSTOP^SDVSIT
CSTOP(SDOE,SDCL,SDVSIT,SDT) ;Process credit stop
 ; SDOE=encounter ien
 ; SDCL0=zeroeth node of HOSPITAL LOCATION file record
 ; SDVSIT=visit data array
 ; SDT=encounter date/time
 ; does clinic have a credit stop code?
 ; process only if non non-count and not equal to credit
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
 .; is stop code active?
 .I $S('CSTOPINACTDT:1,1:SDT<CSTOPINACTDT) D
 ..S SDVSIT("CLN")=CREDSCODE
 ..S SDVIENOR=$G(SDVSIT("ORG"))
 ..S SDVSIT("ORG")=4
 ..S SDVSIT("PAR")=SDOE
 ..S SDVIENSV=$G(SDVSIT("VST"))
 ..K SDVSIT("VST")
 ..S X=$$SDOE(SDT,.SDVSIT)
 ..I X D LOGDATA(X)
 ..; restore SDVSIT
 ..S SDVSIT("CLN")=CLINSTOPCODE
 ..S SDVSIT("ORG")=SDVIENOR
 ..S SDVSIT("VST")=SDVIENSV
 ..K SDVSIT("PAR")
 ..Q
 .Q
 Q
LOGDATA(SDOE,SDLOG) ; log user, date/time and other data
 N DIE,DA,DR,Y,X
 S SDLOG("USER")=DUZ      ; editing user
 S SDLOG("DATE/TIME")=$$NOW^XLFDT()  ; last edited
 S DIE="^SCE(",DA=SDOE,DR="[SD ENCOUNTER LOG]" D ^DIE
 Q
 ;
VIEN(SDOE,SDVIEN) ; stuff in Visit IEN if not already set
 ; needed for those sites that don't have scheduling turned on in Visit Tracking
 ; Required input   SDOE = Outpatient Encounter pointer
 ;                SDVIEN = Visit file pointer or null or zero
 ;
 ; quit if no vien
 Q:'SDVIEN
 ; quit is no encounter
 Q:'$D(^SCE(+SDOE,0))
 ; set visit ien if vien not already set
 N SDFDA,SDERR
 I '$$GET1^DIQ(409.68,+SDOE,.05,"I") D
 .K SDFDA,SDERR
 .S SDFDA(409.68,SDOE_",",.05)=SDVIEN
 .D FILE^DIE("","SDFDA","SDERR")
 I '$$GET1^DIQ(409.68,+SDOE,.04,"I") D
 .N DIE,DA,DR,SDLOC
 .S SDLOC=$$GET1^DIQ(9000010,SDVIEN,.22,"I")
 .I SDLOC D
 ..K SDFDA,SDERR
 ..S SDFDA(409.68,SDOE_",",.04)=SDLOC
 ..D FILE^DIE("","SDFDA","SDERR")
 Q
 ;
CHKOUT2(SDOE,DFN,APPTDTTM,CLINICIEN,CHKOUTDT,SDECAPTID,SDQUIET,VPRV,SDERRORS) ;EP; called to ask check-out date/time
 ; SDOE      = Outpatient Encounter IEN
 ; DFN       = Patient IEN
 ; APPTDTTM  = Appointment Date/Time
 ; CLINICIEN = Clinic IEN
 ; CHKOUTDT  = APPOINTMENT CHECKOUT TIME [OPTIONAL - USED WHEN SDQUIET=1] USER ENTERED FORMAT
 ; SDECAPTID = APPOINTMENT ID - POINTER TO ^SDECAPPT
 ; SDQUIET   = ALLOW NO TERMINAL INPUT/OUTPUT 0=ALLOW; 1=DO NOT ALLOW
 ; VPRV      = V Provider IEN - pointer to V PROVIDER file
 ; SDERRORS  = Returned Array of errors
 ;
 N DIE,DA,DR,SDECNOD,SDN,SDV,AUPNVSIT,PROVIEN40984,PSTAT,SDFDA,SDERR,IENS44
 K SDFDA,SDERR
 S (DA,SDN)=$$SCIEN(DFN,CLINICIEN,APPTDTTM)
 S IENS44=$$GET44RECORDIENS^SDESCANCELAPPTS(CLINICIEN,APPTDTTM,DFN)
 S SDFDA(44.003,IENS44,303)=CHKOUTDT
 S SDFDA(44.003,IENS44,304)=DUZ
 S SDFDA(44.003,IENS44,306)=$$NOW^XLFDT
 D FILE^DIE(,"SDFDA","SDERR")
 ;
 ; if checked out and status not updated
 I $$GET1^DIQ(44.003,DA_","_APPTDTTM_","_CLINICIEN_",",303,"I")]"" D
 .;UPDATE APPOINTMENT SCHEDULE GLOBAL ^SDEC(409.84
 .I $G(SDECAPTID) D
 ..S PSTAT=$$GET1^DIQ(409.68,SDOE,.12,"I")
 ..K SDFDA,SDERR
 ..S SDFDA(409.84,SDECAPTID_",",.14)=$G(CHKOUTDT)
 ..S SDFDA(409.84,SDECAPTID_",",.19)=PSTAT
 ..D FILE^DIE("","SDFDA","SDERR")
 ..; possibly update VProvider
 ..S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 ..S PROVIEN40984=$$GET1^DIQ(409.84,SDECAPTID,.15,"I")
 ..I $G(VPRV),PROVIEN40984 D
 ...; get SDEC appointment schedule
 ...K SDFDA,SDERR
 ...S SDFDA(9000010.06,PROVIEN40984_",",.01)=VPRV
 ...D FILE^DIE("","SDFDA","SDERR")
 .Q:$$GET1^DIQ(409.68,SDOE,.12)="CHECKED OUT"
 .K SDFDA,SDERR
 .S SDFDA(409.68,SDOE_",",.12)=14
 .S SDFDA(409.68,SDOE_",",.101)=DUZ
 .S SDFDA(409.68,SDOE_",",.102)=$$NOW^XLFDT
 .D FILE^DIE("","SDFDA","SDERR")
 .; if visit pointer stored, update visit checkout date/time
 .S SDV=$$GET1^DIQ(409.68,SDOE,.05,"I") Q:'SDV
 .Q:'$D(^AUPNVSIT(SDV,0))  Q:$$GET1^DIQ(9000010,SDV,.05,"I")'=DFN
 .Q:$$GET1^DIQ(9000010,SDV,.11,"I")=1    ;deleted
 .K SDFDA,SDERR
 .S SDFDA(9000010,SDV_",",.18)=$$GET1^DIQ(44.003,SDN_","_APPTDTTM_","_CLINICIEN_",",303,"I")
 .D FILE^DIE("","SDFDA","SDERR")
 Q
 ;
SCIEN(PAT,CLINIC,DATE) ;PEP; returns ien for appt in ^SC
 NEW X,IEN
 S X=0 F  S X=$O(^SC(CLINIC,"S",DATE,1,X)) Q:'X  Q:$G(IEN)  D
 . Q:$P($G(^SC(CLINIC,"S",DATE,1,X,0)),U,9)="C"  ;cancelled
 . I +$G(^SC(CLINIC,"S",DATE,1,X,0))=PAT S IEN=X
 Q $G(IEN)
 ;
CHK(SDSTB) ; is appointment checked out
 N Y
 I "^2^8^12^"[("^"_+SDSTB_"^"),$P(SDSTB,"^",3)["CHECKED OUT" S Y=1
 Q +$G(Y)
