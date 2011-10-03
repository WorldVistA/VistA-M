FSCLMPNN ;SLC/STAFF NOIS List Manager Protocol Notification Notify ;2/16/96  15:56
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTIFY ; from FSCLMPN
 N DIR,LENGTH,NOTIFY,SUBJECT,Y K DIR
 S DIR(0)="SAMO^MAIL:MAIL;ALERT:ALERT",DIR("A")="Notify by (M)ail or (A)lert: ",DIR("B")="ALERT"
 S DIR("?",1)="You can send notification to others (including mail groups)"
 S DIR("?",2)="using email or menu alerts."
 S DIR("?",3)="Enter MAIL to send by mail, ALERT to send using alerts."
 S DIR("?",4)="Enter '^' to exit without sending notification or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S NOTIFY=Y,LENGTH=$S(NOTIFY="MAIL":65,1:30)
 N DIR,Y K DIR
 S DIR(0)="FAO^3:"_LENGTH,DIR("A")="Enter a brief reason for the notification: "
 S DIR("?",1)="Enter a brief (3-"_LENGTH_" character) message to be sent with the notification."
 S DIR("?",2)="Enter '^' to exit without sending notification or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT)!'$L(Y) Q
 S SUBJECT=Y,SUBJECT=$$SUBCHK^XMGAPI0(SUBJECT,0)
 I $P(SUBJECT,U) W !,"This entry is invalid." H 2 Q
 S SUBJECT=$P(SUBJECT,U,2)
 I NOTIFY="MAIL" D MAIL^FSCNMS(SUBJECT)
 I NOTIFY="ALERT" D ALERT^FSCNAS(SUBJECT)
 Q
