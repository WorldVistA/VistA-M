DGENQRY1 ;ALB/CJM - API for ENROLLMENT QUERIES (continued); 4-SEP-97 ; 5/14/02 9:57am
 ;;5.3;REGISTRATION;**147,232,363,472,989**;Aug 13,1993;Build 5
 ;
BATCH ;
 ;Description:  This procedure will re-send all queries still outstanding
 ;with status of TRANSMITTED with QUERY DT/TM of more than 2 days in the
 ;past. 
 ;
 ;Input:
 ;  None
 ;Output:  
 ;  The ENROLLMENT QUERY LOG file is updated with all the query activity. New queries to HEC are generated where necessary.
 ;
 N QRY,DATE
 S DATE=$$FMADD^XLFDT(DT,-2)
 F  S DATE=$O(^DGEN(27.12,"ADS",DATE),-1) Q:'DATE  D
 .S QRY=0
 .F  S QRY=$O(^DGEN(27.12,"ADS",DATE,QRY)) Q:'QRY  D
 ..I '$$RESEND(QRY) ;then something went wrong, but continue
 Q
 ;
RECEIVE(IEN,ERRORMSG,RMSGID) ;
 ;Description: This function will update the query log to show status
 ;RECEIVED. If the NOTIFY field is contains a user to notify, it will
 ;also send the notification message.
 ;Input:
 ;  IEN - internal entry number of a record in the ENROLLMENT QUERY LOG
 ;  ERRORMSG - error message to include in notification (optional)
 ;  RMSGID - message id from the response
 ;
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;
 N SUCCESS,DGQRY,DATA,IEN2,DGQRY2
 S SUCCESS=0
 ;
 D
 .Q:'$G(IEN)
 .Q:'$$GET^DGENQRY(IEN,.DGQRY)
 .;
 .;try to get a lock, but proceed anyway
 .I $$LOCK^DGENQRY(DGQRY("DFN"))
 .;
 .;if the query was retransmitted, then update the status of the patient's last query
 .I DGQRY("STATUS")=2 D
 ..S IEN2=$$FINDLAST^DGENQRY(DGQRY("DFN"))
 ..Q:'IEN2
 ..Q:'$$GET^DGENQRY(IEN2,.DGQRY2)
 ..I DGQRY2("FIRST")=DGQRY("FIRST") S IEN=IEN2 M DGQRY=DGQRY2
 .;
 .S DATA(.03)=$S($L($G(ERRORMSG)):4,1:3)
 .S DGQRY("STATUS")=DATA(.03)
 .S DATA(.06)=$$NOW^XLFDT
 .S DGQRY("RESPONSE")=DATA(.06)
 .S DATA(1)=$G(ERRORMSG)
 .S DATA(.07)=$G(RMSGID)
 .S DGQRY("RESPONSEID")=DATA(.07)
 .S DGQRY("ERROR")=DATA(1)
 .Q:'$$UPD^DGENDBS(27.12,IEN,.DATA)
 .;
 .I DGQRY("NOTIFY") I '$$NOTIFY(.DGQRY)
 .;
 .S SUCCESS=1
 ;
 D:$G(DGQRY("DFN")) UNLOCK^DGENQRY(DGQRY("DFN"))
 Q SUCCESS
 ;
NOTIFY(DGQRY) ;
 ;Description: send notification of reply received for enrollment query.
 ;
 ;Input:
 ;  DGQRY() - array containing the ENROLLMENT QUERY LOG record (pass by reference)
 ;
 ;Output:
 ;  Function Value: 1 on success, 0 on failure
 ;
 N PATIENT,TEXT,XMDUZ,XMTEXT,XMSUB,XMSTRIP,XMROU,XMY,XMZ,XMDF
 Q:'$$GET^DGENPTA($G(DGQRY("DFN")),.PATIENT) 0
 ;
 S XMDF=""
 S (XMDUN,XMDUZ)="Registration Enrollment Module"
 S XMSUB="Enrollment/Eligibility Query Reply: "_PATIENT("NAME")
 S XMY(DGQRY("NOTIFY"))=""
 S XMTEXT="TEXT("
 S TEXT(1)="A reply to the enrollment/eligibility query that you sent has been received."
 S TEXT(2)="  "
 S TEXT(3)="Patient Name   :     "_PATIENT("NAME")
 S TEXT(4)="SSN            :     "_PATIENT("SSN")
 S TEXT(5)="Query Date/Time:     "_$$FMTE^XLFDT(DGQRY("FIRST"),"1")
 S TEXT(6)="Query Status   :     "_$$EXTERNAL^DILFD(27.12,.03,"F",DGQRY("STATUS"))
 ;
 I $L(DGQRY("ERROR")) D
 .S TEXT(7)=" "
 .S TEXT(8)="The following problem was encountered:"
 .S TEXT(9)=" "
 .S TEXT(10)=DGQRY("ERROR")
 ;
 D ^XMD
 Q 1
 ;
