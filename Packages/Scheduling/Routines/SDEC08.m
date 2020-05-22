SDEC08 ;ALB/SAT/JSM - VISTA SCHEDULING RPCS ;JUN 21, 2017
 ;;5.3;Scheduling;**627,651,658,665,722,740,744**;Aug 13, 1993;Build 3
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;
 Q
 ;
APPDEL(SDECY,SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER) ;Cancels appointment
 ;APPDEL(SDECY,SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER)  external parameter tag is in SDEC
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file
 ;SDECTYP   - (required) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ;SDECCR    - (optional) pointer to CANCELLATION REASON File (409.2)
 ;SDECNOT   - (optional) text representing user note
 ;SDECDATE   - (optional) Cancel Date/Time in external format; defaults to NOW
 ;SDUSER     - (optional) User that cancelled appt; defaults to current user
 ;Returns error code in recordset field ERRORID
 ;
 N SDECNOD,SDECPATID,SDECSTART,DIK,DA,SDECID,SDECI,SDECZ,SDECERR
 N SDECLOC,SDECLEN,SDECSCIEN,SDECSCIEN1
 N SDECNOEV,SDECSC1,SDRET
 N %DT,X,Y
 S SDECNOEV=1 ;Don't execute SDEC CANCEL APPOINTMENT protocol
 S SDECSCIEN1=0
 ;
 S SDECI=0
 S SDECY="^TMP(""SDEC08"","_$J_",""APPDEL"")"
 K @SDECY
 S @SDECY@(SDECI)="T00020ERRORID"_$C(30)
 S SDECI=SDECI+1
 ;validate SDEC APPOINTMENT pointer (required)
 I '$D(^SDEC(409.84,+$G(SDECAPTID),0)) D ADERR(SDECI,.SDECY,"SDEC08: Invalid Appointment ID",+$G(SDECAPTID),0) Q  ;BI/SD*5.3*740 added ADERR
 ;validate appointment status type (required)
 S SDECTYP=$G(SDECTYP)
 S SDECTYP=$S(SDECTYP="C":"C",SDECTYP="CANCELLED BY CLINIC":"C",SDECTYP="PC":"PC",SDECTYP="CANCELLED BY PATIENT":"PC",1:"")
 I SDECTYP="" D ADERR(SDECI,.SDECY,"SDEC08: Invalid status type",+$G(SDECAPTID),0) Q   ;BI/SD*5.3*740 added ADERR
 ;validate CANCELLATION REASON pointer (optional)
 S SDECCR=$G(SDECCR)
 I SDECCR'="" I '$D(^SD(409.2,+SDECCR,0)) S SDECCR=$O(^SD(409.2,"B","SDECCR",0))
 ;validate SDECNOT
 S SDECNOT=$TR($G(SDECNOT),"^"," ")  ;alb/sat 658 - strip out ^
 ;validate cancel date/time
 S SDECDATE=$G(SDECDATE)
 I SDECDATE'="" S %DT="T" S X=SDECDATE D ^%DT S SDECDATE=Y I Y=-1 S SDECDATE=""
 I $G(SDECDATE)="" S SDECDATE=$$NOW^XLFDT
 ;validate user
 S SDUSER=$G(SDUSER)
 I SDUSER'="" I '$D(^VA(200,+SDUSER,0)) S SDUSER=""
 I SDUSER="" S SDUSER=DUZ
 ;
 ;Delete APPOINTMENT entries
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S SDECPATID=$P(SDECNOD,U,5)
 S SDECSTART=$P(SDECNOD,U)
 ;
 ;Lock SDEC node
 L +^SDEC(409.84,SDECPATID):5 I '$T D ADERR(SDECI+1,.SDECY,"Another user is working with this patient's record.  Please try again later",+SDECPATID,0) Q   ;BI/SD *5.3*740
 ;cancel check-in if walk-in
 I $P(SDECNOD,U,13)="y" D
 .S SDRET=""
 .D CHECKIN^SDEC25(.SDRET,SDECAPTID,"@")
 ;cancel SDEC APPOINTMENT record
 D SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER,1)
 ;
 S SDECSC1=$P(SDECNOD,U,7) ;RESOURCEID
 I SDECSC1]"",$D(^SDEC(409.831,SDECSC1,0)) D  I +$G(SDECZ) S SDECERR=+SDECZ D ADERR(SDECI,.SDECY,$P(SDECZ,U,2),+SDECPATID,1) Q   ;BI/SD*5.3*740 added ADERR
 . S SDECNOD=^SDEC(409.831,SDECSC1,0)
 . S SDECLOC=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 . Q:'+SDECLOC
 . S SDECSCIEN=$$SCIEN^SDECU2(SDECPATID,SDECLOC,SDECSTART) I SDECSCIEN="" D  I 'SDECZ Q  ;Q:SDECZ
 . . S SDECERR="SDEC08: Unable to find associated appointment for this patient. "
 . . S SDECZ=1
 . . I '$D(^SDEC(409.831,SDECSC1,20)) S SDECZ=0 Q
 . . N SDEC1
 . . S SDEC1=0
 . . F  S SDEC1=$O(^SDEC(409.831,SDECSC1,20,SDEC1)) Q:'+SDEC1  Q:SDECZ=0  D
 . . . Q:'$D(^SDEC(409.831,SDECSC1,20,SDEC1,0))
 . . . S SDECLOC=$P(^SDEC(409.831,SDECSC1,20,SDEC1,0),U)
 . . . S SDECSCIEN=$$SCIEN^SDECU2(SDECPATID,SDECLOC,SDECSTART) I +SDECSCIEN S SDECZ=0 Q
 . S SDECERR="SDEC08: CANCEL^SDEC08 Returned "
 . I SDECLOC']"" S SDECZ="0^Unable to find associated appointment for this patient." Q
 . I '$D(^SC(SDECLOC,0)) S SDECZ="0^Unable to find associated appointment for this patient." Q
 . S SDECNOD=$G(^SC(SDECLOC,"S",SDECSTART,1,+SDECSCIEN,0))
 . I SDECNOD="" S SDECZ="0^Unable to find associated appointment for this patient." Q
 . S SDECLEN=$P(SDECNOD,U,2)
 . D APCAN(.SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECAPTID,SDECLEN)
 . Q:+$G(SDECZ)
 . D AVUPDT(SDECLOC,SDECSTART,SDECLEN)
 . D AR433D^SDECAR2(SDECAPTID)
 L -^SDEC(409.84,SDECPATID)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=""_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 Q
 ;
