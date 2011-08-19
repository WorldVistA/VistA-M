XMXMSGS2 ;ISC-SF/GMB-Message APIs (cont.) ;03/25/2003  15:04
 ;;8.0;MailMan;**16**;Jun 28, 2002
DEL(XMDUZ,XMK,XMZ,XMCNT) ; For many messages, pass in XMCNT; for 1, don't
XDEL ;
 I '$G(XMK) S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,"")) Q:'XMK
 I XMDUZ'=DUZ,'$$DELETE^XMXSEC(XMDUZ,XMK,XMZ) Q
 S:$D(XMCNT) XMCNT=XMCNT+1
 D ZAPIT(XMDUZ,XMK,XMZ,.XMCNT)
 D WASTEIT(XMDUZ,XMK,XMZ)
 Q
FLTR(XMDUZ,XMK,XMKN,XMZ,XMCNT,XMKTO,XMKNTO) ; Filter message
XFLTR ;
 ; XMK    (in) the basket # the message is currently in.  (May be 0 if
 ;             the message isn't currently in a basket.)
 ; XMKN   (in) the name of basket XMK
 ; XMKTO  (out) the basket # this routine decides to put the message in
 ; XMKNTO (out) the name of basket XMKTO
 ; This routine decides which basket the message belongs in.
 ; If this is the same basket it is currently in, it sets XMKTO and
 ; XMKNTO to the current basket.
 ; Otherwise, it moves the message (from the current basket) to the
 ; decided-upon basket and sets XMKTO and XMKNTO to that basket.
 ; If the message is in the WASTE basket, and no filters are defined,
 ; it will be moved to the IN basket.
 I '$G(XMK) D
 . S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 . S:XMK XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)
 I XMDUZ=.6,XMK'=.5,'$$MOVE^XMXSEC(XMDUZ,XMZ) Q
 S:$D(XMCNT) XMCNT=XMCNT+1
 I $D(^XMB(3.7,XMDUZ,15,"AF")) D
 . N XMZREC
 . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . D FILTER^XMTDF(XMDUZ,XMZ,$P(XMZREC,U,1),$P(XMZREC,U,2),.XMKTO,.XMKNTO)
 . I XMKTO=1,XMK>1 S XMKTO=XMK,XMKNTO=XMKN
 E  I XMK>1 S XMKTO=XMK,XMKNTO=XMKN
 E  S XMKTO=1,XMKNTO=$$EZBLD^DIALOG(37005) ; "IN"
 Q:XMK=XMKTO
 I XMK D MOVEIT(XMDUZ,XMK,XMZ,XMKTO,.XMCNT) Q
 D PUTMSG(XMDUZ,XMKTO,XMKNTO,XMZ)
 Q
LATER(XMDUZ,XMZ,XMWHEN,XMCNT) ;
XLATER ;
 S:$D(XMCNT) XMCNT=XMCNT+1
 D LTRADD^XMJMD(XMDUZ,XMZ,XMWHEN)
 Q
MOVE(XMDUZ,XMK,XMZ,XMKTO,XMCNT) ;
XMOVE ;
 I XMDUZ=.6,'$$MOVE^XMXSEC(XMDUZ,XMZ) Q
 ; If 2 users are reading the same msg at the same time, one may get an
 ; abort if tries to save msg to another bskt, if the msg has already
 ; been moved by the other user.  So this next line makes sure no abort.
 I '$D(^XMB(3.7,"M",XMZ,XMDUZ,+$G(XMK))) S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 Q:XMK=XMKTO
 I XMKTO=.5,'$$DELETE^XMXSEC(XMDUZ,"",XMZ) Q  ; Can't save confidential to WASTE bskt.
 D MOVEIT(XMDUZ,XMK,XMZ,XMKTO,.XMCNT)
 S:$D(XMCNT) XMCNT=XMCNT+1
 Q
MOVEIT(XMDUZ,XMK,XMZ,XMKTO,XMCNT) ;
 I XMK D
 . D COPYIT(XMDUZ,XMK,XMZ,XMKTO,.XMCNT)
 . D ZAPIT(XMDUZ,XMK,XMZ,.XMCNT)
 ; The message is not in the user's mailbox
 E  D PUTMSG(XMDUZ,XMKTO,$P(^XMB(3.7,XMDUZ,2,XMKTO,0),U),XMZ)
 Q
