ORGUEM2 ; slc/KCM - Set Up Formatted Protocol Menus (cont) ;6/1/92  17:08
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;;Dec 17, 1997
 ;;
GMENU(X,Y) ; Select or Create Menu to be set up
 ;Y is array returned by DIC, it should be call by reference
 N DIC,DLAYGO,DA,ORGOK
 S DIC="^ORD(101,",DIC(0)=X_"Z",DLAYGO=101,DIC("DR")=""
 S DIC("S")="I ""QM""[$P(^(0),""^"",4)"
 F  D  Q:$D(ORGOK)
 . D ^DIC
 . I DIC(0)["L",$P(Y,"^",2)?1"OR ADD MENU".E D  I $D(ORGPOP) S ORGOK=1 Q
 . . N X W !!,"NOTE: You should only modify locally namespaced add order menus.",!,"Press RETURN to continue or '^' to exit: "
 . . R X:DTIME S:X="^^" DIROUT=1 S:X["^" ORGPOP=1
 . . Q
 . I Y'>1 S ORGPOP=1,ORGOK=1 Q
 . I $P(Y,"^",3) S ORGOK=1 Q
 . ; I +$G(ORGMENU)=+Y W !,"Can't copy from the menu you just created." Q
 . I "QM"[$P(Y(0),"^",4) S ORGOK=1 Q
 . W !,Y(0,0)," is not a menu type."
 Q
NEW ; Copy from existing menu or get required fields for new menu
 N ORGCOPY
 W !,ORGMENU(0,0)," is a new menu."
 S ORGCOPY=$$ASK("Do you want to copy an existing menu? ","Yes")
 I ORGCOPY="^" S ORGPOP=1 Q
 I ORGCOPY D GMENU("AEMQ",.Y) Q:$D(ORGPOP)  D
 . N %X,%Y,DA,DIK
 . S %X="^ORD(101,"_+Y_",",%Y="^ORD(101,"_+ORGMENU_"," D %XY^%RCR
 . S $P(^ORD(101,+ORGMENU,0),"^")=ORGMENU(0,0)
 . W !,"Please wait.  Copying the menu may take a few minutes."
 . S DA=+ORGMENU,DIK="^ORD(101," D IX1^DIK
 I 'ORGCOPY D
 . N DA,DR,DIE
 . ;Check namespace to see if can guess default for package name
 . S DA=+ORGMENU,DIE="^ORD(101,",DR="1;4//Q;12" D ^DIE
 . I $D(Y) S ORGPOP=1
 Q
ASK(X,Y) ; Ask a Yes or No question
 ;X is question, Y is default
 S DIR(0)="YAO" S:$D(X) DIR("A")=X S:$D(Y) DIR("B")=Y
 D ^DIR
 Q Y
FLDS(DA,ORGFLG) ; Edit item fields without updating database
 N DR,DIE,DIC
 S DIE="^ORD(101,"_+ORGMENU_",10,",DA(1)=+ORGMENU,DR=".01;3;2;6"
 D ^DIE S ORGFLG=$D(Y) ; Y undef if no up arrow out
 Q
LOOK(X) ; Lookup an item on the menu
 N LST,XQORM
 D SMENU
 S XQORM(0)="A"_$S(ORGMENU("TOG")="R":"h",1:""),XQORM("A")=X
 D:ORGMENU("TOG")="R" SET^ORGUEM1(+ORGMENU) D EN^XQORM
 S Y=0,LST="" F  S Y=$O(Y(Y)) Q:'Y  S LST=LST_+Y(Y)_","
 Q LST
SMENU ; Set up for call to display menu
 S XQORM("W")="W:$E(^ORD(101,+$P(X,""^"",2),0),1,8)=""OR GFAKE"" $$INHI W $P(X,""^"",3),$$INLO"
 I ORGMENU("TOG")="R" S XQORM=+ORGMENU_";"_$J,XQORM(0)="Dh",XQORM("M")=4 Q
 S XQORM=+ORGMENU_";ORD(101,",XQORM(0)="D"
 I $L($G(^ORD(101,+ORGMENU,28))) S XQORM("A")=^(28)
 I $L($G(^ORD(101,+ORGMENU,29))) S XQORM("B")=^(29)
 I $D(^ORD(101,+ORGMENU,4)) S XQORM("M")=$P(^(4),"^",2) S:'XQORM("M") XQORM("M")=5
 Q
BLANKS ; Renumber blank line protocols
 N COUNT,LIST,ITM,DIE,DIC,DR,DA
 W ! ; Checking 'blank line' items
 D SEQ^ORGUEM3(+ORGMENU,.LIST)
 S COUNT=0,DIE="^ORD(101,"_+ORGMENU_",10,",DA(1)=+ORGMENU
 F ITM=1:1:LIST I ^ORD(101,$P(LIST(ITM),"^",2),0)?1"ORB BLANK LINE".E D
 . S COUNT=COUNT+1 Q:COUNT>20
 . S X=$O(^ORD(101,"B","ORB BLANK LINE"_COUNT,0)) Q:'X  Q:X=$P(LIST(ITM),"^",2)
 . S DA=+LIST(ITM),DR=".01///`"_X D ^DIE
 Q
MOVE ; Resequence items
 N ORGIDX,ORGLST,DIR
 S ORGLST=$$LOOK("Select item(s) to be resequenced: ")
 S DIR(0)="LOA^1:999",DIR("A")="Enter new range of sequence numbers (i.e. 2-8): "
 D ^DIR Q:$D(DIRUT)
 I $L(ORGLST,",")'=$L(Y,",") D
 . I $L(Y,",")=2 F I=1:1:$L(ORGLST,",")-1 S $P(Y,",",I+1)=Y+I
 . E  D
 . . N X1,X2,X3 S X1=$P(Y,","),X2=$P(Y,",",$L(Y,",")-1),X3=(X2-X1)/($L(ORGLST,",")-2)
 . . S Y="" F I=1:1:$L(ORGLST,",")-1 S Y=Y_$J(X1,0,2)_",",X1=X1+X3
 F ORGIDX=1:1:$L(ORGLST,",")-1 I +$P(ORGLST,",",ORGIDX) D STUF(+$P(ORGLST,",",ORGIDX),3,+$P(Y,",",ORGIDX))
 Q
STUF(DA,FLD,VAL) ;Stuff value into field for entry
 N DIC,DIE,DR,X,Y
 S DIE="^ORD(101,"_+ORGMENU_",10,",DA(1)=+ORGMENU,DR=FLD_"///"_VAL
 D ^DIE
 Q
USER ; Assign menu to individual users
 N DIR,DIC,DIE,DA,DR,ORGTYP
 W !,"Individual users may be assigned primary menus of the following types:"
 W !!,"  1 OE/RR MENU      - contains selections like Add Orders, Review Orders, etc."
 W !,"  2 ADD ORDERS MENU - contains orderable items.",!
 S DIR(0)="SOA^1:OE/RR MENU;2:ADD ORDERS MENU"
 S DIR("A")="Type of this menu: "
 D ^DIR Q:$D(DIRUT)
 S ORGTYP=$S(Y=1:100.11,1:100.12)
 F  D  Q:Y'>0
 . S DIC="^VA(200,",DIC(0)="AEMQ"
 . S DIC("A")="Select user to be assigned this menu: "
 . D ^DIC Q:Y'>0
 . S DIE=DIC,DA=+Y,DR=ORGTYP_"///"_+ORGMENU
 . D ^DIE S Y=1
 Q
