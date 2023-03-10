SDES25 ;ALB/MGD/LEG - VISTA SCHEDULING RPCS ;June 7, 2021@13:07
 ;;5.3;Scheduling;**790**;Aug 13, 1993;Build 11
 ;
 ; Documented API's and Integration Agreements
 ; -------------------------------------------
 ; Reference to ^AUPNVSIT(    In ICR #2309
 ; Reference to ^DPT(         In ICR #7030
 ;
 Q
 ; Check in appointment
CHECKIN(JSON,SDECAPTID,SDECCDT,SDECCC,SDECPRV) ; 
 ; RPC: SDES APPT CHECKIN JSON. Entry parameter tag is in SDES.
 ; This routine is based off of the existing SDES25 routine. It has been
 ; optimized and updated to return info in JSON format.
 ;
 ; INPUT: SDECAPTID - (required) Appointment ID
 ;        SDECCDT   - (required) Check-in date/time
 ;                               "@" - indicates delete check-in
 ;        SDECCC    - (optional) Clinic Stop pointer to CLINIC STOP file
 ;        SDECPRV   - (optional) Provider pointer to NEW PERSON file
 ;                               default to current user
 ;
 ; OUTPUT: JSON formatted data for success ("0"), error info for failure (error message)
 ;
 N BSDVSTN
 N SDECNOD,SDECPATID,SDECSTART,DIK,DA,SDECID,SDECZ,SDECIENS,SDECVEN,JSONMSG
 N SDECNOEV,SDECCAN,SDECR1,SDESERROR,%DT,X,Y,ERR
 S SDECNOEV=1 ;Don't execute protocol
 S SDECCAN=0
 S SDESERROR=0 ; Initialize error flag = 0:No Error
 ;
 ;validate SDEC appointment ID
 S SDECAPTID=$G(SDECAPTID)
 I SDECAPTID="" S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,14)
 I SDECAPTID'="",'$D(^SDEC(409.84,SDECAPTID,0)) S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,15)
 S SDECAPTID=+SDECAPTID
  ;validate checkin date/time (required)
 S SDECCDT=$G(SDECCDT)
 S:SDECCDT="@" SDECCAN=1
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ;
 ; ### IS THE PREVIOUS DAY @24 GOING TO BE A PROBLEM ?
 I SDECCDT="" S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,21)
 I 'SDECCAN,SDECCDT'="" S SDECCDT=$$NETTOFM^SDECDATE(SDECCDT,"Y") I SDECCDT=-1 S SDESERROR=1,SDECCDT="" D ERRLOG^SDESJSON(.JSONMSG,22)
 ;validate clinic stop code
 S SDECCC=$G(SDECCC)
 ; ### DOES THE VA GET "CREDIT" BASED ON THE ABILITY TO TRACK CHECKING VIA CLINIC STOP CODE?
 ; ### IF SO, SHOULD THIS BE UPDATED TO PREVENT CHECKINS UNTIL A VALID STOP CODE IS PROVIDED?
 I SDECCC'="" I '$D(^DIC(40.7,SDECCC,0)) S SDECCC=""
 ;validate provider (optional)
 S SDECPRV=$G(SDECPRV)
 I SDECPRV'="" I '$D(^VA(200,+SDECPRV,0)) S SDECPRV=""
 ;
 S SDECNOD=$G(^SDEC(409.84,SDECAPTID,0))
 S (SDECPATID,DFN)=$P(SDECNOD,U,5)
 S SDECSTART=$P(SDECNOD,U)
 ;
 S SDECR1=$P(SDECNOD,U,7) ;RESOURCEID
 I 'SDESERROR D
 . I SDECR1<1 S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,18)
 . I SDECR1]"",'$D(^SDEC(409.831,SDECR1,0)) S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,19)
 . I SDECR1]"",$D(^SDEC(409.831,SDECR1,0)) D
 . . S SDECNOD=^SDEC(409.831,SDECR1,0)
 . . S SDECSC1=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 . . ;Hospital Location is required for CHECKIN
 . . I 'SDECSC1]"",'$D(^SC(+SDECSC1,0)) D  Q
 . . . N SDESERRMSG2
 . . . S SDESERRMSG2=$P(SDECNOD,U,1)_" ("_SDECSC1_")"
 . . . D ERRLOG^SDESJSON(.JSONMSG,18,SDESERRMSG2)
 . . . S SDESERROR=1
  ;if resource Id is not null AND there is a valid resource record
 ; ### Trace what sets SDECZ
 I 'SDESERROR D  I +$G(SDECZ) S SDESERROR=1 D ERRLOG^SDESJSON(.JSONMSG,0,$P(SDECZ,U,2))
 . ;
 . ;  Event driver "BEFORE" actions - wtc SD*5.3*717 10/24/18
 . ;
 . N SDATA,SDDA,SDCIHDL ;
 . S SDDA=$$FIND(DFN,SDECSTART,SDECSC1),SDATA=SDDA_U_DFN_U_SDECSTART_U_SDECSC1,SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 . D BEFORE^SDAMEVT(.SDATA,DFN,SDECSTART,SDECSC1,SDDA,SDCIHDL) ;
 . ;
 . I 'SDECCAN D  ;
 . . ;
 . . ;  Checkin SDEC APPOINTMENT entry - wtc SD*5.3*717 10/24/18
 . . ;
 . . D SDECCHK(SDECAPTID,SDECCDT) ; sets field .03 (Checkin), in file 409.84
 . . D APCHK(.SDECZ,SDECPATID,SDECSC1,SDECCC,SDECPRV,SDECSTART,SDECCDT,DUZ)
 . . I $G(SDECPRV) S DIE="^SDEC(409.84,",DA=SDECAPTID,DR=".16///"_SDECPRV D ^DIE ; PROVIDER
 . ;
 . I SDECCAN D  ;
 . . ;
 . . ;  Cancel check in - wtc SD*5.3*717 10/24/18
 . . ;
 . . D SDECCHK(SDECAPTID,"") ; sets field .03 (Checkin), in file 409.84
 . . D CANCHKIN(SDECPATID,SDECSC1,SDECSTART) ;
 . ;
 . ;  Event driver "AFTER" actions - wtc SD*5.3*717 10/24/18
 . ;
 . D AFTER^SDAMEVT(.SDATA,DFN,SDECSTART,SDECSC1,SDDA,SDCIHDL) ;
 . ;
 . ;  Execute event driver.  4=check in (see #409.66), 2=non-interactive - wtc SD*5.3*717 10/25/18
 . ;
 . ;*zeb+1 717 3/19/19 prevent extra cancel check-in when canceling a checked-in walkin
 . I '((SDECCDT="@")&($G(SDECTYP)]"")) D EVT^SDAMEVT(.SDATA,4,2,SDCIHDL) ;assumes SDECTYP, which is defined if coming from APPDEL^SDEC08
 ;
 ; If Checkin was successful, update JSONMSG array and call JSON encoder.
 ; ### Need to validate whether to send by a 0 or a "" for succesful checkins
 I 'SDESERROR S JSONMSG("RESULT",1)=0
 D ENCODE^SDESJSON(.JSONMSG,.JSON,.ERR)
 Q
 ;
 ; Update Checkin related fields
SDECCHK(SDECAPTID,SDECCDT) ;
 N SDECFDA,SDECMSG
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.03)=SDECCDT ; CHECKIN
 S SDECFDA(409.84,SDECIENS,.04)=$S(SDECCDT'="":$$NOW^XLFDT,1:"") ; CHECK IN TIME ENTERED
 D FILE^DIE("","SDECFDA","SDECMSG")
 Q
 ;    
APCHK(SDECZ,SDECPATID,SDECSC1,SDECCC,SDECPRV,SDECSTART,SDECCDT,DUZ) ;
 ;Checkin appointment for patient SDECDFN in clinic SDECSC1
 ;at time SDECSD
 N BSDMSG,SDECC
 S SDECC("PAT")=SDECPATID
 S SDECC("HOS LOC")=SDECSC1
 S SDECC("CLINIC CODE")=SDECCC
 S SDECC("PROVIDER")=SDECPRV
 S SDECC("APPT DATE")=SDECSTART
 S SDECC("CDT")=SDECCDT
 S SDECC("USR")=DUZ
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
 N SDECOUT
 D GETVISIT^SDECAPI4(.SDECC,.SDECOUT)
 Q
 ;
CANCHKIN(DFN,SDCL,SDT) ; Logic to cancel a checkin if the checkin date/time is passed in as '@'
 ; input:  DFN := ifn of patient
 ;        SDCL := clinic#
 ;         SDT := appt d/t
 ;
 N SDDA
 S SDDA=$$FIND(DFN,SDT,SDCL)
 S FDA(44.003,SDDA_","_SDT_","_SDCL_",",309)=""
 D FILE^DIE(,"FDA","ERR")
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
 ;   input:   DFN := ifn of pat.
 ;            SDT := appt d/t
 ;           SDCL := ifn of clinic
 ;           SDDA := ifn of appt
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
 I SDECFOUND,+$G(SDECAPPT) D  ;
 . D SDECCHK(SDECAPPT,SDECSTAT)
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
 N SDECI,SDECNOD,RPCPERM
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 S RPCPERM=""
 S RPCPERM=$$KCHK^XUSRB("SD SUPERVISOR",DUZ) I RPCPERM=0 D ERR("THE SD SUPERVISOR KEY IS REQUIRED TO PERFORM THIS ACTION.") Q
 I '+SDECAPTID D ERR("Invalid Appointment ID.") Q
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR("Invalid Appointment ID.") Q
 ;INITIALIZE VARIABLES
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ; 
 ;S %DT="T"
 ;S X=SDT
 ;D ^%DT   ; GET FM FORMAT FOR APPOINTMENT DATE/TIME
 ;S SDT=Y
 S SDT=$$NETTOFM^SDECDATE(SDT,"Y") ;
 ;S X=SDCODT
 ;D ^%DT   ; GET FM FORMAT FOR CHECKOUT DATE/TIME
 S SDCODT=$$NETTOFM^SDECDATE(SDCODT,"Y") ;
 ;ChecOut time cannot be in the future
 ;S SDCODT=Y
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
 ;
 ;  Event driver "BEFORE" actions - wtc SD*5.3*717 10/25/18
 ;
 N SDATA,SDDA,SDCIHDL ;
 S SDDA=$$FIND(DFN,SDT,SDCL),SDATA=SDDA_U_DFN_U_SDT_U_SDCL,SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 ;
 ;  Event driver "BEFORE" actions - wtc SD*5.3*717 10/25/18
 ;
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL) ;
 ;
 D CO^SDEC25A(DFN,SDT,SDCL,SDDA,SDASK,SDCODT,SDCOACT,SDLNE,.SDCOALBF,SDECAPTID,SDQUIET,VPRV,.APIERR) ;Appt Check Out
 ;
 ;  Skip event driver actions if error occurred checking appointment out. - wtc SD*5.3*717 10/25/2018
 ;
 I 'APIERR D  ;
 . ;
 . ;  Event driver "AFTER" actions - wtc SD*5.3*717 10/25/18
 . ;
 . D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL) ;
 . ;
 . ;  Execute event driver.  5=check out (see #409.66), 2=non-interactive - wtc SD*5.3*717 10/25/18
 . ;
 . D EVT^SDAMEVT(.SDATA,5,2,SDCIHDL) ;
 ;
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
 N SDECI,SDECNOD,RPCPERM
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,0)="T00020ERRORID"_$C(30)
 S RPCPERM=""
 S RPCPERM=$$KCHK^XUSRB("SD SUPERVISOR",DUZ) I RPCPERM=0 D ERR("THE SD SUPERVISOR KEY IS REQUIRED TO PERFORM THIS ACTION.") Q
 I '+SDECAPTID D ERR("Invalid Appointment ID.") Q
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR("Invalid Appointment ID.") Q
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S APS=$P(SDECNOD,U,19)
 S DFN=$P(SDECNOD,U,5)
 S SDT=$P(SDECNOD,U)
 S RES=$P(SDECNOD,U,7)
 S SDCL=$P(^SDEC(409.831,RES,0),U,4)
 I $P(SDECNOD,U,14)="" D ERR("Appointment is not Checked Out.") Q
 ;
 ;  Event driver "BEFORE" actions - wtc SD*5.3*717 10/25/18
 ;
 N SDATA,SDDA,SDCIHDL ;
 S SDDA=$$FIND(DFN,SDT,SDCL),SDATA=SDDA_U_DFN_U_SDT_U_SDCL,SDCIHDL=$$HANDLE^SDAMEVT(1) ;
 ;
 ;  Event driver "BEFORE" actions - wtc SD*5.3*717 10/25/18
 ;
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL) ;
 ;
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
 ;
 ;  Event driver "AFTER" actions - wtc SD*5.3*717 10/25/18
 ;
 D AFTER^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCIHDL) ;
 ;
 ;  Execute event driver.  5=check out (see #409.66), 2=non-interactive - wtc SD*5.3*717 10/25/18
 ;
 D EVT^SDAMEVT(.SDATA,5,2,SDCIHDL) ;
 ;
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
ERR(JSONMSG) ;Error processing
 S JSONMSG("Error",1)=JSONMSG
 D ENCODE^XLFJSON("JSONMSG","JSON","ERR")
 S SDESERROR=1
 Q
