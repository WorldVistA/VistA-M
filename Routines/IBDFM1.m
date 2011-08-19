IBDFM1 ;ALB/CJM - Compiling bubbles and hand print fields;3/1/93
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**13,25,38**;APR 24, 1997
 ;                                          
DRWBBL(ROW,COL,PI,VALUE,FNAME,FID,ALLOWED,DISPLAY,HDR,QLFR,DYN,CNT,SUBHDR,QTY,ND2,SLCTN) ;
 ;returns "" if no bubble created, else the ien
 ;
 N BUBBLE
 S DISPLAY=$E(DISPLAY,1,80),HDR=$E(HDR,1,40)
 S DISPLAY=$TR(DISPLAY,"""\","``")
 S DYN=+$G(DYN),CNT=+$G(CNT)
 ;
 ;don't want to associate a value with the bubble if there is no input interface for the type of data
 I 'PI S VALUE=""
 ;
 ;compiling blocks?
 I IBPRINT("COMPILING_BLOCKS") D CMPBBL Q:'IBPRINT("WRITE_IF_COMPILING")
 ;
 ;don't draw a bubble if in the list processor
 Q:IBDEVICE("LISTMAN")
 ;
 ;add the offsets for the block to position
 S ROW=ROW+IBBLK("Y"),COL=COL+IBBLK("X")
 ;
 ;might not be creating a FORM DEFINITION TABLE - case of toolkit form
 I IBFORM("TOOLKIT") S @IBARRAY("BUBBLES")@(ROW,COL)="" Q
 ;
 ;case of FORM DEFINITION TABLE being created - all forms but toolkit
 Q:IBFORM("COMPILED")="F"  ;something already went wrong
 I IBFORM("TYPE") I $D(^IBD(357.95,IBFORM("TYPE"),0))
 E  S IBFORM("TYPE")=$$NEWTABLE(.IBFORM)
 I 'IBFORM("TYPE") D UNCMPL^IBDF19(.IBFORM,1) Q
 ;
 ;add the bubble to the table
 K DIC,D0,DINUM,DD S DIC="^IBD(357.95,"_IBFORM("TYPE")_",1,",X=ROW,DA(1)=IBFORM("TYPE"),DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S BUBBLE=$S(+Y<0:"",1:+Y)
 I 'BUBBLE D UNCMPL^IBDF19(.IBFORM,1) Q
 I BUBBLE D
 .D INPUT^IBDFU91(PI,.VALUE) I '$D(VALUE) S VALUE=""
 .S ^IBD(357.95,IBFORM("TYPE"),1,BUBBLE,0)=ROW_"^"_COL_"^"_PI_"^"_VALUE_"^"_$G(FNAME)_"^"_FID_"^"_ALLOWED_"^"_DISPLAY_"^"_HDR_"^"_QLFR_"^"_DYN_"^"_CNT_"^"_$G(QTY)_"^"_$G(SLCTN)
 .I $L($G(SUBHDR)) S ^IBD(357.95,IBFORM("TYPE"),1,BUBBLE,1)=$E(SUBHDR,1,250)
 .I $L($G(ND2)) D
 ..; -- change external format of 2nd & 3rd codes to internal format
 ..N IBJ,IBVAL F IBJ=3,4 S IBVAL=$P(ND2,"^",IBJ) I IBVAL]"" D INPUT^IBDFU91(PI,.IBVAL) S $P(ND2,"^",IBJ)=$S($D(IBVAL):IBVAL,1:"")
 ..S ^IBD(357.95,IBFORM("TYPE"),1,BUBBLE,2)=ND2
 .K DIK,DA S DIK="^IBD(357.95,"_IBFORM("TYPE")_",1,",DA=BUBBLE,DA(1)=IBFORM("TYPE") D IX1^DIK K DIK,DA
 Q
 ;
NEWTABLE(IBFORM) ;creates a new FORM DEFINITION table
 ;returns the ien of the table created, "" if not created
 N NODE,SUB,CNT
 S IBFORM("TYPE")=$$FORMTYPE^IBDF18D(1)
 Q:'IBFORM("TYPE")
 S NODE=$G(^IBE(357,IBFORM,0))
 S $P(^IBD(357.95,IBFORM("TYPE"),0),"^",9,19)=$P(NODE,"^",9,19) ;not all  19 pieces may exist
 S $P(^IBD(357.95,IBFORM("TYPE"),0),"^",20,21)=DT_"^"_IBFORM
 S $P(^IBE(357,IBFORM,0),"^",13)=IBFORM("TYPE")
 S (CNT,SUB)=0 F  S SUB=$O(^IBE(357,IBFORM,2,SUB)) Q:'SUB  S NODE=$G(^IBE(357,IBFORM,2,SUB,0)) Q:('+NODE)!('$P(NODE,"^",2))  S CNT=CNT+1,^IBD(357.95,IBFORM("TYPE"),3,CNT,0)=+NODE_"^1",^IBD(357.95,IBFORM("TYPE"),3,"B",+NODE,CNT)=""
 S $P(^IBD(357.95,IBFORM("TYPE"),3,0),"^",3,4)=CNT_"^"_CNT
 Q IBFORM("TYPE")
 ;
CMPBBL ;save compiled bubbles for the block
 S IBWRTCNT("B")=IBWRTCNT("B")+1
 S ^IBE(357.1,IBBLK,"B",IBWRTCNT("B"),0)=ROW_"^"_COL_"^"_PI_"^"_VALUE_"^"_FNAME_"^"_FID_"^"_ALLOWED_"^"_DISPLAY_"^"_HDR_"^"_QLFR_"^"_DYN_"^"_CNT_"^"_$G(QTY)_"^"_$G(SLCTN)
 I $L($G(SUBHDR)) S ^IBE(357.1,IBBLK,"B",IBWRTCNT("B"),1)=$E(SUBHDR,1,250)
 I $L($G(ND2)) S ^IBE(357.1,IBBLK,"B",IBWRTCNT("B"),2)=ND2
 Q
 ;
CMPHAND ;save compiled hand print fields for the block
 S IBWRTCNT("H")=IBWRTCNT("H")+1
 S ^IBE(357.1,IBBLK,"H",IBWRTCNT("H"),0)=ROW_"^"_COL_"^"_WIDTH_"^"_PI_"^^"_LINES_"^"_FID_"^"_FNAME_"^"_HDR_"^"_QLFR_"^^"_ITEM_"^^"_PRINT_"^"_READ_"^^"_TYPEDATA
 Q
 ;
DRWHAND(ROW,COL,WIDTH,PI,LINES,FID,FNAME,HDR,QLFR,ITEM,PRINT,READ,TYPEDATA) ;creates hand print field
 N NODE
 S NODE=""
 ;
 S ITEM=$G(ITEM),PRINT=$G(PRINT),READ=$G(READ),TYPEDATA=$G(TYPEDATA)
 ;returns "" if no hand print field created, else the ien
 Q:('$D(ROW))!('$D(COL))
 N HANDPRNT
 S HDR=$E(HDR,1,40)
 ;
 ;compiling blocks?
 I IBPRINT("COMPILING_BLOCKS") D CMPHAND Q:'IBPRINT("WRITE_IF_COMPILING")
 ;
 ;don't draw hand print field if in the list processor
 Q:IBDEVICE("LISTMAN")
 ;
 ;add the offsets for the block to position
 S ROW=ROW+IBBLK("Y"),COL=COL+IBBLK("X")
 ;
 ;might not be creating a FORM DEFINITION TABLE - case of toolkit form
 I IBFORM("TOOLKIT") D  Q
 .N CNT S CNT=+$G(@IBARRAY("HAND_PRINT"))+1
 .S @IBARRAY("HAND_PRINT")@(ROW,COL,CNT)=ROW_"^"_COL_"^"_WIDTH_"^"_PI_"^"_FNAME_"^"_LINES_"^^"_FID_"^"_HDR_"^"_QLFR_"^^"_ITEM_"^^"_PRINT_"^"_READ_"^^"_TYPEDATA
 ;
 ;case of FORM DEFINITION TABLE being created - all forms but toolkit
 Q:IBFORM("COMPILED")="F"  ;something already went wrong
 I IBFORM("TYPE") I $D(^IBD(357.95,IBFORM("TYPE"),0))
 E  S IBFORM("TYPE")=$$NEWTABLE(.IBFORM)
 ;if 'IBFORM("TYPE") want to recompile this next time around
 I 'IBFORM("TYPE") D UNCMPL^IBDF19(.IBFORM,1) Q
 ;
 ;add the handprint field to the table
 K DIC,D0,DINUM,DD S DIC="^IBD(357.95,"_IBFORM("TYPE")_",2,",X=ROW,DA(1)=IBFORM("TYPE"),DIC(0)=""
 D FILE^DICN K DIC,DIE,DA
 S HANDPRNT=$S(+Y<0:"",1:+Y)
 I 'HANDPRNT D UNCMPL^IBDF19(.IBFORM,1) Q
 I HANDPRNT D
 .S ^IBD(357.95,IBFORM("TYPE"),2,HANDPRNT,0)=ROW_"^"_COL_"^"_WIDTH_"^"_PI_"^"_FNAME_"^"_LINES_"^^"_FID_"^"_HDR_"^"_QLFR_"^^"_ITEM_"^^"_PRINT_"^"_READ_"^^"_TYPEDATA
 .K DIK,DA S DIK="^IBD(357.95,"_IBFORM("TYPE")_",2,",DA=HANDPRNT,DA(1)=IBFORM("TYPE") D IX1^DIK K DIK,DA
 Q
 ;
TRACKBBL(FID,COUNT,QLFR,PI,DISPLAY,VALUE) ;
 ;IBPFID, the id in form tracking, should be defined
 ;
 ; -- do not re-file dynamic data if reprint
 Q:$G(REPRINT)
 ;N SUB,NODE
 ;S NODE=$G(^IBD(357.96,IBPFID,1,0))
 ;S SUB=$P(NODE,"^",3)
 ;S SUB=SUB+1,$P(NODE,"^",3,4)=SUB_"^"_SUB
 ;D INPUT^IBDFU91(PI,.VALUE) I '$D(VALUE) S VALUE=""
 ;S ^IBD(357.96,IBPFID,1,SUB,0)=COUNT_"^^"_PI_"^"_VALUE_"^^"_FID_"^^"_DISPLAY_"^^"_QLFR
 ;S ^IBD(357.96,IBPFID,1,0)=NODE
 ;K DIK,DA S DIK="^IBD(357.96,IBPFID,1,",DA=SUB,DA(1)=IBPFID D IX^DIK K DIK,DA
 ;
 ; -- for problem list, move the narrative to one piece for storing
 S DISPLAY=$$DISP(DISPLAY)
 ;
 D INPUT^IBDFU91(PI,.VALUE) I '$D(VALUE) S VALUE=""
 S X=COUNT
 S DLAYGO=357.96
 S DIC="^IBD(357.96,IBPFID,1,"
 S DIC(0)="L"
 S DIC("P")=$P(^DD(357.96,1,0),"^",2)
 S DA(1)=IBPFID
 S DIC("DR")=".03////^S X=PI;.04////^S X=VALUE;.06////^S X=FID;.08////^S X=$E(DISPLAY,1,80);.1////^S X=QLFR"
 K DD,DO D FILE^DICN K DIC,DA,DLAYGO,DD,DO
 Q
 ;
DISP(DIS) ; -- display narrative :: piece
 N I,J
 S DIS=$E($G(DIS),1,80)
 G:DIS="" DISPQ
 G:DIS'[" :: " DISPQ
 I $P(DIS," :: ",2,99)="" S DIS=$P(DIS," :: ",1) G DISPQ
 ;
 F I=1:1 D  Q:$P(DIS," :: ",2,99)=""
 . ;
 . ; -- sometimes the string contains "nnnnn ::  ::  :: narrative"
 . I $E(DIS,1,4)=" :: " S DIS=$E(DIS,5,80) Q
 . ;
 . ; -- get rid of leading spaces
 . F J=1:1 Q:$E(DIS)'=" "  S DIS=$E(DIS,2,80)
 . ;
 . ; -- get rid of piece one if Numeric code
 . I +DIS>0 S DIS=$P(DIS," :: ",2,99) Q
 . ;
 . ; -- get rid of piece one if alpha numeric (cpt) code
 . I +DIS=0,$P(DIS," :: ",1)?1U4N S DIS=$P(DIS," :: ",2,99) Q
 . ;
 . ; -- get rid of piece one if alpha numeric icd code
 . I +DIS=0,$P(DIS," :: ",1)?1U2.3N.1".".2N S DIS=$P(DIS," :: ",2,99) Q
 . ;
 . ; -- must be text in piece one, use it as text
 . I +DIS=0 S DIS=$P(DIS," :: ",1) Q
DISPQ I DIS=" :: " S DIS="Unknown"
 Q DIS
