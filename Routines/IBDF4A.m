IBDF4A ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(editing group's selections - continued from IBDF4) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38**;APR 24, 1997
 ;
EDIT ;allows editing of an existing selection
 N SEL,SUB,SLCTN,SC,NODE,OQTY,NQTY
 D EN^VALM2($G(XQORNOD(0)),"S")
 S SEL="" F  S SEL=$O(VALMY(SEL)) Q:'SEL  D
 .W !,"Editing Entry #",SEL
 .S SLCTN=$G(@VALMAR@("IDX",SEL,SEL)) Q:'SLCTN
 .S NODE=$G(^IBE(357.3,SLCTN,0))
 .;re-index the record, to insure it is good                             
 .K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D IX^DIK K DIK
 .;edit the order of the selection - also, for placeholders, the text, then quit
 .D FULL^VALM1
 .I $P(NODE,"^",2) D  Q
 ..S DA=SLCTN,DIE=357.3,DR="[IBDF EDIT PLACE HOLDER]" D ^DIE K DIE,DA,DR
 .S DA=SLCTN,DIE=357.3,DR=".05;I '$P($G(^IBE(357.6,$P($G(^IBE(357.2,+IBLIST,0)),""^"",11),16)),""^"",8) S Y=""@99"";S OQTY=$P(^IBE(357.3,DA,0),""^"",9);.09;S NQTY=X;@99;S CONT=1" S CONT=0 D ^DIE K DIE,DA,DR
 .D CODES
 .D ADD^IBDF4C
 .;add any missing subcolumns
 .S SC=0 F SC=1:1:8 I $G(IBLIST("SCTYPE",SC))=1 I '$D(^IBE(357.3,SLCTN,1,"B",SC)) D
 ..K DA,DO,DINUM,DIC
 ..N DLAYGO
 ..S DIC="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,X=SC,DIC(0)="L",DLAYGO=357.3 D FILE^DICN
 .;now allow the user to edit editable subcolumns - CONT=0 means the user up-arrowed out, so stop
 .I CONT S SUB=0 F  S SUB=$O(^IBE(357.3,SLCTN,1,SUB)) Q:'SUB  D
 ..S SC=+$G(^IBE(357.3,SLCTN,1,SUB,0)) I $G(IBLIST("SCTYPE",SC))=1,$G(IBLIST("SCPIECE",SC)),$G(IBLIST("SCEDITABLE",SC)) D
 ...I $G(^IBE(357.3,SLCTN,1,0))="" S ^IBE(357.3,SLCTN,1,0)="^357.31AI^"
 ...S DIE="^IBE(357.3,"_SLCTN_",1,",DA(1)=SLCTN,DA=SUB,DR=".02;S CONT=1",CONT=0 W !!,"Editing Subcolumn "_SC_": Header="_IBLIST("SCHDR",SC)
 ...S IBVAL=$P($G(^IBE(357.3,SLCTN,1,SUB,0)),"^",2)
 ...I $G(OQTY)'=$G(NQTY) S IBVAL=$P(IBVAL," x "_OQTY)_$S(NQTY>1:" x "_NQTY,1:""),DR=".02////^S X=IBVAL;I;"_DR
 ...;--added for modifiers
 ...I $P($G(^IBE(357.3,SLCTN,3,0)),"^",4)>0 D
 ....S:IBVAL'["w/ mod" IBVAL=IBVAL_" w/ mod"
 ....S DR=".02////^S X=IBVAL;I;"_DR
 ...D ^DIE K DIE,DA,DR,IBVAL I 'CONT Q
 .D NARR^IBDF4 W !
 .D TERM^IBDF4 W !
 D IDXSLCTN^IBDF4
 S VALMBCK="R"
EDITEXIT ;
 Q
CODES ; -- allow editing of 2nd & 3rd codes that are associated w/ original
 N IBPI S IBPI=+$P($G(^IBE(357.2,+IBLIST,0)),U,11) Q:'IBPI
 Q:'$P($G(^IBE(357.6,IBPI,16)),U,9)!('$D(^IBE(357.6,IBPI,17)))
 N IBI,IBEXT,FLD
 F IBI=3,4 S FLD="2.0"_IBI D
 .S IBEXT=$P($G(^IBE(357.3,SLCTN,2)),"^",IBI)
 .I $G(IBEXT)]"" D
 ..W !,$S(IBI=3:"SECOND",1:"THIRD")," CODE: ",IBEXT
 ..S DIR(0)="Y",DIR("A")="Delete?",DIR("B")="NO" D ^DIR K DIR
 ..I Y=1 S IBEXT="",DIE="^IBE(357.3,",DA=SLCTN,DR=FLD_"////@" D ^DIE K DIE,DA,DR
 .S DIC("A")="Select a "_$S(IBI=3:"SECOND",1:"THIRD")_" code to associate with the original:",DIC("B")=$S($G(IBEXT)]"":IBEXT,1:"")
 .I '$$DORTN^IBDFU1B(.IBRTN) Q
 .S IBEXT=$S(+$G(Y)>0:$P($G(Y(0)),"^"),1:"")
 .I $G(IBEXT)]"" D
 ..S DIE="^IBE(357.3,",DA=SLCTN,DR=FLD_"////^S X=IBEXT"
 ..D ^DIE K DIE,DA,DR
 Q
