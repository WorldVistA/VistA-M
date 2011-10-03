PRCN2237 ;SSI/SEB,ALA-Create 2237 from completed request ;[ 01/30/97  1:45 PM ]
 ;;1.0;Equipment/Turn-In Request;**3,11,12**;Sep 13, 1996
EN ;  Entry point to individual 2237
 S DIC("S")="I $P(^(0),U,7)=39!($P(^(0),U,7)=18)!($P(^(0),U,7)=19)",DIC="^PRCN(413,"
 S DIC(0)="AEQZ" D ^DIC K DIC("S") G EXIT:Y<0 S IN=+Y
 S PRCNTMP=$P(^PRCN(413,IN,0),U),P2237N=$S($D(^PRCS(410,"H",PRCNTMP)):0,1:1)
 I 'P2237N D
 . S DA=$O(^PRCS(410,"H",PRCNTMP,""))
 . W !!,"2237 on File - Editing Transaction #: ",$P(^PRCS(410,DA,0),U),! K DA
LIST ; Create 2237s for chosen requests
 D EN^PRCSUT G W2:'$D(PRC("SITE")) G EXIT:'$D(PRC("QTR"))!(Y<0)
 I P2237N D
 . D NEW S TDA=IN D LINE
 . ;  move justification
 . S ^PRCS(410,DA(1),8,0)=^PRCN(413,TDA,36,0)
 . S PRCNJ=0 F  S PRCNJ=$O(^PRCN(413,TDA,36,PRCNJ)) Q:'PRCNJ  S ^PRCS(410,DA(1),8,PRCNJ,0)=^PRCN(413,TDA,36,PRCNJ,0)
 . K DR S (DIC,DIE)="^PRCS(410,",DA=DA(1)
 . I $G(PRCNVNDR)'="",PRCNVNDR?.N S PRCNVNDR=$P(^PRC(440,PRCNVNDR,0),U)
 . S DR="56///^S X=60;11//^S X=$G(PRCNVNDR);11.1;11.2;11.3;11.4;11.5;11.6;11.7;11.8;11.9;13" D ^DIE
 . I $D(^PRCS(410,DA(1),"IT",1)) S ^PRCS(410,DA(1),10)=$O(^PRCS(410,DA(1),"IT",99),-1)_U_$P(^PRCS(410,DA(1),10),U,2,99)
 I 'P2237N D
 . S DA=$O(^PRCS(410,"H",PRCNTMP,"")),(DIC,DIE)="^PRCS(410,"
 . S DR="[PRCN2237E]" D ^DIE
 D CMP I $G(QFL)=1 W !!,$C(7),"2237 information is incomplete" G EXIT
 D W61^PRCSEB I $G(%)=2 G EXIT
 I $P($G(^PRCS(410,D0,7)),U,5)=""!($P($G(^(7)),U,7)="") G EXIT
 I +$G(SPENDCP)=0 D
 . S (DIE,DIC)="^PRCN(413,",DA=IN S:$G(PRCNT1)="" PRCNT1=$O(^PRCS(410,"H",PRCNTMP,""))
 . S DR="6///^S X=34;7///^S X=DT;50////^S X=PRCNT1" D ^DIE
 G EXIT
NEW ; Create new 2237 and fill in info from a finished request
 D EN1^PRCSUT3 G NQ:'X S X1=X D EN2^PRCSUT3 G NQ:'$D(X1) S X=X1,T1=DA
 W !!,"This transaction is assigned transaction number: ",X
 D LOCK^PRCSUT
 S PRCNT1=T1,DIC="^PRCS(410,"
 I $P(^PRCN(413,IN,0),U,14)'="" S SRTGRP=$P(^PRCN(413,IN,0),U,14)_";PRCS(410.7,"
 S DIE=DIC,DR="[PRCN2237]" D ^DIE
NQ K DIE,DA,DR,T1,X,X1 Q
W2 W $C(7),!!,"You are not an authorized control point user."
 W !,"Contact your control point official." S NGF=1
