HLTP3 ;SFIRMFO/RSD - Transaction Processor for TCP ;07/29/2009  14:51
 ;;1.6;HEALTH LEVEL SEVEN;**19,43,57,58,59,66,69,109,115,108,116,117,125,120,133,122,140,142,145**;Oct 13, 1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
NEW(X) ;process new msg. ien in 773^ien in 772
 ;HLMTIENS=ien in #773; HLMTIEN=ien in #772
 ;HLHDRO=original header;  HLHDR=response header
 ;set error trap
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^HLTP3"
 N HL,HLEID,HLEIDS,HLERR,HLHDR,HLHDRO,HLMTIEN,HLMTIENS,HLJ,HLMSA,HLQUIT,HLNODE,HLNEXT,HLRESLTA,HLDONE1,HLASTRSP,HLRESLT
 S HLRESLT=""
 D INIT^HLTP3A
 ;error with header, return commit/app reject
 I $G(HLRESLT) D  Q
 . ;set status & unlock record
 . D STATUS^HLTF0(HLMTIENS,4,,,1),EXIT
 . ;quit if no commit or app ack
 . I $G(HL("ACAT"))="NE",$G(HL("APAT"))="NE" Q
 . S X=$S($G(HL("ACAT"))="AL":"CR",1:"AR")
 . ;HLTCP=ien of acknowledgment msg. from ACK^HLTP4
 . D ACK^HLTP4(X,$P(HLRESLT,U,2)) Q:'$G(HLTCP)
 . ;write ack back
 . S X=$$WRITE^HLCSTCP2(HLTCP)
 . ;update counter to sent
 . D LLCNT^HLCSTCP(HLDP,4)
 . ;update status of ack
 . D STATUS^HLTF0(HLTCP,3,,,1)
 ;
 ;check for duplicate msg., use rec. app and msg. id x-ref
 ; patch HL*1.6*142 start
 ; HL("HDR FLDS:3-6") extracted from field 3 to field 6 of header
 ; defined in HLDIE routine
 ; I $G(HL("MID"))]"",$G(HL("RAP")) S X=$O(^HLMA("AH",HL("RAP"),HL("MID"),0)) D  Q:'$D(HLMTIENS)
 I ($G(HL("MID"))]""),($G(HL("HDR FLDS:3-6"))]"") D  Q:'$D(HLMTIENS)
 . S X=$O(^HLMA("AH-NEW",HL("HDR FLDS:3-6"),HL("MID"),0))
 . ; patch HL*1.6*142 end
 . ;HLASTMSG=last ien received during this connection
 . ;if no duplicate, save msg. ien and quit
 . I X=HLMTIENS!'X S HLASTMSG=HLMTIENS Q
 . N MSH,OIENS
 . S (OIENS,Y)=X D  S Y=HLMTIENS D
 .. ;combine MSH into single string
 .. S MSH(Y)="",I=0 F  S I=$O(^HLMA(Y,"MSH",I)) Q:'I  S MSH(Y)=MSH(Y)_$G(^(I,0))
 .; patch 117 & 125, check if identical
 .I MSH(HLMTIENS)'=MSH(OIENS) S HLASTMSG=HLMTIENS Q
 .;
 . ;msg is duplicate, set status
 . D STATUS^HLTF0(HLMTIENS,4,109,"Duplicate with ien "_OIENS,1),EXIT
 . ;msg was resent, ignore it.
 . I HLASTMSG=HLMTIENS K HLMTIENS Q
 . ;find original response and send back
 . S HLASTRSP=$O(^HLMA("AF",OIENS,OIENS))
 . ; patch HL*1.6*142 start
 . ; the original msg may need to be updated again if 1st time
 . ; update failed
 . S HLASTMSG("OIENS")=OIENS
 . ;
 . ; the original message and its commit ACK were purged, OIENS is
 . ; duplicate and needs to create its own commit ACK (happened
 . ; between MPI and VIE in 9/2008), the OIENS will be processed
 . ; by the application routine again.
 . I $G(HL("ACAT"))="AL",'$G(HL("ACK")),'HLASTRSP D
 .. N HLTCP,HLMTIENS
 .. S HLMTIENS=OIENS
 .. D ACK^HLTP4("CA")
 .. D LLCNT^HLCSTCP(HLDP,3,1) ; decreament and will be added later
 .. S HLASTRSP=HLTCP
 . ; patch HL*1.6*142 end
 ;
 ; patch HL*1.6*145 start
 ; Quit if this is application ack to application ack
 I $G(HL("ACK")) D  Q
 . N HLERRMG,X
 . S HLERRMG="Received application acknowledgement to an application acknowledgement"
 . ;msg is a resend, HLASTRSP=ien of original response (commit ACK)
 . I $G(HLASTRSP) D
 .. S HLTCP=HLASTRSP
 .. D STATUS^HLTF0(HLTCP,8)
 .. S ^HLMA(+HLTCP,"S")=$$NOW^XLFDT
 .. D LLCNT^HLCSTCP(HLDP,3)
 . E  D  Q:'$G(HLTCP)
 .. ;Send CR and update status of original and current ack messages
 .. D ACK^HLTP4("CR",HLERRMG)
 . ;
 . ; write commit ACK (original commit ACK)
 . S X=$$WRITE^HLCSTCP2(HLTCP)
 . D STATUS^HLTF0(HLTCP,3,,"'Reject' commit ACK: "_HLERRMG,1)
 . S ^HLMA(+HLTCP,"S")=$$NOW^XLFDT
 . D LLCNT^HLCSTCP(HLDP,4)
 . S HLTCP=""
 . ; D STATUS^HLTF0(HL("MTIENS"),3,,,1),STATUS^HLTF0(HLMTIENS,3,,,1)
 . D STATUS^HLTF0(HL("MTIENS"),3,,,1)
 . D STATUS^HLTF0(HLMTIENS,4,,HLERRMG,1)
 . ;unlock record
 . D EXIT
 ; patch HL*1.6*145 end
 ;
 ; enhance ack., send commit, quit if not an ack, msg will be 
 ; processed by filer
 I $G(HL("ACAT"))="AL" D  Q:'$G(HL("MTIENS"))
 . ;msg is a resend, HLASTRSP=ien of original response (commit ACK)
 .I $G(HLASTRSP) D
 ..S HLTCP=HLASTRSP
 ..D LLCNT^HLCSTCP(HLDP,3)
 . E  D  Q:'$G(HLTCP)
 ..D ACK^HLTP4("CA") ;**109** LLCNT^HLCSTCP(HLDP,3) called in ACK^HLTP4
 . ;
 . ; write commit ACK (original commit ACK)
 . S X=$$WRITE^HLCSTCP2(HLTCP)
 . ; patch HL*1.6*142
 . ; D LLCNT^HLCSTCP(HLDP,4),STATUS^HLTF0(HLTCP,3,,,1):'$G(HLASTRSP)
 . D LLCNT^HLCSTCP(HLDP,4)
 . I '$G(HLASTRSP) D
 .. D STATUS^HLTF0(HLTCP,3,,,1)
 . S HLTCP=""
 . ;if not an ack, set status to awaiting processing **109** and put on in queue
 . I '$G(HL("MTIENS")),'$G(HLASTRSP) D STATUS^HLTF0(HLMTIENS,9),EXIT,SETINQUE^HLTP31
 . ;
 . ; patch HL*1.6*142 start
 . ;if the original msg failed to en-queue and update status
 . ; it may happen when COTS disconnect the listener during
 . ; writing the commit ACK
 . ; deal with a non-application ACK duplicate message
 . I '$G(HL("MTIENS")),$G(HLASTRSP) D
 .. N STATUS
 .. S STATUS=+$G(^HLMA(HLASTRSP,"P"))
 .. I STATUS,(STATUS'=3) D
 ... ; update the original messsage, ien=HLASTMSG("OIENS")
 ... D STATUS^HLTF0(HLASTMSG("OIENS"),9)
 ... D EXIT
 ... N HLMTIENS
 ... S HLMTIENS=HLASTMSG("OIENS")
 ... D SETINQUE^HLTP31
 ... D STATUS^HLTF0(HLASTRSP,3,,,1)
 . ; patch HL*1.6*142 end
 ;
 ;enhance ack., no commit & no app ack
 I $G(HL("ACAT"))="NE",$G(HL("APAT"))="NE" D  Q
 . ;set status to awaiting processing, **109** and put on in queue
 . I '$G(HLASTRSP) D STATUS^HLTF0(HLMTIENS,9),EXIT,SETINQUE^HLTP31
 ;
 ; patch HL*1.6*120 start
 ;resending old response, msg is a resend
 ; do not re-send duplicate when $G(HL("ACAT"))="AL"
 ; the following resend is for original mode application ACK
 I $G(HLASTRSP),$G(HL("ACAT"))'="AL" S HLTCP=HLASTRSP G ACK
 ; patch HL*1.6*120 end
 ;
 ; patch HL*1.6*142 start
 ; to handle duplicate when the original message encountered
 ; a write error of commit ACK
 ; quit if duplicate
 ; Q:$G(HLASTRSP)
 S HLASTRSP("FLAG")=0
 I $G(HLASTRSP),$G(HL("ACAT"))="AL" D
 . I +$G(^HLMA(+$G(HLASTRSP),"P")),(+$P($G(^HLMA(+$G(HLASTRSP),"P")),"^")'=3) D
 .. S HLASTRSP("FLAG")=1
 ; don't quit if this is duplicate application ACK msg with accept
 ; ACK type="AL", and its original commit ACK is not done.
 I $G(HLASTRSP),('HLASTRSP("FLAG")) Q
 ;
 ; if duplicate, change ien to orginal msg ien
 I $G(HLASTRSP) D
 . S HLMTIENS=+$G(HLASTMSG("OIENS"))
 . S HLMTIEN=+$G(^HLMA(HLMTIENS,0))
 ; patch HL*1.6*142 end
 ;
CONT ;continue processing an enhance ack msg. called from DEFACK
 ;Set special HL variables for processing rtn
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ;
 ; message is an acknowledgement, HLMSA=ack code^id^text
 I ($G(HLMSA)]"") D  Q
 . ;X=1 if ack ok, 0=reject of error
 . S X=$E(HLMSA,2)="A"
 . ;Update status of original message and remove it from the queue
 . D STATUS^HLTF0(HL("MTIENS"),$S(X:3,1:4),"",$S(X:"",1:$P(HLMSA,HL("FS"),3)),1)
 . ; patch HL*1.6*142
 . ; time: original message receives the application ACK
 . S $P(^HLMA(HL("MTIENS"),"S"),"^",5)=$$NOW^XLFDT
 . D DEQUE^HLCSREP($P($G(^HLMA(HL("MTIENS"),0)),"^",7),"O",HL("MTIENS"))
 . D
 .. N HLTCP ;variable to update status in file #772.
 ..;
 ..;**108**
 .. N TEMP
 .. S TEMP=HLMTIENS
 .. N HLMTIENS
 .. S HLMTIENS=TEMP
 ..;**END 108**
 ..;
 .. ; patch HL*1.6*142 start
 .. ; time: starts to process the incoming message
 .. S $P(^HLMA(HLMTIENS,"S"),"^",6)=$$NOW^XLFDT
 .. D PROCACK^HLTP2(HLMTIEN,HL("EID"),.HLRESLT,.HL)
 .. ; time: ends processing the incoming message
 .. S $P(^HLMA(HLMTIENS,"S"),"^",7)=$$NOW^XLFDT
 . ; if duplicate, and the original msg failed to
 . ; complete the processing
 . I $G(HLASTRSP) D STATUS^HLTF0(HLASTRSP,3,,,1)
 . ; patch HL*1.6*142 end
 . ;update status of incoming & unlock
 . D STATUS^HLTF0(HLMTIENS,$S($G(HLRESLT):4,1:3),$S($G(HLRESLT):+$G(HLRESLT),1:""),$S($G(HLRESLT):$P(HLRESLT,U,2),1:""),1),EXIT
 ;
 ;get entry action, exit action and processing routine
 K HLHDR,HLLD0,HLLD1,HLMSA
 I HL("EIDS")="",$G(HLEIDS)]"" S HL("EIDS")=HLEIDS ;**CIRN**
 D EVENT^HLUTIL1(HL("EIDS"),"15,20,771",.HLN)
 S HLENROU=$G(HLN(20)),HLEXROU=$G(HLN(15)),HLPROU=$G(HLN(771))
 ;quit if no processing routine,update status and quit
 I HLPROU']"" S HLRESLT="10^"_$G(^HL(771.7,10,0)) D STATUS^HLTF0(HLMTIENS,3,,,1),EXIT Q
 ;HLORNOD=subscriber protocol for Fileman auditing, ien;global ref
 N HLORNODD S HLORNOD=HL("EIDS")_";ORD(101,"
 ;Execute entry action of client protocol
 X:HLENROU]"" HLENROU K HLENROU,HLDONE1
 ;
 ; patch HL*1.6*142 start
 ; time: starts to process the incoming message
 S $P(^HLMA(HLMTIENS,"S"),"^",6)=$$NOW^XLFDT
 ;Execute processing routine
 X HLPROU S HLRESLT=0 S:($D(HLERR)) HLRESLT="9^"_HLERR
 ; time: ends processing the incoming message
 S $P(^HLMA(HLMTIENS,"S"),"^",7)=$$NOW^XLFDT
 ; if duplicate, and the original msg failed to
 ; complete the processing
 I $G(HLASTRSP) D STATUS^HLTF0(HLASTRSP,3,,,1)
 ; patch HL*1.6*142 end
 ;update status of incoming to complete & unlock
 D STATUS^HLTF0(HLMTIENS,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S(HLRESLT:$P(HLRESLT,U,2),1:""),1,$S($G(HLERR("SKIP_EVENT"))=1:1,1:0)),EXIT
 ;HLTCPO=link open, HLTCP=ien of ack msg. from GENACK
