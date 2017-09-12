DIAC1T ;SLCISC/MKB - Test utility for Policies ;17FEB2017
 ;;22.2;VA FileMan;**8**;Jan 05, 2016;Build 19
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; -- test the current policy set [expects DITOP]
 N DIACT,DIPOL,DIFN,DIACTN,DIENS,DIUSR,DIUSRNM,DIZ,DIZTRACE,DIVAL,DITXT,DIRESULT,DIMSG,DIERR,DIFLDS
 S DIPOL=+$G(DITOP) I DIPOL<1 S VALMBCK="" Q
 D FULL^VALM1 S VALMBCK="R"
 S DIACT=$$ACTION Q:DIACT="^"
 I DIACT<1 W !!,"NOTE: This policy is not tied to an Application Action (file and action)."
 S DIFN=$P($G(^DIAC(1.61,+DIACT,0)),U,2),DIACTN=$P($G(^(0)),U,3)
 ;
 W !!,"Enter values to use for testing evaluation of "_$P(DITOP,U,2)_","
 W !,"either a valid IENS string and/or target attributes.",!
 S DIENS=$$IENS(DIFN) Q:DIENS="^"
 D ATTRBS                  ;get DIVAL(att)=value
 I DIENS<1,'$D(DIVAL) Q    ;no values to test against
 S DIUSR=$$USER Q:DIUSR<1  ;=NP#200 ien
 S DIUSRNM=$P($G(^VA(200,+DIUSR,0)),U)
 ;
 S DIZTRACE=$$TRACE Q:"^"[DIZTRACE
 S DIRESULT="" D EN^DIAC1
 I DIRESULT="P",'$L($G(DIFLDS)) D FIELDS^DIAC1(DIACT,1.61)
 ;
 ; build output array ^TMP("DIACT",$J) and display
 N DIT K ^TMP("DIACT",$J)
 I $G(DIZTRACE) D SHOWVAR,SHOWTRC,OUT("")
 D OUT("Result: "_$S(DIRESULT="P":"PERMIT",DIRESULT="D":"DENY",$G(DIERR):"ERROR",1:"INDETERMINATE"))
 I $G(DIERR) D SHOWTMP("DIERR")
 I $G(DIMSG) D SHOWTMP("DIMSG")
 I $L($G(DIFLDS)) D SHOWFLDS
 I $$TEST^DDBRT D BROWSE Q
 D WRITE
 Q
 ;
ACTION() ; -- select App Action to use for testing
 N I,X,Y,CNT,DIR,DIACT
 S (I,CNT)=0 F  S I=$O(^DIAC(1.61,"D",DIPOL,I)) Q:I<1  D
 . S CNT=CNT+1,X=$G(^DIAC(1.61,I,0)),Y=$G(^(1)),DIACT(CNT)=I
 . S:Y="" Y=$P(X,U)_" (#"_$P(X,U,2)_$S($L($P(X,U,3)):" "_$P(X,U,3),1:"")_")"
 . S DIR("A",CNT)=$$RJ^XLFSTR(CNT,3)_" "_Y
 I CNT<1 S Y=""
 I CNT=1 S Y=+$G(DIACT(1))
 I CNT>1 D  S:Y>0 Y=+$G(DIACT(Y))
 . S DIR(0)="NAO^1:"_CNT,DIR("A")="Use action: " K X,Y
 . S DIR("?")="This policy is linked to multiple actions; select the one to use for this test."
 . D ^DIR I Y<1 S Y="^"
 Q Y
 ;
IENS(FN) ; -- get IENS string for file number FN [lookup if FN?]
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
I1 S DIR(0)="FAO^1:30",DIR("A")="IENS: " D ^DIR
 I $G(Y),$G(FN),'$$VIENS(Y,FN) G I1
 Q Y
 ;
VIENS(IENS,FN) ; -- validate IENS string for file# FN
 N GBL,DIERR S GBL=$$ROOT^DILFD(FN,IENS,,1)
 I $G(DIERR) W !,$G(^TMP("DIERR",$J,1,"TEXT",1)) Q 0
 I '$D(@(GBL_+IENS_")")) D  Q 0
 . W "The entry identified by "_FN_" and "_IENS
 . W " does not exist in the database."
 Q 1
 ;
ATTRBS ; -- prompt for test attributes
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 N ATT,DILIST D LIST
 S DIR(0)="FAO^1:30" F  D  Q:"^"[Y
 . S DIR("?")="^D HELPATT^DIAC1T"
 . S DIR("A")="ATTRIBUTE: " D ^DIR Q:"^"[Y
 . S ATT=Y,DIR("A")="    VALUE: " K X,Y D ^DIR
 . S:"^"'[Y DIVAL(ATT)=Y K ATT
 Q
 ;
LIST ; -- return DILIST("attribute") of targets used by DIPOL
 N DISTK,DIMEM K DILIST
 S DISTK=1,DISTK(DISTK)=DIPOL_"^0",DISTK(0)=0,DIMEM=0
 F  S DIMEM=$O(^DIAC(1.6,+DISTK(DISTK),10,DIMEM)) D @$S(+DIMEM'>0:"POP",1:"PROC") Q:DISTK<1
 Q
 ;
POP ; -- pop the stack [set]
 S DISTK=DISTK-1,DIMEM=$P(DISTK(DISTK),U,2)
 Q
 ;
PROC ; -- process member DIMEM
 N DIEN,I,X
 S $P(DISTK(DISTK),U,2)=DIMEM
 S DIEN=+$G(^DIAC(1.6,+DISTK(DISTK),10,DIMEM,0))
 S I=0 F  S I=$O(^DIAC(1.6,DIEN,2,I)) Q:I<1  S X=$G(^(I,0)) I $L($P(X,U,2)) D
 . S DILIST($P(X,U,2))=""
 . S:$L($P(X,U,3)) DILIST($P(X,U,2),$P(X,U,3))=""
 S DISTK=DISTK+1,DISTK(DISTK)=DIEN_"^0",DIMEM=0
 Q
 ;
HELPATT ; -- help for ATTRBS
 W !,"Enter an attribute/value pair for testing evaluation of this policy."
 Q:'$D(DILIST)  I '$D(ATT) D  Q  ;show attributes
 . W !,"Target attributes used within this policy are:"
 . N I S I="" F  S I=$O(DILIST(I)) Q:I=""  W !?5,I
 I $L(ATT),$D(DILIST(ATT)) D  ;show values for ATTribute
 . W !,"Values used with this attribute are:"
 . N I S I="" F  S I=$O(DILIST(ATT,I)) Q:I=""  W !?5,I
 Q
 ;
USER() ; -- select test user from #200
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 N DIVAL ;protect from embedded ^DIC call
 S DIR(0)="PAO^200:AEQM",DIR("A")="Select Test User: "
 S DIR("B")=$P($G(^VA(200,DUZ,0)),U)
 S DIR("?")="Select a user for testing evaluation of this policy."
 W ! D ^DIR
 Q +Y
 ;
TRACE() ; -- show trace of policies/rules evaluated?
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="Y",DIR("A")="Show a trace of all policies and rules evaluated"
 S DIR("?")="Enter YES to see all rules and results displayed as they are processed."
 D ^DIR
 Q Y
 ;
SHOWVAR ; -- show variables
 N X
 F X="DIACT","DIACTN","DIENS","DIFN","DIPOL","DIUSR" D OUT(X_" = "_$S($D(@X):@X,1:"<undefined>"))
 S X="" F  S X=$O(DIVAL(X)) Q:X=""  D OUT("DIVAL("""_X_""") = "_DIVAL(X))
 Q
 ;
SHOWTMP(TYPE) ; -- display messages from ^TMP
 Q:'$L($G(TYPE))
 N I,J D OUT(""),OUT(TYPE_": "_@TYPE)
 S I=0 F  S I=$O(^TMP(TYPE,$J,I)) Q:I<1  D
 . I TYPE="DIMSG" D OUT($G(^TMP(TYPE,$J,I))) Q
 . S J=0 F  S J=$O(^TMP(TYPE,$J,I,"TEXT",J)) Q:J<1  D OUT(^(J))
 Q
 ;
SHOWTRC ; -- display DIZTRACE of processing
 ; DIZTRACE(DIZ) = PolicyIEN ^ stack level ^ match? (1/0) ^ result (P/D)
 ;       or      = PolicyIEN ^ stack level ^ done (2) ^ ResultFcnIEN
 ; DIZTRACE(#,i) = ConditionDA ^ stack level ^ result (1/0)
 ;
 N DII,DIJ,DISTK,X,Y,DIEN,DIX D OUT("")
 F DII=1:1:DIZ I $D(DIZTRACE(DII)) D
 . S X=$G(DIZTRACE(DII)),DIEN=+X,DISTK=$P(X,U,2)
 . S DIX=$$REPEAT^XLFSTR(" ",DISTK*3)_$P($G(^DIAC(1.6,DIEN,0)),U)_": "
 . I $P(X,U,3)<0 D OUT(DIX_"<disabled>") Q
 . I $P(X,U,3)=0 D OUT(DIX_"<not a match>") Q
 . I $P(X,U,3)=2 D OUT(DIX_$P($G(^DIAC(1.62,+$P(X,U,4),0)),U,2)) Q
 . I DIEN=+$G(DITOP) S DIX=DIX_"DIPOL="_DIEN S:$G(DIFN) DIX=DIX_" (DIFN="_DIFN_" & DIACTN="_DIACTN_")"
 . E  S DIX=DIX_$$TARGET(DIEN)
 . D OUT(DIX)
 . ;show conditions, if DIEN is a rule
 . S DIJ=0 F  S DIJ=$O(DIZTRACE(DII,DIJ)) Q:DIJ<1  D
 .. S Y=$G(DIZTRACE(DII,DIJ)),DISTK=$P(Y,U,2)
 .. S DIX=$$REPEAT^XLFSTR(" ",DISTK*3)_$$FCNM(DIEN,+Y)_": "_$P(Y,U,3)
 .. D OUT(DIX)
 . I $L($P(X,U,4)) S DIX=$$REPEAT^XLFSTR(" ",DISTK*3)_"DIRESULT: "_$P(X,U,4) D OUT(DIX)
 Q
 ;
FCNM(IEN,CON) ; -- return NAME(X1,X2,X3) for a function in use
 N X0,X,Y
 S X0=$G(^DIAC(1.6,IEN,3,CON,0))
 S Y=$P($G(^DIAC(1.62,+$P(X0,U,2),0)),U)
 S X=$P(X0,U,3) I $L(X) S Y=Y_"("_X_")"
 Q Y
 ;
TARGET(IEN) ; -- return target(s) that matched
 N X,Y,CONJ,KEY,DONE
 S Y="",CONJ=$P($G(^DIAC(1.6,IEN,0)),U,5),DONE=0
 S KEY="" F  S KEY=$O(^DIAC(1.6,IEN,2,"AKEY",KEY)) Q:KEY=""  D  Q:DONE
 . S X=$G(DIVAL(KEY))
 . I $L(X),$D(^DIAC(1.6,IEN,2,"AKEY",KEY,X)) S Y=Y_$S($L(Y):" & ",1:"")_KEY_"="_X
 . I $L(Y),CONJ'="&" S DONE=1
 Q Y
 ;
SHOWFLDS ; -- display DIFLDS string of available fields to access
 ; DIZTRACE("DR") = ien ^ file# returning the string
 ; DIFLDS = DR string
 ; DIFLDS(level,subfile#,n) = DR string
 ;
 Q:'$L($G(DIFLDS))
 N I,X,FN,IEN
 S X=$G(DIZTRACE("FLDS")),FN=+X,IEN=+$P(X,U,2)
 D OUT(""),OUT("DIFLDS("_$P($G(^DIAC(FN,IEN,0)),U)_"): "_$G(DIFLDS))
 S I="DIFLDS" F  S I=$Q(@I) Q:I'?1"DIFLDS(".E  D OUT(I_": "_@I)
 Q
 ;
OUT(X) ; -- add line to output
 S DIT=+$G(DIT)+1,^TMP("DIACT",$J,DIT)=$G(X)
 Q
 ;
WRITE ; -- write ^TMP output to screen
 N I,LCNT,STOP S I=0,LCNT=2,STOP=0
 W !!,$$REPEAT^XLFSTR(" ",29-$L($P(DITOP,U,2)))
 W "---------- "_$P(DITOP,U,2)_" ----------",!
 F  S I=$O(^TMP("DIACT",$J,I)) Q:I<1  D  Q:STOP
 . S LCNT=LCNT+1 I LCNT>23 D WAIT Q:STOP  S LCNT=1
 . W !,^TMP("DIACT",$J,I)
 I 'STOP D WAIT
 Q
 ;
WAIT ; -- wait for ok [returns STOP]
 N X,Y,DIR,DTOUT,DUOUT,DIRUT,DIROUT
 S DIR(0)="E" D ^DIR ;Y=1 to continue
 S STOP='Y
 Q
 ;
BROWSE ; -- use Browser to show output
 D BROWSE^DDBR("^TMP(""DIACT"",$J)","N",$P(DITOP,U,2))
 Q
