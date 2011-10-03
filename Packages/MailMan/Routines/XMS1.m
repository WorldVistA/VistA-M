XMS1 ;ISC-SF/GMB-SMTP Send (RFC 821) ;05/20/2002  08:40
 ;;8.0;MailMan;**30**;Jun 28, 2002
 ; Was ISC-WASH/THM/CAP
 ;
 ; Entry points (DBIA 1151):
 ; $$SRVTIME Set message transmission status information
 ; $$STATUS  Get message transmission status information
SENDMSG(XMK,XMZ,XMB) ;
 N XMZREC,XMNVFROM,XMFROM,XMRCPT,XMNETNAM,XMRZ,XMCM
 ; XMCM("START") - timestamp at start of msg xmit
 ; XMCM("START","FM") - FM date/time (no seconds) at start of msg xmit
 K XMTLER,XMBLOCK,XMLIN
 D INIT(XMINST,XMZ,.XMZREC,.XMNVFROM,.XMFROM,.XMNETNAM)
 D ENVELOPE(XMNETNAM,XMINST,XMZ,XMZREC,XMNVFROM,.XMRZ,.XMRCPT) Q:ER
 D FINISH(XMINST,XMZ,XMRZ)
 Q
INIT(XMINST,XMZ,XMZREC,XMNVFROM,XMFROM,XMNETNAM) ;
 N XMFDA,XMIENS
 S XMIENS=XMINST_","
 S XMFDA(4.2999,XMIENS,1)=$H
 S XMFDA(4.2999,XMIENS,2)=XMZ ; Message in transit
 ;S XMFDA(4.2999,XMIENS,3)="@" ; Last line xmit'd
 D FILE^DIE("","XMFDA")
 S XMNETNAM=^XMB("NETNAME")
 S XMCM("START")=$$TSTAMP^XMXUTIL1
 S XMCM("START","FM")=+$E($$NOW^XLFDT,1,12) ; Strip off the seconds
 S XMZREC=^XMB(3.9,XMZ,0)
 S XMFROM=$$FROM($P(XMZREC,U,2),XMNETNAM)
 S XMNVFROM=$P($G(^XMB(3.9,XMZ,.7)),U,1) ; envelope from
 I XMNVFROM="" S XMNVFROM=XMFROM
 Q
ENVELOPE(XMNETNAM,XMINST,XMZ,XMZREC,XMNVFROM,XMRZ,XMRCPT) ;
 ; These commands are part of RFC 821 - SMTP.
 N XMRSET
 D MAIL(XMZ,XMZREC,.XMNVFROM,.XMRZ) Q:ER
 D RCPT(XMNETNAM,XMINST,XMZ,XMZREC,XMNVFROM,.XMRCPT) Q:ER
 ;I 'XMC("MAILMAN") D CHEKSPEC^XMS2(XMZREC)
 I XMC("MAILMAN") D NONSTD^XMS2(XMNETNAM,XMZ,XMZREC,.XMRZ,.XMRSET) Q:ER
 D DATACMD Q:ER
 I $G(XMRSET) D  Q:ER  ; Send: "" (if 'duplicate message')
 . S XMSG="" X XMSEN
 E  D  Q:ER  ; Send: header records followed by message text
 . I '$D(^XMB(3.9,XMZ,2,.001)) D  Q:ER
 . . D HEADER^XMS3(XMZ,XMZREC,XMFROM,XMNETNAM) Q:ER
 . . S XMSG="" X XMSEN Q:ER
 . D TEXT^XMS3(XMZ)
 ; Send: "."
 ; Recv: "250 'data' accepted"
 ;   or: "254 Duplicate (no add'l recipients).  Msg rejected."
 ;   or: "551 Too many lines.  Msg rejected."
 ;   or: "554 Duplicate (purged).  Msg rejected."
 ;   or: "555 Reply to 'Info Only'.  Msg rejected."
 S XMSG="." X XMSEN Q:ER
 I 'XMC("BATCH") S XMSTIME=300 X XMREC K XMSTIME Q:ER
 S:XMC("BATCH") XMRG="250 OK"
 Q:$E(XMRG)=2
 S (ER,ER("NONFATAL"))=1
 I "^551^554^555^552^"'[(U_$E(XMRG,1,3)_U) Q
 S XMRZ=$P(XMRG," ",2,99)
 D MSGERR^XMS3(XMSITE,XMINST,XMRG,XMZ,XMZREC,XMNVFROM,.XMRCPT)
 Q