ADERR(SDECI,SDECY,SDECERR,SDECPATID,LOCK) ;Error processing   BI/SD*5.3*740
 S SDECI=SDECI+1
 S SDECERR=$TR(SDECERR,"^","~")
 S @SDECY@(SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 I LOCK=1  L -^SDEC(409.84,SDECPATID)
 Q
 ;
AVUPDT(SDECSCD,SDECSTART,SDECLEN) ;Update Clinic availability
 ;See SDCNP0
 N HSI,I,S,SB,SD,SDDIF,SI,SL,SS,ST,STARTDAY,STR,X,Y
 S (SD,S)=SDECSTART
 S I=SDECSCD
 Q:'$D(^SC(I,"ST",SD\1,1))
 S SL=^SC(I,"SL"),X=$P(SL,U,3),STARTDAY=$S($L(X):X,1:8),SB=STARTDAY-1/100,X=$P(SL,U,6),HSI=$S(X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4),STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2)
 S SL=SDECLEN
 S S=^SC(I,"ST",SD\1,1),Y=SD#1-SB*100,ST=Y#1*SI\.6+(Y\1*SI),SS=SL*HSI/60
 I Y'<1 F I=ST+ST:SDDIF S Y=$E(STR,$F(STR,$E(S,I+1))) Q:Y=""  S S=$E(S,1,I)_Y_$E(S,I+2,999),SS=SS-1 Q:SS'>0
 S ^SC(SDECSCD,"ST",SD\1,1)=S
 Q
 ;
