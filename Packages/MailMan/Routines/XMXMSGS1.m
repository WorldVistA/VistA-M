XMXMSGS1 ;ISC-SF/GMB-Message APIs (cont.) ;04/19/2002  11:58
 ;;8.0;MailMan;;Jun 28, 2002
FWD(XMDUZ,XMZ,XMINSTR,XMCNT) ;
XFWD ; (Need XMDUZ, XMZ, XMINSTR.  XMK not needed.)
 ; XMZREC   Zero node of the msg record
 N XMZREC,%X,%Y,XMRESTR
 S XMZREC=^XMB(3.9,XMZ,0)
 Q:'$$FORWARD^XMXSEC(XMDUZ,XMZ,XMZREC)
 D GETRESTR^XMXSEC1(XMDUZ,XMZ,XMZREC,.XMINSTR,.XMRESTR)
 D CHKSHARE(XMDUZ,XMZ,.XMRESTR)
 I $G(XMINSTR("ADDR FLAGS"))'["R" D CHKRESTR(XMDUZ,XMZ,.XMRESTR)
 D FWDIT(XMDUZ,XMZ,.XMINSTR,.XMCNT)
 I $D(^TMP("XM",$J,"SAVE")) D RESTADDR
 Q
CHKSHARE(XMDUZ,XMZ,XMRESTR) ;
 I $G(XMRESTR("FLAGS"))["C",$D(^TMP("XMY",$J,.6)) D
 . D ERRSET^XMXUTIL(39200,XMZ,XMZ)
 . ;Confidential messages may not be forwarded to SHARED,MAIL.
 . D SAVEADDR
 . D CHKADDR^XMXADDR(XMDUZ,"-.6")
 I $G(XMRESTR("FLAGS"))["X",$D(^TMP("XMY",$J,.6)) D
 . D ERRSET^XMXUTIL(39201,XMZ,XMZ)
 . ;Message |1| is closed.  SHARED,MAIL removed as recipient.
 . ;Closed messages may not be forwarded to SHARED,MAIL.
 . D SAVEADDR
 . D CHKADDR^XMXADDR(XMDUZ,"-.6")
 Q
CHKRESTR(XMDUZ,XMZ,XMRESTR) ;
 N XMTO
 I $D(XMRESTR("NOBCAST")) D
 . ; The user is not allowed to forward this message to broadcast
 . ; because it has replies, and users with autoforward would not
 . ; see the replies.  Search for any broadcasts and delete them.
 . N XMOK
 . S XMTO="",XMOK=1
 . F  S XMTO=$O(^TMP("XMY0",$J,XMTO)) Q:XMTO=""  D
 . . Q:$E(XMTO)'="*"
 . . S XMOK=0
 . . I '$D(^TMP("XM",$J,"SAVE")) D SAVEADDR
 . . D CHKADDR^XMXADDR(XMDUZ,"-"_XMTO)
 . Q:XMOK
 . D ERRSET^XMXUTIL(39205,XMZ,XMZ)
 I $D(XMRESTR("NOFPG")) D
 . ; The user is not allowed to forward this priority message to groups
 . ; because s/he is not the originator and does not possess the proper
 . ; security key.  Search for any groups and delete them.
 . N XMOK
 . S XMTO="",XMOK=1
 . F  S XMTO=$O(^TMP("XMY0",$J,XMTO)) Q:XMTO=""  D
 . . Q:$E(XMTO,1,2)'="G."
 . . S XMOK=0
 . . I '$D(^TMP("XM",$J,"SAVE")) D SAVEADDR
 . . D CHKADDR^XMXADDR(XMDUZ,"-"_XMTO)
 . Q:XMOK
 . D ERRSET^XMXUTIL(39202,XMZ,XMZ)
 . ;Priority message |1| not forwarded.
 . ;Only message originator or XM GROUP PRIORITY key holders
 . ;may forward priority messages to groups.
 I $D(XMRESTR("NONET")) D
 . ; The user is not allowed to forward this message to remote sites
 . ; because it exceeds the site maximum number of lines and
 . ; s/he does not possess the proper security key.
 . ; Search for any remote addressees and delete them.
 . N XMOK
 . S XMTO="",XMOK=1
 . F  S XMTO=$O(^TMP("XMY0",$J,XMTO)) Q:XMTO=""  D
 . . Q:XMTO'["@"
 . . S XMOK=0
 . . I '$D(^TMP("XM",$J,"SAVE")) D SAVEADDR
 . . D CHKADDR^XMXADDR(XMDUZ,"-"_XMTO)
 . Q:XMOK
 . N XMPARM S XMPARM(1)=XMZ,XMPARM(2)=XMRESTR("NONET")
 . D ERRSET^XMXUTIL(39203,.XMPARM,XMZ)
 . ;Message |1| not forwarded to remote recipients.
 . ;Only XMMGR key holders may forward to remotes sites
 . ;messages which exceed site maximum of |2| lines.
 Q
SAVEADDR ; Save addressees
 S %X="^TMP(""XMY"",$J,",%Y="^TMP(""XM"",$J,""SAVE"",""XMY""," D %XY^%RCR
 S %X="^TMP(""XMY0"",$J,",%Y="^TMP(""XM"",$J,""SAVE"",""XMY0""," D %XY^%RCR
 Q
RESTADDR ; Restore addressees
 S %X="^TMP(""XM"",$J,""SAVE"",""XMY"",",%Y="^TMP(""XMY"",$J," D %XY^%RCR
 S %X="^TMP(""XM"",$J,""SAVE"",""XMY0"",",%Y="^TMP(""XMY0"",$J," D %XY^%RCR
 K ^TMP("XM",$J,"SAVE")
 Q
FWDONE(XMDUZ,XMZ,XMTO,XMINSTR,XMCNT) ; Forward one message
XFWDONE ;
 N XMZREC,XMRESTR
 S XMZREC=^XMB(3.9,XMZ,0)
 Q:'$$FORWARD^XMXSEC(XMDUZ,XMZ,XMZREC)
 D:$G(XMINSTR("ADDR FLAGS"))'["I" INIT^XMXADDR
 D:$G(XMINSTR("ADDR FLAGS"))'["R" GETRESTR^XMXSEC1(XMDUZ,XMZ,XMZREC,.XMRESTR)
 D CHKADDR^XMXADDR(XMDUZ,.XMTO,.XMINSTR,.XMRESTR)
 D FWDIT(XMDUZ,XMZ,.XMINSTR,.XMCNT)
 Q
FWDIT(XMDUZ,XMZ,XMINSTR,XMCNT) ;
 I $$GOTADDR^XMXADDR D  Q
 . D FWD^XMKP(XMDUZ,XMZ,.XMINSTR)
 . S:$D(XMCNT) XMCNT=XMCNT+1
 ;Message |1| has no addressees.  Not forwarded.
 D ERRSET^XMXUTIL(39204,XMZ,XMZ)
 Q
PRT(XMDUZ,XMZ) ; Print
XPRT ;
 S ^TMP("XM",$J,"XMZ",XMZ)=""
 S XMCNT=$G(XMCNT)+1
 Q
XP(XMDUZ,XMK,XMZ,XMTPRI,XMCNT)      ; Toggle Transmission Priority
XXP ;
 S:'$G(XMK) XMK=$O(^XMB(3.7,"M",XMZ,XMDUZ,""))
 I XMDUZ'=.5!(XMK'>999) D  Q  ;Transmit priority toggle valid only
 . D ERRSET^XMXUTIL(37219.5)  ;for Postmaster transmission queues.
 Q:XMTPRI=$P(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0),U,6)
 N XMFDA
 S XMFDA(3.702,XMZ_","_XMK_","_XMDUZ_",",6)=XMTPRI
 D FILE^DIE("","XMFDA")
 S:$D(XMCNT) XMCNT=XMCNT+1
 Q
PUTSERV(XMKN,XMZ) ; Replaces SETSB^XMA1C (ISC-WASH/ACC/IHS)
 ; Put message in Postmaster's basket for this server.
 ; Create server basket as needed.
 ; XMKN  Full server name (with S.)
 ; XMZ   Message number
 ;
 ; Messages to server are saved in a mail basket of the
 ; Postmaster much like transmission queues.  But while
 ; Domain queues point at the domain file (domain#+1000),
 ; Server baskets point at the option file (option#+10000).
 N XMK
 S XMK=$O(^DIC(19,"B",$E(XMKN,3,999),0)) Q:'XMK
 S XMK=XMK+10000
 D PUTMSG^XMXMSGS2(.5,XMK,XMKN,XMZ)
 Q
ZAPSERV(XMKN,XMZ) ; Replaces REMSBMSG^XMA1C (ISC-WASH/ACC/IHS)
 ; Remove message from server basket
 ; XMKN  Full server name (with S.)
 ; XMZ   Message number
 N XMK
 S XMK=$O(^XMB(3.7,.5,2,"B",XMKN,0)) Q:'XMK  Q:XMK'>10000
 D ZAPIT^XMXMSGS2(.5,XMK,XMZ)
 Q
