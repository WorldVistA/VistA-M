XMR1 ;ISC-SF/GMB-SMTP Receiver HELO/MAIL/RCPT (RFC 821) ;02/10/2004  06:31
 ;;8.0;MailMan;**6,24**;Jun 28, 2002
HELO ; Recv: "HELO REMOTE.MED.VA.GOV <security num>"
 ; Send: "250 OK LOCAL.MED.VA.GOV <security num> [8.0,DUP,SER,FTP]"
 N X,Y,XMDOMREC
 I XMP="" S XMSG="501 Missing domain specification" X XMSEN Q
 I '$D(^XMB("NETNAME")) S XMSG="550 Unchristened local domain" X XMSEN Q
 S X=$P(XMP,"<")
 I $E(X,$L(X))="." S XMSG="501 Invalid Domain Name" X XMSEN Q
 S XMSTATE="^HELO^QUIT^"
 S X=$$UP^XLFSTR(X)
 S Y=$$FACILITY(X)
 I Y>0 D
 . S XMINST=+Y
 . S (XMSITE,XMC("HELO RECV"))=$P(Y,U,2)
 E  I $$REJECT(X) D  Q
 . S XMSG="421 Service not available, closing transmission channel" X XMSEN
 . S XMC("QUIT")=1
 E  D
 . S XMC("HELO RECV")=X
 . S Y=$$DOMAIN(X)
 . S XMINST=+Y
 . S XMSITE=$P(Y,U,2)
 I +$G(^XMB(1,1,4)) D
 . D NORELAY
 E  S XMC("RELAY OK")=1
 I XMC("BATCH") S XMSTATE="^MAIL^",XMCONT=XMCONT_"TURN^MESS^" Q
 S XMDOMREC=^DIC(4.2,XMINST,0)
 I $P(XMDOMREC,U,15) D VALPROC(XMINST,XMDOMREC,XMP,.XMRVAL) Q:'$D(XMRVAL)
 S XMSG="250 OK "_^XMB("NETNAME")_$S($D(XMRVAL):" <"_XMRVAL_">",1:"")_" ["_$P($T(XMR1+1),";",3)_",DUP,SER,FTP]" X XMSEN
 S XMSTATE="^MAIL^",XMCONT=XMCONT_"TURN^MESS^"
 Q
NORELAY ; We want to prevent this site from unwittingly acting as a relay
 ; domain for spammers or viruses.  Such nefarious ne'erdowells
 ; typically route their mail through unsuspecting sites to "launder"
 ; it.  The unsuspecting sites forward it onward.
 ; XMC("HELO RECV") contains the sending site's name.  If we
 ; were to be truly vigorous about this, we would find out the IP
 ; address of the site and do a reverse DNS lookup to verify the site's
 ; name.  We don't yet have that capability, so we'll have to make do
 ; with XMC("HELO RECV") and trust that the site is who it says it is.
 N XMOKDOM
 S XMOKDOM="" ; Get list of acceptable sites
 F  S XMOKDOM=$O(^XMB(1,1,4.1,"B",XMOKDOM)) Q:XMOKDOM=""  D
 . S XMC("MY DOMAIN",$$UP^XLFSTR(XMOKDOM))=""
 I $F(^XMB("NETNAME"),".VA.GOV")=($L(^XMB("NETNAME"))+1) D
 . ; This is a VA site.  Make sure mail from other VA sites is relayed.
 . I '$D(XMC("MY DOMAIN",".VA.GOV")) S XMC("MY DOMAIN",^XMB("NETNAME"))=""
 S XMOKDOM="" ; Make sure this site is an acceptable site!
 F  S XMOKDOM=$O(XMC("MY DOMAIN",XMOKDOM)) Q:XMOKDOM=""  Q:$F(^XMB("NETNAME"),XMOKDOM)=($L(^XMB("NETNAME"))+1)
 I XMOKDOM="" S XMC("MY DOMAIN",^XMB("NETNAME"))="" ; Default
 ; Set XMC("RELAY OK")=1 if the sending site is acceptable.
 S XMOKDOM=""
 F  S XMOKDOM=$O(XMC("MY DOMAIN",XMOKDOM)) Q:XMOKDOM=""  Q:$F(XMC("HELO RECV"),XMOKDOM)=($L(XMC("HELO RECV"))+1)
 S XMC("RELAY OK")=XMOKDOM'=""
 Q
