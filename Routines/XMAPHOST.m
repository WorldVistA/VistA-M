XMAPHOST ;ISC-SF/GMB-Print to Message (P-MESSAGE) ;07/29/2003  14:36
 ;;8.0;MailMan;**2,17,21,28,33**;Jun 28, 2002
 ;Was (WASH ISC)/KMB/CAP before extensive rework.
 ;
 ;This routine handles printing to P-MESSAGE.
 ;
 ;To print reports to mail messages, we actually write to host files
 ;(DOS,VMS...) and then suck them into mail messages.  MailMan works
 ;closely with TaskMan and the device handler to make it happen.
 ;
 ;If a user or application wants to write something to a mail message,
 ;the user should choose (or the application should set ZTIO=) a device
 ;whose name starts with "P-MESSAGE".  The user or application can
 ;set the subject of the message, as well as the recipients.  The user
 ;does this by responding to MailMan queries, and the application does
 ;this by setting input variables (see below).
 ;
 ;EN^XMAPHOST is called as a pre-open execute for the P-MESSAGE device,
 ;and READ^XMAPHOST is called as a close execute for the P-MESSAGE
 ;terminal type.
 ;
 ;The pre-open execute is there to capture the wishes (message subject,
 ;recipients, and whether to queue or not) of the user working in the
 ;foreground.  The global ^TMP("XM-MESS",$J) is created, as a result.
 ;TaskMan looks for this global whenever $E(ZTIO,1,9)="P-MESSAGE", and
 ;includes it in the task, if the user chooses to task the print.  This
 ;is a special arrangement that MailMan has with TaskMan.
 ;
 ;If the job printing to P-MESSAGE is running in the background, then
 ;the pre-open execute code does not get executed during the pre-open
 ;execute; instead, it is run as part of the close execute.
 ;
 ;If more than 250 consecutive null lines are encountered, MailMan
 ;assumes EOF has somehow been missed, and stops transferring lines from
 ;the host file to the message.
 ;
 ;This routine has one idiosyncracy.  If the report contains one single
 ;line or two lines separated with only a $C(13) instead of a CR/LF that
 ;is more than 254 characters long, there will be unexpected results.
 ;
 ;Variables:
 ;input:
 ;  XMDUZ   (optional) Sender DUZ or string (default=DUZ)
 ;          If XMDUZ is a string, then user will not be asked who the
 ;          message should be from.
 ;  XMSUB   (optional) message subject.  If not supplied, then default
 ;          subject is "Queued mail report from "<user name>
 ;  XMY(x)="" (optional) array of additional addressees to whom the
 ;          message should be sent.  See documentation for ^XMD for more
 ;          info on XMY.
 ;          The message will always be sent to XMDUZ (unless XMDUZ is a
 ;          string), so it is not necessary to set XMY(XMDUZ)="".
 ;  XMQUIET (optional) if $G(XMQUIET), then there is no user interaction
 ;          and no information written to the screen.
 ;  XMZBACK (optional) if $D(XMZBACK), then XMZ is set upon exit,
 ;          and XMZBACK is killed.
 ;output:
 ;  XMZ     If $D(XMZBACK), then XMZ is set with the IEN of the message,
 ;          and XMZBACK is killed; otherwise, XMZ is not set, and
 ;          remains whatever it was (or wasn't) before the call.
 ;  XMMG    If error, may contain error message.
 ;  XMV("ERROR") If error, may contain error message.
 ;
EN ; Entry from pre-open execute of P-MESSAGE entry in DEVICE file.
 ; If the user chooses to queue the print, we don't want this code
 ; (the pre-open execute of the DEVICE file entry) to execute when
 ; the task starts up.
 K ^TMP("XM-MESS",$J)
 N %H
 Q:$D(ZTQUEUED)!$G(XMQUIET)!$D(DDS)
 N XMAPHOST,XMABORT
 D SETUP(.XMAPHOST,.XMABORT) I XMABORT S (POP,DUOUT,%ZISQUIT)=1 K IO("Q") Q
 M ^TMP("XM-MESS",$J,"XMY")=^TMP("XMY",$J)
 M ^TMP("XM-MESS",$J,"XMY0")=^TMP("XMY0",$J)
 M ^TMP("XM-MESS",$J,"XMAPHOST")=XMAPHOST
 D CLEANUP^XMXADDR
 D KSETS
 Q
SETUP(XMAPHOST,XMABORT) ; Entry during close-execute (called from READ^XMAPHOST)
 N XMINSTR
 S XMABORT=0
 D INIT(.XMDUZ,.XMAPHOST,.XMINSTR,.XMABORT)
 I 'XMABORT D GETSUBJ($S($D(XMAPSUBJ):XMAPSUBJ,$D(XMSUB):XMSUB,1:""),.XMAPHOST,.XMABORT)
 I 'XMABORT D FROMWHOM(XMDUZ,.XMINSTR,.XMABORT)
 I 'XMABORT D ADDRMSG(XMDUZ,.XMINSTR,.XMABORT)
 I 'XMABORT M XMAPHOST("XMINSTR")=XMINSTR Q
 D CLEANUP^XMXADDR
 D KSETS
 Q
INIT(XMDUZ,XMAPHOST,XMINSTR,XMABORT) ;
 I '$D(XMDUZ) S XMDUZ=DUZ,XMAPHOST("SET XMDUZ")=1 K XMV
 S XMAPHOST("CHG XMDUZ")=XMDUZ
 D SETFROM^XMD(.XMDUZ,.XMINSTR) I $D(XMMG) S XMABORT=1 Q
 I '$D(XMINSTR("FROM")) K XMAPHOST("CHG XMDUZ")
 I '$D(XMV("NAME")) D  Q:XMABORT
 . S XMAPHOST("SET XMV")=1
 . D INITAPI^XMVVITAE
 . I $D(XMV("ERROR")) S XMABORT=1 D:'$D(ZTQUEUED) ERROR^XM(.XMV,"ERROR")
 I $D(XMZBACK) S XMAPHOST("XMZBACK")="" K XMZBACK
 S XMAPHOST("XMDUZ")=XMDUZ
 M XMAPHOST("XMV")=XMV
 Q
GETSUBJ(XMSUBJ,XMAPHOST,XMABORT) ;
 D CHKSUBJ(.XMSUBJ)
 I $D(ZTQUEUED)!$G(XMQUIET) D
 . S XMSUBJ=$G(XMSUBJ,$E($$EZBLD^DIALOG(34233,XMV("NAME")),1,65)) ; queued mail report from |1|
 E  D SUBJ^XMJMS(.XMSUBJ,.XMABORT) Q:XMABORT
 S XMAPHOST("XMSUB")=XMSUBJ
 Q
CHKSUBJ(XMSUBJ) ;
 I XMSUBJ="" K XMSUBJ Q
 K XMERR,^TMP("XMERR",$J)
 I $L(XMSUBJ)<3 S XMSUBJ=XMSUBJ_"..."
 I $L(XMSUBJ)>65 S XMSUBJ=$E(XMSUBJ,1,65)
 S XMSUBJ=$$XMSUBJ^XMXPARM("",XMSUBJ)
 I $D(XMERR) K XMSUBJ,XMERR,^TMP("XMERR",$J)
 Q
FROMWHOM(XMDUZ,XMINSTR,XMABORT) ;
 I XMDUZ=.5!$D(XMINSTR("FROM")) Q
 N XMFROM
 S XMFROM=$P($G(^XMB(3.7,XMDUZ,16)),U,3)
 I $D(ZTQUEUED)!$G(XMQUIET) D  Q
 . I XMFROM="P" S XMINSTR("FROM")="POSTMASTER"
 N DIR,X,Y,XMME,XMPOST
 S DIR("A")=$$EZBLD^DIALOG(34239) ; From whom
 S XMME=$$EZBLD^DIALOG(34240)   ; M:Me
 S XMPOST=$$EZBLD^DIALOG(34241) ; P:Postmaster
 S DIR(0)="S^"_XMME_";"_XMPOST
 S DIR("B")=$S(XMFROM="P":$P(XMPOST,":",2,9),1:$P(XMME,":",2,9))
 D BLD^DIALOG(34242,"","","DIR(""?"")") ; Answer 'Me' if the message should be from...
 D ^DIR I $D(DIRUT) S XMABORT=1 Q
 I Y=$P(XMPOST,":",1) S XMINSTR("FROM")="POSTMASTER"
 Q
ADDRMSG(XMDUZ,XMINSTR,XMABORT) ;
 ;I '$D(ZTQUEUED),'$G(XMQUIET) K XMY,XMY0
 D INIT^XMXADDR
 K XMERR,^TMP("XMERR",$J)
 I $D(ZTQUEUED)!$G(XMQUIET) D
 . I '$D(XMAPHOST("CHG XMDUZ")) S XMY(XMDUZ)=""
 . D CHKBSKT^XMD(.XMY,.XMINSTR)
 . D CHKADDR^XMXADDR(XMDUZ,.XMY,.XMINSTR)
 . K XMY
 E  D  Q:XMABORT  ; ask the user for recipients.
 . D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34110),.XMINSTR,"",.XMABORT) ; send
 Q