DELETE ;allows the user to select selections to delete
 N SEL
 D EN^VALM2($G(XQORNOD(0)))
 K DA
 S SEL="" F  S SEL=$O(VALMY(SEL)) Q:'SEL  D
 .S DIK="^IBE(357.3,",DA=$G(@VALMAR@("IDX",SEL,SEL))
 .Q:'$$RUSURE^IBDFU5("Selection #"_SEL)
 .D ^DIK
 .D KILL^VALM10(SEL)
 K DIK,DA
 D IDXSLCTN^IBDF4
 S VALMBCK="R"
 Q
 ;
ADDBLANK ;allows the user to add a dummy selection to the selection group
 ;i.e., a place holder that will not actually print a selection
 ;
 D FULL^VALM1
 D ADD
 D IDXSLCTN^IBDF4
 S VALMBCK="R"
 Q
 ;
NEXT(IBLIST,IBGRP) ;returns the next print order to assign=last + 1
 Q (1+$O(^IBE(357.3,"APO",IBLIST,IBGRP,""),-1))
 ;
ASKMORE() ;ask if the user wants to add another, returns 1 or 0
 K DIR
 S DIR(0)="Y",DIR("A")="Do you want to add another",DIR("B")="NO"
 D ^DIR
 K DIR
 I $D(DIRUT)!'Y Q 0
 Q 1
 ;
ADD ;allows the user to add a dummy selection to the selection group
 ;i.e., a place holder that will not actually print a selection
 ;
 N QUIT,ORDER,SLCTN,NODE
 S QUIT=0 F  D  Q:QUIT  Q:'$$ASKMORE()
 .S ORDER=$$NEXT(IBLIST,IBGRP)
 .;we have all the data needed to add the selection - so add it
 .S NODE=ORDER_"^"_1_"^"_IBLIST_"^"_IBGRP_"^"_ORDER
 .K DIC,DD,DO,DINUM
 .N DLAYGO
 .S DIC="^IBE(357.3,",X=ORDER,DIC(0)="FL",DLAYGO=357.3
 .D FILE^DICN K DIC,DIE,DA
 .S SLCTN=$S(+Y<0:"",1:+Y)
 .I 'SLCTN W !,"Unable to create the place holder!" D PAUSE^VALM1 S QUIT=1 Q
 .S ^IBE(357.3,SLCTN,0)=NODE
 .K DA S DA=SLCTN,DIK="^IBE(357.3," D IX^DIK K DIK,DA
 .K DIE S DA=SLCTN,DIE=357.3,DR="[IBDF EDIT PLACE HOLDER]" D ^DIE K DIE,DA,DR
 .K DA S DA=SLCTN,DIK="^IBE(357.3," D IX^DIK K DIK,DA
 Q
