XMXADDRD ;ISC-SF/GMB-Lookup Domain Name ;04/24/2002  10:36
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces PSP^XMA210,^XMA21A,^XMA21B (ISC-WASH/CAP)
DNS(XMDUZ,XMDOMAIN,XMVIA,XMVIAN) ;
 ; XMDOMAIN - (in/out) Domain name.  May be mixed case.  Must already be
 ;            in xxx.xxx.xxx format.
 ; XMVIA    - (out) IEN of (relay) domain (in ^DIC(4.2))
 ; XMVIAN   - (out) Name of (relay) domain
 N XMVIAREC,XMNETNAM
 S XMNETNAM=^XMB("NETNAME")
 S XMDOMAIN=$$UP^XLFSTR(XMDOMAIN)
 I XMDOMAIN=XMNETNAM D  Q
 . S XMVIA=^XMB("NUM")
 . S XMVIAN=XMNETNAM
 D FINDDOMN
 Q:$D(XMERROR)
 I XMVIAN="VA.GOV",$$FORUM D  Q
 . D SETERR^XMXADDR4($G(XMIA),"!",39100,XMDOMAIN) ;Domain not found: |1|
 I $G(XMIA) D
 . W:XMDOMAIN'=XMVIAN $$EZBLD^DIALOG(39101,XMVIAN) ;via |1|
 . I XMVIAN'=XMNETNAM,$P(XMVIAREC,U,2)'["S" W $$EZBLD^DIALOG(39102) ; queued
 Q
FORUM() ; Is this FORUM or GATEWAY?
 Q $S($G(XMNETNAM,^XMB("NETNAME"))'["FORUM.":0,1:1)
FINDDOMN ; Look up domain
 N XMSUBDOM,XMFLAGS,DIC,X,Y,XMDCIRCL
 S XMSUBDOM="",X=XMDOMAIN
 ;S XMFLAGS="ZMF"_$S('$G(XMIA):"O",$G(XMINSTR("EXACT")):"OE",$D(XMGCIRCL):"OE",1:"E")
 S XMFLAGS="ZMF"_$S($G(XMINSTR("EXACT")):"X",'$G(XMIA):"O",$D(XMGCIRCL):"O",1:"")_$S($G(XMIA):"E",1:"")
 S DIC="^DIC(4.2,",DIC(0)=XMFLAGS
 F  S D="B^C" D MIX^DIC1 Q:Y>0!(X'[".")!$D(DUOUT)!$D(DTOUT)  D  Q:X=XMNETNAM
 . S XMSUBDOM=XMSUBDOM_$P(X,".")_"."
 . S X=$P(X,".",2,999)
 I Y'>0,X'[".",'$G(XMIA),$L(X)<4 S DIC(0)="ZFX",D="C" D IX^DIC  ; Look for COM,MIL,NET,etc. as synonym for one of the domains.
 I Y>0 D  Q   ; Domain successfully found
 . I XMSUBDOM'="" D  Q:$D(XMERROR)
 . . D CHKDOM($E(XMSUBDOM,1,$L(XMSUBDOM)-1)) Q:$D(XMERROR)
 . . Q:Y(0,0)'=XMNETNAM
 . . D SETERR^XMXADDR4($G(XMIA),"!",39103,$E(XMSUBDOM,1,$L(XMSUBDOM)-1),X) ; Sub-domain '|1|' not found for domain '|2|'
 . I XMSUBDOM="",X'[".",$L(X)<4,$$FIND1^DIC(4.2996,"","QX",X) D NEEDSUB(X) Q
 . S XMDOMAIN=$S(XMSUBDOM="":Y(0,0),1:XMSUBDOM_X) ; MailMan's klugey way
 . ;S XMDOMAIN=XMSUBDOM_X ; Proper way?  Nope.
 . S XMVIA=+Y
 . S XMVIAREC=Y(0)
 . D VIA(.XMVIA,.XMVIAREC,.XMVIAN,.XMDCIRCL)
 I '$G(XMIA),X'=XMNETNAM D  Q:$D(XMERROR)
 . N Y,X
 . S X=XMDOMAIN
 . F  S Y=$$FIND1^DIC(4.2,"","MOQ",X,"B^C") Q:Y>0!$D(DIERR)!(X'[".")  D
 . . S X=$P(X,".",2,999)
 . Q:Y!'$D(DIERR)  ; (Y should never be >0, because we didn't find it before.)
 . I X'[".",$$FIND1^DIC(4.2996,"","QX",X) Q
 . D SETERR^XMXADDR4(0,"",39106,X) ;Domain ambiguous: |1|
 I $D(DTOUT)!$D(DUOUT) D  Q
 . ;up-arrow out. / time out.
 . D SETERR^XMXADDR4(1,"!",$S($D(DUOUT):37000,1:37001))
 I X'["." D  Q  ; Domain not found, look in internet suffix file
 . D LOOKSFX Q:$D(XMERROR)
 . I X=XMDOMAIN D NEEDSUB(X) Q
 . D CHKDOM($E(XMSUBDOM,1,$L(XMSUBDOM)-1))
 I X=XMNETNAM D  Q  ;Sub-domain '|1|' not found for domain '|2|'
 . D SETERR^XMXADDR4($G(XMIA),"!",39103,$E(XMSUBDOM,1,$L(XMSUBDOM)-1),X)
 Q
NEEDSUB(X) ;
 D SETERR^XMXADDR4(0,"",39104,X) ;Valid domain, but need subdomain: |1|
 Q:'$G(XMIA)
 ;Domain |1| is a valid Internet domain,
 ;but you must specify at least one sub-domain.
 N XMTEXT
 D BLD^DIALOG(39105,X,"","XMTEXT","F")
 D MSG^DIALOG("WE","","","","XMTEXT")
 Q
VIA(XMVIA,XMVIAREC,XMVIAN,XMDCIRCL) ;
 S XMVIAN=$P(XMVIAREC,U,1)
 Q:XMVIAN=XMNETNAM
 D CHKPRMIT(XMDUZ,XMVIAREC) Q:$D(XMERROR)
 I $D(XMDCIRCL(XMVIA)) D  Q
 . I $G(XMIA) D EN^DDIOL($$EZBLD^DIALOG(39088)) ;Error:
 . ;Circular relay domain: |1|
 . D SETERR^XMXADDR4($G(XMIA),"",39107,XMVIAN)
 I $P(XMVIAREC,U,3) D  Q  ; If there's a relay domain, follow it.
 . S XMDCIRCL(XMVIA)=""
 . S XMVIA=$P(XMVIAREC,U,3),XMVIAREC=$G(^DIC(4.2,XMVIA,0))
 . D VIA(.XMVIA,.XMVIAREC,.XMVIAN,.XMDCIRCL)
 Q:$P(XMVIAREC,U,2)'["S"
 Q:$O(^DIC(4.2,XMVIA,1,0))  ; Domain has script(s).
 Q:$L(XMVIAN)+1=$F(XMVIAN,XMNETNAM)  ; Subdomain of this domain.
 N Y
 I $L(XMVIAN,".")>3 D  I Y,$P(^DIC(4.2,+Y,0),U,1)=XMNETNAM Q  ; Subdomain of this domain.
 . N X
 . S X=$P(XMVIAN,".",2,999)
 . F  S Y=$$FIND1^DIC(4.2,"","QX",X,"C") Q:Y!($L(X,".")<3)  D
 . . S X=$P(X,".",2,999)
 ; No script, so send to parent domain, if there is one,
 ; and if the parent isn't the same as this domain.
 Q:'$G(^XMB("PARENT"))
 Q:'$G(^XMB("NUM"))
 Q:^XMB("PARENT")=^XMB("NUM")
 Q:'$D(^DIC(4.2,^XMB("PARENT"),0))
 S XMVIA=^XMB("PARENT")
 S XMVIAREC=^DIC(4.2,XMVIA,0)
 S XMVIAN=$P(XMVIAREC,U,1)
 Q
CHKDOM(XMDOM,XMMAXDOM,XMMAXDOT) ;
 N I,XMSUBDOM
 I $TR(XMDOM,".-","")'?.AN D  Q
 . ;Domain may not contain punctuation other than '.' or '-'.
 . D SETERR^XMXADDR4($G(XMIA),"!",39108)
 I '$D(XMMAXDOM) S XMMAXDOM=255
 I $L(XMDOM)>XMMAXDOM D  Q
 . ;Domain must be from 1 to |1| characters.
 . D SETERR^XMXADDR4($G(XMIA),"!",39109,XMMAXDOM)
 I '$D(XMMAXDOT) S XMMAXDOT=63
 F I=1:1:$L(XMDOM,".") D  Q:$D(XMERROR)
 . S XMSUBDOM=$P(XMDOM,".",I)
 . I XMSUBDOM?1AN.E,$L(XMSUBDOM)'>XMMAXDOT Q
 . ; 39110 - Domain dot pieces must be from 1 to |1| characters.
 . ; 39111 - Domain dot pieces must begin with a letter or number.
 . D SETERR^XMXADDR4($G(XMIA),"!",$S($L(XMSUBDOM,I)>XMMAXDOT:39110,1:39111),XMMAXDOT)
 . Q:'$G(XMIA)
 . D EN^DDIOL($$EZBLD^DIALOG(39112,XMSUBDOM)) ;|1| is not valid.
 Q
LOOKSFX ; Look for top level domain in internet suffix file
 ; Instead of looking in the file, we could call the COTS DNS, if it exists.
 N DIC,Y
 I $G(XMIA) D
 . D EN^DDIOL($$EZBLD^DIALOG(39113)) ;Looking in Internet Suffix file...
 . S DIC(0)=$TR(XMFLAGS,"O")_"X"
 E  S DIC(0)="X"
 S DIC="^DIC(4.2996,"
 S:$G(XMIA) DIC("W")="W ""  "",$P(^(0),U,2)"  ; high-level domain purpose/country
 D ^DIC
 I Y>0 D  Q:XMVIA
 . S XMVIA=$G(^XMB("PARENT"))
 . I 'XMVIA S XMVIA=$$FIND1^DIC(4.2,"","MQX",$S($$FORUM:"GK.VA.GOV",1:"FORUM.VA.GOV"),"B^C") Q:'XMVIA
 . S XMVIAREC=^DIC(4.2,XMVIA,0)
 . S XMVIAN=$P(XMVIAREC,U)
 D SETERR^XMXADDR4($G(XMIA),"!",39100,X) ;Domain not found: |1|
 Q
CHKPRMIT(XMDUZ,XMVIAREC) ;
 I $G(XMINSTR("ADDR FLAGS"))["R",'$D(XMRESTR("NET RECEIVE")) Q
 I $P(XMVIAREC,U,2)["C",$P(XMVIAREC,U,2)'["S" D  Q  ;Domain closed: |1|
 . D SETERR^XMXADDR4($G(XMIA),"!",39114,$P(XMVIAREC,U,1))
 Q:$G(XMINSTR("ADDR FLAGS"))["R"
 I $P(XMVIAREC,U,11)'="",'$D(^XUSEC($P(XMVIAREC,U,11),XMDUZ)) D  Q
 . ;You don't hold key to domain '|1|'.
 . D SETERR^XMXADDR4($G(XMIA),"!",39115,$P(XMVIAREC,U,1))
 ; Maybe the following belongs in XMFWD^XMVVITAE:
 ;I $P(XMVIAREC,U,2)["N" D  Q
 ;. D SETERR^XMXADDR4($G(XMIA),"!",XXXXX,$P(XMVIAREC,U,1)) ; No forwarding to domain '|1|'.
 Q
CHKNAME ; Input transform for .01 field of DOMAIN file 4.2
 N XMIA,XMERROR,I
 S XMIA=0
 S X=$$UP^XLFSTR(X)
 D CHKDOM(X,64,20)
 I $D(XMERROR) D  Q
 . D WRIERR^XMXADDR4("!,$C(7)")
 . K X
 Q:$D(DIFROM)
 F I=1:1:$L(X,".")-1 D  Q:'$D(X)
 . Q:'$D(^DIC(4.2996,"B",$P(X,".",I),0))
 . D EN^DDIOL($$EZBLD^DIALOG(39116),"","!,$C(7)")
 . K X ;Domain dot pieces must not match Internet reserved domain names.
 Q
