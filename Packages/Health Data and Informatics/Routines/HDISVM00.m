HDISVM00 ;BPFO/JRP - SERVER TO RECEIVE XML MESSAGE;1/4/2005
 ;;1.0;HEALTH DATA & INFORMATICS;**6,7**;Feb 22, 2005;Build 33
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
 NEW XMLARR,PRSARR,ERRARR,STOP,LINE,TYPE
 ;Establish temporary globals
 SET XMLARR=$NAME(^TMP(XQSOP,$JOB,"XML"))
 SET PRSARR=$NAME(^TMP(XQSOP,$JOB,"PARSED"))
 SET ERRARR=$NAME(^TMP(XQSOP,$JOB,"ERROR"))
 KILL @XMLARR,@PRSARR,@ERRARR
 ;Copy message to temporary global
 SET STOP=0
 FOR LINE=1:1 DO  QUIT:STOP
 .XECUTE XMREC
 .IF $DATA(XMER) IF (XMER<0) SET STOP=1 QUIT
 .SET @XMLARR@(LINE)=XMRG
 ;Parse message
 DO SAX^HDISVM01(XMLARR,PRSARR)
 ;Get type of system out of parameter file
 SET TYPE=+$$GETTYPE^HDISVF02()
 ;Process messages on centralized server
 IF TYPE=2 DO MAIN^HDISVS00(PRSARR,ERRARR)
 ;Process messages on VistA (client) system
 IF TYPE=1 DO MAIN^HDISVC00(PRSARR,ERRARR)
 ;Error(s) occurred
 IF $DATA(@ERRARR) DO
 .;Send error message
 .DO ERROR(ERRARR,XQMSG,XQSOP,XMFROM)
 .;Set message status
 .SET X=$$SRVTIME^XMS1(XQMSG,"S."_XQSOP,"ERROR FOUND DURING PROCESSING")
 ;Delete message (don't delete if errors found)
 IF '$DATA(@ERRARR) DO ZAPSERV^XMXAPI("S."_XQSOP,XQMSG)
 ;Done
 KILL @XMLARR,@PRSARR,@ERRARR
 QUIT
 ;
ERROR(ERRARR,MSGNUM,SRVR,SNDR) ;Send error message
 ; Input : ERRARR - Error array (closed root)
 ;         MSGNUM - Message number of received message (XMZ)
 ;         SRVR - Name of server option (XQSOP)
 ;         SNDR - Sender of message (XMFROM)
 ;Output : None
 ; Notes : Existance/validity of input assumed (internal call)
 NEW NAME,HDISPRAM,HDISFLAG
 ;Set bulletin parameters
 SET HDISPRAM(1)=MSGNUM
 SET HDISPRAM(2)=SNDR
 SET HDISPRAM(3)=SRVR
 ;Send bulletin
 SET NAME="HDIS XML MSG PROCESS ERROR"
 SET HDISFLAG("FROM")="HDIS XML MESSAGE SERVER"
 ;TASKBULL^XMXAPI was redefining ERRARR when it ran so switched to SENDBULL
 DO SENDBULL^XMXAPI(DUZ,NAME,.HDISPRAM,ERRARR,,.HDISFLAG)
 IF $GET(XMERR) DO
 .;Error generating bulletin - log error text
 .DO ERR2XTMP^HDISVU01("HDI-XM","Server error bulletin",$NAME(^TMP("XMERR",$JOB)))
 .KILL XMERR,^TMP("XMERR",$JOB)
 QUIT
 ;
LABXCPT ;Main entry point for serving UUEncoded Lab exception messages
 ; Input: (As defined by MailMan and Kernel)
 ;        XMREC - Executable code to "read" next line of message
 ;        XQSUB - Subject of received message
 ;        XQSOP - Server option name
 ;        XQMSG,XMZ - Msg IEN in file 3.9
 ;        XQSND,XMFROM - Msg sender
 ;Output: None
 ;  Note: Input is not checked (assumes existence)
 ;
 NEW STOP,LINE,MSGARR,ERRARR
 SET MSGARR=$NAME(^TMP("HDISVM00",$JOB,"MSGARR"))
 SET ERRARR=$NAME(^TMP("HDISVM00",$JOB,"ERRARR"))
 KILL @MSGARR,@ERRARR
 ;Copy message to temporary global
 SET STOP=0
 FOR LINE=1:1 DO  QUIT:(STOP)
 .XECUTE XMREC
 .IF ($DATA(XMER)) IF (XMER<0) SET STOP=1 QUIT
 .SET @MSGARR@(LINE,0)=XMRG
 .QUIT
 ;Get type of system out of parameter file
 SET TYPE=+$$GETTYPE^HDISVF02()
 ;Process messages on centralized server
 IF TYPE=2 DO LABXCPT^HDISVS04(MSGARR,ERRARR)
 ;Send error message
 IF ($DATA(@ERRARR)) DO
 .DO ERROR(ERRARR,XQMSG,XQSOP,XMFROM)
 .;Set message status
 .SET X=$$SRVTIME^XMS1(XQMSG,"S."_XQSOP,"ERROR FOUND DURING PROCESSING")
 ;Delete message (don't delete if errors found)
 IF ('$DATA(@ERRARR)) DO ZAPSERV^XMXAPI("S."_XQSOP,XQMSG)
 ;Done
 KILL @MSGARR,@ERRARR
 QUIT
