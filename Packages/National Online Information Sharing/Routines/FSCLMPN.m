FSCLMPN ;SLC/STAFF NOIS List Manager Protocol New ;1/13/98  12:56
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTIFY ; from FSCLMP
 N DIR,Y K DIR
 S DIR(0)="SAMO^NOTIFY:NOTIFY;BE NOTIFIED:BE NOTIFIED;REMOVE:REMOVE"
 S DIR("A")="Select (N)otify, (B)e Notified, or (R)emove Notification: "
 S DIR("?",1)="Enter NOTIFY to send notification to others."
 S DIR("?",2)="Enter BE NOTIFIED to schedule notification to yourself."
 S DIR("?",3)="Enter REMOVE to unschedule notification on yourself."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y="NOTIFY" D NOTIFY^FSCLMPNN Q
 I Y="BE NOTIFIED" D NOTIFY^FSCLMPNB Q
 I Y="REMOVE" D NOTIFY^FSCLMPNR Q
 Q
 ;
NOTIFYL ; from FSCLMP
 N DIR,Y K DIR
 S DIR(0)="SAMO^NOTIFY:NOTIFY;BE NOTIFIED:BE NOTIFIED;FIND:FIND;REMOVE:REMOVE"
 S DIR("A")="Select (N)otify, (B)e Notified, (F)ind, or (R)emove Notification: "
 S DIR("?",1)="Enter NOTIFY to send notification to others."
 S DIR("?",2)="Enter BE NOTIFIED to schedule notification to yourself."
 S DIR("?",3)="Enter FIND to find scheduled notifications."
 S DIR("?",4)="Enter REMOVE to unschedule notification on yourself."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y="NOTIFY" D NOTIFY^FSCLMPNN Q
 I Y="BE NOTIFIED" D NOTIFY^FSCLMPNB Q
 I Y="FIND" D NOTIFY^FSCLMPNF Q
 I Y="REMOVE" D NOTIFY^FSCLMPNR Q
 Q
