HLTP31 ;SFIRMFO/RSD - Cont. Transaction Processor for TCP ;07/08/2009  15:33
 ;;1.6;HEALTH LEVEL SEVEN;**57,58,66,109,120,145**;Oct 13, 1995;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 Q
RSP(X,HLN) ;process response msg. X=ien in 773^msg. ien in 772
 ;HLN=HL array for original message
 ;HLMTIEN=ien in 772,  HLMTIENS=ien in 773
 ;returns - 0=resend msg, 1=commit ack, 3=app ack success, 4=error
 ;set error trap
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^HLTP3"
 N HLERR,HLHDR,HLMSA,HLMTIEN,HLMTIENS,HLQUIT,HLNODE,HLNEXT,HLRESLTA
 D INIT^HLTP3A  ;patch HL*1.6*109: hltp3 routine split
 ;Quit processing if error with header
 I $G(HLRESLT) D EXIT Q 0
 ;must have MSA segment
 I '$L(HLMSA) D RSPER(4,108,"Missing MSA segment") Q 0
 ;msg. id in MSA must match original msg. id, if not reject
 I $P(HLMSA,HL("FS"),2)'=HLN("MID") D RSPER(4,108,"Incorrect msg. Id") Q 0
 ;rec. app. must match sending app. of original message.
 I HL("RAN")'=HLN("SAN") D RSPER(4,108,"Incorrect sending app.") Q 0
 ;get ack code
 S HL("ACKCD")=$P(HLMSA,HL("FS"))
 ;update LL, rec. 1 msg
 D LLCNT^HLCSTCP(HLDP,1)
 ;commit ack
 I $E(HL("ACKCD"))="C" D  Q X
 . ;update LL, processed 1 msg
 . D LLCNT^HLCSTCP(HLDP,2)
 . ;received an error ack, return NAK
 . S:$E(HL("ACKCD"),2)'="A" HLRESLT=102_U_$P(HLMSA,HL("FS"),3)
 . D RSPER(3) S X=$S($E(HL("ACKCD"),2)="A":1,1:4)
 ;app. ack, received an error ack, NAK
 S:$E(HL("ACKCD"),2)'="A" HLRESLT=102_U_$P(HLMSA,HL("FS"),3)
 ;Set special HL variables
 S HLQUIT=0,HLNODE="",HLNEXT="D HLNEXT^HLCSUTL"
 ;HLORNOD=subscriber protocol for Fileman auditing, ien;global ref
 N HLORNODD S HLORNOD=HL("EIDS")_";ORD(101,"
 ;process ack
 D
 . N HLTCP ;Newed variable to update status in 772.
 . ; patch HL*1.6*145
 . ; time: starts to process the incoming message
 . I $G(HLMTIENS) S $P(^HLMA(+HLMTIENS,"S"),"^",6)=$$NOW^XLFDT
 . D PROCACK^HLTP2(HLMTIEN,HL("EID"),.HLRESLT,.HL)
 . ; time: ends processing the incoming message
 . I $G(HLMTIENS) S $P(^HLMA(+HLMTIENS,"S"),"^",7)=$$NOW^XLFDT
 ;update LL, processed 1 msg
 D LLCNT^HLCSTCP(HLDP,2)
 ;process ack successfully
 D RSPER(3)
 ;HLRESELT is defined for errors
 Q $S($G(HLRESLT):4,1:3)
 ;
RSPER(HLST,HLER,HLERM) ;HLST=status, HLER=error type, HLERM=error msg.
 D STATUS^HLTF0(HLMTIENS,HLST,$G(HLER),$G(HLERM),1)
 S:$G(HLER) HLRESLT=HLER_U_HLERM
 D EXIT
 Q
EXIT ;unlock
 ;**109**
 ;I $G(HLMTIENS) L -^HLMA(HLMTIENS)
 Q
 ;
