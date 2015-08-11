VPSAPPT ;SLOIFO/BT - VPS Appointment RPC;1/16/15 11:55
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #3860  - DGPFAPI call          (Controlled Sub)
 ; #10035 - ^DPT( references      (Supported)
 ; #4433  - SDAMA301 call         (Supported)
 ; #2462  - ^DGEN( reference      (Controlled Sub) 
 ; ###### - File 2.98, Field 17 (Cancellation Remark) (Private)
 QUIT
 ;
GET(VPSAPPT,VPSQUEUE,VPSFRDT,VPSTODT) ; VPS GET APPOINTMENTS
 ; This RPC returns all appointments for a given appointment date range.
 ; Those appointments will also be stored in VPS Appointment queue (File 853.9).
 ; This queue is used by GETCHG^VPSAPPT2 to filter out the non-change appontments during retrieval.
 ;
 ; INPUT
 ;   VPSQUEUE : Unique Queue ID represents Vecna Appointment Queue.
 ;   VPSFRDT  : Appointment From Date
 ;   VPSTODT  : Appointment Through Date
 ; OUTPUT
 ;   VPSAPPT : Name of Global array contains all retrieved appointments
 ;   Output Format: 
 ;   ^TMP("VPSAPPT",$J,SEQ)=TODO^APPOINTMENT ID^RECORD FLAG#^FIELD NAME^FIELD VALUE
 ;      TODO                    : instruct vecna to add appointment into the queue and also notify for any error
 ;      APPOINTMENT ID          : represent appointment record in the VPS Appointment queue
 ;      RECORD FLAG#            : record flag number for patient (1..n)  - use only for record flag field
 ;      FIELD NAME              : Field name
 ;      FIELD VALUE             : Field value
 ;
 ;   Output Samples:
 ;      ^TMP("VPSAPPT",$J,0)=ERR^^^PARAMETER^error message      <--- notify Vecna for parameter error
 ;      ^TMP("VPSAPPT",$J,SEQ)=ERR^99^^ERROR^error message <--- notify Vecna that there is an issue during adding appt ien #99 to the queue
 ;      ^TMP("VPSAPPT",$J,SEQ)=ADD^111^^<FIELD NAME>^FIELD VALUE   <--- notify Vecna to add entry #111 to the queue with those field values
 ;      ^TMP("VPSAPPT",$J,SEQ)=ADD^111^1^<FLAG FIELD NAME>^FIELD VALUE <--- notify Vecna to add record flag #1 to entry #111 to the queue
 ;
 ;      <FIELD NAME> is a member of
 ;        CLINIC IEN^CLINIC NAME^APPT DATE
 ;        DFN^PATIENT NAME^SSN^EMAIL
 ;        APPT TYPE IEN^APPT TYPE NAME^APPT COMMENTS
 ;        APPT STATUS IEN^APPT STATUS NAME^DISPLAYED APPT STATUS
 ;        BAD ADDRESS INDICATOR^BAD ADDRESS NAME
 ;        SENSITIVE,BALANCE,ENROLLMENT STATUS,ENROLLMENT STATUS NAME
 ;        PRE-REGISTRATION DATE CHANGED,ELIGIBILITY STATUS,ELIGIBILITY STATUS NAME
 ;        INELIGIBLE DATE^MEANS TEST STATUS^INSURANCE
 ;      <FLAG FIELD NAME> is a member of 
 ;        FLAG INDICATOR^FLAG TYPE^FLAG NAME^FLAG NARRATIVE
 ;
 S VPSAPPT=$NA(^TMP("VPSAPPT",$J)) K @VPSAPPT ; return as global array
 I $G(VPSQUEUE)="" D ADDERR("ERR^^^PARAM^QUEUE ID IS REQUIRED") QUIT
 I $G(VPSFRDT)="" D ADDERR("ERR^^^PARAM^FROM DATE IS REQUIRED") QUIT
 I $G(VPSTODT)="" D ADDERR("ERR^^^PARAM^THROUGH DATE IS REQUIRED") QUIT
 K ^TMP($J,"SDAMA301")
 ;
 N OK S OK=$$ADDQUEUE(VPSQUEUE,VPSFRDT,VPSTODT) ; create queue entry
 I OK D
 . N APPTCNT S APPTCNT=$$POPAPPTS(VPSFRDT,VPSTODT) ; populate ^TMP($J,"SDAMA301") using supported API given appointment from - through date
 . D:APPTCNT>0 CMPAPPTS(VPSQUEUE) ; stored appointments in the vps appointment queue file and result array
 ;
 K ^TMP($J,"SDAMA301")
 QUIT
 ;
