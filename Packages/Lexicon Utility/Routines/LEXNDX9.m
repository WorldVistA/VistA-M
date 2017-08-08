LEXNDX9 ;ISL/KER - Set/kill indexes 757.07/757.33 ;05/23/2017
 ;;2.0;LEXICON UTILITY;**73,103**;Sep 23, 1996;Build 2
 ;               
 ; Global Variables
 ;    ^LEX(757.07         SACC 1.3
 ;    ^LEX(757.33         SACC 1.3
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10103
 ;               
 ; File 757.33, field 1
SAHC ;   Set new value when Code is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXMAP S LEXIEN=+$G(DA) Q:+LEXIEN'>0
 I $D(^LEX(757.33,+LEXIEN,2,"B")) S LEXHIS=0 D  Q
 . F  S LEXHIS=$O(^LEX(757.33,+LEXIEN,2,LEXHIS)) Q:+LEXHIS=0  D
 . . N DA,X S DA=+LEXHIS,DA(1)=+LEXIEN D HDC Q:'$L($G(LEXEFF))  Q:'$L($G(LEXSTA))  D SHIS
 Q
KAHC ;   Kill old value when Code is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXMAP S LEXIEN=+$G(DA) Q:+LEXIEN'>0
 I $D(^LEX(757.33,+LEXIEN,2,"B")) S LEXHIS=0 D  Q
 . F  S LEXHIS=$O(^LEX(757.33,+LEXIEN,2,LEXHIS)) Q:+LEXHIS=0  D
 . . N DA,X S DA=+LEXHIS,DA(1)=+LEXIEN D HDC Q:'$L($G(LEXEFF))  Q:'$L($G(LEXSTA))  D KHIS
 Q
 ; File 757.333, field .01
SAHD ;   Set new value when Effective Date is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP,LEXNOD,LEXSTA
 D HDC Q:'$L($G(LEXSTA))  Q:+LEXEFF=0  D SHIS
 Q
KAHD ;   Kill old value when Effective Date is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP,LEXNOD,LEXSTA
 D HDC Q:'$L($G(LEXSTA))  S LEXEFF=+$G(X) Q:+LEXEFF=0  D KHIS
 Q
 ; File 757.333 field 1
SAHS ;   Set new value when Status is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP,LEXNOD,LEXSTA,LEXSYS
 D HDC Q:+LEXEFF=0  S LEXSTA=$G(X) Q:'$L(LEXSTA)  D SHIS
 Q
KAHS ;   Kill old value when Status is Edited
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP,LEXNOD,LEXSTA
 D HDC Q:+LEXEFF=0  S LEXSTA=$G(X) Q:'$L(LEXSTA)  D KHIS
 Q
 ; File 757.33 Set and Kills
SHIS ;   Set "G" Index
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))  Q:+$G(DA(1))'>0  Q:+$G(DA)'>0  Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 K:$L($G(LEXDDT)) ^LEX(757.33,"G",LEXMAP,LEXDDT,LEXSTA,DA(1)) S ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,DA(1))=""
 Q
SDHIS ;   Set "G" Index Default
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))  Q:+$G(LEXIEN)'>0  Q:'$D(^LEX(757.33,+$G(LEXIEN),0))
 S ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,+LEXIEN)=""
 Q
KHIS ;   Kill "G" Index
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))  Q:+$G(DA(1))'>0  Q:+$G(DA)'>0  Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 K ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,DA(1),DA)
 Q
KDHIS ;   Kill "G" Index Default
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))  Q:+$G(LEXIEN)'>0  Q:'$D(^LEX(757.33,+$G(LEXIEN),0))
 K ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,+LEXIEN,0)
 Q
 ; File 757.07
SD(X,IENS) ;   Set "D" KWIC Index
 N ARY,I Q:$G(IENS)'?1N.N  Q:$G(IENS(1))'?1N.N  Q:'$L($G(X))  D PR($G(X),.ARY) S I=0 F  S I=$O(ARY(I)) Q:+I'>0  D
 . N TKN S TKN=$$UP^XLFSTR($$TM($G(ARY(I)))) Q:'$L(TKN)  S ^LEX(757.07,"D",TKN,+($G(IENS(1))),+($G(IENS)))=""
 K ARY
 Q
KD(X,IENS) ;   Kill "D" KWIC Index
 N ARY,I Q:$G(IENS)'?1N.N  Q:$G(IENS(1))'?1N.N  Q:'$L($G(X))  D PR($G(X),.ARY) S I=0 F  S I=$O(ARY(I)) Q:+I'>0  D
 . N TKN S TKN=$$UP^XLFSTR($$TM($G(ARY(I)))) Q:'$L(TKN)  S ^LEX(757.07,"D",TKN,+($G(IENS(1))),+($G(IENS)))=""
 K ARY
 Q
