XMJMP2 ;ISC-SF/GMB-Print,Backup (cont.) ;05/20/2002  14:21
 ;;8.0;MailMan;;Jun 28, 2002
CHECK(XMDUZ,XMZ,XMZREC,XMNOGO) ;
 D CONFID(XMDUZ,XMZ,XMZREC,.XMNOGO) Q:XMNOGO
 D SCRAMBLE(XMZ,XMZREC,.XMNOGO)
 Q
CONFID(XMDUZ,XMZ,XMZREC,XMNOGO) ; Check to see if msg is confidential
 Q:XMDUZ=DUZ
 Q:$$SURRACC^XMXSEC(XMDUZ,"",XMZ,XMZREC)  ; "access"
 S XMNOGO=1
 I $D(ZTQUEUED) D  Q
 . S XMNOGO(1)=^TMP("XMERR",$J,XMERR,"TEXT",1)
 . K XMERR,^TMP("XMERR",$J)
 U IO(0)  ; In case we are not printing to terminal
 D NOGOID(XMZ,XMZREC)
 W !,^TMP("XMERR",$J,XMERR,"TEXT",1)
 K XMERR,^TMP("XMERR",$J)
 U IO
 Q
SCRAMBLE(XMZ,XMZREC,XMNOGO) ;
 ; If '$D(ZTQUEUED), and scrambled, ask the user for the password.
 Q:'$D(^XMB(3.9,XMZ,"K"))!$D(XMSECURE)
 I XMPAKMAN D  Q
 . N XMERRMSG
 . S XMERRMSG=$$EZBLD^DIALOG(37416.4) ; You may not Print a secure KIDS or PackMan message.
 . S XMNOGO=1
 . I $D(ZTQUEUED) D  Q
 . . S XMNOGO(1)=XMERRMSG
 . U IO(0)  ; In case we are not printing to terminal
 . D NOGOID(XMZ,XMZREC)
 . W !,XMERRMSG
 . U IO
 I $D(ZTQUEUED) D  Q
 . S XMNOGO=1
 . ;This message has been secured with a password.
 . ;When a range of messages is queued to print,
 . ;those messages with passwords cannot be printed because
 . ;there is no opportunity to ask for the password.
 . D BLD^DIALOG(34521,"","","XMNOGO")
 U IO(0)  ; In case we are not printing to terminal
 S:'$$KEYOK^XMJMCODE(XMZ,$P(XMZREC,U,10)) XMNOGO=1
 U IO
 Q
NOGOID(XMZ,XMZREC,XMNOCR) ;
 N XMSUBJ
 S XMSUBJ=$P(XMZREC,U,1)
 S:XMSUBJ["~U~" XMSUBJ=$$DECODEUP^XMXUTIL1(XMSUBJ)
 W !,$$EZBLD^DIALOG(34536,XMSUBJ),"  ",$$EZBLD^DIALOG(34537,XMZ) ; Subj: _XMSUBJ_  _[#_XMZ_]
 W !,$$EZBLD^DIALOG(34538,$$NAME^XMXUTIL($P(XMZREC,U,2),1)) ; From:
 W:'$G(XMNOCR) !
 Q
NOGOMSG(XMDUZ,XMZ,XMZREC,XMNOGO) ;
 N I
 D NOGOID(XMZ,XMZREC)
 S I=""
 F  S I=$O(XMNOGO(I)) Q:I=""  D
 . W !,XMNOGO(I)
 Q
