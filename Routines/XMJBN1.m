XMJBN1 ;ISC-SF/GMB-Access new mail in mailbox (cont.) ;04/06/2002  08:52
 ;;8.0;MailMan;;Jun 28, 2002
INIT(XMDUZ,XMK,XMKN,XMNEW,XMKMULT,XMABORT) ;
 N I F I="N","N0" D BOGUS(XMDUZ,I)
 D CHECK^XMVVITAE
 I XMDUZ'=DUZ,'$$RPRIV^XMXSEC D  Q
 . S XMABORT=1
 . D SHOW^XMJERR
 S XMK=$O(^XMB(3.7,XMDUZ,"N0",0))
 I XMK>0,XMK<1 D
 . D FIXIT(XMDUZ)
 . S XMK=$O(^XMB(3.7,XMDUZ,"N0",0))
 I XMK="" D  Q
 . S XMABORT=1
 . S $P(^XMB(3.7,XMDUZ,0),U,6)="" ; Just to make sure we're in synch.
 . N XMPARM S XMPARM(2)=XMV("NAME")
 . W !,$$EZBLD^DIALOG($S(XMDUZ=DUZ:34017,1:38156.2),.XMPARM) ; You have no new messages. / |2| has no new messages.
 S XMNEW=$$TNMSGCT^XMXUTIL(XMDUZ)
 I $O(^XMB(3.7,XMDUZ,"N0",XMK)) D
 . S XMKMULT=1
 . W !!,$$EZBLD^DIALOG($S(XMDUZ=DUZ:34019,1:34019.1),XMV("NAME")) ; You have/|1| has new mail in more than one basket
 E  S XMKMULT=0
 S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U)
 Q
BOGUS(XMDUZ,XMTYPE) ; Check for and kill bogus node.
 ; This shouldn't be needed, but something (not MailMan) is setting it.
 I $D(^XMB(3.7,XMDUZ,XMTYPE,0)) K ^XMB(3.7,XMDUZ,XMTYPE,0)
 Q
FIXIT(XMDUZ) ; In case mail in the waste basket is new.
 N XMK,XMZ
 S (XMK,XMZ)=""
 F  S XMK=$O(^XMB(3.7,XMDUZ,"N0",XMK)) Q:XMK'<1!'XMK  D
 . F  S XMZ=$O(^XMB(3.7,XMDUZ,"N0",XMK,XMZ)) Q:'XMZ  D
 . . D:$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)) NONEW^XMXUTIL(XMDUZ,XMK,XMZ,1)
 . . K:$D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ)) ^XMB(3.7,XMDUZ,"N0",XMK,XMZ)
 . . K:$D(^XMB(3.7,XMDUZ,"N",XMK,XMZ)) ^XMB(3.7,XMDUZ,"N",XMK,XMZ)
 Q
NXTBSKT(XMDUZ,XMTYPE,XMKN,XMK,XMKPRI) ;
 D NXTINIT(XMDUZ,XMTYPE)
 I '$D(^TMP("XM",$J,XMTYPE)) D  Q
 . S XMK=0,XMKN="",XMKPRI=0,XMKPRI("XMKN")=""
 . K ^TMP("XM",$J,"APX")
 F  D  Q:XMKN'=""
 . I XMKN="" S XMKPRI=0,XMKPRI("XMKN")="" K ^TMP("XM",$J,"APX")
 . I XMKN=XMKPRI("XMKN") D  Q:XMKN'=""
 . . D NXTPRI(XMDUZ,XMTYPE,.XMKPRI)
 . . S XMKN=XMKPRI("XMKN")
 . E  S XMKPRI=0,XMKPRI("XMKN")=""
 . F  S XMKN=$O(^TMP("XM",$J,XMTYPE,XMKN)) Q:XMKN=""  Q:'$D(^TMP("XM",$J,"APX",XMTYPE,XMKN))
 S XMK=^TMP("XM",$J,XMTYPE,XMKN)
 K ^TMP("XM",$J,XMTYPE)
 Q
NXTINIT(XMDUZ,XMTYPE) ;
 N XMK,XMKN
 K ^TMP("XM",$J,XMTYPE)
 D BOGUS(XMDUZ,XMTYPE)
 S XMK=0
 F  S XMK=$O(^XMB(3.7,XMDUZ,XMTYPE,XMK)) Q:'XMK  D
 . S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U)
 . S ^TMP("XM",$J,XMTYPE,XMKN)=XMK
 Q
NXTPRI(XMDUZ,XMTYPE,XMKPRI) ;
 I XMKPRI=100 S XMKPRI("XMKN")="" Q
 I $D(^XMB(3.7,XMDUZ,2,"AP")) D  I XMKPRI S ^TMP("XM",$J,"APX",XMTYPE,XMKPRI("XMKN"))="" Q
 . N XMK,XMKN
 . K ^TMP("XM",$J,"AP")
 . S:XMKPRI XMKPRI=XMKPRI-.1
 . S XMK=0
 . F  S XMKPRI=$O(^XMB(3.7,XMDUZ,2,"AP",XMKPRI)) Q:'XMKPRI  D  Q:XMKPRI("XMKN")'=""
 . . F  S XMK=$O(^XMB(3.7,XMDUZ,2,"AP",XMKPRI,XMK)) Q:'XMK  D
 . . . S XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U)
 . . . Q:'$D(^TMP("XM",$J,XMTYPE,XMKN))
 . . . S ^TMP("XM",$J,"AP",XMKPRI,XMKN)=""
 . . S XMKPRI("XMKN")=$O(^TMP("XM",$J,"AP",XMKPRI,XMKPRI("XMKN")))
 . K ^TMP("XM",$J,"AP")
 S XMKPRI=100
 N XMIN
 S XMIN=$$EZBLD^DIALOG(37005) ; IN
 I $D(^TMP("XM",$J,XMTYPE,XMIN)) S XMKPRI("XMKN")=XMIN,^TMP("XM",$J,"APX",XMTYPE,XMKPRI("XMKN"))="" Q
 S XMKPRI("XMKN")=""
 Q
 ; It used to be that the list of messages to "new" was kept in ^TMP.
 ; But if the user got forced off for some reason, the global was lost,
 ; and the messages were never "new"ed. So I changed to ^XTMP.  We check
 ; ^XTMP whenever a user logs on (in ^XMVVITAE).
 ; Possible problem: one user is in the middle of reading new messages
 ; and "new"ing ones he wants to have "new" again, and a surrogate logs
 ; on, and triggers an immediate "new"ing of all those messages.
 ; I think it's an acceptable risk.  Maybe not.
 ; This may be a case of 'damned if you do; damned if you don't'.
 ; Perhaps we should also check ^XTMP in the wee hours of the morning
 ; (in ^XMTDT), just in case the user doesn't log on again.
NEWAGAIN(XMDUZ) ; "new" messages which the user wanted to "new".
 S ^XTMP("XM",0)=$$FMADD^XLFDT(DT,7)_U_DT
 N XMZ,XMK
 S XMZ=""
 F  S XMZ=$O(^XTMP("XM","MAKENEW",XMDUZ,XMZ)) Q:XMZ=""  D  K ^XTMP("XM","MAKENEW",XMDUZ,XMZ)
 . S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,0)) Q:'XMK
 . Q:$D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ))
 . D MAKENEW^XMXUTIL(XMDUZ,XMK,XMZ,1)
 Q
