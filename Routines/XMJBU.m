XMJBU ;ISC-SF/GMB-Basket utilities ;04/06/2002  08:56
 ;;8.0;MailMan;;Jun 28, 2002
 ; (ISC-WASH/CAP/THM)
SELBSKT(XMDUZ,XMPROMPT,XMLAYGO,XMDIC,XMK,XMKN) ; Select a basket (Replaces S^XMA1B)
 ; XMPROMPT (in) Verbage for prompt
 ; XMLAYGO  (in) "L" - the user may create a new basket
 ;               ""  - the user may not create a new basket
 ; XMK      (out) basket number (=^ if user up-arrows out)
 ; XMKN     (out) basket name
 N DIC,DINUM,DA,Y,X
 I $G(XMLAYGO)["L" D
 . ; Find the first vacant basket spot.
 . F DINUM=2:1 Q:'$D(^XMB(3.7,XMDUZ,2,DINUM))
 . ; Postmaster baskets numbered above 999 are reserved for message queues.
 . I XMDUZ=.5,DINUM>999 S XMLAYGO=$TR(XMLAYGO,"L")
 ; Postmaster may not save a queued msg to his own basket. ***
 S DIC="^XMB(3.7,"_XMDUZ_",2,"
 S DA(1)=XMDUZ
 S DIC(0)="AEQ"_$G(XMLAYGO)
 I $G(XMPROMPT)'="" S DIC("A")=$S(+XMPROMPT=XMPROMPT:$$EZBLD^DIALOG(XMPROMPT),1:XMPROMPT)
 ; XMDIC("B")="@" means don't give a default
 I $G(XMDIC("B"))'="@" D
 . I $D(XMDIC("B")) S DIC("B")=XMDIC("B") Q
 . I $$BMSGCT^XMXUTIL(XMDUZ,1) S DIC("B")=$$EZBLD^DIALOG(37005) Q  ; IN
 . W !!,$$EZBLD^DIALOG(34044,$$EZBLD^DIALOG(37005)) ; No messages in 'IN' basket.
 S:$D(XMDIC("S")) DIC("S")=XMDIC("S")
 S:$D(XMDIC("W")) DIC("W")=XMDIC("W")
 D ^DIC I Y=-1 S XMK=U Q
 S XMK=$P(Y,U,1)
 S XMKN=$P(Y,U,2)
 Q
CHKXMKN(X) ; Input transform for file 3.7 (3.701,.01 BASKET)
 I X=+X,$D(^XMB(3.7,$G(XMDUZ,DUZ),2,X)) S X="`"_X Q
 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>30!($L(X)<3) X
 Q
NAMEBSKT(XMDUZ,XMK,XMKN) ; Rename an existing basket (Replaces REN^XMA11)
 ; XMK      (in) basket number
 ; XMKN     (in/out) basket name
 N DIR,X,XMFDA,XMKX
 I XMK'>1!(XMDUZ=.5&(XMK>999)) D  Q
 . W !,$$EZBLD^DIALOG(37201.1) ; The name of this basket may not be changed.
 ; *** I would rather use a ^DIE call, if I were sure that the user
 ; *** could not delete the basket or create a duplicate basket name.
 S DIR("A")=$$EZBLD^DIALOG(34048) ; Enter a new basket name
 S DIR("B")=XMKN
 S DIR(0)="3.701,.01"
 F  D ^DIR Q:$D(DIRUT)  D  Q:$D(X)
 . I X=XMKN D  Q
 . . W !,$C(7),$$EZBLD^DIALOG(34048.8) ; That's the same name.
 . . K X
 . S XMKX=$$FIND1^DIC(3.701,","_XMDUZ_",","X",X)
 . I XMKX,XMKX'=XMK D  Q
 . . W !,$C(7),$$EZBLD^DIALOG(34048.9) ; You already have a basket by this name.
 . . K X
 . S XMKN=X
 . S XMFDA(3.701,XMK_","_XMDUZ_",",.01)=XMKN
 . D FILE^DIE("","XMFDA")
 Q
