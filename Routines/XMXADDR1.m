XMXADDR1 ;ISC-SF/GMB-XMXADDR (cont.) ;05/21/2002  07:00
 ;;8.0;MailMan;;Jun 28, 2002
PERSON(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMG,XMFULL) ;
 N XMSCREEN,XMNOTFND
 S XMADDR=$$UP^XLFSTR(XMADDR)
 S XMSCREEN="I $L($P(^(0),U,3)),$D(^XMB(3.7,+Y,2))"  ; User must have an access code & mailbox
 ; "B^BB^C^D" = name^alias^initial^nickname            
 S XMG=$$FIND1^DIC(200,"","O",$S(+XMADDR=XMADDR:"`"_XMADDR,1:XMADDR),"B^BB^C^D",XMSCREEN)
 I XMG D  Q
 . S XMFULL=$$NAME^XMXUTIL(XMG)
 . Q:XMG'=.6
 . D CHKSHARE
 . S:XMLATER XMLATER="?"  ; Can't 'later' to SHARED,MAIL
 S XMNOTFND=$S($D(DIERR):39018,1:39019) ;Addressee ambiguous. / Addressee not found.
 I +XMADDR=XMADDR D  Q
 . D SETERR^XMXADDR4(0,"",XMNOTFND)
 ; Not found in NEW PERSON file, see if there's a MAIL NAME
 I $D(^XMB(3.7,"C")) D  Q:XMG
 . S XMSCREEN="I $L($P(^VA(200,+Y,0),U,3))"  ; User must have an access code
 . S XMG=$$FIND1^DIC(3.7,"","OQ",XMADDR,"C",XMSCREEN) Q:'XMG
 . S XMFULL=$$NAME^XMXUTIL(XMG)
 ; Not a Mail Name, see if it's in the Remote User Directory.
 N XMINDEX,I,XMG
 S XMINDEX="" F I="B","F" S:$D(^DIC(4.2997,I)) XMINDEX=XMINDEX_U_I
 I XMINDEX'="" D  Q:XMG
 . S XMINDEX=$E(XMINDEX,2,99)
 . S XMG=$$FIND1^DIC(4.2997,"","OQ",XMADDR,XMINDEX) Q:'XMG
 . S XMADDR=$P(^XMD(4.2997,XMG,0),U,7)
 . D CHKREM(XMG,XMADDR) Q:$D(XMERROR)
 . D REMDT(XMG)
 . D REMOTE^XMXADDR3(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,.XMFULL)
 D SETERR^XMXADDR4(0,"",XMNOTFND)
 Q
