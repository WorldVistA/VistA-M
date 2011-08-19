RGMSCALR ;CAIRO/DKM - Send alert to user(s) via kernel or mail;04-Sep-1998 11:26;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Old entry point
ALERT(XQAMSG,RGUSR) ;
 D ALERT^RGUTALR(.XQAMSG,.RGUSR)
 Q
MAIL(RGMSG,XMY,XMSUB,XMDUZ) ;
 D MAIL^RGUTALR(.RGMSG,.XMY,.XMSUB,.XMDUZ)
 Q
