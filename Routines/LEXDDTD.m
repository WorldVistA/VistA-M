LEXDDTD ; ISL Display Defaults - Display           ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
DSO ; Display Sources
 ; Required LEXSHOW
 K LEX N LEXTCTR,LEXTI,LEXTIC,LEXTSTR,LEXT
 S:'$D(LEXSTLN) LEXSTLN=56
 D:'$L($G(LEXSHOW)) NONE D:$L($G(LEXSHOW)) SHOW
 Q
SHOW ; Show Classification Codes (sources)
 S LEX=LEXSHOW,LEXTCTR=0,LEX("L")=LEX
 S LEX("L","H")="Display codes from"
 S LEX("L","T")="coding system",LEXTCTR=0
 F LEXTI=1:1:$L(LEX("L"),"/") D
 . N LEXTIC S LEXTIC=$P(LEX("L"),"/",LEXTI) Q:LEXTIC="UND"
 . S LEXTCTR=LEXTCTR+1,LEX("L",LEXTCTR)=$$CN^LEXDDTF(LEXTIC)
 S:LEXTCTR>1 LEX("L","T")=LEX("L","T")_"s"
 S LEX("L","T")=LEX("L","T")_"."
 S LEX("L",0)=LEXTCTR
 S LEXTCTR=0,LEXTSTR="",LEXT="L"
 D:$G(LEX("L",0)) LNK^LEXDDTF
 D EOC^LEXDDT2
 Q
NONE ; LEXSHOW is Null (nothing to show)
 S LEX=LEXSHOW,LEX("L")=LEX,LEXTCTR=0,LEXTSTR="",LEXT="L"
 S LEX("L","H")="Do not display Classification Codes",LEX("L",0)=0
 D LNK^LEXDDTF,EOC^LEXDDT2
 Q
