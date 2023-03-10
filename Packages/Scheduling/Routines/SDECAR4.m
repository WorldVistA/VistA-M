SDECAR4 ;ALB/TAW,LAB - VISTA SCHEDULING RPCS ;Oct 31, 2022@14:00
 ;;5.3;Scheduling;**784,785,788,805,813,826,833**;Aug 13, 1993;Build 9
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
ARGETPATJSON(RET,DFN) ;Entry point to return JSON
 ;  SDEC GET PATIENT APPT REQ JSON
 ;      ARGETPATJSON^SDEC1
 N FILT,APPT,ERR,JSONFLG,JSONERR,COPUNT
 S JSONFLG=1,JSONERR=""
 D JSONEP
 I '$D(APPT("Error")),'$D(APPT("ApptReq")) S APPT("ApptReq")=""  ;No appt req for this patient
 D BUILDJSON
 Q
 ;
ARGETIEN(RET,ARIEN) ;Appt Req GET for speific appt IEN
 ;  SDEC GET PAT APPT REQ BY IEN
 ;      ARGETIEN^SDEC1
 N FILT,APPT,COUNT,FNUM,DFN,ARDATA,JSONFLG,JSONERR
 S JSONFLG=1,JSONERR=""
 D INIT
 S ARIEN=$G(ARIEN)
 I ARIEN="" D ERRLOG^SDESJSON(.APPT,3)
 S FNUM=$$FNUM^SDECAR
 I ARIEN'="",('$D(^SDEC(409.85,ARIEN))) S ARIEN="" D ERRLOG^SDESJSON(.APPT,4)
 I ARIEN D GETS^DIQ(FNUM,ARIEN,"**","IE","ARDATA","ARMSG")  ;Get data for all field for this appt req
 I $D(ARDATA)>1 D BUILDREC
 D BUILDJSON
 Q
 ;
