LEXQC5 ;ISL/KER - Query - Changes - Duplicate Text ;05/23/2017
 ;;2.0;LEXICON UTILITY;**103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^ICD0(              ICR   4486
 ;    ^ICD9(              ICR   4485
 ;    ^ICPT(              ICR   4489
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10103
 ;               
 Q
DUPL(LEX,X,Y) ; Long Description is a Duplicate
 ;   
 ;   Input
 ;      LEX  File Number
 ;             80      ICD Diagnosis
 ;             80.1    ICD Procedures
 ;             81      CPT Procedures
 ;             81.3    Modifiers
 ;      X    Code IEN
 ;      Y    Long Description IEN
 ;           
 ;   Output
 ; 
 ;   $$DUPL  Boolean value
 ;       
 ;           1  Long Descriptions is a Duplicate
 ;           0  Long Descriptions is not a Duplicate
 ;           
 N LEXFI,LEXIEN,LEXI S LEXFI=$G(LEX) Q:"^80^80.1^81^81.3^"'[("^"_LEXFI_"^") 0
 S LEXIEN=+($G(X)) Q:+LEXIEN'>0 0  S LEXI=+($G(Y)) Q:+LEXI'>0 0
 Q:LEXFI=81 +($$CPTL(LEXIEN,LEXI)) Q:LEXFI=81.3 +($$MODL(LEXIEN,LEXI)) Q:LEXFI=80!(LEXFI=80.1) +($$ICDL(LEXFI,LEXIEN,LEXI))
 Q 0
DUPS(LEX,X,Y) ; Short Description is a Duplicate
 ;   
 ;   Input
 ;      LEX  File Number
 ;             80    ICD Diagnosis
 ;             80.1  ICD Procedures
 ;             81    CPT Procedures
 ;             81.3    Modifiers
 ;      X    Code IEN
 ;      Y    Short Description IEN
 ;           
 ;   Output
 ; 
 ;   $$DUPL  Boolean value
 ;       
 ;           1  Short Descriptions is a Duplicate
 ;           0  Short Descriptions is not a Duplicate
 ;           
 N LEXFI,LEXIEN,LEXI S LEXFI=$G(LEX) Q:"^80^80.1^81^"'[("^"_LEXFI_"^") 0
 S LEXIEN=+($G(X)) Q:+LEXIEN'>0 0  S LEXI=+($G(Y)) Q:+LEXI'>0 0
 Q:LEXFI=81 +($$CPTS(LEXIEN,LEXI)) Q:LEXFI=81.3 +($$MODS(LEXIEN,LEXI)) Q:LEXFI=80!(LEXFI=80.1) +($$ICDS(LEXFI,LEXIEN,LEXI))
 Q 0
 ;
 ; Coding System Text
CPTL(X,Y) ;   CPT Long Description is a Duplicate
 N LEXA1,LEXA2,LEXD1,LEXD2,LEXI,LEXI1,LEXI2,LEXIEN,LEXL,LEXT
 S LEXIEN=+($G(X)) Q:'$D(^ICPT(+LEXIEN,0)) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:'$D(^ICPT(+LEXIEN,62,+LEXI1,1)) 0
 . S LEXD1=$O(^ICPT(+LEXIEN,62,"B"," "),-1),LEXI1=$O(^ICPT(+LEXIEN,62,"B",+LEXD1," "),-1)
 S LEXD1=$G(^ICPT(+LEXIEN,62,+LEXI1,0)) Q:LEXD1'?7N 0
 S LEXD2=$O(^ICPT(+LEXIEN,62,"B",+LEXD1),-1) Q:LEXD2'?7N 0  Q:LEXD1'>LEXD2
 S LEXI2=$O(^ICPT(+LEXIEN,62,"B",+LEXD2," "),-1) Q:+LEXD2'>0  Q:'$D(^ICPT(+LEXIEN,62,+LEXI2,1)) 0
 S LEXL=0 F  S LEXL=$O(^ICPT(+LEXIEN,62,+LEXI1,1,LEXL)) Q:+LEXL'>0  D
 . N LEXT,LEXI S LEXT=$G(^ICPT(+LEXIEN,62,+LEXI1,1,+LEXL,0)) Q:'$L($G(LEXT))
 . S LEXI=$O(LEXA1(" "),-1)+1,LEXA1(+LEXI)=LEXT
 S LEXL=0 F  S LEXL=$O(^ICPT(+LEXIEN,62,+LEXI2,1,LEXL)) Q:+LEXL'>0  D
 . N LEXT,LEXI S LEXT=$G(^ICPT(+LEXIEN,62,+LEXI2,1,+LEXL,0)) Q:'$L($G(LEXT))
 . S LEXI=$O(LEXA2(" "),-1)+1,LEXA2(+LEXI)=LEXT
 S X=+($$SAME(.LEXA1,.LEXA2))
 Q X
CPTS(X,Y) ;   CPT Short Description is a Duplicate
 N LEXA1,LEXA2,LEXD1,LEXD2,LEXI1,LEXI2,LEXIEN,LEXL
 S LEXIEN=+($G(X)) Q:'$D(^ICPT(+LEXIEN,0)) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:'$D(^ICPT(+LEXIEN,61,+LEXI1,0)) 0
 . S LEXD1=+($O(^ICPT(+LEXIEN,61,"B"," "),-1)),LEXI1=$O(^ICPT(+LEXIEN,61,"B",+LEXD1," "),-1)
 S LEXD1=$P($G(^ICPT(+LEXIEN,61,+LEXI1,0)),"^",1) Q:LEXD1'?7N 0
 S LEXD2=$O(^ICPT(+LEXIEN,61,"B",+LEXD1),-1) Q:LEXD2'?7N 0  Q:LEXD1'>LEXD2 0
 S LEXI2=$O(^ICPT(+LEXIEN,61,"B",+LEXD2," "),-1) Q:LEXI2'>0  Q:'$D(^ICPT(+LEXIEN,61,+LEXI2,0)) 0
 S LEXA1=$$UP^XLFSTR($$TM($$DS($P($G(^ICPT(+LEXIEN,61,+LEXI1,0)),"^",2))))
 S LEXA2=$$UP^XLFSTR($$TM($$DS($P($G(^ICPT(+LEXIEN,61,+LEXI2,0)),"^",2))))
 Q:LEXA1'=LEXA2 0
 Q 1
MODL(X,Y) ;   Modifier Long Description is a Duplicate
 N LEXA1,LEXA2,LEXD1,LEXD2,LEXI,LEXI1,LEXI2,LEXIEN,LEXL,LEXT
 S LEXIEN=+($G(X)) Q:'$D(^DIC(81.3,+LEXIEN,0)) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:'$D(^DIC(81.3,+LEXIEN,62,+LEXI1,1)) 0
 . S LEXD1=$O(^DIC(81.3,+LEXIEN,62,"B"," "),-1),LEXI1=$O(^DIC(81.3,+LEXIEN,62,"B",+LEXD1," "),-1)
 S LEXD1=$G(^DIC(81.3,+LEXIEN,62,+LEXI1,0)) Q:LEXD1'?7N 0
 S LEXD2=$O(^DIC(81.3,+LEXIEN,62,"B",+LEXD1),-1) Q:LEXD2'?7N 0  Q:LEXD1'>LEXD2
 S LEXI2=$O(^DIC(81.3,+LEXIEN,62,"B",+LEXD2," "),-1) Q:+LEXD2'>0  Q:'$D(^DIC(81.3,+LEXIEN,62,+LEXI2,1)) 0
 S LEXL=0 F  S LEXL=$O(^DIC(81.3,+LEXIEN,62,+LEXI1,1,LEXL)) Q:+LEXL'>0  D
 . N LEXT,LEXI S LEXT=$G(^DIC(81.3,+LEXIEN,62,+LEXI1,1,+LEXL,0)) Q:'$L($G(LEXT))
 . S LEXI=$O(LEXA1(" "),-1)+1,LEXA1(+LEXI)=LEXT
 S LEXL=0 F  S LEXL=$O(^DIC(81.3,+LEXIEN,62,+LEXI2,1,LEXL)) Q:+LEXL'>0  D
 . N LEXT,LEXI S LEXT=$G(^DIC(81.3,+LEXIEN,62,+LEXI2,1,+LEXL,0)) Q:'$L($G(LEXT))
 . S LEXI=$O(LEXA2(" "),-1)+1,LEXA2(+LEXI)=LEXT
 S X=+($$SAME(.LEXA1,.LEXA2))
 Q X
MODS(X,Y) ;   Modifier Short Description is a Duplicate
 N LEXA1,LEXA2,LEXD1,LEXD2,LEXI1,LEXI2,LEXIEN,LEXL
 S LEXIEN=+($G(X)) Q:'$D(^DIC(81.3,+LEXIEN,0)) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:'$D(^DIC(81.3,+LEXIEN,61,+LEXI1,0)) 0
 . S LEXD1=+($O(^DIC(81.3,+LEXIEN,61,"B"," "),-1)),LEXI1=$O(^DIC(81.3,+LEXIEN,61,"B",+LEXD1," "),-1)
 S LEXD1=$P($G(^DIC(81.3,+LEXIEN,61,+LEXI1,0)),"^",1) Q:LEXD1'?7N 0
 S LEXD2=$O(^DIC(81.3,+LEXIEN,61,"B",+LEXD1),-1) Q:LEXD2'?7N 0  Q:LEXD1'>LEXD2 0
 S LEXI2=$O(^DIC(81.3,+LEXIEN,61,"B",+LEXD2," "),-1) Q:LEXI2'>0  Q:'$D(^DIC(81.3,+LEXIEN,61,+LEXI2,0)) 0
 S LEXA1=$$UP^XLFSTR($$TM($$DS($P($G(^DIC(81.3,+LEXIEN,61,+LEXI1,0)),"^",2))))
 S LEXA2=$$UP^XLFSTR($$TM($$DS($P($G(^DIC(81.3,+LEXIEN,61,+LEXI2,0)),"^",2))))
 Q:LEXA1'=LEXA2 0
 Q 1
ICDL(LEX,X,Y) ;   ICD Long Description is a Duplicate
 N LEXIEN,LEXI1,LEXI2,LEXD1,LEXD2,LEXA1,LEXA2,LEXL,LEXRT,LEXFI
 S LEXFI=+($G(LEX)) Q:"^80^80.1^"'[("^"_LEXFI_"^") 0
 S LEXRT=$S(LEXFI=80:"^ICD9(",LEXFI=80.1:"^ICD0(",1:"") Q:'$L(LEXRT)
 S LEXIEN=+($G(X)) Q:'$D(@(LEXRT_+LEXIEN_",0)")) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:+($G(LEXI1))'>0 0
 . S LEXD1=$O(@(LEXRT_+LEXIEN_",68,""B"","" "")"),-1) Q:LEXD1'?7N
 . S LEXI1=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD1_","" "")"),-1)
 Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",0)")) 0  Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",1)")) 0
 S LEXD1=$P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",0)")),"^",1) Q:LEXD1'?7N
 S LEXD2=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD1_")"),-1) Q:LEXD2'?7N 0
 S LEXI2=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD2_","" "")"),-1) Q:LEXI2'>0 0
 Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",0)")) 0  Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",1)")) 0
 S LEXA1=$$UP^XLFSTR($$TM($$DS($P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",1)")),"^",1))))
 S LEXA2=$$UP^XLFSTR($$TM($$DS($P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",1)")),"^",1))))
 Q:LEXA1=LEXA2 1
 Q 0