EXIT K %,C,D,DA,DIC,DIE,DQ,DR,PRCS,PRCS2,PRCSDAA,PRCSDR,PRCSL,PRCSTT,I,N
 K T,T1,T2,X,X1,PRCSX3,Y,PRCNTMP,QTY,COST,P2237N,PRCNT1,PRCNVNDR,TEST1
 K IN,PRC,CURQTR,CURQTR1,PRCHQ,PRCSN,PRCST,PRCST1,SPENDCP,STRING,TEST
 K %W,D0,DIW,DIWI,DIWT,DIWTC,DIWX,DN,OK,P1,PRCNJ,PRCSCP,PRCSERR,UTYP
 K PRCSPG,PRCSQT,RECORD,RECORD1,RECORD10,RECORD2,RECORD3,RECORD4
 K SKIPRNT,STKNO,TDA,TRNODE,XNAME,JUMP,POP,PRCSCST,QFL,PDD1,SRTGRP
 Q
LINE ; Line item copier, called from [PRCN2237] input template
 ;NEW DIEL,Y,DG,DI,DK,DL,DM,DP,DU,D0,D1,DA,DIC,DIE,DR,DOV
CPLINE ; Create a line item in 2237 and copy over line item from request
 N I S (I,C)=0 F  S I=$O(^PRCN(413,TDA,1,"B",I)) Q:I'>0  S C=C+1
 S DA=0 F  S DA=$O(^PRCN(413,TDA,1,DA)) Q:'DA  S LI=DA D L2 D  Q:$D(DUOUT)
 . W !!,"Line Item #",DA,":",!,"Description:"
 . F II=1:1 Q:'$D(^PRCN(413,IN,1,LI,1,II))  S DL=^(II,0) D
 .. W !,"    ",DL S ^PRCS(410,DA(1),"IT",LI,1,II,0)=DL
 . W ! S ^PRCS(410,DA(1),"IT",LI,1,0)="^^"_(II-1)_U_(II-1)_U_DT
 . I $P(^PRCN(413,IN,1,LI,0),U,12)="P",$P(^(0),U,2)'="" S PRCNVNDR=$P(^(0),U,2)
 . I $G(PRCNVNDR)="" S PRCNVNDR=$P(^PRCN(413,IN,1,LI,0),U,13)
 . D ^DIC Q:$G(DUOUT)=1!($G(DTOUT)=1)  D ^DIE
 K C,DLAYGO,DL,II,LI
 Q
L2 S DA(1)=PRCNT1,DIC(0)="LZ",DLAYGO=410,X=DA
 S (DIE,DIC)="^PRCS(410,"_DA(1)_",""IT"","
 I '$D(@(DIC_"0)")) S @(DIC_"0)")="^410.02AI^0^0"
 D FILE^DICN
 S QTY=$S($P(^PRCN(413,IN,1,LI,0),U,7)'="":$P(^(0),U,7),1:$P(^PRCN(413,IN,1,LI,0),U,5))
 S COST=$P(^PRCN(413,IN,1,LI,0),U,4),STKNO=$P(^(0),U,3)
 ; Special DRs to automatically copy line items from request
 S UTYP=$O(^PRCD(420.5,"B","EA","")) S:UTYP="" UTYP="EA"
 S (DR(1,410.02),DR)="2////^S X=QTY;3////^S X=UTYP;7////^S X=COST;4;6//^S X=STKNO;K PRCSV;10;S PRCSDR=""[2237]"""
 S DR(1,410.02,1)="S PRCSVAR=$S($D(^PRCS(410,DA(1),""IT"",0)):^(0),1:"""");K PRCSV D 2^PRCSCK;I $D(PRCSERR)&PRCSERR S Y=""@1"" K PRCSERR;D QRB^PRCSCK;12;K PRCSMDP;"
 Q
CMP ;  Check for completeness of data
 S PDD1=0 F  S PDD1=$O(^PRCS(410,D0,"IT",PDD1)) Q:'PDD1  D CMPD Q:QFL
 Q
CMPD S QFL=0 F I=1,2,3,4,7 I $P(^PRCS(410,D0,"IT",PDD1,0),U,I)="" S QFL=1
 Q
