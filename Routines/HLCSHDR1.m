HLCSHDR1 ;SFIRMFO/RSD - Make HL7 header for TCP ;04/17/2007
 ;;1.6;HEALTH LEVEL SEVEN;**19,57,59,72,80,93,120,133,122**;Oct 13, 1995;Build 14
 ;Per VHA Directive 2004-038, this routine should not be modified.
HEADER(IEN,CLIENT,HLERROR) ; Create an HL7 MSH segment
 ;
 ;Input  : IEN - Pointer to entry in Message Administration file (#773)
 ;               that HL7 MSH segment is being built for
 ;         CLIENT - IEN of the receiving application
 ;         HLERROR - Variable to return possible error text in
 ;                   (pass by reference - only used when needed)
 ;
 ;Output : HLHDR(1) - HL7 MSH segment
 ;         HLHDR(2) - Continuation of HL7 MSH segment (if needed)
 ;         HLHDR(3) - Continuation of HL7 MSH segment (if needed)
 ;
 ;Notes  : HLERROR will only be defined [on output] if an error occurs
 ;       : HLHDR() will not be defined [on output] if an error occurs
 ;       : HLHDR(2) & HLHDR(3) are continuation [or roll-over] nodes
 ;         and will only be used/defined when needed
 ;
 N ACKTO,ACCACK,APPACK,CHILD,CLNTAPP,CLNTFAC,CNTRY,EC,EVNTYPE,FS,HLDATE,HLHDRI,HLHDRL,HLID,HLPID,MSGTYPE,PROT,PROTS,SECURITY,SEND,SERAPP,SERFAC,TXTP,TXTP0,X,MSGEVN
 N COMFLAG ; patch HL*1.6*120
 S HLERROR=""
 S HLPARAM=$$PARAM^HLCS2
 D VAR Q:$G(HLERROR)]""
 ; The following line commented by HL*1.6*72
 ;I $D(^HLMA(IEN)) S $P(^HLMA(IEN,0),U,13)=MSGTYPE,$P(^HLMA(IEN,0),U,14)=$G(EVNTYPE)
 ;Append event type
 I $G(EVNTYPE)]"" S MSGTYPE=MSGTYPE_$E(EC,1)_EVNTYPE
 ;Append message structure component
 I $G(EVNTYPE)]"",$G(MSGEVN)]"" S MSGTYPE=MSGTYPE_$E(EC,1)_MSGEVN
 ;Build MSH array
 D RESET^HLCSHDR3 ;HL*1.6*93
 ;
 ; patch HL*1.6*120 start
 ; escape delimiters for SERAPP and CLNTAPP
 ; escape component separator if the field is not consisted
 ; of 3 components
 S EC(1)=$E(EC,1)
 S EC(2)=$E(EC,2)
 S EC(3)=$E(EC,3)
 S EC(4)=$E(EC,4)
 S COMFLAG=1
 I $L(SERAPP,$E(EC,1))=3 S COMFLAG=0
 I (SERAPP[FS)!(SERAPP[EC(1))!(SERAPP[EC(2))!(SERAPP[EC(3))!(SERAPP[EC(4)) D
 . S SERAPP=$$ESCAPE(SERAPP,COMFLAG)
 S COMFLAG=1
 I $L(CLNTAPP,$E(EC,1))=3 S COMFLAG=0
 I (CLNTAPP[FS)!(CLNTAPP[EC(1))!(CLNTAPP[EC(2))!(CLNTAPP[EC(3))!(CLNTAPP[EC(4)) D
 . S CLNTAPP=$$ESCAPE(CLNTAPP,COMFLAG)
 ; patch HL*1.6*120 end
 ;
 S HLHDRI=1,HLHDR(1)="MSH"_FS_EC_FS_SERAPP,HLHDRL=$L(HLHDR(1))
 F X=SERFAC,CLNTAPP,CLNTFAC,HLDATE,SECURITY,MSGTYPE,HLID,HLPID,$P(PROT,U,9),"",$G(^HL(772,TXTP,1)),ACCACK,APPACK,CNTRY D MSH(X)
 ;in preceeding line, "" is for sequence number - not supported
 Q
 ;
MSH(X) ;add X to HLHDR
 S:HLHDRL+$L(X)>245 HLHDRI=HLHDRI+1,HLHDR(HLHDRI)=""
 S HLHDR(HLHDRI)=HLHDR(HLHDRI)_FS_X,HLHDRL=$L(HLHDR(HLHDRI))
 Q
BHSHDR(IEN,CLIENT,HLERROR) ; Create Batch Header Segment
 ; The BHS has 12 segments, of which 4 are blank.
 ; INPUT: IEN - IEN of entry in file #772
 ; OUTPUT: HLHDR(1) and HLHDR(2) - the two lines with the 12 segs.
 ;   ready for adding to a message directly.
 N ACKTO,ACCACK,ACKMID,APPACK,BNAME,BSTATUS,BTACK,CHILD,CLNTAPP ;HL*1.6*80
 N CLNTFAC,CNTRY,EC,EVNTYPE,FS,HLDATE,HLHDRI,HLHDRL,HLID,HLPID ;HL*1.6*80 - added HLPID
 N PROT,PROTS,SECURITY,SEND,SERAPP,SERFAC,TXTP,TXTP0,X ;HL*1.6*80
 N COMFLAG ; patch HL*1.6*120
 S HLERROR=""
 ;
 S HLPARAM=$$PARAM^HLCS2
 D VAR Q:$G(HLERROR)]""
 ; The following line commented by HL*1.6*72
 ;I $D(^HLMA(IEN)) S $P(^HLMA(IEN,0),U,13)=MSGTYPE,$P(^HLMA(IEN,0),U,14)=$G(EVNTYPE)
 ;
 ;Append event type
 I $G(EVNTYPE)]"" S MSGTYPE=MSGTYPE_$E(EC,2)_EVNTYPE,(ACKMID,BTACK)=""
 ;batch/name/id/type(#9)=null~process ID~msg type|evnt type~version~CA~AA
 S BNAME=$E(EC,1)_HLPID_$E(EC,1)_MSGTYPE_$E(EC,1)_$P(PROT,U,9)_$E(EC,1)_ACCACK_$E(EC,1)_APPACK ;HL*1.6*80
 ;for batch ACK
 I ACKTO D  S BTACK=X_$E(EC,1)_$P(BSTATUS,U,3)
 . ;get msg id and status of message that is being ACKed
 . S ACKMID=$P($G(^HLMA(ACKTO,0)),U,2),BSTATUS=$G(^HLMA(ACKTO,"P")) ;HL*1.6*80
 . ;set type of ACK based on status
 . S X=$S(ACKMID="":"AR",(BSTATUS>3)&(BSTATUS<8):"AE",1:"AA")
 ;
 D RESET^HLCSHDR3 ;HL*1.6*93
 ;
 ; patch HL*1.6*120 start
 ; escape delimiters for SERAPP and CLNTAPP
 ; escape component separator if the field is not consisted
 ; of 3 components
 S EC(1)=$E(EC,1)
 S EC(2)=$E(EC,2)
 S EC(3)=$E(EC,3)
 S EC(4)=$E(EC,4)
 S COMFLAG=1
 I $L(SERAPP,$E(EC,1))=3 S COMFLAG=0
 I (SERAPP[FS)!(SERAPP[EC(1))!(SERAPP[EC(2))!(SERAPP[EC(3))!(SERAPP[EC(4)) D
 . S SERAPP=$$ESCAPE(SERAPP,COMFLAG)
 S COMFLAG=1
 I $L(CLNTAPP,$E(EC,1))=3 S COMFLAG=0
 I (CLNTAPP[FS)!(CLNTAPP[EC(1))!(CLNTAPP[EC(2))!(CLNTAPP[EC(3))!(CLNTAPP[EC(4)) D
 . S CLNTAPP=$$ESCAPE(CLNTAPP,COMFLAG)
 ; patch HL*1.6*120 end
 ;
 S HLHDRI=1,HLHDR(1)="BHS"_FS_EC_FS_SERAPP,HLHDRL=$L(HLHDR(1))
 F X=SERFAC,CLNTAPP,CLNTFAC,HLDATE,SECURITY,BNAME,BTACK,HLID,ACKMID D MSH(X)
 Q
VAR ;Check input
 N APPPRM,HLPROTS,HLPROT
 S IEN=+$G(IEN)
 I '$G(^HLMA(IEN,0)) S HLERROR="Valid pointer to Message Administration file (#772) not passed" Q
 I '$G(CLIENT) S HLERROR="Could not determine receiving application" Q
 ;Get child, text pointer,text entry, and sending app.
 S CHILD=$G(^HLMA(IEN,0)),SEND=+$P($G(^(0)),U,11),TXTP=+CHILD,TXTP0=$G(^HL(772,TXTP,0))
 I ('SEND) S HLERROR="Could not determine sending application" Q
 ;Get info for sending & receiving applications
 D APPPRM^HLUTIL2(CLIENT),APPPRM^HLUTIL2(SEND)
 ;Get name of sending application, facility, and country
 S SERAPP=$P(APPPRM(SEND,0),U),SERFAC=$P(APPPRM(SEND,0),U,2),CNTRY=$P(APPPRM(SEND,0),U,3)
 ;Get name of receiving application and facility
 S CLNTAPP=$P(APPPRM(CLIENT,0),U),CLNTFAC=$P(APPPRM(CLIENT,0),U,2)
 ;
 ; patch HL*1.6*120
 ; for dynamic addressing, overide the receiving facility from the
 ; 3rd component of HLL("LINKS") array
 I $G(HLP("REC-FACILITY"))]"" S CLNTFAC=HLP("REC-FACILITY")
 ;
 ;Get field separator & encoding characters
 S FS=APPPRM(SEND,"FS"),EC=APPPRM(SEND,"EC")
 S:(EC="") EC="~|\&" S:(FS="") FS="^"
 ;Determine if it's a response/ACK to another message
 S ACKTO=+$P(CHILD,U,10)
 ;subscriber protocol is from child (file 773)
 ;If response, get MType from subscriber
 S HLPROTS=+$P(CHILD,U,8)
 S PROTS=$$TYPE^HLUTIL2(HLPROTS)
 I ACKTO S MSGTYPE=$P(PROTS,U,10),EVNTYPE=$P(PROTS,U,3),MSGEVN=$P(PROTS,U,4)
 ;Get accept ack & application ack type (based on server protocol) it
 ; is always in file 772, TXPT0
 ;If original message, get MT from Event Driver Protocol
 S HLPROT=+$P(TXTP0,U,10)
 S PROT=$$TYPE^HLUTIL2(HLPROT)
 S:'ACKTO MSGTYPE=$P(PROT,U,2),EVNTYPE=$P(PROT,U,3),MSGEVN=$P(PROT,U,4)
 S ACCACK=$P(PROT,U,7),APPACK=$P(PROT,U,8)
 ;
 ; patch HL*1.6*122
 ; setting the MSH-15 and MSH-16 from subscriber protocol
 I HLPROTS,$P($G(^ORD(101,HLPROTS,773)),"^",5) D
 . S ACCACK=$P(PROTS,U,7)
 . S APPACK=$P(PROTS,U,8)
 ;
PID ;Processing ID
 ;I PID not 'debug' get from site params
 ;If event driver set to 'debug' get from protocol
 ;'production' or 'training' comes from site params
 S HLPID=$P(PROT,U,5)
 I $G(HLPID)'="D" S HLPID=$P(HLPARAM,U,3)
 ;
 ; patch HL*1.6*120: to include processing mode
 I $G(HLP("PMOD"))]"",($G(HLTYPE)="M") D
 . S HLPID=HLPID_$E($G(EC),1)_HLP("PMOD")
 ;
 I $G(HLPID)="" S HLERROR="Missing processing ID Site parameter."
 ;acknowledgements have no application ack, link open no commit ack
 I ACKTO S:APPACK]"" APPACK="NE" S:ACCACK]""&$G(HLTCPO) ACCACK="NE"
 ;Get date/time, Message ID, and security
 S HLDATE=+TXTP0,HLDATE=$$FMTHL7^XLFDT(HLDATE),HLID=$P(CHILD,U,2),SECURITY=$P(CHILD,U,9)
HDR23 ;generate extended facility field info based on 'facility required'
 ;default format is INSTITUTION_HLCS_DOMAIN_HLCS_'DNS'
 ;application parameter entry overrides default
 N HLEP773,HLS773
 S SERFAC=$G(SERFAC),CLNTFAC=$G(CLNTFAC)
 S HLEP773=+$G(^ORD(101,HLPROTS,773))
 S HLS773=+$P($G(^ORD(101,HLPROTS,773)),U,2)
 Q:'HLEP773&('HLS773)
 D GEN^HLCSHDR2
 I ACKTO D  Q
 .;Find original message
 .S X=$G(^HLMA(ACKTO,"MSH",1,0)) ;Find header in TCP nodes
 .I X["MSH" D
 ..;
 ..; patch HL*1.6*120 start
 .. N HLEC
 ..S HLFS=$E(X,4),HLEC=$E(X,5)
 ..S SENDFAC=$P(X,HLFS,4),RECFAC=$P(X,HLFS,6) ;from original msg
 ..S CLNTFAC=SENDFAC,SERFAC=RECFAC ;reverse facility info
 ..S EC("COMPONENT")=$E($G(EC),1)
 ..I $L(EC("COMPONENT"))=1,$L(HLEC)=1,EC("COMPONENT")'=HLEC D
 ... ; change the the component separator in the sending and
 ... ; receiving facilities for the outgoing message
 ... S CLNTFAC=$TR(CLNTFAC,HLEC,EC("COMPONENT"))
 ... S SERFAC=$TR(SERFAC,HLEC,EC("COMPONENT"))
 ; patch HL*1.6*120 end
 ;
 I HLEP773,SERFAC="" D EP^HLCSHDR2
 I HLS773,CLNTFAC="" D S^HLCSHDR2
 Q
 ;
ESCAPE(INPUT,COMPONET) ;
 ; patch HL*1.6*120 - escape delimiters:
 ; - field separator
 ; - component separator
 ; - repetition separator
 ; - escape character
 ; - subcomponent separator
 ;
 ; input: 
 ;     INPUT - string data to be escaped
 ;  COMPONET - if 1, escape component separator
 ;             if 0, do not escape component separator
 ;        FS - field separator character
 ;        EC - encoding characters 
 ; result: return the escaped string
 ;
 N HLDATA,HLESCAPE,HLI,HLCHAR,HLEN,HLOUT,COMFLAG
 S HLDATA=$G(INPUT)
 S COMFLAG=$G(COMPONET)
 Q:$L($G(FS))'=1 HLDATA
 ;
 ; patch HL*1.6*133
 ; Q:$L($G(EC))'=4 HLDATA
 Q:($L($G(EC))<3) HLDATA
 Q:HLDATA']"" HLDATA
 ;
 S HLESCAPE=FS_EC
 S HLESCAPE("F")=FS
 S HLESCAPE("S")=$E(EC,1)
 S HLESCAPE("R")=$E(EC,2)
 S HLESCAPE("E")=$E(EC,3)
 S HLESCAPE("T")=$E(EC,4)
 S HLEN=$L(HLDATA)
 S HLOUT=""
 F HLI=1:1:HLEN D
 . S HLCHAR=$E(HLDATA,HLI)
 . I HLESCAPE[HLCHAR D  Q
 .. I HLCHAR=HLESCAPE("F") S HLOUT=HLOUT_HLESCAPE("E")_"F"_HLESCAPE("E") Q
 .. I HLCHAR=HLESCAPE("S") D  Q
 ... I COMFLAG=1 S HLOUT=HLOUT_HLESCAPE("E")_"S"_HLESCAPE("E") Q
 ... S HLOUT=HLOUT_HLCHAR
 .. I HLCHAR=HLESCAPE("R") S HLOUT=HLOUT_HLESCAPE("E")_"R"_HLESCAPE("E") Q
 .. I HLCHAR=HLESCAPE("E") S HLOUT=HLOUT_HLESCAPE("E")_"E"_HLESCAPE("E") Q
 .. I HLCHAR=HLESCAPE("T") S HLOUT=HLOUT_HLESCAPE("E")_"T"_HLESCAPE("E") Q
 . ;
 . S HLOUT=HLOUT_HLCHAR
 Q HLOUT
