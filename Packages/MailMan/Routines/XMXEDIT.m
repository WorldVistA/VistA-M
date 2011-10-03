XMXEDIT ;ISC-SF/GMB-Edit msg that user has sent to self ;05/19/2000  13:41
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2730.
 ; These entry points edit a message.  They do not perform any checks to
 ; see whether it is appropriate to do so.  That is the responsibility
 ; of the calling routine.
 ; For these entry points, it is expected that:
 ; OPTMSG^XMXSEC2  has been called and has given its permission to
 ;                 edit the message or to toggle information only.
 ; OPTEDIT^XMXSEC2 has been called and has given its permission to
 ;                 edit the particular thing we are editing here.
 ; INMSG2^XMXUTIL2 has been called to set XMINSTR.  These routines expect
 ;                 that XMINSTR has been correctly set.  They will change
 ;                 XMINSTR according to the edit.
CLOSED(XMZ,XMINSTR,XMMSG) ; Toggle Closed msg
 I $D(^TMP("XMY",$J,.6)) D ERRSET^XMXUTIL(37320.6) Q  ; Messages addressed to SHARED,MAIL may not be closed
 D FLAGTOGL(XMZ,1.95,.XMINSTR,"X",37319.9,37320.9,.XMMSG)
 Q
CONFID(XMZ,XMINSTR,XMMSG) ; Toggle Confidential msg
 I $D(^TMP("XMY",$J,.6)) D ERRSET^XMXUTIL(37301.6) Q  ; Messages addressed to SHARED,MAIL may not be confidential
 D FLAGTOGL(XMZ,1.96,.XMINSTR,"C",37301.9,37302.9,.XMMSG)
 Q
CONFIRM(XMZ,XMINSTR,XMMSG) ; Toggle Confirm receipt of msg
 D FLAGTOGL(XMZ,1.3,.XMINSTR,"R",37313.9,37314.9,.XMMSG)
 Q
DELIVER(XMZ,XMDBSKT,XMINSTR,XMMSG) ; Delivery basket
 I XMDBSKT="@" D  Q
 . K XMINSTR("RCPT BSKT")
 . S XMFDA(3.9,XMZ_",",21)="@"
 . D FILE^DIE("","XMFDA")
 . S XMMSG=$$EZBLD^DIALOG(37304.9) ; Delivery basket removed
 S XMINSTR("RCPT BSKT")=XMDBSKT
 S XMFDA(3.9,XMZ_",",21)=XMINSTR("RCPT BSKT")
 D FILE^DIE("","XMFDA")
 S XMMSG=$$EZBLD^DIALOG(37303.9) ; Delivery basket set
 Q
INFO(XMZ,XMINSTR,XMMSG) ; Toggle Information only msg
 D FLAGTOGL(XMZ,1.97,.XMINSTR,"I",37307.9,37308.9,.XMMSG)
 Q
NETSIG(XMDUZ,XMZ,XMINSTR,XMMSG) ; Add Network Signature
 N I,XMNSIG
 S XMNSIG(.1)=""
 S XMNSIG(.2)=""
 S XMNSIG(.3)=$$REPEAT^XLFSTR("-",79)
 S XMNSIG=$G(^XMB(3.7,XMDUZ,"NS1"))
 F I=1:1:3 S:$P(XMNSIG,U,I)'="" XMNSIG(I)=$P(XMNSIG,U,I)
 N XMABORT
 I $D(^XMB(3.9,XMZ,"K")) D  Q:XMABORT
 . ; If XMSECURE does not exist, then XMINSTR("SCR KEY") must hold the
 . ; correct scramble key.
 . I '$D(XMSECURE) N XMSECURE
 . I '$D(XMSECURE),'$$GOODKEY^XMJMCODE(XMZ,XMINSTR("SCR KEY")) D  Q
 . . D ERRSET^XMXUTIL(34623) ; The key is not correct.
 . . S XMABORT=1
 . S XMABORT=0
 . S I=0
 . F  S I=$O(XMNSIG(I)) Q:'I  S XMNSIG(I)=$$ENCSTR^XMJMCODE(XMNSIG(I))
 D MOVEBODY^XMXSEND(XMZ,"XMNSIG","A") ; Add the network signature
 S XMMSG=$$EZBLD^DIALOG(37309.9) ; Network Signature added
 Q
PRIORITY(XMZ,XMINSTR,XMMSG) ; Toggle Priority msg
 D FLAGTOGL(XMZ,1.7,.XMINSTR,"P",37311.9,37312.9,.XMMSG)
 Q