FACILITY(X) ; If full domain name is found in domain file, either as main
 ; entry or as synonym, return main entry.  "Domain IEN^Domain name"
 N DIC,Y,D
 S DIC="^DIC(4.2,",DIC(0)="FMOZ",D="B^C"
 D MIX^DIC1
 Q $S(Y>0:+Y_U_Y(0,0),1:Y)
DOMAIN(XMDOMAIN) ; Try to find the domain.
 N DIC,X,Y,D
 S (X,XMDOMAIN)=$$UP^XLFSTR(XMDOMAIN)
 S DIC="^DIC(4.2,",DIC(0)="FMXZ",D="B^C"
 F  D MIX^DIC1 Q:Y>0!(X'[".")  S X=$P(X,".",2,99)
 Q:Y>0 +Y_U_Y(0,0)
 N XMTOP
 S XMTOP=X
 ; If the top-level domain is found in the Internet Suffix file, then
 ; just pretend that we're talking to this site's parent.
 ; (TURN command will be disabled.)
 I $$FIND1^DIC(4.2996,"","QX",XMTOP) Q ^XMB("PARENT")_U_$P(^DIC(4.2,^XMB("PARENT"),0),U,1)
 ; Add the top-level domain to the DOMAIN file.
 N XMFDA,XMIENS,XMIEN
 S XMIENS="?+1,"
 S XMFDA(4.2,XMIENS,.01)=XMTOP        ; Top-level domain name
 S XMFDA(4.2,XMIENS,1)="C"            ; Closed
 S XMFDA(4.2,XMIENS,1.7)="y"          ; Disable TURN command
 S XMFDA(4.2,XMIENS,2)=^XMB("PARENT") ; Relay domain
 D UPDATE^DIE("","XMFDA","XMIEN")
 ; If there's a problem with adding the top-level domain to the DOMAIN
 ; file, just pretend that we're talking to this site's parent.
 ; (TURN command will be disabled.)
 I $D(DIERR) Q ^XMB("PARENT")_U_$P(^DIC(4.2,^XMB("PARENT"),0),U,1)
 ; Notify someone that we've added a new domain to the DOMAIN file.
 N XMINSTR,XMPARM
 S XMPARM(1)=XMTOP
 S XMPARM(2)=XMDOMAIN
 S XMINSTR("FROM")="POSTMASTER"
 D TASKBULL^XMXBULL(.5,"XM DOMAIN ADDED",.XMPARM,,,.XMINSTR)
 Q XMIEN(1)_U_XMTOP
VALPROC(XMINST,XMDOMREC,XMP,XMRVAL) ; Check validation number
 L +^DIC(4.2,XMINST,0):0 E  S XMSG="550 Domain file locked, try later" X XMSEN Q
 S XMRVAL=$P($P(XMP,"<",2),">")
 D VALCHK(.XMDOMREC,XMRVAL)
 I '$D(XMRVAL) L -^DIC(4.2,XMINST,0) Q
 S XMRVAL=$R(8000000)+1000000 ; generate new validation number
 ;set val. num in return message, set new Val. num field
 S $P(XMDOMREC,U,18)=XMRVAL
 S ^DIC(4.2,XMINST,0)=XMDOMREC
 Q
VALCHK(XMDOMREC,XMRVAL) ; Check the validation number
 Q:XMRVAL=$P(XMDOMREC,U,15)  ; 15=current number; 18=new number
 I XMRVAL=$P(XMDOMREC,U,18) S $P(XMDOMREC,U,15)=$P(XMDOMREC,U,18) Q
 K XMRVAL
 N XMPARM,XMINSTR
 S XMINSTR("FROM")="POSTMASTER"
 S XMPARM(1)=XMC("HELO RECV")
 D TASKBULL^XMXBULL(.5,"XMVALBAD",.XMPARM,"","",.XMINSTR)
 S XMSG="550 Bad validation number" X XMSEN
 Q
VALSET(XMINST,XMRVAL) ;check validation number
 ;if new val. num. exist, then set val. num. to it and set to null
 Q:'$G(XMRVAL)
 N XMDOMREC
 S XMDOMREC=$G(^DIC(4.2,XMINST,0))
 S $P(XMDOMREC,U,15)=XMRVAL
 S $P(XMDOMREC,U,18)=""
 S ^DIC(4.2,XMINST,0)=XMDOMREC
 L -^DIC(4.2,XMINST,0)
 K XMRVAL
 Q
MAIL ; Recv: "MAIL FROM:<USER.JOE@REMOTE.MED.VA.GOV>"
 ; Send: "250 OK Message-ID:12345@LOCAL.MED.VA.GOV"
 N XMD
 S XMP=$P(XMP,":",2,999)
 S XMP=$$SCRUB^XMR3(XMP)
 I XMP'?1"<>",(XMP'?1"<"1.E1"@"1.E1">") S XMSG="501 Invalid reverse-path specification" X XMSEN Q
 I $$REJECT(XMP) S XMSG="502 No message receipt authorization." X XMSEN Q
 K XMINSTR,XMNVFROM,XMREMID,XMRXMZ,XM2LONG,XMZ,XMZFDA,XMZIENS,^TMP("XMY",$J),^TMP("XMY0",$J)
 S XMINSTR("FWD BY")="" ; We're not sure who sent/forwarded it
 S XMINSTR("ADDR FLAGS")="R"
 K:$D(XMERR) XMERR K:$D(^TMP("XMERR",$J)) ^TMP("XMERR",$J)
 D CRE8XMZ^XMXSEND($$EZBLD^DIALOG(34012),.XMZ) ; * No Subject *
 I $D(XMERR) D  Q
 . S XMSG="555 "_^TMP("XMERR",$J,1,"TEXT",1)
 . K XMERR,^TMP("XMERR",$J)
 . X XMSEN
 S XMZIENS=XMZ_","
 S (XMNVFROM,XMZFDA(3.9,XMZIENS,1),XMZFDA(3.9,XMZIENS,41))=XMP ; mail from
 S XMSTATE="^RCPT^DATA"
 S (XMD,XMZFDA(3.9,XMZIENS,1.4))=$$NOW^XLFDT() ; Message date default
 S $P(^XMB(3.9,XMZ,0),U,3)=XMD
 D PUTMSG^XMXMSGS2(.5,.95,"ARRIVING",XMZ)
 S XMSG="250 OK Message-ID:"_XMZ_"@"_^XMB("NETNAME") X XMSEN Q:ER
 S XMD=$$INDT^XMXUTIL1(XMD)
 ;DON'T CHANGE ORDER OF .001 & .002 LINES !
 S ^XMB(3.9,XMZ,2,.001,0)="Received: "_$S($L($G(XMC("HELO RECV"))):"from "_XMC("HELO RECV")_" by "_^XMB("NETNAME")_" (MailMan/"_$P($T(XMR1+1),";",3)_" "_XMPROT_")",1:"(BATCH)")_" id "_XMZ_" ; "_XMD
 N XMFDA,XMIENS
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,1)=$H
 S XMFDA(4.2999,XMIENS,2)=XMZ   ; Message in transit
 ;S XMFDA(4.2999,XMIENS,3)="@"   ; Last line xmit'd
 D FILE^DIE("","XMFDA")
 Q