NTOGL(XMDUZ,XMK,XMKN,XMZ,XMCNT,XMKTO,XMKNTO) ;
XNTOGL ;
 ; If XMK>.5, then it's simple.  Just toggle the 'new' flag.
 ; If XMK<1, we know the message is not new, and we need to make it new.
 ; Filter it, but if it filters to the WASTE basket put it in the IN.
 ; Then make it new.
 I '$G(XMK) D
 . S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 . S:XMK XMKN=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,1)
 I XMK<1 D
 . I $D(^XMB(3.7,XMDUZ,15,"AF")) D
 . . N XMZREC
 . . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . . D FILTER^XMTDF(XMDUZ,XMZ,$P(XMZREC,U,1),$P(XMZREC,U,2),.XMKTO,.XMKNTO)
 . . I XMKTO=1,XMK>1 S XMKTO=XMK,XMKNTO=XMKN Q
 . . I XMKTO<1 S XMKTO=1,XMKNTO=$$EZBLD^DIALOG(37005) ; "IN"
 . E  I XMK>1 S XMKTO=XMK,XMKNTO=XMKN
 . E  S XMKTO=1,XMKNTO=$$EZBLD^DIALOG(37005) ; "IN"
 . Q:XMK=XMKTO
 . I XMK D MOVEIT(XMDUZ,XMK,XMZ,XMKTO,.XMCNT) Q
 . D PUTMSG(XMDUZ,XMKTO,XMKNTO,XMZ)
 E  S XMKTO=XMK,XMKNTO=XMKN
 I $D(XMCNT) D  Q
 . N XMFDA
 . I $$NEW^XMXUTIL2(XMDUZ,XMKTO,XMZ) D
 . . S XMFDA(3.702,XMZ_","_XMKTO_","_XMDUZ_",",3)="@" ; no longer new
 . . S XMCNT(XMKTO,"DECR")=$G(XMCNT(XMKTO,"DECR"))+1
 . E  D
 . . S XMFDA(3.702,XMZ_","_XMKTO_","_XMDUZ_",",3)="1" ; new
 . . S XMCNT(XMKTO,"INCR")=$G(XMCNT(XMKTO,"INCR"))+1
 . D FILE^DIE("","XMFDA")
 . S XMCNT=XMCNT+1
 I $$NEW^XMXUTIL2(XMDUZ,XMKTO,XMZ) D NONEW^XMXUTIL(XMDUZ,XMKTO,XMZ) Q
 D MAKENEW^XMXUTIL(XMDUZ,XMKTO,XMZ)
 Q
TERM(XMDUZ,XMK,XMZ,XMCNT) ;
XTERM ;
 N XMIEN
 S:'$G(XMK) XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 I XMDUZ'=DUZ,'$$DELETE^XMXSEC(XMDUZ,XMK,XMZ) Q
 I XMK D
 . D ZAPIT(XMDUZ,XMK,XMZ,.XMCNT)
 . D WASTEIT(XMDUZ,XMK,XMZ)
 S XMIEN=+$O(^XMB(3.9,XMZ,1,"C",XMDUZ,0))
 S:XMIEN ^XMB(3.9,XMZ,1,XMIEN,"D")=DT
 S:$D(XMCNT) XMCNT=XMCNT+1
 Q
VAPOR(XMDUZ,XMK,XMZ,XMWHEN,XMCNT) ;
XVAPOR ;
 I '$G(XMK) S XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,"")) Q:'XMK
 I XMDUZ'=DUZ,'$$DELETE^XMXSEC(XMDUZ,XMK,XMZ) Q
 S:$D(XMCNT) XMCNT=XMCNT+1
 D KVAPOR^XMXUTIL(XMDUZ,XMK,XMZ,XMWHEN)
 Q
PUTMSG(XMDUZ,XMK,XMKN,XMZ) ; For internal MM use only.
 ; Replaces SETSB^XMA1C, SET^XMS1, & part of MAIL^XMR0B
 ; Put a msg in the Postmaster's (or anyone else's) basket.
 ; The msg is NOT made new.
 ; The basket has a specific name and number.
 ; If the basket doesn't exist, create it.
 ; XMK      Basket number
 ; XMKN     Basket name
 ; XMZ      Msg number
 N XMFDA,XMIEN,XMTRIES
 Q:$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0))
 I XMDUZ'=.5 D RESURECT(XMDUZ,XMZ)
 I $D(^XMB(3.7,XMDUZ,2,XMK)) D
 . S XMFDA(3.702,"+1,"_XMK_","_XMDUZ_",",.01)=XMZ
 . S XMIEN(1)=XMZ
 E  D
 . S XMFDA(3.701,"+1,"_XMDUZ_",",.01)=XMKN
 . S XMFDA(3.702,"+2,+1,"_XMDUZ_",",.01)=XMZ
 . S XMIEN(1)=XMK
 . S XMIEN(2)=XMZ
