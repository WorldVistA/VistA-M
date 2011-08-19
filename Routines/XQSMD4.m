XQSMD4 ; SEA/MJM,JLI - Edit a user's options ;01/25/2008
 ;;8.0;KERNEL;**510**;Jul 10, 1995;Build 6
 ; Per VHA Directive 2004-038, this routine should not be modified.
 ; Option: XQSMD BUILD MENU
BUILD ;
 N XQNMSP,XQOPT
 I '$D(^VA(200,DUZ,19.5,"B")) W !!?7,$C(7),"You haven't been delegated any options with which to build a menu." Q
 D NAMESP(.XQNMSP) Q:'$D(XQNMSP)
 D ASKOPT(.XQOPT,"M") Q:'$D(XQOPT)
 I XQOPT("NEW") D NEW(.XQOPT) Q
 D OLD(.XQOPT)
 Q
ASKOPT(XQOPT,XQTYPE) ;
 N XQOPNM
 D ASKNAME(.XQOPNM,.XQNMSP,XQTYPE) Q:'$D(XQOPNM)
 D ADDFIND(XQOPNM,.XQOPT) Q:'$D(XQOPT)
 Q
ADDFIND(X,XQOPT) ;
 N DIC,Y,DLAYGO
 S DIC(0)="MLE",DIC=19,DLAYGO=19
 D ^DIC Q:Y<0
 S XQOPT("NAME")=$P(Y,U,2)
 S XQOPT("IEN")=+Y
 S XQOPT("NEW")=$P(Y,U,3)
 Q
NEW(XQOPT) ;
 N DIE,DA,DIC,DR,DLAYGO,X,Y
 S DIE=19,DR="1;3.5;4///M;",DA=XQOPT("IEN") D ^DIE ; Enter as new option and force type to be menu
 S DIC="^VA(200,DUZ,19.5,",X=XQOPT("NAME"),DIC(0)="MLX",DA(1)=DUZ,DLAYGO=200 D ^DIC Q:Y'>0
 D EDIT(.XQOPT)
 Q
OLD(XQOPT) ;
 I $P(^DIC(19,XQOPT("IEN"),0),U,4)'="M" W !,$C(7),"This option already exists but is not a MENU." Q
 I '$D(^VA(200,DUZ,19.5,XQOPT("IEN"),0)) W !,$C(7),"This option already exists but is not included in your delegated options.",!,"Choose another option name or get this option delegated to yourself." Q
 D EDIT(.XQOPT)
 Q
EDIT(XQOPT) ;
 N XQOUT
 W !!,"You may only include options that have been delegated as items to you.",!
 S XQOUT=0
 F  D  Q:XQOUT
 . N DIC,X,Y,XQITEM,XQITEMNM
 . I $D(^DIC(19,XQOPT("IEN"),10,"B")) D SHOWITEM
 . S DIC("A")="Select Menu Item: "
 . S DIC("S")="I +Y'="_XQOPT("IEN") ; Don't select the option as a menu item
 . S DIC(0)="AEQMZ"
 . S DIC="^VA(200,DUZ,19.5,"
 . D ^DIC I Y<0 S XQOUT=1 Q
 . S XQITEM("IEN")=+Y ; Menu Item IEN
 . S XQITEM("NAME")=Y(0,0) ; Menu Item Name
 . I $D(^DIC(19,XQOPT("IEN"),10,"B",XQITEM("IEN"))) D  Q
 . . N DIK,DA ; If already there, remove it from menu
 . . S DIK="^DIC(19,"_XQOPT("IEN")_",10,",DA(1)=XQOPT("IEN"),DA=$O(^DIC(19,XQOPT("IEN"),10,"B",XQITEM("IEN"),0)) D ^DIK
 . . W !,$C(7),"Menu item ",XQITEM("NAME")," deleted from menu."
 . . I '$D(^DIC(19,XQOPT("IEN"),10,"B")) D
 . . . W !,"This menu contains no menu items."
 . . . W !,"It will be deleted if you don't add a menu item."
 . . W !
 . N X,Y,DIC,DLAYGO,DA,D0
 . S X=XQITEM("NAME")
 . S DIC(0)="EQML"
 . S DLAYGO=19,(D0,DA(1))=XQOPT("IEN")
 . S DIC="^DIC(19,"_XQOPT("IEN")_",10,"
 . D ^DIC I Y<0 W ! Q
 . N DIE,DR,DA
 . S DR="2:3;" ; Set SYNONYM and DISPLAY ORDER
 . S DIE=DIC,DA=+Y,DA(1)=XQOPT("IEN") D ^DIE
 . W !
 Q:$O(^DIC(19,XQOPT("IEN"),10,0))
 I $D(^VA(200,"AP",XQOPT("IEN"))),'$G(XQOPT("NEW")) D  Q
 . D NODEL(.XQOPT)
 . W !,"These users now have a Primary Menu with no menu items!",$C(7)
 . W !,"Recommend you add some menu items to it."
 D DELETE(.XQOPT)
 W !!?7,$C(7),"Empty menu removed from option file and your delegated options.",!
 Q
