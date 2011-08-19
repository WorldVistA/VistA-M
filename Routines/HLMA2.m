HLMA2 ;AISC/SAW-Message Administration Module ;09/23/2005  17:45
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,57,58,64,65,76,82,91,94,109,120**;Oct 13, 1995;Build 12
 ; References to ^ORD(101) supported by IA# 1373.
 ;
SEND(EIDS,MTIEN,CLIENT,PRIORITY,MTIENS,LOGLINK) ;
 ;Entry point to create
 ;an entry in the Message Administrator and Message Text
 ;files for a message that is about to be sent to a recipient
 ;
 ;This is a subroutine call with parameter passing.  It returns a value
 ;in the variable MTIENS with 1 to 3 pieces separated by uparrows
 ;as follows:  MTIENS^error code^error description
 ;If no error occurs, only the first piece is returned equal to the IEN
 ;the entry created in the Message Text or Administration file.
 ;Otherwise, three pieces are returned with the first piece equal to 0
 ;
 ;All the following input parameters are required
 ;    EIDS = The IEN from the Protocol file of the subscriber event
 ;   MTIEN = The IEN from the Message Text file created when the
 ;           GENERATE^HLMA or GENACK^HLMA1 entry points were invoked
 ;  CLIENT = The IEN of the client (subscriber) application from
 ;             the Application Parameter file
 ;PRIORITY = I for immediate or D for deferred
 ;  MTIENS = The variable that will be returned to the calling
 ;             application as described above
 ;Optional parameter
 ; LOGLINK = The IEN of the logical link from the Logical Link file
 ;
 ;     ACK = 1 or 0 to indicate if original message or response-passed
 ;             by ^HLCS
 ;
 ; Save passed parameters for restore... HL*1.6*94
 N HL94P
 ;
 ; patch HL*1.6*120 start
 ; save the receiving facility from HLSUP("S") variable in routine ADD^HLCS2
 I $G(MTIENS("REC-FACILITY"))]"" D
 . S HLP("REC-FACILITY")=MTIENS("REC-FACILITY")
 ; F HL94P="CONTPTR","NAMESPACE","SECURITY","SUBSCRIBER" D
 F HL94P="CONTPTR","NAMESPACE","SECURITY","SUBSCRIBER","PMOD","REC-FACILITY" D
 .  QUIT:'$D(HLP(HL94P))  ;->
 .  MERGE HL94P(HL94P)=HLP(HL94P)
 ; patch HL*1.6*120 end
 ;
 ;Check for required parameters
 S MTIENS=""
 I '$G(EIDS)!('$G(MTIEN))!('$G(CLIENT))!("ID"'[$E($G(PRIORITY))) S MTIENS="0^7^"_$G(^HL(771.7,7,0))_" at SEND^HLMA entry point" G EXIT
 ;Get message ID and Message Text IEN
 N HLJ,HLHDRBLD,HLMIDS,HLDTS,HLDT1S,HLP,REPLYTO,SERVER,X
 ;
 ; Restore parameters if needed... HL*1.6*94
 S HL94P=""
 F  S HL94P=$O(HL94P(HL94P)) Q:HL94P']""  D
 .  MERGE HLP(HL94P)=HL94P(HL94P)
 ;
 ;check if LL is TCP
 I $G(LOGLINK) D  Q:MTIENS!($G(HLERROR)]"")
 . ;quit if it is not TCP
 . Q:$P(^HLCS(870,LOGLINK,0),U,3)'=4
 . ;create client in 773, MTIENS=ien in 773
 . S (MTIENS,HLTCP)=$$MA^HLTF(MTIEN,.HLMIDS)
 .;
 .;**109
 .; F  L +^HLMA(MTIENS):1 Q:$T  H 1
 .;
 . D MIDAR(HLMIDS)
 . ;get info from parent (772)
 . S X=^HL(772,MTIEN,0),HLTYPE=$P(X,U,14),SERVER=$P(X,U,2),REPLYTO=$P(X,U,7)
 . ;get ack timeout override
 . S:$P($G(^HL(772,MTIEN,"P")),U,7) HLP("ACKTIME")=+$P(^("P"),U,7)
 . ;get message type and event type from protocol
 . S X=$G(^ORD(101,EIDS,770)),HLP("MTYPE")=$P(X,U,11),HLP("EVENT")=$P(X,U,4),HLP("HLTCPI")=MTIENS
 . S:$P(X,U,5) HLP("MTYPE_EVENT")=$P(X,U,5)
 . ;update date in client (773)
 . D UPDATE^HLTF0(MTIENS,"","O",EIDS,CLIENT,SERVER,"D",REPLYTO,"",.HLP)
 . ;create header for message in 773
 . I (HLTYPE="M") D HEADER^HLCSHDR1(MTIENS,CLIENT,.HLERROR)
 . I (HLTYPE'="M") D BHSHDR^HLCSHDR1(MTIENS,CLIENT,.HLERROR)
 . ;if error set status to ERROR DURING TRANSMISSION
 . I ($G(HLERROR)'="") D  Q
 ..;**109**
 ..; D STATUS^HLTF0(MTIENS,4,12,HLERROR) L -^HLMA(MTIENS)
 .. D STATUS^HLTF0(MTIENS,4,12,HLERROR)
 ..;
 .. S MTIENS="0^12^"_$G(^HL(771.7,12,0))_" in HLCSHDR1"
 .. Q
 . ;do we still need MTIEN=ien of file 772
 . S MTIEN=""
 . ;update status of 773 to PENDING TRANSMISSION
 . D STATUS^HLTF0(MTIENS,1)
 . ;set header, HLHDR and Logical Link in 773
 . K HLJ
 . S X=MTIENS_",",HLJ(773,X,7)=LOGLINK,HLJ(773,X,200)="HLHDR"
 . D FILE^HLDIE("","HLJ","","SEND","HLMA2") ;HL*1.6*109
 .D ENQUE^HLCSREP(LOGLINK,"O",MTIENS)
 .;
 .;**109
 .; L -^HLMA(MTIENS)
 ;
 ;if not TCP get msg. ID
 S HLMIDS=$P($G(^HL(772,MTIEN,0)),"^",6)
 ;create child message
 D CREATE^HLTF(.HLMIDS,.MTIENS,.HLDTS,.HLDT1S),MIDAR(HLMIDS)
 ;Link new Message Text file entry to MTIENG entry and update fields
 ;on zero node
 D UPDATE^HLTF0(MTIENS,MTIEN,"O",EIDS,CLIENT,"",PRIORITY,"",$S($G(LOGLINK):LOGLINK,1:""))
EXIT Q
 ;
MIDAR(X) ;update HLMIDAR array with X=message id
 Q:$G(X)=""
 I 'HLMIDAR S HLMIDAR("N")=1,HLMIDAR=X Q
 S HLMIDAR(HLMIDAR("N"))=X,HLMIDAR("N")=HLMIDAR("N")+1
 Q
 ;
DC ;direct connect
 N CLIENT,EIDS,HLMIDS,LOGLINK,MTIEN,MTIENS,POP,HLHDR,HLHDRO,HLMSA,REPLYTO,SERVER,X,HLTCPI
 N HLCSOUT,HLDBACK,HLDBSIZE,HLDP,HLDREAD,HLDRETR,HLDWAIT,HLMSG,HLOS,HLPORT,HLTCPADD,HLTCPCS,HLTCPLNK,HLTCPO,HLTCPORT,HLRESP,HLTYPE,HLRETRA,HLRETRY,HLTCPRET
 S (EIDS,LOGLINK)="",MTIEN=HLMTIEN
 I $D(HLL("LINKS")) D
 . S EIDS=$P(HLL("LINKS",1),U),LOGLINK=$P(HLL("LINKS",1),U,2)
 . K HLL("LINKS")
 . Q:EIDS=""  I EIDS<1 S EIDS=$O(^ORD(101,"B",EIDS,0))
 . Q:LOGLINK=""  I LOGLINK<1 S LOGLINK=$O(^HLCS(870,"B",LOGLINK,0))
 . S CLIENT=+$$PTR^HLUTIL2(EIDS)
 I 'LOGLINK!'EIDS D
 . S EIDS=+$O(^ORD(101,HLEID,775,0)) Q:'EIDS  S EIDS=$P($G(^(EIDS,0)),U)
 . S X=$$PTR^HLUTIL2(EIDS),CLIENT=$P(X,U),LOGLINK=$P(X,U,2)
 I 'EIDS S HLERROR="15^Invalid Subscriber for Immediate connection" Q
 I 'LOGLINK S HLERROR="15^Invalid Logical Link for Immediate connection" Q
 I CLIENT<0 S HLERROR="15^Invalid Subscriber Protocol for Immediate connection" Q
 ;open connection
 I '$$DCOPEN^HLCSTCP(LOGLINK) S HLERROR="15^Connection Failed" Q
 ;create client in 773
 S HLDP=LOGLINK,(MTIENS,HLTCP,HLTCPI,HLMSG)=$$MA^HLTF(MTIEN,.HLMIDS)
 ;
 ; patch HL*1.6*120 start
 S HLMIDAR("HLMID")=$G(HLMIDS)
 S HLMIDAR("IEN773")=MTIENS
 ; patch HL*1.6*120 end
 ;
 ;**109**
 ;F  L +^HLMA(MTIENS):1 Q:$T  H 1
 ;
 ;get info from parent (772)
 S X=^HL(772,MTIEN,0),HLTYPE=$P(X,U,14),SERVER=$P(X,U,2),REPLYTO=$P(X,U,7)
 ;get ack timeout override
 S:$P($G(^HL(772,MTIEN,"P")),U,7) HLP("ACKTIME")=+$P(^("P"),U,7)
 ;get message type and event type from protocol
 S X=$G(^ORD(101,EIDS,770)),HLP("MTYPE")=$P(X,U,11),HLP("EVENT")=$P(X,U,4),HLP("HLTCPI")=MTIENS
 S:$P(X,U,5) HLP("MTYPE_EVENT")=$P(X,U,5)
 ;update date in client (773)
 D UPDATE^HLTF0(MTIENS,"","O",EIDS,CLIENT,SERVER,"I",REPLYTO,"",.HLP)
 ;create header for message in 773
 I (HLTYPE="M") D HEADER^HLCSHDR1(MTIENS,CLIENT,.HLERROR)
 I (HLTYPE'="M") D BHSHDR^HLCSHDR1(MTIENS,CLIENT,.HLERROR)
 ;if error set status to ERROR DURING TRANSMISSION
 I ($G(HLERROR)'="") D  Q
 .;
 .;**109**
 .; D STATUS^HLTF0(MTIENS,4,12,HLERROR) L -^HLMA(MTIENS)
 . D STATUS^HLTF0(MTIENS,4,12,HLERROR)
 .;
 . S MTIENS="0^12^"_$G(^HL(771.7,12,0))_" in HLCSHDR1"
 .;
 .;**109**
 .; L -^HLMA(HLMSG) D MON^HLCSTCP("Idle")
 . D MON^HLCSTCP("Idle")
 .;
 . Q
 ;set header, HLHDR and Logical Link in 773
 K HLJ S X=MTIENS_",",HLJ(773,X,7)=LOGLINK,HLJ(773,X,200)="HLHDR"
 ;
 D FILE^HLDIE("","HLJ","","DC","HLMA2") ; HL*1.6*109
 ;
 ;**109**
 D LLCNT^HLCSTCP(LOGLINK,3)
 ;
 D DCSEND^HLCSTCP2
 G EXIT2:'$G(HLRESP)
 ;X=ien in 773^ien in 772 for response
 S X=HLRESP D INIT^HLTP3A  ;patch HL*1.6*109 - hltp3 routine split
 D:'$G(HL) STATUS^HLTF0(HLMTIENS,3,,,1)
 S HLMTIENR=HLMTIEN
 D EXIT^HLTP3
EXIT2 ;
 ;**109**
 ;L -^HLMA(HLMSG)
 Q
