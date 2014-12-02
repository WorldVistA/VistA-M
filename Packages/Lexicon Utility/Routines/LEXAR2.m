LEXAR2 ;ISL/KER - Look-up Response (up arrow/jump/null) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    None
 ;               
UPA(LEXUR) ; Up-Arrow Detected
 I LEXUR="^^" S X=LEXUR D EDA^LEXAR Q
 N LEXR S LEXR=$P(LEXUR,"^",2,299)
 I +LEXR>0,+LEXR'>LEX D JMP Q
 S LEXUR=$E(LEXUR,1) I LEXUR="^",+LEXR=0 S X=LEXUR D EDU^LEXAR Q
 Q
NULL ; Null response
 N LEXEOA,LEXN S LEXEOA=+($P($G(LEX("LIST",0)),"^",1))
 I LEXEOA=0 D EDA^LEXAR Q
 S LEX=+($G(^TMP("LEXSCH",$J,"NUM",0))) I LEX=0 D EDA^LEXAR Q
 I LEXEOA=LEX!(LEXEOA>LEX) D EDU^LEXAR Q
 I LEXEOA'=LEX,LEXEOA<LEX D LIST^LEXAL2("PGDN")
 Q
JMP ; Jump to # on list
 S LEXR=+($G(LEXR)) Q:LEXR'>0!(LEXR>LEX)
 D LIST^LEXAL2(LEXR)
 Q
