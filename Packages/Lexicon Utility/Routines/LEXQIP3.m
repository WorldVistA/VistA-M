LEXQIP3 ;ISL/KER - Query - ICD Procedure - Save ;12/19/2014
 ;;2.0;LEXICON UTILITY;**62,73,80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXQIPO")     SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$VSEX^ICDEX        ICR   5747
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXCDT             Code Set Versioning Date
 ;    LEXDG              DRG Array
 ;    LEXIEN             Internal Entry Number
 ;    LEXLEN             Offset Length
 ;    LEXSO              Code
 ;    LEXNAM             Unversioned Name
 ;    LEXST              Status and Effective Dates
 ;    LEXSD              Versioned Short Description
 ;    LEXLD              Versioned Long Description
 ;    LEXWN              Warning
 ;    LEXMOR             Major O.R. Procedure
 ;    LEXDG              MDC/DRG
 ;    LEXELDT            External Last Date
 ;    LEXLX              Lexicon Expressioin
 ;              
EN ; Main Entry Point
 K ^TMP("LEXQIPO",$J) Q:'$L($G(LEXELDT))  I +($G(LEXST))<0 D FUT D:$D(^TMP("LEXQIPO",$J)) DSP^LEXQO("LEXQIPO") Q
 D FUL D:$D(^TMP("LEXQIPO",$J)) DSP^LEXQO("LEXQIPO")
 Q
FUT ; Future Activation
 N LEX1,LEX2,LEX3,LEXEFF,LEXI,LEXL,LEXSTA S LEXI=+($G(LEXIEN)) Q:+LEXI'>0
 S LEXL=+($G(LEXLEN)) Q:+LEXL'>0  S:LEXL>62 LEXL=62
 Q:'$L(LEXSO)  Q:'$L(LEXNAM)  S LEXSTA=$G(LEXST)
 S LEXEFF=$P(LEXSTA,"^",5),LEXSTA=$P(LEXSTA,"^",4)
 Q:'$L(LEXSTA)  Q:'$L(LEXEFF)  S (LEX1,LEX2,LEX3)=""
 D BOD(LEXELDT),COD(LEXSO,LEXNAM,+($G(LEXL))),STA(.LEXST,+($G(LEXL)))
 Q
BOD(X) ;   Based on Date
 N LEXBOD S LEXBOD=$G(X),X="Display based on date:  "_LEXBOD D BL,TL(X)
 Q
COD(X,Y,LEXLEN) ;   Code Line
 N LEXC,LEXN,LEXT S LEXC=$G(X),LEXN=$G(Y),LEXT="Code:  "_LEXC
 S LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 Q
STA(X,LEXLEN) ;   Status Line
 N LEX,LEXC,LEXX,LEXE,LEXI,LEXN,LEXS,LEXT,LEXW,LEXEFF,LEXSTA
 S LEXX=$G(X),LEXSTA=$P(LEXX,"^",4),LEXEFF=$P(LEXX,"^",5)
 S LEXEFF=$TR(LEXEFF,"()",""),LEXW=$P(LEXX,"^",6)
 S LEXT="  Status:  ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXSTA
 S LEXT=LEXT_$J(" ",(35-$L(LEXT)))
 S:LEXEFF'["future" LEXT=LEXT_"Effective:  "
 S LEXT=LEXT_$$UP^XLFSTR($E(LEXEFF,1))_$E(LEXEFF,2,$L(LEXEFF)) D BL,TL(LEXT)
 I $L(LEXW) D
 . N LEX,LEXT,LEXC,LEXI,LEXN S LEX(1)=LEXW D PR^LEXQM(.LEX,(LEXLEN-7))
 . Q:+($O(LEX(" "),-1))'>0  S LEXT=$J(" ",((79-+($G(LEXLEN)))))
 . S (LEXC,LEXI)=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI'>0  D
 . . N LEXN S LEXN=$$TM^LEXQM($G(LEX(LEXI))) S:$L(LEXN) LEXC=LEXC+1
 . . D:LEXC=1 BL D TL((LEXT_LEXN))
 Q
