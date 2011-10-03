ORCMENU ;SLC/MKB-Add Orders menus ; 08 May 2002  2:12 PM
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**7,41,46,48,141**;Dec 17, 1997
 ;
EN ; -- main entry point
 Q:'+$G(ORVP)  ;I '+$G(ORVP) D EN^ORQPT Q:'+$G(ORVP)
 S ORPTLK=$$LOCK^ORX2(+ORVP) I 'ORPTLK D  Q  ; lock pt chart
 . W !!,$C(7),$P(ORPTLK,U,2) H 2 S VALMBCK=""
 I $G(OREVENT),$G(^ORE(100.2,+OREVENT,1)) W !!,$C(7),$$NAME^OREVNTX(OREVENT)_" has been terminated!" H 2 S VALMBCK="" Q
 D FULL^VALM1 S VALMBCK="R",ORACTION=0
 W !!,"<"_$S($G(OREVENT):"Delayed ",1:"")_"Orders for "_$P($G(^DPT(+ORVP,0)),U)_">"
 I $G(OREVENT) D  ;show delay message
 . W !!,"Now writing orders for "_$$NAME^OREVNTX(OREVENT)
 . W !,"(To add orders for current release rather than delayed, quit the following"
 . W !,"menu and return to viewing Active Orders via the Delayed Orders action.)"
 . W !!,"Press <return> to continue ..." N X R X:DTIME
 I '$G(ORL),'$G(OREVENT) S ORL=$$LOCATION^ORCMENU1 G:ORL["^" ENQ
 S ORNP=$$PROVIDER^ORCMENU1 G:ORNP="^" ENQ
 S ORENT="ALL^"_$G(ORL)_$S($G(^VA(200,DUZ,5)):"^SRV.`"_+$G(^(5)),1:"")
 S ORMENU=$$GET^XPAR(ORENT,"OR ADD ORDERS MENU") Q:ORMENU'>0
 D EN^VALM("OR ADD ORDERS MENU"),REBLD:$D(ORTAB)
ENQ K ORPTLK,OREBUILD,ORMENU,ORENT,^TMP("ORMENU",$J),^TMP("ORECALL",$J),ZTSAVE
 D:'$D(^TMP("ORNEW",$J)) UNLOCK^ORX2(+ORVP) ;unlock if no new orders
 Q
 ;
REBLD ; -- Rebuild tab listings
 I $G(ORTAB)="ORDERS" D TAB^ORCHART(ORTAB,1) Q
 S:$D(^TMP("OR",$J,"ORDERS",0)) $P(^(0),U)="" ; force rebld of Orders tab
 D:$G(ORTAB)="NEW" INIT^ORCMENU2 ; called from RV - rebuild list
 Q
 ;
INIT ; -- init variables and list array
 ;    Requires ORMENU  = IFN of menu in Order Dialog file #101.41
 ;    Optional OREVENT = Event pointer
 ;
 N X,CW,MW,TITLE,ROWS,ROW,COL,Z,CNT,MNEM,TEXT,POS,ITEM,IFN,PROTOCL,FLAG,XQORM
 S Z=$$MSG^ORXD(+ORMENU) I Z W !!,$P(Z,U,2) S VALMQUIT=1 H 2 Q  ;disabled
 S Z=$$LOCK^ORDD41(+ORMENU) I 'Z W !!,$P(Z,U,2) S VALMQUIT=1 H 2 Q
 X:$D(^ORD(101.41,ORMENU,3)) ^(3) I $D(ORFORGET) D  K ORFORGET
 . I ORFORGET K ^TMP("ORECALL",$J,+ORFORGET) ;kill dlg
 . E  K ^TMP("ORECALL",$J) ;kill all
 S CW=$P($G(^ORD(101.41,ORMENU,5)),U),MW=$P($G(^(5)),U,2),TITLE=$P(^(0),U,2)
 S:'CW CW=80 S:'MW MW=5 S ROWS=$$ROWS(ORMENU) I 'ROWS S VALMQUIT=1 Q
 S PROTOCL=$O(^ORD(101,"B","ORC ADD ITEM",0))_"^1"
 S (POS,CNT)=0,XQORM=ORMENU_";ORD(101.41,"
IN1 F  S POS=$O(^XUTL("XQORM",XQORM,POS)) Q:POS'>0  S ITEM=^(POS,0) D
 . S ROW=$P(POS,"."),COL=$$COLUMN($P(POS,".",2),CW) Q:ROW'>0
 . S IFN=$P(ITEM,U,2),TEXT=$P(ITEM,U,3),MNEM=$P(ITEM,U,4),FLAG=$P(ITEM,U,5)
 . I FLAG="H" S Z=$E(TEXT,1,CW) D SETVIDEO(ROW,COL,$L(Z),IOUON,IOUOFF)
 . I FLAG'="H" S Z=MNEM_$E("         ",1,MW-$L(MNEM))_$E(TEXT,1,CW-MW)
 . S X(ROW,0)=$$SETSTR^VALM1(Z,$G(X(ROW,0)),COL,CW),CNT=CNT+1
 . I $L(MNEM) S X("KEY",MNEM)=PROTOCL S:'$L(FLAG)&IFN X("IDX",MNEM)=IFN_U_POS D SETVIDEO(ROW,COL,MW,IOINHI,IOINORM)
 S X("KEY","ALL")=$O(^ORD(101,"B","ORC ADD ALL ITEMS",0))_"^1"
 S X("KEY","CWAD")=$O(^ORD(101,"B","ORC CWAD DISPLAY",0))_"^1"
 S X("KEY","PI")=$O(^ORD(101,"B","ORC PATIENT INQUIRY",0))_"^1"
INQ S X(0)=ROWS_U_CNT_U_CW_U_MW_U_$G(OREVENT),VALMCNT=ROWS
 M ^TMP("ORMENU",$J,ORMENU)=X,^TMP("VALM VIDEO",$J,VALMEVL)=X("VIDEO")
 I $L(TITLE),$$UP^XLFSTR(TITLE)'?1"ADD ".E S TITLE="Add "_TITLE
 S VALM("TITLE")=$S($L(TITLE):TITLE,1:"Add New Orders")_$S($G(OREVENT):" for Delay",1:"")
 Q
 ;
ROWS(MENU) ; -- Returns the number of rows in MENU
 N MAX,I,R S MAX=0
 S I=0 F  S I=$O(^ORD(101.41,MENU,10,"B",I)) Q:I=""  S R=$P(I,".") I R>MAX S MAX=R
 Q MAX
 ;
COLUMN(NUM,WIDTH) ; -- Returns position of column NUM per WIDTH
 N Y S:'$G(NUM) NUM=1 S:'$G(WIDTH) WIDTH=80
 S Y=(NUM-1)*WIDTH+1
 Q Y
 ;
SETVIDEO(LINE,COL,WIDTH,ON,OFF) ; -- set video attributes
 S X("VIDEO",LINE,COL,WIDTH)=ON,X("VIDEO",LINE,COL+WIDTH,0)=OFF
 Q
 ;
MSG() ; -- Message bar
 Q "Enter the number of each item you wish to order."
 ;
HELP ; -- help code
 N X D FULL^VALM1 S VALMBCK="R"
 W !!,"Enter the items you wish to order for this patient, as a list or range of",!,"numbers.  When you are done placing orders, enter Q to return to the",!,"patient's chart."
 W !!,"You may also enter PI to get additional patient information, or CWAD for",!,"access to this patient's crisis and warning notes."
 W !!,"Press <return> to continue ..." R X:DTIME
 Q
 ;
KILL ; -- Cleanup after Add New Orders option
 I $D(^TMP("ORNEW",$J)) D EN^ORCMENU2,NOTIF^ORCMENU2 ; sign & release
 K ORVP,ORSEX,ORPNM,ORSSN,ORL,ORDOB,ORAGE,ORPD,ORNP,ORSC,ORTS,ORWARD,ORATTEND,OREBUILD,^TMP("ORNEW",$J)
 Q
 ;
EXIT ; -- exit code
 X:$D(^ORD(101.41,ORMENU,4)) ^(4) ; exit action
 K ^TMP("ORMENU",$J,ORMENU) D UNLOCK^ORDD41(+ORMENU)
 Q
 ;
ALT ; -- XQORM("ALT") lookup
 N XQORM,Y,ORX,ORY,ORI,IFN,POS,ITEM
 S ORX=X D FULL^VALM1 S VALMBCK="R",X=ORX
 S XQORM=+ORMENU_";ORD(101.41,",XQORM(0)="E"
 D EN^XQORM Q:Y'>0  M ORY=Y S ORI=0
 F  S ORI=$O(ORY(ORI)) Q:ORI'>0  S X=$P(ORY(ORI),U,4),IFN=$P(ORY(ORI),U,2),ITEM=$G(^ORD(101.41,+ORMENU,10,+$P(ORY(ORI),U),0)),POS=$P(ITEM,U) D ITM Q:$G(XQORPOP)
 Q
 ;
ALL ; -- process all menu items
 N ORI,ITEM,X,IFN,POS S ORI=""
 F  S ORI=$O(^TMP("ORMENU",$J,+ORMENU,"IDX",ORI)) Q:ORI=""  S X=ORI,ITEM=$G(^(ORI)),IFN=+$P(ITEM,U),POS=$P(ITEM,U,2) D ITM Q:$G(XQORPOP)
 Q
 ;
ITEM ; -- process menu item
 N X,ITEM,IFN,POS S VALMBCK="R"
 S X=$P(XQORNOD(0),U,3),ITEM=$G(^TMP("ORMENU",$J,ORMENU,"IDX",X))
 S IFN=+$P(ITEM,U) Q:'IFN  S POS=$P(ITEM,U,2)
ITM ; -- may enter here with IFN=Dlg, POS=position
 N ROW,COL,CW,MW,TYPE,ORIT,PS S VALMBCK="R"
 S ROW=$P(POS,"."),COL=$P(POS,".",2) S:'COL COL=1
 S CW=$P(^TMP("ORMENU",$J,ORMENU,0),U,3),MW=$P(^(0),U,4),COL=COL-1*CW+1
 D CNTRL^VALM10(ROW,COL+MW,CW-MW,IORVON,IORVOFF)
 S TYPE=$P($G(^ORD(101.41,IFN,0)),U,4)
 D MENU:TYPE="M" I TYPE'="M" S ORIT=IFN D FREEZE,EN^ORCDLG(IFN)
 S:$G(DIROUT) XQORPOP=1 ; stop processing items
 S PS=$P($G(^ORD(101.41,ORMENU,5)),U,3),VALMBCK=$S(PS:"R",1:"Q")
 Q
 ;
MENU ; -- display sub-menu
 N ORMENU S ORMENU=IFN
 D EN^VALM("OR ADD ORDERS MENU")
 Q
 ;
ORDER ; -- place order(s)
 N ORDIALOG,ORIT,TITLE D FREEZE
 S (ORIT,ORDIALOG)=IFN,TITLE=$P($G(^ORD(101.41,+ORDIALOG,0)),U,2)
 W !!,?(36-($L(TITLE)\2)),"-- "_TITLE_" --"
 D SET^ORCDLG:TYPE="O",ADD^ORCDLG:TYPE'="O" ; order set or single order?
 K ^TMP("ORWORD",$J)
 Q
 ;
SEARCH ; -- free text search of Orderable Items file
 N ORDIALOG,DIC,OI
 S OI=$O(^ORD(101.41,"AB","OR GTX ORDERABLE ITEM",0)),VALMBCK="R"
 S DIC=101.43,DIC(0)="AEQM",DIC("A")="Select ORDER: "
 D FULL^VALM1,^DIC Q:Y'>0
 S ORDIALOG(OI,1)=Y ;,ORDIALOG=DG default dialog
 D ADD^ORCDLG
 S VALMBCK="R"
 Q
 ;
FREEZE ; -- Freeze header, reset right margin
 Q:'VALMCC  N X S X=IOM X ^%ZOSF("RM")
 S IOTM=VALM("TM"),IOBM=IOSL W IOSC,@IOSTBM,IORC
 Q
