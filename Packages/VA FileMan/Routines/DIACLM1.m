DIACLM1 ;SLCISC/MKB - Policy Editor actions ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
ADD ; -- add/remove members
 N X,Y,DAD,TYPE,DONE,DIFF,ITM,DIE,DA,DR,DIC S VALMBCK=""
 L +^DIAC(1.6,0):DILOCKTM I '$T W !,"Another user is editing policies." H 2 Q
 I VALMCNT=1 S DAD=+$G(^TMP("DIAC",$J,"IEN",1)) Q:DAD<1
 E  S DAD=+$$SELECT("To policy") Q:DAD<1
 I $P($G(^DIAC(1.6,DAD,0)),U,2)="R" W !,"Rules may not have members.",! H 2 Q
 L +^DIAC(1.6,DAD):DILOCKTM I '$T W !,"Another user is editing "_$P(DAD,U,2) H 2 Q
 S TYPE=$P($G(^DIAC(1.6,DAD,0)),U,2),(DONE,DIFF)=0
 ;
 D FULL^VALM1 S VALMBCK="R"
 F  D  Q:DONE
 . S ITM=$$DIR I ITM<1 S DONE=1 Q
 . I $P(ITM,U,3) D  Q:'$D(DA)  ;deleted
 .. S DR=".01;2;I $P($G(^DIAC(1.6,+DA,2,0)),U,4)<2 S Y=""@1"";.05R;@1;"
 .. I $G(TYPE)="P" S DR=DR_"3;I $P($G(^DIAC(1.6,+DA,3,0)),U,4)<2 S Y=""@2"";.06R;@2;.08R;7.1;7;8.1;8"
 .. E  S DR=DR_".07R;7.1;7;8.1;8"
 .. K DA,DIC S DIE="^DIAC(1.6,",DA=+ITM D ^DIE
 . ;
 . K DA,DIC S DA=$O(^DIAC(1.6,DAD,10,"B",+ITM,0)),DA(1)=+DAD,DIFF=1
 . I 'DA D  Q  ;add new member
 .. N LAST S LAST=$O(^DIAC(1.6,DA(1),10,"AC",""),-1)\1 ;integer
 .. S DIC="^DIAC(1.6,"_DA(1)_",10,",DIC(0)="AEQ",X=+ITM,DIC("DR")=".02//"_(LAST+1)
 .. D FILE^DICN S DA=+Y
 . S DR=".01;.02",DIE="^DIAC(1.6,"_DA(1)_",10," D ^DIE
 ;
 L -^DIAC(1.6,DAD),-^DIAC(1.6,0)
 I DIFF S ^TMP("DIACX",$J,+DAD)="" D INIT^DIACLM ;rebuild
 Q
 ;
DIR() ; -- find member policy (return X & Y as if ^DIC)
 N X,Y,DIR
 S DIR(0)="FAO^3:30^D DIC^DIACLM1"
 S DIR("A")="Select MEMBER: "
 S DIR("?")="Enter a unique name, 3-30 characters, beginning with the package namespace"
 S DIR("??")="^D MEMHLP^DIACLM1"
 W ! D ^DIR
 Q Y
 ;
DIC ; -- input transform to look up X in #1.6, return Y=ien^name[^1]
 N DIC,DLAYGO,DA
 S DIC=1.6,DIC(0)="ELQZ",DLAYGO=1.6,DA(1)=DAD
 S DIC("S")="I $P(^(0),U,2)"_$S(TYPE="P":"=""R""",1:"'=""R"",'$$TREE^DIACX")
 S DIC("DR")=$S(TYPE="P":".02////R",1:".02;I X=""R"" W !,""A Rule may not be a member of a set!"" S Y=.02")
 D ^DIC I Y<1 K X Q
 S X=$P(Y,U,2) ;return Y=ien^name[^1 if new]
 Q
 ;
MEMHLP ; -- Xecutable help to show current members of policy DAD
 N X,Y,D,DZ,DIC
 S DIC="^DIAC(1.6,"_DAD_",10,",DIC(0)="EQ",D="B",DZ="??" D DQ^DICQ
 W !?8,"You may enter a new MEMBER, if you wish."
 W !?8,"Enter a policy, set, or rule that is not an ancestor of this item."
 W !?8,"Members of a policy must be rules; sets may include policies or sets.",!
 S DIC("S")="I $P(^(0),U,2)"_$S($G(TYPE)="P":"=",1:"'=")_"""R"""
 S DIC="^DIAC(1.6,",X="?" K DZ D ^DIC
 Q
 ;
