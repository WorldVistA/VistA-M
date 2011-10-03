XMS2 ;ISC-SF/GMB-SMTP Send (non-standard) ;04/25/2002  14:14
 ;;8.0;MailMan;;Jun 28, 2002
NONSTD(XMNETNAM,XMZ,XMZREC,XMRZ,XMRSET) ; Non-Standard commands,
 ; used only when communicating with other MailMan sites.
 I $O(^XMB(3.9,XMZ,2005,0)),XMC("MAILMAN")>7 D  Q:ER
 . N XMBLOBER ; Send other Body parts
 . S XMBLOBER=0
 . D ^XMS0BLOB
 . I XMBLOBER S ER=1,ER("NONFATAL")=1
 D MESSID(XMNETNAM,XMZ,.XMRZ,.XMRSET) Q:ER!$G(XMRSET)
 I XMC("MAILMAN")<8 D  Q:ER
 . D SPECIAL(XMZREC) Q:ER
 E  D  Q:ER
 . D LINES Q:ER!$G(XMRSET)
 Q
MESSID(XMNETNAM,XMZ,XMRZ,XMRSET) ;
 ; This is a head's up on which message is being sent, and allows the
 ; receiving site to say, "don't bother, I've already received it long
 ; ago and it's already been purged." or "I've already got it, so don't
 ; bother sending the text again, but maybe you've got some new
 ; recipients for me."
 ; Send: "MESS ID:654321@LOCAL.MED.VA.GOV"
 ; Recv: "250 OK"
 ;   or: "RSET :21212@REMOTE.MED.VA.GOV:Duplicate purged"
 ;   or: "RSET :21212@REMOTE.MED.VA.GOV:Previously received"
 N XMREMID
 S XMREMID=$$NETID^XMS3(XMZ)
 I XMREMID="" D  Q
 . ; *** Maybe the thing to do here is to just assign it a net id
 . ; *** and go on our merry way.
 . D ERTRAN^XMC1(42357) ;Msg transmit aborted - remote msg with no remote msg ID
 . S ER("NONFATAL")=1
 . D DOTRAN^XMC1("")
 . N XMPARM,XMINSTR
 . S XMINSTR("FROM")="POSTMASTER"
 . S XMPARM(1)=XMZ
 . D TASKBULL^XMXBULL(.5,"XM SEND ERR REMOTE MSG ID",.XMPARM,"",.5,.XMINSTR)
 S XMSG="MESS ID:"_XMREMID X XMSEN Q:ER
 X XMREC Q:ER
 I $E(XMRG,1,4)="RSET" S XMRSET=1,XMRZ=$P(XMRG,":",2) Q
 Q
LINES ; If message is at least 1000 lines, and it's not a PackMan message,
 ; let the other site know.  If the other site says it's too many lines,
 ; we don't have to bother with the text.
 N XMLINES
 S XMLINES=$$LINE^XMXUTIL2(XMZ) Q:XMLINES<1000
 Q:$$PAKMAN^XMXSEC1(XMZ)
 S XMSG="MESS LINES:"_XMLINES X XMSEN Q:ER
 X XMREC Q:ER
 I $E(XMRG,1,4)="RSET" S XMRSET=1 Q
 Q
SPECIAL(XMZREC) ; Special message characteristics
 ;I 'XMC("MAILMAN") D CHEKSPEC(XMINST,XMSITE,XMZ,XMZREC,XMNVFROM) Q
 N I
 S I=7 I $P(XMZREC,U,I)'="" D SPECSEND(I,$P(XMZREC,U,I)) Q:ER
 Q:ER
 F I=5,9,11,12 I "^Y^y^"[(U_$P(XMZREC,U,I)_U) D SPECSEND(I,$P(XMZREC,U,I)) Q:ER
 Q:ER
 Q
SPECSEND(I,XMVAL) ;
 S XMSG="MESS "_$P("^^^^CONFIRMATION^^TYPE^^CLOSED^^CONFIDENTIAL^INFO",U,I)_":"_XMVAL X XMSEN Q:ER
 X XMREC
 Q
 ; *** The following is not used ***
CHEKSPEC(XMINST,XMSITE,XMZ,XMZREC,XMNVFROM) ; If special VA-only instructions exist, send msg to user
 N I,XMSPEC
 F I=6,7 I $P(XMZREC,U,I)'="" D SPECSET(I,.XMSPEC)
 F I=5,9,11,12 I "^Y^y^"[(U_$P(XMZREC,U,I)_U) D SPECSET(I,.XMSPEC)
 Q:'$D(XMSPEC)
 N XMTEXT,J,XMINSTR,XMTO,XMIEN
 S XMINSTR("FROM")="POSTMASTER"
 S I=0
 S I=I+1,XMTEXT(I)="Your message to "_XMSITE_","
 S I=I+1,XMTEXT(I)="Subject: "_$P(XMZREC,U,1)_" ["_XMZ_"]"
 S I=I+1,XMTEXT(I)="will not include any special instructions, since that site"
 S I=I+1,XMTEXT(I)="is running a very old MailMan version: "_XMC("MAILMAN")
 S I=I+1,XMTEXT(I)=""
 S I=I+1,XMTEXT(I)="The special instructions to be ignored are:"
 S I=I+1,XMTEXT(I)=""
 S J=""
 F  S J=$O(XMSPEC(J)) Q:J=""  S I=I+1,XMTEXT(I)="   "_J
 S XMIEN=""
 F  S XMIEN=$O(^XMB(3.9,XMZ,1,"AQUEUE",XMINST,XMIEN)) Q:XMIEN=""  S XMTO($$SENDER^XMS3(XMZ,XMZREC,XMNVFROM,XMIEN))=""
 D SENDMSG^XMXSEND(.5,"Special Instructions Ignored","XMTEXT",.XMTO,.XMINSTR)
 Q
SPECSET(I,XMSPEC) ;
 S XMSPEC($P("^^^^CONFIRMATION request^VAPORIZE date^TYPE^^CLOSED status^^CONFIDENTIAL status^INFO status",U,I))=""
 Q
