HLCSHDR ;  ALB/MFK,JRP - Make HL7 header from a #772 IEN ;05/31/2000  08:59
 ;;1.6;HEALTH LEVEL SEVEN;**37,19,57,59,65,80**;Oct 13, 1995
HEADER(IEN,HLERROR) ; Create an HL7 MSH segment
 ;
 ;Input  : IEN - Pointer to entry in Message Text file (#772) that
 ;               HL7 MSH segment is being built for
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
 ;Check input
 S IEN=+$G(IEN)
 I ('$D(^HL(772,IEN,0))) S HLERROR="Valid pointer to Message Text file (#772) not passed" Q
 ;Declare variables
 N PROTOCOL,PARENTP,PARENT,SERVERP,CLIENTP,FS,PROT,MSGTYPE,APPPRM
 N HLDTID,HLID,HLDATE,SECURITY,ID,SERAPP,SERFAC,EC,ACCACK,APPACK
 N CHILD,CLNTAPP,CLNTFAC,ACKTO,CNTRY,HLPROT,HLPROTS,HLPARAM
 ;Get Site Parameters
 S HLPARAM=$$PARAM^HLCS2
 ;Get parent message (NOTE: Original message is it's own parent)
 S CHILD=$G(^HL(772,IEN,0))
 I CHILD="" S HLERROR="Valid pointer to Message Text file (#772) not passed" Q
 S PARENTP=+$P(CHILD,"^",8)
 I ('PARENTP) S HLERROR="Could not determine parent message" Q
 S PARENT=$G(^HL(772,PARENTP,0))
 ;Get server [sending] & client [receiving] applications
 S SERVERP=+$P(PARENT,"^",2)
 I ('SERVERP) S HLERROR="Could not determine sending application" Q
 S CLIENTP=+$P(CHILD,"^",3)
 I ('CLIENTP) S HLERROR="Could not determine receiving application" Q
 ;Get info for sending & receiving applications
 D APPPRM^HLUTIL2(CLIENTP)
 D APPPRM^HLUTIL2(SERVERP)
 ;Get name of sending application and facility
 S SERAPP=$P(APPPRM(SERVERP,0),"^",1)
 S SERFAC=$P(APPPRM(SERVERP,0),"^",2)
 ;Get name of receiving application and facility
 S CLNTAPP=$P(APPPRM(CLIENTP,0),"^",1)
 S CLNTFAC=$P(APPPRM(CLIENTP,0),"^",2)
 ;Get country
 S CNTRY=$P(APPPRM(SERVERP,0),"^",3)
 ;Get field seperator & encoding characters
 S FS=APPPRM(SERVERP,"FS")
 S EC=APPPRM(SERVERP,"EC")
 S:(EC="") EC="~|\&"
 S:(FS="") FS="^"
 ;
 ;Determine if it's a response/ACK to another message
 ;
 S ACKTO=+$P(PARENT,"^",7)
 ;
 ;Get message type
 ;Message type/Event Type of Initiator found on Event Driver
 ;Message type/Event Type of Responder found on Subscriber
 ;
 S PROT=+$P(PARENT,"^",10),HLPROT=PROT
 ;commented the next line to get ack message to have the correct header
 ;S:ACKTO&($G(HLOGLINK)) PROT=+$P(CHILD,"^",10)
 S PROTOCOL=$$TYPE^HLUTIL2(PROT)
 ;if initiating a new transaction, get MsgType from Event Driver, field 770.3
 ;if generating a response, get MsgType from subscriber, field 770.11
 S MSGTYPE=$S(ACKTO:$P(PROTOCOL,"^",10),1:$P(PROTOCOL,"^",2))
 ;Append event type
 I MSGTYPE']"" S HLERROR="Message Type Undefined for protocol "_$P(PROTOCOL,"^",1) Q
 I $P(PROTOCOL,"^",3)]"" S MSGTYPE=MSGTYPE_$E(EC,1)_$P(PROTOCOL,"^",3)
 ;Append mesaage structure component
 I $P(PROTOCOL,"^",3)]"",$P(PROTOCOL,"^",4)]"" S MSGTYPE=MSGTYPE_$E(EC,1)_$P(PROTOCOL,"^",4)
 ;Get accept ack & application ack type (based on server protocol)
 ;  Originating messages have it listed in the parent message
 ;  Responses/ACKs have it listed in the child message
 S PROT=+$P(PARENT,"^",10),HLPROT=PROT
 S:(ACKTO) PROT=+$P(CHILD,"^",10)
 S HLPROTS=+$P(CHILD,"^",10)
 S PROTOCOL=$$TYPE^HLUTIL2(PROT)
 S ACCACK=$P(PROTOCOL,"^",7)
 S APPACK=$P(PROTOCOL,"^",8)
 ;Get date/time & message ID
 S HLDATE=+PARENT
 S HLDATE=$$FMTHL7^XLFDT(HLDATE)
MID ;Message ID
 S HLID=$P(PARENT,"^",6)
PID ;Processing ID
 ;If event driver set to 'debug' get from protocol
 ;'production' or 'training' comes from site params
 S HLPID=$P(PROTOCOL,"^",5)
 I $G(HLPID)'="D" S HLPID=$P(HLPARAM,U,3)
 I $G(HLPID)="" S HLERROR="Missing Processing ID Site Parameter."
 ;Get security info
 S SECURITY=$P(PARENT,"^",12)
 D HDR23
 ;Build MSH array
 S HLHDR(1)="MSH"_FS_EC_FS_SERAPP_FS_SERFAC_FS_CLNTAPP_FS_CLNTFAC_FS
 S HLHDR(1)=HLHDR(1)_HLDATE_FS_SECURITY_FS_MSGTYPE_FS_HLID_FS
 S HLHDR(1)=HLHDR(1)_HLPID_FS_$P(PROTOCOL,"^",9)_FS_FS
 S HLHDR(2)=$G(^HL(772,PARENT,1))_FS
 S HLHDR(3)=ACCACK_FS_APPACK_FS_CNTRY
 ;Combine line 1 & 2 (if possible)
 I (($L(HLHDR(1))+$L(HLHDR(2)))'>245) D
 .S HLHDR(1)=HLHDR(1)_HLHDR(2)
 .S HLHDR(2)=HLHDR(3)
 .S HLHDR(3)=""
 .;Add original line 3 (if possible)
 .I (($L(HLHDR(1))+$L(HLHDR(2)))'>245) D
 ..S HLHDR(1)=HLHDR(1)_HLHDR(2)
 ..S HLHDR(2)=""
 ;Combine line 2 & 3 (if possible)
 I (($L(HLHDR(2))+$L(HLHDR(3)))'>245) D
 .S HLHDR(2)=HLHDR(2)_HLHDR(3)
 .S HLHDR(3)=""
 ;Delete unused lines
 K:(HLHDR(2)="") HLHDR(2)
 K:(HLHDR(3)="") HLHDR(3)
 Q
BHSHDR(IEN) ; Create Batch Header Segment
 ; The BHS has 12 segments, of which 4 are blank.
 ; INPUT: IEN - IEN of entry in file #772
 ; OUTPUT: HLHDR(1) and HLHDR(2) - the two lines with the 12 segs.
 ;   ready for adding to a message directly.
 N ACKMID,ACKTO,APPPRM,BC,BCD,BCI,BEC,BFS,BN,BRA,BRF,BS,BSA,BSF ;HL*1.6*80
 N BSTATUS,BTACK,CHILD,CLIENTP,HLDATE,HLDTID,HLPID,ID,PARENT,PARENTP ;HL*1.6*80
 N RBCI,SERVERP ;HL*1.6*80
 S CHILD=$G(^HL(772,IEN,0))
 S PARENTP=$P(CHILD,"^",8)
 I (PARENTP="") S HLHDR(1)="-1^No parent" Q
 S PARENT=$G(^HL(772,PARENTP,0))
 S SERVERP=$P(PARENT,"^",2)
 I (SERVERP="") S HLHDR(1)="-1^No server for this node" Q
 S CLIENTP=$P(CHILD,"^",3)
 I (CLIENTP="") S HLHDR(1)="-1^No client for this node" Q
 ;--  get server and application parameters
 D APPPRM^HLUTIL2(SERVERP)
 D APPPRM^HLUTIL2(CLIENTP)
 S BFS=APPPRM(SERVERP,"FS")
 S BEC=APPPRM(SERVERP,"EC")
 ;-- sending application
 S BSA=$P(APPPRM(SERVERP,0),"^",1)
 ;-- sending facility
 S BSF=$P(APPPRM(SERVERP,0),"^",2)
 ;-- receiving application
 S BRA=$P(APPPRM(CLIENTP,0),"^",1)
 ;-- receiving facility
 S BRF=$P(APPPRM(CLIENTP,0),"^",2)
 S HLDATE=+PARENT
 S HLID=$P(PARENT,"^",6)
 S BCD=$$HLDATE^HLFNC(HLDATE,"TS")
 ;-- batch security
 S BS=$P(PARENT,"^",12)
 ;-- build batch field #9  NULL~Process ID~Message Type|Event Type~version
 S ACKTO=$P(PARENT,"^",7)
 S PROT=$S((ACKTO&$G(HLOGLINK)):$P(CHILD,"^",10),1:$P(PARENT,"^",10))
 ;S X=$$TYPE^HLUTIL2($P(CHILD,U,10))
 ; for batch ACK message, client protocol pointer is stored in parent message
 ;I ACKTO S X=$$TYPE^HLUTIL2($P(PARENT,U,10))
 S X=$$TYPE^HLUTIL2(PROT)
 S MSGTYPE=$S(ACKTO:$P(X,"^",10),1:$P(X,"^",2))
 I MSGTYPE']"" S HLERROR="MType undefined for protocol "_$P(X,U) Q
 I $P(X,U,3)]"" S MSGTYPE=MSGTYPE_$E(BEC,2)_$P(X,U,3)
 ;S BN=$E(BEC,1)_$P(X,U,5)_$E(BEC,1)_$S('$P(CHILD,"^",11)&('ACKTO):$P(X,U,2),1:$P(X,U,10))_$E(BEC,2)_$P(X,U,3)_$E(BEC,1)_$P(X,U,9)
 S HLPID=$$PIDCK($P($G(^HL(772,+PROT,0)),U,10)) QUIT:$G(HLERROR)]""  ;HL*1.6*80
 S BN=$E(BEC,1)_HLPID_$E(BEC,1)_MSGTYPE_$E(BEC,1)_$P(X,U,9) ;HL*1.6*80
 ;
 ; for batch ACK message
 S ACKMID="",BTACK=""
 I ACKTO D
 . S ACKMID=$P($G(^HL(772,ACKTO,0)),"^",6)
 . S BSTATUS=$P($G(^HL(772,ACKTO,"P")),"^")
 . S BTACK="AR"
 . I ACKMID]"" D
 .. S BTACK="AA"
 .. I (BSTATUS>3)&(BSTATUS<8) S BTACK="AE"_$E(BEC,1)_$P($G(^HL(772,ACKTO,"P")),"^",3)
 ;
 S HLHDR(1)="BHS"_BFS_BEC_BFS_BSA_BFS_BSF_BFS_BRA_BFS_BRF_BFS_BCD_BFS_BS_BFS_BN_BFS_BTACK_BFS_HLID_BFS_ACKMID
 Q
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
 .S X=$G(^HL(772,ACKTO,"IN",1,0))
 .I X["MSH" D
 ..S HLFS=$E(X,4)
 ..S SENDFAC=$P(X,HLFS,4),RECFAC=$P(X,HLFS,6) ;from original msg
 ..S CLNTFAC=SENDFAC,SERFAC=RECFAC ;reverse facility info
 I HLEP773,SERFAC="" D EP^HLCSHDR2
 I HLS773,CLNTFAC="" D S^HLCSHDR2
 Q
 ;
PIDCK(IEN101) ; This subroutine added by HL*1.6*80
 ; Given 101's IEN, return the PROCESSING ID.  (See PID^HLCSHDR
 ; and PID^HLCSHDR1 for other locations where HLPID is set.)
 ; HLPARAM -- req
 S HLPID=$P($G(^ORD(101,+IEN101,0)),U,6)
 I HLPID'="D" D
 .  I $G(HLPARAM)']"" N HLPARAM S HLPARAM=$$PARAM^HLCS2
 .  S HLPID=$P($G(HLPARAM),U,3)
 I HLPID="" S HLERROR="Missing Processing ID Site Parameter."
 QUIT HLPID
