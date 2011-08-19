XMUDCHR ;ISC-SF/GMB-Christen Site ;04/17/2002  11:48
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; CHRISTEN      XMCHRIS - Edit MailMan Site Parameters
CHRISTEN ;Set up/Change MailMan Site Parameters
 N XMREC,XMABORT
 S XMABORT=0
 S XMREC=$G(^XMB(1,1,0)) I '+XMREC,$O(^XMB(1,0)) G E
 I XMREC="" D
 . D INIT
 E  D
 . D CHANGE
 Q:XMABORT
 D PARENT
 D SCRIPT
 G Q
INIT ; Initial Christening
 N DIC,DIE,Y,DA,XMFDA
 S DIC=4.2,DIC(0)="AEMQ"
 D ^DIC I Y<1 S XMABORT=1 D E1 Q
 S XMFDA(4.3,"+1,",.01)=+Y
 D UPDATE^DIE("","XMFDA")
 K DIC,Y
 S DR="3//FORUM.VA.GOV;1//EST"
 S DIE=4.3,DA=1
 D ^DIE I $D(Y) S XMABORT=1 D E1
 Q
CHANGE ;
 N XMSITE,DIE,DA,DR,DIC,X,Y
 S XMSITE=$S($D(^XMB("NETNAME")):^XMB("NETNAME"),$D(^XMB("NAME")):^XMB("NAME"),$D(^DIC(4.2,+XMREC,0)):$P(^(0),U),1:XMREC)
 I '$$SURE(XMSITE) S XMABORT=1 Q  ; Are you sure?
 S DIC=4.2,DIC(0)="AEMQ",DIC("B")=$S($D(^DIC(4.2,+XMREC,0)):$P(^(0),U),1:XMSITE)
 D ^DIC I Y=-1 S XMABORT=1 Q
 I XMSITE'=$P(Y,U,2) D
 . I +Y=^XMB("NUM") D
 . . ; The domain name in file 4.2 has been changed.
 . . ; The pointer to file 4.2 has stayed the same.
 . . ; The filer won't fire the xrefs, so we need to do it manually
 . . S (^XMB("NETNAME"),^XMB("NAME"))=$P(Y,U,2)
 . E  D
 . . N XMFDA
 . . S XMFDA(4.3,"1,",.01)=+Y
 . . D FILE^DIE("","XMFDA")
 . W !!,"The domain name for this facility is now: ",^XMB("NETNAME")
 E  D
 . W !!,"The domain name for this facility remains: ",^XMB("NETNAME")
 K DIC,Y
 S DR="3//FORUM.VA.GOV;1//EST"
 S DIE=4.3,DA=1
 D ^DIE
 Q
SURE(XMSITE) ;  Function returns 1 if sure; 0 if not
 N DIR,X,Y
 W !!!,"         * * * *  WARNING  * * * *"
 W !!,"You are about to change the domain name of this facility"
 W !,"in the MailMan Site Parameters file."
 W !!,"Currently, this facility is named: ",XMSITE
 W !!,"You must be extremely sure before you proceed!",!
 S DIR("A")="Are you sure you want to change the name of this facility"
 S DIR("B")="NO"
 S DIR(0)="Y"
 D ^DIR Q:Y 1  ; Sure do!
 Q 0  ; Nope, I'm not sure!
PARENT ;
 N XMPARENT
 S XMPARENT=+$G(^XMB("PARENT"))
 I XMPARENT S XMPARENT=$S($D(^DIC(4.2,XMPARENT,0)):$P(^(0),U),1:0)
 I XMPARENT'=0 D
 . W !!,XMPARENT," has been initialized as your 'parent' domain."
 . W !,"(Forum is usually the parent domain, unless this is a subordinate domain.)"
 . W !!,"You may edit the MailMan Site Parameter file to change your parent domain."
 E  D
 . W !!,$C(7),"*** YOUR PARENT DOMAIN HAS NOT BEEN INITIALIZED !!! ***"
 . W !!,"You MUST edit the MailMan Site Parameter file to ENTER your parent domain."
 Q
SCRIPT ;RESET AUSTIN SCRIPT
 ;G SCRIPT^XMYPDOM
 W !!,"We will not initialize your transmission scripts."
 Q
Q W !!,"Use the 'Subroutine editor' option under network management menu to add your"
 W !,"site passwords to the MINIENGINE script, and the 'Edit a script' option"
 W !,"to edit any domain scripts that you choose to."
 ;D ^XMYPDOM
 Q
PMB S Y=Y+1000,^XMB(3.7,.5,2,+Y,1,0)=^TMP("XM",I,1,0),^XMB(3.7,.5,2,"B",$E($P(Y(0),U,1),1,30),+Y)="",^XMB(3.7,.5,2,+Y,0)=$P(Y(0),U)
 F J=0:0 S J=$O(^TMP("XM",I,1,J)) Q:J'>0  S ^XMB(3.7,.5,2,+Y,1,J,0)=J W "."
 Q
E W $C(7),!!,"There is a FILE INTEGRITY problem in your MailMan Site Parameters file",!,"There should only be one entry and that entry should be entry number 1.",!
E1 W $C(7),!,"Your MailMan site parameters MUST be reviewed."
EQ W !!,"Then you can finish the INIT by executing POST^XMYPOST.",! Q
E2 W $C(7),!,"You do not yet have an entry in your MailMan Site Parameters File",!,"Use FileMan to make an entry." G EQ
