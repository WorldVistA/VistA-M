HDISVM00 ;BPFO/JRP - SERVER TO RECEIVE XML MESSAGE;1/4/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**6**;Feb 22, 2005
 ;
XML ;Main entry point for XML server options
 ; Input: (As defined by MailMan and Kernel)
 ;        XMREC - Executable code to "read" next line of message
 ;        XQSUB - Subject of received message
 ;        XQSOP - Server option name
 ;        XQMSG,XMZ - Msg IEN in file 3.9
 ;        XQSND,XMFROM - Msg sender
 ;Output: None
 ;  Note: Input is not checked (assumes existence)
 ;
 N XMLARR,PRSARR,ERRARR,STOP,LINE,TYPE
 ;Establish temporary globals
 S XMLARR=$NA(^TMP(XQSOP,$J,"XML"))
 S PRSARR=$NA(^TMP(XQSOP,$J,"PARSED"))
 S ERRARR=$NA(^TMP(XQSOP,$J,"ERROR"))
 K @XMLARR,@PRSARR,@ERRARR
 ;Copy message to temporary global
 S STOP=0
 F LINE=1:1 D  Q:STOP
 .X XMREC
 .I $D(XMER) I (XMER<0) S STOP=1 Q
 .S @XMLARR@(LINE)=XMRG
 ;Parse message
 D SAX^HDISVM01(XMLARR,PRSARR)
 ;Get type of system out of parameter file
 S TYPE=+$$GETTYPE^HDISVF02()
 ;Process messages on centralized server
 I TYPE=2 D MAIN^HDISVS00(PRSARR,ERRARR)
 ;Process messages on VistA (client) system
 I TYPE=1 D MAIN^HDISVC00(PRSARR,ERRARR)
 ;Error(s) occurred
 I $D(@ERRARR) D
 .;Send error message
 .D ERROR(ERRARR,XQMSG,XQSOP,XMFROM)
 .;Set message status
 .S X=$$SRVTIME^XMS1(XQMSG,"S."_XQSOP,"ERROR FOUND DURING PROCESSING")
 ;Delete message (don't delete if errors found)
 I '$D(@ERRARR) D ZAPSERV^XMXAPI("S."_XQSOP,XQMSG)
 ;Done
 K @XMLARR,@PRSARR,@ERRARR
 Q
 ;
ERROR(ERRARR,MSGNUM,SRVR,SNDR) ;Send error message
 ; Input : ERRARR - Error array (closed root)
 ;         MSGNUM - Message number of received message (XMZ)
 ;         SRVR - Name of server option (XQSOP)
 ;         SNDR - Sender of message (XMFROM)
 ;Output : None
 ; Notes : Existance/validity of input assumed (internal call)
 N NAME,HDISPRAM,HDISFLAG,HDISTASK
 ;Set bulletin parameters
 S HDISPRAM(1)=MSGNUM
 S HDISPRAM(2)=SNDR
 S HDISPRAM(3)=SRVR
 ;Send bulletin
 S NAME="HDIS XML MSG PROCESS ERROR"
 S HDISFLAG("FROM")="HDIS XML MESSAGE SERVER"
 D TASKBULL^XMXAPI(DUZ,NAME,.HDISPRAM,ERRARR,,.HDISFLAG,.HDISTASK)
 I $G(XMERR) D
 .;Error generating bulletin - log error text
 .D ERR2XTMP^HDISVU01("HDI-XM","Server error bulletin",$NA(^TMP("XMERR",$J)))
 .K XMERR,^TMP("XMERR",$J)
 Q
