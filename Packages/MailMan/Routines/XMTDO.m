XMTDO ;ISC-SF/GMB-Deliver other (server,device) ;04/11/2002  07:05
 ;;8.0;MailMan;**45**;Jun 28, 2002;Build 8
 ; Replaces ZSER^, ZDEV^XMS1 (ISC-WASH/THM/CAP)
 ;
 ; Patch mod to attempt to sync mail message arrival with processing
 ; by building in 5 minute pause waiting for next mail msg line to
 ; arrive, and, if not, then xm send error server msg 
 ;
SERVER ; S.server TASKMAN ENTRY
 ; Variables supplied by TaskMan:  XMZ,XMSERVER,XMSVIENS
 ; XMSERVER  Name of the server option (includes leading S.)
 N XMZREC,XMFROM,XMSERR,XMSUBJ,XMZI
 D DUZ^XUP(.5)
 F XMZI=1:1 S XMZREC=$G(^XMB(3.9,XMZ,0)) Q:XMZREC'=""  H 1 I XMZI>300 D  Q   ;patch mod for timing lag with mail msg
 . N XMPARM,XMINSTR
 . S XMINSTR("FROM")=.5
 . S XMPARM(1)=XMSERVER
 . S XMPARM(2)=ZTSK
 . D TASKBULL^XMXBULL(.5,"XM SEND ERR SERVER MSG",.XMPARM,"",.5,.XMINSTR)
 Q:XMZREC=""     ;patch mode to quit if mail msg lag check occurs in for loop waiting for next line
 S XMSUBJ=$P(XMZREC,U,1)
 S:XMSUBJ["~U~" XMSUB=$$DECODEUP^XMXUTIL1(XMSUBJ)
 S XMFROM=$P(XMZREC,U,2)
 S:XMFROM["@" XMFROM=$$REPLYTO1^XMXREPLY(XMZ)
 D SETSTAT(XMSVIENS,$$EZBLD^DIALOG(39300)) ; Server hand off ready
 D DOSERV($E(XMSERVER,3,99),XMZ,XMFROM,XMSUBJ,.XMSERR)
 D SETSTAT(XMSVIENS,$S($D(XMSERR):XMSERR,1:$$EZBLD^DIALOG(39301))) ; Served (hand off done)
 S ZTREQ="@"
 Q
DOSERV(XMXX,XMZ,XMFROM,XMSUBJ,XQSRVOK) ;
 N XMCHAN,XMPROT,X,Y,XMSEN,XMREC,XMOPEN,XMCLOSE,XMSVIENS
 S XMCHAN="SERVER"
 D GET^XML
 S X=XMXX_U_XMZ_U_XMFROM_U_XMSUBJ
 D ^XQSRV
 ; ^XQSRV1 calls SETSB^XMA1C to put the msg in the postmaster's bskt.
 ; Instead, that line could read:
 ; D:XQSRV PUTSERV^XMXMSGS1(XQSOP,XQMSG)
 Q
DEVICE ; D.device or H.device TASKMAN ENTRY
 ; Variables supplied by TaskMan:  XMDUZ,XMZ,XMDVIENS,XMPRTHDR
 ; TaskMan opens and closes the device.
 N XMV
 I '$G(DUZ) D DUZ^XUP(XMDUZ)
 D INITAPI^XMVVITAE
 D PRTMSG^XMJMP(XMDUZ,"?",XMZ,"0-",0,$G(XMPRTHDR,1))
 D SETSTAT(XMDVIENS,$$EZBLD^DIALOG(39302)) ; Printed
 S ZTREQ="@"
 Q
SETSTAT(XMIENS,XMSTATUS) ; Record Time/Status in msg file
 N XMFDA
 S XMFDA(3.91,XMIENS,2)=$$NOW^XLFDT
 S XMFDA(3.91,XMIENS,5)=XMSTATUS
 D FILE^DIE("","XMFDA")
 Q
