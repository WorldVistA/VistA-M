SCAPMSG ;ALB/SCK - PCMM MESSAGE GENERATOR ; 22 SEP 95
 ;;5.3;Scheduling;**41**;AUG 13, 1993
 ;;1
 Q
 ; mailman message generator for the primary care management
 ; module.
 ;
PARSE(SC) ;
 ;  -- array parsing for messages
 ;     SCDUZ  -  DUZ of user triggering the message
 ;     SCIENS -  The Internal entry number of the team, position, or
 ;               patient, etc.
 ;     SCDATE -  The date and/or time of the change or incident that
 ;               triggered the notification in external format.
 ;     SCSUBJ -  The subject for the message
 ;     SCMSG  -  The message type
 ;     SCTEXT -  text line to be added to the message
 ;
 S SCDUZ=$G(SC("DUZ"))
 S SCIENS=$G(SC("IENS"))
 S SCDATE=$G(SC("DATE"))
 S SCSUBJ=$G(SC("SUBJECT"))
 S SCMSG=$G(SC("MESSAGE"))
 S SCTEXT=$G(SC("TEXT"))
 Q
 ;
MAILC(SCOK,SCROOT) ;
 ;
 N SCTEXT,SCSUBJ,SCDUZ
 D CHK^SCUTBK
 D TMP^SCUTBK
 ;
 S SCOK=0
 ;
 D BLDMSG(.SCROOT,.SCSUBJ,.SCDUZ)
 ;
 S XMDUZ=$S($G(SCDUZ)]"":SCDUZ,1:"PRIMARY CARE MANAGEMENT")
 S XMSUB=$S($G(SCSUBJ)]"":SCSUBJ,1:"PCMM NOTIFICATION")
 D XMZ^XMA2
 G:XMZ<1 MAILQ
 S XMTEXT="SCTEXT("
 S XMY("G.PCM MESSAGING@DEVFEX.ISC-ALBANY.VA.GOV")=""
 ;
 D ^XMD
 S SCOK=XMZ
MAILQ Q
 ;
BLDMSG(SCROOT,SCSUBJ,SCDUZ) ;
 ;
 N I
 S SCDUZ=$P($G(SCROOT(1,0)),U,1)
 S SCSUBJ=$P($G(SCROOT(1,0)),U,2)
 ;
 S I=0
 F  S I=$O(SCROOT(1,I)) Q:'I  S SCTEXT(I)=SCROOT(1,I)
 Q
