IBDF9B2 ;ALB/CJM - ENCOUNTER FORM - (edit,delete,add multiple choice fields) ;JUL 20,1994
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
MFIELD ;Create, Edit, or Delete a multiple choice field from the form
 ;
 N IBVALMBG,QUIT
 S IBVALMBG=VALMBG
 S QUIT=0
 S VALMBCK="R"
 ;
 F  D  Q:QUIT
 .D FULL^VALM1
 .K DIR S DIR("?",1)="You can Create, Edit, or Delete a multiple choice field, or Shift all of the",DIR("?")="multiple choice fields within a definable range either up or down."
 .W !!,DIR("?",1),!,DIR("?"),!
 .S DIR("B")="C",DIR(0)="SB^C:Create;E:Edit;D:Delete;S:Shift;Q:Quit",DIR("A")="[C]reate,   [D]elete,   [E]dit,   [S]hift,   [Q]uit"
 .D ^DIR K DIR I $D(DIRUT)!(Y<0) S QUIT=1 Q
 .I Y="Q" S QUIT=1 Q
 .D @$S(Y="C":"NEWFLD",Y="E":"EDITFLD",Y="D":"DLTFLD",Y="S":"SHIFT",1:"")
 .D RE^VALM4
 .D FULL^VALM1
 S VALMBCK="R",VALMBG=IBVALMBG
 Q
SHIFT ;expects IBBLK to be defined - shifts all input fields within range supplied by user
 D SHIFT^IBDF10("M")
 D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
EDITFLD ;expects IBBLK to be defined
 N IBFIELD,RTN,NODE
 N IBOLD,IBX,IBY,IBLEN,IBTYPE,IBLABEL,IBQUAL,IBID ;these are used in the input template
 D SELECT
 I IBFIELD D
 .D RE^VALM4
 .S (IBX,IBY,IBLEN)=0
 .S IBOLD=1,IBTYPE=$P($G(^IBE(357.93,IBFIELD,0)),"^",6)
 .K DR,DIE,DA S DIE=357.93,DA=IBFIELD,DR="[IBDF EDIT MULT CHOICE FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA,DIC
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
SELECT ;
 S IBFIELD=0
 Q:'$G(IBBLK)
 I '$O(^IBE(357.93,"C",IBBLK,0)) W !,"There is no multiple choice field!" D PAUSE^IBDFU5 Q
AGAIN K DIC S DIC="^IBE(357.93,",DIC(0)="EFQ",DIC("B")="",D="C",X=IBBLK
 S DIC("S")="I $P($G(^(0)),U,8)=IBBLK"
 D IX^DIC K DIC
 S:+Y>0 IBFIELD=+Y
 I 'IBFIELD,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No multiple choice field selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
DLTFLD ;expects IBBLK to be defined
 N IBFIELD
 D SELECT
 I IBFIELD D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.93,IBFIELD,0)),"^"))
 .D DLTIFLD^IBDFU3(357.93,IBBLK,IBFIELD)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWFLD ;adds a new field, expects IBBLK to be defined
 N NAME,FIELD,NODE,IBRTN,DLAYGO
 N IBX,IBY,IBLEN,IBOLD,IBTYPE,IBLABEL,IBQUAL,IBID ;these are used in the input template
 S NAME=$$NEWNAME^IBDF9B
 Q:NAME=-1
 S IBOLD=0,(IBX,IBY,IBLEN)=""
 K DIC,DIE,DD,DO,DINUM S DIC="^IBE(357.93,",DIC(0)="FL",X=NAME,DLAYGO=357.93
 D FILE^DICN K DIC,DIE,DA
 S FIELD=$S(+Y<0:"",1:+Y)
 I 'FIELD D
 .W !,"Unable to create a new input field!" D PAUSE^IBDFU5
 I FIELD D
 .K DIE,DA,DR S DIE=357.93,DA=FIELD,DR="[IBDF EDIT MULT CHOICE FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA,DIC
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
