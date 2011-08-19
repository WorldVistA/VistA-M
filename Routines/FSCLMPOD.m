FSCLMPOD ;SLC/STAFF-NOIS List Manager Protocol Other Defaults ;1/13/98  13:01
 ;;1.1;NOIS;;Sep 06, 1998
 ;
NONSPEC(USER) ; from FSCLMPO
 N DA,DIC,DR,DIE,OK,SPEC,Y K DIC
 S OK=1
 I '$D(^FSC("SPEC",USER,0)) D  Q
 .W !
 .W !,"You currently have no package affiliations."
 .W !,"By affiliating with a package, you will automatically receive alerts"
 .W !,"whenever a call for that package is edited."
 .W !,"You may affiliate with multiple packages."
 .W !,"You can use User Defaults to edit, delete, or add packages."
 .W !
 .N DIR,X,Y K DIR
 .S DIR(0)="YA0",DIR("A")="Do you want to set up package affiliations? ",DIR("B")="YES"
 .S DIR("?",1)="Enter YES to set up package affiliations."
 .S DIR("?",2)="Enter NO to exit."
 .S DIR("?",3)="Enter '^' or '??' for more help."
 .S DIR("?")="^D HELP^FSCU(.DIR)"
 .S DIR("??")="FSC U1 NOIS"
 .D ^DIR K DIR
 .I Y'=1 Q
 .D SETUP(USER,.OK) I 'OK D UNABLE
 W ! S (DIC,DIE)="^FSC(""SPEC"","
 S (DA,SPEC)=+DUZ D EN^DIQ
 I '$O(^FSC("SPEC",USER,30,0)) W !,"You are currently not affiliated with any packages."
 W ! S DR="30"
 L +^FSC("SPEC",SPEC):30 I '$T D UNABLE Q
 D ^DIE
 L -^FSC("SPEC",SPEC)
 K DIC
 S VALMBCK=$S($G(FSCEXIT):"Q",1:"R")
 Q
 ;
SETUP(USER,OK) ;
 N DA,DIE,DR
 L +^FSC("SPEC",0):30 I '$T S OK=0 Q
 S $P(^FSC("SPEC",0),U,3)=USER,$P(^(0),U,4)=$P(^(0),U,4)+1
 S ^FSC("SPEC",USER,0)=USER,^FSC("SPEC","B",USER,USER)=""
 L -^FSC("SPEC",0)
 S DA=USER,DIE=7105.2,DR="1///1;10.1///ALERT;10.2///EDITED;10.3///ALL;30"
 L +^FSC("SPEC",USER):30 I '$T S OK=0 Q
 D ^DIE
 L -^FSC("SPEC",USER)
 Q
 ;
UNABLE ;
 W !,"Unable to edit.",$C(7) H 2
 Q
