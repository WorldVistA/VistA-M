DGHTRTX ;ALB/JRC - Home Telehealth HL7 Message Monitoring Routine ;10 January 2005 ; 9/14/06 12:52pm
 ;;5.3;Registration;**644**;Aug 13, 1993;Build 11
 ;
 ;This routine when tasked will run at predetermined time intervals
 ;and check to see if there are any HTH HL7 messages that have not
 ;received an application acknowledgment. If it finds messages that
 ;have not received AAs, it will retransmit the HL7 messages up to the
 ;number of times defined in the "DG HTH # OF RETRANSMITS" parameter.
 ;If no AA is received after the 5th try an alert is sent to the
 ;DGHTERR mailgroup. After the 5th try an extended wait time is used
 ;(12 hours) and the process starts a new.
 ;
EN ;entry point from tasked option, $O thru home telehealth file
 ;(#391.31) "HTHNOACK" xref and find mnessages to retransmit
 N MSGID,NODE,STATUS,RECORD,TRANS,TYPE,ERROR,RETRANS,DTIME,XTIME
 N DGCOUNT,DGDATE,CNT
 S (MSGID,NODE,TRANS,ERROR)="",TYPE=1,CNT=0
 K ^TMP($J,"DGHT")
 ;Get number of allowed retransmissions from parameter file
 S RETRANS=$$GET^XPAR("SYS","DG HTH # OF RETRANSMITS")
 ;Get time interval parameters, convert them to seconds
 S DTIME=$$GET^XPAR("SYS","DG HTH DEFAULT WAIT TIME")*60
 S XTIME=$$GET^XPAR("SYS","DG HTH EXTENDED WAIT TIME")*60
 ;Resolve record to update using MSGID cross reference
 F  S MSGID=$O(^DGHT(391.31,"HTHNOACK",MSGID)) Q:MSGID=""  D
 .S RECORD=$O(^DGHT(391.31,"D",MSGID,0)) Q:'RECORD
 .S TRANS=$O(^DGHT(391.31,"D",MSGID,RECORD,0)) Q:'TRANS
 .S NODE=$G(^DGHT(391.31,"HTHNOACK",MSGID,RECORD,TRANS))
 .Q:NODE=""
 .S DGCOUNT=$P(NODE,U,1),DGDATE=$P(NODE,U,2)
 .;Check outgoing message status
 .;               0 = message doesn't exist
 .;               1 = waiting in queue
 .;             1.5 = opening connection
 .;             1.7 = awaiting response, # of retries
 .;               2 = awaiting application ack
 .;               3 = successfully completed
 .;               4 = error
 .;               8 = being generated
 .;               9 = awaiting processing
 .S STATUS=+$$MSGSTAT^HLUTIL(MSGID)
 .;If status=3 kill xref and quit
 .I STATUS=3 D KILLXREF^DGHTXREF(MSGID) Q
 .D CHKMSG
 I $O(^TMP($J,"DGHT",0)) D MESSAGE K ^TMP($J)
 Q
 ;
RTX ;Retransmit message
 N X,DGDATE
 S X=$$MSGACT^HLUTIL(MSGID,2)
 ;Update counter and trans date
 S DGDATE=$$NOW^XLFDT()
 D SETXREF^DGHTXREF(MSGID,1,1)
 Q
 ;
MESSAGE ;Build bulletin and send to mail group
 ;      Input: Home telehealth patient record
 ;      Output:
 ;
 N MSGTEXT,XMTEXT,XMSUB,XMY,XMCHAN,XMZ,XMDUZ,MSGTYPE,NODE0,NODE1
 N RECORD,TNODE
 ;Get records from ^tmp global
 S (RECORD,CNT)=0 F  S RECORD=$O(^TMP($J,"DGHT",RECORD)) Q:'RECORD  D
 .S TRANS=0 F  S TRANS=$O(^TMP($J,"DGHT",RECORD,TRANS)) Q:'TRANS  D
 ..S TNODE=^TMP($J,"DGHT",RECORD,TRANS)
 ..S MSGID=$P(TNODE,U,2),ERROR=$P(TNODE,U,2)
 ..;Get 0th node and trans nodes
 ..S NODE0=$G(^DGHT(391.31,RECORD,0))
 ..S NODE1=$G(^DGHT(391.31,RECORD,"TRAN",TRANS,0)),MSGTYPE=$P(NODE1,U,4)
 ..S MSGTYPE=$S(MSGTYPE="A":"Sign-up/Activation",MSGTYPE="I":"Inactivation",1:""),CNT=CNT+1
 ..S MSGTEXT(CNT)="Home Telehealth "_MSGTYPE_" was REJECTED",CNT=CNT+1
 ..S MSGTEXT(CNT)=" ",CNT=CNT+1
 ..S MSGTEXT(CNT)="Date:       "_$$FMTE^XLFDT($$NOW^XLFDT(),1),CNT=CNT+1
 ..S MSGTEXT(CNT)="Patient:    "_$$GET1^DIQ(2,$P(NODE0,U,2),.01,"E")
 ..S CNT=CNT+1,MSGTEXT(CNT+1)="Message ID: "_MSGID,CNT=CNT+1
 ..S MSGTEXT(CNT)="Error Code: "_ERROR,CNT=CNT+1
 ..S MSGTEXT(CNT)="",CNT=CNT+1
 ;Send message to mail group
 S XMSUB="Home Telehealth Patient "_MSGTYPE_" Reject"
 S XMTEXT="MSGTEXT("
 S XMY("G.DGHTERR")=""
 S XMCHAN=1
 S XMDUZ="Home Telehealth Patient "_MSGTYPE
 D ^XMD
 Q
 ;
CHKMSG ;Check message for retransmission
 N DIFF
 S DIFF=$$FMDIFF^XLFDT($$NOW^XLFDT(),DGDATE,2)
 I DGCOUNT<RETRANS D  Q
 .I DIFF>DTIME D RTX I (DGCOUNT+1)=RETRANS D  Q
 ..S ERROR=$S('STATUS:"HL7 MESSAGE DOES NOT EXIST. REQUIRES MANUAL RETRANSMISSION",1:"DEFAULT MAXIMUM RETRANSMISSIONS REACHED")
 ..S ^TMP($J,"DGHT",RECORD,TRANS)=MSGID_U_ERROR
 I DIFF>XTIME S DGCOUNT=0 D RTX Q
 Q
