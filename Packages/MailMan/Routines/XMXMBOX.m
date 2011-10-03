XMXMBOX ;ISC-SF/GMB-Mailbox APIs ;04/17/2002  14:10
 ;;8.0;MailMan;;Jun 28, 2002
QMBOX(XMDUZ,XMMSG) ; Message counts for a mailbox
 K XMERR,^TMP("XMERR",$J)
 S XMMSG=""
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC  Q
 S XMMSG=$$NEWS^XMXUTIL(XMDUZ)
 Q
FLTRMBOX(XMDUZ,XMMSG) ; Filter all the messages in a user's mailbox.
 K XMERR,^TMP("XMERR",$J)
 S XMMSG=""
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC Q
 N XMK
 S XMK=.99
 F  S XMK=$O(^XMB(3.7,XMDUZ,2,XMK)) Q:XMK'>0!(XMDUZ=.5&(XMK>999))  D
 . D FLTRBSKT^XMXBSKT(XMDUZ,XMK)
 S XMMSG=$$EZBLD^DIALOG(34306.3) ; Mailbox filtered.
 Q
CRE8MBOX(XMDUZ,XMDATE) ; Create a Mailbox for a user
 ; XMDUZ  The user's DUZ
 ; XMDATE The user has been reinstated after not having worked here a
 ;        while.  Please note the earliest message date which the user
 ;        may access, and don't let the user access any messages before
 ;        that date, except for any which someone might forward to the
 ;        user.
 ;        =fileman date or any supported date format that FileMan
 ;         recognizes (The date must be exact.)
 ;         The user may not access any before this date.
 ;        =0      - (default) The user may access any old msgs which had
 ;                  been addressed to the user.
 K XMERR,^TMP("XMERR",$J)
 ;I DUZ'=.5,'$$POSTPRIV^XMXSEC Q
 I '$D(^XMB(3.7,XMDUZ,0)) D
 . N XMFDA,XMIEN,XMTRIES
 . S XMFDA(3.7,"+1,",.01)=XMDUZ
 . S XMIEN(1)=XMDUZ
CTRY . D UPDATE^DIE("S","XMFDA","XMIEN") Q:'$D(DIERR)
 . S XMTRIES=$G(XMTRIES)+1
 . I $D(^TMP("DIERR",$J,"E",110)) H 1 G CTRY ; Try again if can't lock
 D:'$D(^XMB(3.7,XMDUZ,2,.5,0)) MAKEBSKT^XMXBSKT(XMDUZ,.5,$$EZBLD^DIALOG(37004)) ; WASTE
 D:'$D(^XMB(3.7,XMDUZ,2,1,0)) MAKEBSKT^XMXBSKT(XMDUZ,1,$$EZBLD^DIALOG(37005)) ; IN
 ; Limit message access at reinstatement?
 Q:$G(XMDATE)=""!($G(XMDATE)=0)
 N XMFDA
 S XMFDA(3.7,XMDUZ_",",1.2)=XMDATE
 D FILE^DIE("E","XMFDA")
 Q
TERMMBOX(XMDUZ) ; Terminate a user's Mailbox
 ; (Delete all traces of a user in MailMan)
 ; XMDUZ  The user's DUZ
 K XMERR,^TMP("XMERR",$J)
 I DUZ'=.5,'$$POSTPRIV^XMXSEC Q
 D TERMINAT^XMUTERM1(XMDUZ)
 Q
