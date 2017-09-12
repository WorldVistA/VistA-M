DIACLM ;SLCISC/MKB - Policy Editor driver ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- main entry point for DIAC POLICY EDITOR
 S DITOP=$$SELECT Q:DITOP<1
 K ^TMP("DIACX",$J) S ^($J,+DITOP)=""
 D EN^VALM("DIAC POLICY EDITOR")
 Q
 ;
HDR ; -- header code
 N I,X,Y,X0,F,DIACT
 S Y=0 F  S Y=+$O(^DIAC(1.61,"D",+DITOP,Y)) Q:Y<1  D
 . S X0=$G(^DIAC(1.61,Y,0)),X=$G(^(1)) S:X="" X=$P(X0,U,3)
 . ; DIACT(file#,ien)=description or name
 . S DIACT(+$P(X0,U,2),Y)=X
 I '$O(DIACT(0)) S VALMHDR(1)="For: <no linked Application Action>" Q
 ;
 S (I,F)=0 F  S F=$O(DIACT(F)) Q:F<1  D
 . S X="#"_F,Y=0
 . F  S Y=$O(DIACT(F,Y)) Q:Y<1  S X=X_", "_DIACT(F,Y)
 . S I=I+1,VALMHDR(I)=$S(I=1:"For: ",1:"     ")_$E(X,1,75)
 Q
 ;
INIT ; -- init variables and list array
 N SEQ,STK K ^TMP("DIAC",$J)
 S VALMCNT=0,STK=0 D ADD(+DITOP)
 S STK=1,STK(STK)=+DITOP_"^0",STK(0)=0
 ; expand members, if in DIACX list
 I $D(^TMP("DIACX",$J,+DITOP)) S SEQ=0 F  S SEQ=$O(^DIAC(1.6,+STK(STK),10,"AC",SEQ)) D @$S(SEQ'>0:"POP",1:"PROC") Q:STK<1
 S ^TMP("DIAC",$J,0)=VALMCNT_U_+DITOP
 S VALMBCK="R",VALMBG=1
 Q
 ;
POP ; -- pop the stack
 S STK=STK-1,SEQ=$P(STK(STK),U,2)
 Q
PROC ; -- process member
 N IEN S $P(STK(STK),U,2)=SEQ
 S IEN=+$O(^DIAC(1.6,+STK(STK),10,"AC",SEQ,0)) D ADD(IEN)
 ; push stack, if expanding policy/set
 I $D(^TMP("DIACX",$J,IEN)) S STK=STK+1,STK(STK)=IEN_"^0",SEQ=0
 Q
 ;
ADD(DA) ; -- add row
 N PREFIX,X0,NAME,TYPE,EFFECT,LINE
 S PREFIX=$S('$O(^DIAC(1.6,DA,10,0)):" ",$D(^TMP("DIACX",$J,DA)):"-",1:"+")
 S X0=$G(^DIAC(1.6,DA,0)),NAME=$P(X0,U)
 I $P(X0,U,3) S NAME="("_NAME_")" ;disabled
 S NAME=PREFIX_NAME S:$G(STK) NAME=$$REPEAT^XLFSTR(" ",STK*2)_NAME
 S TYPE=$$EXTERNAL^DILFD(1.6,.02,,$P(X0,U,2))
 I $P(X0,U,7) S EFFECT=$P(^DIAC(1.62,+$P(X0,U,7),0),U,2)
 E  S EFFECT=$$EXTERNAL^DILFD(1.6,.08,,$P(X0,U,8))
 S VALMCNT=VALMCNT+1,LINE=$$SETFLD^VALM1(VALMCNT,"","NUMBER")
 S LINE=$$SETFLD^VALM1(NAME,LINE,"NAME")
 S LINE=$$SETFLD^VALM1(TYPE,LINE,"TYPE")
 S LINE=$$SETFLD^VALM1(EFFECT,LINE,"RESULT")
 D SET^VALM10(VALMCNT,LINE,VALMCNT)
 S ^TMP("DIAC",$J,"IEN",VALMCNT)=DA_U_$P(X0,U)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K ^TMP("DIAC",$J),^TMP("DIACX",$J),DITOP
 Q
 ;
EXPND ; -- expand code
 Q
 ;
SELECT() ; -- select a policy/set
 N X,Y,DIC,DLAYGO
 S DIC=1.6,DLAYGO=1.6,DIC(0)="AEQL",DIC("A")="Select POLICY: "
 S DIC("?")="Select or create a policy to view and manage."
 D FULL^VALM1,^DIC
 S VALMBCK="R"
 Q Y