ADDERR(MSG) ;add error message to result array
 S ^TMP("VPSAPPT",$J,0)=MSG
 QUIT
 ; 
ADDQUEUE(QUEUEID,FROM,THROUGH) ; create queue entry
 ; INPUT
 ;   QUEUEID : Unique Queue ID represents Vecna Appointment Queue.
 ;   FROM    : Appointment From Date
 ;   THROUGH : Appointment Through Date
 ;
 K ^VPS(853.9,QUEUEID)
 N VPSFDA,VPSERR,IENS
 S IENS(1)=QUEUEID
 S VPSFDA(853.9,"+1,",.01)=QUEUEID
 S VPSFDA(853.9,"+1,",1)=FROM
 S VPSFDA(853.9,"+1,",2)=THROUGH
 D UPDATE^DIE("E","VPSFDA","IENS","VPSERR")
 N OK S OK='$D(DIERR)
 D:'OK ADDERR("ERR"_U_U_U_"FILE"_U_VPSERR("DIERR",1,"TEXT",1))
 K DIERR,VPSFDA,VPSERR,IENS
 QUIT OK
 ;
POPAPPTS(VPSFRDT,VPSTODT) ; populate ^TMP($J,"SDAMA301") using supported API given appointment from - through date
 ; INPUT
 ;   VPSFRDT : Appointment From Date
 ;   VPSTODT : Appointment Through Date
 ;
 N DGARRAY
 S DGARRAY(1)=VPSFRDT_";"_VPSTODT
 S DGARRAY("FLDS")="1;2;4;10;22" ;get appt date, clinic and appointment status
 QUIT $$SDAPI^SDAMA301(.DGARRAY)
 ;
