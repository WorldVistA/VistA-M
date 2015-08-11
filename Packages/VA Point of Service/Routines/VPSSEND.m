VPSSEND ;SLOIFO/BT - Send HL7 messages (Appointment Status Change) to VetLink HL7 Server ;01/16/2015 11:23
 ;;1.0;VA POINT OF SERVICE (KIOSKS);**5**;Jan 16, 2015;Build 31
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External Reference DBIA#
 ; ------------------------
 ; #1496  - ^HLCS(870,            (Controlled Subs)
 ; #2171  - $$NS^XUAF4            (Supported)
 ; #2462  - ^DGEN( reference      (Controlled Sub) 
 ; #2541  - $$KSP^XUPARAM         (Supported)
 ; #3065  - STDNAME^XLFNAME       (Supported)
 ; #4080  - $$BADADR^DGUTL3       (Supported)
 ; #4433  - SDAMA301 call         (Supported)
 ; #4716  - $$NEWMSG^HLOAPI       (Supported)
 ; #4716  - $$SET^HLOAPI          (Supported)
 ; #4716  - $$ADDSEG^HLOAPI       (Supported)
 ; #4717  - $$SENDONE^HLOAPI1     (Supported)
 ; #4730  - HLOQUE                (Supported)
 ; #4853  - $$SETDT^HLOAPI4       (Supported)
 ; #10040 - ^SC( references       (Supported)
 ; #10063 - %ZTLOAD               (Supported)
 ; #6137  - File 2.98, Field 17 (Cancellation Remark) (Private)
 ; #6122  - locking/unlocking ^HLB("QUEUE","OUT",LINKPORT,QUEUE,IEN)) 
 QUIT
 ;
EN ;Entry Point called by SDAM APPOINTMENT EVENTS protocol
 ; SDATA will be defined when SDAM APPOINTMENT EVENTS protocol calls this entry
 N AFTERSTS S AFTERSTS=$G(SDATA("AFTER","STATUS"))
 N STATUS S STATUS=$P(AFTERSTS,"^",3)
 QUIT:STATUS=""  ; Not a valid appointment
 ;
 ; -- is VPS HL7 active?
 I '$$ACTIVE D ERROR("VPS HL7 IS INACTIVE") QUIT
 ;
 ; -- queue transmission process
 N DFN S DFN=$P(SDATA,"^",2)
 N APPTDT S APPTDT=$P(SDATA,"^",3)
 N CLINIC S CLINIC=$P(SDATA,"^",4)
 ;
 I '$$QUE(DFN,APPTDT,CLINIC,STATUS) D ERROR("Unable to queue VPS SEND APPOINTMENT STATUS") QUIT
 QUIT
 ;
ACTIVE() ;Is VPS HL7 active? 
 ;Return 1 if HL7 active, 0 othewise
 N SITE S SITE=$O(^VPS(853.1,"B","VPS HL7 SITE PARAMETER",0))
 QUIT:'SITE 0
 QUIT $P(^VPS(853.1,SITE,0),U,2)="Y"
 ;
QUE(DFN,APPTDT,CLINIC,STATUS) ; -- Queue Send appointment status Job
 K ZTSK,IO("Q")
 S ZTIO="NULL"
 S ZTDTH=$H
 S ZTDESC="VPS SEND APPOINTMENT STATUS"
 S ZTRTN="SEND^VPSSEND"
 ;
 N SENDAPP S SENDAPP="VPS SEND APPT STATUS"
 N RCVAPP S RCVAPP="VPS VECNA APPT STATUS"
 N LINK S LINK="VPSAPPT"
 ;
 N SAV F SAV="CLINIC","DFN","APPTDT","STATUS","SENDAPP","RCVAPP","LINK" S ZTSAVE(SAV)=""
 D ^%ZTLOAD
 QUIT ZTSK
 ;
