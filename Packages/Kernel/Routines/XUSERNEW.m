XUSERNEW ;SF/RWF - ADD NEW USER ;5/13/08  17:19
 ;;8.0;KERNEL;**16,49,134,208,157,313,351,419,467,480**;Jul 10, 1995;Build 38
 ;;Per VHA Directive 2004-038, this routine should not be modified
 ;In the call to NEW^XM for new users the variable XMZ must be undef.
 ;on a reactivation XMZ should be set to the current max message number.
EN ;Add
 N Y,XUN,DR,DIE,DA,DTOUT,DIWF,XMDT,XMM,XMZ
 S Y=$$ADD("","",1) G EXIT:Y'>0,RE:$P(Y,U,3)'=1
 S XUN=+Y ;XU USER ADD called in $$ADD
 S DR="["_$$GET^XUPARAM("XUNEW USER","N")_"]"
 S DIE=200,DA=XUN D XUDIE^XUS5 G:$D(DTOUT) EXIT
 I $$GET1^DIQ(200,XUN_",",11,"I")="" W !,"Without a VERIFY code the user will not be able to sign-on!",$C(7),!
 S Y=XUN K XMZ D NEW^XM K XMDT,XMM,XMZ
 ;ACCESS LETTER, Also see XUSERBLK
 W ! D LETTER(XUN,1)
 K DIR,DIWF,XUTEXT
 ;
 ;Fall in from above, called from REACT
KEYS N DIR,XQHOLD,XQKEY,XQDA,XQAL,XQ6,XQFL
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to allocate security keys" D ^DIR G:$D(DIRUT) EXIT
 I Y=1 S XQHOLD(XUN)="",XQKEY(0)=0,XQDA=0,XQAL=1,XQ6="",XQFL="" D KEY^XQ6
 ;
 ;Check on adding this user to user groups
 I $P(^VA(200,XUN,0),U,3)'="" D  ;Must have access code & mailbox
 .N DIR,Y
 .S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you wish to add this user to mail groups" D ^DIR Q:$D(DIRUT)
 .I Y=1 D ENLOCAL1^XMVGRP(XUN)
 .K XMDUN,XMDUZ,XMV
 .Q
 ;
EXIT K D0,DA,DDER,DDSFILE,DIE,DIC,DIR,DI,DICR,DIG,DIH,DISYS,DIU,DIV,DIWT,DLAYGO,DR,DQ,K,I,X,X1,XQHOLD,XQKEY,XUN,XUSOLD,XMB,XMZ,Y,Z,XQ6,XQFL,DTOUT
 Q
 ;
