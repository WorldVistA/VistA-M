XMVSURR ;ISC-SF/GMB-Surrogate management ;04/19/2002  11:32
 ;;8.0;MailMan;;Jun 28, 2002
 ; Replaces ^XMA7 (ISC-WASH/RJ/THM/CAP)
 ; Entry points used by MailMan options (not covered by DBIA):
 ; SHARE    XMSHARE  - Become SHARED,MAIL
 ; ASSUME   XMASSUME - Become another user
SHARE ; Assume the identity of SHARED,MAIL
 Q:'$$CHKOK
 S XMDUZ=.6
 D SURROGAT^XMVVITAE(XMDUZ,.XMV,.XMDUN,"",.XMPRIV)
 D HEADER^XM
 D MANAGE^XMJBM
 D SELF
 Q
CHKOK() ;
 I $D(^XUSEC("XMNOPRIV",DUZ)) D  Q 0
 . N XMTEXT  ;You have been given the XMNOPRIV key
 . W $C(7) ;and may not become anyone's surrogate.
 . D BLD^DIALOG(38053,"","","XMTEXT","F")
 . D MSG^DIALOG("WE","","","","XMTEXT")
 D CHECK^XMVVITAE
 Q 1
SELF ;
 D SELF^XMVVITAE
 W $C(7),!,$$EZBLD^DIALOG(38054),! ;You are now yourself again.
 D HEADER^XM
 Q
ASSUME ; Assume someone else's identity
 I '$D(^XMB(3.7,"AB",DUZ)) D SHARE Q
 Q:'$$CHKOK
 D LISTEM
 N DIC,Y
 S DIC(0)="AEMQZ"
 S D="B^BB^C^D"
 S DIC="^VA(200,"
 S DIC("W")="D SHOWPRIV^XMVSURR(Y)"
 S DIC("S")="I Y=.6!$D(^XMB(3.7,""AB"",DUZ,Y))"
 I XMDUZ=DUZ D
 . S DIC("B")=$$NAME^XMXUTIL(.6) ; SHARED,MAIL
 E  D
 . N XMTEXT
 . S DIC("S")=DIC("S")_"!(Y=DUZ),Y'=XMDUZ"
 . S DIC("B")=XMV("DUZ NAME")
 . ;You may select yourself to resume your own identity.
 . D BLD^DIALOG(38055,"","","XMTEXT","F")
 . D MSG^DIALOG("WE","","","","XMTEXT")
 D MIX^DIC1 I Y=-1!$D(DUOUT)!$D(DTOUT) Q
 S XMDUZ=+Y
 I XMDUZ=DUZ D SELF Q
 I XMDUZ=.6 D SHARE Q
 D OTHER^XMVVITAE
 D HEADER^XM
 Q
LISTEM ; List surrogates a user may become
 N XMDUZ
 W !,$$EZBLD^DIALOG(38056) ;Choose from:
 S XMDUZ=0
 F  S XMDUZ=$O(^XMB(3.7,"AB",DUZ,XMDUZ)) Q:'XMDUZ  W !,?3,$E($$NAME^XMXUTIL(XMDUZ),1,32) D SHOWPRIV(XMDUZ)
 W !,?3,$$NAME^XMXUTIL(.6) D SHOWPRIV(.6) W !
 Q
SHOWPRIV(XMDUZ) ;
 Q:XMDUZ=DUZ
 I XMDUZ=.6 W ?37,$$EZBLD^DIALOG(38048) Q  ;Read Privilege
 N XMPRIV,XMNEW
 S XMPRIV=$P($G(^XMB(3.7,XMDUZ,9,+$O(^XMB(3.7,"AB",DUZ,XMDUZ,0)),0)),U,2,3)
 I XMPRIV'["y" W ?37,$$EZBLD^DIALOG(38046) Q  ;No Privileges
 I $L(XMPRIV,"y")>2 W ?37,$$EZBLD^DIALOG(38047) ;Read and Send Privileges
 E  W ?37,$$EZBLD^DIALOG($S($P(XMPRIV,U)["y":38048,1:38049)) ; Read/Send Privilege
 S XMNEW=$$TNMSGCT^XMXUTIL(XMDUZ)
 W " ",$J($$EZBLD^DIALOG($S(XMNEW:38052,1:38051),XMNEW),79-$X) ; x/No New Msgs
 Q
