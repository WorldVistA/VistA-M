XMRPOP ;ISC-SF/GMB-POP3 Server (RFC 1939) ;05/20/2002  07:05
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces the class III routines ^XMRPOPA, ^XMRPOPB, ^XMRPOPC,
 ; which were written by Chiao-Ming Wu, WASH-ISC.
 ;
 ; Implements RFC 1939 (replaces RFC 1725)
 ; Post Office Protocol - Version 3 (POP3) maildrop service
 ;
 ; Rather than locking the user's IN basket, which severely disrupts
 ; mail delivery, we take a snapshot of it, and keep the snapshot in
 ; a temp global.  We then use the temp global during the session.
 ; Here is the layout of the global:
 ;
 ; ^TMP("XM",$J,"POP3")=# msgs^# octets   ; total msgs in IN basket
 ;                                        ; (updated if msgs are deleted)
 ; ^TMP("XM",$J,"POP3",1)=XMZ^# octets    ; msgs 1 thru n are in
 ;         ...                            ; IN basket.
 ; ^TMP("XM",$J,"POP3",i)=XMZ^# octets    ; 
 ; ^TMP("XM",$J,"POP3",j)=XMZ^# octets    ; 
 ;         ...                            ; 
 ; ^TMP("XM",$J,"POP3",n)=XMZ^# octets    ; 
 ;                                        ;
 ; ^TMP("XM",$J,"POP3","D",i)=XMZ         ; user deleted msg i
 ; ^TMP("XM",$J,"POP3","D",j)=XMZ         ; user deleted msg j
