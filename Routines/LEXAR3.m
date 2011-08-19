LEXAR3 ;ISL Look-up Response (Help, Def, MAX) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
HLP ; Help
 N LEXRP,LEXMAX K LEX("HLP")
 S LEXMAX=+($G(^TMP("LEXSCH",$J,"LST",0)))
 I LEXUR["??" D EXT Q
 S LEXRP=+($P(LEXUR,"?",2,229))
 I LEXRP>0,LEXRP'>LEXMAX D  Q
 . S LEXRP=+($G(^TMP("LEXHIT",$J,LEXRP))) D DEF(LEXRP)
 I LEXUR["?",LEXRP'["?",+LEXRP'>0 D STD
 Q
STD ; Standard Help   LEX("HLP",
 I +($G(LEX))=1 D STD2 Q
 N LEXC S LEXC=+($G(LEX("HLP",0))),LEXC=LEXC+1,LEX("HLP",0)=LEXC
 S:LEX'>LEXMAX LEX("HLP",LEXC)="Select 1-"_LEXMAX_", ^ (quit), or ?# (help on a term)"
 S:LEX>LEXMAX LEX("HLP",LEXC)="Select 1-"_LEXMAX_", ^ (quit), ^# (jump - "_LEX_"), ?# (term help), or <Return> for more"
 D:$D(LEX("LIST")) LST^LEXAR
 Q
STD2 ; Standard Help   LEX("HLP",
 K LEX("HLP") S LEXRP=+($G(^TMP("LEXHIT",$J,1))) D DEF(LEXRP)
 N LEXC S LEXC=+($G(LEX("HLP",0))) I LEXC>0 S LEXC=LEXC+1,LEX("HLP",LEXC)="",LEX("HLP",0)=LEXC
 S LEXC=LEXC+1,LEX("HLP",0)=LEXC,LEX("HLP",LEXC)="Enter ""Yes"" to select, ""No"" to ignore, ""^"" to quit or ""?"" for term help"
 D:$D(LEX("LIST")) LST^LEXAR
 Q
EXT ; Extended Help   LEX("HLP",
 I +($G(LEX))=1 D EXT2 Q
 N LEXCP,LEXTP,LEXM S LEXTP=LEX\LEXLL S:LEX#LEXLL>0 LEXTP=LEXTP+1
 S LEXCP=LEXMAX\LEXLL S:LEXMAX#LEXLL>0 LEXCP=LEXCP+1
 S LEXM=$S(LEXTP>LEXCP:1,1:0) N LEXS,LEXE,LEXJ,LEXH,LEXR,LEXSTR,LEXC
 S LEXC=+($G(LEX("HLP",0))) S LEXC=LEXC+1
 S (LEXS,LEXE,LEXJ,LEXH,LEXR,LEXSTR)=""
 S LEXS="You may select 1-"_LEXMAX
 S LEXE="enter an ^ to quit" S:LEXM LEXJ="enter ^# to jump to another entry on the list (up to "_LEX_")"
 S LEXH="enter ?# to display the definition of an entry marked with an asterisk (*)"
 S:LEXM LEXR="or press <Return> to continue."
 S:'LEXM LEXR="or press <Return> to quit without making a selection."
 S LEXSTR=LEXS S:LEXE'="" LEXSTR=LEXSTR_", "_LEXE S:LEXJ'="" LEXSTR=LEXSTR_", "_LEXJ
 S:LEXH'="" LEXSTR=LEXSTR_", "_LEXH S:LEXR'="" LEXSTR=LEXSTR_", "_LEXR
 I $L(LEXSTR)>74 D
 . F  Q:$L(LEXSTR)'>74  D
 . . N LEXI F LEXI=74:-1:1 Q:$E(LEXSTR,LEXI)=" "
 . . S LEX("HLP",LEXC)=$E(LEXSTR,1,(LEXI-1)),LEX("HLP",0)=LEXC
 . . S LEXC=LEXC+1,LEXSTR=$E(LEXSTR,(LEXI+1),$L(LEXSTR))
 . I $L(LEXSTR)>0,$L(LEXSTR)'>74 S LEXC=LEXC+1,LEX("HLP",LEXC)=LEXSTR,LEX("HLP",0)=LEXC
 D:$D(LEX("LIST")) LST^LEXAR
 Q
EXT2 ; Extended help for one
 N LEXS,LEXE,LEXH,LEXSTR,LEXC,LEXDEF,LEXRP
 S (LEXS,LEXE,LEXJ,LEXC,LEXH,LEXR,LEXSTR)=""
 S LEXRP=+($G(^TMP("LEXHIT",$J,1))) D DEF(LEXRP)
 S LEXC=+($G(LEX("HLP",0))) I LEXC>0 S LEXC=LEXC+1,LEX("HLP",LEXC)="",LEX("HLP",0)=LEXC
 S LEXC=LEXC+1
 S LEXDEF=+($G(^TMP("LEXHIT",$J,1)))
 S LEXDEF=$S($D(^LEX(757.01,+LEXDEF,3)):1,1:0)
 S LEXS="There was only one term found.  Enter ""Yes"" to select, ""No"" to ignore"
 S LEXE="or an ""^"" to quit"
 S LEXH="" S:+LEXDEF>0 LEXH="""?"" to display the term definition"
 S LEXSTR=LEXS
 S:LEXH'="" LEXSTR=LEXSTR_", "_LEXH
 S:LEXE'="" LEXSTR=LEXSTR_", "_LEXE
 I $L(LEXSTR)>74 D
 . F  Q:$L(LEXSTR)'>74  D
 . . N LEXI F LEXI=74:-1:1 Q:$E(LEXSTR,LEXI)=" "
 . . S LEX("HLP",LEXC)=$E(LEXSTR,1,(LEXI-1)),LEX("HLP",0)=LEXC
 . . S LEXC=LEXC+1,LEXSTR=$E(LEXSTR,(LEXI+1),$L(LEXSTR))
 . I $L(LEXSTR)>0,$L(LEXSTR)'>74 S LEXC=LEXC+1,LEX("HLP",LEXC)=LEXSTR,LEX("HLP",0)=LEXC
 D:$D(LEX("LIST")) LST^LEXAR
 Q
DH ; Display help
 N LEXI S LEXI=0
 F  S LEXI=$O(LEX("HLP",LEXI)) Q:+LEXI=0  W !,"  ",LEX("HLP",LEXI)
 Q
DA ; Display help
 Q
 N LEXI S LEXI=0
 F  S LEXI=$O(LEX("LIST",LEXI)) Q:+LEXI=0  W !,"  ",LEX("LIST",LEXI)
 Q
DEF(LEXIEN) ; Definition Help LEX("HLP",
 N LEXR S (LEXR,LEXIEN)=+($G(LEXIEN))
 D:$D(LEX("LIST")) LST^LEXAR Q:LEXIEN'>0
 N LEXLN,LEXC S (LEXLN,LEXC)=0 K LEX("HLP")
 I '$D(^LEX(757.01,LEXIEN,3,1)),$P($G(^LEX(757.01,LEXIEN,1)),"^",2)'=1 D
 . S LEXIEN=+($G(^LEX(757.01,LEXIEN,1))),LEXIEN=+($G(^LEX(757,LEXIEN,0)))
 I $D(^LEX(757.01,LEXIEN,0)),$L($G(^LEX(757.01,LEXIEN,3,1,0))) D
 . S LEXC=1,LEX("HLP",LEXC)=$G(^LEX(757.01,LEXIEN,0)) S LEXC=LEXC+1
 . S LEX("HLP",LEXC)="",LEXC("HLP",0)=LEXC
 . F  S LEXLN=$O(^LEX(757.01,LEXIEN,3,LEXLN)) Q:+LEXLN=0  D
 . . S LEXC=LEXC+1 S LEX("HLP",LEXC)=^LEX(757.01,LEXIEN,3,LEXLN,0),LEX("HLP",0)=LEXC
 I '$D(LEX("HLP")) D
 . K LEX("HLP") S:$L($G(^LEX(757.01,LEXR,0))) LEX("HLP",1)="No definition found for "_$C(34)_^LEX(757.01,LEXR,0)_$C(34)
 . S:'$L($G(^LEX(757.01,LEXR,0))) LEX("HLP",1)="No definition found"
 D:$D(LEX("LIST")) LST^LEXAR
 Q
QMH(X) ; Question Mark Help
 N LEXX S LEXX=$G(X)
 I LEXX["?"&(LEXX'["^") D  Q
 . K LEX S LEX=0
 . ;S LEX("HLP",0)=14
 . S LEX("HLP",+($$Q))="      Enter a ""free text"" term.  Best results occur using one"
 . S:LEXX'["??" LEX("HLP",+($$Q))="      to three full or partial words without a suffix."
 . S:LEXX["??" LEX("HLP",+($$Q))="      to three full or partial words without a suffix (i.e.,"
 . S:LEXX["??" LEX("HLP",+($$Q))="      ""DIABETES"",""DIAB MELL"",""DIAB MELL INSUL"")"
 . S LEX("HLP",+($$Q))="  or  "
 . S LEX("HLP",+($$Q))="      Enter a classification code (ICD/CPT etc) to find the"
 . S:LEXX'["??" LEX("HLP",+($$Q))="      term associated with the code."
 . S:LEXX["??" LEX("HLP",+($$Q))="      term associated with the code.  Example; a lookup of "
 . S:LEXX["??" LEX("HLP",+($$Q))="      code 239.0 returns one and only one term, that is the "
 . S:LEXX["??" LEX("HLP",+($$Q))="      preferred term for the code 239.0, ""Neoplasm of "
 . S:LEXX["??" LEX("HLP",+($$Q))="      unspecified nature of digestive system"""
 . S LEX("HLP",+($$Q))="  or  "
 . S LEX("HLP",+($$Q))="      Enter a classification code (ICD/CPT etc) followed by"
 . S LEX("HLP",+($$Q))="      a plus sign (+) to retrieve all terms associated with"
 . S:LEXX'["??" LEX("HLP",+($$Q))="      the code."
 . S:LEXX["??" LEX("HLP",+($$Q))="      the code.  Example; a lookup of 239.0+ returns all"
 . S:LEXX["??" LEX("HLP",+($$Q))="      terms that are linked to the code 239.0."
 . S:$O(LEX("HLP"," "),-1)>0 LEX("HLP",0)=$O(LEX("HLP"," "),-1)
 . S LEX("NAR")=$S(LEXX["??":"??",1:"?")
 I LEXX["?"&(LEXX'["??")&(LEXX'["^") D  Q
 . K LEX S LEX=0,LEX("HLP",0)=1,LEX("HLP",1)="      "_$$SQ^LEXHLP,LEX("NAR")="?"
 Q
Q(X) ; Help Counter
 Q ($O(LEX("HLP"," "),-1)+1)