FUL ; Full Display
 N LEXFUL,LEX,LEXL S LEXL=+($G(LEXLEN)) S:LEXL>62 LEXL=62
 S LEXFUL=""  D FUT
 D LIM(+($G(LEXIEN)),+($G(LEXL)))
 D SD(.LEXSD,+($G(LEXL)))
 D LD(.LEXLD,+($G(LEXL)))
 D LX(.LEXLX,+($G(LEXL)))
 D WN(.LEXWN,+($G(LEXL)))
 D MOR(.LEXMOR,+($G(LEXL)))
 D DRG(.LEXDG,+($G(LEXL)))
 Q
LIM(X,LEXLEN) ;   Limitations - Sex
 N LEXC,LEXH,LEXI,LEXS,LEXT S LEXC=0,LEXI=+($G(X)) S LEXS=$$VSEX^ICDEX(80.1,+LEXI,$G(LEXCDT)) Q:"^M^F^"'[("^"_LEXS_"^")
 S LEXH="Use only with the " S:LEXS="F" LEXH=LEXH_"female sex" S:LEXS="M" LEXH=LEXH_"male sex"
 S LEXT="  Limitations: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXH
 D BL,TL(LEXT) S LEXC=1
 Q
SD(X,LEXLEN) ;   Short Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Short Name: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 Q
LD(X,LEXLEN) ;   Long Description
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Description: ",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))) S LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
LX(X,LEXLEN) ;   Lexicon Expression
 N LEXI,LEXH,LEXE,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)),LEXT="  Lexicon Term:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT)
 S LEXE=$G(X(0)),LEXT="    "_LEXE,LEXN=$G(X(2)),LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=2 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
WN(X,LEXLEN) ;   Warning
 N LEXI,LEXH,LEXE,LEXN,LEXT,LEXC Q:'$D(X(1))  S LEXC=0,LEXN=$G(X(1)),LEXT="",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN
 D:$L($G(LEXLD(2))) BL D TL(LEXT)
 S LEXT=$J(" ",((79-+($G(LEXLEN))))),LEXI=1 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=LEXT_$G(X(LEXI)) D TL(LEXN)
 Q
MOR(X,LEXLEN) ;   Major OR Procedure
 N LEXE,LEXH,LEXI,LEXID,LEXN,LEXT Q:'$D(X(1))  Q:'$D(X(1,1))  S LEXID=$G(X(1)) Q:'$L(LEXID)  S LEXN=$G(X(1,1)) Q:'$L(LEXN)
 S LEXT="  Major OR Proc",LEXE="Major O.R. Procedure",LEXE=LEXN,LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXE D BL,TL(LEXT)
 S LEXI=1 F  S LEXI=$O(X(1,LEXI)) Q:+LEXI'>0  S LEXE=$G(X(1,LEXI)) I $L(LEXE) S LEXT=$J(" ",((79-+($G(LEXLEN)))))_LEXE D TL(LEXT)
 Q
DRG(X,LEXLEN) ;   Major Diagnostic Category/DRG
 N LEXE,LEXH,LEXI,LEXN,LEXT Q:'$D(X(1))  S LEXN=$G(X(1)) Q:'$L(LEXN)  S LEXE=$G(X(0)) S:$L(LEXE,"/")'=3 LEXE=""
 S LEXT="  MDC/DRG:",LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT)))_LEXN D BL,TL(LEXT) S LEXN=$G(X(2))
 S LEXT="    "_LEXE,LEXT=LEXT_$J(" ",((79-+($G(LEXLEN)))-$L(LEXT))) D TL((LEXT_LEXN)) S LEXT=$J(" ",(79-+($G(LEXLEN)))),LEXI=2
 F  S LEXI=$O(X(LEXI)) Q:+LEXI'>0  S LEXN=$G(X(LEXI)) D:$L(LEXN) TL((LEXT_LEXN))
 Q
 ;
 ; Miscellaneous
BL ;   Blank Line
 D TL(" ") Q
TL(X) ;   Text Line
 I $D(LEXTEST) W !,$G(X) Q
 N LEXI,LEXTEST S LEXI=+($O(^TMP("LEXQIPO",$J," "),-1))+1 S ^TMP("LEXQIPO",$J,LEXI)=$G(X),^TMP("LEXQIPO",$J,0)=LEXI
 Q