ENTRY ;
 N XMK,XMSTATE,XMCMDS,XMCMD,XMDUZ,XMACCESS,XMVERIFY,XMTRY,XMTMSGS,XMTOCTS,XMV
 I '$D(ZTQUEUED) S X=$S($D(^%ZOSF("ERRTN")):^("ERRTN"),1:"ERR^ZU"),@(^%ZOSF("TRAP"))
 I '$G(DUZ) S DUZ=.5
 I '$D(XMDUZ) S XMDUZ=DUZ
 I '$D(XMC("BATCH")) S XMC("BATCH")=0
 I $S('$D(XMCHAN):1,XMCHAN="":1,1:0) S XMCHAN="TCP/IP-MAILMAN"
 D OPEN^XML
 I $G(ER)=1 D ^%ZISC:IO'=$G(IO(0)) W !,"Device open failed !",$C(7) Q
 S:'$D(XM) XM=""
 I 'XMC("BATCH") X ^%ZOSF("EOFF") S X=255 X ^%ZOSF("RM"),^%ZOSF("TYPE-AHEAD")
 S ER=0
 S XMK=1
 S XMSG="+OK "_^XMB("NETNAME")_" POP3 server ready (Comments to: POSTMASTER@"_^XMB("NETNAME")_")" X XMSEN Q:ER
 S XMCMDS("AUTH")="^PASS^QUIT^USER^"
 S XMCMDS("TRAN")="^DELE^LIST^NOOP^QUIT^RETR^RSET^STAT^TOP^UIDL^"
 S XMSTATE="AUTH"
 F  X XMREC Q:ER  D  Q:XMCMD="QUIT"!ER
 . I XMRG="" S ER=1,XMCMD="" Q
 . S XMCMD=$P(XMRG," ",1)
 . I $L(XMCMD)<3!($L(XMCMD)>4)!(XMCMD'?.U) S XMSG="-ERR no such command" X XMSEN Q
 . I $T(@XMCMD)'[";;" S XMSG="-ERR no such command" X XMSEN Q
 . I XMCMDS(XMSTATE)'[(U_XMCMD_U)="" S XMSG="-ERR no such command in "_XMSTATE_" state" X XMSEN Q
 . D @XMCMD
 I ER,$G(XMCMD)'="QUIT" D QUIT
 Q
DELE ;;
 N XMID
 S XMID=$P(XMRG," ",2,999)
 Q:'$$OKID(XMID)
 N XMREC,XMZ,XMOCTS
 S XMZ=+^TMP("XM",$J,"POP3",XMID),XMOCTS=$P(^(XMID),U,2)
 S ^TMP("XM",$J,"POP3","D",XMID)=XMZ
 S XMREC=^TMP("XM",$J,"POP3")
 S ^TMP("XM",$J,"POP3")=($P(XMREC,U,1)-1)_U_($P(XMREC,U,2)-XMOCTS)
 S XMSG="+OK message "_XMID_" deleted" X XMSEN
 Q
OKID(XMID) ;
 I XMID="" S XMSG="-ERR message-id required" X XMSEN Q 0
 I +XMID'=XMID S XMSG="-ERR improper message-id" X XMSEN Q 0
 I '$D(^TMP("XM",$J,"POP3",XMID)) S XMSG="-ERR no such message" X XMSEN Q 0
 I $D(^TMP("XM",$J,"POP3","D",XMID)) S XMSG="-ERR message "_XMID_" already deleted" X XMSEN Q 0
 Q 1
LIST ;;
 N XMID,XMOCTS
 S XMID=$P(XMRG," ",2,999)
 I XMID="" D  Q
 . S XMSG="+OK "_$P(^TMP("XM",$J,"POP3"),U,1)_" messages ("_$P(^("POP3"),U,2)_" octets)" X XMSEN Q:ER
 . F  S XMID=$O(^TMP("XM",$J,"POP3",XMID)) Q:'XMID  S XMOCTS=$P(^(XMID),U,2) D  Q:ER
 . . Q:$D(^TMP("XM",$J,"POP3","D",XMID))
 . . S XMSG=XMID_" "_XMOCTS X XMSEN
 . S XMSG="." X XMSEN
 Q:'$$OKID(XMID)
 S XMSG="+OK "_XMID_" "_$P(^TMP("XM",$J,"POP3",XMID),U,2) X XMSEN
 Q
NOOP ;;
 S XMSG="+OK" X XMSEN
 Q
PASS ;;
 I '$D(XMACCESS) D LOGINERR("-ERR sorry, USER access code expected") Q
 S XMVERIFY=$P(XMRG," ",2,999)
 I XMVERIFY'="" D LOGIN Q
 D LOGINERR("-ERR sorry, PASS verify code expected")
 Q
LOGIN ;
 N XMLOGIN
 S XMLOGIN=$$LOGINOK
 I 'XMLOGIN D LOGINERR("-ERR "_$P(XMLOGIN,U,2)) Q
 K XMACCESS,XMVERIFY
 S XMSTATE="TRAN"
 S XMDUZ=DUZ
 D INIT^XMVVITAE
 D MAILDROP
 D RSET
 Q
LOGINOK() ;
 I $T(@"USERSET^XUSRA")="" Q $$OLDCHK
 Q $$USERSET^XUSRA(XMACCESS_";"_XMVERIFY)
OLDCHK() ;
 N XUSER,XUF,%1,XMLOGIN
 S XUF=0
 S XMLOGIN=$$CHECKAV^XUS(XMACCESS_";"_XMVERIFY)
 I XMLOGIN S DUZ=XMLOGIN Q 1
 Q "0^Not a valid ACCESS CODE/VERIFY CODE pair"
MAILDROP ;
 N XMKZ,XMZ,XMOCTS,XMID
 K ^TMP("XM",$J,"POP3")
 S (XMID,XMKZ,XMTOCTS)=0
 F  S XMKZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ)) Q:'XMKZ  D
 . S XMZ=$O(^XMB(3.7,XMDUZ,2,XMK,1,"C",XMKZ,0))
 . I '$D(^XMB(3.7,XMDUZ,2,XMK,1,XMZ,0)) D ADDITC^XMUT4A(XMDUZ,XMK,XMZ,XMKZ)
 . I '$D(^XMB(3.9,XMZ,0)) D ZAPIT^XMXMSGS2(XMDUZ,XMK,XMZ) Q
 . S XMID=XMID+1
 . S XMOCTS=$$OCTETS(XMZ)
 . S XMTOCTS=XMTOCTS+XMOCTS
 . S ^TMP("XM",$J,"POP3",XMID)=XMZ_U_XMOCTS
 S XMTMSGS=XMID
 Q
OCTETS(XMZ) ; Returns the number of 'octets' in a message.
 ; Basically, that's a count of the number of characters.
 ; We estimate it by multiplying the number of lines by 50.
 Q $P($G(^XMB(3.9,XMZ,2,0)),U,4)*50
LOGINERR(XMSG) ;
 K XMACCESS,XMVERIFY
 S XMTRY=$G(XMTRY)+1
 I XMTRY<3 X XMSEN Q
 D SIGNOFF(XMSG_"; 3 tries and you're out!")
 S XMCMD="QUIT"
 Q
QUIT ;;
 I XMSTATE="TRAN",'ER D UPDATE
 K ^TMP("XM",$J,"POP3")
 D SIGNOFF("")
 Q