EDIT ; -- edit item
 N VALMY,DDSFILE,DDSPARM,DDSCHANG,DII,DA,DR,DIFF,DTOUT
 D EN^VALM2(XQORNOD(0)) I '$O(VALMY(0)) S VALMBCK="" Q
 D FULL^VALM1 S VALMBCK="R"
 S DDSFILE=1.6,DDSPARM="C",DIFF=0
 S DII=0 F  S DII=$O(VALMY(DII)) Q:DII<1  D
 . S DA=+$G(^TMP("DIAC",$J,"IEN",DII)) Q:DA<1
 . L +^DIAC(1.6,DA):DILOCKTM I '$T W !,"Another user is editing #"_I H 2 Q
 . S DR="[DIAC "_$$UP^XLFSTR($$GET1^DIQ(1.6,DA_",",.02))_"]" K DDSCHANG
 . W !,"Loading form to edit #"_DII_" ..." H 1
 . D ^DDS S:$G(DDSCHANG) DIFF=1 I '$G(DA) D  ;deleted
 .. S DA=+$G(^TMP("DIAC",$J,"IEN",DII)),DIFF=1 Q:DA<1
 .. D DELDAD(DA)  ;remove members
 .. Q:DA'=+DITOP  ;select a new policy to display, if needed
 .. S DITOP=$$SELECT^DIACLM I DITOP<1 S VALMBCK="Q" Q
 .. K VALMHDR,^TMP("DIACX",$J)
 .. S VALMBCK="R",^TMP("DIACX",$J,+DITOP)=""
 . L -^DIAC(1.6,DA)
 D:DIFF INIT^DIACLM
 Q
 ;
DELETE ; -- delete item
 N DA S VALMBCK=""
 S DA=+$$SELECT Q:DA<1
 I $O(^DIAC(1.6,"AD",DA,0))!(DA=+DITOP) D FULL^VALM1 S VALMBCK="R"
 D DEL Q:$D(^DIAC(1.6,DA,0))  ;quit - not deleted
 S VALMBCK="R"
 I DA=+DITOP D  Q:VALMBCK="Q"  ; select a new policy to display, if needed
 . S DITOP=$$SELECT^DIACLM I DITOP<1 S VALMBCK="Q" Q
 . K VALMHDR,^TMP("DIACX",$J)
 . S VALMBCK="R",^TMP("DIACX",$J,+DITOP)=""
 D INIT^DIACLM
 Q
DEL ; enter here from option with DA
 N DIK,DAD,DAC
 I $O(^DIAC(1.6,"AD",DA,0)) D  W !
 . W !,$P($G(^DIAC(1.6,DA,0)),U)_" will also be removed as a member from:"
 . S DAD=0 F  S DAD=$O(^DIAC(1.6,"AD",DA,DAD)) Q:DAD<1  W !?3,$P(^DIAC(1.6,DAD,0),U)
 I $O(^DIAC(1.61,"D",DA,0)) D  W !
 . W !,$P($G(^DIAC(1.6,DA,0)),U)_" will also be unlinked as a policy for:"
 . S DAC=0 F  S DAC=$O(^DIAC(1.61,"D",DA,DAC)) Q:DAC<1  W !?3,$P(^DIAC(1.61,DAC,0),U)
 I '$$SURE(DA) W !,"Nothing deleted!" Q
 L +^DIAC(1.6,0):DILOCKTM I '$T W !,"Another user is editing policies." H 2 Q
 L +^DIAC(1.6,DA):DILOCKTM I '$T W !,"Another user is editing this policy." H 2 Q
 S DIK="^DIAC(1.6," D ^DIK
 L -^DIAC(1.6,DA)
 D DELDAD(DA)   ;clean up ancestors
 D DELACT(DA)   ;clean up actions
 L -^DIAC(1.6,0)
 Q
DELDAD(IEN) ; -- remove IEN as a member from parent policies
 N DA,DIK,DAD S DAD=0
 F  S DAD=$O(^DIAC(1.6,"AD",+$G(IEN),DAD)) Q:DAD<1  S DA=+$O(^(DAD,0)) D
 . L +^DIAC(1.6,DAD):DILOCKTM I '$T W !,"Another user is editing policy #"_DAD H 2 Q
 . S DA(1)=DAD,DIK="^DIAC(1.6,"_DA(1)_",10,"
 . D ^DIK
 . L -^DIAC(1.6,DAD)
 Q
