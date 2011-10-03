XMA1B ;ISC-SF/GMB-Save/Delete Message APIs ;04/17/2002  07:09
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/THM
 ;
 ; Entry points (DBIA 10065):
 ; KL    Delete a message from a basket
 ; KLQ   Delete a message from a basket and put it in the WASTE basket.
 ; S2    Put a message in a basket
 ;
KL ; Delete a message from a basket
 ; In:
 ; XMDUZ  User's DUZ
 ; XMK    Basket number (optional)
 ; XMZ    Message number
 I '$D(XMK) S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,0)) Q:'XMK
 I XMK,'$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)) S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,0)) Q:'XMK
 D ZAPIT^XMXMSGS2(XMDUZ,XMK,XMZ)
 Q
KLQ ; Delete a message from a basket AND put it in waste basket
 ; In:
 ; XMDUZ  User's DUZ
 ; XMK    Basket number (optional)
 ; XMZ    Message number
 D KL Q:XMK=.5
 S XMKM=.5
 ; Fall through to S2
S2 ; Put a message in a basket.
 ; In:
 ; XMDUZ   User's DUZ
 ; XMKM    Basket number
 ; XMZ     Message number
 N XMK,XMKN
 K XMERR,^TMP("XMERR",$J)
 S XMK=$$XMK^XMXPARM(XMDUZ,"XMKM",.XMKM)
 I $D(XMERR) K XMERR,^TMP("XMERR",$J) Q
 I XMK>1 S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)
 E  S XMKN=$$EZBLD^DIALOG($S(XMK=.5:37004,1:37005)) ; WASTE / IN
 D PUTMSG^XMXMSGS2(XMDUZ,XMK,XMKN,XMZ)
 K XMKM
 Q
