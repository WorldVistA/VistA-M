ORCMEDT1 ;SLC/MKB-QO,Set editor ; 7/18/11 10:46am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,57,95,110,245,243,296,341**;Dec 17, 1997;Build 3
OI ; -- Enter/edit generic orderable items
 N X,Y,DA,DR,DIE,DIC,ID,DLAYGO,ORDG
 F  S ORDG=$$DGRP Q:ORDG'>0  D  W !!
 . F  S D="S."_$P(ORDG,U,4) D   Q:Y'>0  S DA=+Y,ID=DA_";99ORD",DR=".01"_$S($P(Y,U,3):";2///^S X=ID;5////"_+ORDG,1:"") D ^DIE W ! ;110
 .. ;*341 Screen OI from editing if it isn't in the DG.
 .. S DIC("S")="I $P(^(0),U,5)="_+ORDG,DIC="^ORD(101.43,",DIC(0)="AEQL",DLAYGO=101.43,DIE=DIC D IX^DIC ;110
 Q
 ;
DGRP() ; -- Returns sub-display group of Nursing or Other for generic OI
 N X,Y,DIC,ORGRP,ORDG,ORI
 F ORI="NURS","OTHER" S ORDG=+$O(^ORD(100.98,"B",ORI,0)) D DG^ORCHANG1(ORDG,"BILD",.ORGRP)
 S DIC="^ORD(100.98,",DIC(0)="AEQ",DIC("S")="I $D(ORGRP(+Y))"
 S DIC("A")="Type of Orderable: " D ^DIC
 S:Y>0 Y=+Y_U_$G(^ORD(100.98,+Y,0))
 Q Y
 ;
QUICK ; -- Enter/edit quick order dialogs
 N ORQDLG,ORDG
 F  S ORQDLG=$$DIALOG^ORCMEDT0("Q") Q:ORQDLG="^"  D QCK0(ORQDLG) W !
 Q
QCK0(ORQDLG) ; -- edit quick order ORQDLG
 N ORDIALOG,DA,DR,DIE,DIDEL,ORQUIT,ORVP,ORL,ACTION,FIRST,ORTYPE,ORNAME,X,Y,BEFORCRC,AFTERCRC
 Q:'$G(ORQDLG)  S DA=ORQDLG,(ORVP,ORL)=0,FIRST=1,ORTYPE="Z"
 S ORNAME=$$NAME^ORCMEDT4(ORQDLG) Q:(ORNAME="@")!(ORNAME="^")  ;deleted,^
 S BEFORCRC=$$RAWCRC^ORCMEDT8(ORQDLG)
 S DR=".01///^S X=ORNAME;2;8;20"_$S(DUZ(0)="@":";30",1:""),DIE="^ORD(101.41,"
 D ^DIE G:$D(Y)!$D(DTOUT) QR  D GETQDLG^ORCD(ORQDLG) G:'$G(ORDIALOG) QR
 I '$P($G(^ORD(101.41,ORQDLG,0)),U,7) S X=+$P($G(^ORD(101.41,+ORDIALOG,0)),U,7) S:X $P(^ORD(101.41,ORQDLG,0),U,7)=X,^ORD(101.41,"APKG",X,ORQDLG)=""
 W ! I $D(^ORD(101.41,+ORDIALOG,3.1)) X ^(3.1) G:$G(ORQUIT) QQ
Q1 D DIALOG^ORCDLG G:$G(ORQUIT) QQ
 D DISPLAY^ORCDLG S ACTION=$$OK G:ACTION="^" QQ
 D:ACTION="P" SAVE^ORCMEDT0,AUTO(ORQDLG) I ACTION="E" S FIRST=0 G Q1 ;fall thru if "C"
QQ X:$D(^ORD(101.41,+ORDIALOG,4)) ^(4)
QR S AFTERCRC=$$RAWCRC^ORCMEDT8(ORQDLG)
 I BEFORCRC'=AFTERCRC D UPDQNAME^ORCMEDT8(ORQDLG) ; Rename personal quick order if modified
 Q
 ;
