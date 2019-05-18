DIACX ;SLCISC/KCM,MKB - Policy utilities ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ; External References          ICR#
 ; -------------------          ----
 ; ^XUSEC                      10076
 ; XUA4A72                      1625
 ;
SCR() ; -- set Member screen to ensure type is compatible w/parent
 N DAD,Y
 S DAD=$P($G(^DIAC(1.6,+$G(DA(1)),0)),U,2),Y="I 1"
 I DAD="R" S Y="I 0"                   ;  Rule: no members
 I DAD="P" S Y="I $P(^(0),U,2)=""R"""  ;Policy: Rules only
 I DAD="S" S Y="I $S($P(^(0),U,2)=""R"":0,$P(^(0),U,2)=""P"":1,1:'$$TREE^DIACX)"
 Q Y
 ;
TREE() ; -- look back up tree to make sure item is not ancestor
 N DIACDAD,DDI,Z
 S DIACDAD=DA(1) I Y=DIACDAD Q 1          ;parent
 ; $O(^DIAC(1.6,DIACDAD,10,"B",Y,0)) Q 1  ;sibling?
 S Z=0 D TR1                              ;ancestors
 Q Z
TR1 F DDI=0:0 S DDI=$O(^DIAC(1.6,"AD",DIACDAD,DDI)) Q:DDI'>0  S:DDI=Y Z=1 Q:Z  D TR2
 Q
TR2 N DIACDAD S DIACDAD=DDI N DDI D TR1
 Q
 ;
CHKNAME(FN) ;CHECK A NAME, AND DISPLAY APPROPRIATE MESSAGE
 I $D(^DIAC(FN,"B",X)) D EN^DDIOL("   Duplicate names not allowed.") K X Q
 N %,%1 D NAME E  D EN^DDIOL("Not a known package or a local namespace.") Q
 D EN^DDIOL("  Located in the "_$E(X,1,%)_" ("_%1_") namespace.")
 Q
NAME ;CHECK NAMESPACING IN PACKAGE FILE.
 I $E(X,1)="A"!($E(X,1)="Z") S %=1,%1="Local" Q
 F %=4:-1:2 G:$D(^DIC(9.4,"C",$E(X,1,%))) NAMEOK
 I 0
 Q
NAMEOK ;FOUND
 S %1=$O(^DIC(9.4,"C",$E(X,1,%),0))
 I %1 S:$D(^DIC(9.4,%1,0)) %1=$P(^(0),U) I 1 Q
 I 0
 Q
TEST ;TEST CHKNAME
 W !,"Enter a name, and the computer will respond with the namespace to which"
 W !,"that name belongs.  It does this by looking at the package file.",!!
T1 R !,"NAME: ",X:DTIME,"  " Q:$G(X)=""
 D CHKNAME G T1
 Q
 ;
ORPHANS  ; -- find orphan entries [rule w/o a policy, pol/set w/o parent or event]
 N I,X S I=0
 F  S I=$O(^DIAC(1.6,I)) Q:I<1  S X=$G(^(I,0)) I '$O(^DIAC(1.6,"AD",I,0))  D
 . I $P(X,U,2)="R" W !,I,?10,$P(X,U),?40,"-- rule w/o policy" Q
 . I '$O(^DIAC(1.61,"D",I,0)) W !,I,?10,$P(X,U),?40,"-- no parent policy/set or event"
 Q
 ;
SEQ ; -- Xecutable help to show Member sequence numbers in use
 W !?3,"Sequence numbers already in use:"
 N SEQ,IEN
 S SEQ=0 F  S SEQ=$O(^DIAC(1.6,DA(1),10,"AC",SEQ)) Q:SEQ<1  D
 . S IEN=0 F  S IEN=$O(^DIAC(1.6,DA(1),10,"AC",SEQ,IEN)) Q:IEN<1  D
 .. W !?3,SEQ,?10,$P($G(^DIAC(1.6,IEN,0)),U)
 W !
 Q
 ;
 ; -- ScreenMan form utilities:
 ;
REQTCONJ ; -- require conjunction? [Target block post-action]
 N X0,IENS,X
 S X0=@(DIE_"0)"),IENS=DA(1)_",",X=$S($P(X0,U,4)>1:1,1:0)
 D REQ^DDSUTL("CONJUNCTION","DIAC POLICY 1A",1,X,IENS)
 Q
 ;
CKTCONJ ; -- ask Conjunction again? [branching logic]
 I $G(X)="",$P($G(^DIAC(1.6,+$G(DA),2,0)),U,4)>1 D
 . D HLP^DDSUTL("Conjunction is required for multiple attributes.")
 . S DDSBR="CONJUNCTION"
 Q
 ;
REQCCONJ ; -- require conjunction? [Condition block post-action]
 N X0,IENS,X
 S X0=@(DIE_"0)"),IENS=DA(1)_",",X=$S($P(X0,U,4)>1:1,1:0)
 D REQ^DDSUTL("CONJUNCTION","DIAC RULE 2",2,X,IENS)
 Q
 ;
CKCCONJ ; -- ask Conjunction again? [branching logic]
 I $G(X)="",$P($G(^DIAC(1.6,+$G(DA),3,0)),U,4)>1 D
 . D HLP^DDSUTL("Conjunction is required for multiple conditions.")
 . S DDSBR="CONJUNCTION"
 Q
 ;
EFFECT ; -- ask Effect/Result again? [branching logic]
 I $G(X)="" D
 . D HLP^DDSUTL("Result is required; please select Permit or Deny.")
 . S DDSBR="RESULT"
 Q
 ;
RESULT ; -- ask Result Function again? [branching logic]
 I $G(X)="" D
 . D HLP^DDSUTL("Result Function is required for policies and sets.")
 . S DDSBR="RESULT FUNCTION"
 Q
 ;
 ; -- Policy Functions:
 ;
HASKEY ; -- does user hold key X?
 S Y=$D(^XUSEC(X,+$G(DIUSR)))
 Q
 ;
BOOL ; -- evaluates DIVAL(X) as a boolean, returns 1 or 0 in Y
 S Y=$S(+$G(DIVAL(X)):1,1:0)
 Q
 ;
PCLS(CLASS,USER) ; -- is user a member of Person Class X?
 ; X = IEN or VA Code for Person Class #8932.1
 N Y
 S Y=$$GET^XUA4A72(+$G(USER)),CLASS=$G(CLASS)
 I +CLASS=CLASS,CLASS=+Y Q 1 ;IEN
 I CLASS=$P(Y,U,7) Q 1       ;VA Code
 Q 0