EN ;  -- Resequence selection lists not taking into account the
 ;     the place holders.  Will put the selection list into alphabetic
 ;     or numeric order..... the place holders will be used as exta
 ;     lines of description and not as separators or headers within
 ;     the group.
 N CNTR,COUNT,IBGROUP,IBORDER
 S (CNTR,COUNT,IBGROUP)=0
 K ^TMP("BLANK",$J),^TMP("IBDF",$J)
 ;  -- Resequence only specific groups in block.
 I $D(IBGRUP) F  S IBGROUP=$O(IBGRUP(IBGROUP)) Q:'IBGROUP  D RESEQ
 I $D(IBGRUP) D ORDER Q
 ;  -- Resequence all groups of the block.
 I '$D(IBGRUP) F  S IBGROUP=$O(^IBE(357.3,"APO",IBLIST,IBGROUP)) Q:'IBGROUP  D RESEQ
 I '$D(IBGRUP) D ORDER Q
 Q
 ;
RESEQ S IBORDER=0 F  S IBORDER=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER)) Q:'IBORDER  S ITEM=0 F  S ITEM=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER,ITEM)) Q:'ITEM  D
 .S NODE=$G(^IBE(357.3,ITEM,0))
 .I ($P(NODE,"^",3)'=IBLIST) Q
 .S GROUP=+$P(NODE,"^",4)
 .Q:$P($G(^IBE(357.4,GROUP,0)),"^",3)'=IBLIST
 .S COUNT=COUNT+1
 .I $P(NODE,"^",2) S ^TMP("BLANK",$J,GROUP,CNTR,COUNT,ITEM)=""
 .S IEN=$O(^IBE(357.3,ITEM,1,"B",SUBCOL,0)) Q:'IEN
 .S VALUE=$P($G(^IBE(357.3,ITEM,1,IEN,0)),"^",2)
 .S VALUE=$S(SORT=1:VALUE=" "_VALUE,1:+$P(NODE,"^",1))
 .S CNTR=CNTR+1
 .S ^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,$E(VALUE,1,40),ITEM)=CNTR
 .S ^TMP("BLANK",$J,GROUP,CNTR,COUNT,ITEM)=""
 ;
 ;set the order
ORDER S (GROUP,CNTR)=0
 F  S GROUP=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP)) Q:'GROUP  D
 .S VALUE="",CNT=0
 .F  S VALUE=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,VALUE)) Q:VALUE=""  D
 ..S ITEM=0 F  S ITEM=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,VALUE,ITEM)) Q:'ITEM  S CNTR=^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,VALUE,ITEM) D:'$D(^TMP("BLANK",$J,GROUP,CNTR))  I $D(^TMP("BLANK",$J,GROUP,CNTR)) D BLANK
 ...S CNT=CNT+1
 ...K DIE,DA,DR S DIE="^IBE(357.3,",DR=".05///"_CNT,DA=ITEM D ^DIE K DIE,DA,DR
 ;
 K Y,X,DIR,^TMP("IBDF",$J,"RESEQUENCE LIST")
 D IDXGRP^IBDF3
 Q
BLANK ;  -- Check to see if there is any place holders.
 N IBDITEM,COUNT
 F COUNT=0:0 S COUNT=$O(^TMP("BLANK",$J,GROUP,CNTR,COUNT)) Q:'COUNT  F IBDITEM=0:0 S IBDITEM=$O(^TMP("BLANK",$J,GROUP,CNTR,COUNT,IBDITEM)) Q:'IBDITEM  D
 .S CNT=CNT+1
 .K DIE,DA,DR S DIE="^IBE(357.3,",DR=".05///"_CNT,DA=IBDITEM D ^DIE K DIE,DA,DR
 .Q
 Q