OK() ; -- Ready to save?
 N X,Y,DIR S DIR(0)="SAM^P:PLACE;E:EDIT;C:CANCEL;",DIR("B")="PLACE"
 S DIR("A")="(P)lace, (E)dit, or (C)ancel this quick order? "
 S DIR("?")="Enter P to save this quick order, or E to change any of the displayed values; enter C to quit without saving these responses"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
 ;
SAVE G SAVE^ORCMEDT0
 ;
AUTO(DLG) ; -- set AutoAccept flag for GUI
 N X,Y,DIR
 I $$VBQO^ORWDXM4(+DLG)=0 S $P(^ORD(101.41,+DLG,5),U,8)="" Q
 I $$VALQO^ORWDXM3(+DLG)=0 S $P(^ORD(101.41,+DLG,5),U,8)="" Q
 S DIR(0)="YA",DIR("A")="Auto-accept this order? "
 S DIR("B")=$S($P($G(^ORD(101.41,+DLG,5)),U,8):"YES",1:"NO")
 S DIR("?")="Enter YES if this order can be placed simply by selecting it, or NO if the dialog should be presented to complete the order."
 D ^DIR S:Y=1!(Y=0) $P(^ORD(101.41,+DLG,5),U,8)=$S(Y:1,1:"")
 I $P($G(^ORD(101.41,+DLG,0)),"^",8)'=1&($P($G(^(0)),"^",9)=2)&(Y) D EXPLAIN S $P(^ORD(101.41,+DLG,5),"^",8)="" ;Reset auto-accept to no if explanation required. 
 Q
 ;
SET ; -- Order Sets
 N ORSET,ORDG
 F  S ORSET=$$DIALOG^ORCMEDT0("O") Q:ORSET="^"  D SET0(ORSET) W !
 Q
SET0(ORSET) ; -- edit order set ORSET
 N DA,DR,DIE,DIC,DIK,X,Y,SEQ,ITM,LCNT,QUIT,ORNAME Q:'$G(ORSET)
 S ORNAME=$$NAME^ORCMEDT4(ORSET) Q:(ORNAME="@")!(ORNAME="^")  ;deleted,^
 S DR=".01///^S X=ORNAME;2;20"_$S(DUZ(0)="@":";30;40",1:""),DA=ORSET
 S DIE="^ORD(101.41," D ^DIE Q:$D(Y)  Q:'$G(DA)
