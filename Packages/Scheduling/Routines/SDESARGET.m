SDESARGET ;ALB/BLB,MGD,KML,LAB - VISTA SCHEDULING RPCS ;March 23, 2022
 ;;5.3;Scheduling;**794,799,805,809,813**;Aug 13, 1993;Build 6
 ;;Per VHA Directive 6402, this routine should not be modified
 ; Reference to ^DPT(DFN,0) in ICR #10035
 ;
 Q
 ;
 ; Get SDEC APPOINTMENT REQUEST for all entries in the user's Institution
 ; where the Current Status is not C(losed).
 ;
 ; This RPC differs from SDEC ARGET in that only appointment specific data is returned.
 ;
 ; The ARGETPAT and ARGETPATJSON entry points must be kept in sync when passing in
 ; new parameters
 ;
 ; VSE-2500 - dates and date/times that get returned will be in ISO8601 format (e.g., CCYY-MM-DD, CCYY-MM-DDTHH:MM-timezone offset)
 ; since the data is retrieved from file 409.85, any date/times that are returned will be system time
 ;
ARGETPATJSON(RET,DFN,SDEAS) ;Entry point to return JSON
 ;  SDEC GET PATIENT APPT REQ JSON
 ;      ARGETPATJSON^SDEC1
 N FILT,APPT,ERR,JSONFLG,JSONERR,COPUNT
 S JSONFLG=1,JSONERR=""
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I +SDEAS=-1 D ERRLOG^SDESJSON(.APPT,142),BUILDJSON Q
 D JSONEP
 I '$D(APPT("Error")),'$D(APPT("ApptReq")) S APPT("ApptReq")=""  ;No appt req for this patient
 D BUILDJSON
 Q
 ;
ARGETIENJSON(RET,ARIEN,SDEAS) ;Appt Req GET for speific appt IEN
 ;  SDEC GET PAT APPT REQ BY IEN
 ;      ARGETIEN^SDEC1
 N FILT,APPT,COUNT,FNUM,DFN,ARDATA,JSONFLG,JSONERR
 S JSONFLG=1,JSONERR=""
 D INIT
 S ARIEN=$G(ARIEN)
 I ARIEN="" D ERRLOG^SDESJSON(.APPT,3)
 S SDEAS=$G(SDEAS,"")
 I $L(SDEAS) S SDEAS=$$EASVALIDATE^SDESUTIL(SDEAS)
 I +SDEAS=-1 D ERRLOG^SDESJSON(.APPT,142),BUILDJSON Q
 S FNUM=$$FNUM^SDECAR
 I ARIEN'="",('$D(^SDEC(409.85,ARIEN))) S ARIEN="" D ERRLOG^SDESJSON(.APPT,4)
 I ARIEN D GETS^DIQ(FNUM,ARIEN,"**","IE","ARDATA","ARMSG")  ;Get data for all field for this appt req
 I $D(ARDATA)>1 D BUILDREC(.ARDATA)
 D BUILDJSON
 Q
 ;
JSONEP ;
 D INIT
 I $$VALIDATE()=0 D:'$G(JSONFLG) EXIT Q
 D PROCESS
 Q
 ;
INIT ; Initalize any process specific variables
 S COUNT=0
 S FILT("SKIP STAT","C")=""  ;Exclude closed requests
 S FILT("INDEX")="DFN^"_$G(DFN)
 Q
 ;
VALIDATE() ;Validata input params
 N VALID,DFN,COUNT
 S VALID=1  ;Assume all is good
 ;
 S DFN=$P(FILT("INDEX"),"^",2)
 I +DFN<1 S VALID=0 D ERRLOG^SDESJSON(.APPT,1)
 I +DFN>0,'$D(^DPT(DFN,0)) S VALID=0 D ERRLOG^SDESJSON(.APPT,2) ;This is a valid DFN
 I 'VALID,'$G(JSONFLG) D ERR1^SDECERR(-1,"Invalid Patient ID.",.COUNT,.RET)
 ;
 Q VALID
 ;
PROCESS ; Loop over primary index
 N ARIEN,FNUM,COUNT
 S FNUM=$$FNUM^SDECAR,COUNT=0
 ;
 S ARIEN=0
 F  S ARIEN=$O(^SDEC(409.85,"B",+DFN,ARIEN)) Q:ARIEN'>0  D ONEPAT
 Q
 ;
ONEPAT ; Process one patient
 N ARDATA,ARMSG
 I $$VALIDIEN()=0 Q  ;Is this appt request one that we are looking for
 D GETS^DIQ(FNUM,ARIEN,"**","IE","ARDATA","ARMSG")  ;Get data for all field for this appt req
 D:$D(ARDATA)>1 BUILDREC(.ARDATA)
 Q
 ;
