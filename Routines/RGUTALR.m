RGUTALR ;CAIRO/DKM - Send alert to user(s) via kernel or mail;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Send an alert.
 ;   XQAMSG = Message to send
 ;   RGUSR  = A semicolon-delimited list of users to receive alert.
 ;=================================================================
ALERT(XQAMSG,RGUSR) ;
 N XQA,XQAOPT,XQAFLG,XQAROU,XQADATA,XQAID
 S @$$TRAP^RGZOSF("EXIT^RGUTALR"),RGUSR=$G(RGUSR,"*"),XQAMSG=$TR(XQAMSG,U,"~")
 D ENTRY^RGUTUSR(RGUSR,.XQA),SETUP^XQALERT:$D(XQA)
EXIT Q
 ;=================================================================
 ; Send a mail message
 ;   RGMSG  = Message to send (single node or array)
 ;   XMY    = A semicolon-delimited list (or array) of users
 ;   XMSUB  = Subject line (optional)
 ;   XMDUZ  = DUZ of sender (optional)
 ;=================================================================
MAIL(RGMSG,XMY,XMSUB,XMDUZ) ;
 N XMTEXT
 S:$D(RGMSG)=1 RGMSG(1)=RGMSG
 S XMTEXT="RGMSG(",@$$TRAP^RGZOSF("EXIT^RGUTALR"),XMY=$G(XMY)
 S:$G(XMSUB)="" XMSUB=RGMSG
 S:$G(XMDUZ)="" XMDUZ=$G(DUZ)
 F  Q:'$L(XMY)  S X=$P(XMY,";"),XMY=$P(XMY,";",2,999) S:$L(X) XMY(X)=""
 D ^XMD:$D(XMY)>9
 Q