SHOWITEM ;
 N I,XQREC,XQREC0
 W !,"This menu contains the following menu items. You may add a new menu item."
 W !,"If you select an existing menu item, it will be deleted from the menu.",!
 S I=0
 F  S I=$O(^DIC(19,XQOPT("IEN"),10,I)) Q:'I  S XQREC=^(I,0) D
 . S XQREC0=^DIC(19,+XQREC,0)
 . W !,?3,$P(XQREC0,U),?40,$P(XQREC,U,2),?46,$P(XQREC0,U,2)
 W !
 Q
NODEL(XQOPT) ; called by ^XQSMDFM, too
 N I
 W !!,"This option is used as a Primary Menu for:"
 S I=0
 F  S I=$O(^VA(200,"AP",XQOPT("IEN"),I)) Q:'I  W !?10,$P(^VA(200,I,0),U)
 W !,"Can't delete it while it is used as a primary menu."
 Q
DELETE(XQOPT) ; called by ^XQSMDFM, too
 N DIK,DA
 I $G(XQOPT("NEW")) D
 . S DIK="^VA(200,DUZ,19.5,",DA(1)=DUZ,DA=XQOPT("IEN") D ^DIK
 E  D
 . N XQJ
 . S XQJ=0
 . ; Delete option from all menus
 . F  S XQJ=$O(^DIC(19,"AD",XQOPT("IEN"),XQJ)) Q:'XQJ  S DA=$O(^(XQJ,0)),DA(1)=XQJ,DIK="^DIC(19,DA(1),10," D ^DIK
 . ; Delete option as a secondary menu option for all users
 . F  S XQJ=$O(^VA(200,"AD",XQOPT("IEN"),XQJ)) Q:'XQJ  S DA=$O(^(XQJ,0)),DA(1)=XQJ,DIK="^VA(200,DA(1),203," D ^DIK
 . ; Delete option as delegated option for all users
 . F  S XQJ=$O(^VA(200,XQJ)) Q:'XQJ  I $D(^(XQJ,19.5,"B",XQOPT("IEN"))) S DA=XQOPT("IEN"),DA(1)=XQJ,DIK="^VA(200,DA(1),19.5," D ^DIK
 S DIK="^DIC(19,",DA=XQOPT("IEN") D ^DIK ; Delete option
 Q
NAMESP(XQNMSP) ; Check for available namespaces. Called by ^XQSMDFM, too.
 N I
 S I=0
 F  S I=$O(^VA(200,DUZ,19.6,"B",I)) Q:I=""  S XQNMSP=$G(XQNMSP)+1,XQNMSP(I)=""
 I $D(XQNMSP) D HLPNAME Q
 I $D(^VA(200,DUZ,19.6)) K ^(19.6)
 W !!?7,$C(7),"No namespace(s) have been set up for you to build new menus.",!?7,"Contact your computer service representative."
 Q
HLPNAME ;
 N I
 W !?7,"The options you build or edit must begin with ",$S(XQNMSP>1:"one of ",1:""),!?7,"the following namespace",$S(XQNMSP>1:"(s)",1:"")," and be no more than 30 characters long:",!
 S I=""
 F  S I=$O(XQNMSP(I)) Q:I=""  W !?35,$S($E(I,1)="A":I,1:I_"Z")
 W !
 Q:"^P^I^E^M^"'[(U_$G(XQTYPE)_U)
 N I,XQM,XQREC
 S I=0
 F  S I=$O(^VA(200,DUZ,19.5,"B",I)) Q:'I  D
 . S XQREC=$G(^DIC(19,I,0)) Q:$P(XQREC,U,4)'=XQTYPE
 . S XQM($P(XQREC,U))=$P(XQREC,U,2)
 I '$D(XQM) W !?7,"You have no existing delegated "_$$TYPE(XQTYPE)_" options. You may enter a new one." Q
 W !,"The following are your existing delegated "_$$TYPE(XQTYPE)_" options:"
 F  S I=$O(XQM(I)) Q:I=""  W !,I,?40,XQM(I)
 Q
TYPE(XQT) ;
 Q $S(XQT="P":"Print",XQT="I":"Inquire",XQT="E":"Edit",1:"Menu")
ASKNAME(XQOPNM,XQNMSP,XQTYPE)  ;Check for a valid option names.
 ;Called by ^XQSMDFM, too.
 ;XU*8*428 also allows for local namespaces, e.g., A5A, AFS, etc.
 F  D  Q:$D(DIRUT)!$D(XQOPNM)
 . N DIR,X,Y
 . S DIR("A")="Option Name"
 . S DIR("PRE")="D CHKNAME^XQSMD4"
 . S DIR("?")="^D HLPNAME^XQSMD4"
 . S DIR(0)="F^3:30"
 . D ^DIR Q:$D(DIRUT)
 . S XQOPNM=Y
 Q
CHKNAME ;
 I $D(DTOUT)!(X[U)!(X["?") Q
 I X="" S X=U Q
 N I
 S I=""
 F  S I=$O(XQNMSP(I)) Q:I=""  Q:$E(I,1)="A"&($E(X,1,$L(I))=I)  Q:$E(X,1,$L(I))=I&($E(X,$L(I)+1)="Z")
 Q:I'=""
 W $C(7),!!?7,$E(X,1,4),"* is not a valid namespace for you.",!
 K X
 Q
