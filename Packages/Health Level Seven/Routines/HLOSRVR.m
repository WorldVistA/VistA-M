HLOSRVR ;ALB/CJM - Server for receiving messages - 10/4/94 1pm ;06/25/2012
 ;;1.6;HEALTH LEVEL SEVEN;**126,130,131,134,137,138,139,143,147,157,158**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
GETWORK(WORK) ;
 ;GET WORK function for a single server or a Taskman multi-server
 N LINK
 I '$$CHKSTOP^HLOPROC,$G(WORK("LINK"))]"",$$GETLINK^HLOTLNK(WORK("LINK"),.LINK),+LINK("SERVER") S WORK("PORT")=LINK("PORT") Q 1
 Q 0
 ;
DOWORKS(WORK) ;
 ;DO WORK rtn for a single server (non-concurrent)
 N $ETRAP,$ESTACK
 S $ETRAP="G ERROR^HLOSRVR3"
 D SERVER(WORK("LINK"))
 Q
DOWORKM(WORK) ;
 ;DO WORK rtn for a Taskman multi-server (Cache systems only)
 D LISTEN^%ZISTCPS(WORK("PORT"),"SERVER^HLOSRVR("""_WORK("LINK")_""")")
 Q
 ;
VMS2(LINKNAME) ;called from a VMS TCP Service once a connection request has been received.  This entry point should be used only if an additional VMS TCPIP Services are being created for HLO.
 ;Input:
 ;   LINKNAME - only pass it in if an additional service is being created on a different port
 Q:'$L(LINKNAME)
 D VMS
 Q
 ;
VMS ;Called from VMS TCP Service once a connection request has been received. This entry point should be used only by the standard HLO service that runs on the standard HLO port.
 Q:$$CHKSTOP^HLOPROC
 D
 .Q:$L($G(LINKNAME))
 .;
 .N PROC,NODE
 .S PROC=$O(^HLD(779.3,"B","VMS TCP LISTENER",0))
 .I PROC S LINKNAME=$P($G(^HLD(779.3,PROC,0)),"^",14) Q:$L(LINKNAME)
 .S NODE=$G(^HLD(779.1,1,0)) I $P(NODE,"^",10) S LINKNAME=$P($G(^HLCS(870,$P(NODE,"^",10),0)),"^") Q:$L(LINKNAME) 
 .S LINKNAME="HLO DEFAULT LISTENER"
 ;
 D SERVER(LINKNAME,"SYS$NET")
 Q
LINUX1 ;The listener entry point on Linux systems.  The HL LOGICAL LINK should
 ;be specified in the xinetd configuration file as the variable
 ;HLOLINK or otherwise in the HLO SYSTEM PARAMETERS file 
 ;
 N LINKNAME,NODE
 S LINKNAME=$System.Util.GetEnviron("HLOLINK")
 I '$L(LINKNAME) S NODE=$G(^HLD(779.1,1,0)) I $P(NODE,"^",10) S LINKNAME=$P($G(^HLCS(870,$P(NODE,"^",10),0)),"^")
 S:'$L(LINKNAME) LINKNAME="HLO DEFAULT LISTENER"
 D LINUX(LINKNAME)
 Q
 ;
LINUX(LINKNAME) ;Listener for Linux systems running under Xinetd.
 ;Input:
 ;  LINKNAME - name of the HL LOGICAL LINK for the listener
 ;
 Q:'$L($G(LINKNAME))
 Q:$$CHKSTOP^HLOPROC
 ;
 D $ZU(68,15,1) ;need error on disconnect
 D SERVER(LINKNAME,$PRINCIPAL)
 Q
 ;
SERVER(LINKNAME,LOGICAL) ; LINKNAME identifies the logical link, which describes the communication channel to be used
 N $ETRAP,$ESTACK S $ETRAP="G ERROR^HLOSRVR3"
 N HLCSTATE,INQUE
 S INQUE=0
 ;
ZB1 ;
 ;
 Q:'$$CONNECT(.HLCSTATE,LINKNAME,.LOGICAL)
 ;
 K LINKNAME
 F  Q:'HLCSTATE("CONNECTED")  D  Q:$$CHKSTOP^HLOPROC
 .N HLMSTATE,SENT
 .;read msg and parse the hdr
 .;HLMSTATE("MSA",1) is set with type of ack to return
 .;
 .I $$READMSG^HLOSRVR1(.HLCSTATE,.HLMSTATE) D
 ..I (HLMSTATE("MSA",1)]"") S SENT=$$WRITEACK(.HLCSTATE,.HLMSTATE) D:HLMSTATE("IEN") SAVEACK(.HLMSTATE,SENT)
 ..;
 ..I HLMSTATE("ID")'="" L -HLO("MSGID",HLMSTATE("ID"))
 ..;
 ..D:HLMSTATE("IEN") UPDATE(.HLMSTATE,.HLCSTATE)
 ..D:HLCSTATE("COUNTS")>4 SAVECNTS^HLOSTAT(.HLCSTATE)
 ..I $G(HLMSTATE("ACK TO IEN")),$L($G(HLMSTATE("ACK TO","SEQUENCE QUEUE"))) D ADVANCE^HLOQUE(HLMSTATE("ACK TO","SEQUENCE QUEUE"),+HLMSTATE("ACK TO IEN"))
 .E  D
 ..I $G(HLMSTATE("ID"))'="" L -HLO("MSGID",HLMSTATE("ID"))
 ..D INQUE() H:HLCSTATE("CONNECTED") 1
 ;
END D CLOSE^HLOT(.HLCSTATE)
 D INQUE()
 D SAVECNTS^HLOSTAT(.HLCSTATE)
 Q
 ;
CONNECT(HLCSTATE,LINKNAME,LOGICAL) ;
 ;sets up HLCSTATE() and opens a server connection
 ;
 N LINK,NODE
 S HLCSTATE("CONNECTED")=0
 Q:'$$GETLINK^HLOTLNK(LINKNAME,.LINK) 0
ZB999 ; 
 Q:+LINK("SERVER")'=1 0
 S HLCSTATE("SERVER")=LINK("SERVER")
 M HLCSTATE("LINK")=LINK
 S HLCSTATE("READ TIMEOUT")=20
 S HLCSTATE("OPEN TIMEOUT")=30
 S HLCSTATE("READ")="" ;buffer for reads
 ;
 ;HLCSTATE("BUFFER",<seg>,<line>)  write buffer
 S HLCSTATE("BUFFER","BYTE COUNT")=0 ;count of bytes in buffer
 S HLCSTATE("BUFFER","SEGMENT COUNT")=0 ;count of segments in buffer
 ;
 S HLCSTATE("COUNTS")=0
 S HLCSTATE("MESSAGE STARTED")=0 ;start of message flag
 S HLCSTATE("MESSAGE ENDED")=0 ;end of message flag
 S NODE=^%ZOSF("OS")
 S HLCSTATE("SYSTEM","OS")=$S(NODE["DSM":"DSM",NODE["OpenM":"CACHE",NODE["G.TM":"G.TM",1:"")
 Q:HLCSTATE("SYSTEM","OS")="" 0
 D  ;get necessary system parameters
 .N SYS,SUB
 .D SYSPARMS^HLOSITE(.SYS)
 .F SUB="MAXSTRING","DOMAIN","STATION","PROCESSING ID","NORMAL PURGE","ERROR PURGE" S HLCSTATE("SYSTEM",SUB)=SYS(SUB)
 .S HLCSTATE("SYSTEM","BUFFER")=SYS("HL7 BUFFER")
 I HLCSTATE("LINK","LLP")="TCP" D
 .D OPEN^HLOTCP(.HLCSTATE,.LOGICAL)
 E  ;no other LLP implemented
 ;
 Q HLCSTATE("CONNECTED")
 ;
INQUE(MSGIEN,PARMS) ;
 ;
 ;
 ;puts received messages on the incoming queue and sets the B x-ref
 I $G(MSGIEN) S INQUE=INQUE+1 M INQUE(MSGIEN)=PARMS
 ;
 ;
 I ('$G(MSGIEN))!(INQUE>20) S MSGIEN=0 D
 .F  S MSGIEN=$O(INQUE(MSGIEN)) Q:'MSGIEN  D
 ..S ^HLB("B",INQUE(MSGIEN,"MSGID"),MSGIEN)=""
 ..S ^HLA("B",INQUE(MSGIEN,"DT/TM"),INQUE(MSGIEN,"BODY"))=""
 ..D:INQUE(MSGIEN,"PASS")
 ...N PURGE,ORIG
 ...S PURGE=+$G(INQUE(MSGIEN,"PURGE"))
 ...S ORIG("IEN")=$G(INQUE(MSGIEN,"ORIG_IEN"))
 ...S:ORIG("IEN") ORIG("STATUS")=$G(INQUE(MSGIEN,"ORIG_STATUS")),ORIG("ACK BY")=INQUE(MSGIEN,"MSGID")
 ...D INQUE^HLOQUE(INQUE(MSGIEN,"FROM"),INQUE(MSGIEN,"QUEUE"),MSGIEN,INQUE(MSGIEN,"ACTION"),PURGE,.ORIG)
 .K INQUE S INQUE=0
 Q
 ;
SAVEACK(HLMSTATE,SENT) ;
 ;Input:
 ;  SENT - flag = 1 if transmission of ack succeeded, 0 otherwise
 ;
 N NODE,I,XX
 S $P(NODE,"^")=HLMSTATE("MSA","DT/TM OF MESSAGE")
 S $P(NODE,"^",2)=HLMSTATE("MSA","MESSAGE CONTROL ID")
 S $P(NODE,"^",3)="MSA"
 F I=1:1:3 S NODE=NODE_"|"_$G(HLMSTATE("MSA",I))
 S ^HLB(HLMSTATE("IEN"),4)=NODE
 S:SENT $P(^HLB(HLMSTATE("IEN"),0),"^",$S($E(HLMSTATE("MSA",1))="A":18,1:17))=1
 Q
 ;
UPDATE(HLMSTATE,HLCSTATE) ;
 ;Updates status and purge date when appropriate
 ;Also, sets the "B" xrefs, files 777,778, and places message on the incoming queue
 ;
 N PARMS
 S PARMS("PASS")=0
 I HLMSTATE("STATUS","ACTION")]"",HLMSTATE("STATUS")'="ER" D
 .N IEN
 .S IEN=HLMSTATE("IEN")
 .S PARMS("PASS")=1,$P(^HLB(IEN,0),"^",6)=HLMSTATE("STATUS","QUEUE"),$P(^HLB(IEN,0),"^",10)=$P(HLMSTATE("STATUS","ACTION"),"^"),$P(^HLB(IEN,0),"^",11)=$P(HLMSTATE("STATUS","ACTION"),"^",2)
 D:'PARMS("PASS")  ;if not passing to the app, set the purge date
 .I HLMSTATE("STATUS")="" S HLMSTATE("STATUS")="SU"
 .D SETPURGE^HLOF778A(HLMSTATE("IEN"),HLMSTATE("STATUS"),$G(HLMSTATE("ACK TO IEN")),$G(HLMSTATE("ACK TO","STATUS")))
 ;
 ;if not waiting for an application ack, set the status now even if passing to the app - but don't set the purge until the infiler passes the message
 I HLMSTATE("STATUS")="",($G(HLMSTATE("ACK TO IEN"))!HLMSTATE("HDR","APP ACK TYPE")'="AL") S HLMSTATE("STATUS")="SU"
 I HLMSTATE("STATUS")'="" S $P(^HLB(HLMSTATE("IEN"),0),"^",20)=HLMSTATE("STATUS") S:$G(HLMSTATE("MSA",3))]"" $P(^HLB(HLMSTATE("IEN"),0),"^",21)=HLMSTATE("MSA",3) D:HLMSTATE("STATUS")'="SU"
 .N APP
 .S APP=HLMSTATE("HDR","RECEIVING APPLICATION") S:APP="" APP="UNKNOWN" S ^HLB("ERRORS",APP,HLMSTATE("DT/TM"),HLMSTATE("IEN"))=""
 .D COUNT^HLOESTAT("IN",$G(HLMSTATE("HDR","RECEIVING APPLICATION")),$G(HLMSTATE("HDR","SENDING APPLICATION")),$S(HLMSTATE("BATCH"):"BATCH",1:$G(HLMSTATE("HDR","MESSAGE TYPE"))),$G(HLMSTATE("HDR","EVENT")))
 ;
 ;set the necessary parms for passing the msg to the app via the infiler
 D:PARMS("PASS")
 .N I,FROM
 .S FROM=HLMSTATE("HDR","SENDING FACILITY",1)
 .I HLMSTATE("HDR","SENDING FACILITY",2)]"" S FROM=FROM_"~"_HLMSTATE("HDR","SENDING FACILITY",2)_"~"_HLMSTATE("HDR","SENDING FACILITY",3)
 .I FROM="" S FROM="UNKNOWN SENDING FACILITY"
 .S PARMS("FROM")=FROM,PARMS("QUEUE")=HLMSTATE("STATUS","QUEUE"),PARMS("ACTION")=HLMSTATE("STATUS","ACTION")
 .I HLMSTATE("STATUS")'="" S PARMS("PURGE")=1
 .;The infiler should set the purge date at the same time as the initial message, and update the status and 'ack by' fields
 .S:$G(HLMSTATE("ACK TO IEN")) PARMS("ORIG_IEN")=HLMSTATE("ACK TO IEN"),PARMS("ORIG_STATUS")=$G(HLMSTATE("ACK TO","STATUS"))
 ;
 S PARMS("BODY")=HLMSTATE("BODY")
 S PARMS("DT/TM")=HLMSTATE("DT/TM")
 S PARMS("MSGID")=HLMSTATE("ID")
 ;
 D INQUE(HLMSTATE("IEN"),.PARMS)
 Q
 ;
WRITEACK(HLCSTATE,HLMSTATE) ;
 ;Sends an accept ack
 ;
 ;Input:
 ;  HLCSTATE (pass by reference) defines the communication channel
 ;  HLMSTATE (pass by reference) the message being acked
 ;     ("MSA",1) - value for MSA-1
 ;     ("MSA",2) - value for MSA-2
 ;     ("MSA",3) - value for MSA-3
 ;     ("HDR") - parsed values for the message being ack'd
 ;Output:
 ;  Function returns 1 if successful, 0 otherwise
 ;  HLMSTATE("MSA","MESSAGE CONTROL ID") - the msg id of the ack
 ;  HLMSTATE(,"MSA","DT/TM OF MESSAGE") - from the ack header
 ; 
 N HDR,SUB,FS,CS,MSA,ACKID,TIME
 ;Hard-code the delimiters, the standard requires that the receiving system accept the delimiters listed in the header
 S FS="|"
 S CS="^"
 S TIME=$$NOW^XLFDT
 S HLMSTATE("MSA","DT/TM OF MESSAGE")=TIME
 S ACKID=HLCSTATE("SYSTEM","STATION")_" "_$$NEWIEN^HLOF778A("OUT")
 S HLMSTATE("MSA","MESSAGE CONTROL ID")=ACKID
 ;
 S HDR(1)="MSH"_FS_"^~\&"_FS_HLMSTATE("HDR","RECEIVING APPLICATION")_FS_HLCSTATE("SYSTEM","STATION")_CS_HLCSTATE("SYSTEM","DOMAIN")_CS_"DNS"_FS
 S HDR(1)=HDR(1)_HLMSTATE("HDR","SENDING APPLICATION")_FS_HLMSTATE("HDR","SENDING FACILITY",1)_CS_HLMSTATE("HDR","SENDING FACILITY",2)_CS_HLMSTATE("HDR","SENDING FACILITY",3)
 ;
 S HDR(2)=FS_$$HLDATE^HLFNC(TIME,"TS")_FS_FS_"ACK"_FS_ACKID_FS_HLMSTATE("HDR","PROCESSING ID")_FS_"2.4"_FS_FS_FS_"NE"_FS_"NE"
 ;
 S MSA(1)="MSA"_FS
 F SUB=1:1:3 S MSA(1)=MSA(1)_HLMSTATE("MSA",SUB)_FS
 I $$WRITEHDR^HLOT(.HLCSTATE,.HDR),$$WRITESEG^HLOT(.HLCSTATE,.MSA),$$ENDMSG^HLOT(.HLCSTATE) S HLCSTATE("COUNTS","ACKS")=$G(HLCSTATE("COUNTS","ACKS"))+1 Q 1
 S HLMSTATE("MSA","DT/TM OF MESSAGE")=""
 Q 0
