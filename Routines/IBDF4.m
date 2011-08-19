IBDF4 ;ALB/CJM - ENCOUNTER FORM - BUILD FORM(editing group's selections) ;NOV 16,1992
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**19,38,56**;APR 24, 1997
 ;
SLCTNS ;
 N IBRTN
 Q:IBLIST'=$P($G(^IBE(357.4,IBGRP,0)),"^",3)
 S IBRTN=IBLIST("RTN")
 D RTNDSCR^IBDFU1B(.IBRTN)
 D KILL^IBDFUA
 D EN^VALM("IBDF EDIT GROUP'S SELECTIONS") ;call the list manager
 Q
ONENTRY ;entry code for list manager
 D IDXSLCTN
 Q
ONEXIT ;exit code for the list manager
 K @VALMAR
 Q
 ;
IDXSLCTN ;build an array of selections in print order for the list processor
 N SLCTN,ODR,NODE
 K @VALMAR
 S ODR="",VALMCNT=0
 F  S ODR=$O(^IBE(357.3,"APO",IBLIST,IBGRP,ODR)) Q:ODR=""  D
 .S SLCTN="" F  S SLCTN=$O(^IBE(357.3,"APO",IBLIST,IBGRP,ODR,SLCTN)) Q:'SLCTN  D
 ..;check for messed up index and take appropriate action
 ..S NODE=$G(^IBE(357.3,SLCTN,0))
 ..I ($P(NODE,"^",3)'=IBLIST)!($P(NODE,"^",4)'=IBGRP) D  Q
 ...K ^IBE(357.3,"APO",IBLIST,IBGRP,ODR,SLCTN)
 ...I $P(NODE,"^",3)'=IBLIST,$P(NODE,"^",4)=IBGRP D  Q
 ....K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D ^DIK K DIK,DA
 ...I $P(NODE,"^",3)=IBLIST,$P($G(^IBE(357.4,+IBGRP,0)),"^",3)'=IBLIST D  Q
 ....K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D ^DIK K DIK,DA
 ...K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN D IX^DIK K DIK,DA
 ..;
 ..S VALMCNT=VALMCNT+1
 ..S @VALMAR@(VALMCNT,0)=$$DISPLAY(SLCTN,VALMCNT),@VALMAR@("IDX",VALMCNT,VALMCNT)=SLCTN
 ..D FLDCTRL^VALM10(VALMCNT,"ID") ;set video for ID column
 Q
LMGRPHDR ;header for the screen
 S VALMHDR(1)="SELECTIONS CURRENTLY DEFINED FOR '"_$$GRPNAME_"' PRINT GROUP"
 Q
 ;
GRPNAME() ;the name of the selection group
 Q $P($G(^IBE(357.4,IBGRP,0)),"^",1)
 ;
DISPLAY(SLCTN,COUNT) ;returns a line to display to the list containing a selection - SLCTN is a ptr to the selectin, COUNT is the number of the selection on the list
 N SC,SCDA,VAL,RET,W,NODE,ORDER
 ;W - an array cotaining the widths of the subcolumns that contain text
 S VAL=""
 S RET=$$PADRIGHT^IBDFU(COUNT,4)
 S NODE=$G(^IBE(357.3,SLCTN,0))
 S ORDER=$P(NODE,"^",5),RET=RET_$J(ORDER,6,2)
 I $P(NODE,"^",2) S RET=RET_$S($P(NODE,"^",7):" SH",1:" PH")_"| "_$P(NODE,"^",6)
 I '$P(NODE,"^",2) S RET=RET_"  ",SC="" F SC=1:1:8 S SCDA=$O(^IBE(357.3,SLCTN,1,"B",SC,"")) D
 .I $G(IBLIST("SCTYPE",SC))=1 S W(SC)=IBLIST("SCW",SC)*(1+IBLIST("BTWN"))
 .S:$G(W(SC)) VAL=$$PADRIGHT^IBDFU($S(SCDA:$P($G(^IBE(357.3,SLCTN,1,SCDA,0)),"^",2),1:""),W(SC))
 .S:VAL'="" RET=RET_" | "_VAL
 .S VAL=""
 I $D(^IBE(357.3,SLCTN,2)) S RET=RET_"  ",SC="" F SC=1:1:2 S SCDA=$P(^IBE(357.3,SLCTN,2),"^",SC) S:SC=2 SCDA=$S($D(^LEX)>1:$P($G(^LEX(757.01,+SCDA,0)),"^"),1:$P($G(^GMP(757.01,+SCDA,0)),"^")) D
 .S W(SC)=25
 .S VAL=$$PADRIGHT^IBDFU($S(SCDA]"":SCDA,1:""),W(SC))
 .S:VAL'="" RET=RET_" | "_VAL
 .S VAL=""
 Q RET