SIGNOFF(XMSG) ;
 S XMSG=$S(XMSG'="":XMSG_"; ",ER:"-ERR ",1:"+OK ")_^XMB("NETNAME")_" POP3 server signing off" X XMSEN
 Q
RETR ;;
 N XMID
 S XMID=$P(XMRG," ",2,999)
 Q:'$$OKID(XMID)
 S XMSG="+OK "_$P(^TMP("XM",$J,"POP3",XMID),U,2)_" octets" X XMSEN Q:ER
 D RETRIEVE(XMID,"*")
 Q
RSET ;;
 K ^TMP("XM",$J,"POP3","D")
 S ^TMP("XM",$J,"POP3")=XMTMSGS_U_XMTOCTS
 S XMSG="+OK maildrop has "_XMTMSGS_" messages ("_XMTOCTS_" octets)" X XMSEN
 Q
STAT ;;
 S XMSG="+OK "_$P(^TMP("XM",$J,"POP3"),U,1)_" "_$P(^("POP3"),U,2) X XMSEN
 Q
TOP ;;
 N XMID,XMLINES
 S XMID=$P(XMRG," ",2)
 Q:'$$OKID(XMID)
 S XMLINES=$P(XMRG," ",3,999)
 I +XMLINES'=XMLINES S XMSG="-ERR improper number of lines" X XMSEN Q
 S XMSG="+OK" X XMSEN Q:ER
 D RETRIEVE(XMID,XMLINES)
 Q
UIDL ;;
 N XMID,XMZ
 S XMID=$P(XMRG," ",2,999)
 I XMID="" D  Q
 . S XMSG="+OK" X XMSEN Q:ER
 . F  S XMID=$O(^TMP("XM",$J,"POP3",XMID)) Q:'XMID  S XMZ=+^(XMID) D  Q:ER
 . . Q:$D(^TMP("XM",$J,"POP3","D",XMID))
 . . S XMSG=XMID_" "_XMZ X XMSEN
 . S XMSG="." X XMSEN
 Q:'$$OKID(XMID)
 S XMSG="+OK "_XMID_" "_+^TMP("XM",$J,"POP3",XMID) X XMSEN
 Q
USER ;;
 S XMACCESS=$P(XMRG," ",2,999)
 I XMACCESS'="" S XMSG="+OK" X XMSEN Q
 D LOGINERR("-ERR sorry, USER access code expected")
 Q
UPDATE ;
 N XMID,XMZ
 S XMID=0
 F  S XMID=$O(^TMP("XM",$J,"POP3","D",XMID)) Q:'XMID  S XMZ=+^(XMID) D DEL^XMXMSGS2(XMDUZ,"",XMZ)
 Q
RETRIEVE(XMID,XMLINES) ;
 N XMZ,XMRESP,XMIM,XMINSTR,XMIU
 S XMZ=+^TMP("XM",$J,"POP3",XMID)
 D INMSG^XMXUTIL2(XMDUZ,"",XMZ,"","I",.XMIM,.XMINSTR,.XMIU)
 D RETRXMZ(XMZ,XMLINES,.XMIM) Q:ER
 I 'XMLINES,XMIM("RESPS") D  Q:ER
 . F XMRESP=XMIU("RESP")+1:1:XMIM("RESPS") D  Q:ER
 . . N XMIR
 . . D INRESP^XMXUTIL2(XMZ,XMRESP,"I",.XMIR) Q:'$D(XMIR)
 . . I XMIR("SUBJ")?1"R".N S XMIR("SUBJ")="Re: "_XMIM("SUBJ")
 . . S XMSG="" X XMSEN Q:ER  ; just for visual separation
 . . D RETRXMZ(XMIR("XMZ"),"*",.XMIR,XMZ) Q:ER
 E  S XMRESP=0
 S XMSG="." X XMSEN Q:ER
 D LASTACC^XMXUTIL(XMDUZ,XMK,XMZ,XMRESP,.XMIM,.XMINSTR,.XMIU)
 I $D(^XMB(3.7,XMDUZ,"N0",XMK,XMZ)),+XMRESP=+$P($G(^XMB(3.9,XMZ,3,0)),U,4) D NONEW^XMXUTIL(XMDUZ,XMK,XMZ,1)
 Q
RETRXMZ(XMZ,XMLINES,XMIM,XMZO) ;
 N XMI
 I $O(^XMB(3.9,XMZ,2,0))'<1 D CRE8HDR(XMZ,.XMIM,.XMZO) Q:ER
 S XMI=0
 F  S XMI=$O(^XMB(3.9,XMZ,2,XMI)) Q:'XMI  S XMSG=^(XMI,0) S:$E(XMSG)="." XMSG="."_XMSG X XMSEN Q:ER  I XMLINES,XMI'<XMLINES Q
 Q
CRE8HDR(XMZ,XMIM,XMZO) ;
 S XMSG="Message-ID: <"_XMZ_"@"_^XMB("NETNAME")_">" X XMSEN Q:ER
 S XMSG="From: <"_$$NETNAME^XMXUTIL(XMIM("FROM"))_">" X XMSEN Q:ER
 S XMSG="To: <"_XMV("NETNAME")_">" X XMSEN Q:ER
 S XMSG="Subject: "_XMIM("SUBJ") X XMSEN Q:ER
 S XMSG="Date: "_$$INDT^XMXUTIL1(XMIM("DATE")) X XMSEN Q:ER
 S XMSG="" X XMSEN Q:ER
 Q
