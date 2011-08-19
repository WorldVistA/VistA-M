XMXUTIL ;ISC-SF/GMB-Message & Mailbox Utilities ;06/19/2002  07:39
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2734.
WAIT ;
 N DIR,Y,DIRUT S DIR(0)="E",DIR("A")=$$EZBLD^DIALOG(37003) D ^DIR ; Press RETURN to continue
 Q
PAGE(XMABORT) ;
 N DIR,Y,DIRUT S DIR(0)="E" D ^DIR I $D(DIRUT) S XMABORT=1
 Q
NEWS(XMDUZ,XMTEST) ;
 ; Given:
 ;   XMDUZ    User's DUZ
 ;   XMTEST   0=this is not a test. (DEFAULT)
 ;            (Field 1.12 LAST NEW MSG NOTIFY DATE/TIME may be updated)
 ;            1=this is just a test.
 ;            (Field 1.12 will not be updated)
 ; Returns:
 ;   -1       If no record of this user
 ;   0        If no new mail
 ; Otherwise, if the user has new mail, returns an ^-delimited string:
 ;   Piece 1:  # New Msgs
 ;   Piece 2:  Does the user have new priority mail? (1=yes;0=no)
 ;   Piece 3:  # New Msgs in IN basket
 ;   Piece 4:  Date/Time (FileMan) that the last msg was received
 ;   Piece 5:  Have there been any new messages since the last time
 ;             this function was called? (1=yes;0=no)
 ; And for the first priority read basket with new messages in it:
 ; (If none has new messages, then first priority read basket)
 ;   Piece 6:  # New Msgs in basket
 ;   Piece 7:  Basket IEN
 ;   Piece 8:  Basket name
 N XMREC,XMNEW,XMRECEIV,XMNOTIFY
 S XMREC=$G(^XMB(3.7,XMDUZ,0))
 Q:XMREC="" -1
 S XMNEW=+$P(XMREC,U,6)
 Q:'XMNEW 0
 S XMRECEIV=$P(XMREC,U,14) ; date/time last msg received
 S XMNOTIFY=$P(XMREC,U,15) ; date/time user last notified
 I XMRECEIV>XMNOTIFY,'$G(XMTEST) S $P(^XMB(3.7,XMDUZ,0),U,15)=XMRECEIV
 Q XMNEW_U_($D(^XMB(3.7,XMDUZ,"N"))>0)_U_+$P(^XMB(3.7,XMDUZ,2,1,0),U,2)_U_XMRECEIV_U_(XMRECEIV>XMNOTIFY)_U_$$NPBSKT^XMJBN(XMDUZ)
TNMSGCT(XMDUZ) ; Total new msg count
 Q +$P(^XMB(3.7,XMDUZ,0),U,6)
BNMSGCT(XMDUZ,XMK) ; Basket new msg count
 Q +$P(^XMB(3.7,XMDUZ,2,XMK,0),U,2)
TPMSGCT(XMDUZ) ; Total new priority msg count
 I '$D(^XMB(3.7,XMDUZ,"N")) Q 0
 N XMK,I,XMZ
 S (XMK,I,XMZ)=0
 F  S XMK=$O(^XMB(3.7,XMDUZ,"N",XMK)) Q:'XMK  D
 . F I=I:1 S XMZ=$O(^XMB(3.7,XMDUZ,"N",XMK,XMZ)) Q:'XMZ
 Q I
BPMSGCT(XMDUZ,XMK) ; Basket new priority msg count
 I '$D(^XMB(3.7,XMDUZ,"N",XMK)) Q 0
 N I,XMZ
 S XMZ=0
 F I=0:1 S XMZ=$O(^XMB(3.7,XMDUZ,"N",XMK,XMZ)) Q:'XMZ
 Q I
TMSGCT(XMDUZ) ; Total msg count
 N I,XMK
 S I=0,XMK=.99
 F  S XMK=$O(^XMB(3.7,XMDUZ,2,XMK)) Q:XMK'>0  S I=I+$$BMSGCT(XMDUZ,XMK)
 Q I
BMSGCT(XMDUZ,XMK) ; Basket msg count
 Q +$P($G(^XMB(3.7,XMDUZ,2,XMK,1,0)),U,4)
KVAPOR(XMDUZ,XMK,XMZ,XMVAPOR,XMIU) ; Set/delete a message's vaporize date in user's basket
 ; XMVAPOR ="@"           delete it
 ;         =FM date/time  set/change it
 N XMFDA,XMIENS
 S XMIENS=XMZ_","_XMK_","_XMDUZ_","
 S XMFDA(3.702,XMIENS,5)=XMVAPOR
 I XMVAPOR="@" D
 . K XMIU("KVAPOR")
 . S XMFDA(3.702,XMIENS,7)="@"
 E  D
 . S XMIU("KVAPOR")=XMVAPOR
 . S XMFDA(3.702,XMIENS,7)=0
 D FILE^DIE("","XMFDA")
 Q
BSKTNAME(XMDUZ,XMK) ; What's the name of this basket for this user?
 Q $P($G(^XMB(3.7,XMDUZ,2,XMK,0)),U,1)