ADDSLCTN ;allows the user to add a selection to the selection group
 N QUIT,SUB
 ;
 S VALMBCK="R"
 D FULL^VALM1
 I IBRTN("ACTION")'=3 D NOGOOD G ADDEXIT
 K @IBRTN("DATA_LOCATION")
 S QUIT=0 F  D  Q:QUIT  W !!!,"Now for another SELECTION LIST entry!"
 .I '$$DORTN^IBDFU1B(.IBRTN) S QUIT=1 D NOGOOD Q
 .I '$D(@IBRTN("DATA_LOCATION")) S QUIT=1 Q
 .D ADDREC(.QUIT) ;edits and adds the selection
 .K @IBRTN("DATA_LOCATION")
ADDEXIT ;
 D IDXSLCTN
 Q
ADDREC(QUIT,ORDER,SLCTN) ;allows the user to number the selection, edit the editable subcolumns, then adds the record - sets QUIT=1 if user quits
 N SUB,COUNT,NODE,VAL,DLAYGO,QTY,DTOUT,DUOUT,DIRUT
 I $P($G(^IBE(357.6,$P($G(^IBE(357.2,+IBLIST,0)),"^",11),16)),"^",8) S DIR(0)="NO",DIR("A")="Quantity",DIR("B")=1,DIR("?")="Enter the number of occurrences" D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) QUIT=1 Q:QUIT  S QTY=$G(Y)
 I '$G(ORDER) D  Q:QUIT
 .K DIR S DIR(0)="357.3,.05",DIR("B")=$$NEXT^IBDF4A(IBLIST,IBGRP) D ^DIR K DIR I $D(DIRUT) S QUIT=1 Q
 .S ORDER=+Y
 S VAL=$G(@IBRTN("DATA_LOCATION"))
 Q:QUIT
 ;we have all the data needed to add the selection - so add it
 S NODE=$S($P(VAL,"^")'="":$P(VAL,"^"),1:ORDER)_"^^"_IBLIST_"^"_IBGRP_"^"_ORDER_$S($G(QTY):"^^^^"_QTY,1:"")
 K DIC,DD,DO,DINUM S DIC="^IBE(357.3,",X=$P(NODE,"^",1),DIC(0)="FL",DLAYGO=357.3
 D FILE^DICN K DIC,DIE,DA
 S SLCTN=$S(+Y<0:"",1:+Y)
 I 'SLCTN W !,"Unable to create a new selection record!" D PAUSE^VALM1 S QUIT=1 Q
 S ^IBE(357.3,SLCTN,0)=NODE
 ;--- move codes and add modifiers
 D CODES^IBDF4A,ADD^IBDF4C
 ;---move the subcolum set up
 F SUB=1:1:8 D  Q:QUIT
 .I $G(IBLIST("SCTYPE",SUB))=1 I IBLIST("SCPIECE",SUB),IBLIST("SCW",SUB) D
 ..S NODE=$$DATANODE^IBDFU1B(IBRTN,IBLIST("SCPIECE",SUB))
 ..I NODE]"" S VAL(SUB)=$P($G(@IBRTN("DATA_LOCATION")@(NODE)),"^",IBLIST("SCPIECE",SUB))
 ..E  S VAL(SUB)=$P(VAL,"^",IBLIST("SCPIECE",SUB))
 ..Q:('IBLIST("SCEDITABLE",SUB))!((IBRTN("WIDTH",1))&(IBLIST("SCPIECE",SUB)=1))
 ..W !!,"Subcolumn Header: "_IBLIST("SCHDR",SUB) K DIR S DIR(0)="FO^0:"_(IBLIST("SCW",SUB)*(1+IBLIST("BTWN"))),DIR("A")="Edit Subcolumn "_SUB,DIR("B")=VAL(SUB)_$S($G(QTY)>1:" x "_QTY,1:"")
 ..I $P($G(^IBE(357.3,SLCTN,3,0)),"^",4)>0 D
 ...S:DIR("B")'["w/ mod" DIR("B")=DIR("B")_"w/ mod"
 ..D ^DIR K DIR S:$D(DTOUT)!$D(DUOUT) QUIT=1 Q:QUIT  S VAL(SUB)=Y I IBLIST("SCPIECE",SUB)=1,X="" S QUIT=1
 ;
 ;add the subcolumn value multiple
 S COUNT=0 F SUB=1:1:8 I $G(VAL(SUB))'="" S COUNT=COUNT+1,^IBE(357.3,SLCTN,1,COUNT,0)=SUB_"^"_VAL(SUB)
 S ^IBE(357.3,SLCTN,1,0)="^357.31IA^"_COUNT_"^"_COUNT
 K DA S DA=SLCTN,DIK="^IBE(357.3," D IX^DIK K DIK,DA
 D NARR,TERM
 Q
 ;
NARR ; -- edit provider narrative, but only for selections where the
 ;    interface allows editing
 N DIE,DA,DR
 I $P($G(^IBE(357.6,+$P($G(^IBE(357.2,+IBLIST,0)),U,11),0)),U,17) D
 .S DIE="^IBE(357.3,",DA=SLCTN,DR=2.01 D ^DIE K DIE,DA,DR
 Q
 ;
TERM ; -- map selection to clinical lexicon, but only for selections where
 ;    the package interface allows editing
 N DIE,DA,DR,GMPTUN,GMPTSUB,GMPTSHOW,XTLKGLB,XTLKHLP,XTLKKSCH,XTLKSAY,IBDLEX
 I $P($G(^IBE(357.6,+$P($G(^IBE(357.2,+IBLIST,0)),U,11),0)),U,18) D
 .I $D(^LEX)>1 S X="LEXSET" X ^%ZOSF("TEST") I $T D CONFIG^LEXSET("GMPL","PL1") S IBDLEX=1
 .I '$D(IBDLEX) S X="GMPTSET" X ^%ZOSF("TEST") I $T D CONFIG^GMPTSET("GMPL","PL1") S IBDLEX=1
 .;D CONFIG^GMPTSET("ICD","ICD") (this is an alternate filter)
 .Q:'$D(IBDLEX)
 .S DIE="^IBE(357.3,",DA=SLCTN,DR="2.02//"_$P($G(^IBE(357.3,DA,0)),"^") D ^DIE
 K DIC
 Q
 ;
CODES ; -- allow selection of a second code to pass through for this entry
 ; -- only as if pi allows input of more than one code
 ;N PI S PI=+$P($G(^IBE(357.2,+IBLIST,0)),U,11)
 ;Q:'$P($G(^IBE(357.6,PI,16)),U,9)
 ;N IBI,QUIT,IBVAL S QUIT=0
 ;F IBI=1,2 D  Q:QUIT
 ;.W !,"****Select a ",$S(IBI=1:"second",1:"third")," code to pass along with original."
 ;.I '$$DORTN^IBDFU1B(.IBRTN) S QUIT=1 Q
 ;.I +Y'>0 S QUIT=1 Q
 ;.X $G(^IBE(357.6,PI,9)) S IBVAL=X
 ;.S DIE="^IBE(357.3,",DA=SLCTN,DR=$S(IBI=1:"2.03",1:"2.04")_"////^S X=IBVAL" D ^DIE K DIE,DA,DR
 ;Q
 ;
NOGOOD ;
 W !,"The package interface routine for selection is not properly defined" D PAUSE^VALM1
 Q
 ;
SEQUENCE ;allows the user to resequence all of the selections on the list
 ;
 N SUBCOL,CNT,P,SORT,GROUP,NODE,VALUE,ITEM,IEN,HDR,DTOUT,DUOUT,DIRUT,SORT1
 S VALMBCK="R"
 D FULL^VALM1
 ;
 ;sort by which subcolumn?
 K DIR S DIR("A")="Which subcolumn do you want to sort by?",DIR("?")=" "
 S SUBCOL=0 F  S SUBCOL=$O(IBLIST("SCTYPE",SUBCOL)) Q:'SUBCOL  I IBLIST("SCTYPE",SUBCOL)=1 S SUBCOL(SUBCOL)=""
 S (CNT,SUBCOL)=0,DIR(0)="SOX^"
 F CNT=1:1 S SUBCOL=$O(SUBCOL(SUBCOL)) Q:'SUBCOL  D
 .S P=IBLIST("SCPIECE",SUBCOL),P=$S(P=1:1,P=2:3,P=3:5,P=4:7,P=5:9,P=6:11,P=7:13,1:0),HDR=$P($G(^IBE(357.6,+IBLIST("RTN"),2)),"^",P),DIR("?",CNT)=SUBCOL_" = "_HDR
 .S HDR=$S($G(IBLIST("SCHDR",SUBCOL))="":HDR,1:IBLIST("SCHDR",SUBCOL))
 .S DIR(0)=DIR(0)_SUBCOL_":"_HDR_";"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 K SUBCOL S SUBCOL=+Y
 ;
 ;sort aphabetically or numerically?
 K DIR
 S DIR("A")="How should the list be sorted?",DIR(0)="SO^1:ALPHABETICALLY;2:NUMERICALLY;",DIR("B")="ALPHABETICALLY"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 S SORT=Y
 ;  -- Resequence by group or group and placeholders
 K DIR
 S DIR("A")="Resequence by Group or Group and Place Holders?",DIR(0)="SO^1:GROUP/PLACE HOLDERS;2:GROUP;",DIR("B")="GROUP/PLACE HOLDERS"
 D ^DIR
 Q:$D(DIRUT)!(Y=-1)
 S SORT1=Y
 ;
 ;sort
 I SORT1=2 D EN^IBDF4A Q
 N CNTR,GROUP1,IBGROUP,IBORDER
 K ^TMP("IBDF",$J)
 S (GROUP,GROUP1,CNTR,IBGROUP)=0
 ;  -- Resequence only specific groups in block.
 I $D(IBGRUP) F  S IBGROUP=$O(IBGRUP(IBGROUP)) Q:'IBGROUP  D RESEQ
 I $D(IBGRUP) D ORDER Q
 ;  -- Resequence all groups of the block.
 I '$D(IBGRUP) F  S IBGROUP=$O(^IBE(357.3,"APO",IBLIST,IBGROUP)) Q:'IBGROUP  D RESEQ
 I '$D(IBGRUP) D ORDER Q
 Q
RESEQ S IBORDER=0 F  S IBORDER=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER)) Q:'IBORDER  S ITEM=0 F  S ITEM=$O(^IBE(357.3,"APO",IBLIST,IBGROUP,IBORDER,ITEM)) Q:'ITEM  D
 .S NODE=$G(^IBE(357.3,ITEM,0))
 .I ($P(NODE,"^",3)'=IBLIST) Q
 .S GROUP1=GROUP,GROUP=+$P(NODE,"^",4)
 .Q:$P($G(^IBE(357.4,GROUP,0)),"^",3)'=IBLIST
 .I $P(NODE,"^",2)=1 D  Q
 ..S CNTR=CNTR+1
 ..S VALUE=$S(SORT=1:" ",1:+$P(NODE,"^",1))
 ..S ^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE,ITEM)=""
 .S IEN=$O(^IBE(357.3,ITEM,1,"B",SUBCOL,0)) Q:'IEN
 .S VALUE=$P($G(^IBE(357.3,ITEM,1,IEN,0)),"^",2)
 .S VALUE=$S(SORT=1:VALUE=" "_VALUE,1:+$P(NODE,"^",1))
 .I GROUP'=GROUP1 S CNTR=CNTR+1
 .S ^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,$E(VALUE,1,40),ITEM)=""
 ;set the order
ORDER S GROUP=0,CNTR=0
 F  S GROUP=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP)) Q:'GROUP  D
 .S VALUE="",CNT=0
 .F  S CNTR=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR)) Q:'CNTR  F  S VALUE=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE)) Q:VALUE=""  D
 ..S ITEM=0 F  S ITEM=$O(^TMP("IBDF",$J,"RESEQUENCE LIST",GROUP,CNTR,VALUE,ITEM)) Q:'ITEM  D
 ...S CNT=CNT+1
 ...K DIE,DA,DR S DIE="^IBE(357.3,",DR=".05///"_CNT,DA=ITEM D ^DIE K DIE,DA,DR
 ;
 K Y,X,DIR,^TMP("IBDF",$J,"RESEQUENCE LIST")
 D IDXGRP^IBDF3
 Q
