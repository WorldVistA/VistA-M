IBDF9E ;ALB/CJM - ENCOUNTER FORM (create/edit/delete text areas);MARCH 20, 1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
TEXT ;Create, Edit, or Delete a text area on a block
 S VALMBCK="R"
 K DIR S DIR("?")="You can add text areas to the block, or edit or delete a text area already there."
 S DIR("B")="C",DIR(0)="SB^C:Create;E:Edit;D:Delete",DIR("A")="[C]reate , [D]elete, or [E]dit a text area"
 D ^DIR K DIR I $D(DIRUT)!(Y<0) Q
 D @$S(Y="C":"NEWTEXT",Y="E":"EDITTEXT",Y="D":"DLTTEXT",1:"")
 S VALMBCK="R"
 Q
EDITTEXT ;expects IBBLK to be defined
 N IBTEXT,IBDELETE
 ;IBDELETE is used in the imput template
 D FULL^VALM1
 D SELECT
 I IBTEXT D
 .D RE^VALM4
 .K DIE,DA S DIE=357.8,DA=IBTEXT,DR="[IBDF EDIT TEXT AREA]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
SELECT ;select a text area on the block
 S IBTEXT=0
 Q:'$G(IBBLK)
 I '$O(^IBE(357.8,"C",IBBLK,0)) W !,"There is no text area!" D PAUSE^IBDFU5 Q
AGAIN S DIC="^IBE(357.8,",DIC(0)="EFQ",DIC("B")="",D="C",X=IBBLK
 D IX^DIC K DIC
 S:+Y>0 IBTEXT=+Y
 I 'IBTEXT,'$D(DTOUT),'$D(DUOUT) K DIR S DIR(0)="Y",DIR("A")="No text area selected! Try again",DIR("B")="YES" D ^DIR K DIR I '$D(DIRUT),Y=1 G AGAIN
 Q
DLTTEXT ;delete a text area - expects IBBLK to be defined
 N IBTEXT
 D FULL^VALM1
 D SELECT
 I IBTEXT D
 .Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.8,IBTEXT,0)),"^"))
 .D DLTTEXT^IBDFU3(357.8,IBBLK,IBTEXT)
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWTEXT ;adds a new text area, expects IBBLK to be defined
 N NAME,IBTEXT,NODE,IBDELETE,DLAYGO
 ;IBDELETE - a flag used in the input template to indicate if the input template was completed - if returns 1 delete the record 
 S NAME=$$NEWNAME Q:NAME=-1
 K DIC,DIE,DD,D0,DINUM S DIC="^IBE(357.8,",DIC(0)="FL",X=NAME,DLAYGO=357.8
 D FILE^DICN K DIC,DIE,DA
 S IBTEXT=$S(+Y<0:"",1:+Y)
 I 'IBTEXT D
 .W !,"Unable to create a text area!" D PAUSE^IBDFU5
 I IBTEXT D
 .K DIE,DA S DIE=357.8,DA=IBTEXT,DR="[IBDF EDIT TEXT AREA]",DIE("NO^")="BACKOUTOK" D ^DIE K DIE,DR,DA
 .I IBDELETE K DA S DIK="^IBE(357.8,",DA=IBTEXT D ^DIK K DIK Q
 .D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
NEWNAME() ;
 K DIR S DIR(0)="357.8,.01A",DIR("A")="New Text Area Name: ",DIR("B")=""
 D ^DIR K DIR I $D(DIRUT) Q -1
 Q Y
FORMAT ;formats the word-processing field of IBTEXT
 N W,HT,NODE,COUNT,LINE
 S NODE=$G(^IBE(357.8,IBTEXT,0))
 S W=$P(NODE,"^",5),HT=$P(NODE,"^",6)
 D FORMAT^IBDFU6("^IBE(357.8,IBTEXT,1)",W) ;creates formated version at ^UTILITY($J,"W",1)
 K ^IBE(357.8,IBTEXT,1)
 I $G(^UTILITY($J,"W",1))>HT W !,"WARNING! The text area is too small to display all of the text." D PAUSE^IBDFU5
 S (COUNT,NUM)=0 F  S NUM=$O(^UTILITY($J,"W",1,NUM)) Q:'NUM  S LINE=$G(^(NUM,0)) D
 .;I $L(LINE)>W W !,"WARNING!  The word "_LINE_" is being truncated",!,"because it is too long." D PAUSE^IBDFU5
 .S ^IBE(357.8,IBTEXT,1,NUM,0)=$E(LINE,1,W)
 .S COUNT=COUNT+1
 S ^IBE(357.8,IBTEXT,1,0)="^^"_COUNT_"^"_COUNT_"^"_DT_"^^^^"
 K ^UTILITY($J,"W")
 Q
MAXHT() ;returns the maximum ht. of IBTEXT text area fits in the block IBBLK
 N NODE,Y
 S NODE=$G(^IBE(357.8,IBTEXT,0)) S Y=$P(NODE,"^",4)
 Q ((1+$$MAXY^IBDFU1B)-Y)
 Q
MAXW() ;returns the maximum width of IBTEXT text area fits in the block IBBLK
 N NODE,X
 S NODE=$G(^IBE(357.8,IBTEXT,0)) S X=$P(NODE,"^",3)
 Q ((1+$$MAXX^IBDFU1B)-X)
