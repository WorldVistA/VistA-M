HLOF778A ;ALB/CJM-HL7 - Saving messages to file 778 (continued) ;07/17/2008
 ;;1.6;HEALTH LEVEL SEVEN;**126,134,137,138**;Oct 13, 1995;Build 34
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;
NEW(HLMSTATE) ;
 ;This function creates a new entry in file 778.
 ;Input:
 ;   HLMSTATE (required, pass by reference) These subscripts are expected:
 ;
 ;Output - the function returns the ien of the newly created record
 ;
 N IEN,NODE,ID,STAT
 S STAT="HLMSTATE(""STATUS"")"
 S IEN=$$NEWIEN(HLMSTATE("DIRECTION"),$$TCP)
 Q:'IEN 0
 S HLMSTATE("IEN")=IEN
 ;
 D  ;build the message header
 .N HDR
 .;for incoming messages the header segment should already exist
 .;for outgoing messages must build the header segment
 .I HLMSTATE("DIRECTION")="OUT" D  Q
 ..I HLMSTATE("BATCH"),$G(HLMSTATE("ACK TO"))]"" S HLMSTATE("HDR","REFERENCE BATCH CONTROL ID")=HLMSTATE("ACK TO")
 ..D BUILDHDR^HLOPBLD1(.HLMSTATE,$S(HLMSTATE("BATCH"):"BHS",1:"MSH"),.HDR)
 ..S HLMSTATE("HDR",1)=HDR(1),HLMSTATE("HDR",2)=HDR(2)
 ;
 K ^HLB(IEN)
 S ID=$S(HLMSTATE("BATCH"):HLMSTATE("HDR","BATCH CONTROL ID"),1:HLMSTATE("HDR","MESSAGE CONTROL ID"))
 S NODE=ID_"^"_HLMSTATE("BODY")_"^"_$G(HLMSTATE("ACK TO"))_"^"_$S(HLMSTATE("DIRECTION")="IN":"I",1:"O")_"^"
 S $P(NODE,"^",5)=$G(@STAT@("LINK NAME"))
 S $P(NODE,"^",6)=$G(@STAT@("QUEUE"))
 S $P(NODE,"^",8)=$G(@STAT@("PORT"))
 S $P(NODE,"^",20)=$G(@STAT)
 S $P(NODE,"^",21)=$G(@STAT@("ERROR TEXT"))
 S $P(NODE,"^",16)=HLMSTATE("DT/TM")
 ;
 I HLMSTATE("DIRECTION")="OUT" D
 .S $P(NODE,"^",10)=$P($G(@STAT@("APP ACK RESPONSE")),"^")
 .S $P(NODE,"^",11)=$P($G(@STAT@("APP ACK RESPONSE")),"^",2)
 .S $P(NODE,"^",12)=$P($G(@STAT@("ACCEPT ACK RESPONSE")),"^")
 .S $P(NODE,"^",13)=$P($G(@STAT@("ACCEPT ACK RESPONSE")),"^",2)
 .S $P(NODE,"^",14)=$P($G(@STAT@("FAILURE RESPONSE")),"^")
 .S $P(NODE,"^",15)=$P($G(@STAT@("FAILURE RESPONSE")),"^",2)
 .;
 .;for outgoing set these x-refs now, for incoming msgs set them later
 .S ^HLB("B",ID,IEN)=""
 .S ^HLB("C",HLMSTATE("BODY"),IEN)=""
 .I ($G(@STAT)="ER") D
 ..S ^HLB("ERRORS",$S($L($G(HLMSTATE("HDR","RECEIVING APPLICATION"))):HLMSTATE("HDR","RECEIVING APPLICATION"),1:"UNKNOWN"),HLMSTATE("DT/TM CREATED"),IEN)=""
 ..D COUNT^HLOESTAT("OUT",$G(HLMSTATE("HDR","RECEIVING APPLICATION")),$G(HLMSTATE("HDR","SENDING APPLICATION")),$S(HLMSTATE("BATCH"):"BATCH",1:$G(HLMSTATE("HDR","MESSAGE TYPE"))),$G(HLMSTATE("HDR","EVENT")))
 .;
 .;save some space for the ack
 .S:($G(HLMSTATE("HDR","ACCEPT ACK TYPE"))="AL") ^HLB(IEN,4)="^^^                                                                 "
 I $G(HLMSTATE("STATUS","PURGE")) S $P(NODE,"^",9)=HLMSTATE("STATUS","PURGE"),^HLB("AD","OUT",HLMSTATE("STATUS","PURGE"),HLMSTATE("IEN"))=""
 S ^HLB(IEN,0)=NODE
 ;
 ;store the message header
 S ^HLB(IEN,1)=HLMSTATE("HDR",1)
 S ^HLB(IEN,2)=HLMSTATE("HDR",2)
 ;
 ;if the msg is an app ack, update the original msg
 I $G(HLMSTATE("ACK TO","IEN"))]"" D
 .N ACKTO
 .M ACKTO=HLMSTATE("ACK TO")
 .S ACKTO("ACK BY")=$S(HLMSTATE("BATCH"):HLMSTATE("HDR","BATCH CONTROL ID"),1:HLMSTATE("HDR","MESSAGE CONTROL ID"))
 .D ACKTO^HLOF778(.HLMSTATE,.ACKTO)
 .S HLMSTATE("ACK TO","DONE")=1 ;because the update was already done, otherwise it might be done again
 ;
 ;The "SEARCH" x-ref will be created asynchronously
 S ^HLTMP("PENDING SEARCH X-REF",$J,HLMSTATE("DT/TM CREATED"),IEN)=""
 ;
 ;sequence q?
 I HLMSTATE("DIRECTION")="OUT",$G(@STAT@("SEQUENCE QUEUE"))'="" S ^HLB(IEN,5)=@STAT@("SEQUENCE QUEUE")
 ;
 Q IEN
 ;
