IBDF9D ;ALB/CJM - ENCOUNTER FORM (create/edit/delete lines);MARCH 20, 1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
LINE ;Create, Edit, or Delete a line on the block
 S VALMBCK="R"
 K DIR S DIR("?",1)="You can add vertical or horizontal lines to the block, or edit or delete",DIR("?")="a line already there IF it was created through this action."
 S DIR("B")="C",DIR(0)="SB^C:Create;E:Edit;D:Delete",DIR("A")="[C]reate , [D]elete, or [E]dit a line"
 D ^DIR K DIR I $D(DIRUT)!(Y<0) Q
 D @$S(Y="C":"NEWLINE",Y="E":"EDITLINE",Y="D":"DLTLINE",1:"")
 S VALMBCK="R"
 Q
EDITLINE ;expects IBBLK to be defined - edits an already existing line
 N IBLINE,IBDFDONE
 ;IBDFDONE is used in the imput template
 D FULL^VALM1
 D SELECT
 I IBLINE D
 .D RE^VALM4
 .K DIE,DA S DIE=357.7,DA=IBLINE,DR="[IBDF FORM LINE]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
SELECT ;select a line on the block
 S IBLINE=0
 Q:'$G(IBBLK)
 I '$O(^IBE(357.7,"C",IBBLK,0)) W !,"There is no line!" D PAUSE^IBDFU5 Q
AGAIN K DIC S DIC="^IBE(357.7,",DIC(0)="EFQ",DIC("B")="",D="C",X=IBBLK
 S DIC("S")="I $P($G(^(0)),U,6)=IBBLK"
 D IX^DIC K DIC
 S:+Y>0 IBLINE=+Y
 I 'IBLINE,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No data line selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
DLTLINE ;expects IBBLK to be defined - deletes one of the blocks lines
 N IBLINE
 D FULL^VALM1
 D SELECT
 I IBLINE D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.7,IBLINE,0)),"^"))
 .D DLTLINE^IBDFU3(357.7,IBBLK,IBLINE)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWLINE ;adds a new line, expects IBBLK to be defined
 N IBLINE,NODE,IBDFDONE,DLAYGO
 ;IBDONE - a flag used in the input template to indicate if the input template was completed - delete the line if not completed
 ;S NAME=$$NEWNAME Q:NAME=-1
 K DIC,DIE,DD,DO,DINUM S DIC="^IBE(357.7,",DIC(0)="FL",X="NAME",DLAYGO=357.7
 D FILE^DICN K DIC,DIE,DA,DO
 S IBLINE=+Y
 I 'IBLINE D
 .W !,"Unable to create a new line!" D PAUSE^IBDFU5
 I IBLINE D
 .K DIE,DA S DIE=357.7,DA=IBLINE,DR="[IBDF FORM LINE]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .I 'IBDFDONE K DA S DIK="^IBE(357.7,",DA=IBLINE D ^DIK K DIK Q
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWNAME(IBLINE) ;
 N NODE,NAME S NODE=$G(^IBE(357.7,IBLINE,0))
 Q:NODE="" "LINE"
 S NAME=$P(NODE,"^",4)_"("_(+$P(NODE,"^",3)+1)_","_(+$P(NODE,"^",2)+1)_")"
 Q NAME
MAXLEN() ;returns the maximum length of the line=IBLINE that will fit in the block=IBBLK
 N LEN,TYPE,NODE,POS
 S NODE=$G(^IBE(357.7,IBLINE,0))
 S TYPE=$P(NODE,"^",4)
 S POS=$S(TYPE="H":$P(NODE,"^",2),1:$P(NODE,"^",3))
 Q ((1+$S(TYPE="H":$$MAXX^IBDFU1B,1:$$MAXY^IBDFU1B))-POS)
 ;
TOOMANY() ;are there too many lines in the box? returns 0 or 1
 ;IBBLK is assumed to be defined=the block
 N SPACING,NODE,START,NUMBER
 Q:'$G(IBLINE) 0
 Q:'$G(IBBLK) 0
 S NODE=$G(^IBE(357.7,IBLINE,0))
 S START=$P(NODE,"^",3),SPACING=$P(NODE,"^",8),NUMBER=$P(NODE,"^",7)
 S SPACING=$S(SPACING="d":2,SPACING="t":3,1:1)
 I (START+(SPACING*NUMBER)-(SPACING-1))>$$MAXY^IBDFU1B
 Q $T