NAME(XMID,XMIT) ; Given a name or DUZ, return the name
 ; XMID user's DUZ or name
 ; XMIT 1=if DUZ, return institution and title, too, if needed
 ;      0=just return the name (default)
 Q:+XMID'=XMID $S(XMID'="":XMID,1:$$EZBLD^DIALOG(34009)) ; * No Name *
 N XMNAME,XMTITLE,XMINST
 I '$D(^VA(200,XMID,0)) Q $$EZBLD^DIALOG(34010,XMID) ; * User #|1| * (not in NEW PERSON file)
 S XMNAME("FILE")=200,XMNAME("IENS")=XMID_",",XMNAME("FIELD")=.01
 S XMNAME=$$NAMEFMT^XLFNAME(.XMNAME,"F","C")
 Q:'$G(XMIT) XMNAME
 I XMV("SHOW TITL") D
 . I XMV("TITL SRC")="S" S XMTITLE=$P($G(^VA(200,XMID,20)),U,3) ; field 20.3, SIGNATURE BLOCK TITLE
 . I $G(XMTITLE)="",$P(^VA(200,XMID,0),U,9) S XMTITLE=$P($G(^DIC(3.1,$P(^(0),U,9),0)),U) ; field 8, TITLE
 . S:$G(XMTITLE)'="" XMNAME=XMNAME_" - "_XMTITLE
 I XMV("SHOW INST"),$D(^XMB(3.7,XMID,6000)) D
 . S XMINST=$P(^XMB(3.7,XMID,6000),U)
 . S:XMINST'="" XMNAME=XMNAME_" ("_XMINST_")"
 Q XMNAME
NETNAME(XMDUZ) ; Given a DUZ or a string, return an internet name @ site name.
 N XMNETNAM
 Q:XMDUZ["@" XMDUZ
 I +XMDUZ=XMDUZ!(XMDUZ="") D
 . S:'XMDUZ XMDUZ=.5
 . ; Use Mail Name.  Lacking that, use real name.
 . S XMNETNAM=$S($L($P($G(^XMB(3.7,XMDUZ,.3)),U)):$P(^(.3),U),1:$$NAME(XMDUZ))
 . I $E(XMNETNAM)=$C(34),$E(XMNETNAM,$L(XMNETNAM))=$C(34) Q  ; Ignore if quoted
 . I XMNETNAM?.E1C.E!($TR(XMNETNAM,$C(34)_"<>()[];:")'=XMNETNAM) S XMNETNAM=$C(34)_XMNETNAM_$C(34) Q  ; Quote if illegal
 . I XMNETNAM[","!(XMNETNAM[" ") S XMNETNAM=$TR(XMNETNAM,", .","._+")  ; Translate
 E  D
 . S XMNETNAM=XMDUZ
 . I $E(XMNETNAM)'=$C(34),$E(XMNETNAM,$L(XMNETNAM))'=$C(34) D
 . . I $E(XMNETNAM)="<",$E(XMNETNAM,$L(XMNETNAM))=">" D  I $E(XMNETNAM)=$C(34),$E(XMNETNAM,$L(XMNETNAM))=$C(34) Q
 . . . S XMNETNAM=$E(XMNETNAM,2,$L(XMNETNAM)-1)
 . . I XMNETNAM?.E1C.E!($TR(XMNETNAM,$C(34)_" ,<>()[];:")'=XMNETNAM) S XMNETNAM=$C(34)_XMNETNAM_$C(34) ; Quote if illegal
 Q XMNETNAM_"@"_^XMB("NETNAME")
LOCK(XMDOOR,XMLOCKED,XMWAIT) ; Lock a global (** NOT USED **)
 L +@XMDOOR:$G(XMWAIT,0) E  S XMLOCKED=0 Q
 S XMLOCKED=1
 Q
MAKENEW(XMDUZ,XMK,XMZ,XMLOCKIT) ; Make a message new
 ; Should lock before calling AND unlock after.
 ; If you set XMLOCKIT=1, I'll do the locking for you.
 Q:$D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ))
 Q:'$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ))
 N XMFDA
 S XMFDA(3.702,XMZ_","_XMK_","_XMDUZ_",",3)="1" ; new
 I $G(XMLOCKIT) L +^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0):1
 D FILE^DIE("","XMFDA")
 I $G(XMLOCKIT) L -^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)
 D INCRNEW(XMDUZ,XMK)
 Q
INCRNEW(XMDUZ,XMK,XMCNT) ; Increment the number of new messages in a basket
 ; For internal use only!
 S:'$D(XMCNT) XMCNT=1
 L +^XMB(3.7,XMDUZ,0):1
 S $P(^(0),U,2)=$P(^XMB(3.7,XMDUZ,2,XMK,0),U,2)+XMCNT ; New msgs in bskt
 S $P(^(0),U,6)=$P(^XMB(3.7,XMDUZ,0),U,6)+XMCNT ; New msgs for user
 S $P(^XMB(3.7,XMDUZ,0),U,14)=$$NOW^XLFDT ; When last msg rec'd
 L -^XMB(3.7,XMDUZ,0)
 Q
NONEW(XMDUZ,XMK,XMZ,XMLOCKIT) ; Make a message not new
 ; Should lock before calling AND unlock after.
 ; If you set XMLOCKIT=1, I'll do the locking for you.
 Q:'$D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ))
 N XMFDA
 S XMFDA(3.702,XMZ_","_XMK_","_XMDUZ_",",3)="@" ; no longer new
 I $G(XMLOCKIT) L +^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0):1
 D FILE^DIE("","XMFDA")
 I $G(XMLOCKIT) L -^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)
 D DECRNEW(XMDUZ,XMK)
 Q