CMPAPPTS(QUEUEID) ; stored appointments in the vps appointment queue file and result array
 ; INPUT
 ;   QUEUEID : Unique Queue ID represents Vecna Appointment Queue.
 ;
 N APPTINFO,APPT,APPTDT
 N CLIEN S CLIEN=0
 F  S CLIEN=$O(^TMP($J,"SDAMA301",CLIEN)) QUIT:'CLIEN  D
 . N DFN S DFN=0
 . F  S DFN=$O(^TMP($J,"SDAMA301",CLIEN,DFN)) QUIT:'DFN  D:$D(^DPT(DFN,0))
 . . S APPTDT=0
 . . F  S APPTDT=$O(^TMP($J,"SDAMA301",CLIEN,DFN,APPTDT)) QUIT:'APPTDT  D
 . . . S APPTINFO=$G(^TMP($J,"SDAMA301",CLIEN,DFN,APPTDT))
 . . . D GETAPPT(.APPT,APPTINFO)
 . . . N TODO S TODO=$$ADDAPPT(QUEUEID,.APPT) ;add the appointment to temporary storage (File #853.9)
 . . . D ADDTMP(TODO,QUEUEID,.APPT) ;add the appointment to result array
 QUIT
 ; 
GETAPPT(APPT,APPTINFO) ; return the required appointment information
 ; INPUT
 ;   APPTINFO : Appointment Information returned by $$SDAPI^SDAMA301 containing clinic, patient, appt date, and appointment status
 ; OUTPUT
 ;   APPT     : Array by Reference - Extended appointment information for Vecna to display in the queue
 ;   APPT(FLD)       = VALUE
 ;   APPT("PRF",PRF) = FLAG INDICATOR^FLAG TYPE^FLAG NAME^FLAG NARRATIVE (1..n)
 ; RETURN
 ;
 ; -- get appointment date
 K APPT S APPT("APPT DATE/TIME")=$P(APPTINFO,U)
 ;
 ; -- get clinic info
 S APPT("CLINIC IEN")=$P($P(APPTINFO,U,2),";")
 S APPT("CLINIC NAME")=$P($P(APPTINFO,U,2),";",2)
 ;
 ; -- get patient info
 S APPT("DFN")=$P($P(APPTINFO,U,4),";")
 S APPT("PATIENT NAME")=$P($P(APPTINFO,U,4),";",2)
 N RES D GETS^DIQ(2,APPT("DFN")_",",".09;.133","E","RES")
 S APPT("SSN")=$G(RES(2,DFN_",",.09,"E"))
 S APPT("EMAIL")=$G(RES(2,DFN_",",.133,"E"))
 ;
 D GETPRF(APPT("DFN"),.APPT) ;populate APPT array with patient record flags and narrative
 ;
 ; -- get appointment type
 N APPTYP S APPTYP=$P(APPTINFO,U,10)
 S APPT("APPT TYPE IEN")=$P(APPTYP,";") ;appt type ien
 S APPT("APPT TYPE NAME")=$P(APPTYP,";",2) ;appt type name
 ;
 ; -- get cancellation remarks
 N IENS S IENS=APPT("APPT DATE/TIME")_","_APPT("DFN")_","
 N APPTOUT D GETS^DIQ(2.98,IENS,"17","IE","APPTOUT")
 S APPT("APPT COMMENTS")=$G(APPTOUT(2.98,IENS,17,"I"))
 ;
 ; -- get appointment status
 N STATUS S STATUS=$P(APPTINFO,U,22)
 S APPT("APPT STATUS IEN")=$P(STATUS,";") ;status ien
 S APPT("APPT STATUS NAME")=$P(STATUS,";",2) ;status name
 S APPT("DISPLAYED APPT STATUS")=$P(STATUS,";",3) ;Print Status (what is displayed)
 ;
 ; -- get Bad Address Indicator
 N BADADR S BADADR=$$BADADR^DGUTL3(DFN)
 I BADADR'="" D
 . N BADADRNM S BADADRNM=""
 . I BADADR=1 S BADADRNM="UNDELIVERABLE"
 . I BADADR=2 S BADADRNM="HOMELESS"
 . I BADADR=3 S BADADRNM="OTHER"
 . S APPT("BAD ADDRESS INDICATOR")=BADADR
 . S APPT("BAD ADDRESS NAME")=BADADRNM
 ;
 ; -- get Sensitive
 N VPSARR D SENLOG^VPSRPC16(.VPSARR,DFN)
 N SENS S SENS=$P($G(VPSARR(1)),U,4)
 S:SENS'="" APPT("SENSITIVE")=SENS
 ;
 ; -- get Balance
 K VPSARR D BAL^VPSRPC26(.VPSARR,DFN)
 N BAL S BAL=$P($G(VPSARR(1)),U,4)
 S:BAL'="" APPT("BALANCE")=BAL
 ;
 ; -- Get Enrollment Status
 N ENRIEN S ENRIEN=$O(^DGEN(27.11,"C",DFN,""),-1)
 I ENRIEN D
 . N DFENR D GET^DGENA(ENRIEN,.DGENR)
 . N ENRSTAT S ENRSTAT=$G(DGENR("STATUS"))
 . I ENRSTAT'="" D
 . . N ESNAME S ESNAME=$$GET1^DIQ(27.11,ENRIEN_",",.04,"E")
 . . S APPT("ENROLLMENT STATUS")=ENRSTAT
 . . S APPT("ENROLLMENT STATUS NAME")=ESNAME
 ;
 ; -- get Pre-Registration Date Changed
 K VPSARR D DGS^VPSRPC26(.VPSARR,DFN)
 N PRDT S PRDT=$P($G(VPSARR(1)),U,4)
 S:PRDT'="" APPT("PRE-REGISTRATION DATE CHANGED")=PRDT
 ;
 ; -- get Eligibility Code
 N VAEL D ELIG^VADPT
 N ELIGSTAT S ELIGSTAT=$P($G(VAEL(8)),U)
 I ELIGSTAT'="" D
 . S APPT("ELIGIBILITY STATUS")=ELIGSTAT
 . S ELIGSTAT=$P($G(VAEL(8)),U,2)
 . S APPT("ELIGIBILITY STATUS NAME")=ELIGSTAT
 ;
 ; -- get Ineligible date
 N IELIGDT S IELIGDT=$P($G(VAEL(5,1)),U)
 S:IELIGDT'="" APPT("INELIGIBLE DATE")=IELIGDT
 ;
 ; -- get Means Test Status
 N MTS S MTS=$P($G(VAEL(9)),U,2)
 S:MTS'="" APPT("MEANS TEST STATUS")=MTS
 ;
 ; -- get Insurance (true/false)
 K VPSARR D IBB^VPSRPC26(.VPSARR,DFN) ; Insurance Info
 N INS S INS=$P($G(VPSARR(1)),U,4)
 S INS=$S(INS'="":"Y",1:"N")
 S APPT("INSURANCE")=INS
 ;
 QUIT
 ;
GETPRF(DFN,PRFLAGS) ;populate PRFLAGS with patient record flags and narrative
 ;INPUT : DFN     - Patient IEN
 ;OUTPUT: PRFLAGS - Patient Record Flags array
 ;
 N PRF,REC,NPRF S NPRF=$$GETACT^DGPFAPI(DFN,"REC") ;Retrieve all ACTIVE Patient record flag assignments
 N FLAG,FLAGTYPE,PRFLAG,PRFFIL,FLAGFROM,FLAGNAME,NARR,FLAGINFO
 ;
 F PRF=1:1:NPRF D
 . ;store flag type
 . S FLAGTYPE=$P(REC(PRF,"FLAGTYPE"),U,2)
 . S PRFLAG=$P(REC(PRF,"FLAG"),U)
 . S FLAGFROM=""
 . I FLAGTYPE'="",PRFLAG'="" D
 . . S PRFFIL=$P($P(PRFLAG,"DGPF(",2),",")
 . . I PRFFIL'="" S FLAGFROM=$S(PRFFIL=26.11:"LOCAL",1:"NATIONAL")
 . . I PRFFIL="" S FLAGTYPE=""
 . S FLAGNAME=$P(REC(PRF,"FLAG"),U,2)
 . S PRFLAGS("PRF",PRF,"FLAG ORIGINATION")=FLAGFROM
 . S PRFLAGS("PRF",PRF,"FLAG TYPE")=FLAGTYPE
 . S PRFLAGS("PRF",PRF,"FLAG NAME")=FLAGNAME
 . M PRFLAGS("PRF.NARR",PRF)=REC(PRF,"NARR")
 QUIT
 ;
GETNARR(PRF,REC) ; Get ASSIGNMENT NARRATIVE (word-processing)
 N VAL,NARR S NARR=""
 N NARRCNT S NARRCNT=""
 F  S NARRCNT=$O(REC(PRF,"NARR",NARRCNT)) QUIT:NARRCNT=""  D
 . S VAL=$G(REC(PRF,"NARR",NARRCNT,0))
 . S NARR=NARR_VAL_U
 S:$E(NARR,$L(NARR))=U NARR=$E(NARR,1,$L(NARR)-1)
 QUIT NARR
 ;
ADDAPPT(QUEUEID,APPT) ; add appointment to sub file 853.91
 ; INPUT
 ;   QUEUEID  : Unique Queue ID represents Vecna Appointment Queue.
 ;   APPT(FLD): Array contains value of FIELD 
 ;              CLINIC IEN, APPT DATE, DFN, APPT TYPE, DISPLAY APPT STATUS
 ;              All Values are required
 ; RETURN
 ;   TODO     : ADD               <-- successfully add the appointment
 ;            : ERR^ERRORMESSAGE  <-- failed adding the appointment with ERROR MESSAGE
 ;
 N TODO S TODO="ADD"
 N VPSFDA,VPSERR,DIERR
 S VPSFDA(853.91,"+1,"_QUEUEID_",",.01)=APPT("CLINIC IEN") ;clinic ien
 S VPSFDA(853.91,"+1,"_QUEUEID_",",1)=APPT("APPT DATE/TIME")  ;appointment date
 S VPSFDA(853.91,"+1,"_QUEUEID_",",2)=APPT("DFN")     ;patient ien
 S VPSFDA(853.91,"+1,"_QUEUEID_",",3)=APPT("APPT TYPE IEN")  ;appt type ien
 S VPSFDA(853.91,"+1,"_QUEUEID_",",4)=APPT("DISPLAYED APPT STATUS") ;displayed/printed version of appt status
 D UPDATE^DIE("","VPSFDA","","VPSERR")
 I $D(DIERR) S TODO="ERR"_U_VPSERR("DIERR",1,"TEXT",1)
 K DIERR,VPSFDA,VPSERR
 QUIT TODO
 ;
ADDTMP(TODO,QUEUEID,APPT) ; add appointment to result array
 ; INPUT
 ;   TODO           : Instruction to vecna what todo with the appointment (ADD or ERR)
 ;   QUEUEID        : Unique Queue ID represents Vecna Appointment Queue.
 ;   APPT(FLD)      : Array contains value of FLD
 ;   APPT("PRF",PRF): RECORD FLAG
 ;                  : FLAG ORIGINATION (NATIONAL/LOCAL)^FLAG TYPE^FLAG NAME^FLAG NARRATIVE (1..n)
 ;
 N SEQ S SEQ=$O(^TMP("VPSAPPT",$J,""),-1)+1
 N CLIEN S CLIEN=APPT("CLINIC IEN")       ;clinic ien
 N APPTDT S APPTDT=APPT("APPT DATE/TIME") ;appointment date
 N DFN S DFN=APPT("DFN")                  ;patient ien
 N APPTIEN S APPTIEN=$$GETIEN^VPSAPPT(QUEUEID,CLIEN,APPTDT,DFN)
 I $P(TODO,U)="ERR" D SAVTMP("ERR",APPTIEN,,"ERROR",$P(TODO,U,2)) QUIT
 ;
 ; -- Save appointment fields other than RECORD FLAG
 N FLD S FLD=""
 F  S FLD=$O(APPT(FLD)) Q:FLD=""  D:$E(FLD,1,3)'="PRF" SAVTMP(TODO,APPTIEN,,FLD,APPT(FLD))
 ;
 ; -- save patient record flag
 N SEQ S SEQ=0
 N CNT S CNT=""
 F  S SEQ=$O(APPT("PRF",SEQ)) Q:'SEQ  D
 . F  S FLD=$O(APPT("PRF",SEQ,FLD)) Q:FLD=""  D
 . . D SAVTMP(TODO,APPTIEN,SEQ,FLD,APPT("PRF",SEQ,FLD))
 . F  S CNT=$O(APPT("PRF.NARR",SEQ,CNT)) Q:CNT=""  D
 . . D SAVTMP(TODO,APPTIEN,SEQ,"FLAG NARRATIVE "_CNT,$G(APPT("PRF.NARR",SEQ,CNT,0)))
 ;
 QUIT
 ;
SAVTMP(TODO,APPTIEN,SEQ,FLD,DATA) ;save data to result global array
 N LAST S LAST=$O(^TMP("VPSAPPT",$J,""),-1)+1
 S ^TMP("VPSAPPT",$J,LAST)=TODO_U_APPTIEN_U_$G(SEQ)_U_$G(FLD)_U_DATA
 QUIT
 ;
GETIEN(QUEUEID,CLIEN,APPTDT,DFN) ; return the IEN for sub file 853.91 record
 ; INPUT
 ;   QUEUEID : Unique Queue ID represents Vecna Appointment Queue.
 ;   CLIEN   : Clinic IEN
 ;   APPTDT  : Appointment Date
 ;   DFN     : Patient IEN
 ; RETURN
 ;   APPOINTMENT IEN in the queue
 ;
 QUIT:'QUEUEID!'CLIEN!'APPTDT!'DFN ""
 N APPTIEN S APPTIEN=$O(^VPS(853.9,QUEUEID,1,"C",CLIEN,APPTDT,DFN,""))
 QUIT APPTIEN
