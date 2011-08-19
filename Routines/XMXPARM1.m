XMXPARM1 ;ISC-SF/GMB-Parameter check (cont.) ;04/19/2002  12:14
 ;;8.0;MailMan;**36**;Jun 28, 2002
CHKUSER(XMDUZ,XMNOMBOX) ; Ascertain/verify user's DUZ, and make sure authorized to use MailMan
 ; XMNOMBOX Is it possible that this user does not have a mailbox?
 ;          0=no (default); 1=yes
 N XMSCREEN,XMUSER,XMADDR
 S XMADDR=XMDUZ
 S XMADDR=$$UP^XLFSTR(XMADDR)
 ;S:'$G(XMNOMBOX) XMSCREEN="I $L($P(^(0),U,3)),$D(^XMB(3.7,+Y,2))"  ; User must have an access code & mailbox
 I '$G(XMNOMBOX),'$$USERTYPE^XUSAP(XMDUZ,"APPLICATION PROXY") S XMSCREEN="I $L($P(^(0),U,3)),$D(^XMB(3.7,+Y,2))"  ; User must have an access code & mailbox
 ; "B^BB^C^D" = name^alias^initial^nickname
 S XMDUZ=$$FIND1^DIC(200,"","O",$S(+XMADDR=XMADDR:"`"_XMADDR,1:XMADDR),"B^BB^C^D",.XMSCREEN)
 Q:XMDUZ
 S XMDUZ=XMADDR
 D ERRSET^XMXUTIL($S($D(DIERR):39432,1:39433),XMDUZ) ; User '|1|' ambiguous / not found.
 Q
XMATTACH(XMATTACH) ; Validate attachments
 Q
XMBN(XMBN) ; Check bulletin name
 I $G(XMBN)="" D ERRSET^XMXUTIL(39430) Q  ; Bulletin name must be supplied.
 Q:$D(^XMB(3.6,"B",XMBN))
 D ERRSET^XMXUTIL(39431,XMBN) ; Bulletin '|1|' not found.
 Q
XMBODY(XMBODY,XMOPTNL) ; Check the body of the message (just make sure there is a body)
 I $G(XMBODY)="" D  Q
 . I '$G(XMOPTNL) D ERRSET^XMXUTIL(39405) ;Message must have a body.
 I $E(XMBODY,1,6)="XMBODY" D  Q
 . D ERRSET^XMXUTIL(39406) ;Message body may not be called XMBODY.
 I $D(@XMBODY)'>9 D  Q
 . D ERRSET^XMXUTIL(39407,XMBODY) ;Message body '|1|' has no data.
 Q
XMCODE(XMPARM,XMCODE,XMSET) ;
 Q:XMSET[(U_XMCODE_U)
 N XMP
 S XMP("PARAM","ID")=XMPARM
 S XMP("PARAM","VALUE")=XMCODE
 ;S XMP("PARAM","FILE")=3.901,XMP("PARAM","FIELD")=1.8
 S XMP(1)=XMSET
 D ERRSET^XMXUTIL(39438,.XMP) ; Must be one of |1|.
 Q
XMHINT(XMHINT) ; Validate a scramble hint
 I $G(XMHINT)="" Q
 ;I $G(XMHINT)="" D ERRSET^XMXUTIL(39436) Q  ; Scramble hint must be supplied
 ;D CHK^DIE(3.9,1.8,"H",XMHINT)
 I $L(XMHINT)>0,$L(XMHINT)<41,XMHINT'[U Q
 N XMP
 S XMP("PARAM","ID")="XMINSTR(""SCR HINT"")"
 S XMP("PARAM","VALUE")=XMHINT
 ;S XMP("PARAM","FILE")=3.901,XMP("PARAM","FIELD")=1.8
 S XMP(1)=1,XMP(2)=40
 D ERRSET^XMXUTIL(39437,.XMP) ; Must be |1|-|2| characters, no ^.
 Q
XMKEY(XMKEY) ; Validate a scramble key
 I $G(XMKEY)="" D ERRSET^XMXUTIL(39435) Q  ; Scramble key must be supplied.
 ;D CHK^DIE(3.9,1.85,"H",XMKEY)
 I $L(XMKEY)>2,$L(XMKEY)<21 Q
 N XMP
 S XMP("PARAM","ID")="XMINSTR(""SCR KEY"")"
 S XMP("PARAM","VALUE")=XMKEY
 ;S XMP("PARAM","FILE")=3.9,XMP("PARAM","FIELD")=1.85
 S XMP(1)=3,XMP(2)=20
 D ERRSET^XMXUTIL(39434,.XMP) ; Must be |1|-|2| characters.
 Q
XMKZ(XMK,XMKZ) ;
 I $G(XMKZ),$D(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ)) Q
 N XMP S XMP(1)=XMKZ,XMP(2)=XMK
 D ERRSET^XMXUTIL(34351,.XMP) ; message not found in basket
 Q
XMKZA(XMKZA) ; Check the message numbers (just make sure there is at least one)
 Q:$D(XMKZA)
 D ERRSET^XMXUTIL(39418) ;No message numbers.
 Q
XMROOT(XMPARM,XMROOT) ; Validate root
 Q
XMSTRIP(XMSTRIP) ; Validate a message strip string
 I $L(XMSTRIP)>0,$L(XMSTRIP)<21 Q
 N XMP
 S XMP("PARAM","ID")="XMINSTR(""STRIP"")"
 S XMP("PARAM","VALUE")=XMSTRIP
 S XMP(1)=1,XMP(2)=20
 D ERRSET^XMXUTIL(39434,.XMP) ; Must be |1|-|2| characters.
 Q
XMTO(XMTO,XMOPTNL) ; Check the addressees (just make sure there is at least one)
 Q:$D(XMTO)
 I $G(XMOPTNL),$$GOTADDR^XMXADDR Q
 D ERRSET^XMXUTIL(39408) ;No recipients
 Q