PTRY D UPDATE^DIE("S","XMFDA","XMIEN") Q:'$D(DIERR)
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G PTRY ; Try again if can't lock
 Q
COPYIT(XMDUZ,XMK,XMZ,XMKTO,XMCNT) ;
 Q:$D(^XMB(3.7,XMDUZ,2,XMKTO,1,XMZ))  ; Message already exists at destination
 N XMFDA,XMKREC,XMIENS,XMIEN,XMTRIES
 S XMKREC=^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)
 S XMIENS="+1,"_XMKTO_","_XMDUZ_","
 S XMIEN(1)=XMZ
 S XMFDA(3.702,XMIENS,.01)=XMZ
 I XMKTO'=.5 D
 . I $P(XMKREC,U,3) S XMFDA(3.702,XMIENS,3)=$P(XMKREC,U,3) ; new flag
 . I '$P(XMKREC,U,7),$P(XMKREC,U,5) S XMFDA(3.702,XMIENS,5)=$P(XMKREC,U,5) ; vapor date
 S:$P(XMKREC,U,4) XMFDA(3.702,XMIENS,4)=$P(XMKREC,U,4) ; date last accessed
 S:$P(XMKREC,U,6) XMFDA(3.702,XMIENS,6)=$P(XMKREC,U,6) ; ntwk msg flag
CTRY D UPDATE^DIE("S","XMFDA","XMIEN")
 I '$D(DIERR) D  Q
 . I XMK=.5 D RESURECT(XMDUZ,XMZ) Q
 . Q:'$G(XMFDA(3.702,XMIENS,3))  ; quit if not new
 . I $D(XMCNT) S XMCNT(XMKTO,"INCR")=$G(XMCNT(XMKTO,"INCR"))+1 Q
 . D INCRNEW^XMXUTIL(XMDUZ,XMKTO) ; Increment new counts
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G CTRY ; Try again if can't lock
 Q
RESURECT(XMDUZ,XMZ) ; If msg was terminated, "unterminate" it.
 N XMIEN
 S XMIEN=+$O(^XMB(3.9,XMZ,1,"C",XMDUZ,0))
 K:$D(^XMB(3.9,XMZ,1,XMIEN,"D")) ^XMB(3.9,XMZ,1,XMIEN,"D")
 Q
ZAPIT(XMDUZ,XMK,XMZ,XMCNT) ;
 I $D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ)) D
 . I $D(XMCNT) S XMCNT(XMK,"DECR")=$G(XMCNT(XMK,"DECR"))+1 Q
 . D DECRNEW^XMXUTIL(XMDUZ,XMK)
 N DA,DIK
 S DA(2)=XMDUZ,DA(1)=XMK,DA=XMZ
 S DIK="^XMB(3.7,"_XMDUZ_",2,"_XMK_",1,"
 D ^DIK
 Q
WASTEIT(XMDUZ,XMK,XMZ) ;
 Q:XMK=.5
 Q:$D(^XMB(3.7,XMDUZ,2,.5,1,XMZ))  ; Already in wastebasket
 N XMFDA,XMIENS,XMIEN,XMTRIES
 S XMK=.5
 D:'$D(^XMB(3.7,XMDUZ,2,.5,0)) MAKEBSKT^XMXBSKT(XMDUZ,.5,$$EZBLD^DIALOG(37004)) ; WASTE
 S XMIENS="+1,"_XMK_","_XMDUZ_","
 S XMIEN(1)=XMZ
 S XMFDA(3.702,XMIENS,.01)=XMZ
 S XMFDA(3.702,XMIENS,4)=$$NOW^XLFDT  ; date/time last accessed
WTRY D UPDATE^DIE("S","XMFDA","XMIEN") Q:'$D(DIERR)
 S XMTRIES=$G(XMTRIES)+1
 I $D(^TMP("DIERR",$J,"E",110)) H 1 G WTRY ; Try again if can't lock
 Q
