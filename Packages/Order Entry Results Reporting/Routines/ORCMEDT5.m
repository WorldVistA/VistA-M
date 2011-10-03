ORCMEDT5 ;SLC/MKB-Misc menu utilities ;03:29 PM  12 Feb 1999
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,296**;Dec 17, 1997;Build 19
SEARCH ; -- Search/replace menu items
 N ORDLG
 F  S ORDLG=$$DIC Q:ORDLG'>0  D SR1(ORDLG) W !!
 Q
 ;
SR1(ORX) ; -- list parents, get replacement
 N DA,DR,DIE,DIK,I,J,ORDAD,ORY,ORNMBR,NUM,ORI,ORDAD,ORNM
 I '$O(^ORD(101.41,"AD",+ORX,0)) W !,$P(ORX,U,2)_" has no menu items." Q
 W @IOF,"Menu items of "_$P(ORX,U,2),!?4,"Name",?69,"Type",!,$$REPEAT^XLFSTR("-",79)
 S (I,ORDAD)=0 F  S I=$O(^ORD(101.41,"AD",+ORX,I)) Q:I'>0  D
 . S J=0 F  S J=$O(^ORD(101.41,"AD",+ORX,I,J)) Q:J'>0  D
 . . S ORDAD=ORDAD+1,ORDAD(ORDAD)=I_U_J
 . . W !,ORDAD,?4,$P(^ORD(101.41,I,0),U),?69,$$TYPE($P(^(0),U,4))
 W !,$$REPEAT^XLFSTR("-",79)
 S ORY=$$REPLWITH(ORX) Q:ORY="^"
 D SELECT(ORY,ORDAD,.ORNMBR) Q:ORNMBR="^"
 Q:'$$OK  W !!,$S(ORY="@":"Removing",1:"Replacing "_$P(ORX,U,2)_" with "_$P(ORY,U,2))_" in:"
 F ORI=1:1:$L(ORNMBR,",") S NUM=$P(ORNMBR,",",ORI) I NUM D
 . S DA(1)=+ORDAD(NUM),DA=$P(ORDAD(NUM),U,2),DIE="^ORD(101.41,"_DA(1)_",10,"
 . S ORDAD=DA(1),ORNM=$P(^ORD(101.41,ORDAD,0),U) W !?3,ORNM_" ..."
 . I '$$VALID(ORY,ORDAD,.ORERR) D  Q
 . . W "not "_$S(ORY="@":"removed.",1:"changed."),!?3,">> "_$G(ORERR)
 . . S I=0 F  S I=$O(ORERR(I)) Q:I'>0  W !?25,"=>"_ORERR(I)
 . I ORY="@" S DIK=DIE D ^DIK W "done." Q
 . S DR="2////"_+ORY D ^DIE W $S($P(^ORD(101.41,DA(1),10,DA,0),U,2)=+ORY:"done.",1:"error - not replaced.")
 Q
 ;
TYPE(X) ; -- Returns name of dialog type
 N Y S Y=$S(X="P":"prompt",X="D":"dialog",X="Q":"quick order",X="O":"order set",X="M":"menu",X="A":"action",1:"")
 Q Y
 ;
DIC() ; -- ^DIC on Order Dialog file
 N X,Y,DIC
 S DIC=101.41,DIC(0)="AEQM",DIC("A")="Search for: "
 S DIC("?")="Enter the name of the dialog component you wish to search for."
 D ^DIC
 Q Y
 ;
