HLOAPP ;ALB/CJM-HL7 -Application Registry ;02/23/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,132,137,139,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GETIEN(NAME) ;given the application name, it finds the ien.  Returns 0 on failure
 Q:'$L($G(NAME)) 0
 Q +$O(^HLD(779.2,"C",$E(NAME,1,60),0))
 ;
ACTION(HEADER,ACTION,QUEUE) ;Given the parsed header of a message it returns both the action that should be performed in response to the message and the incoming queue that it should be placed on.
 ;
 ;** do not implement the Pass Immediate parameter **
 ;ACTION(HEADER,ACTION,QUEUE,IMMEDIATE);Given the parsed header of a message it returns both the action that should be performed in response to the message and the incoming queue that it should be placed on.
 ;
 ;Input:
 ;  HEADER() subscripts are used: "RECEIVING APPLICATION","SEGMENT TYPE", "MESSAGE TYPE", "EVENT", "VERSION"
 ;Output:
 ;  Function returns 1 on success, 0 on failure
 ;  ACTION (pass by reference) <tag>^<rtn>
 ;  QUEUE (pass by reference) returns the named queue if there is one, else "DEFAULT"
 ;
 ;** do not implement the Pass Immediate parameter **
 ;  IMMEDIATE (pass by reference, optional) returns 1 if the application wants its messages passed to the incoming queue immediately, 0 otherwise
 ;
 N IEN
 S (ACTION,QUEUE)=""
 S IEN=$$GETIEN(HEADER("RECEIVING APPLICATION"))
 Q:'$G(IEN) 0
 I $G(HEADER("SEGMENT TYPE"))="BHS" D
 .S NODE=$G(^HLD(779.2,IEN,0))
 .I $P(NODE,"^",5)]"" D
 ..S ACTION=$P(NODE,"^",4,5)
 .E  I $P(NODE,"^",7)]"" S ACTION=$P(NODE,"^",6,7)
 .I $P(NODE,"^",8)]"" D
 ..S QUEUE=$P(NODE,"^",8)
 .E  I $P(NODE,"^",3)]"" S QUEUE=$P(NODE,"^",3)
 E  I HEADER("SEGMENT TYPE")="MSH" D
 .I HEADER("MESSAGE TYPE")'="",HEADER("EVENT")'="" D
 ..N SUBIEN,NODE
 ..;did the application specify an action for the particular version of this message?
 ..I HEADER("VERSION")'="" S SUBIEN=$O(^HLD(779.2,IEN,1,"D",HEADER("MESSAGE TYPE"),HEADER("EVENT"),HEADER("VERSION"),0))
 ..;if not, look on the "C" index
 ..S:'$G(SUBIEN) SUBIEN=$O(^HLD(779.2,IEN,1,"C",HEADER("MESSAGE TYPE"),HEADER("EVENT"),0))
 ..;
 ..I SUBIEN D
 ...S NODE=$G(^HLD(779.2,IEN,1,SUBIEN,0))
 ...I $P(NODE,"^",5)]"" S ACTION=$P(NODE,"^",4,5)
 ...I $P(NODE,"^",3)]"" S QUEUE=$P(NODE,"^",3)
 ...;
 ...;** do not implement the Pass ImMediate parameter **
 ...;S IMMEDIATE=$P(NODE,"^",8)
 ...;
 ..I ACTION="" S NODE=$G(^HLD(779.2,IEN,0)) I $P(NODE,"^",7)]"" S ACTION=$P(NODE,"^",6,7)
 ..I QUEUE="" S NODE=$G(^HLD(779.2,IEN,0)) I $P(NODE,"^",3)]"" S QUEUE=$P(NODE,"^",3)
 I QUEUE="" S QUEUE="DEFAULT"
 ;
 ;** do not implement the Pass Immediate parameter **
 ;I $G(IMMEDIATE)'=1 S IMMEDIATE=0
 ;
 I ACTION="" Q 0
 Q 1
 ;
RTRNLNK(APPNAME) ;
 ;given the name of a receiving application, this returns the return
 ;link for application acks if one is provided.  Otherwise, return
 ;acks are routed based on the information provide in the message hdr
 ;
 Q:(APPNAME="") ""
 N IEN
 S IEN=$$GETIEN(APPNAME)
 Q:IEN $P($G(^HLD(779.2,IEN,0)),"^",2)
 Q ""
 ;
