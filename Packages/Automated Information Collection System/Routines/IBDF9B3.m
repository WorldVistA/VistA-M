IBDF9B3 ;ALB/CJM - ENCOUNTER FORM - (edit,delete,add data fields) ;FEB 1,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
LABELS ;Create, Edit, or Delete LABELS from the form
 I Y="I" D LABELS^IBDF9B3 Q
 ;
 N IBVALMBG,QUIT
 S QUIT=0
 S IBVALMBG=VALMBG
 S VALMBCK="R"
 ;
 F  D  Q:QUIT
 .D FULL^VALM1
 .K DIR S DIR("?",1)="You can Create, Edit, or Delete labels, Shift all of the labels AND data",DIR("?")="fields within a range up or down."
 .W !!,DIR("?",1),!,DIR("?"),!
 .S DIR("B")="C",DIR(0)="SB^C:Create;E:Edit;D:Delete;S:Shift;Q:Quit",DIR("A")="[C]reate,  [D]elete,  [E]dit,   [S]hift,  [Q]uit"
 .D ^DIR K DIR I $D(DIRUT)!(Y<0) S QUIT=1 Q
 .I Y="Q" S QUIT=1 Q
 .D @$S(Y="C":"NEWFLD",Y="E":"EDITFLD",Y="D":"DLTFLD",Y="S":"SHIFT",1:"")
 .D RE^VALM4
 S VALMBCK="R",VALMBG=IBVALMBG
 Q
SHIFT ;expects IBBLK to be defined - shifts all fields within range supplied by user
 D SHIFT^IBDF10("D")
 D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
EDITFLD ;expects IBBLK to be defined
 N IBFIELD,NOD
 N IBI,IBOLD,IBX,IBY,IBW,IBDELETE ;these are used in the input template
 D SELECT
 I IBFIELD D
 .D RE^VALM4
 .S IBOLD=1,(IBX,IBY)=""
 .K DR,DIE,DA S DIE=357.5,DA=IBFIELD,DR="[IBDF EDIT LABEL FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
SELECT ;
 S IBFIELD=0
 Q:'$G(IBBLK)
 I '$O(^IBE(357.5,"C",IBBLK,0)) W !,"There is no label only field!" D PAUSE^IBDFU5 Q
AGAIN K DIC S DIC="^IBE(357.5,",DIC(0)="EFQ",DIC("B")="",D="C",X=IBBLK
 S DIC("S")="I $P(^(0),U,2)=IBBLK,+$P(^(0),U,3)=0"
 D IX^DIC K DIC
 S:+Y>0 IBFIELD=+Y
 I 'IBFIELD,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No label selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
DLTFLD ;expects IBBLK to be defined
 N IBFIELD
 D SELECT
 I IBFIELD D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.5,IBFIELD,0)),"^"))
 .D DLTFLD^IBDFU3(357.5,IBBLK,IBFIELD)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWFLD ;adds a new field, expects IBBLK to be defined
 N NAME,FIELD,NODE,IBRTN,DLAYGO
 N IBX,IBY,IBW,IBDELETE,IBOLD ;these are used in the input template
 S NAME=$$NEWNAME^IBDF9B Q:NAME=-1
 S IBOLD=0,(IBX,IBY)=""
 K DIC,DIE,DD,DO,DINUM S DIC="^IBE(357.5,",DIC(0)="FL",X=NAME,DLAYGO=357.5
 D FILE^DICN K DIC,DIE,DA
 S FIELD=$S(+Y<0:"",1:+Y)
 I 'FIELD D
 .W !,"Unable to create a new label!" D PAUSE^IBDFU5
 I FIELD D
 .S IBDELETE=1
 .D RE^VALM4
 .K DIE,DA,DR S DIE=357.5,DA=FIELD,DR="[IBDF EDIT LABEL FIELD]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA,DIC
 .I IBDELETE K DA S DIK="^IBE(357.5,",DA=FIELD D ^DIK K DIK,DA Q
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