RE ;Jump from new user to reactivate
 S XUN=+Y,DIR("A")="This isn't a new user, Want to reactivate?",DIR(0)="Y",DIR("B")="NO"
 D ^DIR
 G EXIT:$D(DIRUT)!(Y'=1),RE2
 ;Reactivate a user
REACT ;SEA/WDE-REACTIVATE A USER
 N XUN,XUSOLD,DIE,DIC,DA,DR,FDA
 S XUN=+$$LOOKUP^XUSER G EXIT:XUN<0
RE2 S XUSOLD=^VA(200,XUN,0)
 S FDA(200,XUN_",",9.2)="@" ;Clear the Termination date
 D UPDATE^DIE("E","FDA")
 ;Show the screanman form
 S DIE=200,DR="["_$$GET^XUPARAM("XUREACT USER","N")_"]",DA=XUN
 D XUDIE^XUS5 G:$D(DTOUT) EXIT
 I $P(^VA(200,XUN,0),U,3)="" W !!,"No ACCESS CODE has been entered.",$C(7),!
 I $P(^VA(200,XUN,0),U,11)>0,$P(^(0),U,11)'>DT W !!,"User is still TERMINATED.",$C(7),!
 I $$GET1^DIQ(200,XUN_",",11,"I")="" W !,"Without a VERIFY code the user will not be able to sign-on!",$C(7),!
 N DIR
 S DIR(0)="Y",DIR("A")="Deny access to old mail messages",DIR("B")="NO",DIR("?")="Enter a 'YES' to restrict access to old mail messages."
 D ^DIR G:$D(DIRUT) EXIT
 K XMZ S:Y=1 XMZ=+$P(^XMB(3.9,0),"^",3) S Y=XUN D NEW^XM K XMDT,XMM,XMZ
 D REACT^XQ84(XUN) ;See if this user's menu trees need to be rebuilt
 G KEYS
 Q
 ;
ADD(NP1,KEYS,NONC) ;Common point to do DIC call for adding a new person.
 ;NP1 will be added to the default or what comes from the NPI field or the KSP.
 ;KEYS is a list of Keys to give the new person
 N DA,DR,DLAYGO,XUITNAME,XUS1,XUS2,DIC,DIE,DIK,NP2,Y
 I $G(^XTV(8989.3,1,"NPI"))]"" X ^("NPI") S NP2=DR
 S:'$D(NP2) NP2="1;"_$S($D(^XUSEC("XUSPF200",DUZ)):9,1:"9R~")_";4;41.99"
 ;";41.99" is for adding National Provider Identifier
 S DIC="^VA(200,",DIC(0)="AELMQ",DLAYGO=200,DIC("A")="Enter NEW PERSON's name (Family,Given Middle Suffix): ",DIC("DR")="",XUITNAME=1
 D ^DIC S XUS1=Y G AX:(Y'>0)!($P(Y,U,3)'>0)
 S DA=+$G(^VA(200,+XUS1,3.1)) I DA,'$G(NONC) D
 . W !,"Name components."
 . S DIE="^VA(20,",DR="1;2;3;5"
 . L +^VA(20,DA,0):60 D ^DIE L -^VA(20,DA,0)
 . I $D(Y)!$D(DTOUT) S DA=+XUS1,XUS1=-1
 . E  S $P(XUS1,U,2)=$P(^VA(200,+XUS1,0),U)
 D:XUS1>0
 . W !,"Now for the Identifiers."
 . S DA=+XUS1,DIE="^VA(200,",DR=NP2_$S($D(NP1):";"_NP1,1:""),DIE("NO^")="OUTOK"
 . L +^VA(200,DA,0):60 D ^DIE L -^VA(200,DA,0)
 . S:$D(Y)!$D(DTOUT) XUS1=-1
 I XUS1<0 D  S XUS1=-1
 . W !?5,"<'",$P(^VA(200,DA,0),U),"' DELETED>"
 . S DIK="^VA(200," D ^DIK
 . Q:$P($G(^DIC(3,0)),U)'="USER"!'$D(^DD(3,0))
 . S DIK="^DIC(3,",XUS1=$P($G(^DIC(3,DA,0)),U,16) D ^DIK
 . Q:'XUS1!($P($G(^DIC(16,0)),U)'="PERSON")!'$D(^DD(16,0))
 . S DIK="^DIC(16,",DA=XUS1 D ^DIK
 N XUSNPI S XUSNPI=$P($G(^VA(200,DA,"NPI")),"^")
 I XUS1>0,+XUSNPI>0 D
 . S XUSNPI=$$ADDNPI^XUSNPI("Individual_ID",DA,XUSNPI,$$NOW^XLFDT(),1) ;add NPI to multiple
 . ; Initialize field 41.97 to 1 (YES)
 . Q:+XUSNPI'>0
 . N DIE,DR,DA S DIE="^VA(200,",DA=+XUS1,DR="41.97////1" D ^DIE
 . Q
 I XUS1>0,$D(KEYS) F XUS2=1:1 S Y=$P(KEYS,",",XUS2) Q:'$L(Y)  D
 . S %=$$ADD^XQKEY(XUS1,Y) I '% W !,"Key '",Y,"' not allocated"
 I XUS1>0 D CALL^XUSERP(+XUS1,1) ;XQOR add
AX Q XUS1
 ;
REPRINT ;Reprint letter
 S DA=+$$LOOKUP^XUSER G EXIT:DA'>0
 D LETTER(DA)
 G EXIT
 ;
LETTER(XUN,ASK) ;Print access letter
 Q:'$G(XUN)
 N DIWF,FR,TO,BY,DIR,XUTEXT
 S XUTEXT=$$GET^XUPARAM("XUSER COMPUTER ACCOUNT","N"),XUTEXT=$O(^DIC(9.2,"B",XUTEXT,0))
 S DIR(0)="Y",DIR("A")="Print User Account Access Letter"
 I XUTEXT>0 S Y=1 D:$G(ASK) ^DIR I Y=1 D
 . S (XUU,XUU2)="________",DIWF="^DIC(9.2,XUTEXT,1,",DIWF(1)=200,FR=XUN,TO=XUN,BY="NUMBER" D EN2^DIWF
 . Q
 Q