DELACT(IEN) ; -- remove IEN as a policy for Application Actions
 N DA,DIE,DR S DA=0
 F  S DA=$O(^DIAC(1.61,"D",+$G(IEN),DA)) Q:DA<1  D
 . L +^DIAC(1.61,DA):DILOCKTM I '$T W !,"Another user is editing action #"_DA H 2 Q
 . S DIE="^DIAC(1.61,",DR=".05////@"
 . D ^DIE
 . L -^DIAC(1.61,DA)
 Q
 ;
SURE(IEN) ; -- are you sure?
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="YA",DIR("A")="Are you sure? ",DIR("B")="NO"
 S DIR("?",1)="Enter NO if you only want to remove this item as a member of a policy."
 S DIR("?")="Enter YES to delete this item from the file"
 I $G(IEN),$O(^DIAC(1.6,"AD",IEN,0)) S DIR("?")=DIR("?")_"; it will also be removed as a Member from its parent policies"
 S DIR("?")=DIR("?")_".",DIR("?",2)="   "
 D ^DIR
 Q +Y
 ;
DISABLE ; -- disable item
 D FULL^VALM1 S VALMBCK="R"
 N DA S DA=+$$SELECT Q:DA<1
 D DIS,INIT^DIACLM
 Q
DIS ;enter here from option with DA
 N X,Y,DIE,DR,DUOUT,DTOUT,DIRUT
 W !!,"WARNING: Disabling a policy will prevent it and ALL its members from being"
 W !,"processed when data access is being evaluated!",!
 L +^DIAC(1.6,DA):DILOCKTM I '$T W !,"Another user is editing this policy." H 2 Q
 S DIE="^DIAC(1.6,",DR=.03 D ^DIE
 L -^DIAC(1.6,DA)
 Q
 ;
EXPAND ; -- expand/collapse items
 N I,VALMY,DA
 D EN^VALM2(XQORNOD(0)) I '$O(VALMY(0)) S VALMBCK="" Q
 S I=0 F  S I=$O(VALMY(I)) Q:I<1  D
 . S DA=+$G(^TMP("DIAC",$J,"IEN",I)) Q:DA<1
 . Q:'$O(^DIAC(1.6,DA,10,0))  ;no members
 . I $D(^TMP("DIACX",$J,DA)) K ^(DA)
 . E  S ^TMP("DIACX",$J,DA)=""
 W !!,"Re-building the list..." H 1
 D INIT^DIACLM S VALMBCK="R"
 Q
 ;
DETAIL ; -- show details
 N DA,DIC,DAD
 S DIC="^DIAC(1.6,",VALMBCK=""
 S DA=+$$SELECT Q:DA<1
 W ! D FULL^VALM1,EN^DIQ
 I $O(^DIAC(1.6,"AD",DA,0)) D
 . W !,"MEMBER OF: "
 . S DAD=0 F  S DAD=$O(^DIAC(1.6,"AD",DA,DAD)) Q:DAD<1  W !?3,$P(^DIAC(1.6,DAD,0),U)
 D WAIT S VALMBCK="R"
 Q
 ;
CHANGE ; -- select a different policy/set to manage
 S VALMBCK=""
 N X S X=$$SELECT^DIACLM Q:X<1  Q:+X=+DITOP
 K VALMHDR,^TMP("DIACX",$J)
 S DITOP=X,VALMBCK="R",^TMP("DIACX",$J,+DITOP)=""
 D INIT^DIACLM
 Q
 ;
TYPE() ; -- select type
 N X,Y,DIR
 S DIR(0)="1.6,.02" D ^DIR
 I Y?1U S Y=Y_U_Y(0)
 Q Y
 ;
SELECT(PROMPT) ; -- select 1 item from list
 N X,Y,DIR
 S DIR("A")=$S($L($G(PROMPT)):PROMPT,1:"Select Item")_" (1-"_VALMCNT_"): "
 S DIR(0)="NAO^1:"_VALMCNT D ^DIR
 I Y S Y=$G(^TMP("DIAC",$J,"IEN",Y)) W "   "_$P(Y,U,2)
 E  S Y=""
 Q Y
 ;
WAIT ; -- hold screen
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E" D ^DIR
 S VALMBCK=$S(Y="":"Q",1:"R")
 Q
 ;
TEST ; -- test current policy
 D EN^DIAC1T S VALMBCK="R"
 Q
 ;