CLOSE(IEN,ERROR) ;
 ;Description:  This function can be used to change a query with status
 ;of TRANSMITTED to a status of CLOSED. This will prevent retransmission.
 ;It can be used, for example, when an unsolicited enrollment message is
 ;received while a query is still outstanding.
 ;Input:
 ;  IEN: The ien of a record in the ENROLLMENT QUERY LOG file.
 ;
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;  ERROR - if unsuccessful, returns an error message (optional, pass by reference)
 ;
 N SUCCESS,DGQRY,DATA
 S SUCCESS=0
 S ERROR=""
 ;
 D
 .I '$G(IEN) S ERROR="ENTRY IN ENROLLMENT QUERY LOG DOES NOT EXIST" Q
 .Q:'$$GET^DGENQRY(IEN,.DGQRY)
 .I '$$LOCK^DGENQRY(DGQRY("DFN")) S ERROR="UNABLE TO LOCK ENROLLMENT QUERY LOG" Q
 .I DGQRY("STATUS") S ERROR="QUERY STATUS IS NOT TRANSMITTED" Q
 .;
 .S DATA(.03)=1
 .I '$$UPD^DGENDBS(27.12,IEN,.DATA,.ERROR) S ERROR="UNABLE TO UPDATE ENROLLMENT QUERY LOG WITH NEW STATUS" Q
 .;
 .S SUCCESS=1
 ;
 D UNLOCK^DGENQRY(DGQRY("DFN"))
 Q SUCCESS
 ;
RESEND(IEN,ERROR) ;
 ;Description:  Used to re-send an outstanding query.
 ;Input:
 ;  IEN - ien of a record in the ENROLLMENT QUERY LOG.  It identifies the query to be re-sent.
 ;Output:
 ;  Function Value - 1 if successful, 0 otherwise.
 ;  ERROR - if unsuccessful returns a mssg (pass by reference, optional)
 ;
 N SUCCESS,DGQRY,DATA
 S SUCCESS=0
 S ERROR=""
 ;
 D
 .I '$G(IEN) S ERROR="ENTRY IN ENROLLMENT QUERY LOG DOES NOT EXIST" Q
 .Q:'$$GET^DGENQRY(IEN,.DGQRY)
 .I '$$LOCK^DGENQRY(DGQRY("DFN")) S ERROR="UNABLE TO LOCK ENROLLMENT QUERY LOG" Q
 .I DGQRY("STATUS") S ERROR="QUERY STATUS IS NOT TRANSMITTED" Q
 .S DATA(.03)=2
 .I '$$UPD^DGENDBS(27.12,IEN,.DATA,.ERROR) S ERROR="UNABLE TO UPDATE ENROLLMENT QUERY LOG WITH NEW STATUS" Q
 .I '$$SEND(DGQRY("DFN"),DGQRY("NOTIFY"),DGQRY("FIRST"),.ERROR) Q
 .S SUCCESS=1
 ;
 D UNLOCK^DGENQRY(DGQRY("DFN"))
 Q SUCCESS
 ;
SEND(DFN,NOTIFY,FIRST,ERROR) ;
 ;Description: This function is used to send an ENROLLMENT/ELIGIBILITY
 ;QUERY to HEC for a particular patient.
 ;
 ;Input:
 ;  DFN - the patient for whom to send the query
 ;  NOTIFY - who should receive notification when the query reply is
 ;           received.  Is a pointer to the NEW USER file.  (Optional)
 ;  FIRST - DATE/TIME to enter to the FIRST DT/TIME field of the
 ;          ENROLLMENT QUERY LOG file (Optional)
 ;
 ;Output: 
 ;  Function Value - 1 on success, 0 on failure.
 ;  ERROR - if unsuccessful, this variable will return an error message, (pass by reference) (optional)
 ;
 ; quit if enrollment transmit query to HEC switch is off
 I '$$ON^DGENQRY Q 0
 ;
 N LAST,DGQRY,MSGID,SUCCESS,SENT
 ;
 S SUCCESS=1
 I '$$LOCK^DGENQRY($G(DFN)) S SUCCESS=0,ERROR="UNABLE TO LOCK ENROLLMENT QUERY LOG"
 S LAST=$$FINDLAST^DGENQRY(DFN)
 I SUCCESS,LAST,$$GET^DGENQRY(LAST,.DGQRY),'DGQRY("STATUS") S SUCCESS=0,ERROR="ENROLLMENT/ELIGIBILITY QUERY ALREADY SENT"
 D:SUCCESS
 .S SENT=$$MSG(DFN,.MSGID,.ERROR)
 .I 'SENT S SUCCESS=0 Q
 .S DGQRY("DFN")=DFN
 .S DGQRY("SENT")=SENT
 .S DGQRY("STATUS")=0
 .S DGQRY("MSGID")=MSGID
 .S DGQRY("NOTIFY")=$G(NOTIFY)
 .S DGQRY("FIRST")=$S($G(FIRST):FIRST,1:SENT)
 .S DGQRY("RESPONSE")=""
 .S DGQRY("RESPONSEID")=""
 .I '$$LOG^DGENQRY(.DGQRY) S SUCCESS=0,ERROR="UNABLE TO ENTER QUERY TO ENROLLMENT QUERY LOG" Q
 .;
