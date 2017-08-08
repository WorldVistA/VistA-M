SDEC25 ;ALB/SAT - VISTA SCHEDULING RPCS ;JUN 21, 2017
 ;;5.3;Scheduling;**627,665**;Aug 13, 1993;Build 14
 ;
 Q
 ;
CHECKIN(SDECY,SDECAPTID,SDECCDT,SDECCC,SDECPRV,SDECROU,SDECVCL,SDECVFM,SDECOG,SDECCR,SDECPCC,SDECWHF) ;Check in appointment
 ;CHECKIN(SDECY,SDECAPTID,SDECCDT,SDECCC,SDECPRV,SDECROU,SDECVCL,SDECVFM,SDECOG,SDECCR,SDECPCC,SDECWHF)
 ;  external parameter tag is in SDEC
 ;
 ; INPUT: SDECAPTID - (required) Appointment ID
 ;        SDECCDT   - (optional) Check-in date/time
 ;                               "@" - indicates delete check-in
 ;        SDECCC    - (????????) Clinic Stop pointer to CLINIC STOP file
 ;        SDECPRV   - (optional) Provider pointer to NEW PERSON file
 ;                               default to current user
 ;        SDECROU   - (optional) Print Routing Slip flag, valid values:
 ;                                 0=false   1=true
 ;        SDECVCL   - (????????) Clinic pointer to HOSPITAL LOCATION
 ;        SDECVFM   - FORM
 ;        SDECOG    - OUTGUIDE FLAG
 ;        SDECCR    - Generate Chart request upon check-in? (1-Yes, otherwise no)
 ;        SDECPCC   - ien of PWH Type in HEALTH SUMMARY PWH TYPE file ^APCHPWHT
 ;        SDECWHF   - Print Patient Wellness Handout flag
 ;
