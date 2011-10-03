ORDD41 ;slc/KCM,MKB-Build menus in XUTL (file 101.41) ;10:36 AM  11 Feb 1999
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**4,46,57**;Dec 17, 1997
SET(DLG) ; -- create dialog menu in ^XUTL("XQORM")
 Q:$D(^ORD(101.41,DLG,0))[0  Q:$P(^(0),U,4)'="M"
 N ITM,POS,COL,ROW,XQORM,TXT,PTR,X,R,C
 S (POS,COL,ROW)=0,XQORM=DLG_";ORD(101.41,"
 F  S POS=$O(^ORD(101.41,DLG,10,"B",POS)) Q:POS=""  S ITM=0 D
 . F  S ITM=$O(^ORD(101.41,DLG,10,"B",POS,ITM))  Q:ITM'>0  D
 . . S X=$G(^ORD(101.41,DLG,10,ITM,0)),PTR=$P(X,U,2)
 . . S TXT=$S($L($P(X,U,4)):$P(X,U,4),PTR:$P($G(^ORD(101.41,+PTR,0)),U,2),1:""),TXT=$TR(TXT,",=;-","    ") Q:'$L(TXT)
 . . S ^XUTL("XQORM",XQORM,POS,0)=ITM_U_PTR_U_TXT_U_$P(X,U,3)_U_$TR($P(X,U,5),"120","OH")
 . . S:$P(POS,".",2)>COL COL=$P(POS,".",2) Q:'PTR  Q:$P(X,U,5)
 . . S ^XUTL("XQORM",XQORM,"B",$$UP(TXT),POS)="" ;text
 . . S:$L($P(X,U,3)) ^XUTL("XQORM",DLG_";ORD(101.41,","B",$$UP($P(X,U,3)),POS)=1 ;mnemonic
 . S:$P(POS,".")>ROW ROW=$P(POS,".") ;hold last row
 F R=1:1:ROW F C=1:1:COL S POS=R_"."_C S:'$D(^XUTL("XQORM",XQORM,POS,0)) ^(0)="^^   ^^O" ;blank
 S X=$H,^XUTL("XQORM",DLG_";ORD(101.41,",0)=X,^("COL")=COL
 S ^ORD(101.41,DLG,99)=X
 Q
 ;
KILL(DLG) ; -- Cleanup ^XUTL("XQORM")
 K ^XUTL("XQORM",DLG_";ORD(101.41,")
 Q
 ;
UP(X) ;Convert X to upper case
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ;
REDO ; -- Rebuild menu in ^XUTL when changed
 I $D(^ORD(101.41,DA,0)) S ^(99)=$H
 Q
 ;
REDOM ; -- Rebuild menu(s) in ^XUTL when DISPLAY TEXT changed
 N X,MENU S X=$H
 I $D(^ORD(101.41,DA,0)) S ^(99)=X
 S MENU=0 F  S MENU=$O(^ORD(101.41,"AD",DA,MENU)) Q:MENU'>0  I $D(^ORD(101.41,MENU,0)) S ^(99)=X
 Q
 ;
REDOX ; -- Rebuild menu in ^XUTL when ITEMS changed
 I $D(^ORD(101.41,+$G(DA(1)),0)) S ^(99)=$H
 Q
 ;
TREE ; -- Ck menu tree to ensure new item is not an ancestor
 ;    Input Xform for Item field #2 of Items subfile #101.412
 ;      expecting DA, DA(1), X from FileMan
 N ORDDA,ORDD S ORDDA=DA(1)
 K:X=ORDDA X D TREE1
 Q
TREE1 ; -- Look for X in ancestors
 F ORDD=0:0 Q:'$D(X)  S ORDD=$O(^ORD(101.41,"AD",ORDDA,ORDD)) Q:ORDD'>0  K:X=ORDD X Q:'$D(X)  D TREE2
 Q
TREE2 ; -- Back up another level
 N ORDDA S ORDDA=ORDD N ORDD D TREE1
 Q
 ;
LIST(MENU) ; -- List items on MENU for ?-help in editor
 N XQORM,TXT,POS,LCNT,QUIT,ITEM S (LCNT,QUIT)=0,TXT=""
 S XQORM=+$G(MENU)_";"_$J Q:'$D(^XUTL("XQORM",XQORM))
 F  S TXT=$O(^XUTL("XQORM",XQORM,"B",TXT)) Q:TXT=""  D  Q:QUIT
 . S POS=0 F  S POS=$O(^XUTL("XQORM",XQORM,"B",TXT,POS)) Q:POS'>0  Q:^(POS)  D  Q:QUIT
 . . S ITEM=$G(^XUTL("XQORM",XQORM,POS,0)),LCNT=LCNT+1
 . . I LCNT>(IOSL-2) R !,"Press <return> to continue ...",X:DTIME S LCNT=0 I X["^" S QUIT=1 Q
 . . W !?3,$P(ITEM,U,4),?10,$P(ITEM,U,3),$S($P(ITEM,U,2):"  ["_$P($G(^ORD(101.41,+$P(ITEM,U,2),0)),U)_"]",1:"")
 Q
 ;
LOCK(MENU) ; -- Lock [and rebuild?] Order Dialog menu
 N OK,XQORM S OK=1,XQORM=+MENU_";ORD(101.41,"
 I $S('XQORM:1,'$D(^ORD(101.41,+MENU,0)):1,1:0) S OK="0^Invalid menu." G LKQ
 I $D(^XUTL("XQORM",XQORM,0)),$P(^XUTL("XQORM",XQORM,0),U)'=$P($G(^ORD(101.41,+MENU,99)),U) D REBLD(+MENU)
 I '$D(^XUTL("XQORM",XQORM,0)) D REBLD(+MENU,.OK) G:'OK LKQ
 L +^XUTL("XQORM",XQORM,"XQORM PROTECT",$J):10 E  S OK="0^Can't access menu at this time - try again later."
LKQ Q OK
 ;
UNLOCK(MENU) ; -- Unlock Order Dialog menu
 L -^XUTL("XQORM",+MENU_";ORD(101.41,","XQORM PROTECT",$J)
 Q
 ;
REBLD(MENU,RES) ; -- Lock, rebuild Order Dialog menu
 N XQORM,DIE,DA,DR
 S XQORM=+MENU_";ORD(101.41,",DIE="^ORD(101.41,",DA=+MENU,DR="99///"_$H
 L +(^XUTL("XQORM",XQORM),^ORD(101.41,+MENU)):5 E  S RES="0^Can't access menu at this time - try  again later." Q
 D ^DIE S RES=1
 L -(^XUTL("XQORM",XQORM),^ORD(101.41,+MENU))
 Q
