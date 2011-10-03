IBDF5C ;ALB/CJM - ENCOUNTER FORM (creating a new block) ;MARCH 22,1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
NEWBLOCK ;adds a new block, expects IBFORM to be defined
 N IBBLK,TOP,BOT
 S VALMBCK="R"
 S IBBLK=$$CREATE()
 I IBBLK D
 .D TOPNBOT^IBDFU5(IBBLK,.TOP,.BOT)
 .D IDXFORM^IBDF5A(TOP,BOT)
 Q
CREATE() ;creates the new block and allows the user to edit it
 ;INPUTS: expects IBFORM to be defined
 ;        expects IBTKBLK to be defined - IBTKBLK=1 means add to tk
 ;returns IBBLK
 N NAME,IBBLK,NODE,IBDFDONE,IBBG,IBLFT,DLAYGO
 S IBBG=1,IBLFT=5
 S VALMBCK="R"
 I '$G(IBTKBLK) S IBBG=+$G(VALMBG),IBLFT=+$G(VALMLFT)
 S NAME=$$NEWNAME Q:NAME=-1 ""
 K DIC,DIE,DD,DO,DINUM S DIC="^IBE(357.1,",DIC(0)="FL",X=NAME,DLAYGO=357.1
 D FILE^DICN K DIC,DIE,DA
 S IBBLK=+Y
 I 'IBBLK D
 .W !,"Unable to create a new block!" K DIC,DIE D PAUSE^IBDFU5
 I IBBLK D
 .;delete everything in the block - it should be empty
 .D DLTCNTNT^IBDFU3(IBBLK,357.1)
 .;set the current position of the block to the upper left-hand corner of the screen as the default
 .S $P(^IBE(357.1,IBBLK,0),"^",4,5)=(IBBG-1)_"^"_(IBLFT-5)
 .;now let the user edit the new block - header,name,outline,etc.
 .K DIE,DA S DIE=357.1,DA=IBBLK,DR="[IBDF NEW EMPTY BLOCK]",DIE("NO^")="BACKOUTOK" D ^DIE K DIC,DIE,DR,DA
 .I 'IBDFDONE S DIK="^IBE(357.1,",DA=IBBLK K DA(1) D ^DIK K DIK,DA Q
 Q IBBLK
NEWNAME() ;
 K DIR S DIR(0)="357.1,.01A",DIR("A")="New Block Name: ",DIR("B")=""
 D ^DIR K DIR I $D(DIRUT) Q -1
 Q Y
REDRAW ;redraws the ;entire form
 S VALMBCK="R"
 D UNCMPALL^IBDF19(IBFORM)
 D IDXFORM^IBDF5A()
 Q
COPYBLK ;copies a block from another form,whether in the toolkit or not, expects IBFORM=current work form  to be defined
 N IBBLK,TOP,BOT,NEWBLOCK
 S IBBLK=$$SELECT2^IBDF13("")
 I IBBLK S NEWBLOCK=$$COPYBLK^IBDFU2(IBBLK,IBFORM,357.1,357.1,$$CURY^IBDFU4,$$CURX^IBDFU4,0,"",1) I NEWBLOCK D
 .D RE^VALM4
 .D POS^IBDFU4(NEWBLOCK)
 .D TOPNBOT^IBDFU5(NEWBLOCK,.TOP,.BOT)
 .D IDXFORM^IBDF5A(TOP,BOT)
 S VALMBCK="R"
 Q
 ;
VIEW ;toggles between viewing form with data and without data
 N STARTVAL
 S STARTVAL=IBPRINT("WITH_DATA")
 I 'IBPRINT("WITH_DATA") D
 .D FULL^VALM1
 .S DFN=$$PATIENT
 .I DFN S IBPRINT("WITH_DATA")=1 I '$G(IBAPPT) D NOW^%DTC S IBAPPT=% K %,%H,%I,X
 E  I IBPRINT("WITH_DATA") S IBPRINT("WITH_DATA")=0
 ;
 ;this action could be called at the form level or the block level - action depends on which
 I '$G(IBBLK) D
 .I STARTVAL'=IBPRINT("WITH_DATA") D JUSTDATA^IBDF2A(IBPRINT("WITH_DATA")) K ^TMP("IB",$J,"INTERFACES")
 I $G(IBBLK) D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 S VALMBCK="R"
 Q
 ;
PATIENT() ;asks for a patient, returns the DFN
 K DIR S DIR(0)="P^2:EM",DIR("A")="Test with what Patient"
 D ^DIR K DIR I $D(DIRUT)!(+Y<1) Q 0
 Q +Y