S1 I $O(^ORD(101.41,+ORSET,10,0)) D  Q:QUIT  ;Show existing components
 . W !,"ORDER SET COMPONENTS:" S (SEQ,LCNT,QUIT)=0
 . S DIK="^ORD(101.41,"_+ORSET_",10,",DA(1)=+ORSET ;just in case
 . F  S SEQ=$O(^ORD(101.41,+ORSET,10,"B",SEQ)) Q:SEQ'>0  D
 . . S DA=0 F  S DA=$O(^ORD(101.41,+ORSET,10,"B",SEQ,DA)) Q:DA'>0  D
 . . . S ITM=$P($G(^ORD(101.41,+ORSET,10,DA,0)),U,2) I ITM'>0 D ^DIK Q
 . . . S LCNT=LCNT+1 I LCNT>(IOSL-3) R !,"Press <return> to continue ...",X:DTIME S LCNT=0 I X["^" S QUIT=1 Q
 . . . W !?3,SEQ,?10,$P(^ORD(101.41,ITM,0),U)
S2 S QUIT=0 F  D  Q:QUIT  W ! ;Enter/edit components
 . S DIC="^ORD(101.41,"_+ORSET_",10,",DIC(0)="AEQLM",D="B^D"
 . S DIC("A")="Select COMPONENT SEQUENCE#: ",DIC("P")=$P(^DD(101.41,10,0),U,2)
 . K DA S DA(1)=+ORSET D MIX^DIC1 I Y'>0 S QUIT=1 Q
 . S DA=+Y,DIE=DIC,DR=".01;2R" D ^DIE Q:'$G(DA)
 . I $D(^ORD(101.41,+ORSET,10,DA,0)),'$P(^(0),U,2) S DIK=DIE D ^DIK
 Q
 ;
PROTOCOL ; -- Convert additional protocols to dialogs
 N X,Y,DIC,ORERR
 F  S DIC="^ORD(101,",DIC(0)="AEQM" D ^DIC Q:Y'>0  D  W !
 . S ORP=+Y,ORM=$$MENU Q:ORM="^"  ; What about "^^"-jumping? (ORWARD)
 . W !,"Converting ..." D ONE(ORP,ORM,.ORERR) I '$G(ORERR) W " done." Q
 . W " unable to convert.",!,">> "_$P(ORERR,U,2) K ORERR
 Q
ONE(PITEM,ORADD,ERROR) ; -- Convert single item protocol, add to menu(s)
 N PMENU,DMENU,NAME,ORPOS,POS,XUTL,DA,DIK
 I $D(^ORD(100.99,1,101.41,PITEM,0)) S DA=PITEM,DA(1)=1,DIK="^ORD(100.99,1,101.41," D ^DIK ; delete error entry
 S NAME=$P($G(^ORD(101,PITEM,0)),U),DITEM=$$ITEM^ORCONVRT(PITEM)
 I 'DITEM!$D(^ORD(100.99,1,101.41,PITEM,0)) S ERROR=$G(^(0)) Q
 Q:'$G(ORADD)  ;to add, may enter here with PITEM & DITEM defined
ADD S PMENU=0 F  S PMENU=$O(^ORD(101,"AD",PITEM,PMENU)) Q:PMENU'>0  D  W "."
 . S DMENU=$O(^ORD(101.41,"AB",$P(^ORD(101,PMENU,0),U),0)) Q:'DMENU
 . S ORPOS=$$FINDXUTL(PMENU,PITEM) Q:'ORPOS
 . S XUTL=$G(^XUTL("XQORM",PMENU_";ORD(101,",ORPOS,0))
 . S DA=$O(^ORD(101.41,DMENU,10,"B",ORPOS,0)) I DA Q:$P(^ORD(101.41,DMENU,10,DA,0),U,2)=DITEM  S POS=$O(^ORD(101.41,DMENU,10,"B",""),-1),ORPOS=($P(POS,".")+1)_".1",DA="" ; move to end, if collision
 . S DA=$$NEXT^ORCONVRT(DMENU)
 . S ^ORD(101.41,DMENU,10,DA,0)=ORPOS_U_DITEM_U_$P(XUTL,U,4)_U_$S($P(XUTL,U,3)'=$P(^ORD(101.41,DITEM,0),U,2):$P(XUTL,U,3),1:"")
 . S ^ORD(101.41,DMENU,10,"B",ORPOS,DA)="",^ORD(101.41,DMENU,10,"D",DITEM,DA)=""
 . S ^ORD(101.41,"AD",DITEM,DMENU,DA)="",^ORD(101.41,DMENU,99)=$H
 Q
 ;
FINDXUTL(MENU,ITEM) ; -- Returns position of ITEM in MENU
 N XQORM,POS
 S XQORM=MENU_";ORD(101," D XREF^XQORM
 S POS=0 F  S POS=$O(^XUTL("XQORM",XQORM,POS)) Q:POS'>0  I $P(^(POS,0),U,2)=ITEM Q
 Q POS
 ;
MENU() ; -- Add converted item to menus?
 N X,Y,DIR S DIR(0)="YA"
 S DIR("A")="Add this item to the same menus again? ",DIR("B")="YES"
 S DIR("?")="Enter YES to have this item placed on the same menus in the Order Dialog file as it was in the Protocol file"
 D ^DIR S:$D(DTOUT) Y="^"
 Q Y
EXPLAIN ;Give reason why user can't set auto-accept to yes
 W !!,"The combination of VERIFY set to NO and ASK FOR ANOTHER ORDER set to",!,"YES, DON'T ASK and AUTO-ACCEPT set to YES is not allowed."
 W !!,"This combination of settings could cause CPRS to enter into an infinite loop",!,"creating the same order over and over.  If you wish to have"
 W !,"AUTO-ACCEPT set to YES you must change one of the other two fields",!,"to a different value.",!!,"AUTO-ACCEPT is being set to NO for you."
 Q
