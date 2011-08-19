IBDF17 ;ALB/CJM - ENCOUNTER FORM - COPY A CPT CHECK-OFF SHEET INTO A FORM ;24SEP93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**38**;APR 24, 1997
 ;DHH
 ;Allows the user to choose a form to copy to, and a CPT check-off sheet
 ;to copy from, then creates a new block and copies the CPT codes to it
 ;
 N FORM,LIST,BLOCK,SHEET
 W !!,"Select the encounter form you want to copy CPT codes to!",!
 S FORM=$$SLCTFORM^IBDFU4(0)
 Q:'FORM
 D FIND(FORM,.BLOCK,.LIST)
 I 'BLOCK W !,"There is no selection list for CPT codes to copy to!" D PAUSE^IBDFU5 Q
 ;
 S SHEET=$$SLCTSHT
 Q:'SHEET
 ;
 ;must delete the compiled version of the block, since it will be changed
 K ^IBE(357.1,BLOCK,"S"),^("V"),^("B"),^("H")
 ;
 D COPY(SHEET,LIST)
 Q
 ;
COPY(SHEET,LIST) ;copies the CPT codes/headers from the sheet to the list
 ;
 N HDR,TYPE,NODE
 ;
 ;find the subcolumns in LIST to write to
 D SUBCOLS(.LIST) I 'LIST("CODESC")!'LIST("TEXTSC") W !,"The CPT selection list does not contain a subcolumn for the CPT code or text!" D PAUSE^IBDFU5 Q
 ;
 S HDR="" F  S HDR=$O(^IBE(350.71,"G",SHEET,HDR)) Q:'HDR  S NODE=$G(^IBE(350.71,HDR,0)),TYPE=$P(NODE,"^",3)  D:TYPE="S" COPYGRP(HDR,.NODE,.LIST)
 Q
 ;
COPYGRP(HDR,NODE,LIST) ;copies the header contained in NODE to the selection list (LIST)
 ;
 N HEADER,ORDER,GROUP,PROC
 S HEADER=$P(NODE,"^") Q:HEADER=""  S ORDER=$P(NODE,"^",2) Q:'ORDER
 ;
 ;copy the group
 K DIC,DD,D0,DINUM S DIC="^IBE(357.4,",X=HEADER,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S GROUP=$S(+Y<0:"",1:+Y)
 Q:'GROUP
 S ^IBE(357.4,GROUP,0)=HEADER_"^"_ORDER_"^"_LIST
 K DIK,DA S DIK="^IBE(357.4,",DA=GROUP
 D IX1^DIK K DIK,DA
 ;
 ;now find all the group's procedures and copy them
 S PROC=0 F  S PROC=$O(^IBE(350.71,"S",HDR,PROC)) Q:'PROC  D:PROC'=HDR COPYPROC(PROC,.LIST,GROUP)
 ;
 W "." ;just to let the use know it's doing something
 Q
 ;
COPYPROC(PROC,LIST,GROUP) ;copies the procedure contained to the selection list and group
 ;
 N NODE,TEXT,ORDER,CODE,SLCTN
 S NODE=$G(^IBE(350.71,PROC,0))
 ;
 ;find the CPT code
 S CODE=$P(NODE,"^",6)
 Q:'CODE
 S CODE=$P($G(^SD(409.71,CODE,0)),"^")
 Q:'CODE
 ;; --change to api cpt ; dhh
 S CODE=$$CPT^ICPTCOD(CODE)
 Q:+CODE=-1
 S CODE=$P(CODE,"^",2)
 Q:'CODE
 ;
 ;find the text and order for the proc on the sheet
 S TEXT=$P(NODE,"^") Q:TEXT=""  S ORDER=$P(NODE,"^",2) Q:'ORDER
 ;
 ;create the selection
 K DIC,DD,D0,DINUM S DIC="^IBE(357.3,",X=CODE,DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S SLCTN=$S(+Y<0:"",1:+Y)
 Q:'SLCTN
 ;
 ;fill in the 0 node
 S ^IBE(357.3,SLCTN,0)=CODE_"^^"_LIST_"^"_GROUP_"^"_ORDER_"^"
 ;
 ;fill in the SUBCOLUM VALUE multiple with the subcolumn values
 S ^IBE(357.3,SLCTN,1,0)="^357.31IA^2^2"
 S ^IBE(357.3,SLCTN,1,2,0)=LIST("TEXTSC")_"^"_TEXT
 S ^IBE(357.3,SLCTN,1,1,0)=LIST("CODESC")_"^"_CODE
 K DIK,DA S DIK="^IBE(357.3,",DA=SLCTN
 D IX1^DIK K DIK,DA
 Q
 ;
SUBCOLS(LIST) ;finds the column containing the CPT code and the text description
 ;LIST is passed by reference
 S (LIST("CODESC"),LIST("TEXTSC"))=""
 ;
 N SC,PIECE,NODE S SC=0
 ;
 ;piece 1 of the data returned by the package interface is the code,piece 2 is the description
 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  S NODE=$G(^IBE(357.2,LIST,2,SC,0)),PIECE=$P(NODE,"^",5) S:PIECE=1 LIST("CODESC")=$P(NODE,"^") S:PIECE=2 LIST("TEXTSC")=$P(NODE,"^") Q:LIST("CODESC")&LIST("TEXTSC")
 Q
 ;
SLCTSHT() ;allows the user to select a CPT check-off sheet
 K DIC S DIC=350.7,DIC(0)="AEMQ" D ^DIC K DIC
 I $D(DINUM)!$D(DUOUT)!(Y<0) Q ""
 Q +Y
FIND(FORM,BLK,LIST) ;finds the block & list for CPT codes
 N INTRFACE,BLOCKS,I
 S (BLK,LIST,BLOCKS,I)=0
 ;
 ;find the package interface for selecting CPT codes
 S INTRFACE=$O(^IBE(357.6,"B","DG SELECT CPT PROCEDURE CODES",0))
 Q:'INTRFACE
 ;
 ;find all of the blocks with CPT lists
 S BLK="" F  S BLK=$O(^IBE(357.1,"C",FORM,BLK)) Q:'BLK  D
 .S LIST="" F  S LIST=$O(^IBE(357.2,"C",BLK,LIST)) Q:'LIST  I $P($G(^IBE(357.2,LIST,0)),"^",11)=INTRFACE S BLOCKS=BLOCKS+1,I=I+1,BLOCKS(I)=BLK_"^"_LIST
 ;
 ;if count of blocks <2 there is no need to ask the user to choose
 I BLOCKS<2 S BLK=+$P($G(BLOCKS(1)),"^"),LIST=$P($G(BLOCKS(1)),"^",2) Q
 ;
 ;if count>1 the user must choose the block from the array BLOCKS
 S (BLK,LIST)=0
 S I=$$CHOOSE(.BLOCKS)
 S BLK=+$G(BLOCKS(+I)),LIST=+$P($G(BLOCKS(+I)),"^",2)
 Q
 ;
CHOOSE(BLOCKS) ;ask the user to choose
 ;BLOCKS is an array passed by reference
 ;
 N I
ASK W ! S I=0 F  S I=$O(BLOCKS(I)) Q:'I  W !,I,"  ",$P($G(^IBE(357.1,+BLOCKS(I),0)),"^")
 W !!,"Select a block to put the CPT codes: (1-",BLOCKS,"): "
 R I:DTIME
 Q:'$T 0
 Q:'$G(I) 0
 I '$D(BLOCKS(I)) G ASK
 Q I
