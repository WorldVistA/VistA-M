ORCMEDT3 ;SLC/MKB-Dialog editor ;6/28/01  14:21
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**8,46,60,95**;Dec 17, 1997
EN ; -- Enter/edit generic ordering dialog
 N ORDLG,ORDG
 F  S ORDLG=$$DIALOG^ORCMEDT0("D") Q:ORDLG="^"  D EN1(ORDLG) W !
 Q
EN1(ORDLG) ; -- edit dialog ORDLG
 N ORPROG,X,Y,D,DA,DR,DIE,DIC,OR0,ORP,ORTYPE,ORDOM,ORQUIT,ORNAME,ORPKG
 Q:'$G(ORDLG)  S ORPROG=(DUZ(0)="@"),DA=ORDLG,DIE="^ORD(101.41,",DR=""
 S ORPKG=+$P($G(^ORD(101.41,ORDLG,0)),U,7),ORPKG=$S($O(^DIC(9.4,"C","OR",0))=ORPKG:1,1:0) ;1 or 0, if PKG=OR
 I ORPKG S ORNAME=$$NAME^ORCMEDT4(ORDLG) Q:(ORNAME="@")!(ORNAME="^")  S DR=".01///^S X=ORNAME;" ; Name not editable for pkg dialogs
 S DR=DR_"2;6;8;9"_$S('ORPKG:"",ORPROG:";20;30;40;17;19",1:";20")
 D ^DIE Q:$D(DTOUT)!$D(Y)  Q:'$G(DA)  ; deleted
 D DGRP Q:ORDG="^"  ;edit display group
EN11 S ORQUIT=0 F  D  Q:ORQUIT  W ! ; ** Only few fields editable if pkg dlg
 . S DIC="^ORD(101.41,"_ORDLG_",10,",DIC(0)="AEQM"_$S(ORPKG:"L",1:"")
 . S DIC("A")="Select PROMPT: ",DIC("P")=$P(^DD(101.41,10,0),U,2),D="B^D"
 . S DIC("DR")="21///"_(+$O(^ORD(101.41,ORDLG,10,"ATXT","A"),-1)+1)
 . K DA S DA(1)=ORDLG D MIX^DIC1 I Y'>0 S ORQUIT=1 Q
 . S DA=+Y,DIE=DIC,DR=.01 I ORPKG D ^DIE Q:'$G(DA)!$D(DTOUT)!$D(Y)
 . S OR0=$G(^ORD(101.41,DA(1),10,DA,0)),ORP=$S(ORPKG:$$PROMPT($P(OR0,U,2)),1:$P(OR0,U,2))
 . I ORP="^" S DIK=DIC D:'$P(OR0,U,2) ^DIK Q  ;delete item if no prompt
 . S ORTYPE=$P(^ORD(101.41,ORP,1),U),ORDOM=$P(^(1),U,2)
 . I ORP'=$P(OR0,U,2),ORTYPE'=$P($G(^ORD(101.41,+$P(OR0,U,2),1)),U) D
 . . N I F I=.1,4,7,8 K ^ORD(101.41,ORDLG,10,DA,I) ;kill xform,screen,def
 . . S $P(^ORD(101.41,ORDLG,10,DA,0),U,10)="",$P(^(1),U,2)="" ;index,lkup
 . S DR=$S(ORPKG:"2////"_ORP_$S(ORTYPE="P"&ORPROG:";10;14;12",1:"")_";4;6;7;I 'X S Y=""@1"";7.1;7.2;7.3;S Y=8;@1;7.1///@;7.2///@;7.3///@;8;9;11",1:"8;9") D ^DIE Q:$D(DTOUT)!$D(Y)
 . I 'ORPROG K DIRUT D DEFAULT Q:$G(DIRUT)
 . I ORPROG S DR=$S(ORPKG:"16;13;.1;",1:"")_$S(ORTYPE="W":18,1:17)_$S(ORPKG:";15;19;20",1:"") D ^DIE Q:$D(DTOUT)!$D(Y)
 . S DR="21;I X'>0 S Y=0;22:"_$S(ORTYPE="W":"27",1:"26") D ^DIE
 D WINID,AUTO^ORCMEDT1(ORDLG),TRY(ORDLG) ;Auto-Accept flag, test changes
 Q
 ;
PROMPT(X) ; -- Enter/edit prompt
 N Y,DIC,OLD S OLD=+$G(X)
 S DIC="^ORD(101.41,",DIC(0)="AEQM",DIC("S")="I $P(^(0),U,4)=""P"""
 S DIC("A")="PROMPT: " S:OLD DIC("B")=$P(^ORD(101.41,X,0),U)
 S DIC("W")="W ""       ""_$$TYPE^ORCMEDT3($P($G(^(1)),U))" ; show type
P1 D ^DIC I $D(DTOUT)!$D(DUOUT) S Y="^" G PQ
 I Y'>0 W $C(7),!?5,"This is a required field!" G P1
 I +Y'=OLD,$D(^ORD(101.41,ORDLG,10,"D",+Y)) W $C(7),!?5,"Duplicates are not allowed!" G P1
 S Y=+Y
PQ Q Y
 ;
TYPE(X) ; -- Displays datatype and domain as identifiers
 I '$L($G(X)) Q ""
 N Y S Y=$S(X="D":"date/time",X="R":"relative date/time",X="F":"free text",X="N":"numeric",X="S":"set of codes",X="P":"pointer to a file",X="Y":"yes/no",X="W":"word processing",1:"")
 Q Y
 ;
DEFAULT ; -- Enter/edit default value
 G:ORTYPE="W" WP N OLD,X,Y,D,DIC,DIR,%DT,ORDIC,ORSCR
 S:$D(^ORD(101.41,ORDLG,10,DA,4)) ORSCR=^(4)
 S OLD=$G(^ORD(101.41,ORDLG,10,DA,7)) I $L(OLD) D  Q:OLD="^"
 . S OLD=$$VALUE(OLD) S:"^P^D^R^"[(U_ORTYPE_U)&(OLD=-1) OLD=""
 . I OLD="^" W !,"DEFAULT: <executable code - uneditable>//" Q
 S DIR("A")="DEFAULT: ",DIR(0)=$S(ORTYPE="P":"FAO^1:63",ORTYPE="D"!(ORTYPE="R"):"DAO^"_ORDOM,1:ORTYPE_"AO^"_ORDOM)
 S:$L(OLD) DIR("B")=$S(ORTYPE="P":$$GET1^DIQ(+ORDOM,+OLD_",",.01),ORTYPE="D":$$FMTE^XLFDT(OLD),1:OLD)
 S:ORTYPE="P" DIR("?")="Select an entry from the file; enter ?? to see a list of choices",DIR("??")="^D LIST^ORCMEDT3"
DF1 D ^DIR K DIRUT I $D(DTOUT)!(X["^") S DIRUT=1 Q
 Q:X=""  Q:X=$G(DIR("B"))  ; no value or no change
 I X="@" K ^ORD(101.41,ORDLG,10,DA,7) Q
 I ORTYPE="R" S Y=X
 I ORTYPE="P" D  G:Y'>0 DF1
 . S DIC=$S(+ORDOM:+ORDOM,1:U_$P(ORDOM,":"))
 . S DIC(0)="EQ",D=$P(OR0,U,10),ORDIC="^DIC"
 . S:$D(ORSCR) DIC("S")=ORSCR
 . I $L(D) S D=$TR(D,";","^"),ORDIC=$S($L(D,"^")>1:"MIX^DIC1",1:"IX^DIC")
 . D @ORDIC S Y=$P(Y,U)
DFQ S ^ORD(101.41,ORDLG,10,DA,7)=$S(Y'="":"S Y="""_Y_"""",1:"Q")
 Q
 ;
VALUE(CODE) ; -- Returns value following "S Y="
 N I,X,Y,Z S Z=$F(CODE,"S Y=") I 'Z Q "^"
 S X=$E(CODE,Z,999),Y="" I '+X,$E(X)'="""" Q "^" ;not numeric or literal
 S:$E(X)="""" X=$E(X,2,999)
 F I=1:1:$L(X) S Z=$E(X,I) Q:(Z="""")  S Y=Y_Z
 Q Y
 ;
LIST ; -- ??help for ptrs
 N D,DIC,DZ
 S DIC=$S(+ORDOM:$$ROOT^DILFD(+ORDOM),1:U_$P(ORDOM,":"))
 S DIC(0)="EQS",DZ="??",D=$P(OR0,U,10) S:'$L(D) D="B"
 S:$D(ORSCR) DIC("S")=ORSCR
 D DQ^DICQ
 Q
 ;
WP ; -- Enter/edit WP data
 N DIC,DIWESUB W !,"DEFAULT: "
 S DIC="^ORD(101.41,"_ORDLG_",10,"_DA_",8,",DIWESUB="DEFAULT"
 D EN^DIWE
 Q
 ;
DGRP ; -- Edit display group [and orderable item]
 N X,Y,DA,DR,DIE,OI,IDX
 S DA=ORDLG,DR="5R",DIE="^ORD(101.41," D ^DIE I $D(Y) S ORDG="^" Q
 Q:$P($G(^ORD(101.41,ORDLG,0)),U,5)=ORDG  S ORDG=$P(^(0),U,5)
 S OI=$O(^ORD(101.41,ORDLG,10,"D",+$$PTR^ORCD("OR GTX ORDERABLE ITEM"),0)) Q:'OI
 S IDX="S."_$P($G(^ORD(100.98,ORDG,0)),U,3)
 S $P(^ORD(101.41,ORDLG,10,OI,0),U,10)=IDX K ^(7)
 W !,"  >> You must select a new orderable item from this group."
 Q
 ;
OI(ORDG) ; -- Returns OI for generic dialog
 Q:'$G(ORDG) "" N X,Y,D,DIC,DLAYGO,DA,DR,DIE,ID,ORDIC,ORY
 S D=$P($G(^ORD(100.98,+ORDG,0)),U,3)
 I "^ANI^AP^AU^BB^CARD^CH^CSLT^CT^CY^D AO^D CON^DIET^DO^E/L T^EM^HEMA^I RX^IV RX^LAB^MAM^MI^MRI^NM^O RX^PREC^PROC^RAD^RX^SP^SPLY^TF^TPN^UD RX^US^VAS^XRAY^"'[(U_D_U) S ORADD=1 ;95 Only add OI if generic DG
 S DIC=101.43,DIC(0)="AEQ"_$S($G(ORADD):"L",1:""),ORDIC="^DIC",DIE=DIC S:$G(ORADD) DLAYGO=101.43 ;95
 S DIC("A")="   ORDERABLE ITEM: " S:$L(D) D="S."_D,ORDIC="IX^DIC"
 D @ORDIC S ORY=Y S:Y'>0 Y=$S(X["^":"^",$D(DTOUT):"^",1:""),ORY=Y
 I Y,$P(Y,U,3) S DA=+Y,ID=DA_";99ORD",DR="2///^S X=ID;5////"_+ORDG D ^DIE
 Q ORY
 ;
TRY(ORDIALOG) ; -- Test [new] dialog
 N X,Y,DIR,FIRST,ORTYPE,ORNMSP,ORVP,ORL,ORNP,AUTO W !
 S DIR(0)="YA",DIR("A")="Do you want to test this dialog now? "
 D ^DIR Q:Y'>0  W ! D GETDLG^ORCD(ORDIALOG)
 S ORTYPE="D",ORNMSP="OR",FIRST=1,(ORVP,ORL,ORNP)=0
 S AUTO=$P($G(^ORD(101.41,ORDIALOG,5)),U,8)
 X:$D(^ORD(101.41,ORDIALOG,3.1)) ^(3.1) ;editor entry action
 D DIALOG^ORCDLG,DISPLAY^ORCDLG
 X:$D(^ORD(101.41,ORDIALOG,4)) ^(4) ;dlg exit action
 Q
 ;
WINID ; -- Need to clear Window ID for GUI? [from EN]
 Q:'ORPKG  Q:'$P($G(^ORD(101.41,ORDLG,5)),U,5)  ;already cleared
 ; ck prompts to see if they match OR GXMISC GENERAL
 N ORGXMISC,ORX,ORP,ORQUIT
 F ORX="ORDERABLE ITEM","FREE TEXT 1","START DATE/TIME","STOP DATE/TIME" S ORP=+$O(^ORD(101.41,"AB","OR GTX "_ORX,0)) I ORP S ORGXMISC(ORP)="" I '$O(^ORD(101.41,ORDLG,10,"D",ORP,0)) S ORQUIT=1 Q
 I '$G(ORQUIT) S ORP=0 F  S ORP=$O(^ORD(101.41,ORDLG,10,"D",ORP)) Q:ORP'>0  I '$D(ORGXMISC(ORP)) S ORQUIT=1 Q
 S:$G(ORQUIT) $P(^ORD(101.41,ORDLG,5),U,5)="" ;clear ID
 Q
 ;
ACTION ; -- Enter/edit actions
 N DA,DR,DIE,ORNAME S DIE="^ORD(101.41,"
 F  S DA=$$DIALOG^ORCMEDT0("A") Q:DA="^"  D  W !
 . S ORNAME=$$NAME^ORCMEDT4(DA) Q:(ORNAME="@")!(ORNAME="^")
 . S DR=".01///^S X=ORNAME;2;"_$S(DUZ(0)="@":"30;40;",1:"")_"20" D ^DIE
 Q