VALIDIEN() ;Validate the appointment request
 N VALID,ARSTAT
 S VALID=1  ;Assume this is a good record
 ; Is status for this request on the skip list
 I $D(FILT("SKIP STAT")) D
 .S ARSTAT=$$GET1^DIQ(409.85,ARIEN_",",23,"I")
 .I ARSTAT'="",$D(FILT("SKIP STAT",ARSTAT)) S VALID=0
 I VALID,$$GET1^DIQ(409.85,ARIEN_",",.01,"I")="" S VALID=0  ;Missing DFN
 Q VALID
 ;
BUILDREC(ARDATA) ; Build an output record
 ; Input - ARDATA = array containing data from SDEC APPT REQUEST file (#409.85)
 N DFN,SDPS,SDCLY,ARORIGDT,SDI,STR,SDCL,CALLLETTER,I,X,VAR,SUBCNT,SDECLET,SDECALL
 N ARINST,ARINSTNM,ARTYPE,VAOSGUID,ARSTOP,ARSTOPN,ARCLIEN,ARCLNAME,APPTYPE,ARUSER,ARUSRNM
 N AREDT,ARPRIO,ARENPRI,ARREQBY,ARPROV,ARPROVNM,ARCLERK,ARCLERKN,ARSDOA
 N ARCLERK,ARCLERKN,ARDAM,ARSVCCON,ARDAPTDT,ARCOMM,ARMAR,ARMAI,ARMAN,ARPC,ARDISPD,ARDISPU,ARDISPUN
 N APPTPTRS,CHILDREN,ARMRTC,SDPARENT,SDMRTC,AREAS
 N I,L,ZZ
 S ARORIGDT=$$FMTISO^SDAMUTDT(ARDATA(FNUM,ARIEN_",",1,"I")) ;vse-2500  CREATE DATE
 S ARSTAT=ARDATA(FNUM,ARIEN_",",23,"I")
 S DFN=ARDATA(FNUM,ARIEN_",",.01,"I")
 S SDPS=ARDATA(FNUM,ARIEN_",",.02,"E")
 S SDCL=ARDATA(FNUM,ARIEN_",",8,"I")
 S ARINST=ARDATA(FNUM,ARIEN_",",2,"I")
 S ARINSTNM=ARDATA(FNUM,ARIEN_",",2,"E")
 S ARTYPE=ARDATA(FNUM,ARIEN_",",4,"I")
 S ARCLIEN=ARDATA(FNUM,ARIEN_",",8,"I")
 S ARSTOP=ARDATA(FNUM,ARIEN_",",8.5,"I")
 S ARSTOPN=ARDATA(FNUM,ARIEN_",",8.5,"E")
 S ARCLNAME=ARDATA(FNUM,ARIEN_",",8,"E")
 S APPTYPE=ARDATA(FNUM,ARIEN_",",8.7,"I")
 S ARUSER=ARDATA(FNUM,ARIEN_",",9,"I")
 S ARUSRNM=ARDATA(FNUM,ARIEN_",",9,"E")
 S AREDT=$G(ARDATA(FNUM,ARIEN_",",9.5,"I"))  ;DATE/TIME ENTERED
 S ARPRIO=ARDATA(FNUM,ARIEN_",",10,"I")
 S ARENPRI=ARDATA(FNUM,ARIEN_",",10.5,"E")
 S ARREQBY=ARDATA(FNUM,ARIEN_",",11,"I")
 S ARPROV=ARDATA(FNUM,ARIEN_",",12,"I")
 S ARPROVNM=ARDATA(FNUM,ARIEN_",",12,"E")
 S ARSDOA=$$FMTISO^SDAMUTDT(ARDATA(FNUM,ARIEN_",",13,"I"))      ;vse-2500 SCHEDULED DATE OF APPT
 S ARDAM=$$FMTISO^SDAMUTDT(ARDATA(FNUM,ARIEN_",",13.1,"I"))    ;vse-2500  DATE APPT. MADE
 S ARCLERK=ARDATA(FNUM,ARIEN_",",13.7,"I")   ;appt clerk ien
 S ARCLERKN=ARDATA(FNUM,ARIEN_",",13.7,"E")   ;appt clerk name
 S ARSVCCON=ARDATA(FNUM,ARIEN_",",15,"E")
 S ARDAPTDT=$$FMTISO^SDAMUTDT(ARDATA(FNUM,ARIEN_",",22,"I")) ;vse-2500  CID/PREFERRED DATE OF APPT
 ;VSE-1218; start process mult lines of comments
 S ARCOMM=ARDATA(FNUM,ARIEN_",",25,"I")
 S ARMAR=ARDATA(409.85,ARIEN_",",41,"E")
 S ARMAI=ARDATA(409.85,ARIEN_",",42,"E")
 S ARMAN=ARDATA(409.85,ARIEN_",",43,"E")
 S ARPC=$$WLPC(.ARDATA,ARIEN)
 S ARDISPD=$$FMTISO^SDAMUTDT(ARDATA(FNUM,ARIEN_",",19,"I"))  ;vse-2500 DATE DISPOSITIONED
 S ARDISPU=ARDATA(FNUM,ARIEN_",",20,"I")
 S ARDISPUN=ARDATA(FNUM,ARIEN_",",20,"E")
 S AREAS=ARDATA(FNUM,ARIEN_",",100,"E")   ; EAS tracking number added with patch SD*5.3*799
 S APPTPTRS=$$GETAPPTS^SDECAR1A(ARIEN)
 S CHILDREN=$$CHILDREN^SDECAR1A(ARIEN)
 S ARMRTC=$$MRTC^SDECAR(ARIEN)
 S SDPARENT=ARDATA(FNUM,ARIEN_",",43.8,"I")
 ;Build string of RTC dates
 S (SDI,SDMRTC)=""
 F  S SDI=$O(ARDATA(409.851,SDI)) Q:SDI=""  D
 .S SDMRTC=$S(SDMRTC'="":SDMRTC_"|",1:"")_$$FMTISO^SDAMUTDT(ARDATA(409.851,SDI,.01,"I")) ;vse-2500 MRTC CALC PREF DATES
 ;# OF CALLS MADE AND DATE LAST LETTER SENT
 S CALLLETTER=$$CALLET^SDECAR1A(DFN,ARIEN)
 ;
 S COUNT=$G(COUNT)+1
 ;
 S APPT("ApptReq",COUNT,"PatientIEN")=DFN
 S APPT("ApptReq",COUNT,"ApptReqIEN")=ARIEN
 S APPT("ApptReq",COUNT,"CreateDateE")=ARORIGDT
 S APPT("ApptReq",COUNT,"InstitutionI")=ARINST
 S APPT("ApptReq",COUNT,"InstitutionE")=ARINSTNM
 S APPT("ApptReq",COUNT,"RequestTypeI")=ARTYPE
 S APPT("ApptReq",COUNT,"ReqSpecificClinicI")=ARCLIEN
 S APPT("ApptReq",COUNT,"ReqSpecificClinicE")=ARCLNAME
 S APPT("ApptReq",COUNT,"OriginatingUserI")=ARUSER
 S APPT("ApptReq",COUNT,"OriginatingUserE")=ARUSRNM
 S APPT("ApptReq",COUNT,"PriorityI")=ARPRIO
 S APPT("ApptReq",COUNT,"RequestedByI")=ARREQBY
 S APPT("ApptReq",COUNT,"ProviderI")=ARPROV
 S APPT("ApptReq",COUNT,"ProviderE")=ARPROVNM
 S APPT("ApptReq",COUNT,"CidPreferredDateOfApptE")=ARDAPTDT
 S APPT("ApptReq",COUNT,"CommentsE")=ARCOMM
 S APPT("ApptReq",COUNT,"EnrollmentPriorityE")=ARENPRI
 S APPT("ApptReq",COUNT,"MultipleAppointmentRtcE")=ARMAR
 S APPT("ApptReq",COUNT,"MultApptRtcIntervalE")=ARMAI
 S APPT("ApptReq",COUNT,"MultApptNumberE")=ARMAN
 S APPT("ApptReq",COUNT,"EASTrackingNumberE")=AREAS
 S SUBCNT=0
 F I=1:1:$L(ARPC,"::") D
 .S VAR=$P(ARPC,"::",I)
 .Q:VAR=""
 .S SUBCNT=SUBCNT+1
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"DateEnteredE")=$P(VAR,"~~",1)
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"EnteredByUserI")=$P(VAR,"~~",2)
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"EnteredByUserE")=$P(VAR,"~~",3)
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"ActionE")=$P(VAR,"~~",4)
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"PatientPhoneE")=$P(VAR,"~~",5)
 .Q
 I '$D(APPT("ApptReq",COUNT,"PatientContact")) S APPT("ApptReq",COUNT,"PatientContact")=""
 ;
 S APPT("ApptReq",COUNT,"DateDispositionedE")=ARDISPD
 S APPT("ApptReq",COUNT,"DispositionedByI")=ARDISPU
 S APPT("ApptReq",COUNT,"DispositionedByE")=ARDISPUN
 S APPT("ApptReq",COUNT,"ServiceConnectedPriorityE")=ARSVCCON
 S APPT("ApptReq",COUNT,"DateTimeEnteredE")=$$FMTISO^SDAMUTDT(AREDT)  ;vse-2500
 S SUBCNT=0
 F I=1:1:$L(SDMRTC,"|") D
 .S:$P(SDMRTC,"|",I)'="" APPT("ApptReq",COUNT,"MRTCCalcPrefDates",$I(SUBCNT),"Date")=$P(SDMRTC,"|",I)
 I '$D(APPT("ApptReq",COUNT,"MRTCCalcPrefDates")) S APPT("ApptReq",COUNT,"MRTCCalcPrefDates")=""
 ;
 S APPT("ApptReq",COUNT,"ReqServiceSpecialtyI")=ARSTOP
 S APPT("ApptReq",COUNT,"ReqServiceSpecialtyE")=ARSTOPN
 S APPT("ApptReq",COUNT,"ScheduledDateOfApptE")=ARSDOA
 S APPT("ApptReq",COUNT,"ApptClerkI")=ARCLERK
 S APPT("ApptReq",COUNT,"ApptClerkE")=ARCLERKN
 S APPT("ApptReq",COUNT,"DateApptMadeE")=ARDAM
 S APPT("ApptReq",COUNT,"CountOfRTCs")=ARMRTC  ;Count of nodes in 43.3 sub file
 S APPT("ApptReq",COUNT,"ReqAppointmentTypeI")=APPTYPE
 S APPT("ApptReq",COUNT,"PatientStatusE")=SDPS
 S SUBCNT=0
 F I=1:1:$L(APPTPTRS,"|") D
 .S VAR=$P(APPTPTRS,"|",I)
 .S:VAR'="" APPT("ApptReq",COUNT,"MultiAppointmentsI",$I(SUBCNT),"IEN")=VAR
 I '$D(APPT("ApptReq",COUNT,"MultiAppointmentsI")) S APPT("ApptReq",COUNT,"MultiAppointmentsI")=""
 ;
 S SUBCNT=0
 F I=1:1:$L(CHILDREN,"|") D
 .S VAR=$P(CHILDREN,"|",I)
 .S:VAR'="" APPT("ApptReq",COUNT,"MultiApptRequestsChildI",$I(SUBCNT),"ARIEN")=VAR
 I '$D(APPT("ApptReq",COUNT,"MultiApptRequestsChildI")) S APPT("ApptReq",COUNT,"MultiApptRequestsChildI")=""
 ;
 S APPT("ApptReq",COUNT,"ParentRequestI")=SDPARENT
 S APPT("ApptReq",COUNT,"NumberOfCalls")=$P(CALLLETTER,"^",1)
 S APPT("ApptReq",COUNT,"DateOfLastLetterSent")=$P(CALLLETTER,"^",2)
 S APPT("ApptReq",COUNT,"NumberOfEmailContact")=$P(CALLLETTER,"^",3)
 S APPT("ApptReq",COUNT,"NumberOfTextContact")=$P(CALLLETTER,"^",4)
 S APPT("ApptReq",COUNT,"NumberOfSecureMessage")=$P(CALLLETTER,"^",5)
 Q
 ;
