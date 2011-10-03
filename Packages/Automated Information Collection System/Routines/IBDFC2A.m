IBDFC2A ;ALB/CJM - ENCOUNTER FORM - converts a form for scanning (cont'd);MAR 3, 1995
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
BUBBLES(LIST) ;changes the marking areas to bubbles
 ;no conversion if there is no input interface for the data
 ;pass LIST array by reference
 Q:'LIST("INPUT_RTN")
 ;
 N SC,SCORDER,LARGEST,SZCHANGE,NODE,CNT,BUBBLE
 S (SZCHANGE,LARGEST)=0
 ;
 ;find the marking area used for bubbles
 S BUBBLE=$O(^IBE(357.91,"B","BUBBLE (use for scanning)",0)) Q:'BUBBLE
 ;
 ;make two lists of the subcolumns, one indexed by ien and the other by the order - also, keep track of the largest subcolumn - adjustments may have to be made to it
 S SC=0 F  S SC=$O(^IBE(357.2,LIST,2,SC)) Q:'SC  S SC(SC)=$G(^IBE(357.2,LIST,2,SC,0)),SCORDER(+SC(SC))=SC I $P(SC(SC),"^",4)=1,$P(SC(SC),"^",3)>+LARGEST S LARGEST=$P(SC(SC),"^",3)_"^"_SC
 ;
 ;look for the marking area subcolumns
 S SC=0 F  S SC=$O(SC(SC)) Q:'SC  I $P(SC(SC),"^",4)=2,$P(SC(SC),"^",6)'=BUBBLE,$P(SC(SC),"^",6) D
 .;
 .;don't underline the marking area
 .S $P(SC(SC),"^",8)=1
 .;
 .N MARK
 .S MARK=$P($G(^IBE(357.91,$P(SC(SC),"^",6),0)),"^",2)
 .Q:MARK=""
 .I (MARK="(A) (I)")!(MARK="(A) (I) (H)")!(MARK="(P) (S)") D
 ..;break this subcolumn in two
 ..N QUAL1,QUAL2,HDR1,HDR2
 ..I MARK["A" D
 ...S QUAL1=$O(^IBD(357.98,"B","ACTIVE",0)),QUAL2=$O(^IBD(357.98,"B","INACTIVE",0)),HDR1="A",HDR2="I"
 ..E  D
 ...S QUAL1=$O(^IBD(357.98,"B","PRIMARY",0)),QUAL2=$O(^IBD(357.98,"B","SECONDARY",0)),HDR1="P",HDR2="S"
 ..F CNT=1:1 I '$D(^IBE(357.2,LIST,2,CNT)) Q
 ..;create a new subcolumn
 ..S NODE=SC(SC),$P(NODE,"^")=+SC(SC)+.5,$P(NODE,"^",2)=HDR2,$P(NODE,"^",9)=QUAL2,$P(NODE,"^",6)=BUBBLE,^IBE(357.2,LIST,2,CNT,0)=NODE,$P(^IBE(357.2,LIST,2,0),"^",4)=$P(^IBE(357.2,LIST,2,0),"^",4)+1,SC(CNT)=NODE,SCORDER(+NODE)=CNT
 ..;change the original subcolumn
 ..S NODE=SC(SC),$P(NODE,"^",2)=HDR1,$P(NODE,"^",9)=QUAL1,$P(NODE,"^",6)=BUBBLE,^IBE(357.2,LIST,2,SC,0)=NODE
 ..;
 ..;may have to make an adjustment
 ..S SZCHANGE=SZCHANGE+($L(LIST("SEP"))-1)
 .;
 .;just change the marking area to bubble
 .E  D
 ..S $P(^IBE(357.2,LIST,2,SC,0),"^",6)=BUBBLE
 ..S SZCHANGE=SZCHANGE+(3-$L(MARK))
 ..;
 ;
 ;adjust subcolumn size to make up for extra space required by bubbles - may truncate text
 I SZCHANGE D
 .N SLCTN,SUBCOL,ORDER,IEN,NEWSIZE,TEXT
 .S SUBCOL=$P(LARGEST,"^",2)
 .S NEWSIZE=$P(SC(SUBCOL),"^",3)-SZCHANGE
 .S $P(SC(SUBCOL),"^",3)=NEWSIZE,^IBE(357.2,LIST,2,SUBCOL,0)=SC(SUBCOL)
 .S ORDER=+SC(SUBCOL)
 .S SLCTN=0 F  S SLCTN=$O(^IBE(357.3,"C",LIST,SLCTN)) Q:'SLCTN  S IEN=$O(^IBE(357.3,SLCTN,1,"B",ORDER,0)) Q:'IEN  D
 ..S TEXT=$P($G(^IBE(357.3,SLCTN,1,IEN,0)),"^",2)
 ..I $L(TEXT)>NEWSIZE D WARNING^IBDFC2("IN THE LIST '"_LIST("NAME")_"' THE TEXT '"_TEXT_"' WILL BE TRUNCATED BY "_($L(TEXT)-NEWSIZE)_" CHARACTERS - MANUAL EDITING MAY BE REQUIRED")
 ;
 ;reorder the subcolumns
 N IBSWT
 S (CNT,SCORDER)=0
 F  S SCORDER=$O(SCORDER(SCORDER)) Q:'SCORDER  S CNT=CNT+1 I SCORDER'=CNT D  I $P(SC(SCORDER(SCORDER)),"^",4)=1 S IBSWT(SCORDER)=CNT
 .K ^IBE(357.2,LIST,2,"B",SCORDER,SCORDER(SCORDER))
 .S $P(^IBE(357.2,LIST,2,SCORDER(SCORDER),0),"^")=CNT,^IBE(357.2,LIST,2,"B",CNT,SCORDER(SCORDER))=""
 .;make the change in the selection due to the reordering of the subcolumns
 .;I $P(SC(SCORDER(SCORDER)),"^",4)=1 D SWITCH^IBDF9A(LIST,SCORDER,CNT)
 D SWITCH^IBDF9A(LIST,.IBSWT)
 Q
