FSCLMPNB ;SLC/STAFF NOIS List Manager Protocol Notification Be Notified ;1/13/98  12:58
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTIFY ; from FSCLMPN
 N CALL,CALLS,CHOICE,DIR,EVENT,LISTNUM,METHOD,OK,Y K CALLS,DIR,^TMP("FSC SELECT",$J,"NVALUES")
 S DIR(0)="SAMO^EDITED:EDITED;STATUS CHANGED:STATUS CHANGED",DIR("A")="Notify when calls are (E)dited or (S)tatus changes: ",DIR("B")="EDITED"
 S DIR("?",1)="Enter the event that will trigger your notification."
 S DIR("?",2)="Enter EDITED to be notified whenever the calls are edited."
 S DIR("?",3)="Enter STATUS CHANGED to be notified when the calls have a status changed."
 S DIR("?",4)="Enter '^' to exit without scheduling notification or '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S EVENT=Y
 N DIR,Y K DIR
 S DIR(0)="SAMO^MAIL:MAIL;ALERT:ALERT",DIR("A")="Notify by (M)ail or (A)lert: ",DIR("B")="ALERT"
 S DIR("?",1)="Enter the method you wish to be notified."
 S DIR("?",2)="Enter MAIL to receive an email message."
 S DIR("?",3)="Enter ALERT to be notified by a menu alert."
 S DIR("?",4)="Note: scheduled notifications will appear as a single alert, as opposed"
 S DIR("?",5)="to alerts sent by others, which appear as separate alerts."
 S DIR("?",6)="Enter '^' to exit without scheduling notification, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S METHOD=Y
 D
 .I $D(^TMP("FSC SELECT",$J,"EVALUES")) S CHOICE=FSCCNT_"-"_FSCCNT Q
 .I $D(^TMP("FSC SELECT",$J,"VVALUES")) S CHOICE=^("VVALUES") Q
 .S CHOICE="1-"_+@VALMAR
 D SELECT^FSCUL(CHOICE,"",CHOICE,"NVALUES",.OK)
 I OK D
 .S LISTNUM=0 F  S LISTNUM=$O(^TMP("FSC SELECT",$J,"NVALUES",LISTNUM)) Q:LISTNUM<1  S CALL=$$CALL^FSCLMPE1(LISTNUM),CALLS(CALL)=""
 .D BENOTIFY(DUZ,.CALLS,METHOD,EVENT)
 Q
 ;
BENOTIFY(USER,CALLS,METHOD,EVENT) ; from FSCELSNS
 N CALL,NUM
 S CALL=0 F  S CALL=$O(CALLS(CALL)) Q:CALL<1  D
 .I $D(^FSCD("NOTIFY","ACUSER",CALL,USER)) S NUM=+^(USER) D  Q
 ..S $P(^FSCD("NOTIFY",NUM,0),U,5,7)=METHOD_U_EVENT_U_1
 .D SETUP^FSCNOT(CALL,,,USER_U_1,METHOD,EVENT)
 Q
