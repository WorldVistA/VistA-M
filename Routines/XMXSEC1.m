XMXSEC1 ;ISC-SF/GMB-Message security and restrictions (cont.) ;05/17/2002  13:26
 ;;8.0;MailMan;;Jun 28, 2002
 ; All entry points covered by DBIA 2732.
GETRESTR(XMDUZ,XMZ,XMZREC,XMINSTR,XMRESTR) ;
 ; If a message is closed, it may not be forwarded to SHARED,MAIL, even by the sender
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 I "^Y^y^"[(U_$P(XMZREC,U,9)_U) D
 . S:$G(XMRESTR("FLAGS"))'["X" XMRESTR("FLAGS")=$G(XMRESTR("FLAGS"))_"X"
 E  I $G(XMRESTR("FLAGS"))["X" S XMRESTR("FLAGS")=$TR(XMRESTR("FLAGS"),"X")
 ; If a message is confidential, it may not be forwarded to SHARED,MAIL
 I "^Y^y^"[(U_$P(XMZREC,U,11)_U) D
 . S:$G(XMRESTR("FLAGS"))'["C" XMRESTR("FLAGS")=$G(XMRESTR("FLAGS"))_"C"
 E  I $G(XMRESTR("FLAGS"))["C" S XMRESTR("FLAGS")=$TR(XMRESTR("FLAGS"),"C")
 Q:$G(XMINSTR("ADDR FLAGS"))["R"
 ; If a message is priority, it may not be forwarded to groups unless
 ; the site has chosen to allow it, or if
 ; the user is the originator or possesses the proper security key,
 I $P(XMZREC,U,7)["P",'$P($G(^XMB(1,1,2)),U,1),'$$ORIGIN8R^XMXSEC(XMDUZ,XMZREC),'$D(^XUSEC("XM GROUP PRIORITY",XMDUZ)) S XMRESTR("NOFPG")=""
 E  K:$D(XMRESTR("NOFPG")) XMRESTR("NOFPG")
 ; If a message has responses, it may not be broadcast.  Users w/auto-
 ; forward addresses would not see the responses.
 I $O(^XMB(3.9,XMZ,3,0)) S XMRESTR("NOBCAST")=""
 ; If a message is more lines than the limit,
 ; then it may not be sent/forwarded to a remote site.
 D CHKLINES(XMDUZ,XMZ,.XMRESTR)
 Q
CHKLINES(XMDUZ,XMZ,XMRESTR) ; Replaces NO^XMA21A
 N XMLIMIT
 Q:$D(^XUSEC("XMMGR",XMDUZ))
 S XMLIMIT=$P($G(^XMB(1,1,"NETWORK-LIMIT")),U)
 I XMLIMIT,$P($G(^XMB(3.9,XMZ,2,0)),U,4)>XMLIMIT S XMRESTR("NONET")=XMLIMIT Q
 K:$D(XMRESTR("NONET")) XMRESTR("NONET")
 Q
CHKMSG(XMDUZ,XMK,XMKZ,XMZ,XMZREC) ; Is the message where the calling routine says it is,
 ; and is the user authorized to access it?
 I $G(XMK) D  Q
 . S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ,""))
 . I 'XMZ D  Q
 . . N XMPARM
 . . S XMPARM(1)=XMKZ,XMPARM(2)=XMK
 . . D ERRSET^XMXUTIL(34351,.XMPARM) ; Message _XMKZ_ in basket _XMK_ does not exist.
 . S XMZREC=$G(^XMB(3.9,XMZ,0))
 . I XMZREC'="" D:XMDUZ'=DUZ  Q
 . . N X
 . . S X=$$SURRACC^XMXSEC(XMDUZ,"",XMZ,XMZREC)
 . N XMPARM
 . S XMPARM(1)=XMZ,XMPARM(2)=XMKZ,XMPARM(3)=XMK
 . D ERRSET^XMXUTIL(34352,.XMPARM) ; Message _XMZ_ (message _XMKZ_ in basket _XMK_) does not exist.
 S XMZ=XMKZ
 S XMZREC=$G(^XMB(3.9,XMZ,0))
 I XMZREC="" D ERRSET^XMXUTIL(34354,XMZ) Q  ; Message _XMZ_ does not exist.
 Q:'$$ACCESS^XMXSEC(XMDUZ,XMZ,XMZREC)
 S XMK=+$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 Q:'XMK
 S XMKZ=$P($G(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)),U,2)
 I 'XMKZ D ADDITM^XMUT4A(XMDUZ,XMK,XMZ,.XMKZ)
 Q
PAKMAN(XMZ,XMZREC) ; Returns 1 if this is a packman msg; 0 if not.
 ; Unfortunately, there isn't always an "X" in piece 7 of the zero node,
 ; so we must go check out the first line of text.
 N XMTYPE
 I $G(XMZREC)="" S XMZREC=$G(^XMB(3.9,XMZ,0))
 S XMTYPE=$P(XMZREC,U,7)
 I "P"[XMTYPE D  Q XMTYPE  ; "P" means priority, and it exists along with
 . ; message type in piece 7 in all MailMan versions thru 7.*
 . N XMREC,XMI
 . S XMTYPE=0
 . S XMI=$O(^XMB(3.9,XMZ,2,.999999)) I 'XMI Q
 . S XMREC=^XMB(3.9,XMZ,2,XMI,0)
 . Q:$E(XMREC,1)'="$"
 . I XMREC?1"$TXT Created by".E1" at ".E1" on ".E S XMTYPE=1 Q  ; Unsecured PackMan
 . I XMREC?1"$TXT PACKMAN BACKUP".E S XMTYPE=1 Q  ; PackMan Backup
 . I XMREC?1"$TXT ^Created by".E1" at ".E1" on ".E S XMTYPE=1 Q  ; Secured PackMan
 Q:XMTYPE="K"!(XMTYPE="X") 1  ; PackMan message (KIDS or regular)
 Q 0
OPTGRP(XMDUZ,XMK,XMOPT,XMOX,XMQDNUM) ; What may the user do at the basket/message group level?
 I XMK D
 . I XMDUZ=.5,XMK>999 D OPTPOST(.XMOPT,.XMOX) Q
 . D OPTUSER1(XMDUZ,.XMOPT,.XMOX)
 . D OPTUSER2(XMK,.XMOPT,.XMOX)
 E  D
 . I XMK="!" D OPTSS(XMDUZ,.XMOPT,.XMOX) Q
 . D OPTUSER1(XMDUZ,.XMOPT,.XMOX)
 Q
SET(XMCD,XMDN,XMOPT,XMOX) ;
 N XMDREC
 S XMDREC=$$EZBLD^DIALOG(XMDN)
 S XMOPT(XMCD)=$P(XMDREC,":",2,99)
 S XMOX("O",XMCD)=$P(XMDREC,":",1) ; "O"=original english to foreign
 S XMOX("X",$P(XMDREC,":",1))=XMCD ; "X"=translate foreign to english
 Q
Q(XMCD,XMDN) ;
 I $G(XMQDNUM) S XMOPT(XMCD,"?")=XMDN Q
 S XMOPT(XMCD,"?")=$$EZBLD^DIALOG(XMDN)
 Q
OPTUSER1(XMDUZ,XMOPT,XMOX) ;
 D SET("D",37202,.XMOPT,.XMOX) ; Delete messages
 D SET("F",37203,.XMOPT,.XMOX) ; Forward messages
 D SET("FI",37204,.XMOPT,.XMOX) ; Filter messages
 D SET("H",37205,.XMOPT,.XMOX) ; Headerless Print messages
 D SET("L",37206,.XMOPT,.XMOX) ; Later messages
 D SET("NT",37208,.XMOPT,.XMOX) ; New Toggle messages
 D SET("P",37209,.XMOPT,.XMOX) ; Print messages
 D SET("S",37213,.XMOPT,.XMOX) ; Save messages to another basket
 D SET("T",37214,.XMOPT,.XMOX) ; Terminate messages
 I '$D(^XMB(3.7,XMDUZ,15,"AF")) D
 . I XMDUZ=DUZ D Q("FI",37204.1) Q  ; You have no message filters defined.
 . S XMOPT("FI","?")=$$EZBLD^DIALOG(37204.2,XMV("NAME")) ; |1| has no message filters defined.
 D SET("V",37216,.XMOPT,.XMOX) ; Vaporize date set messages
 Q:XMDUZ'=.6
 D Q("L",37462) ; You may not do this in SHARED,MAIL.
 S XMOPT("NT","?")=XMOPT("L","?")
 Q:$$ZPOSTPRV^XMXSEC()
 ; You must hold the XMMGR key or be a POSTMASTER surrogate to do this in SHARED,MAIL.
 I $G(XMQDNUM) D  Q
 . F I="D","F","FI","S","T","V" S XMOPT(I,"?")=37261
 N DIR
 D BLD^DIALOG(37261,"","","DIR(""?"")")
 F I="D","F","FI","S","T","V" M XMOPT(I,"?")=DIR("?")
 Q
OPTUSER2(XMK,XMOPT,XMOX) ;
 D SET("C",37201,.XMOPT,.XMOX) ; Change the name of this basket
 D SET("N",37207,.XMOPT,.XMOX) ; New message list
 D SET("Q",37211,.XMOPT,.XMOX) ; Query (search for) messages in this basket
 D SET("R",37212,.XMOPT,.XMOX) ; Resequence messages
 I XMK'>1 D Q("C",37201.1) ; The name of this basket may not be changed.
 ;"The name of "_$S(XMK=1:"the IN",XMK=.5:"the WASTE",1:"this")_" basket may not be changed."
 Q:XMDUZ'=.6!$$ZPOSTPRV^XMXSEC()
 ; You must hold the XMMGR key or be a POSTMASTER surrogate to do this in SHARED,MAIL.
 I $G(XMQDNUM) S XMOPT("C","?")=37261 Q
 N DIR
 D BLD^DIALOG(37261,"","","DIR(""?"")")
 M XMOPT("C","?")=DIR("?")
 Q
OPTPOST(XMOPT,XMOX) ;
 D SET("D",37202,.XMOPT,.XMOX) ; Delete messages
 D SET("F",37203,.XMOPT,.XMOX) ; Forward messages (Added so that postmaster could reroute messages which for some reason were addressed to the wrong domain.)
 D SET("Q",37211,.XMOPT,.XMOX) ; Query (search for) messages in this basket
 D SET("R",37212,.XMOPT,.XMOX) ; Resequence messages
 D SET("X",37219,.XMOPT,.XMOX) ; Xmit Priority toggle
 Q
OPTSS(XMDUZ,XMOPT,XMOX) ; Super Search
 D SET("H",37205,.XMOPT,.XMOX) ; Headerless Print messages
 D SET("P",37209,.XMOPT,.XMOX) ; Print messages
 Q
COPYAMT(XMZ,XMWHICH) ; Checks total number of lines to be copied and total number of responses to be copied.
 ; Function returns 1 if OK; 0 if not OK.
 ; XMWHICH string of which responses to copy (0=original msg).
 ;         Default = original msg and all responses.
 N XMLIMIT,XMRESPS,XMABORT
 S XMABORT=0
 S XMLIMIT=$$COPYLIMS
 S XMRESPS=+$P($G(^XMB(3.9,XMZ,3,0)),U,4)
 I XMRESPS=0 D TOOMANY(+$P($G(^XMB(3.9,XMZ,2,0)),U,4),$P(XMLIMIT,U,3),37470,.XMABORT) Q 'XMABORT
 N I,J,XMRANGE,XMLINES
 S:'$D(XMWHICH) XMWHICH="0-"_XMRESPS
 S (XMRESPS,XMLINES)=0
 F I=1:1:$L(XMWHICH,",")-1 D
 . S XMRANGE=$P(XMWHICH,",",I)
 . F J=$P(XMRANGE,"-",1):1:$S(XMRANGE["-":$P(XMRANGE,"-",2),1:XMRANGE) D
 . . S XMRESPS=XMRESPS+1
 . . I J=0 S XMLINES=XMLINES+$P($G(^XMB(3.9,XMZ,2,0)),U,4) Q
 . . S XMLINES=XMLINES+$P($G(^XMB(3.9,+$G(^XMB(3.9,XMZ,3,J,0)),2,0)),U,4)
 D TOOMANY(XMLINES,$P(XMLIMIT,U,3),37470,.XMABORT) Q:XMABORT 0
 D TOOMANY(XMRESPS,$P(XMLIMIT,U,2),37471,.XMABORT) Q:XMABORT 0
 Q 1
TOOMANY(HOWMANY,XMLIMIT,XMDIALOG,XMABORT) ;
 Q:HOWMANY'>XMLIMIT
 S XMABORT=1
 D ERRSET^XMXUTIL(XMDIALOG,XMLIMIT) ; You may not copy more than the site limit of _XMLIMIT_ lines / responses.
 Q
COPYLIMS() ; Function returns copy limits string.
 ; limits:  # recipients^# responses^# lines
 N I
 S XMLIMIT=$G(^XMB(1,1,.11))
 F I=1:1:3 I '$P(XMLIMIT,U,I) S $P(XMLIMIT,U,I)=$P("2999^99^3999",U,I)
 Q XMLIMIT
COPYRECP(XMZ) ; Checks total number of recipients to see if it's OK to list them in the copy text and send the copy to them, too.
 ; Function returns 1 if OK; 0 if not OK.
 N XMLIMIT
 S XMLIMIT=$$COPYLIMS
 Q:$P($G(^XMB(3.9,XMZ,1,0)),U,4)'>$P(XMLIMIT,U,1) 1
 D ERRSET^XMXUTIL(37472,$P(XMLIMIT,U,1))
 ;Because this message has more than the site limit of _X_ recipients,
 ;we will neither list them in the text of the copy,
 ;nor will we deliver the copy to them.
 Q 0
SSPRIV() ; Is the user authorized to conduct a super search?
 Q:$$ZSSPRIV 1
 D ERRSET^XMXUTIL(34413.5)
 Q 0
ZSSPRIV() ; Is the user authorized to conduct a super search?
 I DUZ'<1,$D(^XUSEC("XM SUPER SEARCH",DUZ)) Q 1
 Q 0
ACCESS2(XMDUZ,XMZ,XMZREC) ; The user (XMDUZ) is not a recipient
 N XMOK                  ; of the message, but did he send it?
 I XMDUZ=$P(XMZREC,U,2)!(XMDUZ=$P(XMZREC,U,4)) D  Q XMOK
 . I XMDUZ='DUZ,'$$SURRACC^XMXSEC(XMDUZ,"",XMZ,XMZREC) S XMOK=0 Q
 . ; The user sent the message, so add him to it.
 . D ADDRECP^XMTDL(XMZ,$P(XMZREC,U,7)["P",XMDUZ)
 . S XMOK=1
 I XMDUZ'=DUZ D  Q 0
 . Q:'$$ACCESS^XMXSEC(DUZ,XMZ,XMZREC)
 . D ERRSET^XMXUTIL(37103,XMV("NAME"),XMZ)
 . ; You may not access this message as |1| unless you
 . ; or someone else on the message forwards it to |1|.
 D ERRSET^XMXUTIL(37102,"",XMZ)
 ; You are neither a sender nor a recipient of this message.
 ; If you need to see it, ask someone to forward it to you.
 Q 0
