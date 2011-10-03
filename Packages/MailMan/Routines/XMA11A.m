XMA11A ;ISC-SF/GMB-Send/Answer a Message API ;04/18/2002  07:24
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/THM
 ;
 ; Entry points (DBIA 1233):
 ; WRITE  Send a message or Answer a message
 ;
WRITE ; Send a message or Answer a message
 ; Needs:
 ; XMDUZ  user number
 ; X      if $E(X)="A", then send an answer, else send a message
 ; XMZ    original message number, if we are sending an answer
 N XMV
 D INITAPI^XMVVITAE
 I $E(X)'="A" D SEND^XMJMS Q
 N XMZREC
 S XMZREC=^XMB(3.9,XMZ,0)
 K XMERR,^TMP("XMERR",$J)
 I '$$ANSWER^XMXSEC(XMDUZ,XMZ,XMZREC) D SHOW^XMJERR Q
 D ANSWER^XMJMA(XMDUZ,XMZ,$P(XMZREC,U,1),$P(XMZREC,U,2))
 Q