RTRNPORT(APPNAME) ;
 ;Given the name of the sending application, IF the application has its
 ;own listener, its port # is returned.  Application acks should be
 ;returned using that port
 Q:(APPNAME="") ""
 N IEN,LINK
 S IEN=$$GETIEN(APPNAME)
 Q:'IEN ""
 S LINK=$P($G(^HLD(779.2,IEN,0)),"^",9)
 Q:'LINK ""
 Q $$PORT^HLOTLNK(LINK)
 ;
ACTIVE(APP,MSGTYPE,EVENT,VERSION) ;
 ;Returns 1 if the message's INACTIVE flag has NOT been set.
 ;
 ;Input:
 ;  APP (required) the name of the sending application
 ;  MSGTYPE (required) 3 character HL7 message type
 ;  EVENT (required) 3 character HL7 event
 ;  VERSION (optional) HL7 version ID as it appears in the message header
 ;Output:
 ;  Function returns 1 if the message type specified by the input parameters has not been set to INACTIVE.  It returns 0 otherwise.
 ;
 N IEN,ACTIVE,SUBIEN
 S ACTIVE=1
 S IEN=$$GETIEN($G(APP))
 Q:'$G(IEN) ACTIVE
 Q:$G(MSGTYPE)="" ACTIVE
 Q:$G(EVENT)="" ACTIVE
 ;did the application specify an action for the particular version of this message?
 I $G(VERSION)'="" S SUBIEN=$O(^HLD(779.2,IEN,1,"D",MSGTYPE,EVENT,VERSION,0))
 ;if not, look on the "C" index
 S:'$G(SUBIEN) SUBIEN=$O(^HLD(779.2,IEN,1,"C",MSGTYPE,EVENT,0))
 ;
 S:SUBIEN ACTIVE='(+$P($G(^HLD(779.2,IEN,1,SUBIEN,0)),"^",7))
 Q ACTIVE
 ;
EXCEPT(APPNAME) ;
 ;returns the exception handler (tag^routine) that should be invoked
 ;when an applicaiton's messages are being sequenced and an app ack
 ;is not timely received
 ;
 N IEN,RTN
 S IEN=$$GETIEN($G(APPNAME))
 I IEN S RTN=$P($G(^HLD(779.2,IEN,0)),"^",10,11)
 I $L($G(RTN))>1 Q RTN
 Q "DEFAULT^HLOAPP"
 ;
DEFAULT ;default exception handler if the app doesn't specify one
 S ^TMP("HLO SEQUENCING EXCEPTION",$J,$$NOW^XLFDT,+$G(HLMSGIEN))=""
 Q
 ;
TIMEOUT(APPNAME) ;
 N IEN,TIME
 S IEN=$$GETIEN($G(APPNAME))
 I IEN S TIME=$P($G(^HLD(779.2,IEN,0)),"^",12)
 Q:'$G(TIME) 10
 Q TIME
 ;
RTNTN(APP,MSGTYPE,EVENT,VERSION) ;
 ;Returns the retention time for this message, if specified.
 ;
 ;Input:
 ;  APP (required) the name of the sending application
 ;  MSGTYPE (required) 3 character HL7 message type
 ;  EVENT (required) 3 character HL7 event
 ;  VERSION (optional) HL7 version ID as it appears in the message header
 ;Output:
 ;  Function returns retention time if spcified, 0 otherwise
 ;
 N IEN,RET,SUBIEN
 S RET=0
 S IEN=$$GETIEN($G(APP))
 Q:'$G(IEN) RET
 I $L($G(MSGTYPE)),$L($G(EVENT)) D
 .;did the application specify an action for the particular version of this message?
 .I $G(VERSION)'="" S SUBIEN=$O(^HLD(779.2,IEN,1,"D",MSGTYPE,EVENT,VERSION,0)) I SUBIEN S RET=$P($G(^HLD(779.2,IEN,1,SUBIEN,0)),"^",8)
 .;if not, look on the "C" index
 .S:'RET SUBIEN=$O(^HLD(779.2,IEN,1,"C",MSGTYPE,EVENT,0)) I SUBIEN S RET=$P($G(^HLD(779.2,IEN,1,SUBIEN,0)),"^",8)
 ;
 S:'RET RET=+$P($G(^HLD(779.2,IEN,0)),"^",13)
 Q RET
 ;
 ;
 ;
 ;
 ;
 ;