READ ; Entry from close-execute of P-MESSAGE entry in TERMINAL TYPE file.
 ; Read the host file into a message, send it, erase it.
 ; Read record from file.
 ; Each time <CR> is found in record it ends a message line.
 N X,XMNULCNT,XMLEN,XMZZ,XMREC,XMI,XMLIMIT,XMAPHOST,XMINSTR,XMABORT
 I '$D(^TMP("XM-MESS",$J)) D  Q:XMABORT
 . D SETUP(.XMAPHOST,.XMABORT)
 E  D
 . M ^TMP("XMY",$J)=^TMP("XM-MESS",$J,"XMY")
 . M ^TMP("XMY0",$J)=^TMP("XM-MESS",$J,"XMY0")
 . M XMAPHOST=^TMP("XM-MESS",$J,"XMAPHOST")
 . K ^TMP("XM-MESS",$J)
 S XMDUZ=XMAPHOST("XMDUZ")
 M XMV=XMAPHOST("XMV")
 M XMINSTR=XMAPHOST("XMINSTR")
 S XMLIMIT=$P($G(^XMB(1,1,.16)),U) ; P-MESSAGE LINE LIMIT
 S:'XMLIMIT XMLIMIT=999999999999999
 D CRE8XMZ^XMXSEND(XMAPHOST("XMSUB"),.XMZZ)
 I '$D(ZTQUEUED),'$G(XMQUIET) D
 . U IO(0)
 . W !,$$EZBLD^DIALOG(34234) ; Moving to MailMan message...
 . W !,"."
 U IO
 S (XMNULCNT,XMI)=0,XMREC=""
 N $ETRAP,$ESTACK S $ETRAP="D EOFERR^XMAPHOST"
 F  S XMREC=$$GET() Q:$G(XMAPHOST("EOF"))  D  Q:$G(XMAPHOST("EOF"))!(XMI>XMLIMIT)
 . I XMREC="" D  Q:$G(XMAPHOST("EOF"))
 . . S XMNULCNT=XMNULCNT+1
 . . Q:XMNULCNT'>250     ; If more than 250 consecutive null lines,
 . . S XMAPHOST("EOF")=1 ; set EOF and get rid of those null lines.
 . . F  K ^XMB(3.9,XMZZ,2,XMI,0) S XMI=XMI-1 Q:'XMI  Q:$G(^XMB(3.9,XMZZ,2,XMI,0))'=""
 . E  S XMNULCNT=0
 . S XMLEN=$L(XMREC)
 . F  D  Q:XMREC=""!$G(XMAPHOST("EOF"))
 . . D PUT(XMZZ,$P(XMREC,$C(13)),.XMI)
 . . S XMREC=$P(XMREC,$C(13),2,999)
 . . Q:XMREC=""
 . . S:XMLEN>254 XMREC=XMREC_$$GET(),XMLEN=0
 D EOF
 Q
