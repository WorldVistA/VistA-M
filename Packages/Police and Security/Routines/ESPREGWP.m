ESPREGWP ;;ALB/CJM-ESP POLICE REGISTRATION ;1/19/1997
 ;;1.0;POLICE & SECURITY;**17**;Mar 31, 1994
 ;
REGISTER(REGTYPE) ;
 ;selects or creates a registration, then edits it
 N NAME,NEW,DIC,DIE,DA,DR,DLAYGO
 Q:(($G(REGTYPE)'=2)&($G(REGTYPE)'=3)&($G(REGTYPE)'=4)&($G(REGTYPE)'=5))
 ;
 S DIC=910.2,DIC(0)="AELMQ",DLAYGO=910.2
 S DIC("S")="I $P(^(0),U,4)="_REGTYPE
 D ^DIC
 S REG=+Y,NEW=$P(Y,"^",3)
 I REG D EDITREG(REG,REGTYPE,NEW)
 Q
 ;
EDITREG(REG,REGTYPE,NEW) ;
 N DIE,DA,DR,DLAYGO,DIC
 S DIE=910.2,DA=REG,DR="[ESP REGISTRATION "_REGTYPE_"]",DLAYGO=910.2
 D ^DIE
 I $D(Y) D
 .I NEW D DELETE(REG)
 E  D
 .S NAME=$$GETNAME
 .I NAME S DR=".03////^S X=NAME" D ^DIE
 Q
 ;
GETNAME() ;
 ;allows selection from Master Name Index file or creation of new name
 ;returns ien, or 0 if none selected
 ;
 N DIC,D,DINUM,DR,X,DLAYGO,DIR,Y,QUIT,NEW,NAME
 S (QUIT,NEW,NAME)=0
 F  Q:QUIT  D
 .W !!,"Who should it be registered to?",!!
 .S DIC="^ESP(910,",DIC(0)="AELMQ",DLAYGO=910,DIC("A")="Enter Registrant: "
 .D ^DIC
 .S NAME=$S(+Y<0:0,1:+Y)
 .I 'NAME S QUIT=1 Q
 .S NEW=$P(Y,"^",3)
 .I NEW S QUIT=1 Q
 .I 'NEW D
 ..N DIR
 ..S DIR(0)="Y"
 ..S DIR("A")="You wish to select "_$P(Y,"^",2)_" as the registrant"
 ..S DIR("B")="YES"
 ..D ^DIR
 ..I Y S QUIT=1
 ..E  S NAME=0 W !,"Another person with the same name can be entered by using quotes!"
 D:NAME EDITNAME(NAME)
 Q NAME
 ;
EDITNAME(NAME) ;
 ;allows user to edit entry in the Master Name Index file
 ;INPUT -
 ;  NAME - ien in Master Name Index file
 ;
 N DIE,DA,DR,DLAYGO,DIC
 S DIE=910,DA=NAME,DR="[ESP REGISTRATION]",DLAYGO=910
 D ^DIE
 Q
 ;
DELETE(NAME) ;
 N DIK,DA
 S DIK="^ESP(910.2,",DA=NAME
 D ^DIK
 W !,"** TAG DELETED FROM POLICE REGISTRATION LOG **"
 Q