NEWIEN(DIR,TCP) ;
 ;This function uses a counter to get the next available ien for file 778. There are 4 different counters, each assigned as range of numbers, selected via the input parameters. It does not create a record.
 ;Inputs:
 ;  DIR = "IN" or "OUT" (required)
 ;  TCP = 1,0 (optional)
 ;Output - the function returns the next available ien. Several counters are used:
 ;
 ;   <"OUT","TCP">
 ;   <"OUT","NOT TCP">
 ;   <"IN","TCP">
 ;   <"IN","NOT TCP">
 ;
 N IEN,COUNTER,INC
 I DIR="OUT" S INC=$S(+$G(TCP):0,1:100000000000)
 I DIR="IN" S INC=$S(+$G(TCP):200000000000,1:300000000000)
 S COUNTER=$NA(^HLC("FILE778",DIR,$S(+$G(TCP):"TCP",1:"NOT TCP")))
AGAIN ;
 S IEN=$$INC^HLOSITE(COUNTER,1)
 I IEN>100000000000 D
 .L +@COUNTER:200
 .I $T,@COUNTER>100000000000 S @COUNTER=1,IEN=1
 .L -@COUNTER
 I IEN>100000000000 G AGAIN
 Q (IEN+INC)
 ;
TCP() ;checks the link to see if its TCP, return 1 if yes, 0 if no or not defined
 N IEN,TCP
 S TCP=1
 S IEN=$G(HLMSTATE("STATUS","LINK IEN"))
 I IEN,$P($G(^HLCS(869.1,+$P($G(^HLCS(870,IEN,0)),"^",3),0)),"^")'="TCP" S TCP=0
 Q TCP
 ;