SEND ; -- Send HL7 message to VetLink
 ;At this point LINK, CLINIC, APPTDT, STATUS, RCVAPP, SENDAPP should exist, sent by Taskman queue
 N QUEUE S QUEUE="VPSSEND"_$J
 N LINKPORT S LINKPORT=$$PREPQUE(LINK,QUEUE)
 I +LINKPORT=-1 D ERROR($P(LINKPORT,U,2)) QUIT
 ;
 N APPT
 S APPT("DFN")=DFN
 S APPT("CLINIC")=CLINIC
 S APPT("CLINIC NAME")=$P($G(^SC(CLINIC,0)),U)
 S APPT("APPOINTMENT DATE")=APPTDT
 ;
 N PARMS,MSG
 S PARMS("MESSAGE TYPE")="ADT"
 S PARMS("EVENT")="A01"
 S PARMS("MESSAGE STRUCTURE")="ADT_A01"
 S PARMS("SENDING APPLICATION")=SENDAPP
 S PARMS("ACCEPT ACK TYPE")="AL"
 S PARMS("APP ACK TYPE")="NE"
 S PARMS("QUEUE")=QUEUE
 ;
 N WHOTO
 S WHOTO("RECEIVING APPLICATION")=RCVAPP
 S WHOTO("FACILITY LINK NAME")=LINK
 ;
 N OK,ERR
 S OK=$$NEWMSG^HLOAPI(.PARMS,.MSG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- Event segment
 I OK D EVN(.APPT,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- Patient ID segment
 I OK D PID(DFN,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- Patient Visit Segment for Record Flags
 S OK=$$PV1(DFN,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- Insurance segment
 I OK D IN1(DFN,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- VA Patient Eligibility segment
 N VAEL D ELIG^VADPT
 I OK D ZEL(.VAEL,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- VA Enrollment segment
 I OK D ZEN(DFN,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- VA Means Test segment
 I OK D ZMT(.VAEL,.SEG)
 I OK S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 ; -- Send message
 I OK S OK=$$SENDONE^HLOAPI1(.MSG,.PARMS,.WHOTO,.ERR)
 I 'OK D ERROR(ERR,LINKPORT,QUEUE) QUIT
 ;
 D STARTQUE(LINKPORT,QUEUE) ;Start HLO Queue to send message
 D UNLQUE(LINKPORT,QUEUE)
 QUIT
 ;
ERROR(ERR,LINKPORT,QUEUE) ;Store error
 I $G(LINKPORT)'="",$G(QUEUE)'="" D UNLQUE(LINKPORT,QUEUE)
 ;
 N VPSFDA,VPSERR,SITE
 S SITE=$O(^VPS(853.1,"B","VPS HL7 SITE PARAMETER",0))
 ;
 I SITE D
 . S VPSFDA(853.1,SITE_",",2)=$$NOW^XLFDT()
 . S VPSFDA(853.1,SITE_",",3)=ERR
 . D FILE^DIE("E","VPSFDA","VPSERR")
 ;
 I 'SITE D
 . S VPSFDA(853.1,"+1,",.01)="VPS HL7 SITE PARAMETER"
 . S VPSFDA(853.1,"+1,",1)="N"
 . S VPSFDA(853.1,"+1,",2)=$$NOW^XLFDT()
 . S VPSFDA(853.1,"+1,",3)=ERR
 . D UPDATE^DIE("E","VPSFDA","IENS","VPSERR")
 ;
 QUIT
 ;
PREPQUE(LINK,QUEUE) ; -- Prepare to use HL7 Queue
 ; INPUT 
 ;   LINK  : HL LOGICAL LINK
 ;   QUEUE : HL7 Transmission Queue
 ; RETURN
 ;   LINK_":"_HLOPORT  for success
 ;   -1^Error Message  for error
 ;
 N IEN S IEN=$O(^HLCS(870,"B",LINK,0))
 QUIT:'IEN "-1^HL LOGICAL LINK NOT DEFINED"
 ;
 N NODE S NODE=$G(^HLCS(870,IEN,400))
 N HLOPORT S HLOPORT=$P(NODE,"^",8)
 S:'HLOPORT HLOPORT=$P(NODE,"^",2)
 QUIT:'HLOPORT "-1^INVALID HL LOGICAL LINK PORT"
 ;
 N LINKPORT S LINKPORT=LINK_":"_HLOPORT
 L +^HLB("QUEUE","OUT",LINKPORT,QUEUE):3 E  QUIT "-1^QUEUE is busy"
 D STOPQUE^HLOQUE("OUT",QUEUE)
 ;
 QUIT LINKPORT
 ;
STARTQUE(LINKPORT,QUEUE) ;start Queue
 D UNLQUE(LINKPORT,QUEUE)
 D STARTQUE^HLOQUE("OUT",QUEUE)
 QUIT
 ;
UNLQUE(LINKPORT,QUEUE) ;Unlock Queue
 L -^HLB("QUEUE","OUT",LINKPORT,QUEUE)
 QUIT
 ;
EVN(APPT,SEG) ; -- generate PID segment
 ;
 ;Description:
 ; Builds the EVN segment using the HLO segment building APIs.
 ;
 ; The fields that are included in the segment are:
 ;  EVN-1 Not used
 ;  EVN-2 Appointment date (Fileman)
 ;  EVN-3 Appointment date (HL7)
 ;
 ;Input:
 ;  APPT (pass-by-refernce) - Appointment information 
 ;
 ;Output:
 ;  SEG (pass-by-reference) The segment, returned as a list of fields.
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"EVN",0) ;Set the segment type.
 ;
 ;Set Appointment Date into EVN-2 (Fileman date format) and EVN-3 (HL7 date format)
 D SET^HLOAPI(.SEG,APPT("APPOINTMENT DATE"),2)
 D SETDT^HLOAPI4(.SEG,APPT("APPOINTMENT DATE"),3)
 ;
 ;get appointment Status/type info
 N PARAM
 S PARAM(1)=APPT("APPOINTMENT DATE")_";"_APPT("APPOINTMENT DATE")
 S PARAM("FLDS")="1;2;4;10;22"
 S PARAM(4)=APPT("DFN")
 N APPTCNT S APPTCNT=$$SDAPI^SDAMA301(.PARAM)
 N TMP S TMP=$G(^TMP($J,"SDAMA301",APPT("DFN"),APPT("CLINIC"),APPT("APPOINTMENT DATE")))
 ;
 I TMP'="" D
 . ;Set appointment Status IEN into EVN-4
 . N STATUS S STATUS=$P(TMP,U,22)
 . D SET^HLOAPI(.SEG,$P(STATUS,";"),4) ;appointment status ien
 . ;
 . ;Set Status (Display) into EVN-5, component 1
 . D SET^HLOAPI(.SEG,$P(STATUS,";",3),5,1) ;Appointment Print Status (what is displayed)
 . ;
 . ;Set appointment type IEN/name into ENV-5, component 4 and 5
 . N ATYPE S ATYPE=$P(TMP,U,10)
 . D SET^HLOAPI(.SEG,$P(ATYPE,";"),5,4) ;appointment type ien
 . D SET^HLOAPI(.SEG,$P(ATYPE,";",2),5,5) ;appointment type name
 ;
 ;Set the Clinic IEN/Name into ENV-5, component 2 and 3
 D SET^HLOAPI(.SEG,APPT("CLINIC"),5,2)
 D SET^HLOAPI(.SEG,APPT("CLINIC NAME"),5,3)
 ;
 ;Set comments/cancellation remarks into ENV-6
 N IENS S IENS=APPT("APPOINTMENT DATE")_","_APPT("DFN")_","
 N APPTOUT D GETS^DIQ(2.98,IENS,"17","IE","APPTOUT")
 N APPTCMTS S APPTCMTS=$G(APPTOUT(2.98,IENS,17,"I"))
 K APPTOUT
 I APPTCMTS'="" D SET^HLOAPI(.SEG,APPTCMTS,6,1) ;cancellation remarks
 ;
 QUIT
 ;
PID(DFN,SEG) ; -- generate PID segment
 ;
 ;Description:
 ; Builds the PID segment using the HLO segment building APIs.
 ; PIMS APIs are called to obtain data from PATIENT file (#2).
 ;
 ; The fields that are included in the segment are:
 ;  PID-1 Always set to '1'
 ;  PID-2 Patient DFN, Station#, unused, Assigning Authority code
 ;  PID-4 Sensitive flag
 ;  PID-11 BadAddressID_BadAddressName
 ;  PID-13 unused, unused, unused, unused, Patient Email Address
 ;  PID-19 patient SSN
 ;
 ;Input:
 ; DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) The segment, returned as a list of fields.
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"PID",0) ;Set the segment type.
 D SET^HLOAPI(.SEG,1,1) ;Set PID-1.
 ;
 ; -- Set dfn to PID-2, component 1
 D SET^HLOAPI(.SEG,DFN,2,1)
 ;
 ; -- Set station number to PID-2, component 2
 N STATION S STATION=$E($P($$NS^XUAF4($$KSP^XUPARAM("INST")),U,2),1,3) ; station number
 D SET^HLOAPI(.SEG,STATION,2,2)
 ;
 ; -- Set As Assigning Authority code to PID-2, component 4
 D SET^HLOAPI(.SEG,"USVHA",2,4)
 ; 
 ; -- Set Sensitive to PD1-4
 N VPSARR D SENLOG^VPSRPC16(.VPSARR,DFN)
 N SENS S SENS=$P($G(VPSARR(1)),U,4)
 D:SENS'="" SET^HLOAPI(.SEG,SENS,4)
 ;
 ; -- Set Patient Name  to PD1-5
 N RES D GETS^DIQ(2,DFN_",",".01;.09;.133","E","RES")
 N PATNAM S PATNAM=$G(RES(2,DFN_",",.01,"E"))
 N NAMPARSE S NAMPARSE=$$NAMPARSE(PATNAM)
 D SET^HLOAPI(.SEG,$P(NAMPARSE,U),5,1) ;Last name
 D SET^HLOAPI(.SEG,$P(NAMPARSE,U,2),5,2) ;First name
 D SET^HLOAPI(.SEG,$P(NAMPARSE,U,3),5,3) ;Initial
 ;
 ; -- Set Bad Address Indicator to PD1-11, component 2
 N BADADR S BADADR=$$BADADR^DGUTL3(DFN)
 I BADADR'="" D
 . N BADADRNM S BADADRNM=""
 . I BADADR=1 S BADADRNM="UNDELIVERABLE"
 . I BADADR=2 S BADADRNM="HOMELESS"
 . I BADADR=3 S BADADRNM="OTHER"
 . D SET^HLOAPI(.SEG,BADADR_"_"_BADADRNM,11,2)
 ;
 ; -- Set Patient Email information to PID-13, component 5
 N EMAIL S EMAIL=$G(RES(2,DFN_",",.133,"E"))
 D:EMAIL'="" SET^HLOAPI(.SEG,EMAIL,13,5)
 ;
 ; -- Set Social Security Number to PID-19
 N SSN S SSN=$G(RES(2,DFN_",",.09,"E"))
 D SET^HLOAPI(.SEG,SSN,19)
 ;
 QUIT
 ;
PV1(DFN,SEG,ERR) ; -- Patient Visit segment for patient record Flags
 ;
 ;Description:
 ; Builds the PV1 segment using the HLO segment building APIs.
 ;
 ; The fields that are included in the segment are:
 ;  PV1-1 PRF number (1..n)
 ;  PV1-2 Always set to 'U' - Unknown
 ;  PV1-5 Record flags: Flag Origin(national/local), Flag Type, unused, Flag Name
 ;
 ;Input:
 ;  DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) The segment, returned as a list of fields.
 ;  ERR (pass-by-reference) Error Message
 ;
 ; -- Set Balance to PV1-26 for the first flag only
 K SEG S SEG="" ;The segment should start off blank.
 K VPSARR D BAL^VPSRPC26(.VPSARR,DFN)
 N BAL S BAL=$P($G(VPSARR(1)),U,4)
 D:BAL'="" SET^HLOAPI(.SEG,BAL,26)
 ;
 ; -- Set patient record flags to PV1-5
 N PRFLAGS D GETPRF^VPSAPPT(DFN,.PRFLAGS)
 N IDX,NARR,NARRTXT
 N OK S OK=1
 N PRF,CNT S CNT=$O(PRFLAGS("PRF",""),-1)
 S:CNT="" CNT=1
 ;
 F PRF=1:1:CNT D  Q:'OK
 . D SET^HLOAPI(.SEG,"PV1",0) ;Set the segment type.
 . D SET^HLOAPI(.SEG,PRF,1) ;Set PV1-1
 . D SET^HLOAPI(.SEG,"U",2) ;Set PV1-2 to Unknown
 . I $D(PRFLAGS("PRF",PRF)) D
 . . D SET^HLOAPI(.SEG,$G(PRFLAGS("PRF",PRF,"FLAG ORIGINATION")),5,1) ;Flag From (National/Local)
 . . D SET^HLOAPI(.SEG,$G(PRFLAGS("PRF",PRF,"FLAG TYPE")),5,2) ;Flag Type
 . . D SET^HLOAPI(.SEG,$G(PRFLAGS("PRF",PRF,"FLAG NAME")),5,4) ;Flag Name
 . S OK=$$ADDSEG^HLOAPI(.MSG,.SEG,.ERR)
 ;
 QUIT OK
 ;
ZEN(DFN,SEG) ; -- generate ZEN segment (VA Enrollment)
 ;
 ;Description:
 ; Builds the ZEN segment using the HLO segment building APIs.
 ;
 ; The fields that are included in the segment are:
 ;  ZEN-1  Always set to '1'
 ;  ZEN-4  Enrollment Status
 ;  ZEN-10 Pre-Registration Date Changed
 ;
 ;Input:
 ;  DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) The segment, returned as a list of fields.
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"ZEN",0) ;Set the segment type.
 D SET^HLOAPI(.SEG,1,1) ;Set ZEN-1.
 ;
 ; -- Set Enrollment Status to ZEN-4
 N ENRIEN S ENRIEN=$O(^DGEN(27.11,"C",DFN,""),-1)
 I ENRIEN D
 . N DFENR D GET^DGENA(ENRIEN,.DGENR)
 . N ENRSTAT S ENRSTAT=$G(DGENR("STATUS"))
 . I ENRSTAT'="" D
 . . N ESNAME S ESNAME=$$GET1^DIQ(27.11,ENRIEN_",",.04,"E")
 . . D SET^HLOAPI(.SEG,ENRSTAT,4,1)
 . . D SET^HLOAPI(.SEG,ESNAME,4,2)
 ;
 ; -- Set Pre-Registration Date Changed TO ZEN-10 (Fileman Date) and ZEN-11 (HL7 Date)
 K VPSARR D DGS^VPSRPC26(.VPSARR,DFN)
 N PRDT S PRDT=$P($G(VPSARR(1)),U,4)
 I PRDT'="" D
 . D SET^HLOAPI(.SEG,PRDT,10,1)
 . D SETDT^HLOAPI4(.SEG,PRDT,11,2)
 ;
 QUIT
 ;
ZEL(VAEL,SEG) ; -- generate ZEL segment (VA Patient Eligibility)
 ;
 ;Description:
 ; Builds the ZEL segment using the HLO segment building APIs.
 ;
 ; The fields that are included in the segment are:
 ;  ZEL-1   Always set to '1'
 ;  ZEL-2   Eligibility Code
 ;  ZEL-4   Eligibility Status
 ;  ZEL-11  Ineligible date (Fileman format)
 ;  ZEL-12  Ineligible date (HL7 format)
 ;
 ;Input:
 ; DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) The segment, returned as a list of fields.
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"ZEL",0) ;Set the segment type.
 D SET^HLOAPI(.SEG,1,1) ;Set ZEL-1.
 ;
 ; -- Set Primary Eligibility Code to ZEL-2
 N ELIGSTAT S ELIGSTAT=$P($G(VAEL(8)),U)
 D:ELIGSTAT'="" SET^HLOAPI(.SEG,ELIGSTAT,2)
 ;
 ; -- Set Eligibility Status to ZEL-4
 S ELIGSTAT=$P($G(VAEL(8)),U,2)
 D:ELIGSTAT'="" SET^HLOAPI(.SEG,ELIGSTAT,4)
 ;
 ; -- Set Ineligible date to ZEL-11 (Fileman Date) and ZEL-12 (HL7 date)
 N IELIGDT S IELIGDT=$P($G(VAEL(5,1)),U)
 I IELIGDT'="" D
 . D SET^HLOAPI(.SEG,IELIGDT,11)
 . D SETDT^HLOAPI4(.SEG,IELIGDT,12)
 ;
 QUIT
 ;
