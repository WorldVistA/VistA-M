XMTDL ;ISC-SF/GMB-Deliver local mail to mailbox ;10/23/2002  06:37
 ;;8.0;MailMan;**1,6**;Jun 28, 2002
 ; Replaces ^XMAD0,GO^XMADGO,STATS^XMADJF0,^XMADJF1,^XMADJF1A (ISC-WASH/CAP)
GO ;
 ; Variables provided through TASKMAN: XMHANG,XMGROUP,XMQUEUE
 N XMTSTAMP,XMUID,XMIDLE,X,XMMCNT,XMRCNT,XMACNT
 ; XMMCNT  # of messages/responses processed
 ; XMRCNT  # of potential local recipients to process
 ; XMACNT  # of actual local recipients processed
 S:$D(ZTQUEUED) ZTREQ="@"
 Q:$P($G(^XMB(1,1,0)),U,16)
 I $$NEWERR^%ZTER N $ETRAP,$ESTACK S $ETRAP="D R^XMCTRAP"
 E  S X="R^XMCTRAP",@^%ZOSF("TRAP")
 I $D(^%ZOSF("TRAP")) S X="^%ET",@^("TRAP")
 I $D(^%ZOSF("PRIORITY")) S X=$S(+$G(^XMB(1,1,.13)):+^(.13),1:5) X ^%ZOSF("PRIORITY")
 L +^XMBPOST(XMGROUP,XMQUEUE):0 E  H 0 Q
 S XMIDLE=0
 F  D  Q:$P($G(^XMB(1,1,0)),U,16)!($$TSTAMP^XMXUTIL1-XMIDLE>900)
 . F  S XMTSTAMP=$O(^XMBPOST(XMGROUP,XMQUEUE,"")) Q:XMTSTAMP'>0  D
 . . S XMIDLE=0
 . . F  S XMUID=$O(^XMBPOST(XMGROUP,XMQUEUE,XMTSTAMP,"")) Q:XMUID=""  D
 . . . I XMGROUP="M" D
 . . . . D MDELIVER(XMGROUP,XMQUEUE,XMTSTAMP,XMUID,.XMMCNT,.XMRCNT,.XMACNT)
 . . . E  D
 . . . . D RDELIVER(XMGROUP,XMQUEUE,XMTSTAMP,XMUID,.XMMCNT,.XMRCNT,.XMACNT)
 . . . K ^XMBPOST(XMGROUP,XMQUEUE,XMTSTAMP,XMUID)
 . . . D:'$D(^XMBPOST("STATS","OFF")) STATS^XMTDL1(XMGROUP,XMQUEUE,XMMCNT,XMRCNT,XMACNT)  ; Delivered to # users
 . L +^XMBPOST("QSTATS",XMGROUP,XMQUEUE):0
 . S ^XMBPOST(XMGROUP,XMQUEUE)=""
 . L -^XMBPOST("QSTATS",XMGROUP,XMQUEUE)
 . S:XMIDLE=0 XMIDLE=$$TSTAMP^XMXUTIL1
 . H XMHANG
 L -^XMBPOST(XMGROUP,XMQUEUE)
 Q
