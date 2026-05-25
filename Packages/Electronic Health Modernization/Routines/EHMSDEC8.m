EHMSDEC8   ;ALB/SAT/JSM,WTC,LAB,LEG,RRM,MGD - DELETE APPTS ; Jun 05, 2025@14:53:21
 ;;1.0;ELECTRONIC HEALTH MODERNIZATION;**13**;Apr 19, 2021;Build 27
 ;
 ;  Cloned from SDEC08 then modified.
 ;
 Q  ;
 ;
APPDEL(SDECAPTID,SDECTYP,SDECCR) ;Cancels appointment
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file #409.84
 ;SDECTYP   - (required) appointment Status valid values:
 ;                       C=CANCELLED BY CLINIC
 ;                       PC=CANCELLED BY PATIENT
 ;                       CNV=Converted to Cerner
 ;SDECCR    - (required) pointer to CANCELLATION REASON File (409.2)
 ;
 ;Returns 1 if successful or 0^error reason 
 ;
 N SDECNOD,SDECPATID,SDECSTART,DIK,DA,SDECID,SDECZ,SDECERR
 N SDECLOC,SDECLEN,SDECSCIEN,SDECSCIEN1,SDECNOEV,SDECSC1,SDRET
 N %DT,X,Y,SDECJ,SDECNOT ; wtc 756 6/8/2020 added SDECJ
 S SDECSCIEN1=0
 ;
 ;validate SDEC APPOINTMENT pointer (required)
 I '$D(^SDEC(409.84,+$G(SDECAPTID),0)) Q "0^Invalid file pointer" ;D ADERR(SDECI,.SDECY,"SDEC08: Invalid Appointment ID",+$G(SDECAPTID),0) Q  ;BI/SD*5.3*740 added ADERR
 ;validate appointment status type (required)
 S SDECTYP=$G(SDECTYP) I SDECTYP'="CNV",SDECTYP'="C" Q "0^Invalid appointment status ("_SDECTYP_")" ;
 ;validate CANCELLATION REASON pointer (optional)
 S SDECCR=$G(SDECCR) I SDECCR="" Q "0^Cancellation Reason missing" ;
 I '$D(^SD(409.2,+SDECCR,0)) S SDECCR=$O(^SD(409.2,"B",SDECCR,0)) ;832
 ;
 S SDECDATE=$$NOW^XLFDT
 S SDUSER=DUZ
 ;Delete APPOINTMENT entries
 S SDECNOD=^SDEC(409.84,SDECAPTID,0)
 S SDECPATID=$P(SDECNOD,U,5)
 S SDECSTART=$P(SDECNOD,U)
 ;
 ;cancel check-in if walk-in
 I $P(SDECNOD,U,13)="y" D
 .S SDRET=""
 .D CHECKIN^SDEC25(.SDRET,SDECAPTID,"@")
 ;cancel SDEC APPOINTMENT record
 N SDF S SDF=1 ; WTC 8.29.23
 D SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECDATE,SDUSER) ;
 ;
 S SDECSC1=$P(SDECNOD,U,7) ;RESOURCEID
 I SDECSC1]"",$D(^SDEC(409.831,SDECSC1,0)) D  I +$G(SDECZ) Q "0^Resource error" ;
 . S SDECNOD=$G(^SDEC(409.831,SDECSC1,0)) ; WTC 6/18/24 BAD DATA
 . S SDECLOC=$P(SDECNOD,U,4) ;HOSPITAL LOCATION
 . Q:'+SDECLOC
 . S SDECSCIEN=$$SCIEN^SDECU2(SDECPATID,SDECLOC,SDECSTART) I SDECSCIEN="" D  I 'SDECZ Q  ;
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
 . ;
 . S SDECNOT="" ; WTC 8.28.23
 . D APCAN^EHMSDC8A(.SDECZ,SDECLOC,SDECPATID,SDECSTART,SDECAPTID,SDECLEN)
 . Q:+$G(SDECZ)
 . D AVUPDT^EHMSDC8A(SDECLOC,SDECSTART,SDECLEN)  ;
 . D AR433D^SDECAR2(SDECAPTID)
 Q 1 ;
 ;