SENDQ ;
 D UNLOCK^DGENQRY($G(DFN))
 Q SUCCESS
 ;
MSG(DFN,MSGID,ERROR) ; Send enrollment/eligibility query to HEC
 ;
 ;Input:
 ;  DFN - Pointer to the patient in file #2
 ;Output
 ;  Function Value - if successful, returns 1, otherwise returns 0
 ;  MSGID - if successful, returns the message id assigned by the HL7 package (pass by reference)
 ;  ERROR - if unsuccessful,returns an error message (pass by reference) 
 ;
 N HLSDT,HLMTN,HLDAP,HLEVN,HLERR,HLDA,HLDAN,HLDT,HLDT1,HLECH,HLFS,HLNDAP,HLNDAP0,HLPID,HLQ,HLVER,HLMID,SUCCESS,DGPAT
 N HL,HLARYTYP,HLFORMAT,HLRESLT
 ;
 K HLA("HLS")                                            ;DG*5.3.472
 S SUCCESS=0
 ;
 ; - init HL7 variables
 S HLMTN="QRY"
 S HLDAP="IVM"
 S HLEID="VAMC "_$P($$SITE^VASITE,"^",3)_" QRY-Z11 SERVER"
 S HLEID=$O(^ORD(101,"B",HLEID,0))
 D INIT^HLFNC2(HLEID,.HL)
 I $G(HL)]"" S HLERR=$P(HL,"^",2)
 I '$D(HLERR) D CREATE^HLTF(.HLMID,.HLMTIEN,.HLDT,.HLDT1)
 S HLEVN=0 ; initialize event counter
 S HLSDT=$$NOW^XLFDT
 I $D(HLERR) S ERROR=HLERR G MSGQ
 ;
 I '$$GET^DGENPTA(DFN,.DGPAT) S ERROR="PATIENT NOT FOUND" G MSGQ
 I (DGPAT("SEX")="") S ERROR="PATIENT SEX IS REQUIRED" G MSGQ
 I (DGPAT("DOB")="") S ERROR="PATIENT DATE OF BIRTH IS REQUIRED" G MSGQ
 I (DGPAT("SSN")="") S ERROR="PATIENT SSN IS REQUIRED" G MSGQ
 ;
 ; - build HL7 query (QRY) msg and send
 D QRD,QRF
 S HLARYTYP="LM"                                         ;DG*5.3*472
 S HLFORMAT=1
 D GENERATE^HLMA(HLEID,HLARYTYP,HLFORMAT,.HLRESLT)
 I $P($G(HLRESLT),"^",2)]"" S HLERR=$P(HLRESLT,"^",3)
 I $D(HLERR) S ERROR=HLERR G MSGQ
 S SUCCESS=HLSDT
 ;
 S MSGID=+HLRESLT
 ;
MSGQ ; - exit and clean-up
 D KILL^HLTRANS
 K HLA("HLS")                                            ;DG*5.3*472
 Q SUCCESS
 ;
QRD ; Build (HL7) QRD segment for patient
 N QUERY,DGICN
 S DGICN=$$GETICN^MPIF001(DFN) ;DBIA- #2070
 S $P(QUERY,HLFS,1)=$$HLDATE^HLFNC(HLDT) ; date/time query generated
 S $P(QUERY,HLFS,2)="R" ; query format code (record oriented format)
 S $P(QUERY,HLFS,3)="I" ; query priority (immediate)
 S $P(QUERY,HLFS,4)=DFN_$E(HL("ECH"),1)_$G(DGICN) ; query ID (DFN), Patient ICN#
 S $P(QUERY,HLFS,7)="1~RD" ; quanity limited request (1 record)
 S $P(QUERY,HLFS,8)=DGPAT("SSN") ; who subject filter (SSN)
 S $P(QUERY,HLFS,9)="OTH" ; what subject filter
 S $P(QUERY,HLFS,10)="ENROLLMENT" ;What department data code
 S $P(QUERY,HLFS,12)="T" ; query results level (full results)
 S HLA("HLS",1)="QRD"_HLFS_QUERY                         ;DG*5.3*472
 Q
 ;
 ;
QRF ; Build HL7 (QRF) segment for patient
 N FILTER
 S $P(FILTER,HLFS,1)="IVM" ; where subject filter (IVM Center)
 S $P(FILTER,HLFS,4)=$$HLDATE^HLFNC(DGPAT("DOB")) ; what user qualifier (DOB)
 S $P(FILTER,HLFS,5)=DGPAT("SEX") ; other subj. query filter (sex)
 S HLA("HLS",2)="QRF"_HLFS_FILTER                        ;DG*5.3*472
 Q