APCAN(SDECZ,SDECLOC,SDECDFN,SDECSD,SDECAPTID,SDECLEN) ;
 ;Cancel appointment for patient SDECDFN in clinic SDECSC1 at time SDECSD
 N SDECPNOD,SDECC,DA,DIE,DPTST,DR,%H
 ;save data into SDEC APPOINTMENT in case of un-cancel (status & appt length)
 S SDECPNOD=^DPT(SDECPATID,"S",SDECSD,0)
 S DPTST=$P(SDECPNOD,U,2)
 S DIE=409.84
 S DA=SDECAPTID
 S DR=".17///"_DPTST_";"_".18///"_SDECLEN
 D ^DIE
 S SDECC("PAT")=SDECDFN
 S SDECC("CLN")=SDECLOC
 S SDECC("TYP")=SDECTYP
 S SDECC("ADT")=SDECSD
 S %H=$H D YMD^%DTC
 S SDECC("CDT")=SDECDATE   ;X+%
 S SDECC("NOT")=SDECNOT
 S:+SDECCR SDECC("CR")=SDECCR
 S SDECC("USR")=SDUSER
 ;
 S SDECZ=$$CANCEL(.SDECC)
 Q
 ;
SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER,SDF) ;cancel SDEC APPOINTMENT entry
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file
 ;SDECTYP   - (required) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ;SDECCR    - (optional) pointer to CANCELLATION REASON File (409.2)
 ;SDECNOT   - (optional) text representing user note
 ;SDECDATE   - (optional) Cancel Date/Time in fm format; defaults to NOW) ;
 ;SDF       - (optional) flags
 ;                       1. called from GUI (update consult only if called from GUI)
 ;                       2. called from cancel in SDAM (CAN^SDCNP0) (do not reopen appt)
 ;Cancel SDEC APPOINTMENT entry
 N DFN,PROVIEN,Y
 N SAVESTRT,SDAPTYP,SDCL,SDI,SDIEN,SDECIENS,SDECFDA,SDECMSG,SDECWP,SDRES,SDT   ;alb/sat 651 add SAVESTRT and SDRES
 S SDF=$G(SDF,0)
 S DFN=$$GET1^DIQ(409.84,SDECAPTID_",",.05)   ;alb/sat 658
 S SDT=$$GET1^DIQ(409.84,SDECAPTID_",",.01,"I")
 S SAVESTRT=$$GET1^DIQ(409.84,SDECAPTID_",",.01)   ;alb/sat 651
 S SDRES=$$GET1^DIQ(409.84,SDECAPTID_",",.07,"I")  ;alb/sat 651
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.12)=$S($G(SDECDATE)'="":SDECDATE,1:$$NOW^XLFDT)
 S SDECFDA(409.84,SDECIENS,.121)=$S($G(SDUSER)'="":SDUSER,1:DUZ)
 S:$G(SDECCR)'="" SDECFDA(409.84,SDECIENS,.122)=SDECCR
 S SDECFDA(409.84,SDECIENS,.17)=SDECTYP
 K SDECMSG
 D FILE^DIE("","SDECFDA","SDECMSG")
 S SDAPTYP=$$GET1^DIQ(409.84,SDECAPTID_",",.22,"I")
 ;alb/sat 658 modification begin
 S SDECNOT=$G(SDECNOT),SDECNOT=$E(SDECNOT,1,160)
 I $L(SDECNOT)>2,'$E(SDF,2) K SDECFDA S SDECFDA(2.98,SDT_","_DFN_",",17)=SDECNOT D UPDATE^DIE("","SDECFDA")
 ;alb/sat 658 modification end
 I $P(SDAPTYP,";",2)="GMR(123,",$E(SDF,1) D
 .S SDCL=$$SDCL^SDECUTL(SDECAPTID)
 .S PROVIEN=$$GET1^DIQ(44,SDCL_",",16,"I")
 .D REQSET^SDEC07A($P(SDAPTYP,";",1),PROVIEN,"",2,SDECTYP,SDECNOT,SAVESTRT,SDRES)  ;alb/sat 651 added SAVESTRT
 I $P(SDAPTYP,";",2)="SDWL(409.3," D   ;update EWL
 .S DFN=$$GET1^DIQ(409.3,$P(SDAPTYP,";",1)_",",.01,"I")
 .Q:DFN=""
 .S SDIEN=0 F  S SDIEN=$O(^SDWL(409.3,"B",DFN,SDIEN)) Q:SDIEN=""  D
 ..I $$GET1^DIQ(409.3,SDIEN_",",13,"I")=SDT D
 ...K SDECFDA,SDECMSG,SDECWP
 ...;S SDIEN=$P(SDAPTYP,";",1)
 ...S SDECFDA(409.3,SDIEN_",",13)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.1)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.2)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.3)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.4)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.5)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.6)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.7)="@"
 ...S SDECFDA(409.3,SDIEN_",",13.8)="@"
 ...D UPDATE^DIE("","SDECFDA")
 ...D:'$E(SDF,2) WLOPEN^SDECWL("","",SDIEN)  ;alb/jsm 658 do not reopen if called from SDEC^SDCNP0
 I $P(SDAPTYP,";",2)="SDEC(409.85," D   ;update APPT
 .K SDECFDA,SDECMSG,SDECWP
 .D:'$E(SDF,2) AROPEN^SDECAR("",SDECAPTID)  ;alb/jsm 658 do not reopen if called from SDEC^SDCNP0
 .S SDIEN=$P(SDAPTYP,";",1)
 .S SDECFDA(409.85,SDIEN_",",13)="@"
 .S SDECFDA(409.85,SDIEN_",",13.1)="@"
 .S SDECFDA(409.85,SDIEN_",",13.2)="@"
 .S SDECFDA(409.85,SDIEN_",",13.3)="@"
 .S SDECFDA(409.85,SDIEN_",",13.4)="@"
 .S SDECFDA(409.85,SDIEN_",",13.5)="@"
 .S SDECFDA(409.85,SDIEN_",",13.6)="@"
 .S SDECFDA(409.85,SDIEN_",",13.7)="@"
 .S SDECFDA(409.85,SDIEN_",",13.8)="@"
 .D UPDATE^DIE("","SDECFDA")
 Q
 ;
