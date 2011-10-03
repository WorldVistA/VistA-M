DGQEHLR ;ALB/RPM - VIC REPLACEMENT HL7 RECEIVE DRIVER ; 10/6/03
 ;;5.3;Registration;**571**;Aug 13, 1993
 ;
RCV ;
 N DGCNT
 N DGMSGTYP
 N DGSEG
 N DGSEGCNT
 N DGWRK
 ;
 S DGWRK=$NA(^TMP("DGPFHL7",$J))
 K @DGWRK
 ;
 ;load work global with segments
 F DGSEGCNT=1:1 X HLNEXT Q:HLQUIT'>0  D
 . S DGCNT=0
 . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE
 . F  S DGCNT=$O(HLNODE(DGCNT)) Q:'DGCNT  D
 . . S @DGWRK@(DGSEGCNT,DGCNT)=HLNODE(DGCNT)
 ;
 ;get message type from first segment
 I $$NXTSEG^DGQEHLUT(DGWRK,0,HL("FS"),.DGSEG),$G(DGSEG("TYPE"))="MSH" D
 . S DGMSGTYP=$P(DGSEG(9),$E(HL("ECH"),1),1)
 . I DGMSGTYP=HL("MTN") D RCVORR(DGWRK,.HL)
 ;
 ;cleanup
 K @DGWRK
 Q
 ;
RCVORR(DGWRK,DGHL) ;process a single ORR~O02 message
 ;
 ;  Input:
 ;    DGWRK - temporary segment work array
 ;     DGHL - VistA HL7 environment array
 ;
 ;  Output:
 ;    none
 ;
 N DGORR
 N DGLIEN
 N DGSTAT
 ;
 D PARSORR(DGWRK,.DGHL,.DGORR)
 ;
 I +$G(DGORR("MSGID")),$G(DGORR("ACKCODE"))]"" D
 . S DGLIEN=$$FINDMID^DGQEHLL(DGORR("MSGID"))
 . Q:'DGLIEN
 . ;
 . I DGORR("ACKCODE")="AA" S DGSTAT="A"
 . E  D
 . . S DGSTAT="RJ"
 . . ;send bulletin indicating failed NCMD update
 . . D SENDBULL(DGLIEN,.DGORR)
 . ;
 . ;remove "H"old event entry from VIC HL7 TRANSMISSION LOG (#39.6) file
 . D STOACK^DGQEHLL(DGLIEN,DGSTAT)
 ;
 Q
 ;
PARSORR(DGWRK,DGHL,DGORR) ;Parse ORR Message/Segments
 ;
 ;  Input:
 ;    DGWRK - Closed root work global reference
 ;     DGHL - HL7 environment array
 ;
 ;  Output:
 ;    DGORR - array of ACK results
 ;
 N DGFS
 N DGCS
 N DGRS
 N DGSS
 N DGCURLIN
 ;
 S DGFS=DGHL("FS")
 S DGCS=$E(DGHL("ECH"),1)
 S DGRS=$E(DGHL("ECH"),2)
 S DGSS=$E(DGHL("ECH"),4)
 S DGCURLIN=0
 ;
 ;loop through the message segments and retrieve the field data
 F  D  Q:'DGCURLIN
 . N DGSEG
 . S DGCURLIN=$$NXTSEG^DGQEHLUT(DGWRK,DGCURLIN,DGFS,.DGSEG)
 . Q:'DGCURLIN
 . D @(DGSEG("TYPE")_"(.DGSEG,DGCS,DGRS,DGSS,.DGORR)")
 Q
 ;
MSH(DGSEG,DGCS,DGRS,DGSS,DGORR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORR - array of ACK results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;
 S DGORR("SNDFAC")=$P($G(DGSEG(4)),DGCS,1)
 S DGORR("RCVFAC")=$P($G(DGSEG(6)),DGCS,1)
 S DGORR("MSGDTM")=$$HL7TFM^XLFDT($G(DGSEG(7)))
 Q
 ;
MSA(DGSEG,DGCS,DGRS,DGSS,DGORR) ;
 ;
 ;  Input:
 ;    DGSEG - MSH segment field array
 ;     DGCS - HL7 component separator
 ;     DGRS - HL7 repetition separator
 ;     DGSS - HL7 sub-component separator
 ;
 ;  Output:
 ;    DGORR - array of ACK results
 ;            "ACKCODE" - Acknowledgment code
 ;            "MSGID" - Message Control ID of the message being ACK'ed
 ;            "ERR",# - Error field defined on failure
 ;
 N DGCNT
 ;
 S DGORR("ACKCODE")=$G(DGSEG(1))
 S DGORR("MSGID")=$G(DGSEG(2))
 I DGORR("ACKCODE")'="AA",$G(DGSEG(6))]"" D
 . S DGCNT=$O(DGORR("ERR",""),-1),DGCNT=DGCNT+1
 . S DGORR("ERR",DGCNT)=$P(DGSEG(6),DGCS,1)
 Q
 ;
SENDBULL(DGLIEN,DGORR) ;build and send error bulletin
 ;
 ;  Input:
 ;    DGLIEN - IEN of VIC HL7 TRANSMISSION LOG (#39.7)
 ;     DGORR - array of parsed ACK results
 ;            "SNDFAC" - sending facility
 ;            "RCVFAC" - receiving facility
 ;            "MSGDTM" - message creation date/time in FileMan format
 ;            "ACKCODE" - Acknowledgment code
 ;            "MSGID" - Message Control ID of the message being ACK'ed
 ;            "ERR",# - Error field defined on failure
 ;
 ;  Output:
 ;    none
 ;
 N XMB    ;name of bulletin and parameter array
 N XMDUZ  ;sending user
 N XMSUB  ;bulletin subject
 N XMTEXT  ;additional text for rejection reasons
 N DGLOG  ;VIC HL7 TRANSMISSION LOG data array
 N DGREQ  ;VIC REQUEST data array
 ;
 I +$G(DGLIEN) D
 . ;
 . ;retrieve HL7 LOG data
 . Q:'$$GETLOG^DGQEHLL(DGLIEN,.DGLOG)
 . ;
 . ;retrieve VIC REQUEST data
 . Q:'$$GETREQ^DGQEREQ($G(DGLOG("REQIEN")),.DGREQ)
 . ;
 . ;load bulletin params
 . S XMB(1)=$$FMTE^XLFDT($$NOW^XLFDT())
 . S XMB(2)=$G(DGREQ("NAME"))
 . S XMB(3)=$G(DGREQ("CARDID"))
 . S XMB(4)=$S($G(DGREQ("CPRSTAT"))="P":"Release and print previously held VIC request",1:"Cancel VIC request")
 . S XMB(5)=$G(DGLOG("HLMID"))
 . S XMB(6)=$$FMTE^XLFDT($G(DGLOG("XMITDT")))
 . I $D(DGORR("ERR")) D
 . . S XMTEXT=$NA(^TMP("DGQEBULL",$J))
 . . K @XMTEXT
 . . S @XMTEXT@(1)=" "
 . . S @XMTEXT@(2)="  Reason(s) for rejection:"
 . . S DGCNT=0
 . . F  S DGCNT=$O(DGORR("ERR",DGCNT)) Q:'DGCNT  D
 . . . S @XMTEXT@(DGCNT+2)="    #"_DGCNT_":"_" "_DGORR("ERR",DGCNT)
 . ;
 . S XMB="DGQE HL7ERR"
 . S XMDUZ="VIC NCMD HL7 INTERFACE MODULE"
 . S XMSUB="VIC HL7 ERROR"
 . D ^XMB
 . I $G(XMTEXT)]"" K @XMTEXT
 Q
