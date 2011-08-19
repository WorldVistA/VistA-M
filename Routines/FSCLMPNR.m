FSCLMPNR ;SLC/STAFF NOIS List Manager Protocol Notification Remove ;11/29/95  11:02
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NOTIFY ; from FSCLMPN
 N CALL,CHOICE,DA,DIK,DIR,LISTNUM,OK,Y K DIR,^TMP("FSC SELECT CALLS",$J)
 D
 .I $D(^TMP("FSC SELECT",$J,"EVALUES")) S CHOICE=FSCCNT_"-"_FSCCNT Q
 .I $D(^TMP("FSC SELECT",$J,"VVALUES")) S CHOICE=^("VVALUES") Q
 .S CHOICE="1-"_+@VALMAR
 D SELECT^FSCUL(CHOICE,"",CHOICE,"NVALUES",.OK)
 I 'OK Q
 S LISTNUM=0 F  S LISTNUM=$O(^TMP("FSC SELECT",$J,"NVALUES",LISTNUM)) Q:LISTNUM<1  S CALL=$$CALL^FSCLMPE1(LISTNUM),^TMP("FSC SELECT CALLS",$J,CALL)=""
 I '$O(^TMP("FSC SELECT CALLS",$J,0)) Q
 S DIR(0)="YAO",DIR("A")="Remove notifications: ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to remove notifications on calls you have scheduled to be noitied on."
 S DIR("?",2)="Enter NO or '^' to exit without removing notifications, '??' for more help."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 I Y'=1 Q
 W !
 S DIK="^FSCD(""NOTIFY"","
 S CALL=0 F  S CALL=$O(^TMP("FSC SELECT CALLS",$J,CALL)) Q:CALL<1  D
 .K ^TMP("FSC NOTIFY",$J)
 .D NOTINFO^FSCNOT(CALL,DUZ)
 .S DA=0 F  S DA=$O(^TMP("FSC NOTIFY",$J,DA)) Q:DA<1  D ^DIK
 K ^TMP("FSC NOTIFY",$J)
 W !,"Scheduled notifications have been removed." H 2
 Q