ARGETPAT(RET,DFN) ;Appt Req GET.
 ; SDEC PATIENT APP REQ GET
 ;   ARGETPAT^SDEC1
 ;
 ; RPC Description:
 ;   Get appointment request details.  This is similar to SDEC ARGET but it
 ;   only returns Appt request specific data.
 ;
 ; INPUT
 ;   DFN : [R] Patient ID pointer to PATIENT File (#2)
 ;
 ; OUTPUT
 ;   See RPC file
 N FILT,APPT,COUNT
 ;
JSONEP ;
 D INIT
 D:'$G(JSONFLG) HDR
 I $$VALIDATE()=0 D:'$G(JSONFLG) EXIT Q
 D PROCESS
 D:'$G(JSONFLG) EXIT
 Q
 ;
INIT ; Initalize any process specific variables
 S COUNT=0
 I '$G(JSONFLG) S RET="^TMP(""SDECAR4"","_$J_")" K ^TMP("SDECAR4",$J)
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
 D:$D(ARDATA)>1 BUILDREC
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
BUILDREC ; Build an output record
 N ARSTAT,DFN,SDPS,SDCLY,ARORIGDT,SDI,STR,SDCL,CALLLETTER,I,X,VAR,SUBCNT,SDECLET,SDECALL
 N ARINST,ARINSTNM,ARTYPE,VAOSGUID,ARSTOP,ARSTOPN,ARCLIEN,ARCLNAME,APPTYPE,ARUSER,ARUSRNM
 N AREDT,ARPRIO,ARENPRI,ARREQBY,ARPROV,ARPROVNM,ARSDOA,ARSDOA,ARDAM,ARCLERK,ARCLERKN,ARASD,ARSDOA
 N ARCLERK,ARCLERKN,ARDAM,ARSVCCON,ARDAPTDT,ARCOMM,ARMAR,ARMAI,ARMAN,ARPC,ARDISPD,ARDISPU,ARDISPUN
 N APPTPTRS,CHILDREN,ARMRTC,SDPARENT,SDMTRC,CANCHANGEPID,MRTCSEQUENCENUM
 S ARORIGDT=ARDATA(FNUM,ARIEN_",",1,"I")
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
 S AREDT=$G(ARDATA(FNUM,ARIEN_",",9.5,"E"))   ;53
 S ARPRIO=ARDATA(FNUM,ARIEN_",",10,"I")
 S ARENPRI=ARDATA(FNUM,ARIEN_",",10.5,"E")   ;msc/sat
 S ARREQBY=ARDATA(FNUM,ARIEN_",",11,"I")
 S ARPROV=ARDATA(FNUM,ARIEN_",",12,"I")
 S ARPROVNM=ARDATA(FNUM,ARIEN_",",12,"E")
 S ARSDOA=ARDATA(FNUM,ARIEN_",",13,"I")      ;scheduled date of appt
 ;  Change date/time conversion so midnight is handled properly.  wtc/pwc 694 1/7/2020
 ;
 S ARSDOA=$$FMTONET^SDECDATE(ARSDOA,"N") ;
 S ARDAM=ARDATA(FNUM,ARIEN_",",13.1,"E")     ;date appt. made
 S ARCLERK=ARDATA(FNUM,ARIEN_",",13.7,"I")   ;appt clerk ien
 S ARCLERKN=ARDATA(FNUM,ARIEN_",",13.7,"E")   ;appt clerk name
 S ARASD=""
 S:ARSDOA'="" $P(ARASD,"~~",1)=ARSDOA
 S:ARCLERK'="" $P(ARASD,"~~",12)=ARCLERK
 S:ARCLERKN'="" $P(ARASD,"~~",13)=ARCLERKN
 S:ARDAM'="" $P(ARASD,"~~",17)=ARDAM
 S ARSVCCON=ARDATA(FNUM,ARIEN_",",15,"E")
 S ARDAPTDT=ARDATA(FNUM,ARIEN_",",22,"I")
 S ARCOMM=ARDATA(FNUM,ARIEN_",",25,"E")
 S ARMAR=ARDATA(409.85,ARIEN_",",41,"E")
 S ARMAI=ARDATA(409.85,ARIEN_",",42,"E")
 S ARMAN=ARDATA(409.85,ARIEN_",",43,"E")
 S ARPC=$$WLPC^SDECAR1A(.ARDATA,ARIEN)
 S ARDISPD=ARDATA(FNUM,ARIEN_",",19,"E")
 S ARDISPU=ARDATA(FNUM,ARIEN_",",20,"I")
 S ARDISPUN=ARDATA(FNUM,ARIEN_",",20,"E")
 S APPTPTRS=$$GETAPPTS^SDECAR1A(ARIEN)
 S CHILDREN=$$CHILDREN^SDECAR1A(ARIEN)
 S ARMRTC=$$MRTC^SDECAR(ARIEN)
 S SDPARENT=ARDATA(FNUM,ARIEN_",",43.8,"I")
 S MRTCSEQUENCENUM=ARDATA(FNUM,ARIEN_",",43.1,"I")
 S CANCHANGEPID=ARDATA(409.85,ARIEN_",",49,"I")
 ;Build string of RTC dates
 S (SDI,SDMTRC)=""
 F  S SDI=$O(ARDATA(409.851,SDI)) Q:SDI=""  S SDMTRC=$S(SDMTRC'="":SDMTRC_"|",1:"")_ARDATA(409.851,SDI,.01,"E")
 ;      1    2       3          4        5          6
 S STR=DFN_U_ARIEN_U_ARORIGDT_U_ARINST_U_ARINSTNM_U_ARTYPE
 ;           7         8          9        10        11       12        13
 S STR=STR_U_ARCLIEN_U_ARCLNAME_U_ARUSER_U_ARUSRNM_U_ARPRIO_U_ARREQBY_U_ARPROV
 ;           14         15         16       17        18      19      20
 S STR=STR_U_ARPROVNM_U_ARDAPTDT_U_ARCOMM_U_ARENPRI_U_ARMAR_U_ARMAI_U_ARMAN
 ;           21     22        23        24         25
 S STR=STR_U_ARPC_U_ARDISPD_U_ARDISPU_U_ARDISPUN_U_ARSVCCON
 ;           26       27       28        29      30
 S STR=STR_U_AREDT_U_SDMTRC_U_ARSTOP_U_ARSTOPN_U_ARASD
 ;           31        32        33     34        35         36
 S STR=STR_U_ARMRTC_U_APPTYPE_U_SDPS_U_APPTPTRS_U_CHILDREN_U_SDPARENT
 ;# OF CALLS MADE AND DATE LAST LETTER SENT
 S CALLLETTER=$$CALLET^SDECAR1A(DFN,ARIEN)
 S STR=STR_U_CALLLETTER
 ;
 S COUNT=$G(COUNT)+1
 I '$G(JSONFLG) S ^TMP("SDECAR4",$J,COUNT)=STR_$C(30) Q
 ;
 S APPT("ApptReq",COUNT,"PatientIEN")=DFN
 S APPT("ApptReq",COUNT,"ApptReqIEN")=ARIEN
 S APPT("ApptReq",COUNT,"CreateDateI")=ARORIGDT
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
 S APPT("ApptReq",COUNT,"CidPreferredDateOfApptI")=ARDAPTDT
 S APPT("ApptReq",COUNT,"CommentsE")=ARCOMM
 D BUILDPATCOMMENTS(.APPT,ARIEN,COUNT)
 S APPT("ApptReq",COUNT,"EnrollmentPriorityE")=ARENPRI
 S APPT("ApptReq",COUNT,"MultipleAppointmentRtcE")=ARMAR
 S APPT("ApptReq",COUNT,"MultApptRtcIntervalE")=ARMAI
 S APPT("ApptReq",COUNT,"MultApptNumberE")=ARMAN
 S SUBCNT=0
 F I=1:1:$L(ARPC,"::") D
 .S VAR=$P(ARPC,"::",I)
 .Q:VAR=""
 .S SUBCNT=SUBCNT+1
 .S APPT("ApptReq",COUNT,"PatientContact",SUBCNT,"DateEnteredI")=$P(VAR,"~~",1)
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
 S APPT("ApptReq",COUNT,"DateTimeEnteredE")=AREDT
 S SUBCNT=0
 F I=1:1:$L(SDMTRC,"|") D
 .S SUBCNT=SUBCNT+1
 .S:$P(SDMTRC,"|",I)'="" APPT("ApptReq",COUNT,"MRTCCalcPrefDates",SUBCNT,"Date")=$P(SDMTRC,"|",I)
 I '$D(APPT("ApptReq",COUNT,"MRTCCalcPrefDates")) S APPT("ApptReq",COUNT,"MRTCCalcPrefDates")=""
 ;
 S APPT("ApptReq",COUNT,"ReqServiceSpecialtyI")=ARSTOP
 S APPT("ApptReq",COUNT,"ReqServiceSpecialtyE")=ARSTOPN
 S APPT("ApptReq",COUNT,"ScheduledDateOfApptI")=ARSDOA
 S APPT("ApptReq",COUNT,"ApptClerkI")=ARCLERK
 S APPT("ApptReq",COUNT,"ApptClerkE")=ARCLERKN
 S APPT("ApptReq",COUNT,"DateApptMadeE")=ARDAM
 S APPT("ApptReq",COUNT,"CountOfRTCs")=ARMRTC  ;Count of nodes in 43.3 sub file
 S APPT("ApptReq",COUNT,"MrtcSequenceNumber")=$G(MRTCSEQUENCENUM)
 S APPT("ApptReq",COUNT,"ReqAppointmentTypeI")=APPTYPE
 S APPT("ApptReq",COUNT,"PatientStatusE")=SDPS
 S APPT("ApptReq",COUNT,"CanEditPid")=CANCHANGEPID
 S SUBCNT=0
 F I=1:1:$L(APPTPTRS,"|") D
 .S VAR=$P(APPTPTRS,"|",I)
 .S SUBCNT=SUBCNT+1
 .S:VAR'="" APPT("ApptReq",COUNT,"MultiAppointmentsI",SUBCNT,"IEN")=VAR
 I '$D(APPT("ApptReq",COUNT,"MultiAppointmentsI")) S APPT("ApptReq",COUNT,"MultiAppointmentsI")=""
 ;
 S SUBCNT=0
 F I=1:1:$L(CHILDREN,"|") D
 .S VAR=$P(CHILDREN,"|",I)
 .S SUBCNT=SUBCNT+1
 .S:VAR'="" APPT("ApptReq",COUNT,"MultiApptRequestsChildI",SUBCNT,"ARIEN")=VAR
 I '$D(APPT("ApptReq",COUNT,"MultiApptRequestsChildI")) S APPT("ApptReq",COUNT,"MultiApptRequestsChildI")=""
 ;
 S APPT("ApptReq",COUNT,"ParentRequestI")=SDPARENT
 S APPT("ApptReq",COUNT,"NumberOfCalls")=$P(CALLLETTER,"^",1)
 S APPT("ApptReq",COUNT,"NumberOfEmailContact")=$P(CALLLETTER,U,3)
 S APPT("ApptReq",COUNT,"NumberOfTextContact")=$P(CALLLETTER,U,4)
 S APPT("ApptReq",COUNT,"NumberOfSecureMessage")=$P(CALLLETTER,U,5)
 S APPT("ApptReq",COUNT,"DateOfLastLetterSent")=$P(CALLLETTER,"^",2)
 Q
 ;
HDR ;
 N SDRTMP
 S SDRTMP="T00030DFN^I00010IEN^D00030ORIGDT"
 ;                 4             5              6          7              8
 S SDRTMP=SDRTMP_"^T00030INSTIEN^T00030INSTNAME^T00030TYPE^T00030CLINIEN^T00030CLINNAME"
 ;                  9             10            11         12          13            14
 S SDRTMP=SDRTMP_"^T00030USERIEN^T00030USERNAME^T00030PRIO^T00030REQBY^T00030PROVIEN^T00030PROVNAME"
 ;                  15           16         17
 S SDRTMP=SDRTMP_"^T00030DAPTDT^T00250COMM^T00030ENROLLMENT_PRIORITY"
 ;                 18                             19                           20
 S SDRTMP=SDRTMP_"^T00010MULTIPLE APPOINTMENT RTC^T00010MULT APPT RTC INTERVAL^T00010MULT APPT NUMBER"
 ;                 21             22               23           24             25
 S SDRTMP=SDRTMP_"^T00100PCONTACT^T00030ARDISPD^T00030ARDISPU^T00030ARDISPUN^T00030WLSVCCON"
 ;                 26         27              28            29             30
 S SDRTMP=SDRTMP_"^T00030DATE^T00030MTRCDATES^T00030STOPIEN^T00030STOPNAME^T00250APPT_SCHED_DATE"
 ;                 31              32            33           34                35             36
 S SDRTMP=SDRTMP_"^T00030MRTCCOUNT^T00030APPTYPE^T00030EESTAT^T00030APPTPTRS^T00250CHILDREN^T00030SDPARENT"
 S SDRTMP=SDRTMP_"^T00030CPHONE^T00030CLET"
 S @RET@(0)=SDRTMP_$C(30)
 Q
 ;
BUILDPATCOMMENTS(REQUEST,REQUESTIEN,COUNT) ; patient comments
 N SUBIEN,NUM,PATCMT
 S SUBIEN=0
 S PATCMT=""
 F  S SUBIEN=$O(^SDEC(409.85,REQUESTIEN,"PATCOM",SUBIEN)) Q:'SUBIEN  D
 .S PATCMT=PATCMT_$$GET1^DIQ(409.855,SUBIEN_","_REQUESTIEN_",",.01,"E")_" "
 S REQUEST("ApptReq",COUNT,"PatientComment")=PATCMT
 Q
 ;
BUILDJSON ;Convert to JSON
 S RET=$G(RET,"RET")
 D ENCODE^SDESJSON(.APPT,.RET,.JSONERR)
 K ^TMP("SDECAR4",$J)
 Q
 ;
EXIT ; Any special logic needed for a successful completion
 N SDTMP,COUNT
 S COUNT=$O(^TMP("SDECAR4",$J,""),-1)
 I COUNT="" S ^TMP("SDECAR4",$J,1)=0,COUNT=1  ;No records to return
 S SDTMP=^TMP("SDECAR4",$J,COUNT)
 S SDTMP=$P(SDTMP,$C(30),1)
 S ^TMP("SDECAR4",$J,COUNT)=SDTMP_$C(30,31)
 Q
