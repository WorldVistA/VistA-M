HLTP0 ;AISC/SAW,JRP - Transaction Processor Module (Cont'd) ;11/19/97  11:13
 ;;1.6;HEALTH LEVEL SEVEN;**25,37**;Oct 13, 1995
PROCESS(HLMTIEN,HLLD0,HLLD1,HLRESLT) ;Process an incoming message
 ;
 ;INPUT  : HLMTIEN - One of two values
 ;                   1) Pointer to entry in MESSAGE TEXT file (#772)
 ;                      that requires processing (internal message)
 ;                   2) Pointer to entry in MESSAGE TEXT file (#772)
 ;                      that external message will be placed into
 ;         HLLD0 - One of three values
 ;                 1) Pointer to LOGICAL LINK file (#870) that
 ;                    contains the message
 ;                 2) 'XM' if the message was received through MailMan
 ;                 3) 'DHCP' if the message is from an internal
 ;                    application
 ;         HLLD1 - Pointer to entry in IN QUEUE multiple (#19) of
 ;                 the LOGICAL LINK file (#870)
 ;               - Only used for messages received through the
 ;                 LOGICAL LINK file (#870)
 ;         HLRESLT - Variable to return error text in (pass by reference)
 ;OUTPUT : On successful completion, HLRESLT will be set to NULL
 ;         On error, HLRESLT will be set to ErrorCode^ErrorText
 ;
 ;Check parameters
 S HLRESLT="7^"_$G(^HL(771.7,7,0))_" at PROCESS^HLTP0 entry point"
 Q:('$G(HLMTIEN))
 S HLLD0=$G(HLLD0)
 Q:(HLLD0="")
 Q:((HLLD0'="XM")&(HLLD0'="DHCP")&('$D(^HLCS(870,+HLLD0,0))))
 S HLLD1=+$G(HLLD1)
 Q:((+HLLD0)&('$D(^HLCS(870,+HLLD0,1,HLLD1,0))))
 S HLRESLT=""
 N HLEXROU,CHARCNT,EVNTCNT,HDRFND,FLDSPRTR,LINE,TEXT,SEGNAME,HDRTYPE
 N HLENROU,HLNEXT,HLNODE,HLPROU,HLQUIT,HLMTIENS
 ;
 ;Prepare to process internal message
 I (HLLD0="DHCP") D  Q:(HLRESLT'="")
 .;Determine statistics for message
 .S LINE=0
 .S TEXT=""
 .S HDRFND=0
 .S CHARCNT=0
 .S EVNTCNT=0
 .S HLMSA=""
 .S HLHDR=""
 .S SEGNAME=""
 .S HDRTYPE=""
 .;Order through message text
 .F  S LINE=+$O(^HL(772,HLMTIEN,"IN",LINE)) Q:('LINE)  D
 ..S TEXT=$G(^HL(772,HLMTIEN,"IN",LINE,0))
 ..;Determine if header found yet (skip lines until it is)
 ..S:"FHS,BHS,MSH"[$E(TEXT,1,3) HDRFND=1
 ..Q:('HDRFND)
 ..;Increment character count
 ..S CHARCNT=CHARCNT+$L(TEXT)
 ..;Get segment name
 ..S SEGNAME=$E(TEXT,1,3)
 ..;If header segment, process it and set HLHDR equal to it
 ..I "FHS,BHS,MSH"[SEGNAME D
 ...I (HLHDR="") S HLHDR=TEXT,FLDSPRTR=$E(TEXT,4),HDRTYPE=SEGNAME
 ...S $P(TEXT,FLDSPRTR,8)=""
 ...S:(SEGNAME="MSH") EVNTCNT=EVNTCNT+1
 ..;If acknowledgement segment, set HLMSA equal to it
 ..S:((SEGNAME="MSA")&(HLMSA="")&(HDRTYPE="MSH")) HLMSA=TEXT
 .;Update statistics
 .D STATS^HLTF0(HLMTIEN,CHARCNT,EVNTCNT)
 .S:(HLHDR="") HLRESLT="12^"_$G(^HL(771.7,12,0))
 ;
 ;Prepare to process external message
 I (HLLD0'="DHCP") D  Q:(HLRESLT'="")
 .;Store message in Message Text file
 .D MERGEIN^HLTF2(HLLD0,$S($G(HLLD1):HLLD1,1:""),HLMTIEN,.HLHDR,.HLMSA)
 . ; for batch message
 .I $D(HLMSA),$P(HLMSA,$E(HLHDR,4),2)="" S HLMSA=""
 .S:('$D(HLHDR)) HLRESLT="12^"_$G(^HL(771.7,12,0))
 ;
 ;Process message
 D ^HLTP01
 ;
 ;Update status of subscriber message
 I (HLMTIENS) D STATUS^HLTF0(HLMTIENS,$S(HLRESLT:4,1:3),$S(HLRESLT:+HLRESLT,1:""),$S($D(HLERR):HLERR,HLRESLT:$P(HLRESLT,"^",2),1:""))
 ;
 ;Execute exit action of client protocol
 X:$G(HLEXROU)]"" HLEXROU
 Q
