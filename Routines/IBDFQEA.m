IBDFQEA ;ALB/CJM/MAF - ENCOUNTER FORM - BUILD FORM(editing action for group's selections list) ;JUN 16,1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**15,38**;APR 24, 1997
 ;
EDIT ;allows editing of an existing selection
 D FULL^VALM1
 N SEL,SUB,SLCTN,SC,NODE,OQTY,NQTY
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL="" F  S SEL=$O(VALMY(SEL)) Q:'SEL  D
 .W !,"Editing Entry #",SEL
 .S SLCTN=$P($G(^TMP("SELIDX",$J,SEL)),"^",3) Q:'SLCTN
 .S NODE=$G(^IBE(357.3,SLCTN,0))
 .S IBGRP=$P(NODE,"^",4),ORD=$P(NODE,"^",5)
 .;re-index the record, to insure it is good                             
 .K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D IX^DIK K DIK
 .;edit the order of the selection - also, for placeholders, the text, then quit
 .I $P(NODE,"^",2) S DA=SLCTN,DIE=357.3,DR="[IBDF EDIT PLACE HOLDER]" D ^DIE K DIE,DA,DR Q
 .S DA=SLCTN,DIE=357.3,DR=".05;I '$P($G(^IBE(357.6,$P($G(^IBE(357.2,+IBLIST,0)),""^"",11),16)),""^"",8) S Y=""@99"";S OQTY=$P(^IBE(357.3,DA,0),""^"",9);.09;S NQTY=X;@99;S CONT=1" S CONT=0 D ^DIE K DIE,DA,DR
 .D CODES^IBDF4A W !
 .D ADD^IBDF4C W !
 .;add any missing subcolumns
 .S SC=0 F SC=1:1:8 I $G(IBLIST("SCTYPE",SC))=1 I '$D(^IBE(357.3,SLCTN,1,"B",SC)) D
 ..K DA,DO,DINUM,DIC
 ..N DLAYGO
 ..S DIC="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,X=SC,DIC(0)="L",DLAYGO=357.3 D FILE^DICN
 .;now allow the user to edit editable subcolumns - CONT=0 means the user up-arrowed out, so stop
 .I CONT S SUB=0 F  S SUB=$O(^IBE(357.3,SLCTN,1,SUB)) Q:'SUB  D
 ..S SC=+$G(^IBE(357.3,SLCTN,1,SUB,0)) I $G(IBLIST("SCTYPE",SC))=1,$G(IBLIST("SCPIECE",SC)),$G(IBLIST("SCEDITABLE",SC)) D
 ...I $G(^IBE(357.3,SLCTN,1,0))="" S ^IBE(357.3,SLCTN,1,0)="^357.31IA^"
 ...S DIE="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,DA=SUB,DR=".02;S CONT=1",CONT=0 W !!,"Editing Subcolumn "_SC_": Header="_IBLIST("SCHDR",SC)
 ...S IBVAL=$P($G(^IBE(357.3,SLCTN,1,SUB,0)),"^",2)
 ...I $G(OQTY)'=$G(NQTY) D
 ....S IBVAL=$P(IBVAL," x "_OQTY)_$S(NQTY>1:" x "_NQTY,1:""),DR=".02////^S X=IBVAL;I;"_DR
 ...I $P($G(^IBE(357.3,SLCTN,3,0)),"^",4)>0 D
 ....S IBVAL=$P($G(^IBE(357.3,SLCTN,1,SUB,0)),"^",2)
 ....S:IBVAL'["w/ mod" IBVAL=IBVAL_" w/ mod"
 ....S DR=".02////^S X=IBVAL;I;"_DR
 ...D ^DIE K DIE,DA,DR,IBVAL I 'CONT Q
 .D NARR^IBDF4 W !
 .D TERM^IBDF4 W !
 ;
EDITEXIT ;
 G EXIT
DELETE ;allows the user to select selections to delete
 D FULL^VALM1
 N SEL
 D EN^VALM2($G(XQORNOD(0)))
 K DA
 S SEL="" F  S SEL=$O(VALMY(SEL)) Q:'SEL  D
 .S DIK="^IBE(357.3,",DA=$P($G(^TMP("SELIDX",$J,SEL)),"^",3) Q:'DA
 .S NODE=$G(^IBE(357.3,DA,0))
 .S IBGRP=$P(NODE,"^",4),ORD=$P(NODE,"^",5)
 .Q:'$$RUSURE^IBDFU5("Selection #"_SEL)
 .D ^DIK
 .D KILL^VALM10(SEL)
 K DIK,DA
 G EXIT
ADDSLCTN ;allows the user to add a selection to the selection group
 N QUIT,SUB
 ;
 D FULL^VALM1
 S IBRTN=IBLIST("RTN")
 I $G(IBLIST("CLRM")) S IBLIST("EDITING CLRM")=1
 D RTNDSCR^IBDFU1B(.IBRTN)
 I IBRTN("ACTION")'=3 D NOGOOD^IBDF4 G ADDEXIT
 K @IBRTN("DATA_LOCATION")
 S QUIT=0 F  D  G:QUIT EXIT  W !,"Now for another!",!
 .I '$$DORTN^IBDFU1B(.IBRTN) S QUIT=1 D NOGOOD^IBDF4 Q
 .I '$D(@IBRTN("DATA_LOCATION")) S QUIT=1 Q
 .S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S:X="^" QUIT=1 Q:QUIT  S IBGRP=+Y I Y<0 D  Q:QUIT=1
 ..W !!,"A SELECTION GROUP HEADER IS REQUIRED.... The selection will not be added if none is provided....Enter '??' for a list of choices.",!!
 ..S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S IBGRP=+Y I Y<0 S QUIT=1 Q
 .D ADDREC^IBDF4(.QUIT) ;edits and adds the selection
 .K @IBRTN("DATA_LOCATION")
ADDEXIT ;
 G EXIT
ADDBLANK ;allows the user to add a dummy selection to the selection group
 ;i.e., a place holder that will not actually print a selection
 ;
 ;
 N IBGRP
 D FULL^VALM1
 K DIC S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $D(^IBE(357.3,""APO"",IBLIST,+Y))" D ^DIC S IBGRP=+Y K DIC
 I ('$D(DIRUT))&(Y>0) D ADD^IBDF4A
 D INIT^IBDFQSL1
 S VALMBCK="R"
 Q
FORMAT ;allows the user to format all of the selections in the group in mass
 ;
 D FORMAT^IBDF9A1
 G EXIT
 ;
GRPDEL ;  -- Group Delete
 D FULL^VALM1
 N GRP
 S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S IBGRP=+Y I Y<0 G EXIT
 S GRP=+Y
 Q:'$$RUSURE^IBDFU5($P($G(^IBE(357.4,GRP,0)),"^"))
 I GRP D DELSLCTN^IBDF3 K DA S DIK="^IBE(357.4,",DA=GRP D ^DIK K DIK
 D IDXGRP^IBDF3
 S VALMBCK="R"
 D EXIT Q
 ;
GROUPADD ;  -- Add a new group to the selection list and to file 357.4.
 D FULL^VALM1
 N NAME,QUIT,GRP
 S QUIT=0
 F  D  D IDXGRP^IBDF3 G:QUIT EXIT
 .K DIR S DIR(0)="357.4,.01O",DIR("B")="" D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 .S NAME=Y
 .K DIC,DD,DO,DINUM S DIC="^IBE(357.4,",X=NAME,DIC(0)=""
 .D FILE^DICN K DIC,DIE,DA
 .I +Y<0 W !,"Unable to create a new record!" D PAUSE^VALM1 S QUIT=1 Q
 .I +Y>0 K DA S DA=+Y,DIE="^IBE(357.4,",DIE("NO^")="Any value",DR=".02;.04;.03////"_IBLIST D ^DIE K DIC,DIE,DR,DA
 .W !,"Now Another!",!
 G EXIT
 ;
GRPEDIT ;
 D FULL^VALM1
 N DIC,DIE,DA,DR,GRP
 S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S IBGRP=+Y I Y<0 G EXIT
 S GRP=+Y
 S (DIC,DIE)="^IBE(357.4,",DA=GRP,DR=".01;.02;.04" D ^DIE
 I '$D(DA) D DELSLCTN^IBDF3
 D IDXGRP^IBDF3
 S VALMBCK="R"
 D EXIT Q
 Q
 ;
EXIT D INIT^IBDFQSL1 S VALMBCK="R"
 Q
GRPRESEQ ;  -- Resequence numerically or alphabetically a group
 ;     within a block.
 D FULL^VALM1
 N DIC,GRP,IBGRP,IBGRUP
 Q:$$LSTDSCR2^IBDFU1(.IBLIST) 1
GRP1 S DIC="^IBE(357.4,",DIC(0)="AEMN",DIC("S")="I $P(^IBE(357.4,+Y,0),""^"",3)=IBLIST" D ^DIC K DIC S IBGRUP(+Y)=+Y
 I Y<0&($D(IBGRUP)) D SEQUENCE^IBDF4,EXIT Q
 I Y<0&('$D(IBGRUP)) G EXIT
 G GRP1
GRPRSEQ1 ;  -- Resequence all groups chosen
 N IBGROUP,IBFLAG
 S IBGROUP=0,IBFLAG=1
 F  S IBGROUP=$O(IBGRP(IBGROUP)) Q:'IBGROUP  D SEQUENCE^IBDF4
 Q