ACK I $G(HLTCPO),$G(HLTCP) D  Q
 . D LLCNT^HLCSTCP(HLDP,3)
 . ;write ack back over open tcp link
 . S X=$$WRITE^HLCSTCP2(HLTCP)
 . ;update status of ack to complete
 . D:'$G(HLASTRSP) STATUS^HLTF0(HLTCP,3,,,1)
 . D LLCNT^HLCSTCP(HLDP,4)
 Q
 ;
DEFACK(HLDP,X) ;process the deferred application ack, called from HLCSIN
 ;HLDP=logical link, X=ien in file 773
 ;
 ; patch HL*1.6*120 start
 ; clean non-Kernel variables
 D
 . ; protect variables defined in STARTIN^HLCSIN
 . N HLFLG,HLEXIT,HLPTRFLR
 . ; protect variables defined in DEFACK^HLCSIN
 . N HLXX,HLD0,HLPCT
 . ; protect input parameters of this sub-routine
 . N HLDP,X
 . D KILL^XUSCLEAN
 ; patch HL*1.6*120 end
 ;
 ;set error trap
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^HLTP3"
 N HLERR     ;patch HL*1.6*109
 Q:'$G(HLDP)!'$G(X)  Q:'$G(^HLMA(X,0))
 Q:'$D(^HLMA("AC","I",HLDP,X))
 ;
 N HL,HLA,HLD0,HLEID,HLEIDS,HLHDR,HLHDRO,HLMTIEN,HLMTIENS,HLJ,HLMSA,HLN,HLQUIT,HLNODE,HLNEXT,HLRESLT,HLRESLTA,HLTCP,HLXX,Z,HLDONE1
 S HLMTIENS=X,X=^HLMA(HLMTIENS,0),HLMTIEN=+$P(X,U),HL("MID")=$P(X,U,2),HL("MTIENS")=$P(X,U,10),HL("LL")=$P(X,U,7),HLTCP="",HL("Q")=""""""
 S HL("EIDS")=$P(X,U,8),HL("SAP")=$P(X,U,11),HL("RAP")=$P(X,U,12),HL("MTP")=$P(X,U,13),HL("ETP")=$P(X,U,14)
 S:$P(X,U,15) HL("MTP_ETP")=$P(X,U,15)
 S:HL("SAP") HL("SAN")=$P($G(^HL(771,HL("SAP"),0)),U) S:HL("RAP") HL("RAN")=$P($G(^HL(771,HL("RAP"),0)),U)
 S:HL("MTP") HL("MTN")=$P($G(^HL(771.2,HL("MTP"),0)),U) S:HL("ETP") HL("ETN")=$P($G(^HL(779.001,HL("ETP"),0)),U)
 S:$G(HL("MTP_ETP")) HL("MTN_ETN")=$P($G(^HL(779.005,HL("MTP_ETP"),0)),U)
 S HL("EID")=$P($G(^HL(772,HLMTIEN,0)),U,10)
 M HLHDRO=^HLMA(HLMTIENS,"MSH")
 ; if no header quit
 Q:'$O(HLHDRO(0))
 ;
 S HL("FS")=$E(HLHDRO(1,0),4),HL("ECH")=$$P^HLTPCK2(.HLHDRO,2),HL("SFN")=$$P^HLTPCK2(.HLHDRO,4),HL("RFN")=$$P^HLTPCK2(.HLHDRO,6),HL("DTM")=$$P^HLTPCK2(.HLHDRO,7)
 ;
 ; quit if ien of #772 is not defined
 Q:'HLMTIEN
 ; quit if field separator is not defined
 Q:HL("FS")=""
 ;
 S X=$$P^HLTPCK2(.HLHDRO,1)
 ;
 ; patch HL*1.6*120 start
 I X="MSH" D
 . S HL("PID")=$$P^HLTPCK2(.HLHDRO,11),HL("VER")=$$P^HLTPCK2(.HLHDRO,12),HL("APAT")=$$P^HLTPCK2(.HLHDRO,16),HL("CC")=$$P^HLTPCK2(.HLHDRO,17)
 . ;
 . ; 2nd component is Processing mode
 . S HL("PMOD")=$P(HL("PID"),$E(HL("ECH"),1),2)
 . ; first component is Processing id
 . S HL("PID")=$P(HL("PID"),$E(HL("ECH"),1))
 ;
 I X'="MSH" D
 . S X=$$P^HLTPCK2(.HLHDRO,9),Z=$E(HL("ECH")),HL("PID")=$P(X,Z,2),HL("VER")=$P(X,Z,4)
 . ;
 . ; original code incorrectly treats repetition separator as
 . ; subcomponent separator
 . I $E(HL("ECH"),2)]"",X[$E(HL("ECH"),2) D
 .. S HL("SUB-COMPONENT")=$E(HL("ECH"),2)
 . ; if subcomponent separator is correctly applied
 . I $E(HL("ECH"),4)]"",X[$E(HL("ECH"),4) D
 .. S HL("SUB-COMPONENT")=$E(HL("ECH"),4)
 . ;
 . I $D(HL("SUB-COMPONENT")),HL("PID")[HL("SUB-COMPONENT") D
 .. ; 2nd sub-component is Processing mode
 .. S HL("PMOD")=$P(HL("PID"),HL("SUB-COMPONENT"),2)
 .. ; first sub-component is Processing id
 .. S HL("PID")=$P(HL("PID"),HL("SUB-COMPONENT"))
 . ; patch HL*1.6*120 end
 . ;
 . Q:$$P^HLTPCK2(.HLHDRO,10)=""
 . ;HLMSA=ack code^id^text
 . S HLMSA=$P($$P^HLTPCK2(.HLHDRO,10),$E(HL("ECH")),1),$P(HLMSA,HL("FS"),2)=$$P^HLTPCK2(.HLHDRO,12),$P(HLMSA,HL("FS"),3)=$P($$P^HLTPCK2(.HLHDRO,10),$E(HL("ECH")),2),HL("MSAID")=$P(HLMSA,HL("FS"),2)
 ;
 ; quit if this is a commit ack
 I $P($G(^HL(772,HLMTIEN,"IN",1,0)),HL("FS"),1)="MSA",$E($P($G(^HL(772,HLMTIEN,"IN",1,0)),HL("FS"),2))="C" Q
 ;
 ;**  HL*1.6*117 **
 K HLL("SET FOR APP ACK"),HLL("LINKS")
 ;
 D CONT
 Q
 ;
MSA(Y) ;Y=ien in 772, returns MSA segment
 ;ack code^msg being ack id^text
 ; patch HL*1.6*122
 ; for HL7 v2.5 and beyond with MSA as 3rd segment
 N X,SUBIEN,DATA,DONE
 S X=$G(^HL(772,Y,"IN",1,0)),X=$S($E(X,1,3)="MSA":$E(X,5,999),1:"")
 Q:X]"" X
 ;
 S DONE=0
 S SUBIEN=1
 F  S SUBIEN=$O(^HL(772,Y,"IN",SUBIEN)) Q:'SUBIEN  D  Q:DONE
 . S DATA=$G(^HL(772,Y,"IN",SUBIEN,0)) I DATA="" D
 .. S DONE=1
 .. S SUBIEN=$O(^HL(772,Y,"IN",SUBIEN)) Q:'SUBIEN
 .. S X=$G(^HL(772,Y,"IN",SUBIEN,0)),X=$S($E(X,1,3)="MSA":$E(X,5,999),1:"")
 ; patch HL*1.6*122 end
 ;
 Q X
 ;
ERROR ;error trap
 D ^%ZTER
 I $G(HLMTIENS),$D(^HLMA(HLMTIENS,0)) D STATUS^HLTF0(HLMTIENS,4,,,1),EXIT
 ; release locks created by inbound filer
 ; patch HL*1.6*140
 ; L -^HLMA("AC","I",+$G(HLXX))
 L -^HLMA("IN-FILER","AC","I",+$G(HLXX))
 G UNWIND^%ZTER
 ;
 ;
EXIT ;unlock
 I $G(HLMTIENS) L -^HLMA(HLMTIENS)
 Q
 ;
ONAC(IEN773) ;
 ;Returns 1 if the message is on the "AC","I" xref
 ;Returns 0 otherwise
 ;
 N LINK
 S LINK=$P($G(^HLMA(IEN773,0)),"^",17)
 Q:'LINK 0
 Q $D(^HLMA("AC","I",LINK,IEN773))
