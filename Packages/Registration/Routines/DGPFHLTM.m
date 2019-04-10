DGPFHLTM ;SHRPE/YMG - PRF HL7 QBP/RSP PROCESSING ; 05/02/18
 ;;5.3;Registration;**951**;Aug 13, 1993;Build 135
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; This routine contains functions for sending Mailman messages related to PRF flag transfer requests.
 ;
 Q
 ;
TREQMSG(DATA,DGPFA,TYPE) ; sends notification about PRF flag ownership transfer request
 ; DATA - Array of values to include in the message (see tag EN^DGPFHLT1)
 ; DGPFA - PRF assignment array
 ; TYPE - 1 = notification about received request, 2 = notification about received response
 ;
 N DGMAX,MSGTXT,LNCNT,MGRP,RESLT,Z
 S MGRP="DGPF PRF TRANSFER REQUESTS" ; PRF transfer requests mail group
 S DGMAX=78 ; Max. line length
 ;
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$CJ^XLFSTR("* * * *  PRF OWNERSHIP TRANSFER REQUEST NOTIFICATION  * * * *",78," "),0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("The following PRF ownership transfer "_$S(TYPE=1:"request",1:"response")_" has been received:",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 I TYPE=1 D ADDLINE^DGPFBGR($$LJ^XLFSTR("Requesting facility: ",22," ")_$G(DATA("SFNAME")),5,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$LJ^XLFSTR("Requester name: ",22," ")_$G(DATA("REQBY")),5,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$LJ^XLFSTR("Request date/time: ",22," ")_$$FMTE^XLFDT($G(DATA("REQDTM")),"1S"),5,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$LJ^XLFSTR("Request reason: ",22," ")_$G(DATA("REQCMT")),5,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$LJ^XLFSTR("PRF flag: ",22," ")_$P($G(DGPFA("FLAG")),U,2),5,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$LJ^XLFSTR("Patient name: ",22," ")_$P($G(DGPFA("DFN")),U,2),5,DGMAX,.LNCNT,"MSGTXT")
 I TYPE=2 D
 .D ADDLINE^DGPFBGR($$LJ^XLFSTR("Reviewer name: ",22," ")_$G(DATA("REVBY")),5,DGMAX,.LNCNT,"MSGTXT")
 .D ADDLINE^DGPFBGR($$LJ^XLFSTR("Review date/time: ",22," ")_$$FMTE^XLFDT($G(DATA("REVDTM")),"1S"),5,DGMAX,.LNCNT,"MSGTXT")
 .D ADDLINE^DGPFBGR($$LJ^XLFSTR("Review reason: ",22," ")_$G(DATA("REVCMT")),5,DGMAX,.LNCNT,"MSGTXT")
 .S Z=$G(DATA("REVRES")),RESLT=$S(Z="A":"Request approved",Z="D":"Request rejected",1:"Unknown")
 .D ADDLINE^DGPFBGR($$LJ^XLFSTR("Review result: ",22," ")_RESLT,5,DGMAX,.LNCNT,"MSGTXT")
 .Q
 D ADDLINE^DGPFBGR($$REPEAT^XLFSTR("-",DGMAX),0,DGMAX,.LNCNT,"MSGTXT")
 ;
 D SEND(MGRP,"PRF ownership transfer request notification","MSGTXT(")
 Q
 ;
TERRMSG(MSGID,ERTXT) ; sends notification about an error that occurred in PRF flag ownership transfer request process
 ; MSGID - HL7 message Id
 ; ERTXT - array containing error text, ERTXT(line #) contains each line
 ;
 N DGMAX,MSGTXT,ERLN,LNCNT,MGRP
 S MGRP="DGPF HL7 TRANSMISSION ERRORS"
 S DGMAX=78 ; Max. line length
 ;
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR($$CJ^XLFSTR("* * * *  PRF OWNERSHIP TRANSFER REQUEST ERROR  * * * *",78," "),0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("The following error occurred during PRF ownership transfer request:",0,DGMAX,.LNCNT,"MSGTXT")
 D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 S ERLN="" F  S ERLN=$O(ERTXT(ERLN)) Q:ERLN=""  D ADDLINE^DGPFBGR($G(ERTXT(ERLN)),0,DGMAX,.LNCNT,"MSGTXT")
 I $G(MSGID) D
 .D ADDLINE^DGPFBGR("",0,DGMAX,.LNCNT,"MSGTXT")
 .D ADDLINE^DGPFBGR("HL7 message Id: "_MSGID,5,DGMAX,.LNCNT,"MSGTXT")
 .Q
 ;
 D SEND(MGRP,"PRF ownership transfer request error","MSGTXT(")
 Q
 ;
SEND(MGRP,SUBJ,MSGARY) ;send the MailMan message
 ; MGRP - mail group name
 ; MSGARY - name of message text array in open format
 ; SUBJ - Subject line
 ;
 N DIFROM  ;protect FM package
 N XMDUZ   ;sender
 N XMSUB   ;message subject
 N XMTEXT  ;name of message text array in open format
 N XMY     ;recipient array
 N XMZ     ;returned message number
 N XMMG    ;error
 ;
 I MGRP="" Q
 S XMDUZ="DGPRF,INTERFACE"
 S XMSUB=$G(SUBJ)
 S XMTEXT=MSGARY
 S XMY("G."_MGRP)=""
 D ^XMD
 Q