CANEVT(SDECPAT,SDECSTART,SDECSC) ;EP Called by SDEC CANCEL APPOINTMENT event
 ;when appointments cancelled via PIMS interface.
 ;Propagates cancellation to SDECAPPT and raises refresh event to running GUI clients
 N SDECFOUND,SDECRES
 Q:+$G(SDECNOEV)
 Q:'+$G(SDECSC)
 S SDECFOUND=0
 I $D(^SDEC(409.831,"ALOC",SDECSC)) S SDECRES=$O(^SDEC(409.831,"ALOC",SDECSC,0)) S SDECFOUND=$$CANEVT1(SDECRES,SDECSTART,SDECPAT)
 I SDECFOUND D CANEVT3(SDECRES) Q
 Q
 ;
CANEVT1(SDECRES,SDECSTART,SDECPAT) ;
 ;Get appointment id in SDECAPT
 ;If found, call SDECCAN(SDECAPPT) and return 1
 ;else return 0
 N SDECFOUND,SDECAPPT
 S SDECFOUND=0
 Q:'+SDECRES SDECFOUND
 Q:'$D(^SDEC(409.84,"ARSRC",SDECRES,SDECSTART)) SDECFOUND
 S SDECAPPT=0 F  S SDECAPPT=$O(^SDEC(409.84,"ARSRC",SDECRES,SDECSTART,SDECAPPT)) Q:'+SDECAPPT  D  Q:SDECFOUND
 . S SDECNOD=$G(^SDEC(409.84,SDECAPPT,0)) Q:SDECNOD=""
 . I $P(SDECNOD,U,5)=SDECPAT,$P(SDECNOD,U,12)="" S SDECFOUND=1 Q
 I SDECFOUND,+$G(SDECAPPT) D SDECCAN(SDECAPPT,,,,,,1)
 Q SDECFOUND
 ;