RDELIVER(XMGROUP,XMQUEUE,XMTSTAMP,XMZ,XMMCNT,XMRCNT,XMACNT) ; was ^XMADJF1
 ; Note: We know that XMGROUP="R" here
 N XMZR,XMREC,XMFROM,XMFLIST,XMFIRST,XMFDA,I,XMZREC,XMZSUBJ,XMZFROM,XMZDATE,XMRESPS,XMTO,XMZRLIST
 ; XMFIRST sender of the first response processed
 K ^XMBPOST(XMGROUP,XMQUEUE,"B",XMZ,XMTSTAMP) ; Accept no more additions to this batch of replies
 ;Post responses to message response multiple, keeping track of number of deliveries
 S (XMMCNT,XMRCNT,XMACNT)=0
 I '$D(^XMB(3.9,XMZ,0)) D  Q
 . D BADERR(36240,XMZ) ; Message |1| does not exist.  Can't post responses to it.
 . S XMZR=""
 . F  S XMZR=$O(^XMBPOST(XMGROUP,XMQUEUE,XMTSTAMP,XMZ,XMZR)) Q:XMZR=""  S XMRCNT=XMRCNT+^(XMZR),XMMCNT=XMMCNT+1
 S XMZREC=^XMB(3.9,XMZ,0)
 S XMZSUBJ=$P(XMZREC,U),XMZFROM=$P(XMZREC,U,2),XMZDATE=$P(XMZREC,U,3)
 S:XMZFROM="" XMZFROM=.5
 ; If the sender of the original msg is not a recipient, make him one.
 I XMZFROM=+XMZFROM,'$D(^XMB(3.9,XMZ,1,"C",XMZFROM)) D
 . D ADDRECP(XMZ,$P(XMZREC,U,7)["P",XMZFROM)
 . ;D LASTREAD(XMZ,XMZFROM,XMZDATE)
 S XMZR=""
 F  S XMZR=$O(^XMBPOST(XMGROUP,XMQUEUE,XMTSTAMP,XMZ,XMZR)) Q:XMZR=""  S XMREC=^(XMZR) D
 . S XMMCNT=XMMCNT+1
 . S XMRCNT=XMRCNT+$P(XMREC,U,1)
 . I '$D(^XMB(3.9,XMZR)) D  Q
 . . N XMPARM S XMPARM(1)=XMZ,XMPARM(2)=XMZR
 . . D BADERR(36241,.XMPARM) ; Response |2| to message |1| does not exist.  Can't deliver it.
 . ;S XMFDA(3.9001,"+1,"_XMZ_",",.01)=XMZR ; *** Moved to ^XMKP ***
 . ;D UPDATE^DIE("","XMFDA")  ; Add to response multiple in original msg
 . S XMZRLIST(XMZR)="" ; (not used, but helps in debugging)
 . S XMFROM=$P(XMREC,U,2)
 . S:'$D(XMFIRST) XMFIRST=XMFROM
 . S XMFLIST(XMFROM)=$G(XMFLIST(XMFROM))+1  ; Number of replies by this user
 . Q:XMFROM="NR"  ; Network reply *** If we implement fully networked mail, we must get the real sender, and make sure s/he's in the 'addressed to' and 'recipient' multiples.
 . ; If the sender of the reply is not a recipient, make him one.
 . I XMFROM,'$D(^XMB(3.9,XMZ,1,"C",XMFROM)) D ADDRECP(XMZ,$P(XMZREC,U,7)["P",XMFROM)
 Q:'$D(XMFLIST)
 I $O(XMFLIST(""))=XMFIRST,$O(XMFLIST(XMFIRST))="" S XMFROM=XMFIRST  ; There's one sender
 E  S XMFROM=""  ; There's multiple senders
 ; At this point, XMFROM has the sender's DUZ (or 'NR' if remote)
 ; if there was only 1 sender.
 ; If there was more than 1 sender, then XMFROM="", so that ^XMTDL1 will
 ; make the msg new for all recipients.
 ; Now, deliver replies...
 S XMRESPS=$P(^XMB(3.9,XMZ,3,0),U,4)  ; Number of replies to msg
 S XMTO=""
 F  S XMTO=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:XMTO'>0  D
 . S I=$O(^XMB(3.9,XMZ,1,"C",XMTO,0))
 . Q:$G(^XMB(3.9,XMZ,1,I,"D"))  ; User terminated
 . I $D(XMFLIST(XMTO)) D:XMTO=XMFIRST GOTREPLY(XMZ,XMRESPS,I,XMFLIST(XMTO)) Q:XMTO=XMFROM  ; If recipient is the only sender, don't bother delivering to him, because he's already seen it.
 . Q:$P(^XMB(3.9,XMZ,1,I,0),U,2)=XMRESPS  ; Don't deliver if recipient has already seen all responses
 . S XMACNT=XMACNT+1
 . D DELIVER^XMTDL2(XMTO,XMZ,XMZSUBJ,XMZFROM,XMFROM,1)
 Q
ADDRECP(XMZ,XMPRI,XMRECP) ; Add a recipient to the message
 N XMFDA
 S XMFDA(3.91,"+1,"_XMZ_",",.01)=XMRECP
 I XMPRI,+XMRECP=XMRECP,$P($G(^XMB(3.7,XMRECP,0)),U,11) S XMFDA(3.91,"+1,"_XMZ_",",10)=$P(^(0),U,11) ; priority response flag
 D UPDATE^DIE("","XMFDA")
 S XMFDA(3.911,"+1,"_XMZ_",",.01)=$$NAME^XMXUTIL(XMRECP)
 D UPDATE^DIE("","XMFDA")
 Q
LASTREAD(XMZ,XMZFROM,XMZDATE) ; Note that the sender has read the original message
 N XMFDA,XMIEN
 S XMIEN=$O(^XMB(3.9,XMZ,1,"C",XMZFROM,0)) Q:'XMIEN
 S XMFDA(3.91,XMIEN_","_XMZ_",",1)=0        ; Read the original msg
 S XMFDA(3.91,XMIEN_","_XMZ_",",2)=XMZDATE  ; Last Read
 S XMFDA(3.91,XMIEN_","_XMZ_",",11)=XMZDATE ; First Read
 D FILE^DIE("","XMFDA")
 Q
GOTREPLY(XMZ,XMRESPS,XMIEN,XMRNEW) ; Note that recipient has seen his own reply.
 N XMFDA
 ; If last reply seen + # responses made = total responses...
 I $P(^XMB(3.9,XMZ,1,XMIEN,0),U,2)+XMRNEW=XMRESPS D
 . S XMFDA(3.91,XMIEN_","_XMZ_",",1)=XMRESPS
 . D FILE^DIE("","XMFDA")
 Q
MDELIVER(XMGROUP,XMQUEUE,XMTSTAMP,XMUID,XMMCNT,XMRCNT,XMACNT) ; was ^XMADJF1
 N XMZSUBJ,XMZFROM,XMZDATE,XMZPDATE,XMZBSKT,XMREC,XMZ,XMK,XMDEL,XMBCAST
 ; Note: We know that XMGROUP="M" here
 ; If $L(XMUID,U)>1, it's a forwarded message, else it's a new message.
 S XMMCNT=1
 S XMREC=^XMBPOST(XMGROUP,XMQUEUE,XMTSTAMP,XMUID)
 S XMRCNT=+$P(XMREC,U,1)
 S XMACNT=0
 S XMZ=+XMUID
 I '$D(^XMB(3.9,XMZ,0)) D  Q
 . I $L(XMUID,U)>1 K ^XMBPOST("FWD",XMUID_U_XMTSTAMP)
 . D BADERR(36242,XMZ) ; Message |1| does not exist.  Can't deliver it.
 S XMZSUBJ=$P(^XMB(3.9,XMZ,0),U),XMZFROM=$P(^(0),U,2),XMZDATE=$P(^(0),U,3),XMZPDATE=$P(^(0),U,6)
 S:XMZFROM="" XMZFROM=.5
 I XMZPDATE,XMZPDATE'>DT D  Q  ; If purge date has passed, don't deliver
 . I $L(XMUID,U)>1 K ^XMBPOST("FWD",XMUID_U_XMTSTAMP)
 I $P(XMREC,U,2)'="" D  ; basket selection
 . I $L(XMUID,U)=1 S XMK(XMZFROM)=$P(XMREC,U,2) Q  ; sending person
 . I $P(XMUID,U,2) S XMK($P(XMUID,U,2))=$P(XMREC,U,2) ; forwarding person
 I $P(XMREC,U,3)'="" S XMK(.6)=$P(XMREC,U,3)
 I $P(XMREC,U,4) S XMDEL(.6)=$P(XMREC,U,4)
 S XMBCAST=($P(XMREC,U,5)'="")
 S XMZBSKT=$P($G(^XMB(3.9,XMZ,.5)),U,1)
 I $L(XMUID,U)=1 D NEW(XMGROUP,XMQUEUE,XMTSTAMP,XMZ,XMBCAST,.XMK,.XMDEL,XMZSUBJ,XMZFROM,XMZDATE,XMZPDATE,XMZBSKT,.XMACNT) Q
 D FORWARD(XMGROUP,XMQUEUE,XMTSTAMP,XMUID,XMZ,XMBCAST,.XMK,.XMDEL,XMZSUBJ,XMZFROM,XMZPDATE,XMZBSKT,.XMACNT)
 Q
NEW(XMGROUP,XMQUEUE,XMTSTAMP,XMZ,XMBCAST,XMK,XMDEL,XMZSUBJ,XMZFROM,XMZDATE,XMZPDATE,XMZBSKT,XMACNT) ;
 D:XMZFROM=+XMZFROM LASTREAD(XMZ,XMZFROM,XMZDATE)
 I XMBCAST D BRODCAST^XMTDL1(XMZ,XMZSUBJ,XMZFROM,XMZFROM,.XMK,.XMDEL,XMZPDATE,XMZBSKT,.XMACNT)
 N XMTO
 S XMTO=0  ; Q: on next line ensures only local user delivery
 F  S XMTO=$O(^XMB(3.9,XMZ,1,"C",XMTO)) Q:XMTO'>0  D
 . I XMBCAST,$D(^XMB(3.7,"M",XMZ,XMTO)) Q
 . S XMACNT=XMACNT+1
 . D DELIVER^XMTDL2(XMTO,XMZ,XMZSUBJ,XMZFROM,XMZFROM,0,$G(XMK(XMTO)),$G(XMDEL(XMTO),XMZPDATE),XMZBSKT)
 Q
FORWARD(XMGROUP,XMQUEUE,XMTSTAMP,XMUID,XMZ,XMBCAST,XMK,XMDEL,XMZSUBJ,XMZFROM,XMZPDATE,XMZBSKT,XMACNT) ;
 N I,J,XMFROM,XMTO,XMTOLIST
 S XMFROM=$P(XMUID,U,2)
 S XMUID=XMUID_U_XMTSTAMP
 I XMBCAST D BRODCAST^XMTDL1(XMZ,XMZSUBJ,XMZFROM,XMFROM,.XMK,.XMDEL,XMZPDATE,XMZBSKT,.XMACNT)  Q:'$D(^XMBPOST("FWD",XMUID))
 S I=0
 F  S I=$O(^XMBPOST("FWD",XMUID,I)) Q:'I  S XMTOLIST=^(I) D
 . F J=1:1:$L(XMTOLIST,U) D
 . . S XMTO=$P(XMTOLIST,U,J)
 . . Q:$O(^XMB(3.7,"M",XMZ,XMTO,""))  ; User already has msg
 . . Q:'$D(^XMB(3.9,XMZ,1,"C",XMTO))  ; User is not on recipient list (Should never happen
 . . S XMACNT=XMACNT+1
 . . D DELIVER^XMTDL2(XMTO,XMZ,XMZSUBJ,XMZFROM,XMFROM,0,$G(XMK(XMTO)),$G(XMDEL(XMTO),XMZPDATE),XMZBSKT)
 K ^XMBPOST("FWD",XMUID)
 Q
BADERR(XMDIALOG,XMPARM) ;
 N XMTEXT,XMINSTR
 D BLD^DIALOG(XMDIALOG,.XMPARM,"","XMTEXT")
 S XMINSTR("FROM")="MailMan"
 D TASKBULL^XMXBULL(DUZ,"XM_TRANSMISSION_ERROR","","XMTEXT",.5,.XMINSTR)
 Q
