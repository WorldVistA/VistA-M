FSCUM ;SLC/STAFF-NOIS Utilities Maintenance ;9/27/96  17:26
 ;;1.1;NOIS;;Sep 06, 1998
 ;
DELETE ; from programmer
 N CALL,CALLNAME,DIC,X,Y K DIC
 S DIC=7100,DIC(0)="AEMOQ",DIC("A")="Select NOIS call to be deleted: "
 D ^DIC Q:Y<1
 K DIC
 S CALL=+Y,CALLNAME=$P(Y,U,2)
 N DIR,X,Y
 W !!,CALL,!,CALLNAME
 Q
 ;
PURGE ;
 K ^TMP("FSC PURGE",$J)
 N LIST,NUM,OK
 D WARNING(.OK)
 I 'OK D NOTDONE Q
 D LIST(.LIST,.NUM,.OK)
 I 'OK D NOTDONE Q
 I 'NUM W !,"No calls on this list.",! Q
 W !,NUM," calls will be deleted."
 D ASK(.OK)
 I 'OK D NOTDONE Q
 D WIPEOUT
 K ^TMP("FSC PURGE",$J)
 Q
 ;
WARNING(OK) ;
 N DIR,X,Y K DIR
 S OK=0
 W !,"WARNING!!!! This option is used to PURGE calls.",$C(7),!
 S DIR(0)="YA0",DIR("A")="Are you sure you want to do this? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to get a list to purge."
 S DIR("?",2)="Enter or '^' to exit."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y=1 S OK=1
 Q
 ;
LIST(LIST,NUM,OK) ;
 S LIST="",(NUM,OK)=0
 N CALL,LIMIT
 D LIST^FSCULOOK(.LIST,.LIMIT,.OK)
 I 'OK Q
 S LIST=+LIST
 S CALL=0 F  S CALL=$O(^FSCD("LISTS","ALC",LIST,CALL)) Q:CALL<1  D
 .S ^TMP("FSC PURGE",$J,CALL)=""
 .S NUM=NUM+1
 Q
 ;
ASK(OK) ;
 N DIR,X,Y K DIR
 S OK=0
 W !,"WARNING!!!! This will purge the calls in this list.",$C(7),!
 S DIR(0)="YA0",DIR("A")="Are you sure you want to do this? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to purge these calls."
 S DIR("?",2)="Enter or '^' to exit."
 S DIR("?")="^D HELP^FSCU(.DIR)"
 S DIR("??")="FSC U1 NOIS"
 D ^DIR K DIR
 I Y=1 S OK=1
 Q
 ;
WIPEOUT ;
 N CALL
 S CALL=0 F  S CALL=$O(^TMP("FSC PURGE",$J,CALL)) Q:CALL<1  D
 .W !,$P($G(^FSCD("CALL",CALL,0)),U)
 .Q  ; ****
 .M ^FSCD("ZZPURGE",CALL)=^FSCD("CALL",CALL)
 .D DELETE^FSCUCD(CALL)
 Q
 ;
NOTDONE ;
 W !,"No calls were purged."
 Q