CANEVT3(SDECRES) ;
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
CANCEL(BSDR) ;EP; called to cancel appt
 ;
 ; Make call using: S ERR=$$CANCEL^SDEC08(.ARRAY)
 ;
 ; Input Array -
 ; BSDR("PAT") = ien of patient in file 2
 ; BSDR("CLN") = ien of clinic in file 44
 ; BSDR("TYP") = C for canceled by clinic; PC for patient canceled
 ; BSDR("ADT") = appointment date and time
 ; BSDR("CDT") = cancel date and time
 ; BSDR("USR") = user who canceled appt
 ; BSDR("CR")  = cancel reason - pointer to file 409.2
 ; BSDR("NOT") = cancel remarks - optional notes to 160 characters
 ;
 ;Output: error status and message
 ;   = 0 or null:  everything okay
 ;   = 1^message:  error and reason
 ;
 I '$D(^DPT(+$G(BSDR("PAT")),0)) Q 1_U_"Patient not on file: "_$G(BSDR("PAT"))
 I '$D(^SC(+$G(BSDR("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(BSDR("CLN"))
 I ($G(BSDR("TYP"))'="C"),($G(BSDR("TYP"))'="PC") Q 1_U_"Cancel Status error: "_$G(BSDR("TYP"))
 I $G(BSDR("ADT")) S BSDR("ADT")=+$E(BSDR("ADT"),1,12)  ;remove seconds
 I $G(BSDR("ADT"))'?7N1".".4N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))
 I $G(BSDR("CDT")) S BSDR("CDT")=+$E(BSDR("CDT"),1,12)  ;remove seconds
 I $G(BSDR("CDT"))'?7N1".".4N Q 1_U_"Cancel Date/Time error: "_$G(BSDR("CDT"))
 I '$D(^VA(200,+$G(BSDR("USR")),0)) Q 1_U_"User Who Canceled Appt Error: "_$G(BSDR("USR"))
 I '$D(^SD(409.2,+$G(BSDR("CR")))) Q 1_U_"Cancel Reason error: "_$G(BSDR("CR"))
 ;
 NEW IEN,DIE,DA,DR,SDMODE,HLAPTIEN ;*zeb+1 722 2/21/19 save IEN for canceling appt
 S IEN=$$SCIEN^SDECU2(BSDR("PAT"),BSDR("CLN"),BSDR("ADT")),HLAPTIEN=IEN
 I 'IEN Q 1_U_"Error trying to find appointment for cancel: Patient="_BSDR("PAT")_" Clinic="_BSDR("CLN")_" Appt="_BSDR("ADT")
 ;
 I $$CI^SDECU2(BSDR("PAT"),BSDR("CLN"),BSDR("ADT"),IEN) Q 1_U_"Patient already checked in; cannot cancel until check-in deleted: Patient="_BSDR("PAT")_" Clinic="_BSDR("CLN")_" Appt="_BSDR("ADT")
 ;
 ; remember before status
 NEW SDATA,DFN,SDT,SDCL,SDDA,SDCPHDL
 S DFN=BSDR("PAT"),SDT=BSDR("ADT"),SDCL=BSDR("CLN"),SDMODE=2,SDDA=IEN
 S SDCPHDL=$$HANDLE^SDAMEVT(1),SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCPHDL)
 ;
 ; get user who made appt and date appt made from ^SC
 ;    because data in ^SC will be deleted
 NEW USER,DATE
 S USER=$P($G(^SC(SDCL,"S",SDT,1,IEN,0)),U,6)
 S DATE=$P($G(^SC(SDCL,"S",SDT,1,IEN,0)),U,7)
 ;
 ; update file 2 info
 NEW DIE,DA,DR
 N SDFDA,SDIEN,SDMSG
 S SDFDA="SDFDA(2.98,SDT_"",""_DFN_"","")"
 S @SDFDA@(3)=BSDR("TYP")
 S @SDFDA@(14)=BSDR("USR")
 S @SDFDA@(15)=BSDR("CDT")
 S:+$G(BSDR("CR")) @SDFDA@(16)=BSDR("CR")
 S:$G(BSDR("NOT"))]"" @SDFDA@(17)=$E(BSDR("NOT"),1,160)
 S @SDFDA@(19)=USER
 S @SDFDA@(20)=DATE
 D UPDATE^DIE("","SDFDA")
 N SDPCE
 S SDPCE=$P($G(^DPT(DFN,"S",SDT,0)),U,20)
 D:+SDPCE EN^SDCODEL(SDPCE,2,"","CANCEL")  ;remove OUTPATIENT ENCOUNTER link  ;*zeb 10/25/18 722 pass in correct SDMODE and delete source
 S $P(^SC(BSDR("CLN"),"S",BSDR("ADT"),1,HLAPTIEN,0),"^",9)="C"
 ; call event driver
 S SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 D CANCEL^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDMODE,SDCPHDL)  ;*zeb 10/25/18 722 uncomment to re-enable event driver
 Q 0
 ;
