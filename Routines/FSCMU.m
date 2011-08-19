FSCMU ;SLC/STAFF-NOIS Modify Utilities ;1/13/98  13:19
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NAME(OLD,NEW,OK) ; from FSCLD, FSCLDR, FSCLMPS
 N DONE,NAME S (DONE,OK)=0,(NAME,NEW)=""
 F  D  Q:DONE
 .N DIR,Y K DIR
 .S DIR(0)="7107.1,.01AO",DIR("A")="List Name: " I $L(OLD) S DIR("B")=OLD
 .S DIR("?",1)="Enter the name of the list."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .S NAME=Y
 .I $L(OLD),X="@" S (NAME,NEW)="@" D WARNING(OLD,.OK) S:OK DONE=1 Q
 .I $D(DIRUT) S DONE=1 Q
 .I '$L(OLD),$D(^FSC("LIST","B",NAME)) W !,NAME," already exists.  Enter a new name.",$C(7) Q
 .S NEW=NAME,(DONE,OK)=1
 Q
 ;
WARNING(LISTNAME,OK) ; from FSCLMPM
 N DIR,Y K DIR S OK=0
 S DIR(0)="YAO",DIR("A")="Are you sure you want to delete "_LISTNAME_"? ",DIR("B")="NO"
 S DIR("?",1)="Deleting a list will remove it's use from all users."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 W $C(7) D ^DIR K DIR
 I $D(DIRUT) Q
 I Y=1 D
 .N DIR K DIR
 .S DIR(0)="YAO",DIR("A",1)="Deleting this list will also remove all calls from the list.",DIR("A")="Do you still want to delete "_LISTNAME_"? ",DIR("B")="NO"
 .S DIR("?",1)="Enter YES to delete the list."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .W $C(7) D ^DIR K DIR
 .I $D(DIRUT) Q
 .I Y=1 S OK=1
 Q
 ;
OWNER(OLD,NEW,OK) ; from FSCLD, FSCLDR, FSCLMPS
 S NEW="",OK=0
 I '$P($G(^FSC("SPEC",DUZ,0)),U,7) S NEW=DUZ,OK=1 Q
 N DIR,Y K DIR
 S DIR(0)="PAO^200:EM",DIR("A")="Owner: " I $L(OLD) S DIR("B")=$$VALUE^FSCGET(+OLD,7107.1,1)
 S DIR("?",1)="Enter the owner for this list."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S NEW=+Y,OK=1
 Q
 ;
TYPE(OLD,NEW,OK) ; from FSCLD
 I $L(OLD),'(OLD="A"!(OLD="M")!(OLD="S")) S NEW="",OK=1 Q
 S NEW="",OK=0
 N DIR,Y K DIR
 S DIR(0)="SAM^ACTIVE UPDATE:ACTIVE UPDATE;MANUAL UPDATE:MANUAL UPDATE;STORE ONLY:STORE ONLY",DIR("A")="Select (A)ctive Update (M)anual Update or (S)tore Only: " I $L(OLD) S DIR("B")=$S(OLD="A":"ACTIVE UPDATE",OLD="S":"STORE ONLY",1:"")
 S DIR("?",1)="Enter ACTIVE UPDATE for lists using a query criteria that update whenever."
 S DIR("?",2)="calls are edited (these lists are typically used for alerts)."
 S DIR("?",3)="Enter MANUAL UPDATE for lists using a query criteria that update when used."
 S DIR("?",4)="Enter STORE ONLY for lists used for storing calls (manually stored)."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I $D(DIRUT) Q
 S NEW=$S(Y="ACTIVE UPDATE":"A",Y="MANUAL UPDATE":"M",Y="STORE ONLY":"S",1:""),OK=1
 Q
