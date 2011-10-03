XMD ;ISC-SF/GMB-Send/Forward/Add text to a message APIs ;08/27/2003  11:01
 ;;8.0;MailMan;**21**;Jun 28, 2002
 ; Was (WASH ISC)/THM/CAP
 ;
 ; Entry points (DBIA 10070) are:
 ; ^XMD         Send a message.
 ;              If no recipients defined, prompt for them.
 ; EN1^XMD      Put text in a message.
 ;              If no recipients defined, prompt for them.
 ;              Send the message.
 ; ENL^XMD      Add text to an existing message.
 ; ENT^XMD      Interactive 'send a message'.  (Same as menu)
 ; ENT1^XMD     Forward a message.
 ; ENT2^XMD     Forward a message.
 ;              Prompt for recipients, whether or not any are already
 ;              defined.
 ;
 ; I/O Variables to the various APIs:
 ; XMDUZ   (in, optional) Sender DUZ or string (default=DUZ)
 ;              For new messages, XMDUZ may be a string, which will be
 ;              put in the 'message from' field.
 ;              For forwarded messages, XMDUZ may be a string, which
 ;              will be put in the 'forwarded by' field.
 ; XMSUB   (in) Message subject
 ; XMTEXT  (in) @location of message.  For example, the following are
 ;              among the acceptable:
 ;              XMTEXT="array("
 ;              XMTEXT="array(""node"","
 ;              XMTEXT="^TMP(""namespace"",$J,""array"","
 ;              The array must be in the acceptable FM word processing
 ;              format.
 ; XMSTRIP (in, optional) Characters that user wants stripped from text
 ;              of message (default=none)
 ; XMY     (in, optional) Array of recipients, XMY(x)="", where
 ;               x is a valid local or internet address.
 ;               XMY(x,0)=basket to deliver to, if x=sender's DUZ or .6
 ;               (Basket may be its number or name.  If name, and it
 ;               doesn't exist, it will be created.)
 ;               XMY(x,1)=recipient type, either "I" (info only) or
 ;               "C" (carbon copy)
 ;               XMY(x,"D")=delete date, if x=.6 ("SHARED,MAIL")
 ;               A local address may be a user's name or DUZ, a G.group
 ;               name or S.server name.
 ;               If not supplied and the process is not queued,
 ;               you will be prompted.
 ; XMMG    (in, optional) If XMY is not supplied and the process is not
 ;               queued, XMMG is used as the default for the first
 ;               'send to:' prompt.  It is ignored otherwise.
 ;         (out) Contains error message if error occurs.
 ;               Undefined if no error.
 ; DIFROM  (in, optional) ?
 ; XMROU   (in, optional) Array of routines to be loaded in a PackMan
 ;               message.   XMROU(x)="", where x=routine name.
 ; XMYBLOB (in, optional) Array of images from the imaging system to be
 ;               loaded.  XMYBLOB(y)=x, where y and x are ?
 ;
 ; Local Variables:
 ; XMDF    Flag that programmer interface is in use.
 ;         Therefore do not check for Security Keys on domains.
 ;
 ; Entry point ^XMD
 ; Needs:   DUZ,XMSUB,XMTEXT
 ; Accepts: XMDUZ,XMY,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB,
 ;          and, if $D(DIFROM), XMDF
 ; Ignores: N/A
 ; Returns: XMZ(if no error),XMMG(if error)
 ; Kills:   XMSUB,XMTEXT,XMY,XMSTRIP,XMMG(if no error),XMYBLOB
 N XMV,XMINSTR,XMBLOBER,XMABORT
 I '$D(DIFROM) N XMDF S XMDF=1
 I '$G(DUZ) N DUZ D DUZ^XUP(.5)
 I $G(XMDUZ)=""!($G(XMDUZ)=0) S XMDUZ=DUZ
 I XMDUZ'?.N S %=XMDUZ N XMDUZ S XMDUZ=% K %
 K XMERR,^TMP("XMERR",$J)
 S XMABORT=0
 I '$D(XMTEXT) S XMMG="Error = No message text" Q
 I '$O(@(XMTEXT_"0)")) S XMMG="Error = No message text" Q
 I '$D(XMSUB)  S XMMG="Error = No message subject" Q
 ;I $L(XMSUB)<3!($L(XMSUB)>65) S XMMG="Error = Message subject too long or too short" Q
 I $L(XMSUB)<3 S XMSUB=XMSUB_"..."
 I $L(XMSUB)>65 S XMSUB=$E(XMSUB,1,65)
 I $D(XMY)'<10 K XMMG
 I XMDUZ'?.N D SETFROM(.XMDUZ,.XMINSTR) Q:$G(XMMG)["Error ="  ; If XMDUZ=.5, becomes POSTMASTER
 D INITAPI^XMVVITAE
 D INITLATR^XMXADDR
 I '$D(XMROU),'$D(DIFROM),'$D(XMYBLOB),$D(XMY) D  Q
 . D SEND(XMDUZ,XMSUB,XMTEXT,.XMSTRIP,.XMY,.XMINSTR,.XMMG,.XMZ)
 . D QUIT
 D CLEANUP^XMXADDR
 S XMSUB=$$ENCODEUP^XMXUTIL1(XMSUB)
 F  D CRE8XMZ^XMXSEND(XMSUB,.XMZ) Q:XMZ>0  D
 . K XMERR,^TMP("XMERR",$J)
 . I $D(ZTQUEUED) H 1 Q
 . W !,$C(7),$$EZBLD^DIALOG(34101),! ;Waiting for access to the Message File
 . N I F I=1:1:10 H 1 W "."
 I $D(XMYBLOB)>9 D  Q:XMBLOBER
 . ; Add BLOBS to message
 . S XMBLOBER=$$MULTI^XMBBLOB(XMZ)
 . K XMYBLOB
 . Q:'XMBLOBER
 . D KILLMSG^XMXUTIL(XMZ)
 . K XMZ
 D EN1A
 Q
SEND(XMDUZ,XMSUBJ,XMBODY,XMSTRIP,XMTO,XMINSTR,XMMG,XMZ) ;
 S XMBODY=$$CREF^DILF(XMBODY)
 S:$D(XMSTRIP) XMINSTR("STRIP")=XMSTRIP
 D CHKBSKT(.XMTO,.XMINSTR)
 D SENDMSG^XMXPARM(.XMDUZ,.XMSUBJ,.XMBODY,.XMTO,.XMINSTR)
 I $D(XMERR) D ERR1 Q
 S:$D(XMDF) XMINSTR("ADDR FLAGS")="R" ; Ignore addressee restrictions
 D SENDMSG^XMXSEND(XMDUZ,XMSUBJ,XMBODY,.XMTO,.XMINSTR,.XMZ)
 D:$D(XMERR) ERR1
 Q
ERR1 ;
 S XMMG="Error = "_^TMP("XMERR",$J,1,"TEXT",1)
 K XMERR,^TMP("XMERR",$J)
 Q
EN1 ; Enter text in the msg, ask for recipients if there aren't any,
 ; and send the msg.
 ; Needs:   DUZ,XMZ,XMTEXT
 ; Accepts: XMDF,XMY,XMMG,XMSTRIP,XMROU,DIFROM
 ; Ignores: XMDUZ,XMSUB
 ; Returns: N/A
 ; Kills:   XMTEXT,XMY,XMSTRIP,XMMG
 N XMV,XMABORT,XMDUZ,XMFROM,XMINSTR,XMSUB ; (XMSUB is newed so it isn't killed in QUIT)
 S XMABORT=0
 S XMDUZ=DUZ
 D INITAPI^XMVVITAE
 D INITLATR^XMXADDR
 K XMERR,^TMP("XMERR",$J)
 I $D(XMY)'<10 K XMMG
 S XMFROM=$P($G(^XMB(3.9,XMZ,0)),U,2)
 I XMFROM'="",XMFROM'=XMDUZ S XMINSTR("FROM")=XMFROM
 D EN1A
 Q
EN1A ;
 D EN2A
 Q:$D(DIFROM)
 D EN3A
 D QUIT
 Q
EN2A ;
 N XMI,XMBODY
 S XMI=0
 I $D(XMROU)>9,'$O(^XMB(3.9,XMZ,2,0)) D NEW^XMP S XMI=1,^XMB(3.9,XMZ,2,0)="^^1^1"
 S XMBODY=$$CREF^DILF(XMTEXT)
 D MOVEBODY^XMXSEND(XMZ,XMBODY,"A")
 D CHEKBODY^XMXSEND(XMZ,.XMSTRIP,XMI)
 S XCNP=+$P($G(^XMB(3.9,XMZ,2,0)),U,3)
 Q:$D(DIFROM)
 Q:$D(XMROU)'>9
 D XMROU^XMPH
 K XMROU
 D PSECURE^XMPSEC(XMZ,.XMABORT)
 Q
EN3 ; called from XPDTP (KIDS)
 ; XMDUZ must be valid DUZ, if provided.  It may not be a string.
 N XMV,XMINSTR
 I '$G(DUZ) N DUZ D DUZ^XUP(.5)
 I '$D(XMDUZ) S XMDUZ=DUZ
 D INITAPI^XMVVITAE
 D INITLATR^XMXADDR
 D EN3A
 D QUIT
 Q
EN3A ;
 N XMABORT
 S XMABORT=0
 S:$D(XMDF) XMINSTR("ADDR FLAGS")="R" ; Ignore addressee restrictions
 I $D(XMY)<10,'$$GOTADDR^XMXADDR,'$D(ZTQUEUED) D
 . I $D(XMMG) S XMINSTR("TO PROMPT")=XMMG K XMMG
 . D TOWHOM^XMJMT($G(XMDUZ,DUZ),$$EZBLD^DIALOG(34110),.XMINSTR,"",.XMABORT) ;Send
 E  D
 . D CHKBSKT(.XMY,.XMINSTR)
 . D CHKADDR^XMXADDR(XMDUZ,.XMY,.XMINSTR) K:$D(XMERR) XMERR,^TMP("XMERR",$J)
 Q:XMABORT
 I '$$GOTADDR^XMXADDR S:'$D(XMMG) XMMG="Error = No recipients." Q
 D BLDNSND^XMXSEND(XMDUZ,XMZ,.XMINSTR)
 Q
QUIT ;
 K XMSUB,XMTEXT,XMY,XMSTRIP
 D CLEANUP^XMXADDR
 Q
ENT ; Entry for outside users
 ; All input variables ignored
 I '$G(DUZ) W "  User ID needed (DUZ) !!" Q
 D EN^XM,SEND^XMJMS
 Q
INIT ; From DIFROM
 D XMZ^XMA2 Q:XMZ<1  S $P(^XMB(3.9,XMZ,0),U,7)="X" D NEW^XMP
 Q
ENT1 ; Forward a msg, do not ask for recipients
 ; Needs:   DUZ,XMZ,XMY
 ; Accepts: XMDUZ
 ; Ignores: XMSUB,XMTEXT,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB
 ; Returns: N/A
 ; Kills:   XMDUZ,XMY
 N XMDF
 S XMDF=1
 D ENT1A(0)
 Q
ENT1A(XMASK) ;
 N XMV,XMINSTR,XMABORT
 K XMERR,^TMP("XMERR",$J)
 I '$G(DUZ) N DUZ D DUZ^XUP(.5)
 I $G(XMDUZ)=""!($G(XMDUZ)=0) S XMDUZ=DUZ
 S XMABORT=0
 D:XMDUZ'?.N SETFWD(.XMDUZ,.XMINSTR)
 D INITAPI^XMVVITAE
 D INIT^XMXADDR
 S:$D(XMDF) XMINSTR("ADDR FLAGS")="R" ; Ignore addressee restrictions
 I XMASK D TOWHOM^XMJMT(XMDUZ,$$EZBLD^DIALOG(34111),.XMINSTR,"",.XMABORT) Q:XMABORT  ;Forward
 D CHKBSKT(.XMY,.XMINSTR)
 D CHKADDR^XMXADDR(XMDUZ,.XMY,.XMINSTR) K:$D(XMERR) XMERR,^TMP("XMERR",$J)
 I $$GOTADDR^XMXADDR D
 . D FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 . D CHECK^XMKPL
 E  S:'$D(XMMG) XMMG="Error = No recipients."
 K XMDUZ,XMY
 D CLEANUP^XMXADDR
 Q
ENT2 ; Forward a msg, ask for (more) recipients
 ; Needs:   DUZ,XMZ
 ; Accepts: XMDUZ,XMY,XMDF
 ; Ignores: XMSUB,XMTEXT,XMMG,XMSTRIP,XMROU,DIFROM,XMYBLOB
 ; Returns: N/A
 ; Kills:   XMDUZ,XMY
 D ENT1A($S($D(ZTQUEUED):0,1:1))
 Q
ENX ;FROM MAILMAN
 S %=XMDUZ N XMDUZ,XMK S XMDUZ=% D XMD K %
 Q
ENL ; Add text to an existing message
 ; Needs:   XMZ,XMTEXT
 ; Accepts: XMSTRIP
 ; Ignores: DUZ,XMDUZ,XMSUB,XMMG,XMY,XMROU,DIFROM,XMYBLOB
 ; Returns: N/A
 ; Kills:   XMSTRIP
 N XMI,XMBODY
 K XMERR,^TMP("XMERR",$J)
 S XMBODY=$$CREF^DILF(XMTEXT)
 S XMI=+$P($G(^XMB(3.9,XMZ,2,0)),U,3)
 D MOVEBODY^XMXSEND(XMZ,XMBODY,"A")
 D CHEKBODY^XMXSEND(XMZ,.XMSTRIP,XMI)
 K XMSTRIP
 Q
CHKBSKT(XMTO,XMINSTR) ;
 I $D(XMTO(XMDUZ,0)) S XMINSTR("SELF BSKT")=XMTO(XMDUZ,0)
 I $D(XMTO(.6,0)) S XMINSTR("SHARE BSKT")=XMTO(.6,0)
 I $D(XMTO(.6,"D")) S XMINSTR("SHARE DATE")=XMTO(.6,"D")
 N XMADDR
 S XMADDR=""
 F  S XMADDR=$O(XMTO(XMADDR)) Q:XMADDR=""  I $D(XMTO(XMADDR,1)) D
 . S XMTO(XMTO(XMADDR,1)_":"_XMADDR)=""
 . K XMTO(XMADDR)
 Q
SETFROM(XMDUZ,XMINSTR) ;
 Q:XMDUZ=DUZ
 N XMPOSTPR
 I XMDUZ=.5 D  Q:XMPOSTPR
 . S XMPOSTPR=+$O(^XMB(3.7,"AB",DUZ,.5,0))
 . Q:'XMPOSTPR
 . I $P($G(^XMB(3.7,.5,9,XMPOSTPR,0)),U,3)'="y" S XMPOSTPR=0
 I XMDUZ'="POSTMASTER",XMDUZ'=.5 D CHKUSER(.XMDUZ) Q:+XMDUZ=XMDUZ
 S XMINSTR("FROM")=$$XMFROM^XMXPARM("XMDUZ",XMDUZ)
 I $D(XMERR) D ERR1 Q
 S XMDUZ=DUZ
 Q
SETFWD(XMDUZ,XMINSTR) ;
 Q:XMDUZ=DUZ
 I XMDUZ=.5,$D(^XMB(3.7,"AB",DUZ,.5)) Q
 I XMDUZ=.5,'$D(^XMB(3.7,"AB",DUZ,.5)) S XMDUZ="POSTMASTER"
 E  D CHKUSER(.XMDUZ) Q:+XMDUZ=XMDUZ
 S XMINSTR("FWD BY")=$$XMFROM^XMXPARM("XMDUZ",XMDUZ)
 I $D(XMERR) D ERR1 Q
 S XMDUZ=DUZ
 Q
CHKUSER(XMDUZ) ;
 N XMERR
 D CHKUSER^XMXPARM1(.XMDUZ)
 I $D(XMERR) K ^TMP("XMERR",$J),DIERR,^TMP("DIERR",$J)
 Q
