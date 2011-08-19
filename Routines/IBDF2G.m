IBDF2G ;ALB/CJM - ENCOUNTER FORM - (prints input field);07/20/94
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
MFLD(FIELD) ;for printing the multiple choice field=FIELD
 N BLOCK,LABEL,ROW,COL,NODE,CHOICE,ID,DISP,FNAME,FID,ALLOWED,HDR,QLFR,PI
 Q:'$G(FIELD)
 S NODE=$G(^IBE(357.93,FIELD,0))
 S BLOCK=$P(NODE,"^",8)
 ;if the input field does not belong to the right block, reindex it and quit
 I BLOCK'=IBBLK K DA S DA=FIELD,DIK="^IBE(357.93," D IX^DIK K DIK Q
 ;
 ;get the package interface
 S PI=$P(NODE,"^",6)
 ;
 S COL=$P(NODE,"^",3)
 S ROW=$P(NODE,"^",4)
 S HDR=$P(NODE,"^",2)
 I HDR]" ",ROW=+ROW,COL=+COL
 E  S HDR=""
 S DISP=$P(NODE,"^",7)
 S FNAME=$P(NODE,"^")
 S ALLOWED=$P(NODE,"^",9)
 D:HDR]"" DRWSTR^IBDFU(+ROW,+COL,HDR,DISP)
 ;
 ;print the choices
 S FID="M"_FIELD
 S CHOICE=0 F  S CHOICE=$O(^IBE(357.93,FIELD,1,CHOICE)) Q:'CHOICE  D
 .S NODE=$G(^IBE(357.93,FIELD,1,CHOICE,0))
 .S ID=$P(NODE,"^",8) ;the ID of the choice
 .S LABEL=$P(NODE,"^",5)
 .S COL=$P(NODE,"^",2)
 .S ROW=$P(NODE,"^",3)
 .S DISP=$P(NODE,"^",4)
 .I LABEL]" ",ROW=+ROW,COL=+COL
 .E  S LABEL=""
 .D:LABEL]"" DRWSTR^IBDFU(ROW,COL,LABEL,DISP)
 .S COL=$P(NODE,"^",6)
 .S ROW=$P(NODE,"^",7)
 .S QLFR=$P(NODE,"^",9)
 .I ROW=+ROW,COL=+COL D DRWBBL^IBDFM1(ROW,COL,PI,ID,FNAME,FID,ALLOWED,LABEL,HDR,QLFR)
 Q