SETINQUE ;
 ;**HL*1.6*109***
 ;Called from HLTP3 for message that utilize enhanced mode - NOT original mode
 ;Sets the incoming message on the in queue.
 ;Does not use the listener, instead, arranges multiple in-queues
 ;by using the sending link.
 ;
 N HLI,HLINST,HLDOMAIN,HLLINK
 ;
 ;Override value of logical link based on sending facility to create
 ;a queue (^HLMA("AC","I",llnk ien,msg ien)) different than that of the 
 ;listener
 S HLINST=$P(HL("SFN"),$E(HL("ECH")))
 S HLDOMAIN=$P(HL("SFN"),$E(HL("ECH")),2)
 ;
 ; patch HL*1.6*120 start
 ; assume the format is <domain>:<port #>
 I HLDOMAIN[":" S HL("PORT")=$P(HLDOMAIN,":",2)
 S HLDOMAIN=$P(HLDOMAIN,":")
 S HL("DOMAIN")=HLDOMAIN
 ; change from lower case to upper case
 S HLDOMAIN=$$UP^XLFSTR(HLDOMAIN)
 ; if first piece of domain is "HL7." or "MPI.", remove it
 I ($E(HLDOMAIN,1,4)="HL7.")!($E(HLDOMAIN,1,4)="MPI.") D
 . S HLDOMAIN=$P(HLDOMAIN,".",2,99)
 ; patch HL*1.6*120 end
 ;
 I HLDOMAIN]"" D    ;logical link lookup by domain
 . D LINK^HLUTIL3(HLDOMAIN,.HLI,"D")
 . S HLLINK=$O(HLI(0)) ;client link for sending facility
 ;logical link lookup by station number
 I $G(HLLINK)']"",HLINST]"" D
 . D LINK^HLUTIL3(HLINST,.HLI,"I")
 . S HLLINK=$O(HLI(0)) ;client link for sending facility
 ;
 ; patch HL*1.6*120 start
 ;logical link lookup by DNS domain
 I $G(HLLINK)']"",HL("DOMAIN")]"" D
 . I $D(^HLCS(870,"DNS",HL("DOMAIN"))) D  Q
 .. S HLLINK=+$O(^HLCS(870,"DNS",HL("DOMAIN"),0))
 . I $D(^HLCS(870,"DNS",$$UP^XLFSTR(HL("DOMAIN")))) D  Q
 .. S HLLINK=+$O(^HLCS(870,"DNS",$$UP^XLFSTR(HL("DOMAIN")),0))
 . I $D(^HLCS(870,"DNS",$$LOW^XLFSTR(HL("DOMAIN")))) D
 .. S HLLINK=+$O(^HLCS(870,"DNS",$$LOW^XLFSTR(HL("DOMAIN")),0))
 ;
 ;logical link lookup by ip address
 I $G(HLLINK)']"",HL("DOMAIN") D
 . S HLLINK=$O(^HLCS(870,"IP",HL("DOMAIN"),0))
 ; patch HL*1.6*120 end
 ;
 ; find the logical link of the subscriber protocol
 ; then set the link field of this message to the link
 I $G(HL("EIDS")),$P(^ORD(101,HL("EIDS"),770),"^",7) S HLLINK=$P(^ORD(101,HL("EIDS"),770),"^",7)
 ;
 ; patch HL*1.6*145 start
 F  L +^HLMA(HLMTIENS,0):10 Q:$T  H 1
 N COUNT
 F COUNT=1:1:15 Q:($G(^HLMA(HLMTIENS,0))]"")  H COUNT
 I $L($G(HLLINK)) D
 .D ENQUE^HLCSREP(HLLINK,"I",HLMTIENS)
 .; move message from listener queue to client link queue
 .S HLDP("HLLINK")=HLLINK
 .D LLCNT^HLCSTCP(HLDP,1,1)
 .D LLCNT^HLCSTCP(HLLINK,1)
 .S $P(^HLMA(HLMTIENS,0),"^",17)=HLLINK
 E  D
 .D ENQUE^HLCSREP(HLDP,"I",HLMTIENS)
 .S $P(^HLMA(HLMTIENS,0),"^",17)=HLDP
 S HLDP("SETINQUE")=1
 L -^HLMA(HLMTIENS,0)
 ; patch HL*1.6*145 end
 Q
