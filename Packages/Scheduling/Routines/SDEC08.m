SDEC08   ;ALB/SAT/JSM,WTC,LAB,LEG,RRM,MGD - DELETE APPTS ;Mar 13, 2023
 ;;5.3;Scheduling;**627,651,658,665,722,740,744,694,745,756,774,781,785,790,792,796,797,799,801,805,819,842,832**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; Reference to ^DPT (Patient File) is supported by IA #7030
 Q
 ;
APPDEL(SDECY,SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER,SOURCE,SDF,SDECCMT,NEWPID,EASTRCKNGNMBR) ;Cancels appointment
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file #409.84
 ;SDECTYP   - (required) appointment Status valid values:
 ;                       C=CANCELLED BY CLINIC
 ;                       PC=CANCELLED BY PATIENT
 ;SDECCR    - (required) pointer to CANCELLATION REASON File (409.2)
 ;SDECNOT   - (optional) text representing user note
 ;SDECDATE  - (optional) Cancel Date/Time in external format; defaults to NOW
 ;SDUSER    - (optional) User that cancelled appt; defaults to current user
 ;SOURCE    - future enhancement L 1.8 SD*5.3*715
 ;SDF       - (optional) Flag to determine whether to reopen appointment SD*5.3*745
 ;SDECCMT   - (optional) List of cancellation comment hash tags (see #409.88) separated by ^ - 756 6/8/2020 wtc
 ;NEWPID    - (optional) Only allowed when cancelling a recall request appointment by patient
 ;EASTRCKINGNMBR - (optional) Enterprise Appointment Scheduling Tracking Number associated to an appointment.
 ;Returns error code in record set field ERRORID
 ;
 N SDECNOD,SDECPATID,SDECSTART,DIK,DA,SDECID,SDECI,SDECZ,SDECERR
 N SDECLOC,SDECLEN,SDECSCIEN,SDECSCIEN1,SDECNOEV,SDECSC1,SDRET
 N %DT,X,Y,SDECJ ; wtc 756 6/8/2020 added SDECJ
 I $G(NEWPID)'="" D
 .S NEWPID=$$NETTOFM^SDECDATE(NEWPID,"N","N")
 S SDF=$S($G(SDF)=3:3,$G(SDF)=2:2,1:1) ; lab 745 default all flags to 1 except a flag of 2.
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
 I SDECCR'="" I '$D(^SD(409.2,+SDECCR,0)) S SDECCR=$O(^SD(409.2,"B",SDECCR,0)) ;832
 ;validate SDECNOT
 S SDECNOT=$TR($G(SDECNOT),"^"," ")  ;alb/sat 658 - strip out ^
 ;
 ;  Add cancellation comment HASHTAGs from #409.88 to beginning of user note. - 756 wtc 6/8/2020
 ;
 I $G(SDECCMT)'="" F SDECJ=$L(SDECCMT,U):-1:1 S SDECNOT=$P(SDECCMT,U,SDECJ)_"_"_SDECNOT ;  Add hashtags in reverse order of receipt so national appear first.  wtc 8/19/2020
 I $E(SDECNOT,$L(SDECNOT))="_" S SDECNOT=$E(SDECNOT,1,$L(SDECNOT)-1) ;  Strip off trailing "_".  Happens if not extra note text.
 ;
 ;validate cancel date/time
 S SDECDATE=$G(SDECDATE)
 ;
 ;  Change date/time conversion so midnight is handled properly.  wtc 694 4/24/18
 ;
 ;I SDECDATE'="" S %DT="T" S X=SDECDATE D ^%DT S SDECDATE=Y I Y=-1 S SDECDATE=""
 I SDECDATE'="" S SDECDATE=$$NETTOFM^SDECDATE(SDECDATE,"Y","N") I SDECDATE=-1 S SDECDATE="" ;  wtc 6/18/18
 I $G(SDECDATE)="" S SDECDATE=$$NOW^XLFDT
 ;validate user
 S SDUSER=$G(SDUSER)
 I SDUSER'="" I '$D(^VA(200,+SDUSER,0)) S SDUSER=""
 I SDUSER="" S SDUSER=DUZ
 ;Delete APPOINTMENT entries
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S SDECPATID=$P(SDECNOD,U,5)
 S SDECSTART=$P(SDECNOD,U)
 ;
 ;Lock SDEC node
 ;changed SDECPATID to SDECAPTID to get APPOINTMENT ID instead of PATIENT ID  ; pwc *745  7/16/2020
 L +^SDEC(409.84,SDECAPTID):5 I '$T D ADERR(SDECI+1,.SDECY,"Another user is working with this patient's record.  Please try again later",+SDECAPTID,0) Q  ;BI/SD *5.3*740
 ;cancel check-in if walk-in
 I $P(SDECNOD,U,13)="y" D
 .S SDRET=""
 .D CHECKIN^SDEC25(.SDRET,SDECAPTID,"@")
 ;validate EAS Tracking Number
 S EASTRCKNGNMBR=$TR($G(EASTRCKNGNMBR),"^"," ")
 I $L(EASTRCKNGNMBR) S EASTRCKNGNMBR=$$EASVALIDATE^SDESUTIL(EASTRCKNGNMBR)
 I EASTRCKNGNMBR=-1 D ADERR(SDECI,.SDECY,"SDEC08: Invalid EAS Tracking Number",+$G(SDECAPTID),0) Q
 ;cancel SDEC APPOINTMENT record
 D SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER,SDF,$G(NEWPID),EASTRCKNGNMBR) ;*745
 ;
 S SDECSC1=$P(SDECNOD,U,7) ;RESOURCEID
 I SDECSC1]"",$D(^SDEC(409.831,SDECSC1,0)) D  I +$G(SDECZ) S SDECERR=+SDECZ D ADERR(SDECI,.SDECY,$P(SDECZ,U,2),+SDECAPTID,1) Q   ;BI/SD*5.3*740 added ADERR ;changed SDECPATID to SDECAPTID - pwc *745
 . S SDECNOD=^SDEC(409.831,SDECSC1,0)
 . S SDECLOC=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 . Q:'+SDECLOC
 . S SDECSCIEN=$$SCIEN^SDECU2(SDECPATID,SDECLOC,SDECSTART) I SDECSCIEN="" D  I 'SDECZ Q  ;Q:SDECZ
 .. S SDECERR="SDEC08: Unable to find associated appointment for this patient. "
 .. S SDECZ=1 I '$D(^SDEC(409.831,SDECSC1,20)) S SDECZ=0 Q
 .. N SDEC1 S SDEC1=0
 .. F  S SDEC1=$O(^SDEC(409.831,SDECSC1,20,SDEC1)) Q:'+SDEC1  Q:SDECZ=0  D
 ... Q:'$D(^SDEC(409.831,SDECSC1,20,SDEC1,0))
 ... S SDECLOC=$P(^SDEC(409.831,SDECSC1,20,SDEC1,0),U)
 ... S SDECSCIEN=$$SCIEN^SDECU2(SDECPATID,SDECLOC,SDECSTART) I +SDECSCIEN S SDECZ=0 Q
 . S SDECERR="SDEC08: CANCEL^SDEC08 Returned "
 . I SDECLOC']"" S SDECZ="0^Unable to find associated appointment for this patient." Q
 . I '$D(^SC(SDECLOC,0)) S SDECZ="0^Unable to find associated appointment for this patient." Q
 . S SDECNOD=$G(^SC(SDECLOC,"S",SDECSTART,1,+SDECSCIEN,0))
 . I SDECNOD="" S SDECZ="0^Unable to find associated appointment for this patient." Q
 . S SDECLEN=$P(SDECNOD,U,2)
 . D APCAN^SDEC08A(.SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECAPTID,SDECLEN)
 . Q:+$G(SDECZ)
 . D AVUPDT^SDEC08A(SDECLOC,SDECSTART,SDECLEN)  ;moved to SDEC08A routine is too big *745
 . D AR433D^SDECAR2(SDECAPTID)
 L -^SDEC(409.84,SDECAPTID)   ;changed SDECPATID to SDECAPTID  ; pwc *745
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=""_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 Q
 ;