SDECCAN(SDECAPTID,SDECTYP,SDECCR,SDECDATE,SDUSER) ;cancel SDEC APPOINTMENT entry
 ;SDECAPTID - (required) pointer to SDEC APPOINTMENT file
 ;SDECTYP   - (required) appointment Status valid values:
 ;                          C=CANCELLED BY CLINIC
 ;                         PC=CANCELLED BY PATIENT
 ;SDECCR    - (required) pointer to CANCELLATION REASON File (409.2)
 ;
 ;Cancel SDEC APPOINTMENT entry
 N DFN,PROVIEN,Y
 N SAVESTRT,SDAPTYP,SDCL,SDI,SDIEN,SDECIENS,SDECFDA,SDECMSG,SDECWP,SDRES,SDT   ;alb/sat 651 add SAVESTRT and SDRES
 N DFN40985,IEN40986,PIDCHANGEVERIF,CSFDA,CSSIEN,ERR,CONSIEN,PIDHIEN ;**792
 S DFN=$$GET1^DIQ(409.84,SDECAPTID_",",.05,"I")   ;alb/sat 658;781 lab added, "I"
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
 D UPDATE^DIE("","SDECFDA") ; restrict note in #2 to 160 characters - wtc 756
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
 .; If Canc Don't Re-Open and no existing Disp Code
 .I ($$GET1^DIQ(409.2,SDECCR,5,"I")=0),($$GET1^DIQ(409.85,SDIEN,21,"I")="") D
 ..S SDECFDA(409.85,SDIEN_",",19)=$P($$GET1^DIQ(409.84,SDECAPTID,.12,"I"),".",1)
 ..S SDECFDA(409.85,SDIEN_",",20)=$$GET1^DIQ(409.84,SDECAPTID,.121,"I")
 ..S SDECFDA(409.85,SDIEN_",",21)=$O(^SDEC(409.853,"B","CANCELLED NOT RE-OPENED",""))
 ..S SDECFDA(409.85,SDIEN_",",23)="C" ;  Mark request closed.  wtc 8.29.23
 .D UPDATE^DIE("","SDECFDA","ARRET","ERRMSG")
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
 I ($G(BSDR("TYP"))'="C"),($G(BSDR("TYP"))'="PC"),($G(BSDR("TYP"))'="CNV") Q 1_U_"Cancel Status error: "_$G(BSDR("TYP")) ; WTC 8.29.23
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
 ; DISABLED WTC 2/28/24 ;S SDCPHDL=$$HANDLE^SDAMEVT(1),SDATA=SDDA_U_DFN_U_SDT_U_SDCL
 ; DISABLED WTC 2/28/24 ;D BEFORE^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDCPHDL)
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
 ; DISABLED WTC 2/28/24 ;I SDPCE D CANCEL^SDAMEVT(.SDATA,DFN,SDT,SDCL,SDDA,SDMODE,SDCPHDL)  ; WTC 2/14/24 Do not call protocol if encounter is not present.
 Q 0
 ;
ERR(SDECI,SDECERR,SDECAPTID,LOCK) ;Error processing   BI/SD*5.3*740 added two parameters   ;changed SDECPATID to SDECAPTID - pwc *745
 ;S SDECI=SDECI+1
 S SDECERR=$TR(SDECERR,"^","~")
 ;S ^TMP("SDEC",$J,SDECI)=SDECERR_$C(30)
 ;S SDECI=SDECI+1
 ;S ^TMP("SDEC",$J,SDECI)=$C(31)
 I $G(LOCK)=1  L -^SDEC(409.84,SDECAPTID)   ;BI/SD*5.3*740  ;changed SDECPATID to SDECAPTID - pwc *745
 Q
 ;
ETRAP    ;EP Error trap entry
 D ^%ZTER
 ;I '$D(SDECI) N SDECI S SDECI=999999
 ;S SDECI=SDECI+1
 ;D ERR(SDECI,"SDEC08 Error")
 Q
 ;