ZMT(VAEL,SEG) ; -- generate ZMT segment (VA Means Test)
 ;
 ;Description:
 ; Builds the ZMT segment for the Mean Test using the HLO segment building APIs. 
 ;
 ; The fields included in the segment are:
 ;  ZMT-1   Always set to '1'
 ;  ZMT-3  Mean Test Status
 ;
 ;Input:
 ;  DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) Will return an array containing the segment.
 ;    The ADDSEG^HLOAPI API must be called to move the segment into
 ;    the message. 
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"ZMT",0) ;Set the segment type.
 D SET^HLOAPI(.SEG,1,1) ;Set ZMT-1.
 ;
 ; -- Set means test status to ZMT-3
 N MTS S MTS=$P($G(VAEL(9)),U,2)
 D:MTS'="" SET^HLOAPI(.SEG,MTS,3)
 ;
 QUIT
 ;
IN1(DFN,SEG) ; -- generate IN1 segment (Insurance Information)
 ;
 ;Description:
 ; Builds the IN1 segment for the Insurance information using the HLO segment building APIs. 
 ;
 ; The fields included in the segment are:
 ;  IN1-1   Always set to '1'
 ;  IN1-2   Patient Insured (Y or N)
 ;
 ;Input:
 ;  DFN (required) The IEN of the record in the PATIENT file (#2).
 ;
 ;Output:
 ;  SEG (pass-by-reference) Will return an array containing the segment.
 ;    The ADDSEG^HLOAPI API must be called to move the segment into
 ;    the message. 
 ;
 K SEG S SEG="" ;The segment should start off blank.
 ;
 ; -- Use the HLO APIs to set the data into the segment.
 D SET^HLOAPI(.SEG,"IN1",0) ;Set the segment type.
 D SET^HLOAPI(.SEG,1,1) ;Set IN1-1.
 ;
 ; -- Set Insurance (true/false) to IN1-2
 K VPSARR D IBB^VPSRPC26(.VPSARR,DFN) ; Insurance Info
 N INS S INS=$P($G(VPSARR(1)),U,4)
 S INS=$S(INS'="":"Y",1:"N")
 D SET^HLOAPI(.SEG,INS,2)
 ;
 QUIT
 ;
NAMPARSE(VNAME) ;  return name components for standard VistA name
 ;Return LastName^FirstName^Middle^Suffix/Title
 ;       on error - return ""
 QUIT:$G(VNAME)="" ""
 D STDNAME^XLFNAME(.VNAME,"CF")
 N RET S RET=""
 N FLD F FLD="FAMILY","GIVEN","MIDDLE" S RET=RET_$G(VNAME(FLD))_U
 S:$L(RET) RET=$E(RET,1,$L(RET)-1)
 QUIT RET