SCRAMBLE(XMZ,XMINSTR,XMMSG) ; Scramble or Unscramble the message text
 N XMFDA,XMIENS
 S XMIENS=XMZ_","
 I $D(^XMB(3.9,XMZ,"K")) D  Q
 . ; Unscramble the text.
 . ; If XMSECURE does not exist, then XMINSTR("SCR KEY") must hold the
 . ; correct scramble key.
 . I '$D(XMSECURE),'$$GOODKEY^XMJMCODE(XMZ,XMINSTR("SCR KEY")) D ERRSET^XMXUTIL(34623) Q  ; The key is not correct.
 . S XMFDA(3.9,XMIENS,1.8)="@"
 . S XMFDA(3.9,XMIENS,1.85)="@"
 . D FILE^DIE("","XMFDA")
 . D DECMSG^XMJMCODE(XMZ)
 . K XMSECURE,XMINSTR("SCR KEY"),XMINSTR("SCR HINT"),^XMB(3.9,XMZ,"K")
 . S XMMSG=$$EZBLD^DIALOG(37316.9) ; Message text UnScrambled
 ; Check the key and hint
 D XMKEY^XMXPARM1($G(XMINSTR("SCR KEY")))
 D:$G(XMINSTR("SCR HINT"))'="" XMHINT^XMXPARM1(XMINSTR("SCR HINT"))
 Q:$D(XMERR)
 ; Scramble the text.
 N XMKEY
 K XMSECURE
 S XMFDA(3.9,XMIENS,1.8)=$S($G(XMINSTR("SCR HINT"))="":" ",1:XMINSTR("SCR HINT"))
 D LOADCODE^XMJMCODE ; XMSECURE is created here
 S XMKEY=XMINSTR("SCR KEY")
 D ADJUST^XMJMCODE(.XMKEY) ; XMSECURE is adjusted here
 S XMFDA(3.9,XMIENS,1.85)="1"_$$ENCSTR^XMJMCODE(XMKEY)
 D ENCMSG^XMJMCODE(XMZ)
 D FILE^DIE("","XMFDA")
 S XMMSG=$$EZBLD^DIALOG(37315.9) ; Message text Scrambled
 Q
SUBJ(XMZ,XMSUBJ,XMIM) ; Replace Subject
 S XMSUBJ=$$XMSUBJ^XMXPARM("XMSUBJ",$G(XMSUBJ)) Q:$D(XMERR)
 S (XMIM("SUBJ"),XMFDA(3.9,XMZ_",",.01))=$$ENCODEUP^XMXUTIL1(XMSUBJ)
 D FILE^DIE("","XMFDA")
 Q
TEXT(XMZ,XMBODY) ; Replace Text
 D WP^DIE(3.9,XMZ_",",3,"",XMBODY)
 Q
VAPOR(XMZ,XMVAPOR,XMINSTR,XMMSG) ; Vaporize date
 I XMVAPOR="@" D  Q
 . K XMINSTR("VAPOR")
 . S XMFDA(3.9,XMZ_",",1.6)="@"
 . D FILE^DIE("","XMFDA")
 . S XMMSG=$$EZBLD^DIALOG(37318.9) ; Vaporize Date removed
 S XMINSTR("VAPOR")=XMVAPOR
 S XMFDA(3.9,XMZ_",",1.6)=XMINSTR("VAPOR")
 D FILE^DIE("","XMFDA")
 S XMMSG=$$EZBLD^DIALOG(37317.9) ; Vaporize Date set
 Q
FLAGTOGL(XMZ,XMFIELD,XMINSTR,XMFLAG,XMSET,XMREMOVE,XMMSG) ; Flag Toggle (For internal MM use only!)
 N XMFDA
 I $G(XMINSTR("FLAGS"))[XMFLAG D
 . S XMINSTR("FLAGS")=$TR(XMINSTR("FLAGS"),XMFLAG)
 . S XMMSG=$$EZBLD^DIALOG(XMREMOVE)
 . I XMFLAG="P" D
 . . S XMFDA(3.9,XMZ_",",XMFIELD)=$S($G(XMINSTR("TYPE"))="":"@",1:XMINSTR("TYPE"))
 . E  S XMFDA(3.9,XMZ_",",XMFIELD)="@"
 E  D
 . S XMINSTR("FLAGS")=$G(XMINSTR("FLAGS"))_XMFLAG
 . S XMMSG=$$EZBLD^DIALOG(XMSET)
 . I XMFLAG="P" S XMFDA(3.9,XMZ_",",XMFIELD)=$G(XMINSTR("TYPE"))_"P"
 . E  S XMFDA(3.9,XMZ_",",XMFIELD)="y"
 D FILE^DIE("","XMFDA")
 Q