GET() ; Read a record from the file
 N Y,X
 N $ETRAP,$ESTACK S $ETRAP="S $EC="""" S XMAPHOST(""EOF"")=1 Q """""
 R Y#255:1
 Q Y
PUT(XMZZ,XMREC,XMI) ; Put data into message.
 S XMI=XMI+1,^XMB(3.9,XMZZ,2,XMI,0)=$S(XMREC'?.E1C.E:XMREC,1:$$CTRL^XMXUTIL1(XMREC))
 I '$D(ZTQUEUED),'$G(XMQUIET),XMI#10=0 U IO(0) W "." U IO
 Q
EOFERR ;
 D EOF
 D UNWIND^%ZTER
 Q
EOF ;
 S $ETRAP=""
 I XMI>XMLIMIT D
 . S XMI=XMI+1,^XMB(3.9,XMZZ,2,XMI,0)=""
 . S XMI=XMI+1,^XMB(3.9,XMZZ,2,XMI,0)="*******************************************************************"
 . S XMI=XMI+1,^XMB(3.9,XMZZ,2,XMI,0)=$$EZBLD^DIALOG(34235,XMLIMIT) ; P-MESSAGE line limit of |1| reached.
 . S XMI=XMI+1,^XMB(3.9,XMZZ,2,XMI,0)="*******************************************************************"
 . Q:$D(ZTQUEUED)!$G(XMQUIET)
 . U IO(0) W !,$$EZBLD^DIALOG(34235,XMLIMIT),! ; P-MESSAGE line limit of |1| reached.
 I '$D(ZTQUEUED),'$G(XMQUIET) U IO(0) W !,$$EZBLD^DIALOG(34236) ; Finished moving.
 S ^XMB(3.9,XMZZ,2,0)="^3.92A^"_XMI_"^"_XMI
 D SENDMSG(XMDUZ,XMZZ,.XMINSTR)
 D CLEANUP
 Q
SENDMSG(XMDUZ,XMZ,XMINSTR) ; Here, send the message to recipient.
 I '$D(ZTQUEUED),'$G(XMQUIET) W !,$$EZBLD^DIALOG(34217,XMZ) ; Sending [_XMZ_]...
 D MOVEPART^XMXSEND(XMDUZ,XMZ,.XMINSTR)
 I $D(XMINSTR("FROM")),XMINSTR("FROM")="POSTMASTER"!(XMINSTR("FROM")?.N) S $P(^XMB(3.9,XMZ,0),U,4)=DUZ ; Retain 'sender'
 I $D(XMINSTR("FROM")),$D(XMINSTR("SELF BSKT")),XMINSTR("SELF BSKT")'=1 D
 . D FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 E  D
 . D SEND^XMKP(XMDUZ,XMZ,.XMINSTR)
 I '$D(ZTQUEUED),'$G(XMQUIET) W !,$$EZBLD^DIALOG(34213) ;   Sent
 D CHECK^XMKPL
 Q
CLEANUP ;
 S IONOFF=1 ; Prevent form feed during device close
 D CLEANUP^XMXADDR
 D KSETS
 K XMERR,^TMP("XMERR",$J)
 I $D(XMAPHOST("XMZBACK")) S XMZ=XMZZ
 Q
KSETS ;
 K:$G(XMAPHOST("SET XMDUZ")) XMDUZ
 K:$G(XMAPHOST("SET XMV")) XMV,XMDUN,XMNOSEND,XMDISPI,XMPRIV
 I $D(XMAPHOST("CHG XMDUZ")) S XMDUZ=XMAPHOST("CHG XMDUZ")
 Q
