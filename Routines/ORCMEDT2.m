ORCMEDT2 ;SLC/MKB-Menu Editor cont ;9/4/01  14:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,95**;Dec 17, 1997
SELECT(ACTION,Y) ; -- Select item from menu
 N X,XQORM K Y S XQORM=+ORMENU_";"_$J
 S XQORM(0)="Ah",XQORM("A")="Select Item(s): ",XQORM("??")="D LIST^ORDD41(+ORMENU)"
 S X="Enter the items you wish to "_ACTION_", either by mnemonic or text.",XQORM("?")="W !,"""_X_""""
 D EN^XQORM
 Q
 ;
ADDITM ; -- Add new item(s) to menu
 N DA,DR,DIE,DONE,OREBLD,DLG,ROW,COL,POS
 D FULL^VALM1 S VALMBCK="R"
 S DA(1)=+ORMENU,DIE="^ORD(101.41,"_DA(1)_",10,"
 S:'$D(^ORD(101.41,+ORMENU,10,0)) ^(0)="^101.412AI^^"
 S (DONE,OREBLD)=0 F  D  Q:DONE  W !
 . S DLG=$$ITEM^ORCMEDT0 I DLG'>0 S DONE=1 Q
ADD1 . S ROW=$$ROW Q:ROW="^"
 . S COL=$$COL Q:COL="^"  S POS=ROW_"."_COL
 . I $D(^ORD(101.41,+ORMENU,10,"B",POS)) W $C(7),!,"There is another item in this position already!" G:'$$SHIFT("down") ADD1 D INSERT(POS)
 . S DA=$$NEXT(POS) Q:'DA  S OREBLD=1
 . S DR="2////"_DLG_";4;3" D ^DIE
 I OREBLD W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT S VALMBCK="R"
 Q
 ;
ADDTXT ; -- Add new text to menu
 N DA,DR,DIE,DONE,OREBLD,TXT,ROW,COL,POS,HDR
 D FULL^VALM1 S VALMBCK="R",DIE="^ORD(101.41,"_+ORMENU_",10,"
 S:'$D(^ORD(101.41,+ORMENU,10,0)) ^(0)="^101.412AI^^"
 S (DONE,OREBLD)=0 F  D  Q:DONE  W !
 . S TXT=$$TEXT I "^"[TXT S DONE=1 Q
AT1 . S ROW=$$ROW Q:ROW="^"
 . S COL=$$COL Q:COL="^"  S POS=ROW_"."_COL
 . I $D(^ORD(101.41,+ORMENU,10,"B",POS)) W $C(7),!,"There is another item in this position already!" G:'$$SHIFT("down") AT1 D INSERT(POS)
 . S HDR=$$OUTPUT Q:HDR="^"
 . S DA=$$NEXT(POS) Q:'DA  S OREBLD=1
 . S DR="4///"_TXT_";5///"_HDR D ^DIE
 I OREBLD W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT S VALMBCK="R"
 Q
 ;
ADDROW ; -- Add new row to menu
 N X,Y,DIR
 S DIR(0)="NAO^1:999",DIR("A")="ROW: ",VALMBCK=""
 S DIR("?")="Enter the number of the row where the new line should appear; all menu items in and below this row number will be shifted down one line."
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)!(Y="")
 D INSERT(+Y) S VALMBCK="R"
 W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT
 Q
 ;
TEXT(X) ; -- Display text
 N Y,DIR
 S DIR(0)="FAO^1:80",DIR("A")="DISPLAY TEXT: " S:$L($G(X)) DIR("B")=X
 S DIR("?",1)="Enter the text to be displayed on this menu.  The following characters" ;**95
 S DIR("?",2)="are not allowed -;,=^  Text longer than the column width will" ;**95
 S DIR("?")="not wrap and will not display correctly." ;**95
ASK D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^" S:X="@" Y=$S($D(DIR("B")):"@",1:"") ;**95
 I Y'="^" I $$CHKNAM^ORUTL(Y) W $C(7),"??",!,"You may not use these characters in your display text -;,=^" G ASK ;If text doesn't pass input transfrom then ask again **95
 Q Y
 ;
OUTPUT(Z) ; -- Output flag
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="HEADER: ",DIR("B")=$S($G(Z)=2:"YES",1:"NO")
 S DIR("?")="Enter YES if this text is to be a header, underlined and displaying over the mnemonic; to display this text normally, enter NO."
 D ^DIR S Z=$S($D(DTOUT)!$D(DUOUT):"^",Y:2,1:1)
 Q Z
 ;
NEXT(POS) ; -- Returns next available DA in ORMENU
 N I,HDR,LAST,TOTAL,DA
 S HDR=$G(^ORD(101.41,+ORMENU,10,0)),TOTAL=+$P(HDR,U,4)
 S LAST=$O(^ORD(101.41,+ORMENU,10,"?"),-1)
 S I=LAST F I=(I+1):1 Q:'$D(^ORD(101.41,+ORMENU,10,I,0))
 S DA=I,^ORD(101.41,+ORMENU,10,DA,0)=POS,$P(HDR,U,3,4)=DA_U_(TOTAL+1)
 S ^ORD(101.41,+ORMENU,99)=$H,^(10,0)=HDR,^("B",POS,DA)=""
 Q DA
 ;
REMOVE ; -- Remove item(s) from menu
 N DA,DIK,ORY,ORI,ORDEL,ORPOS
 D FULL^VALM1 S VALMBCK="R"
 D SELECT("remove",.ORY) Q:ORY'>0  Q:'$$SURE
 S ORDEL=$$SHIFT("up") Q:ORDEL="^"
 S DA(1)=+ORMENU,DIK="^ORD(101.41,"_DA(1)_",10,"
 S ORI=0 F  S ORI=$O(ORY(ORI)) Q:'ORI  S DA=+ORY(ORI),ORPOS=$P(^ORD(101.41,+ORMENU,10,DA,0),U) D ^DIK,DELETE(ORPOS):ORDEL
 W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT
 Q
 ;
REMROW ; -- Remove row from menu
 N X,Y,DIR,ORPOS,ORDEL,OROW,DA,DIK
 S DIR(0)="NAO^1:999",DIR("A")="ROW: ",VALMBCK=""
 S DIR("?")="Enter the number of the row to clear items from"
 D ^DIR Q:$D(DTOUT)!$D(DUOUT)!(Y="")  S OROW=+Y Q:'$$SURE
 S ORDEL=$$SHIFT("up",1) Q:ORDEL="^"  S VALMBCK="R"
 S DA(1)=+ORMENU,DIK="^ORD(101.41,"_DA(1)_",10,"
 S ORPOS=OROW F  S ORPOS=$O(^ORD(101.41,+ORMENU,10,"B",ORPOS)) Q:$P(ORPOS,".")'=OROW  S DA=$O(^(ORPOS,0)) D:DA ^DIK
 D:ORDEL DELETE(OROW)
 W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT
 Q
 ;
SURE() ; -- Are you sure?
 N X,Y,DIR W !
 S DIR(0)="YA",DIR("A")="Are you sure you want to remove these items? "
 S DIR("?")="Enter YES if you want to remove these items from this menu; NO will cancel this action."
 D ^DIR
 Q +Y
 ;
MOVE ; -- Move item(s) in menu
 N STOP,OREBLD,DA,DR,DIE,NODE0,ROW,COL,POS,NEW
 D FULL^VALM1 S VALMBCK="R"
 S DA(1)=+ORMENU,DIE="^ORD(101.41,"_DA(1)_",10,"
 D SELECT("move",.ORY) Q:ORY'>0
 S (STOP,OREBLD,ORI)=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  D  Q:STOP  W !
 . S DA=+ORY(ORI),NODE0=$G(^ORD(101.41,+ORMENU,10,DA,0)),POS=$P(NODE0,U)
MV1 . S ROW=$$ROW($P(POS,".")) I ROW="^" S STOP=1 Q
 . S COL=$$COL($P(POS,".",2)) I COL="^" S STOP=1 Q
 . S NEW=ROW_"."_COL Q:NEW=POS
 . I $D(^ORD(101.41,+ORMENU,10,"B",NEW)) W $C(7),!,"There is another item in this position already!" G:'$$SHIFT("down") MV1 D INSERT(NEW)
 . S OREBLD=1,DR=".01///"_NEW D ^DIE
 I OREBLD W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT S VALMBCK="R"
 Q
 ;
ROW(X) ; -- Edit row placement
 N Y,DIR
 S DIR(0)="NA^1:999",DIR("A")="ROW: " S:$G(X) DIR("B")=X K X
 S DIR("?")="Enter the row in which you want this item to appear, by number"
 D ^DIR S:$D(DTOUT)!$D(DUOUT)!(Y="") Y="^"
 Q Y
 ;
COL(X) ; -- Edit column placement
 N Y,DIR
 S DIR(0)="NA^1:"_ORCOL,DIR("A")="COLUMN: " S:$G(X) DIR("B")=X K X
 S DIR("?")="Enter the number of the column in which you want this item to be placed."
 D ^DIR S:$D(DTOUT)!$D(DUOUT)!(Y="") Y="^"
 Q Y
 ;
SHIFT(DIRECTN,ROW) ; -- Resolve collision
 N X,Y,DIR
 S DIR(0)="YA",DIR("B")="YES"
 S DIR("A")="Do you want to shift items "_$S('$G(ROW):"in this column ",1:"")_DIRECTN_"? "
 S DIR("?")="Enter YES to move the entries "_$S('$G(ROW):"in this column ",1:"")_DIRECTN_" one line"
 D ^DIR S:$D(DTOUT)!$D(DUOUT) Y="^"
 Q Y
 ;
INSERT(Y) ; -- Make room for item at position Y
 N CP,POS,DA S CP=$P(Y,".",2),POS=999.999
 F  S POS=$O(^ORD(101.41,+ORMENU,10,"B",POS),-1) Q:POS<Y  I (CP="")!($P(POS,".",2)=CP) S DA=$O(^(POS,0)) D
 . S X=($P(POS,".")+1)_"."_$P(POS,".",2),$P(^ORD(101.41,+ORMENU,10,DA,0),U)=X
 . S ^ORD(101.41,+ORMENU,10,"B",X,DA)="" K ^ORD(101.41,+ORMENU,10,"B",POS)
 Q
 ;
DELETE(Y) ; -- Remove item at position Y
 N CP,POS,DA S POS=Y,CP=$P(Y,".",2)
 F  S POS=$O(^ORD(101.41,+ORMENU,10,"B",POS)) Q:POS'>0  I (CP="")!($P(POS,".",2)=CP) S DA=$O(^(POS,0)) D
 . S X=($P(POS,".")-1)_"."_$P(POS,".",2),$P(^ORD(101.41,+ORMENU,10,DA,0),U)=X
 . S ^ORD(101.41,+ORMENU,10,"B",X,DA)="" K ^ORD(101.41,+ORMENU,10,"B",POS)
 Q
 ;
EDIT ; -- Edit item(s) in menu
 N STOP,OREBLD,DA,DR,DIE,OR0,ORY,ORI,PTR,ROW,COL,POS,NEWPOS,ORDG,P
 D FULL^VALM1,SELECT("change",.ORY) S VALMBCK="R" Q:ORY'>0
 S (STOP,OREBLD,ORI)=0 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  D  Q:STOP  W !
 . S DA=+ORY(ORI),OR0=$G(^ORD(101.41,+ORMENU,10,DA,0)),PTR=+$P(OR0,U,2)
 . S DIE("NO^")="OUTOK",DA(1)=+ORMENU,DIE="^ORD(101.41,"_DA(1)_",10,"
 . I PTR S P=$$ITEM^ORCMEDT0(PTR) S:'P STOP=1 I P S DR=$S(P'=PTR:"2////"_P_";",1:"")_"4;3" D ^DIE S:$D(Y) STOP=1 ;^ or timeout
 . I 'PTR D  Q:STOP  ;edit #4&5
 . . N X1,X2 S X1=$P(OR0,U,4),X2=$P(OR0,U,5)
ED0 . . S X1=$$TEXT($P(OR0,U,4)) I X1="^" S STOP=1 Q
 . . I X1="@" G:'$$SURE ED0 S DIK=DIE,(STOP,OREBLD)=1 D ^DIK Q
 . . S X2=$$OUTPUT(X2) S:X2="^" STOP=1,X2=$P(OR0,U,5)
 . . S ^ORD(101.41,+ORMENU,99)=$H,$P(^(10,DA,0),U,4,5)=X1_U_X2
 . S:OR0'=$G(^ORD(101.41,+ORMENU,10,DA,0)) OREBLD=1,OR0=$G(^(0))
 . Q:$G(STOP)  S PTR=+$P(OR0,U,2)
ED1 . S POS=$P(OR0,U),ROW=$$ROW($P(POS,".")) I ROW="^" S STOP=1 Q
 . S COL=$$COL($P(POS,".",2)) I COL="^" S STOP=1 Q
 . S NEWPOS=ROW_"."_COL G:POS=NEWPOS ED2 ; no change
 . I $D(^ORD(101.41,+ORMENU,10,"B",NEWPOS)) W $C(7),!,"There is another item in this position already!" G:'$$SHIFT("down") ED1 D INSERT(NEWPOS)
 . S OREBLD=1,DR=".01///"_NEWPOS D ^DIE
ED2 . Q:'PTR  S TYPE=$P($G(^ORD(101.41,PTR,0)),U,4),ORDG=+$P($G(^(0)),U,5)
 . I TYPE'="M",$$EDTITM(TYPE) D QCK0^ORCMEDT1(PTR):TYPE="Q",SET0^ORCMEDT1(PTR):TYPE="O",EN1^ORCMEDT3(PTR):TYPE="D"
 I OREBLD W !!,"Rebuilding menu display ..." D INIT^ORCMEDIT S VALMBCK="R"
 Q
 ;
EDTITM(X) ; -- Edit item itself?
 N Y,DIR S DIR(0)="YA",DIR("B")="YES",Y=""
 S:X="Q" DIR("A")="Edit this quick order? ",DIR("?")="Enter YES to edit the responses in this quick order, or NO to exit."
 S:X="O" DIR("A")="Edit this order set? ",DIR("?")="Enter YES to edit the orders in this set, or NO to exit."
 S:X="D" DIR("A")="Edit this order dialog? ",DIR("?")="Enter YES to edit the prompts in this dialog, or NO to exit."
 I $D(DIR("A")) D ^DIR S:$D(DTOUT)!(X["^") Y="^"
 Q Y
