ORCONVRT ; SLC/MKB - Convert protocols/menus to Dialogs ;9/15/97  15:38
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**14**;Dec 17, 1997
EN ; -- Loop thru protocol menus currently in use
 Q:$P($G(^ORD(100.99,1,200)),U,2)  ; completed
 N ORDUZ,ORPMENU,ORDMENU,ORNDNG,ORMNAM
 S ORPMENU=$P($G(^ORD(100.99,1,0)),U,9) ; site default menu
 I ORPMENU["ORD(101," S ORDMENU=$$MENU(+ORPMENU) D:ORDMENU EN^XPAR("SYS","OR ADD ORDERS MENU",1,"`"_ORDMENU)
 S ORDUZ=+$G(^ORD(100.99,1,200)) Q:ORDUZ<0  ; done
 F  S ORDUZ=$O(^VA(200,ORDUZ)) Q:ORDUZ'>0  D  D LAST(ORDUZ)
 . S ORPMENU=$P($G(^VA(200,ORDUZ,100.1)),U,2) Q:'ORPMENU  ; no menu
 . S ORDMENU=$$MENU(ORPMENU) W:IOST?1"C-".E "."
 . D:ORDMENU EN^XPAR(ORDUZ_";VA(200,","OR ADD ORDERS MENU",1,"`"_ORDMENU)
 D LAST(-1)
 ; convert defaults if needed
 F ORNDNG="CLINICIAN","NURSE","WARD CLERK" D
 . S ORMNAM="ORZ ADD MENU "_ORNDNG
 . Q:'$O(^ORD(101,"B",ORMNAM,0))!$O(^ORD(101.41,"AB",ORMNAM,0))
 . S ORPMENU=$O(^ORD(101,"B",ORMNAM,0)),ORDMENU=$$MENU(+ORPMENU)
 D END
 Q
 ;
LAST(USER) ; -- Save last user preference converted
 S ^ORD(100.99,1,200)=USER_U_$S(USER<0:1,1:"")
 Q
 ;
MENU(PMENU) ; -- Returns dialog ifn for PMENU protocol
 N DMENU,XQORM,ORPOS,XUTL,PITEM,DITEM,ROW,COL,POS,NODE0,NODE4,TYPE,FRMT,PITM0,I
 S NODE0=$G(^ORD(101,PMENU,0)),NODE4=$G(^(4)),TYPE=$P(NODE0,U,4),DMENU=""
 G:'$L(NODE0) MNQ G:'$L($P(NODE0,U)) MNQ ; protocol deleted
 S DMENU=$O(^ORD(101.41,"AB",$E($P(NODE0,U),1,63),0))
 I DMENU,$P($G(^ORD(100.99,1,101,PMENU,0)),U,2)<0 G MNQ ; done
 S DMENU=$$DIALOG(PMENU) I 'DMENU S PITEM=PMENU D DLG G MNQ
 S ^ORD(101.41,DMENU,0)=$P(NODE0,U,1,3)_"^M",^(5)=$P(NODE4,U,1,3)
 S XQORM=PMENU_";ORD(101," D XREF^XQORM ;force ^XUTL to rebuild
 S ORPOS=+$P($G(^ORD(100.99,1,101,PMENU,0)),U,2)
MN1 F  S ORPOS=$O(^XUTL("XQORM",XQORM,ORPOS)) Q:ORPOS'>0  D  S ^ORD(100.99,1,101,PMENU,0)=PMENU_U_ORPOS
 . S XUTL=$G(^XUTL("XQORM",XQORM,ORPOS,0)),PITEM=+$P(XUTL,U,2)
 . Q:'PITEM  S PITM0=$G(^ORD(101,PITEM,0))
 . S ROW=$P(ORPOS,"."),COL=$P(ORPOS,".",2),POS=ROW_"."_COL
 . S FRMT=$S($P(XUTL,U,5)="O":1,$P(XUTL,U,5)="H":2,$P(PITM0,U)?1"ORB BLANK LINE".E:1,$P(PITM0,U,4)="T":1,1:""),DITEM="" Q:FRMT&($P(XUTL,U,3)?1." ")
 . I FRMT Q:$D(^ORD(101.41,DMENU,10,"B",POS))  ;already added
 . I 'FRMT S DITEM=$$ITEM(PITEM) Q:'DITEM  Q:$D(^ORD(101.41,"AD",DITEM,DMENU))
 . S DA=$$NEXT(DMENU),^ORD(101.41,DMENU,10,DA,0)=POS_U_DITEM_U_$P(XUTL,U,4)_U_$P(XUTL,U,3)_U_FRMT,^ORD(101.41,DMENU,10,"B",POS,DA)=""
 . S:DITEM ^ORD(101.41,"AD",DITEM,DMENU,DA)="",^ORD(101.41,DMENU,10,"D",DITEM,DA)=""
 S ^ORD(100.99,1,101,PMENU,0)=PMENU_"^-1" ; done
 I $L($G(^ORD(101,PMENU,15)))!$L($G(^(20))) D
 . Q:$G(^ORD(101,PMENU,15))="K ORSPU"&($G(^(20))="S XQORFLG(""SH"")=1 D EN^OR3")
 . D MCODE
MNQ Q DMENU
 ;
NEXT(MENU,DINUM) ; -- Returns next available item DA
 N I,HDR,LAST,TOTAL,DA
 S HDR=$G(^ORD(101.41,MENU,10,0)) S:HDR="" HDR="^101.412IA^^"
 S LAST=+$P(HDR,U,3),TOTAL=+$P(HDR,U,4)
 I $G(DINUM),'$D(^ORD(101.41,MENU,10,DINUM,0)) S I=DINUM
 E  F I=(LAST+1):1 Q:'$D(^ORD(101.41,MENU,10,I,0))
 S DA=I,$P(HDR,U,3,4)=DA_U_(TOTAL+1),^ORD(101.41,MENU,10,0)=HDR
 Q DA
 ;
ITEM(PITEM) ; -- Returns ifn of dialog for PITEM protocol
 N DITEM,NAME,NMSP,TYPE
 S DITEM=$G(^ORD(101,PITEM,0)),TYPE=$P(DITEM,U,4),NAME=$P(DITEM,U)
 I '$L(NAME) S DITEM="" G ITQ ; protocol deleted
 I TYPE'?1U D PROTCL S DITEM="" G ITQ ; missing type
 S NMSP=$$GET1^DIQ(9.4,+$P(DITEM,U,12)_",",1),DITEM=""
 I (TYPE="Q")!(TYPE="M") S DITEM=$$MENU(PITEM) G ITQ ; sub-menu
 S DITEM=$O(^ORD(101.41,"AB",$E(NAME,1,63),0)) G:DITEM ITQ ; done
 I TYPE="D" D DLG^ORCONV0 G ITQ ; dialog
 I TYPE="X" D SET^ORCONV0 G ITQ ; extended action -> order set
 I TYPE'="O",TYPE'="L",TYPE'="A" S DITEM="" G ITQ ; not orderable
 D EN^ORCONV1 ; pkg quick orders
ITQ Q DITEM
 ;
INACTIVE(Y) ; -- Returns 1 or 0, if OrdItem is inactive
 N IDT S IDT=$G(^ORD(101.43,+Y,.1))
 I 'IDT Q 0
 I IDT>$$NOW^XLFDT Q 0
 Q 1
 ;
DIALOG(IFN) ; -- Returns ifn of dialog entry for protocol IFN
 N X,Y,DIC,DLAYGO,DD,DO,Z,NODE,TEXT
 S NODE=$G(^ORD(101,IFN,0)),X=$E($P(NODE,U),1,63) I X="" Q X
 S TEXT=$P(NODE,U,2) S:'$L(TEXT) TEXT=X
 I TEXT?1"Default Protocol for Rad".E,X?1"RA"1.N.E S TEXT=$$LOWER^VALM1($P(X," ",2,99))
 I $P(NODE,U,4)="T" S Z=$P($G(^ORD(101,IFN,101.04)),U,2) S:$L(Z) TEXT=Z_": " ;default prompt
 S DIC="^ORD(101.41,",DIC(0)="LX",DLAYGO=101.41 D ^DIC
 S Z=$S(Y>0:+Y,1:"")
 I Z S ^ORD(101.41,Z,0)=X_U_TEXT,^ORD(101.41,"C",$$UP^XLFSTR(TEXT),Z)="" M ^ORD(101.41,Z,2)=^ORD(101,IFN,1)
 Q Z
 ;
SET(PROMPT,VALUE,INST) ; -- Sets VALUE of PROMPT,INST in DEFAULT dlg into DITEM responses
 N P,D,TYPE
 S P=$O(^ORD(101.41,"AB",$E("OR GTX "_PROMPT,1,63),0)) Q:'P
 S D=$O(^ORD(101.41,DEFAULT,10,"D",+P,0)) Q:'D
 S CNT=$G(CNT)+1,^ORD(101.41,DITEM,6,CNT,0)=D_U_P_U_$S($G(INST):INST,1:1)
 S:$L(P) ^ORD(101.41,DITEM,6,"D",P,CNT)=""
 S TYPE=$P(^ORD(101.41,+P,1),U)
 I TYPE'="W" S ^ORD(101.41,DITEM,6,CNT,1)=VALUE
 I TYPE="W" M ^ORD(101.41,DITEM,6,CNT,2)=@VALUE
 Q
 ;
VALUE(STR,BEG) ; -- Return value of "var="
 N X,Y,I S X=$E(STR,BEG,999),Y=""
 S:$E(X)="""" X=$E(X,2,999) ; strip leading "
 F I=1:1:$L(X) S Z=$E(X,I) Q:(Z=",")!(Z=" ")!(Z="""")  S Y=Y_Z
 Q Y
 ;
ERRORS ; -- Error messages:
UNKPKG S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Unknown application protocol." Q
NONSTD S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Non-standard application protocol format." Q
PROTCL S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Missing required data in protocol." Q
UNABLE S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Unable to convert quick order." Q
DLG S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Unable to create a new entry in Order Dialog file." Q
OI S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_U_$S($G(DITEM):"Incomplete dialog entry - ",1:"")_"Missing or invalid orderable item(s)." Q
PROMPT S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Incomplete dialog entry - unable to create or match term to dialog prompt." Q
DUPL S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Incomplete dialog entry - duplicate prompt in Items." Q
STRTDT S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Incomplete dialog entry - unable to determine 'start date'." Q
MCODE S ^ORD(100.99,1,101.41,PITEM,0)=PITEM_"^Incomplete dialog entry - Entry or Exit Action present in menu." Q
 ;
END ; -- Send bulletin listing conversion problems
 N ORTEXT,CNT,IFN,ORERR K ^TMP("ORTEXT",$J)
 S (IFN,CNT)=0 F  S IFN=$O(^ORD(100.99,1,101,IFN)) Q:IFN'>0  S CNT=CNT+1
 S:CNT ^ORD(100.99,1,101,0)="^100.99101P^"_CNT_U_CNT S CNT=0
 S IFN=0 F  S IFN=$O(^ORD(100.99,1,101.41,IFN)) Q:IFN'>0  S CNT=CNT+1
 S:CNT ^ORD(100.99,1,101.41,0)="^100.99141P^"_CNT_U_CNT Q:CNT'>0
 S ORTEXT(1)=CNT_" protocols could not be converted."
 S ORTEXT(2)="These will be sent to "_$P(^VA(200,DUZ,0),U)_" in a bulletin."
 S ORTEXT(3)="Sending bulletin ..." D MES^XPDUTL(.ORTEXT)
 S XMB="OR CONVERSION ERRORS",XMDUZ="ORDER ENTRY/RESULTS REPORTING"
 S XMY(DUZ)="",XMB(1)=CNT,XMTEXT="^TMP(""ORTEXT"",$J,",(CNT,IFN)=0
 F  S IFN=$O(^ORD(100.99,1,101.41,IFN)) Q:IFN'>0  S ORERR=$G(^(IFN,0)) D
 . S CNT=CNT+1,^TMP("ORTEXT",$J,CNT)=$$LJ^XLFSTR(IFN,15)_$P(^ORD(101,IFN,0),U)
 . S CNT=CNT+1,^TMP("ORTEXT",$J,CNT)=$P(ORERR,U,2) ; error msg
 . S CNT=CNT+1,^TMP("ORTEXT",$J,CNT)="   " ; blank
 D EN^XMB,KILL^XM K ^TMP("ORTEXT",$J)
 Q