GETWORK(WORK) ; Used by the Process Manager.
 ;Are there any messages that need the "SEARCH" x-ref set?
 ;Inputs:
 ;  WORK (required, pass-by-reference)
 ;    ("DOLLARJ")
 ;    ("NOW") (required by the process manager, pass-by-reference)
 ;
 L +^HLTMP("PENDING SEARCH X-REF"):0
 Q:'$T 0
 N OLD,DOLLARJ,SUCCESS,NOW
 S SUCCESS=0
 S NOW=$$SEC^XLFDT($H)
 S (OLD,DOLLARJ)=$G(WORK("DOLLARJ"))
 F  S DOLLARJ=$O(^HLTMP("PENDING SEARCH X-REF",DOLLARJ)) Q:DOLLARJ=""  D  Q:SUCCESS
 .N TIME S TIME=$O(^HLTMP("PENDING SEARCH X-REF",DOLLARJ,""))
 .S:(NOW-$$SEC^XLFDT(TIME)>10) SUCCESS=1
 ;
 I OLD'="",'SUCCESS F  S DOLLARJ=$O(^HLTMP("PENDING SEARCH X-REF",DOLLARJ)) Q:DOLLARJ=""  Q:DOLLARJ>OLD  D  Q:SUCCESS
 .N TIME S TIME=$O(^HLTMP("PENDING SEARCH X-REF",DOLLARJ,""))
 .S:(NOW-$$SEC^XLFDT(TIME)>10) SUCCESS=1
 S WORK("DOLLARJ")=DOLLARJ,WORK("NOW")=NOW
 Q:WORK("DOLLARJ")]"" 1
 L -^HLTMP("PENDING SEARCH X-REF")
 Q 0
 ;
DOWORK(WORK) ;Used by the Process Manager
 ;Sets the "SEARCH" x-ref, running 10 seconds behind when the message record was created.
 ;
 N MSGIEN,TIME
 S TIME=0
 F  S TIME=$O(^HLTMP("PENDING SEARCH X-REF",WORK("DOLLARJ"),TIME)) Q:'TIME  Q:((WORK("NOW")-$$SEC^XLFDT(TIME))<10)  D
 .S MSGIEN=0
 .F  S MSGIEN=$O(^HLTMP("PENDING SEARCH X-REF",WORK("DOLLARJ"),TIME,MSGIEN)) Q:'MSGIEN  D
 ..N MSG
 ..I $$GETMSG^HLOMSG(MSGIEN,.MSG) D
 ...Q:'MSG("DT/TM CREATED")
 ...I MSG("BATCH") D
 ....N HDR
 ....F  Q:'$$NEXTMSG^HLOMSG(.MSG,.HDR)  S MSG("HDR",1)=HDR(1),MSG("HDR",2)=HDR(2) D SET(.MSG)
 ...E  D
 ....D SET(.MSG)
 ..K ^HLTMP("PENDING SEARCH X-REF",WORK("DOLLARJ"),TIME,MSGIEN)
 L -^HLTMP("PENDING SEARCH X-REF")
 Q
 ;
SET(MSG) ;
 ;sets the ^HLB("SEARCH") x-ref
 ;
 N APP,FS,CS,IEN
 I MSG("DIRECTION")'="IN",MSG("DIRECTION")'="OUT" Q
 S FS=$E(MSG("HDR",1),4)
 Q:FS=""
 S CS=$E(MSG("HDR",1),5)
 S APP=$S(MSG("DIRECTION")="IN":$P($P(MSG("HDR",1),FS,5),CS),1:$P($P(MSG("HDR",1),FS,3),CS))
 I APP="" S APP="UNKNOWN"
 I MSG("BATCH") D
 .N VALUE
 .S VALUE=$P(MSG("HDR",2),FS,4)
 .S MSG("MESSAGE TYPE")=$P(VALUE,CS)
 .S MSG("EVENT")=$P(VALUE,CS,2)
 S:MSG("MESSAGE TYPE")="" MSG("MESSAGE TYPE")="<none>"
 S:MSG("EVENT")="" MSG("EVENT")="<none>"
 S IEN=MSG("IEN")
 I MSG("BATCH") S IEN=IEN_"^"_MSG("BATCH","CURRENT MESSAGE")
 S ^HLB("SEARCH",MSG("DIRECTION"),MSG("DT/TM CREATED"),APP,MSG("MESSAGE TYPE"),MSG("EVENT"),IEN)=""
 Q