REJECT(XMNVFROM) ; Check Senders rejected list
 Q:'$O(^XMBX(4.501,0)) 0
 N XMNO,XMREJECT,XMIEN,XMREC
 S XMNVFROM=$$UP^XLFSTR(XMNVFROM)
 S XMNO="",XMREJECT=0
 F  S XMNO=$O(^XMBX(4.501,"B",XMNO)) Q:XMNO=""  D  Q:XMREJECT
 . Q:XMNVFROM'[$$UP^XLFSTR(XMNO)
 . S XMIEN=$O(^XMBX(4.501,"B",XMNO,0)) Q:'XMIEN
 . S XMREC=$G(^XMBX(4.501,XMIEN,0)) Q:XMREC=""
 . I XMNVFROM[$$UP^XLFSTR($P(XMREC,U,1)),'$P(XMREC,U,2) S XMREJECT=1
 Q XMREJECT
RCPT ; Specify recipients
 S XMP=$P(XMP,":",2,999) I XMP="" S XMSG="501 Invalid forward path specification" X XMSEN Q
 I XMP["> FWD BY:" S XMINSTR("NET FWD BY")=$P(XMP,"> FWD BY:",2)
 E  K XMINSTR("NET FWD BY")
 Q:$$LOOKUP(XMP,.XMINSTR)=0
 S XMSG="250 'RCPT' accepted" X XMSEN
 S XMSTATE="^DATA^RCPT"
 Q
LOOKUP(XMTO,XMINSTR) ;
 N XMFULL,XMRESTR
 S XMRESTR("NET RECEIVE")=$G(XMNVFROM)
 S XMTO=$TR($P($P(XMTO,">",1),"<",2,99),"<")  ; I've seen <<user@site> and <<user@site>>
 I XMTO="" S XMSG="550 Malformed address" X XMSEN Q 0
 I $E(XMTO,1)'="""",XMTO?1"@"1.E1":"1.E1"@"1.E S XMTO=$P(XMTO,":",2)
 D CHKADDR^XMXADDR(.5,XMTO,.XMINSTR,.XMRESTR,.XMFULL)
 I $D(XMERR) D  Q 0
 . S XMSG="550 "_^TMP("XMERR",$J,XMERR,"TEXT",1)
 . X XMSEN
 . K XMERR,^TMP("XMERR",$J)
 I $G(XMFULL)="SHARED,MAIL" D  Q 0
 . S XMSG="550 'Shared,Mail' user may not receive network mail."
 . X XMSEN
 . K ^TMP("XMY",$J,.6),^TMP("XMY0",$J,"SHARED,MAIL")
 ; Don't act as a relay domain for unauthorized sites.
 I XMFULL'["@" Q XMFULL  ; Local address OK
 I XMC("RELAY OK") Q XMFULL  ; Relay from accepted site
 N XMOKDOM,XMTRELAY
 S XMTRELAY=$P(XMFULL,"@",2)
 S XMOKDOM=""
 F  S XMOKDOM=$O(XMC("MY DOMAIN",XMOKDOM)) Q:XMOKDOM=""  Q:$F(XMTRELAY,XMOKDOM)=($L(XMTRELAY)+1)
 I XMOKDOM'="" Q XMFULL  ; Relay from an outside site to an inside site.
 ; Relay from an outside site to an outside site.
 S XMSG="550 Relaying denied."
 X XMSEN
 K ^TMP("XMY",$J,XMFULL),^TMP("XMY0",$J,XMFULL)
 ; Notify someone that a relay attempt was denied.
 N XMINSTR,XMPARM,XMTO
 S XMPARM(1)=XMC("HELO RECV")
 S XMPARM(2)=XMFULL
 S XMPARM(3)=XMNVFROM
 S XMINSTR("FROM")="POSTMASTER"
 S XMTO(.5)=""
 D TASKBULL^XMXBULL(.5,"XM RELAY ATTEMPTED",.XMPARM,,.XMTO,.XMINSTR)
 Q 0