UNDOCANA(SDECY,SDECAPTID) ;Undo Cancel Appointment
 ;UNDOCANA(SDECY,SDECAPTID)  external parameter tag in SDEC
 ;called by SDEC UNCANCEL APPT
 ; SDECAPTID = ien of appointment in SDEC APPOINTMENT (^SDECAPPT) file 409.84
 N SDECDAM,SDECDEC,SDECI,SDECNOD,SDECPATID,SDECSTART
 S SDECNOEV=1 ;Don't execute SDEC CANCEL APPOINTMENT protocol  ;is this used?
 ;
 S SDECI=0
 K ^TMP("SDEC",$J)
 S SDECY="^TMP(""SDEC"","_$J_")"
 S ^TMP("SDEC",$J,SDECI)="T00020ERRORID"_$C(30)
 I '+SDECAPTID D ERR(SDECI+1,"Invalid Appointment ID.",+$G(SDECAPTID),0) Q   ;BI/SD*5.3*740
 I '$D(^SDEC(409.84,SDECAPTID,0)) D ERR(SDECI+1,"Invalid Appointment ID",+SDECAPTID,0) Q   ;BI/SD*5.3*740
 ;Make sure appointment is cancelled
 I $$GET1^DIQ(409.84,SDECAPTID_",",.12)="" D ERR(SDECI+1,"Appointment is not Cancelled.",+SDECAPTID,0) Q   ;BI/SD*5.3*740
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 ;appts cancelled by patient cannot be un-cancelled. /* removed 9/17/2010 */
 ;I $P(^DPT($P(SDECNOD,U,5),"S",$P(SDECNOD,U,1),0),U,2)="PC" TROLLBACK  D ERR(SDECI+1,"Cancelled by patient appointment cannot be uncancelled.") Q
 ;get appointment data
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S SDECDAM=$P(SDECNOD,U,9)                  ;date appt made
 S SDECDEC=$P(SDECNOD,U,8)                  ;data entry clerk
 S SDECLEN=$P(SDECNOD,U,18)                 ;length of appt in minutes
 S SDECNOTE=$G(^SDEC(409.84,SDECAPTID,1,1,0))  ;note from SDEC APPOINTMENT
 S SDECPATID=$P(SDECNOD,U,5)                ;pointer to VA PATIENT file 2
 S SDECSC1=$P($G(SDECNOD),U,7)              ;resource
 S SDECSTART=$P(SDECNOD,U)                  ;appt start time
 S SDECWKIN=$P($G(SDECNOD),U,13)            ;walk-in
 ;lock SDEC node
 L +^SDEC(409.84,SDECPATID):5 I '$T D ERR(SDECI+1,"Another user is working with this patient's record.  Please try again later",+SDECPATID,0) Q   ;BI/SD*5.3*740
 ;un-cancel SDEC APPOINTMENT
 D SDECUCAN(SDECAPTID)
 I SDECSC1]"",$D(^SDEC(409.831,SDECSC1,0)) D  I +$G(SDECZ) S SDECERR=SDECERR_$P(SDECZ,U,2) D ERR(SDECI,SDECERR,+SDECPATID,1) Q   ;BI/SD*5.3*740
 . S SDECLOC=""
 . S SDECNOD=^SDEC(409.831,SDECSC1,0)
 . S SDECLOC=$P(SDECNOD,U,4) ;HOSPITAL LOCATION   ;support for single HOSPITAL LOCATION in SDEC RESOURCE
 . I SDECLOC="" S SDECLOC=$$SDCL^SDECUTL(SDECAPTID)  ;HOSPITAL LOCATION
 . Q:'+SDECLOC
 . ;un-cancel patient appointment and re-instate clinic appointment
 . S SDECZ=""
 . D APUCAN(.SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECDAM,SDECDEC,SDECLEN,SDECNOTE,SDECSC1,SDECWKIN)
 L -^SDEC(409.84,SDECPATID)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=""_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
