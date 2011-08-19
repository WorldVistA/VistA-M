ORCMEDIT ;SLC/MKB-Menu Editor ;4/19/01  11:27
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,95,263**;Dec 17, 1997;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
EN ; -- start here
 S ORMENU=$$MENU D:ORMENU EN^VALM("OR MENU EDITOR")
 Q
 ;
NEW ; -- Change menu
 D FULL^VALM1 S VALMBCK="R",VALMBG=1
 N X S X=$$MENU(ORMENU)
 I X,+X'=+ORMENU S ORMENU=X D INIT,HDR
 Q
 ;
MENU(OROLD) ; -- Select/edit [new] menu
 N DIC,X,Y,DLAYGO,ORNEW,DA,DIK
MN1 S DIC="^ORD(101.41,",DIC(0)="AEQL",DLAYGO=101.41,DIC("DR")="4///^S X=""M"""
 S DIC("A")="Select ORDER MENU: ",DIC("S")="I $P(^(0),U,4)=""M"""
 S:$G(OROLD) DIC("B")=$P(OROLD,U,2) D ^DIC I Y'>0 Q "^"
 L +^ORD(101.41,+Y,0):1 I '$T W !!,"Another user is currently editing this menu!",! G MN1
 L +^XUTL("XQORM",+Y_";ORD(101.41,","XQORM PROTECT",$J):1 E  W !!,"Cannot access menu at this time - try again later.",! G MN1
 S ORNEW=Y I $P(ORNEW,U,3),$$COPY("M") D
 . K DLAYGO,DIC("B") S DIC(0)="AEQZ",DIC("A")="Select MENU TO COPY: "
 . D ^DIC Q:Y'>0  W !,"Copying menu items ..."
 . M ^ORD(101.41,+ORNEW,10)=^ORD(101.41,+Y,10) ; menu items
 . M ^ORD(101.41,+ORNEW,2)=^ORD(101.41,+Y,2) ; description
 . S:$D(^ORD(101.41,+Y,5)) ^ORD(101.41,+ORNEW,5)=^ORD(101.41,+Y,5)
 . S X=$P(Y(0),U,2),$P(^ORD(101.41,+ORNEW,0),U,2)=X S:X'="" ^ORD(101.41,"C",$$UP^XLFSTR(X),+ORNEW)="" ; display text
 . S DA(1)=+ORNEW,DIK="^ORD(101.41,"_+ORNEW_",10,",DIK(1)="2^AD" D ENALL^DIK
 I $P(ORNEW,U,3) S DA=+ORNEW,DIE="^ORD(101.41,",DR="2;20;51;52;53"_$S($G(DUZ(0))="@":";30;40",1:"") D ^DIE
 I $G(OROLD) L -^ORD(101.41,+OROLD,0),-^XUTL("XQORM",+OROLD_";ORD(101.41,","XQORM PROTECT",$J)
 Q ORNEW
 ;
COPY(TYPE) ; -- Returns 1 or 0, if new item is to be a copy
 N X,Y,DIR,ITEM S ITEM=$S(TYPE="M":"menu",TYPE="Q":"quick order",TYPE="O":"order set",1:"order dialog")
 S DIR(0)="YA",DIR("A")="Do you wish to copy an existing "_ITEM_"? "
 S DIR("?")="Enter YES to copy the items from an existing "_ITEM_" into this one",DIR("B")="YES"
 D ^DIR
 Q +Y
 ;
EDIT ; -- Edit menu fields
 N DA,DR,DIE,OR0,OR5,ORNAME D FULL^VALM1 S VALMBCK="R"
 S ORNAME=$$NAME^ORCMEDT4(+ORMENU) Q:ORNAME="^"
 I ORNAME="@" S VALMBCK="Q" Q  ;deleted - quit ListMgr
 S OR0=$G(^ORD(101.41,+ORMENU,0)),OR5=$G(^(5))
 S DR=".01///^S X=ORNAME;2;20;51;52;53"_$S($G(DUZ(0))="@":";30;40",1:"")
 S DIE="^ORD(101.41,",DA=+ORMENU D ^DIE
 I OR0=$G(^ORD(101.41,+ORMENU,0)),OR5=$G(^(5)) Q  ; no change
 W !!,"Rebuilding menu display ..." D INIT,HDR
 Q
 ;
VIEW ; -- Toggle display between Name and Display Text
 N OR0 S OR0=$G(^TMP("ORMENU",$J,0))
 S OR0=$P(OR0,U,1,4)_U_$S($P(OR0,U,5)="I":"E",1:"I")
 S ^TMP("ORMENU",$J,0)=OR0,VALMBCK="R"
 W !!,"Rebuilding menu display ..." D INIT
 Q
 ;
INIT ; -- init variables and list array
 N X,ROWS,ROW,COL,CW,MW,POS,CNT,ITEM,IFN,MNEM,TEXT,FLAG,LINE,XQORM,I,NAME,INT,DA,TS
 S INT=$P($G(^TMP("ORMENU",$J,0)),U,5) ; int/ext flag
 D CLEAN^VALM10,KILL(+ORMENU) ; kill array for rebuilding
 S ROWS=$P($O(^ORD(101.41,+ORMENU,10,"B",""),-1),".")
 S VALMCNT=$S(ROWS>51:ROWS,1:51) ; 3 full screens of row #
 F ROW=1:1:VALMCNT D  ; set-up grid
 . S X=$S((ROW/10)=(ROW\10):ROW/10,(ROW/5)=(ROW\5):"+",1:"|")
 . S ^TMP("ORMENU",$J,ROW,0)=X_$$REPEAT^XLFSTR(" ",79)
 S CW=$P($G(^ORD(101.41,+ORMENU,5)),U),MW=$P($G(^(5)),U,2)
 S:'CW CW=80 S:'MW MW=5 S XQORM=+ORMENU_";"_$J
 S CNT=0 G:'$O(^ORD(101.41,+ORMENU,10,0)) INQ ; new menu, no items yet