CHKSHARE ;
 I $G(XMINSTR("FLAGS"))["X"!($G(XMRESTR("FLAGS"))["X") D  Q
 . ;Closed messages may not be sent to SHARED,MAIL.
 . D SETERR^XMXADDR4(0,"",39020)
 I $G(XMINSTR("FLAGS"))["C"!($G(XMRESTR("FLAGS"))["C") D  Q
 . ;Confidential messages may not be sent to SHARED,MAIL.
 . D SETERR^XMXADDR4(0,"",39021)
 Q
REMDT(XMG) ;
 N XMFDA
 S XMFDA(4.2997,XMG_",",6)=$E(DT,1,5)  ; Date (YYYMM) remote address last used
 D FILE^DIE("","XMFDA")
 Q
IPERSON(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,XMLATER,XMG,XMFULL) ;
 N DIC,D,X,Y,XMINDEX
 S XMADDR=$$UP^XLFSTR(XMADDR)
 S DIC("S")="I $L($P(^(0),U,3)),$D(^XMB(3.7,+Y,2))"  ; User must have an access code & mailbox
 I XMSTRIKE S DIC("S")=DIC("S")_",$D(^TMP(""XMY"",$J,+Y))" ; If '-', must already have been chosen
 S DIC("W")="I Y'=DUZ D USERINFO^XMXADDR1(Y)"
 S DIC="^VA(200,"
 S DIC(0)="FEZMN"  ; If user enters a DUZ, ask "OK?"
 S X=XMADDR
 ;S DIC(0)="FEZM"  ; If user enters a DUZ, do NOT ask "OK?"
 ;S X=$S(XMADDR=+XMADDR:"`"_XMADDR,1:XMADDR)
 S (XMINDEX,D)="B^BB^C^D" ; name^alias^initial^nickname
 D MIX^DIC1
 I Y>0 D  Q
 . S XMG=+Y
 . S XMFULL=$$NAME^XMXUTIL(XMG) ; $P(Y,U,2)
 . Q:XMSTRIKE
 . ; Sending to yourself, and ask bskt, and not creating a forwarding address
 . I XMG=XMDUZ,$G(XMINSTR("ADDR FLAGS"))'["X",XMV("ASK BSKT") D
 . . N XMK,XMDIC
 . . S XMDIC("B")=$$EZBLD^DIALOG(37005) ;IN
 . . D SELBSKT^XMJBU(XMDUZ,$$EZBLD^DIALOG(39022),"L",.XMDIC,.XMK) ;Select basket to send to:
 . . I XMK=U D SETERR^XMXADDR4(0,"",39014) Q  ;No basket selected.
 . . S XMINSTR("SELF BSKT")=XMK
 . E  I XMG=.6 D
 . . D CHKSHARE
 . . I $D(XMERROR) D WRIERR^XMXADDR4("!") Q
 . . D ASKSHARE(.XMINSTR)
 . I $D(XMERROR) W !,XMFULL,$$EZBLD^DIALOG(39015) ;removed from recipient list.
 I $D(DUOUT)!$D(DTOUT) D  Q  ;up-arrow out. / time out.
 . D SETERR^XMXADDR4(0,"",$S($D(DUOUT):37000,1:37001))
 D NOTFOUND(XMADDR,XMINDEX)
 I XMADDR=+XMADDR D SETERR^XMXADDR4(0,"",39002) Q  ;Not found.
 W !,$C(7),$$EZBLD^DIALOG(39026),XMADDR ;Checking for MAIL NAME:
 S X=XMADDR
 K DIC("S"),DIC("W")
 S DIC(0)="FEZ"
 S D="C"
 S DIC="^XMB(3.7,"
 D IX^DIC
 I Y>0 D  Q
 . S XMG=+Y
 . S XMFULL=Y(0,0)
 I $D(DUOUT)!$D(DTOUT) D  Q  ;up-arrow out. / time out.
 . D SETERR^XMXADDR4(0,"",$S($D(DUOUT):37000,1:37001))
 ; Not a Mail Name, see if it's in the Remote User Directory.
 N XMFIND,DIR,XMG
 S XMFIND=X
 W !
 D BLD^DIALOG(39025,"","","DIR(""A"")") ; Not a local user; want to check the Remote User Directory?
 S DIR(0)="Y",DIR("B")=$$EZBLD^DIALOG(39053) ; No
 D BLD^DIALOG(39025.1,"","","DIR(""?"")")
 D ^DIR
 I 'Y W !
 E  D  Q:$D(XMG)
 . S X=XMFIND  ;Not a local user; checking Remote User Directory
 . W !,$C(7),$$EZBLD^DIALOG(39027),X
 . S DIC(0)="MFEVZ"
 . S D="B^F"
 . S DIC="^XMD(4.2997,"
 . D MIX^DIC1 Q:Y<0
 . S XMG=+Y
 . S XMADDR=$P(Y(0),U,7)
 . D CHKREM(XMG,XMADDR) Q:$D(XMERROR)
 . D REMDT(XMG)
 . W !,$$EZBLD^DIALOG(39028),XMADDR ;Routing to Remote Address:
 . D REMOTE^XMXADDR3(XMDUZ,XMADDR,XMSTRIKE,XMPREFIX,.XMLATER,.XMFULL) ;Q:$D(XMERROR)
 I $D(DUOUT)!$D(DTOUT) D  Q  ;up-arrow out. / time out.
 . D SETERR^XMXADDR4(0,"",$S($D(DUOUT):37000,1:37001))
 ; Not in Remote User Directory, see if it's a Mail Group
 S DIC="^XMB(3.8,"
 S D="B"
 S DIC(0)="O"
 D IX^DIC
 I Y>0 D  Q  ;Enter 'G.groupname' to identify a mail group
 . D SETERR^XMXADDR4(1,"!",39029)
 D SETERR^XMXADDR4(1,"",39002) ;Not found.
 Q
ASKSHARE(XMINSTR) ;
 N XMK,XMDIC
 S XMDIC("B")=$$EZBLD^DIALOG(37005) ;IN
 D SELBSKT^XMJBU(.6,$$EZBLD^DIALOG(39022),"L",.XMDIC,.XMK) ;Select basket to send to:
 I XMK=U D SETERR^XMXADDR4(0,"",39014) Q  ;No basket selected.
 N DIR,X,Y
 S DIR("A")=$$EZBLD^DIALOG(39023) ;Enter Termination Date
 S DIR("B")="T+30"
 S DIR(0)="D^"_DT_"::ENX"
 ;Messages sent to SHARED,MAIL must have a delete date, so
 ;they may be automatically removed from SHARED,MAIL's mailbox.
 D BLD^DIALOG(39024,"","","DIR(""?"")")
 S DIR("??")="^D HELP^%DTC"
 D ^DIR
 I $D(DIRUT) D SETERR^XMXADDR4(0,"",37002) Q  ;up-arrow or time out.
 S XMINSTR("SHARE BSKT")=XMK
 S XMINSTR("SHARE DATE")=Y
 Q
CHKREM(DA,XMADDR) ; Is the remote address really local?
 S XMADDR=$$UP^XLFSTR($P(XMADDR,"@",2))
 I $$FIND1^DIC(4.2,"","QO",XMADDR,"B^C")'=^XMB("NUM") Q
 N DIK
 S DIK="^XMD(4.2997,"
 D ^DIK
 I '$G(XMIA) D SETERR^XMXADDR4(0,"",39002) Q  ;Not found.
 D SETERR^XMXADDR4(1,"!",39028.1) ; Remote address is really local.  Deleting it.
 Q
USERINFO(XMDUZ) ;
 N %
 W:XMV("SHOW DUZ") " (DUZ ",XMDUZ,")"
 S %=$P($G(^VA(200,XMDUZ,5)),U,1)  ; Service/Section
 I % S %=$P($G(^DIC(49,%,0)),U,1) W:$L(%)+$X+1>79 !,?4 W " ",%," "
 S %=$P($G(^XMB(3.7,XMDUZ,"L"),$$EZBLD^DIALOG(38002)),U,1) ;Never
 W:$L(%)+$X+20>79 !,?4 W $$EZBLD^DIALOG(38003),% ;Last used MailMan:
 S %=$G(^XMB(3.7,XMDUZ,0))
 I $L($P(%,U,2)) W !,?5,$$EZBLD^DIALOG(38004),$P(%,U,2),$S($P(%,U,8):$$EZBLD^DIALOG(38005),1:$$EZBLD^DIALOG(38006)) ;Forwarding Address: / Local Delivery is ON / Local Delivery is OFF
 S %=$G(^XMB(3.7,XMDUZ,"B")) W:%'="" !,?10,%
 Q
NOTFOUND(XMADDR,XMINDEX) ;
 N XMI,XMREC
 S XMI=$$FIND1^DIC(200,"","O",$S(+XMADDR=XMADDR:"`"_XMADDR,1:XMADDR),XMINDEX)
 I 'XMI W $C(7),$$EZBLD^DIALOG(39030) Q  ;Not found in NEW PERSON file.
 ; found user, but missing access/verify/mailbox
 S XMREC=^VA(200,XMI,0)
 I $D(^XMB(3.7,XMI,2)),$P(XMREC,U,3)'="" Q
 N XMPARM,XMTEXT
 S XMPARM(1)=$$NAME^XMXUTIL(XMI)
 S XMPARM(2)=$S($P(XMREC,U,3)'="":$$EZBLD^DIALOG(39034),$D(^XMB(3.7,XMI,2)):$$EZBLD^DIALOG(39032),1:$$EZBLD^DIALOG(39033)) ;a mailbox / an access code or a mailbox / an access code
 ;If |1| is the person you're trying to address, you can't,
 ;because |1| doesn't have |2|.
 D BLD^DIALOG(39031,.XMPARM,"","XMTEXT","F")
 D MSG^DIALOG("WH","","","","XMTEXT")
 Q
