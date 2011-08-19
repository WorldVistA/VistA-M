ORGUEM ; slc/KCM - Set Up Formatted Protocol Menus ;5/28/92 14:41
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
EN ; Select menu, change items, formatting, & other attributes
 N ORGPOP,ORGMENU,IOINHI,IOINLOW                          ; ORGMENU declared globally for ORGUEM*
 D GMENU^ORGUEM2("AEMQL",.ORGMENU) Q:$D(ORGPOP)           ; Get protocol menu
 I $P(ORGMENU,"^",3) D NEW^ORGUEM2 I $D(ORGPOP) D DMEN Q  ; If creating a new protocol, get required fields
 D HOME^%ZIS S X="IOINHI;IOINLOW" D ENDR^%ZISS
 S ORGMENU("TOG")="F" D SHOW                      ; Show menu in formatted mode
 S X=$O(^ORD(101,"B","ORCL PROTOCOL MENU SETUP",0))_";ORD(101,"
 D EN^XQOR                                        ; Use XQOR to select & execute actions
 D BLANKS^ORGUEM2                                 ; Reset blank lines
 S ^DISV(DUZ,"^ORD(101,")=+ORGMENU
 K ^XUTL("XQORM",+ORGMENU_";"_$J)                 ; Clean up sequence/name menu node
 Q
DMEN ; Delete Protocol Menu (pointers not updated)
 N DA,DIK
 S DA=+ORGMENU,DIK="^ORD(101,"
 W !,"Insufficient information to create menu...."
 D ^DIK
 Q
COL ; Edit the number of columns for the protocol
 N ORCOL,DIR,DIC,DIE,DR,DA
 S ORCOL=80\$S($G(^ORD(101,+ORGMENU,4)):^(4),1:80)
 S DIR(0)="NAO^1:3",DIR("A")="Number of Columns (1-3): ",DIR("B")=ORCOL
 D ^DIR
 I Y,Y'=ORCOL S DR="41///"_(80\Y),DIE="^ORD(101,",DA=+ORGMENU D ^DIE
 Q
MNE ; Edit mnemonic width for the protocol
 N ORMNE,DIR,DIC,DIE,DR,DA
 S ORMNE=$P($G(^ORD(101,+ORGMENU,4)),"^",2)
 S DIR(0)="NAO^1:9",DIR("A")="Width for Mnemonics: ",DIR("B")=$S(ORMNE:ORMNE,1:5)
 D ^DIR
 I Y,Y'=ORMNE S DR="42///"_Y,DIE="^ORD(101,",DA=+ORGMENU D ^DIE
 Q
ADD ; Add a new item to the menu
 N DIC
 S DIC="^ORD(101,",DIC(0)="AEMQZ",DIC("A")="Select Item to be Added: "
 F  D ^DIC Q:Y'>0  D
 . N D0,DD,DIC,DA,DIE,DR
 . S:'$D(^ORD(101,+ORGMENU,10,0)) ^(0)="^101.01PA^^"
 . S X=+Y,DA(1)=+ORGMENU,DIC="^ORD(101,"_DA(1)_",10,",DIC(0)=""
 . D FILE^DICN I +Y S DIE=DIC,DA=+Y,DR="3;2;6" D ^DIE
 Q
EDIT ; Edit an item on the menu
 N ORGIDX,ORGLST,ORGFLG
 S ORGLST=$$LOOK^ORGUEM2("Select item(s) to be edited: ")
 F ORGIDX=1:1:$L(ORGLST,",") I +$P(ORGLST,",",ORGIDX) D FLDS^ORGUEM2(+$P(ORGLST,",",ORGIDX),.ORGFLG) Q:ORGFLG
 Q
DEL ; Delete an item from the menu
 N ORGIDX,ORGLST,DA,DIK
 S ORGLST=$$LOOK^ORGUEM2("Select item(s) to be deleted: ")
 F ORGIDX=1:1:$L(ORGLST,",") D  ;delete item
 . S DA=$P(ORGLST,",",ORGIDX)
 . I DA S DA(1)=+ORGMENU,DIK="^ORD(101,"_DA(1)_",10," D ^DIK
 Q
SHOW ; Display the menu
 N XQORM,X
 W !!,ORGMENU(0,0),?61,$$INHI^XQORM1,"HILITE",$$INLO^XQORM1,"=placeholder"
 W ! F I=1:1:79 W "-"
 D SMENU^ORGUEM2 D:ORGMENU("TOG")="R" SET^ORGUEM1(+ORGMENU) D EN^XQORM
 I ORGMENU("TOG")="F" D
 . W !,$S($D(XQORM("A")):XQORM("A"),1:"Select Item(s): ")
 . W:$D(XQORM("B")) XQORM("B")_"// "
 W ! F I=1:1:79 W "-"
 Q
TOG ; Toggle menu display mode
 I ORGMENU("TOG")="R" S ORGMENU("TOG")="F" W !,"Menus will now be displayed as the user will see them."
 E  S ORGMENU("TOG")="R" W !,"Menus will now be displayed using actual sequence numbers and protocol names."
 Q
OPT ; Edit optional menu parameters
 N DIE,DR,DA
 S DIE="^ORD(101,",DR="[ORCL ADV MENU EDIT]",DA=+ORGMENU D ^DIE
 Q
INQ ; Inquire protocol file
 N DIC,DA,DR,DIQ
 S DIC="^ORD(101,",DIC(0)="AEMQ" D ^DIC Q:Y'>0
 W ! S DA=+Y D EN^DIQ
 Q