SDECUCAN(SDECAPTID) ;called internally to update SDEC APPOINTMENT by clearing cancel date/time
 N PROVIEN,SDAPTYP,SDCL,SDRES
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.12)=""
 K SDECMSG
 D FILE^DIE("","SDECFDA","SDECMSG")
 S SDAPTYP=$$GET1^DIQ(409.84,SDECAPTID_",",.22,"I")
 I $P(SDAPTYP,";",2)="GMR(123," D
 .S SDCL=$$SDCL^SDECUTL(SDECAPTID)
 .S PROVIEN=$$GET1^DIQ(44,SDCL_",",16,"I")
 .D REQSET^SDEC07A($P(SDAPTYP,";",1),PROVIEN,"",1)
 Q
 ;
APUCAN(SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECDAM,SDECDEC,SDECLEN,SDECNOTE,SDECRES,SDECWKIN) ;
 ;un-Cancel appointment for patient SDECDFN in clinic SDECSC1
 ;  SDECLOC   = pointer to hospital location ^SC file 44
 ;  SDECPATID = pointer to VA Patient ^DPT file 2
 ;  SDECSTART = Appointment time
 ;  SDECDAM   = Date appointment made in FM format
 ;  SDECDEC   = Data entry clerk - pointer to NEW PERSON file 200
 N SDECC,%H
 S SDECC("PAT")=SDECPATID
 S SDECC("CLN")=SDECLOC
 S SDECC("ADT")=SDECSTART
 S SDECC("NOTE")=SDECNOTE  ;user note
 S SDECC("RES")=SDECRES
 S SDECC("USR")=DUZ
 S SDECC("LEN")=SDECLEN
 S SDECC("WKIN")=SDECWKIN
 ;
 S SDECZ=$$UNCANCEL(.SDECC)
 Q
 ;
UNCANCEL(BSDR) ;PEP; called to un-cancel appt
 ;
 ; Make call using: S ERR=$$UNCANCEL(.ARRAY)
 ;
 ; Input Array -
 ; BSDR("PAT") = ien of patient in file 2
 ; BSDR("CLN") = ien of clinic in file 44
 ; BSDR("ADT") = appointment date and time
 ; BSDR("USR") = user who un-canceled appt
 ; BSDR("NOTE") = appointment note from SDEC APPOINTMENT
 ; BSDR("LEN") = appt length in minutes (numeric)
 ; BSDR("RES") = resource
 ; BSDR("WKIN")= walk-in
 ;
 ;Output: error status and message
 ;   = 0 or null:  everything okay
 ;   = 1^message:  error and reason
 ;
 N DPTNOD,DPTNODR
 I '$D(^DPT(+$G(BSDR("PAT")),0)) Q 1_U_"Patient not on file: "_$G(BSDR("PAT"))
 I '$D(^SC(+$G(BSDR("CLN")),0)) Q 1_U_"Clinic not on file: "_$G(BSDR("CLN"))
 I $G(BSDR("ADT")) S BSDR("ADT")=+$E(BSDR("ADT"),1,12)  ;remove seconds
 I $G(BSDR("ADT"))'?7N1".".4N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))
 I '$D(^VA(200,+$G(BSDR("USR")),0)) Q 1_U_"User Who Canceled Appt Error: "_$G(BSDR("USR"))
 ;
 S SDECERR=$$APPVISTA^SDEC07B(BSDR("LEN"),BSDR("NOTE"),BSDR("PAT"),BSDR("RES"),BSDR("ADT"),BSDR("WKIN"),BSDR("CLN"),.SDECI)  ;alb/sat 665 APPVISTA moved to SDEC07B
 Q SDECERR
 ;
ERR(SDECI,SDECERR,SDECPATID,LOCK) ;Error processing   BI/SD*5.3*740 added two parameters
 S SDECI=SDECI+1
 S SDECERR=$TR(SDECERR,"^","~")
 ;TROLLBACK
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 I $G(LOCK)=1  L -^SDEC(409.84,SDECPATID)   ;BI/SD*5.3*740
 Q
 ;
ETRAP ;EP Error trap entry
 D ^%ZTER
 I '$D(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(SDECI,"SDEC08 Error")
 Q
