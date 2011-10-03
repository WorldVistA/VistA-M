XMA2 ;ISC-SF/GMB-Create Message Stub API ;04/19/2002  12:35
 ;;8.0;MailMan;;Jun 28, 2002
 ; Was (WASH ISC)/CAP/THM
 ;
 ; Entry points (DBIA 10066):
 ; GET  get a message number
 ; XMZ  get a message number
XMZ ; Create stub/return error
 ; In:
 ; XMDUZ  User's DUZ or free text
 ; XMSUB  Message subject
 ; Out:
 ; XMZ    Message number (-1 if error)
 D MAKESTUB($G(XMDUZ),XMSUB,.XMZ,1)
 Q
GET ; Create stub
 ; In:
 ; XMDUZ  User's DUZ or free text
 ; XMSUB  Message subject
 ; Out:
 ; XMZ    Message number (HALT if error)
 D MAKESTUB($G(XMDUZ),XMSUB,.XMZ)
 Q
MAKESTUB(XMDUZ,XMSUBJ,XMZ,XMRETURN) ;
 N XMZREC,XMSENDR
 I '$G(DUZ) N DUZ D DUZ^XUP(.5)
 I XMDUZ=0!(XMDUZ="") S XMDUZ=DUZ
 I $L(XMSUBJ)>65 S XMSUBJ=$E(XMSUBJ,1,65)
 I $L(XMSUBJ)<3 S XMSUBJ=XMSUBJ_"..."
 D VSUBJ^XMXPARM(.XMSUBJ)
 I $D(XMERR) D  Q
 . S XMZ=-1
 . D:'$D(ZTQUEUED) SHOW^XMJERR
 . I '$G(XMRETURN) G ABORT
 D CRE8XMZ^XMXSEND(XMSUBJ,.XMZ,1)
 I XMZ<1 D  Q
 . I '$G(XMRETURN) G ABORT
 . K XMERR,^TMP("XMERR",$J)
 S XMZREC=^XMB(3.9,XMZ,0)
 I XMDUZ=.6 S XMDUZ=DUZ,XMSENDR=.6
 E  S XMSENDR=DUZ
 I XMDUZ=.5,XMSENDR'=.5 S $P(XMZREC,U,12)="y" ;Info Only / sent by Postmaster
 S $P(XMZREC,U,2,4)=XMDUZ_U_$$NOW^XLFDT()_U_$S(XMDUZ'=XMSENDR&+XMDUZ:XMSENDR,1:"")
 S ^XMB(3.9,XMZ,0)=XMZREC
 Q
ABORT ;
 S X=^TMP("XMERR",$J,1,"TEXT",1)
 K XMERR,^TMP("XMERR",$J)
 X X
 Q