ADERR(SDECI,SDECY,SDECERR,SDECAPTID,LOCK) ;Error processing   BI/SD*5.3*740  ;changed SDECPATID to SDECAPTID  ; pwc *745
 S SDECI=SDECI+1
 S SDECERR=$TR(SDECERR,"^","~")
 S @SDECY@(SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S @SDECY@(SDECI)=$C(31)
 I LOCK=1  L -^SDEC(409.84,SDECAPTID)   ; changed SDECPATID to SDECAPTID  ; pwc *745
 Q
 ;
SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECNOT,SDECDATE,SDUSER,SDF,NEWPID,EASTRCKNGNMBR) ;cancel SDEC APPOINTMENT entry
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file
 ;SDECTYP   - (required) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ;SDECCR    - (required) pointer to CANCELLATION REASON File (409.2)
 ;SDECNOT   - (optional) text representing user note
 ;SDECDATE  - (optional) Cancel Date/Time in fm format; defaults to NOW) ;
 ;SDF       - (optional) flags ;*745 expanded flag explanation
 ;                       "1" or null  - update consult only.  (assumption called from a GUI)
 ;                       "01" (two digit) -do not reopen appt (called from cancel in SDAM)
 ;                       "2" - close appt request disp code REMOVED/EXTERNAL APP
 ;                       "3" - Block & Move don't re-open a Appt Request if a Recall
 ;NEWPID    - (optional) Only allowed when cancelling a recall request appointment by patient
 ;EASTRCKINGNMBR - (optional) Enterprise Appointment Scheduling Tracking Number associated to an appointment.
 ;
 ;Cancel SDEC APPOINTMENT entry
 N DFN,PROVIEN,Y
 N SAVESTRT,SDAPTYP,SDCL,SDI,SDIEN,SDECIENS,SDECFDA,SDECMSG,SDECWP,SDRES,SDT   ;alb/sat 651 add SAVESTRT and SDRES
 N DFN40985,IEN40986,PIDCHANGEVERIF,CSFDA,CSSIEN,ERR,CONSIEN,PIDHIEN ;**792
 S SDF=$G(SDF,0)
 S NEWPID=$G(NEWPID)
 S DFN=$$GET1^DIQ(409.84,SDECAPTID_",",.05,"I")   ;alb/sat 658;781 lab added, "I"
 S SDT=$$GET1^DIQ(409.84,SDECAPTID_",",.01,"I")
 S SAVESTRT=$$GET1^DIQ(409.84,SDECAPTID_",",.01)   ;alb/sat 651
 S SDRES=$$GET1^DIQ(409.84,SDECAPTID_",",.07,"I")  ;alb/sat 651
 S SDECIENS=SDECAPTID_","
 S SDECFDA(409.84,SDECIENS,.12)=$S($G(SDECDATE)'="":SDECDATE,1:$$NOW^XLFDT)
 S SDECFDA(409.84,SDECIENS,.121)=$S($G(SDUSER)'="":SDUSER,1:DUZ)
 S:$G(SDECCR)'="" SDECFDA(409.84,SDECIENS,.122)=SDECCR
 S SDECFDA(409.84,SDECIENS,.17)=SDECTYP
 ;S SDECFDA(409.84,SDECIENS,2)="@" ;patch SD*5.3*796, delete VVS appointment ID if appointment is cancelled
 S:$G(EASTRCKNGNMBR)'="" SDECFDA(409.84,SDECIENS,100)=EASTRCKNGNMBR
 K SDECMSG
 D FILE^DIE("","SDECFDA","SDECMSG")
 S SDAPTYP=$$GET1^DIQ(409.84,SDECAPTID_",",.22,"I")
 I SDF=3,$P(SDAPTYP,";",2)'="SD(403.5," S SDF=0
 ;alb/sat 658 modification begin
 S SDECNOT=$G(SDECNOT) ;,SDECNOT=$E(SDECNOT,1,160) - removed 160 character restriction so entire note is stored in #409.84 - wtc 756
 I $L(SDECNOT)>2,'$E(SDF,2) K SDECFDA
 S SDECFDA(2.98,SDT_","_DFN_",",17)=$E(SDECNOT,1,160) D UPDATE^DIE("","SDECFDA") ; restrict note in #2 to 160 characters - wtc 756
 ; VSE-863; 6/6/2021 ; create new "APPT" Request if A "RECALL" Appt is Cancelled
 I $P(SDAPTYP,";",2)="SD(403.5," D  Q
 .Q:SDF=3
 .D RECREQ^SDECRECREQ(.SDECY,SDECAPTID,SDAPTYP,$G(NEWPID),$G(SDECTYP))
 ;alb/sat 658 modification end
 I $P(SDAPTYP,";",2)="GMR(123,",$E(SDF,1),(SDF'=2) D
 .S SDCL=$$SDCL^SDECUTL(SDECAPTID)
 .S PROVIEN=$$GET1^DIQ(44,SDCL_",",16,"I")
 .D REQSET^SDEC07A($P(SDAPTYP,";",1),PROVIEN,"",2,SDECTYP,SDECNOT,SAVESTRT,SDRES)  ;651 added SAVESTRT
 .; File consult PID history
 .I $G(NEWPID) D
 ..S CONSIEN=$P(SDAPTYP,";",1)
 ..S PIDHIEN=$O(^SDEC(409.87,"B",CONSIEN,0))
 ..S CSFDA(409.871,"+1,"_PIDHIEN_",",.01)=$$NOW^XLFDT
 ..S CSFDA(409.871,"+1,"_PIDHIEN_",",1)=$G(NEWPID)
 ..S CSFDA(409.871,"+1,"_PIDHIEN_",",2)=$$GET1^DIQ(200,SDUSER,.01,"E")
 ..D UPDATE^DIE("","CSFDA","CSSIEN","ERR") K CSFDA
 .Q
 I $P(SDAPTYP,";",2)="SDEC(409.85," D   ;update APPT
 .K SDECFDA,SDECMSG,SDECWP
 .D:'$E(SDF,2) AROPEN^SDECAR("",SDECAPTID)
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
 .S PIDCHANGEVERIF=$S(SDECTYP="C":0,SDECTYP="PC":1,1:"")
 .S SDECFDA(409.85,SDIEN_",",49)=PIDCHANGEVERIF
 .S:$G(EASTRCKNGNMBR)'="" SDECFDA(409.85,SDIEN_",",100)=EASTRCKNGNMBR
 .; If Canc Don't Re-Open and no existing Disp Code
 .I ($$GET1^DIQ(409.2,SDECCR,5,"I")=0),($$GET1^DIQ(409.85,SDIEN,21,"I")="") D
 ..S SDECFDA(409.85,SDIEN_",",19)=$P($$GET1^DIQ(409.84,SDECAPTID,.12,"I"),".",1)
 ..S SDECFDA(409.85,SDIEN_",",20)=$$GET1^DIQ(409.84,SDECAPTID,.121,"I")
 ..S SDECFDA(409.85,SDIEN_",",21)=$O(^SDEC(409.853,"B","CANCELLED NOT RE-OPENED",""))
 .D UPDATE^DIE("","SDECFDA","ARRET","ERRMSG")
 .I SDF=2 NEW INP S INP(1)=SDIEN S INP(2)="REMOVED/EXTERNAL APP" S INP(3)=SDUSER S INP(4)=DT D ARCLOSE^SDECAR("",.INP) ;*745
 Q
 ;
CANEVT(SDECPAT,SDECSTART,SDECSC) ;EP Called by SDEC CANCEL APPOINTMENT
 ;when Appt cancelled via PIMS interface.
 ;Propagates cancel to SDECAPPT & raises refresh event to running GUI clients
 N SDECFOUND,SDECRES
 Q:+$G(SDECNOEV)
 Q:'+$G(SDECSC)
 S SDECFOUND=0
 I $D(^SDEC(409.831,"ALOC",SDECSC)) S SDECRES=$O(^SDEC(409.831,"ALOC",SDECSC,0)) S SDECFOUND=$$CANEVT1(SDECRES,SDECSTART,SDECPAT)
 I SDECFOUND D CANEVT3(SDECRES) Q
 Q
 ;
CANEVT1(SDECRES,SDECSTART,SDECPAT) ;
 ;Get Appt ID in SDECAPT
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
 Q
 N SDECRESN
 S SDECRESN=$G(^SDEC(409.831,SDECRES,0))
 Q:SDECRESN=""
 S SDECRESN=$P(SDECRESN,"^")
 Q
 ;
CANCEL(BSDR) ;EP; called to cancel appt
 ; Make call using: S ERR=$$CANCEL^SDEC08(.ARRAY)
 ;
 ; Input Array -
 ; BSDR("PAT") = ien of patient file 2
 ; BSDR("CLN") = ien of clinic file 44
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
 I $G(BSDR("ADT"))'?7N1"."1N.N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))  ;PWC  allow any time combination of numbers #694
 I $G(BSDR("CDT"))'?7N1"."1N.N Q 1_U_"Appt Date/Time error: "_$G(BSDR("ADT"))  ;PWC  allow any time combination of numbers #694
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
 D UPDATE^DIE("","SDFDA") ; ICR #7030 wtc 756 6/15/2020
 N SDPCE
 S SDPCE=$P($G(^DPT(DFN,"S",SDT,0)),U,20) ; ICR #7030 wtc 756 6/15/2020
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
 N SDECDAM,SDECDEC,SDECI,SDECNOD,SDECPATID,SDECSTART,SDECNOTE,SDECWKIN
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
 ;
 ;  Get entire note from Appointment file.  756 wtc 1/25/2019
 ;
 ;S SDECNOTE=$G(^SDEC(409.84,SDECAPTID,1,1,0))  ;note from SDEC APPOINTMENT
 S SDECNOTE="" N I F I=1:1 Q:'$D(^SDEC(409.84,SDECAPTID,1,I,0))  S SDECNOTE=SDECNOTE_^(0)_$C(13) ;
 ;
 S SDECPATID=$P(SDECNOD,U,5)                ;pointer to VA PATIENT file 2
 S SDECSC1=$P($G(SDECNOD),U,7)              ;resource
 S SDECSTART=$P(SDECNOD,U)                  ;appt start time
 S SDECWKIN=$P($G(SDECNOD),U,13)            ;walk-in
 ;lock SDEC node
 ; changed line below to use SDECAPTID instead of SDECPATID  ; pwc *745  7/16/2020
 L +^SDEC(409.84,SDECAPTID):5 I '$T D ERR(SDECI+1,"Another user is working with this patient's record.  Please try again later",+SDECAPTID,0) Q   ;BI/SD*5.3*740
 ;un-cancel SDEC APPOINTMENT
 D SDECUCAN^SDEC08A(SDECAPTID)  ;moved to ^SDEC08A because of XINDEX size *756 PWC
 I SDECSC1]"",$D(^SDEC(409.831,SDECSC1,0)) D  I +$G(SDECZ) S SDECERR=SDECERR_$P(SDECZ,U,2) D ERR(SDECI,SDECERR,+SDECAPTID,1) Q   ;BI/SD*5.3*740  ;changed SDECPATID to SDECAPTID - pwc *745
 . S SDECLOC=""
 . S SDECNOD=^SDEC(409.831,SDECSC1,0)
 . S SDECLOC=$P(SDECNOD,U,4) ;HOSPITAL LOCATION   ;support for single HOSPITAL LOCATION in SDEC RESOURCE
 . I SDECLOC="" S SDECLOC=$$SDCL^SDECUTL(SDECAPTID)  ;HOSPITAL LOCATION
 . Q:'+SDECLOC
 . ;un-cancel patient appointment and re-instate clinic appointment
 . S SDECZ=""
 . D APUCAN^SDEC08A(.SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECDAM,SDECDEC,SDECLEN,SDECNOTE,SDECSC1,SDECWKIN)  ;moved to ^SDEC08A because of XINDEX size *756 PWC
 L -^SDEC(409.84,SDECAPTID)  ;changed SDECPATID to SDECAPTID - pwc *745
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=""_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 Q
 ;
ERR(SDECI,SDECERR,SDECAPTID,LOCK) ;Error processing   BI/SD*5.3*740 added two parameters   ;changed SDECPATID to SDECAPTID - pwc *745
 S SDECI=SDECI+1
 S SDECERR=$TR(SDECERR,"^","~")
 S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 S SDECI=SDECI+1
 S ^TMP("SDEC",$J,SDECI)=$C(31)
 I $G(LOCK)=1  L -^SDEC(409.84,SDECAPTID)   ;BI/SD*5.3*740  ;changed SDECPATID to SDECAPTID - pwc *745
 Q
 ;
ETRAP    ;EP Error trap entry
 D ^%ZTER
 I '$D(SDECI) N SDECI S SDECI=999999
 S SDECI=SDECI+1
 D ERR(SDECI,"SDEC08 Error")
 Q