EXIT ; -- exit editor
 S VALMBCK="Q"
 Q
 ;
LINK ; -- link policy to actions
 N X,Y,DLAYGO,DIC,DIE,DR,DA
 I '$O(^DIAC(1.61,"D",+DITOP,0)) W !!,"No Application Actions are linked to "_$P(DITOP,U,2)_"."
 E  D
 . W !!,"The following Application Actions are linked to policy "_$P(DITOP,U,2)_":"
 . S Y=0 F  S Y=$O(^DIAC(1.61,"D",+DITOP,Y)) Q:Y<1  D
 .. S X=$G(^DIAC(1.61,Y,0))
 .. W !?3,$P(X,U)_"     "_$P(X,U,2)_"     "_$P(X,U,3)
 L +^DIAC(1.61,0):DILOCKTM I '$T W !,"Another user is editing Application Actions." H 2 Q
L1 ;loop back
 S DIC=1.61,DIC(0)="AELMQ",DLAYGO=1.61,DIC("DR")=".02:.04;1"
 W ! D ^DIC I Y<1 L -^DIAC(1.61,0) Q
 S DIE=DIC,DA=+Y,DR=.05 D ^DIE
 K X,Y,DR,VALMHDR
 G L1
 Q
 ;
ACTIONS ; -- edit Actions [Option]
 N X,Y,DIC,DIE,DA,DR,DLAYGO
 L +^DIAC(1.61,0):DILOCKTM I '$T W !,"Another user is editing Application Actions." H 2 Q
ACT1 ; loop back here
 S DIC=1.61,DIC(0)="AEQL",DLAYGO=1.61,DIC("A")="Select APPLICATION ACTION: "
 D ^DIC I Y<1 L -^DIAC(1.61,0) Q
 S DA=+Y I '$P(Y,U,3) W ! D EN^DIQ ;display
 S DIE=DIC,DR=".01:.04;1;5;I X="""" S Y="""";5.1" D ^DIE
 K X,Y,DLAYGO,DIC,DIE,DA,DR
 W ! G ACT1
 Q
 ;
FCNS ; -- edit Functions
 N X,Y,DIC,DIE,DA,DR,DLAYGO,TYPE
 L +^DIAC(1.62,0):DILOCKTM I '$T W !,"Another user is editing Functions." H 2 Q
FC1 ; loop back here
 S DIC=1.62,DIC(0)="AEQLZ",DLAYGO=1.62,DIC("A")="Select POLICY FUNCTION: "
 D ^DIC I Y<1 L -^DIAC(1.62,0) Q
 S TYPE=$P(Y(0),U,3)
 S DA=+Y I '$P(Y,U,3) W ! D EN^DIQ ;display
 I DA<1000 W $C(7),!,"VA FILEMAN functions are uneditable!"
 E  S DIE=DIC,DR=".01;.02;I X'=""R"" S Y=1;.04;1;2" D ^DIE K X,Y,DLAYGO,DIC,DR
 I $G(DA),$$ASSIGN(TYPE) D ADDPOL(TYPE)
 W !! G FC1
 Q
 ;
ADDPOL(T) ; -- add a function to a policy
 N X,Y,DIC,DA,DR,DIE,DONE,DIAT S DIAT=$G(T)
 S DR=$S(DIAT="A":.04,DIAT="R":.07,DIAT="O":"7;8",DIAT="C":3,1:"")
 S:DIAT="C" DIC("S")="I $P(^(0),U,2)=""R"""
 S:DIAT="R" DIC("S")="I $P(^(0),U,2)'=""R"""
 S DONE=0 F  D  Q:DONE
 . S DIC=1.6,DIC(0)="AEQZ" W !
 . D ^DIC I $G(Y)<1 S DONE=1 Q
 . S DIE="^DIAC(1.6,",DA=+Y D ^DIE
 D:DIAT="R" INIT^DIACLM
 Q
 ;
ASSIGN(T) ; -- want to assign a function to a policy?
 N X,Y,DIR,NAME S T=$G(T)
 S NAME=$S(T="A":"ATTRIBUTE",T="R":"RESULT",T="O":"OBLIGATION",T="C":"CONDITION",1:"")
 S DIR("?")="Enter YES to edit the "_NAME_" FUNCTION of selected policies"
 S DIR("A")="Do you want to assign this "_NAME_" function to a policy? "
 S DIR(0)="YAO" W ! D ^DIR
 Q +Y