DATACMD ; Send: "DATA"
 ; Recv: "354 Enter data"
 S XMSG="DATA" X XMSEN Q:ER
 I 'XMC("BATCH") X XMREC Q:ER
 S:XMC("BATCH") XMRG=300
 Q:$E(XMRG)=3
 D ERTRAN^XMC1(42356) ;Receiver will not accept DATA.
 S ER("MSG")=XMTRAN_" - "_XMRG
 Q
MAIL(XMZ,XMZREC,XMNVFROM,XMRZ) ; Send mail
 ; Send: "MAIL FROM:<USER.JOE@LOCAL.MED.VA.GOV>"
 ; Recv: "250 OK Message-ID:123456@REMOTE.MED.VA.GOV"
 S XMSG="MAIL FROM:"_XMNVFROM X XMSEN Q:ER
 I 'XMC("BATCH") S XMSTIME=300 X XMREC K XMSTIME Q:ER
 I XMC("BATCH") S XMRG="200 ID:Batch"
 I $E(XMRG)'=2 D  Q
 . S (ER,ER("NONFATAL"))=1
 . Q:"^501^502^553^"'[(U_$E(XMRG,1,3)_U)
 . ; 501: Exchange says Syntax error
 . ; 502: MailMan says it won't accept msgs from you.
 . ; 553: Exchange says something's wrong with your FROM address.
 . D MSGERR^XMS3(XMSITE,XMINST,XMRG,XMZ,XMZREC,XMNVFROM)
 S XMRZ=$P(XMRG,"ID:",2)
 Q
FROM(XMFROM,XMNETNAM) ;
 I $F(XMFROM,"@"_XMNETNAM)>$L(XMFROM) S XMFROM=$P(XMFROM,"@"_XMNETNAM)
 I XMFROM'["@" Q "<"_$$NETNAME^XMXUTIL(XMFROM)_">"
 Q "<"_$$REMADDR^XMXADDR3(XMFROM)_">"
RCPT(XMNETNAM,XMINST,XMZ,XMZREC,XMNVFROM,XMRCPT) ; Identify Recipients
 ; Send: "RCPT TO:<USER.JANE@REMOTE.MED.VA.GOV>"
 ; Recv: "250 'RCPT' accepted"
 ;   or: "550 Addressee not found." or "550 Addressee ambiguous."
 ;
 ; When communicating with a MailMan site, we also can add non-standard
 ; information on who forwarded the message to this recipient, and/or
 ; whether the recipient is 'information only' or 'copy'.
 ; Send: "RCPT TO:<I:USER.JANE@REMOTE.MED.VA.GOV> FWD BY:<USER.LEX@LOCAL.MED.VA.GOV>"
 N XMIEN,XMTO,XMTOREC,XMPREFIX,XMTOX,XMTRY,XMFWDBY,XM2MANY
 S (XMIEN,XM2MANY)=0
 F  S XMIEN=$O(^XMB(3.9,XMZ,1,"AQUEUE",XMINST,XMIEN)) Q:XMIEN=""  D  Q:ER!XM2MANY
 . S XMTOREC=$G(^XMB(3.9,XMZ,1,XMIEN,0))
 . I $P(XMTOREC,U,7)'=XMINST D  Q
 . . K ^XMB(3.9,XMZ,1,"AQUEUE",XMINST,XMIEN)
 . I XMC("MAILMAN") D
 . . S XMPREFIX=$P($G(^XMB(3.9,XMZ,1,XMIEN,"T")),U)
 . . S XMFWDBY=$G(^XMB(3.9,XMZ,1,XMIEN,"F"))
 . . I XMFWDBY'="" S XMFWDBY=$$FWDBY(XMFWDBY)
 . E  S (XMPREFIX,XMFWDBY)=""
 . S XMTO=$$TOFORMAT($P(XMTOREC,U),XMPREFIX)
 . S XMSG="RCPT TO:<"_XMTO_">"_$S(XMFWDBY="":"",1:" FWD BY:"_XMFWDBY) X XMSEN Q:ER
 . I 'XMC("BATCH") S XMSTIME=300 X XMREC K XMSTIME Q:ER
 . I XMC("BATCH") S XMRG="250 In transit"
 . I $E(XMRG,1,2)=25 S XMRCPT(XMIEN)="" Q
 . I $E(XMRG,1,3)=552 S XM2MANY=1 Q  ; 552: Too many recipients / exceed storage allocation
 . I $E(XMRG,1,3)=221 S ER=1 Q  ; 221: Closing Connection
 . D RCPTERR^XMS3(XMRG,XMZ,XMZREC,XMNVFROM,$P(XMTOREC,U),XMTO,XMIEN)
 S:'$D(XMRCPT) (ER,ER("NONFATAL"))=1
 Q