SAED(X,Y,IENS) ;   Set "AED" Phrase Index
 N EXM,STR,PIE,I Q:$G(IENS)'?1N.N  Q:$G(IENS(1))'?1N.N  Q:'$L($G(X))  Q:'$L($G(Y))
 S EXM=$G(X),STR=$G(Y) F I=1:1 S PIE=$$TM($P(STR,"/",I)) Q:'$L(PIE)  D
 . S ^LEX(757.07,"AED",$$UP^XLFSTR(EXM),PIE,+($G(IENS(1))),+($G(IENS)))=""
 Q
KAED(X,Y,IENS) ;   Kill "AED" Phrase Index
 N EXM,STR,PIE,I Q:$G(IENS)'?1N.N  Q:$G(IENS(1))'?1N.N  Q:'$L($G(X))  Q:'$L($G(Y))
 S EXM=$G(X),STR=$G(Y) F I=1:1 S PIE=$$TM($P(STR,"/",I)) Q:'$L(PIE)  D
 . K ^LEX(757.07,"AED",$$UP^XLFSTR(EXM),PIE,+($G(IENS(1))),+($G(IENS)))
 Q
 ;
 ; Miscellaneous
HDC ;   Set Common Variables (Status and Effective Date)
 S (LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXSTA,LEXMAP)="" Q:+$G(DA(1))'>0  Q:+$G(DA)'>0  Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 S LEXMAP=$P(^LEX(757.33,DA(1),0),U),LEXNOD=$G(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0)),LEXSTA=$P(LEXNOD,U,2),LEXEFF=$P(LEXNOD,U)
 S LEXSTA=$S(LEXSTA="A":1,LEXSTA="I":0,1:LEXSTA),LEXDDT=$$DDTBR(LEXDSYS,LEXSTA)
 Q
DF(X,CODE) ;   Default Status
 N LEXI,LEXNF,LEXL,LEXEFF,LEXC S LEXI=+$G(X) Q:+LEXI'>0 ""  S LEXEFF=$O(^LEX(757.33,+LEXI,2,"B"," "),-1)
 S LEXL=$O(^LEX(757.33,+LEXI,2,"B",+LEXEFF,0)),LEXL=$P($G(^LEX(757.33,+LEXI,2,+LEXL,0)),U,2) S X=LEXL
 Q X
DDTBR(SYS,STA) ;   Default Date Business Rules
 ;     Input:
 ;       SYS - System
 ;       STA - Status
 ;     Output:
 ;       If Status = 1 (Give)
 ;          If SYS = ICD/ICP  use October 1, 1978      2781001
 ;          If SYS = CPT/CPC  use January 1, 1989      2890101
 ;          If SYS is not listed above, use            2960923
 ;       If Status = 0 (InGive)
 ;          If SYS = ICD/ICP  use October 2, 1978      2791001
 ;          If SYS = CPT/CPC  use January 2, 1989      2900101
 ;          If SYS is not listed above, use            2960924
 N LEXSTA,LEXSYS,LEXDT
 S LEXSTA=+$G(STA),LEXSYS=$G(SYS),LEXDT=0
 S:$L(LEXSYS)=3&("^ICD^ICP^CPT^CPC^"'[LEXSYS) LEXSTA=1
 I $L(LEXSYS)'=3 D  Q LEXDT
 . S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 I LEXSYS="ICD"!(LEXSYS="ICP") D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2781001 S:LEXSTA'>0 LEXDT=2791001
 I LEXSYS="CPT"!(LEXSYS="CPC") D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2890101 S:LEXSTA'>0 LEXDT=2900101
 I "^ICD^ICP^CPT^CPC^"'[LEXSYS D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2960923 S:LEXSTA'>0 LEXDT=2970923
 S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 Q LEXDT
PR(X,ARY) ;   Parse Expression into Tokens
 N CTL,EXP,CUR,PRE,TC,CT,OUT,P1,ST,P2,PC S EXP=$G(X) K ARY
 S CTL="^ ^!^@^#^$^%^^^&^*^(^)^_^+^-^=^{^}^|^[^]^\^:^""^;^'^<^>^?^,^.^/^"
 S (CUR,PRE)="",TC=1,CT=0,(OUT,P1,ST,P2)="" F PC=1:1:$L(EXP) D
 . N CHR S (CUR,CHR)=$E(EXP,PC)
 . I CTL'[("^"_CHR_"^") D  Q
 . . S ARY(+TC)=$G(ARY(+TC))_CHR S PRE=CUR
 . I CTL[("^"_CHR_"^") D  Q
 . . N CC,NXT S CC=$O(ARY(+TC,"B"," "),-1)+1
 . . S ARY(+TC,"B",CC)=CHR
 . . S NXT=$E(EXP,(PC+1))
 . . I $L(NXT),CTL'[("^"_NXT_"^") S TC=TC+1
 . . S PRE=CUR
 S TC=0 F  S TC=$O(ARY(TC)) Q:+TC'>0  D
 . N TKN S TKN=$G(ARY(TC)) S:$L(TKN) ARY(TC,"O")=TKN
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