ICDS(LEX,X,Y) ;   ICD Short Description is a Duplicate
 N LEXIEN,LEXI1,LEXI2,LEXD1,LEXD2,LEXA1,LEXA2,LEXL,LEXRT,LEXFI
 S LEXFI=+($G(LEX)) Q:"^80^80.1^"'[("^"_LEXFI_"^") 0
 S LEXRT=$S(LEXFI=80:"^ICD9(",LEXFI=80.1:"^ICD0(",1:"") Q:'$L(LEXRT)
 S LEXIEN=+($G(X)) Q:'$D(@(LEXRT_+LEXIEN_",0)")) 0
 S LEXI1=+($G(Y)) I +($G(LEXI1))'>0 D  Q:+($G(LEXI1))'>0 0
 . S LEXD1=$O(@(LEXRT_+LEXIEN_",68,""B"","" "")"),-1) Q:LEXD1'?7N
 . S LEXI1=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD1_","" "")"),-1)
 Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",0)")) 0  Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",1)")) 0
 S LEXD1=$P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",0)")),"^",1) Q:LEXD1'?7N
 S LEXD2=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD1_")"),-1) Q:LEXD2'?7N 0
 S LEXI2=$O(@(LEXRT_+LEXIEN_",68,""B"","_+LEXD2_","" "")"),-1) Q:LEXI2'>0 0
 Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",0)")) 0  Q:'$D(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",1)")) 0
 S LEXA1=$$UP^XLFSTR($$TM($$DS($P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI1_",1)")),"^",1))))
 S LEXA2=$$UP^XLFSTR($$TM($$DS($P($G(@(LEXRT_+LEXIEN_",68,"_+LEXI2_",1)")),"^",1))))
 Q:LEXA1=LEXA2 1
 Q 0
 ;
 ; Miscellaneous
SAME(X1,X2) ;   Are Arrays X1 and X2 the same
 Q:$O(X1(" "),-1)'>0 "-1^Invalid Array"  Q:$O(X2(" "),-1)'>0 "-1^Invalid Array"
 D PR^LEXU(.X1,80),PR^LEXU(.X2,80) N LEXSAME,LEXTIEN
 S LEXSAME=1,LEXTIEN=0 F  S LEXTIEN=$O(X1(LEXTIEN)) Q:+LEXTIEN'>0  S:$G(X1(+LEXTIEN))'=$G(X2(+LEXTIEN)) LEXSAME=0
 I LEXSAME=1 S LEXTIEN=0 F  S LEXTIEN=$O(X2(LEXTIEN)) Q:+LEXTIEN'>0  S:$G(X2(+LEXTIEN))'=$G(X1(+LEXTIEN)) LEXSAME=0
 Q LEXSAME
DS(X) ;   Remove Double Space
 S X=$G(X) Q:X="" X
 F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,4000)
 Q X
TM(X,Y) ;   Trim Character Y - Default " " Space
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