IN1 S POS=0 F  S POS=$O(^ORD(101.41,+ORMENU,10,"B",POS)) Q:POS'>0  S DA=0 F  S DA=$O(^ORD(101.41,+ORMENU,10,"B",POS,DA)) Q:'DA  D
 . S ROW=$P(POS,"."),COL=$$COLUMN($P(POS,".",2),CW)
 . S ITEM=$G(^ORD(101.41,+ORMENU,10,DA,0)),IFN=$P(ITEM,U,2)
 . S MNEM=$P(ITEM,U,3),FLAG=$P(ITEM,U,5) S:IFN ITM=$G(^ORD(101.41,IFN,0))
 . I INT="I" S TEXT=$S(IFN:$P(ITM,U),1:"")
 . I INT'="I" S TEXT=$P(ITEM,U,4) I '$L(TEXT),IFN S TEXT=$P(ITM,U,2)
 . Q:'$L(TEXT)  I FLAG=2 S TEXT=$E(TEXT,1,CW),X=TEXT D SETVIDEO(ROW,COL+1,$L($G(TEXT)),IOUON,IOUOFF)
 . I FLAG<2 S X=MNEM_$E("         ",1,MW-$L(MNEM))_$E(TEXT,1,CW-MW) D SETVIDEO(ROW,COL+1,MW,IOINHI,IOINORM)
 . S LINE=$G(^TMP("ORMENU",$J,ROW,0)),^TMP("ORMENU",$J,ROW,0)=$$SETSTR^VALM1(X,LINE,COL+1,CW),CNT=CNT+1,TEXT=$$STRIP(TEXT) Q:'$L(TEXT)
 . S ^TMP("ORMENU",$J,"B",$$UP(TEXT))=DA S:$L(MNEM) ^($$UP(MNEM))=DA
 . S ^XUTL("XQORM",XQORM,POS,0)=DA_U_IFN_U_TEXT_U_MNEM,^XUTL("XQORM",XQORM,"B",$$UP(TEXT),POS)="" S:$L(MNEM) ^XUTL("XQORM",XQORM,"B",$$UP(MNEM),POS)=1
 . I IFN,INT'="I" S NAME=$P(ITM,U) S:$L(NAME) ^XUTL("XQORM",XQORM,"B",$$UP(NAME),POS)=1
INQ S ^TMP("ORMENU",$J,0)=ROWS_U_CNT_U_CW_U_MW_U_INT ;,VALMBG=1
 M ^TMP("VALM VIDEO",$J,VALMEVL)=^TMP("ORMENU",$J,"VIDEO")
 S X="" F I=1:1 S COL=(I-1)*CW+1 Q:COL>80  S $E(X,COL)=I,ORCOL=I
 D CHGCAP^VALM("LINE",X) S TS=$G(^ORD(101.41,+ORMENU,99)) ; set caption heading
 S:$D(^XUTL("XQORM",XQORM)) ^(XQORM,"COL")=ORCOL,^(0)=TS
 Q
 ;
SETVIDEO(ROW,COL,WIDTH,ON,OFF) ; -- Set video attributes
 S ^TMP("ORMENU",$J,"VIDEO",ROW,COL,WIDTH)=ON
 S ^TMP("ORMENU",$J,"VIDEO",ROW,COL+WIDTH,0)=OFF
 Q
 ;
UP(X) ; -- Convert X to uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
STRIP(X) ; -- Strip leading spaces from text X
 N I,Y S Y=""
 F I=1:1:$L(X) I $E(X,I)'=" " S Y=$E(X,I,999) Q
 Q Y
 ;
COLUMN(NUM,WIDTH) ; -- Returns position for column NUM per WIDTH
 N Y S:'$G(NUM) NUM=1 S:'$G(WIDTH) WIDTH=80
 S Y=(NUM-1)*WIDTH+1
 Q Y
 ;
HDR ; -- header code
 N X,Y S X="Menu: "_$P(ORMENU,U,2)
 S Y="Column Width: "_$P($G(^TMP("ORMENU",$J,0)),U,3)
 S VALMHDR(1)=X_$$REPEAT^XLFSTR(" ",79-$L(X)-$L(Y))_Y
 Q
 ;
HELP ; -- help code
 N X D FULL^VALM1 S VALMBCK="R"
 W !,"  This is how this menu will appear to the user in the Add New Orders"
 W !,"  option.  Select ADD, REMOVE, or EDIT to make changes to this menu, or"
 W !,"  ASSIGN to set it as the default for users.  Use the ORDER DIALOGS option"
 W !,"  to change or create quick orders for this menu."
 W !,"Press <return> to continue ..." R X:DTIME
 Q
 ;
MSG() ; -- Msg bar
 Q "+ Next Screen  - Prev Screen  ?? More Actions"
 ;
EXIT ; -- exit code
 L -^ORD(101.41,+ORMENU,0),-^XUTL("XQORM",+ORMENU_";ORD(101.41,","XQORM PROTECT",$J)
 D KILL(+ORMENU) K VALMHDR,VALMCNT,VALMBG,ORMENU,ORCOL,^TMP("ORMENU",$J)
 Q
 ;
KILL(DA) ; -- Cleanup compiled menu from editor
 K ^XUTL("XQORM",DA_";"_$J)
 Q