SELECT(ORY,MAX,Y) ; -- Select which Dlgs to replace items
 N X,DIR
 S DIR(0)="LA^1:"_MAX,DIR("A")=$S(ORY="@":"Remove in: ",1:"Replace in: "),DIR("B")=$S(MAX>1:"1-"_MAX,1:"1")
 ; S DIR("?")
 D ^DIR S:$D(DTOUT)!(X["^") Y="^"
 Q
 ;
OK() ; -- Are you ready?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Are you ready? ",DIR("B")="NO"
 W ! D ^DIR
 Q +Y
 ;
REPLWITH(ORIT) ; -- Remove item, or select replacement
 N X,Y,DIR,DIC
 S DIR(0)="FAO^1:63",DIR("A")="Replace "_$P(ORIT,U,2)_" with: "
 S DIR("?")="Enter the name of the item you wish to replace this one with, or @ to remove this item; to quit without changing anything, press <return>."
R1 D ^DIR I X="@" Q "@"
 I $D(DTOUT)!("^"[X) Q "^"
 S DIC=101.41,DIC(0)="EQM" D ^DIC I Y'>0 G R1
 Q Y
 ;
VALID(ITM,DAD,ERR) ; -- Ck if ITM may be placed on DAD
 N DTYPE,ITYPE,Y S Y=0
 S DTYPE=$P(^ORD(101.41,DAD,0),U,4) I DTYPE="D",$$NMSP^ORCD($P(^(0),U,7))'="OR" S ERR="Only generic ordering dialogs are editable." G VQ
 I ITM="@" S Y=1 G VQ ; ok to delete
 S ITYPE=$P(^ORD(101.41,+ITM,0),U,4)
 I ITYPE="P",DTYPE'="D" S ERR="A prompt may not be added to a "_$$TYPE(DTYPE)_"." G VQ
 I ITYPE="A","DOM"'[DTYPE S ERR="An action may not be added to a "_$$TYPE(DTYPE)_"." G VQ
 I "DQOM"[ITYPE,"OM"'[DTYPE S ERR="A "_$$TYPE(ITYPE)_" may not be added to a "_$$TYPE(DTYPE)_"." G VQ
 D RECURSV(+ITM,DAD,.ERR) I $D(ERR) S Y=0 G VQ
 S Y=1 ; ok
VQ Q Y
 ;
RECURSV(ITEM,MENU,MSG) ; -- Return 1 or 0, if recursive reference to ITEM
 N STACK,CNT S STACK=0,CNT=0
 K MSG D CHKPAR(MENU)
 Q
CHKPAR(MENU) ; follow tree to check parents
 N PMENU,I
 S STACK=STACK+1,STACK(STACK)=MENU,STACK("B",MENU)=STACK,PMENU=0
 F  S PMENU=$O(^ORD(101.41,"AD",MENU,PMENU)) Q:'PMENU  D  Q:$D(MSG)
 . I PMENU=ITEM D  Q
 . . S MSG="Recursive Reference: "_$P(^ORD(101.41,ITEM,0),U)
 . . F I=STACK:-1:1 S CNT=CNT+1,MSG(CNT)=$P(^ORD(101.41,STACK(I),0),U)
 . I $D(STACK("B",PMENU)) Q
 . D CHKPAR(PMENU)
 K STACK(STACK),STACK("B",MENU) S STACK=STACK-1
 Q
 ;
INUSE(MENU) ; -- Returns 1 or 0, if MENU is in use by parameter
 N PARAM,ENT,Y
 S PARAM=$O(^XTV(8989.51,"B","OR ADD ORDERS MENU",0)),Y=0
 S ENT="" F  S ENT=$O(^XTV(8989.5,"AC",PARAM,ENT)) Q:ENT=""  I $G(^(ENT,1))=MENU S Y=1 Q
 Q Y
 ;
ASSIGN ; -- Assign menu to user(s)
 D FULL^VALM1
 D EDITPAR^XPAREDIT("OR ADD ORDERS MENU")
 S VALMBCK="R"
 Q
 ;
INQ ; -- Inquire to Order Dialog file
 N X,Y,DIC,DA,DR,DIQ
 S DIC="^ORD(101.41,",DIC(0)="AEQM"
 F  D ^DIC Q:Y'>0  S DA=+Y W ! D EN^DIQ W !
 Q
 ;
OUTPUT(ORY) ; -- Output Xform for Value field of Response multiple
 N ORDIALOG,ORP,ORZ S ORZ=ORY
 S ORP=$P($G(^ORD(101.41,D0,6,D1,0)),U,2)
 I ORP S ORDIALOG(ORP,0)=$P($G(^ORD(101.41,ORP,1)),U,1,2),ORDIALOG(ORP,1)=ORY,ORZ=$$EXT^ORCD(ORP,1)
 Q ORZ
 ;
AOPAR ; -- List of add order menus assigned to users
 N BY,DHD,DIC,FLDS,FR,TO
 S DIC=8989.5
 S FR="OR ADD ORDERS MENU,?",TO="OR ADD ORDERS MENU,?"
 S BY="@.02,@1;S2;""Add order menu: """
 S DHD="CPRS Add order menu list"
 S FLDS="VALUE;N;""Menu"",ENTITY;""User/Location/etc."";C40"
 D EN1^DIP
 Q
 ;
DISABLE ; -- Disable order dialogs
 N X,Y,DIC,DIR,ORDIS,ORI K ^TMP("ORDISABLE",$J)
 S DIC=101.41,DIC(0)="AEQM",DIC("A")="Select ORDER DIALOG: ",DIC("?")="Enter the name of an order dialog you wish to disable."
 S DIC("W")="I $L($P(^(0),U,3)) W !?3,"">> disabled: ""_$P(^(0),U,3)"
 F  D ^DIC Q:Y'>0  S ^TMP("ORDISABLE",$J,+Y)="" S DIC("A")="ANOTHER ONE: "
 Q:'$O(^TMP("ORDISABLE",$J,0))  ;none selected
 W !!,"Enter a message to disable the dialog(s), or @ to enable again."
 S DIR(0)="FAO^1:40",DIR("A")="MESSAGE: "
 S DIR("?")="Enter up to 40 characters explaining why use of this dialog has been disabled that will display if the dialog is selected, or @ to enable the dialog again."
 D ^DIR G:$D(DTOUT)!$D(DUOUT)!(X="") DQ S ORDIS=X
 I '$$OK W !,"Nothing "_$S(ORDIS="@":"en",1:"dis")_"abled." H 1 G DQ
 S ORI=0  F  S ORI=$O(^TMP("ORDISABLE",$J,ORI)) Q:ORI'>0  S $P(^ORD(101.41,ORI,0),U,3)=$S(ORDIS="@":"",1:ORDIS) W "."
 W !,"done." H 1
DQ K ^TMP("ORDISABLE",$J)
 Q