ENDBG ;
 N BSDVSTN,EMSG
 N SDECNOD,SDECPATID,SDECSTART,DIK,DA,SDECID,SDECI,SDECZ,SDECIENS,SDECVEN
 N SDECNOEV,SDECCAN,SDECR1,%DT,X,Y
 S SDECNOEV=1 ;Don't execute protocol
 S SDECCAN=0
 ;
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID^T00150MESSAGE"_$C(30)
 ;validate SDEC appointment ID
 I '+$G(SDECAPTID) D ERR("SDEC25: Invalid Appointment ID") Q
 I '$D(^SDEC(409.84,+SDECAPTID,0)) D ERR("SDEC25: Invalid Appointment ID") Q
 ;validate checkin date/time (required)
 S SDECCDT=$G(SDECCDT)
 S:SDECCDT="@" SDECCAN=1
 I 'SDECCAN,SDECCDT'="" S %DT="T" S X=SDECCDT D ^%DT S SDECCDT=Y I Y=-1 S SDECCDT=""
 I SDECCDT="" D ERR("SDEC25: Invalid Check-In Time") Q
 ;validate clinic stop code
 S SDECCC=$G(SDECCC)
 I SDECCC'="" I '$D(^DIC(40.7,SDECCC,0)) S SDECCC=""
 ;validate provider (optional)
 S SDECPRV=$G(SDECPRV)
 I SDECPRV'="" I '$D(^VA(200,+SDECPRV,0)) S SDECPRV=""
 ;I SDECPRV="" S SDECPRV=DUZ
 ;I SDECPRV="" S SDECPRV=""
 ;validate routine slip flag (optional)
 S SDECROU=$$UP^XLFSTR($G(SDECROU))
 S SDECROU=$S(SDECROU=1:"true",SDECROU="TRUE":"true",1:0)
 ;validate clinic
 S SDECVCL=$G(SDECVCL)
 I SDECVCL'="" I '$D(^SC(SDECVCL,0)) S SDECVCL=""
 I SDECCC="",SDECVCL'="" S SDECCC=$P($G(^SC(SDECVCL,0)),U,7)   ;get clinic stop from 44
 ;
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S DFN=$P(SDECNOD,U,5)
 S SDECPATID=$P(SDECNOD,U,5)
 S SDECSTART=$P(SDECNOD,U)
 ;
 S SDECR1=$P(SDECNOD,U,7) ;RESOURCEID
 ;if resourceId is not null AND there is a valid resource record
 I SDECR1]"",$D(^SDEC(409.831,SDECR1,0)) D  I +$G(SDECZ) D ERR($P(SDECZ,U,2)) Q
 . S SDECNOD=^SDEC(409.831,SDECR1,0)
 . S SDECSC1=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 . ;Hospital Location is required for CHECKIN
 . ;I 'SDECSC1]"",'$D(^SC(+SDECSC1,0)) D ERR("SDEC25: Clinic not defined for this Resource: "_$P(SDECNOD,U,1)_" ("_SDECSC1_")") Q
 . I 'SDECSC1]"",'$D(^SC(+SDECSC1,0)) D ERR("Clinic not defined for this Resource: "_$P(SDECNOD,U,1)_" ("_SDECSC1_")") Q
 . ;Checkin SDEC APPOINTMENT entry
 . D SDECCHK(SDECAPTID,$S(SDECCAN:"",1:SDECCDT)) ; sets field .03 (Checkin), in file 409.84
 . ;Process cancel checkin
 . I $G(SDECCAN) D CANCHKIN(SDECPATID,SDECSC1,SDECSTART) Q
 . D APCHK(.SDECZ,SDECSC1,SDECPATID,SDECCDT,SDECSTART)
 . I $G(SDECPRV) S DIE="^SDEC(409.84,",DA=SDECAPTID,DR=".16///"_SDECPRV D ^DIE
 ;
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="0^"_$S($G(EMSG)'="":EMSG,1:"")_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
SDECCHK(SDECAPTID,SDECCDT) ;
 N SDECFDA,SDECMSG
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.03)=SDECCDT
 S SDECFDA(409.84,SDECIENS,.04)=$S(SDECCDT'="":$$NOW^XLFDT,1:"")
 D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;
APCHK(SDECZ,SDECSC1,SDECDFN,SDECCDT,SDECSTART)         ;
 ;Checkin appointment for patient SDECDFN in clinic SDECSC1
 ;at time SDECSD
 N APTN,BSDMSG,SDECC
 S SDECC("PAT")=SDECPATID
 S SDECC("HOS LOC")=SDECSC1
 S SDECC("CLINIC CODE")=SDECCC
 S SDECC("PROVIDER")=SDECPRV
 S SDECC("APPT DATE")=SDECSTART
 S SDECC("CDT")=SDECCDT
 S SDECC("USR")=DUZ
 ;find IEN in ^SC multiple or null
 S APTN=$$FIND^SDAM2(SDECC("PAT"),SDECC("APPT DATE"),SDECC("HOS LOC"))
 ;
 ;Required by NEW API:
 S SDECC("SRV CAT")="A"
 S SDECC("TIME RANGE")=-1
 S SDECC("VISIT DATE")=SDECCDT
 S SDECC("SITE")=$G(DUZ(2))
 S SDECC("VISIT TYPE")="V"
 S SDECC("CLN")=SDECC("HOS LOC")
 S SDECC("ADT")=SDECC("APPT DATE")
 ;
 ;Set up SDECVEN array containing VEN EHP CLINIC, VEN EHP FORM, OUTGUIDE FLAG
 ;These values come from input param
 S SDECVEN("CLINIC")=SDECVCL
 S SDECVEN("FORM")=SDECVFM
 S SDECVEN("OUTGUIDE")=SDECOG
 ;
 N SDECOUT
 D GETVISIT^SDECAPI4(.SDECC,.SDECOUT)
 ;K SDECC
 ;I SDECOUT(0)=1 S BSDVSTN=$O(SDECOUT(0))         ;if match found, set visit IEN
 ;D VISIT^SDECV(SDECC("HOS LOC"),SDECC("APPT DATE"),APTN,SDECC("PAT"),SDECC("CLINIC CODE"),SDECC("PROVIDER"),,.BSDMSG,.BSDVSTN,.SDECC)   ;replace GETVISIT^SDECAPI4 to make sure all visit data is updated
 Q
 ;
CANCHKIN(DFN,SDCL,SDT) ; Logic to cancel a checkin if the checkin date/time is passed in as '@'
 ; input:  DFN := ifn of patient
 ;        SDCL := clinic#
 ;         SDT := appt d/t
 ;
 N SDDA
 S SDDA=$$FIND(DFN,SDT,SDCL)
 ;I 'SDDA D ERR("SDEC25: Could not locate appointment in database or appointment is cancelled.") Q
 I 'SDDA D ERR("Could not locate appointment in database or appointment is cancelled.") Q
 N SDATA,SDCIHDL,X S SDATA=SDDA_U_DFN_U_SDT_U_SDCL,SDCIHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 S FDA(44.003,SDDA_","_SDT_","_SDCL_",",309)="" D FILE^DIE(,"FDA","ERR")
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL)
 D CHKEVTD(DFN,SDT,SDCL)
 K FDA,ERR
 Q
 ;