TOFORMAT(XMTO,XMPREFIX) ;
 N XMDOM
 S XMDOM=$S(XMTO["@":$P(XMTO,"@",2,99),1:XMNETNAM)
 S XMTO=$$TO($P(XMTO,"@"))
 Q $S(XMPREFIX="":"",$E(XMTO,1)=$C(34):"",1:XMPREFIX_":")_XMTO_"@"_XMDOM
TO(XMTO) ;
 I XMTO?.E1C.E S XMTO=$$CTRL^XMXUTIL1(XMTO)
 Q:XMTO?.A XMTO
 I $E(XMTO)=$C(34),$E(XMTO,$L(XMTO))=$C(34) Q XMTO
 ; If we translate blanks to underscores, we have to be careful with
 ; G. and S. names which contain blanks.  ^XMXADDR* looks for G. and
 ; S. names, and it will translate them back, if necessary.
 ; But Austin is running pre-patch 50 v7.1 MailMan code, which will not
 ; translate them back.  So... for G. and S., we will only translate
 ; when sending to non-MailMan sites.
 I XMTO[","!XMTO[" " D
 . I ".G.g.D.d.H.h.S.s."[("."_$E(XMTO,1,2)),XMC("MAILMAN") Q
 . S XMTO=$TR(XMTO,", .","._+")
 ;Allowed punctuation (without quoting rcpt name is .%_-@+!
 I $TR(XMTO,"()<>@,;:\[]"_$C(34),"")=XMTO Q XMTO
 N I,% ; Reformat name for \ and " characters
 F %="\",$C(34) D
 . S I=0
 . F  S I=$F(XMTO,%,I+1) Q:'I  S XMTO=$E(XMTO,1,I-2)_"\"_$E(XMTO,I-1,999)
 Q XMTO
FWDBY(XMFREC) ;
 I $E(XMFREC,1)=" " Q ""
 I $E(XMFREC,1)="<" Q $P(XMFREC,">",1)_">"
 N XMFDUZ
 S XMFDUZ=$P(XMFREC,U,2)
 I +XMFDUZ=XMFDUZ Q "<"_$$NETNAME^XMXUTIL(XMFDUZ)_">"
 Q ""
FINISH(XMINST,XMZ,XMRZ) ;
 D XMTHIST^XMTDR(XMINST,"S",$P($G(^XMB(3.9,XMZ,2,0)),U,4))
 N XMIEN,XMIENS
 S XMIEN=0
 F  S XMIEN=$O(XMRCPT(XMIEN)) Q:'XMIEN  D
 . N XMFDA
 . S XMIENS=XMIEN_","_XMZ_","
 . S XMFDA(3.91,XMIENS,3)=XMRZ   ; remote msg id
 . S XMFDA(3.91,XMIENS,4)=XMCM("START","FM") ; xmit date/time
 . S XMFDA(3.91,XMIENS,5)=$S(XMC("BATCH"):$$EZBLD^DIALOG(39303.6),1:"@")   ; status: In transit
 . S XMFDA(3.91,XMIENS,6)="@"    ; path
 . S XMFDA(3.91,XMIENS,9)=$$TSTAMP^XMXUTIL1-XMCM("START") ; xmit time (seconds)
 . D FILE^DIE("","XMFDA")
 . S $P(^XMB(3.9,XMZ,1,XMIEN,0),U,7)=XMINST_":"_XMINST ; violates the DD, but we've always done this, and it might help in debugging.
 Q
 ; The following have nothing to do with the above.
 ; They are simply here because of an existing DBIA.
STATUS(XMZ,XMRECIP) ; Get Recipient Status
 N XMIEN
 S XMIEN=$$FIND1^DIC(3.91,","_XMZ_",","QX",XMRECIP,"C") Q:'XMIEN ""
 Q $P($G(^XMB(3.9,XMZ,1,XMIEN,0)),U,6)
SRVTIME(XMZ,XMRECIP,XMSTRING) ; Set Recipient Status
 ;Returns 0 for success, 1 for failure
 ;Parameters=(Message#,Recipient,Status)
 I $L(XMSTRING)>30 Q "2 Status too long"
 I XMSTRING[U Q "3 Bad Characters in Status"
 N XMIEN,XMIENS
 S XMIEN=$$FIND1^DIC(3.91,","_XMZ_",","QX",XMRECIP,"C") Q:'XMIEN "1 No Update"
 S XMIENS=XMIEN_","_XMZ_","
 D SETSTAT^XMTDO(XMIENS,XMSTRING)
 Q 0
