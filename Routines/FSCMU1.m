FSCMU1 ;SLC/STAFF-NOIS Modify Utilities continued ;4/22/94  11:44
 ;;1.1;NOIS;;Sep 06, 1998
 ;
METHOD(OLD,NEW,OK) ; from FSCLD
 I $L(OLD),'(OLD="MAIL"!(OLD="ALERT")) S NEW="",OK=1 Q
 S NEW="",OK=1
 N DIR,Y K DIR
 S DIR(0)="SAMO^MAIL:MAIL;ALERT:ALERT",DIR("A")="Select (M)ail or (A)lert: " I $L(OLD) S DIR("B")=$S(OLD="MAIL":"MAIL",OLD="ALERT":"ALERT",1:"")
 S DIR("?",1)="Enter MAIL for notification to be sent by mail."
 S DIR("?",2)="Enter ALERT for notification to be sent by menu alert."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 W !,"Notification Method"
 D ^DIR K DIR
 I $D(DIRUT) S:$D(DTOUT) OK=0 Q
 S NEW=Y
 Q
 ;
EVENT(OLD,NEW,OK) ; from FSCLD
 I $L(OLD),'(OLD="EDITED"!(OLD="STATUS CHANGED")!(OLD="ADDED")) S NEW="",OK=1 Q
 S NEW="",OK=1
 N DIR,Y K DIR
 S DIR(0)="SAMO^EDITED:EDITED;STATUS CHANGED:STATUS CHANGED;ADDED:ADDED",DIR("A")="Select when (E)dited, (S)tatus Changed, or (A)dded to list: "
 I $L(OLD) S DIR("B")=$S(OLD="EDITED":OLD,OLD="STATUS CHANGED":OLD,OLD="ADDED":OLD,1:"")
 S DIR("?",1)="Enter EDITED for notification to occur when the call is edited."
 S DIR("?",2)="Enter STATUS CHANGED for notification to occur when the status changes."
 S DIR("?",3)="Enter ADDED for notification to only occur when added to the list."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 W !,"Notification Event"
 D ^DIR K DIR
 I $D(DIRUT) S:$D(DTOUT) OK=1 Q
 S NEW=Y
 Q
 ;
DESC(LISTNUM,NEW,OK) ; from FSCLD
 N CNT,OLD K OLD,NEW S OK=0
 S CNT=0 F  S CNT=$O(^FSC("LIST",+LISTNUM,2,CNT)) Q:CNT<1  S (NEW(CNT,0),OLD(CNT,0))=^(CNT,0)
 D EDITWP^FSCEU("NEW","List Description:")
 I $D(DTOUT) S OK="" Q
 I $O(OLD(0)),'$O(NEW(0)) S NEW=0 ; wp entry was deleted
 S CNT=0 F  S CNT=$O(NEW(CNT)) Q:CNT<1  I NEW(CNT,0)'=$G(OLD(CNT,0)) S OK=1 Q
 I $O(NEW("A"),-1)'=$O(OLD("A"),-1) S OK=1 Q
 Q