FIND(DFN,SDT,SDCL) ; -- return appt ifn for pat
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;  output: [returned] := ifn if pat has appt on date/time
 ;
 N Y
 S Y=0 F  S Y=$O(^SC(SDCL,"S",SDT,1,Y)) Q:'Y  I $D(^(Y,0)),DFN=+^(0),$D(^DPT(+DFN,"S",SDT,0)),$$VALID(DFN,SDCL,SDT,Y) Q
 Q Y
 ;
VALID(DFN,SDCL,SDT,SDDA) ; -- return valid appt.
 ; **NOTE:  For speed consideration the ^SC and ^DPT nodes must be
 ;          check to see they exist prior to calling this entry point.
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;                SDDA := ifn of appt
 ;  output: [returned] := 1 for valid appt., 0 for not valid
 Q $S($P(^SC(SDCL,"S",SDT,1,SDDA,0),U,9)'="C":1,$P(^DPT(DFN,"S",SDT,0),U,2)["C":1,1:0)
 ;
CHKEVT(SDECPAT,SDECSTART,SDECSC) ;EP Called by SDEC CHECKIN APPOINTMENT event
 ;when appointments CHECKIN via PIMS interface.
 ;Propagates CHECKIN to SDECAPPT and raises refresh event to running GUI clients
 ;
 Q:+$G(SDECNOEV)
 Q:'+$G(SDECSC)
 N SDECSTAT,SDECFOUND,SDECRES
 S SDECSTAT=""
 S:$G(SDATA("AFTER","STATUS"))["CHECKED IN" SDECSTAT=$P(SDATA("AFTER","STATUS"),"^",4)
 S SDECFOUND=0
 I $D(^SDEC(409.831,"ALOC",SDECSC)) S SDECRES=$O(^SDEC(409.831,"ALOC",SDECSC,0)) S SDECFOUND=$$CHKEVT1(SDECRES,SDECSTART,SDECPAT,SDECSTAT)
 I SDECFOUND D CHKEVT3(SDECRES) Q
 Q
 ;
CHKEVT1(SDECRES,SDECSTART,SDECPAT,SDECSTAT) ;
 ;Get appointment id in SDECAPT
 ;If found, call SDECNOS(SDECAPPT) and return 1
 ;else return 0
 N SDECFOUND,SDECAPPT
 S SDECFOUND=0
 Q:'+$G(SDECRES) SDECFOUND
 Q:'$D(^SDEC(409.84,"ARSRC",SDECRES,SDECSTART)) SDECFOUND
 S SDECAPPT=0 F  S SDECAPPT=$O(^SDEC(409.84,"ARSRC",SDECRES,SDECSTART,SDECAPPT)) Q:'+SDECAPPT  D  Q:SDECFOUND
 . S SDECNOD=$G(^SDEC(409.84,SDECAPPT,0)) Q:SDECNOD=""
 . I $P(SDECNOD,U,5)=SDECPAT,$P(SDECNOD,U,12)="" S SDECFOUND=1 Q
 I SDECFOUND,+$G(SDECAPPT) D SDECCHK(SDECAPPT,SDECSTAT)
 Q SDECFOUND
 ;
CHKEVT3(SDECRES) ;
 ;Call RaiseEvent to notify GUI clients
 ;
 Q
 N SDECRESN
 S SDECRESN=$G(^SDEC(409.831,SDECRES,0))
 Q:SDECRESN=""
 S SDECRESN=$P(SDECRESN,"^")
 ;D EVENT^SDEC23("SCHEDULE-"_SDECRESN,"","","")
 ;D EVENT^BMXMEVN("SDEC SCHEDULE",SDECRESN)
 Q
 ;
CHKEVTD(SDECPAT,SDECSTART,SDECSC) ;EP Called by SDEC CHECKIN APPOINTMENT event
 ;when  an appointment CHECKIN is deleted via.
 ;Deletes CHECKIN to and raises refresh event to running GUI clients
 ;
 ;
 Q:+$G(SDECNOEV)
 Q:'+$G(SDECSC)
 N SDECSTAT,SDECFOUND,SDECRES
 S SDECSTAT=""
 S:$G(SDATA("AFTER","STATUS"))'="CHECKED IN" SDECSTAT=$P(SDATA("AFTER","STATUS"),"^",4)
 I SDECSTAT="" S SDECRES=$O(^SDEC(409.831,"ALOC",SDECSC,0))
 I SDECRES D CHKEVT3(SDECRES) Q
 S SDECFOUND=0
 ;
 ;I $D(^SDEC(409.831,"ALOC",SDECSC)) S SDECRES=$O(^SDEC(409.831,"ALOC",SDECSC,0)) S SDECFOUND=$$CHKEVT1(SDECRES,SDECSTART,SDECPAT,SDECSTAT)
 ;I SDECFOUND D CHKEVT3(SDECRES) Q
 Q
 ;
 ;CHECK OUT APPOINTMENT - RPC
CHECKOUT(SDECY,DFN,SDT,SDCODT,SDECAPTID,VPRV) ;Check Out appointment
 ;CHECKOUT(SDECY,DFN,SDT,SDCODT,SDECAPTID,VPRV)  external parameter tag is in SDEC
 ; Returns   SDECY
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time in FM format
 ;           SDCODT   Date/Time of Check Out FM FORMAT [REQUIRED]
 ;           SDECAPTID - Appointment ID
 ;           VPRV      - V Provider
 ;SETUP ERROR TRACKING
 N APIERR,CNT,ERR,%DT,X,Y
 N SDCL,SDASK,SDCOACT,SDCOALBF,SDDA,SDLNE,SDQUIET
 N SDECI,SDECNOD
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I '+SDECAPTID D ERR("Invalid Appointment ID.") Q
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR("Invalid Appointment ID.") Q
 ;INITIALIZE VARIABLES
 S %DT="T"
 S X=SDT
 D ^%DT   ; GET FM FORMAT FOR APPOINTMENT DATE/TIME
 S SDT=Y
 S X=SDCODT
 D ^%DT   ; GET FM FORMAT FOR CHECKOUT DATE/TIME
 ;ChecOut time cannot be in the future
 S SDCODT=Y
 I SDCODT>$$HTFM^XLFDT($H) D ERR("Check Out time cannot be in the future.") Q
 ;
 ;appointment record
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 ;make sure CHECKOUT time is after CHECKIN time
 I SDCODT'>$P(SDECNOD,U,3) D ERR("Check Out time must be at least 1 minute after the Check In time of "_$TR($$FMTE^XLFDT($P(SDECNOD,U,3)),"@"," ")_".") Q   ;alb/sat 665
 ;Hospital Location of RESOURCE
 S SDECRES=$P(SDECNOD,U,7) ;RESOURCEID
 S SDECNOD=^SDEC(409.831,SDECRES,0)
 S SDCL=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 ;
 S SDDA=0
 S SDASK=0
 S SDCOALBF=""
 S SDCOACT="CO"
 S SDLNE=""
 S SDQUIET=1
 K APIERR
 S APIERR=0
 D CO^SDEC25A(DFN,SDT,SDCL,SDDA,SDASK,SDCODT,SDCOACT,SDLNE,.SDCOALBF,SDECAPTID,SDQUIET,VPRV,.APIERR) ;Appt Check Out
 ;ERROR(S) FOUND
 I APIERR>0 D
 . S CNT=""
 . F  S CNT=$O(APIERR(CNT)) Q:CNT=""  S ERR=APIERR(CNT) S SDECI=SDECI+1 D ERR(ERR)
 ;NO ERROR
 I APIERR<1 D
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)="0"_$C(30)
 . S SDECI=SDECI+1
 . S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
 ;CHECK OUT APPOINTMENT - RPC
CANCKOUT(SDECY,SDECAPTID) ;Cancel Check Out appointment
 ;CANCKOUT(SDECY,SDECAPTID)  external parameter tag is in SDEC
 ; Returns   SDECY
 ; Input  -- SDECAPTID - Appointment ID
 N APS,DA,DFN,DIE,DR,RES
 N SDCL,SDN,SDOE,SDT,SDV
 N SDECI,SDECNOD
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 I '+SDECAPTID D ERR("Invalid Appointment ID.") Q
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR("Invalid Appointment ID.") Q
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S APS=$P(SDECNOD,U,19)
 S DFN=$P(SDECNOD,U,5)
 S SDT=$P(SDECNOD,U)
 S RES=$P(SDECNOD,U,7)
 S SDCL=$P(^SDEC(409.831,RES,0),U,4)
 I $P(SDECNOD,U,14)="" D ERR("Appointment is not Checked Out.") Q
 ; ^SDECAPPT: update piece 8: Data Entry Clerk; clear piece 14: CHECKOUT;
 S DIE="^SDEC(409.84,"
 S DA=SDECAPTID
 S DR=".14////@;.08///"_DUZ
 D ^DIE
 ; ^SC file 44: clear piece C;3: CHECKED OUT; clear piece C;4: CHECK OUT USER; clear C;6: CHECK OUT ENTERED
 S DIE="^SC("_SDCL_",""S"","_SDT_",1,"
 S DA(2)=SDCL,DA(1)=SDT,(DA,SDN)=$$SCIEN^SDECU2(DFN,SDCL,SDT)
 S DR="303///@;304///@;306///@"
 D ^DIE
 ; ^AUPNVSIT file 9000010: clear piece 18: CHECK OUT DATE&TIME
 S SDOE=$$GETAPT^SDVSIT2(DFN,SDT,SDCL)
 S SDV=$$GET1^DIQ(409.68,SDOE,.05,"I")
 I +SDV D
 . S DIE="^AUPNVSIT(",DA=SDV
 . S DR=".18///@"
 . D ^DIE
 ; ^SCE file 409.68: Set piece 12 back to CHECKED IN, pointer to APPOINTMENT STATUS file 409.63; clear piece 7: CHECK OUT PROCESS COMPLETION
 I +APS D
 . S DIE=409.68,DA=SDOE,DR=".07///@;.12///"_APS_";101///"_DUZ_";102///"_$$NOW^XLFDT
 . D ^DIE
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)="0"_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
CANAPPT(SDECAPTID)  ;external call to cancel check out in SDEC APPOINTMENT called by SDCODEL for VistA Delete Check Out
 N APS,DA,DIE,DR,DFN,RES,SDCL,SDT
 N SDECNOD
 I '+$G(SDECAPTID) Q
 I '$D(^SDEC(409.84,+SDECAPTID,0)) Q
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S APS=$P(SDECNOD,U,19)
 S DFN=$P(SDECNOD,U,5)
 S SDT=$P(SDECNOD,U)
 S RES=$P(SDECNOD,U,7)
 S SDCL=$P(^SDEC(409.831,RES,0),U,4)
 I $P(SDECNOD,U,14)="" Q
 ; ^SDEC(409.84: update piece 8: Data Entry Clerk; clear piece 14: CHECKOUT;
 S DIE="^SDEC(409.84,"
 S DA=SDECAPTID
 S DR=".14////@;.08///"_DUZ
 D ^DIE
 Q
 ;
ERROR ;
 D ERR("VISTA Error")
 Q
 ;
ERR(ERRNO) ;Error processing
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=ERRNO_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
