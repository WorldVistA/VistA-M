IBDF9 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(display single form block for edit) ; 08-JAN-1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
INIT ;
 D IDXBLOCK^IBDFU4
 Q
EXIT ;
 K @VALMAR
 Q
HDR ;
 S VALMHDR(1)=$$PADRIGHT^IBDFU("",4)
 F I=1:1:16 S VALMHDR(1)=VALMHDR(1)_$J(I,10)
 Q
RESIZE ;resize the block
 N IBW,IBH
 S VALMBCK="R"
 K DIR S DIR(0)="NA^1:"_IBFORM("WIDTH")_":0",DIR("A")="Move the RIGHT MARGIN of the block to which column?: ",DIR("B")=IBBLK("W") D ^DIR K DIR Q:$D(DIRUT)  S IBW=X
 S DIR(0)="NA^1:"_IBFORM("HT")_":0",DIR("A")="Move the BOTTOM MARGIN of the block to which row?: ",DIR("B")=IBBLK("H") D ^DIR K DIR Q:$D(DIRUT)  S IBH=X
 K DR,DIE,DA S DIE=357.1,DA=IBBLK,DR=".06////^S X=IBW;.07////^S X=IBH" D ^DIE K DIE,DR,DA
 S VALMBCK="R"
 D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
EDITBLK ;edit the name,brief description, header and outline
 ;automatically shifts contents and changes size of block if changes in header or outline call for that
 N HDR1,HDR2 ;flags set to indicate existance of hdr before and after editing 
 N NODE,IBNAME,QUIT
 S QUIT=0,VALMBCK="R"
 D FULL^VALM1
 S NODE=$G(^IBE(357.1,IBBLK,0))
 S HDR1=$P(NODE,"^",11) S:HDR1'="" HDR1=1
 K DIR S DIR(0)="357.1,.01",DIR("B")=$P($G(^IBE(357.1,IBBLK,0)),"^") D ^DIR K DIR D  Q:QUIT
 .I (Y=-1)!$D(DIRUT) S QUIT=1 Q
 .S IBNAME=Y
 .K DA,DR,DIE S DIE=357.1,DA=IBBLK,DR="[IBDF EDIT HEADER&OUTLINE]" D ^DIE K DIE,DR,DA
 S NODE=$G(^IBE(357.1,IBBLK,0))
 S HDR2=$P(NODE,"^",11) S HDR2=$S(HDR2="":0,1:1)
 ;shift contents and resize if there has been a change to existance of the header
 I HDR1'=HDR2 D
 .N TOP,BOTTOM,LEFT,RIGHT,WAY,AMOUNT
 .S TOP=0,BOTTOM=IBBLK("H"),LEFT=0,RIGHT=IBBLK("W"),AMOUNT=1
 .I HDR2 S WAY="D" D E^IBDF10 S $P(NODE,"^",7)=$P(NODE,"^",7)+1,^IBE(357.1,IBBLK,0)=NODE
 .I HDR1 S WAY="U" D E^IBDF10 S $P(NODE,"^",7)=$P(NODE,"^",7)-1,^IBE(357.1,IBBLK,0)=NODE
 D UNCMPBLK^IBDF19(IBBLK),IDXBLOCK^IBDFU4
 Q