DECRNEW(XMDUZ,XMK,XMCNT) ; Decrement the number of new messages in a basket
 ; For internal use only!
 S:'$D(XMCNT) XMCNT=1
 L +^XMB(3.7,XMDUZ,0):1
 I $P(^XMB(3.7,XMDUZ,2,XMK,0),U,2) S $P(^(0),U,2)=$P(^(0),U,2)-XMCNT ; New msgs in bskt
 I $P(^XMB(3.7,XMDUZ,0),U,6) S $P(^(0),U,6)=$P(^(0),U,6)-XMCNT ; New msgs for user
 L -^XMB(3.7,XMDUZ,0)
 Q
KILLMSG(DA) ; For internal MM use only.  Kill a msg in ^XMB(3.9
 N DIK
 S DIK="^XMB(3.9,"
 L +^XMB(3.9,0):1
 D ^DIK
 L -^XMB(3.9,0)
 Q
LASTACC(XMDUZ,XMK,XMZ,XMRESP,XMIM,XMINSTR,XMIU,XMCONFRM) ; Note first, last accesses, number of responses read
 ; in:
 ; XMDUZ,XMK,XMZ the usual.  If message not in basket, set XMK=0.
 ; XMRESP   last response read this time
 ; XMIM     "SUBJ", "FROM"
 ; XMINSTR  "FLAGS"
 ; XMIU     "IEN", "RESP"
 ; out:
 ; XMCONFRM Confirmation message was sent to message sender (0=no; 1=yes)
 N XMNOW,XMREC,XMFDA,XMIENS
 I XMRESP D
 . N XMRESPS ; User can't read more responses than there are.
 . S XMRESPS=+$P($G(^XMB(3.9,XMZ,3,0)),U,4)
 . I XMRESP>XMRESPS S XMRESP=XMRESPS
 S XMCONFRM=0
 I 'XMIU("IEN") D  Q
 . I XMRESP>XMIU("RESP")!(XMIU("RESP")="") S XMIU("RESP")=XMRESP
 S XMNOW=$$NOW^XLFDT
 S XMREC=^XMB(3.9,XMZ,1,XMIU("IEN"),0)
 I $P(XMREC,U,10)="" D
 . S $P(XMREC,U,10)=XMNOW ; first access 
 . ; If confirmation requested, and user is not sender, send confirmation
 . I XMINSTR("FLAGS")["R",XMDUZ'=XMIM("FROM") D CONFIRM^XMXUTIL1(XMDUZ,XMZ,.XMIM) S XMCONFRM=1
 S $P(XMREC,U,3)=XMNOW  ; last access
 I $S(XMRESP>$P(XMREC,U,2):1,1:$P(XMREC,U,2)="") S XMIU("RESP")=XMRESP,$P(XMREC,U,2)=XMRESP ; last response read
 S ^XMB(3.9,XMZ,1,XMIU("IEN"),0)=XMREC
 I XMDUZ'=DUZ,XMDUZ'=.6 S ^XMB(3.9,XMZ,1,XMIU("IEN"),"S")=XMV("DUZ NAME")
 Q:'XMK
 S XMREC=$G(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0))
 Q:XMREC=""  ; Message is not in the user's basket
 I '$P(XMREC,U,7) D  Q
 . S $P(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0),U,4)=XMNOW ; last access (for MailMan's auto-vaporize)
 ; MailMan has set an automatic delete date.  Since this message was
 ; just accessed, we must delete that date.
 S XMIENS=XMZ_","_XMK_","_XMDUZ_","
 S XMFDA(3.702,XMIENS,4)=XMNOW ; last access (for MailMan's auto-vaporize)
 S XMFDA(3.702,XMIENS,5)="@" ; automatic delete date
 S XMFDA(3.702,XMIENS,7)="@" ; delete date set by MailMan?
 D FILE^DIE("","XMFDA")
 Q
ERRSET(XMID,XMPARM,XMZ) ; For internal MailMan use only.
 S XMERR=$G(XMERR)+1
 S ^TMP("XMERR",$J,XMERR)=XMID
 I $D(XMZ) S ^TMP("XMERR",$J,XMERR,"XMZ")=XMZ
 I $D(XMPARM("PARAM")) M ^TMP("XMERR",$J,XMERR,"PARAM")=XMPARM("PARAM")
 D BLD^DIALOG(XMID,.XMPARM,"","^TMP(""XMERR"",$J,"_XMERR_",""TEXT"")")
 S ^TMP("XMERR",$J,"E",XMID,XMERR)=""
 Q