BUILDJSON ;Convert to JSON
 S RET=$G(RET,"RET")
 D ENCODE^SDESJSON(.APPT,.RET,.JSONERR)
 K ^TMP("SDECAR4",$J)
 Q
 ;
WLPC(ARDATA,ASDIEN) ;
 N PC,PC1,PCIEN
 S PC=""
 S PCIEN="" F  S PCIEN=$O(ARDATA(409.8544,PCIEN)) Q:PCIEN=""  D
 .Q:$P(PCIEN,",",2)'=ASDIEN
 .S PC1=""
 .S $P(PC1,"~~",1)=$$FMTISO^SDAMUTDT(ARDATA(409.8544,PCIEN,.01,"I"))    ;vse-2500 DATE ENTERED
 .S $P(PC1,"~~",2)=ARDATA(409.8544,PCIEN,2,"I")      ;PC ENTERED BY USER IEN
 .S $P(PC1,"~~",3)=ARDATA(409.8544,PCIEN,2,"E")      ;PC ENTERED BY USER NAME
 .S $P(PC1,"~~",4)=ARDATA(409.8544,PCIEN,3,"E")      ;ACTION
 .S $P(PC1,"~~",5)=ARDATA(409.8544,PCIEN,4,"E")      ;PATIENT PHONE
 .S PC=$S(PC'="":PC_"::",1:"")_PC1
 Q PC
 ;
EXIT ; Any special logic needed for a successful completion
 N SDTMP,COUNT
 S COUNT=$O(^TMP("SDECAR4",$J,""),-1)
 I COUNT="" S ^TMP("SDECAR4",$J,1)=0,COUNT=1  ;No records to return
 S SDTMP=^TMP("SDECAR4",$J,COUNT)
 S SDTMP=$P(SDTMP,$C(30),1)
 S ^TMP("SDECAR4",$J,COUNT)=SDTMP_$C(30,31)
 Q
