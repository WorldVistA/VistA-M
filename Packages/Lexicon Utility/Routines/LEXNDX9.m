LEXNDX9 ;ISL/KER - Set/kill indexes 757.33 ;01/03/2011
 ;;2.0;LEXICON UTILITY;**73**;Sep 23, 1996;Build 10
 ;
 ; Set and Kill Activation History
 ;   File 757.33, field 1
SAHC ;     Set new value when Code is Edited
 ;          ^DD(757.33,1,1,D0,1) = D SAHC^LEXNDX9
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF
 N LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXMAP
 S LEXIEN=+$G(DA) Q:+LEXIEN'>0
 I $D(^LEX(757.33,+LEXIEN,2,"B")) S LEXHIS=0 D  Q
 .F  S LEXHIS=$O(^LEX(757.33,+LEXIEN,2,LEXHIS)) Q:+LEXHIS=0  D
 ..N DA,X
 ..S DA=+LEXHIS,DA(1)=+LEXIEN
 ..D HDC
 ..Q:'$L($G(LEXEFF))
 ..Q:'$L($G(LEXSTA))
 ..D SHIS
 Q
KAHC ;   Kill old value when Code is Edited
 ;   ^DD(757.33,1,1,D0,2) = D KAHC^LEXNDX9
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF
 N LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXMAP
 S LEXIEN=+$G(DA) Q:+LEXIEN'>0
 I $D(^LEX(757.33,+LEXIEN,2,"B")) S LEXHIS=0 D  Q
 .F  S LEXHIS=$O(^LEX(757.33,+LEXIEN,2,LEXHIS)) Q:+LEXHIS=0  D
 ..N DA,X S DA=+LEXHIS,DA(1)=+LEXIEN D HDC
 ..Q:'$L($G(LEXEFF))
 ..Q:'$L($G(LEXSTA))
 ..D KHIS
 Q
 ;
 ;   File 757.333, field .01
SAHD ;   Set new value when Effective Date is Edited
 ;   ^DD(757.333,.01,1,D0,1) = D SAHD^LEXNDX9
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP
 N LEXNOD,LEXSTA
 D HDC
 Q:'$L($G(LEXSTA))
 Q:+LEXEFF=0
 D SHIS
 Q
KAHD ;   Kill old value when Effective Date is Edited
 ;   ^DD(757.333,.01,1,D0,2) = D KAHD^LEXIDX8
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP
 N LEXNOD,LEXSTA
 D HDC
 Q:'$L($G(LEXSTA))
 S LEXEFF=+$G(X) Q:+LEXEFF=0
 D KHIS
 Q
 ;
 ;   File 757.333 field 1
SAHS ;   Set new value when Status is Edited
 ;   ^DD(757.333,1,1,D0,1) = D SAHS^LEXNDX9
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP
 N LEXNOD,LEXSTA,LEXSYS
 D HDC
 Q:+LEXEFF=0
 S LEXSTA=$G(X)
 Q:'$L(LEXSTA)
 D SHIS
 Q
KAHS ;   Kill old value when Status is Edited
 ;   ^DD(757.333,1,1,D0,2) = D KAHS^LEXIDX9
 N LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXMAP
 N LEXNOD,LEXSTA
 D HDC
 Q:+LEXEFF=0
 S LEXSTA=$G(X)
 Q:'$L(LEXSTA)
 D KHIS
 Q
 ;
HDC ;  Set Common Variables (Status and Effective Date)
 S (LEXDDT,LEXDSYS,LEXDSTA,LEXEFF,LEXSTA,LEXMAP)=""
 Q:+$G(DA(1))'>0
 Q:+$G(DA)'>0
 Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 S LEXMAP=$P(^LEX(757.33,DA(1),0),U)
 S LEXNOD=$G(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 S LEXSTA=$P(LEXNOD,U,2),LEXEFF=$P(LEXNOD,U)
 S LEXSTA=$S(LEXSTA="A":1,LEXSTA="I":0,1:LEXSTA)
 S LEXDDT=$$DDTBR(LEXDSYS,LEXSTA)
 Q
SHIS ;  Set Index
 ;  ^LEX(757.33,"G",<code>,<date>,<status>,<ien>)
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+$G(DA(1))'>0  Q:+$G(DA)'>0
 Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 K:$L($G(LEXDDT)) ^LEX(757.33,"G",LEXMAP,LEXDDT,LEXSTA,DA(1))
 S ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,DA(1))=""
 Q
SDHIS ;  Set Default Index
 ;  ^LEX(757.33,"G",<code>,<date>,<status>,<ien>)
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+$G(LEXIEN)'>0  Q:'$D(^LEX(757.33,+$G(LEXIEN),0))
 S ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,+LEXIEN)=""
 Q
KHIS ;  Kill Index
 ;  ^LEX(757.33,"G",<code>,<date>,<status>,<ien>)
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+$G(DA(1))'>0  Q:+$G(DA)'>0
 Q:'$D(^LEX(757.33,+$G(DA(1)),2,+$G(DA),0))
 K ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,DA(1),DA)
 Q
KDHIS ;  Kill Default Index
 ;  ^LEX(757.33,"G",<code>,<date>,<status>,<ien>)
 Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+$G(LEXIEN)'>0  Q:'$D(^LEX(757.33,+$G(LEXIEN),0))
 K ^LEX(757.33,"G",LEXMAP,LEXEFF,LEXSTA,+LEXIEN,0)
 Q
DF(X,CODE) ; Default Status
 N LEXI,LEXNF,LEXL,LEXEFF,LEXC
 S LEXI=+$G(X) Q:+LEXI'>0 ""
 S LEXEFF=$O(^LEX(757.33,+LEXI,2,"B"," "),-1)
 S LEXL=$O(^LEX(757.33,+LEXI,2,"B",+LEXEFF,0))
 S LEXL=$P($G(^LEX(757.33,+LEXI,2,+LEXL,0)),U,2)
 S X=LEXL
 Q X
DDTBR(SYS,STA) ; Default Date Business Rules
 ; Input:
 ;   SYS - System
 ;   STA - Status
 ; Output:
 ;   If Status = 1 (Give)
 ;      If SYS = ICD/ICP  use October 1, 1978      2781001
 ;      If SYS = CPT/CPC  use January 1, 1989      2890101
 ;      If SYS is not listed above, use            2960923
 ;   If Status = 0 (InGive)
 ;      If SYS = ICD/ICP  use October 2, 1978      2791001
 ;      If SYS = CPT/CPC  use January 2, 1989      2900101
 ;      If SYS is not listed above, use            2960924
 N LEXSTA,LEXSYS,LEXDT
 S LEXSTA=+$G(STA),LEXSYS=$G(SYS),LEXDT=0
 S:$L(LEXSYS)=3&("^ICD^ICP^CPT^CPC^"'[LEXSYS) LEXSTA=1
 ;   No System, use Lexicon Release Date
 I $L(LEXSYS)'=3 D  Q LEXDT
 .S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 ;   System is ICD, use 2781001/2791001
 I LEXSYS="ICD"!(LEXSYS="ICP") D  Q LEXDT
 .S:LEXSTA>0 LEXDT=2781001 S:LEXSTA'>0 LEXDT=2791001
 ;   System is CPT, use 2890101/2900101
 I LEXSYS="CPT"!(LEXSYS="CPC") D  Q LEXDT
 .S:LEXSTA>0 LEXDT=2890101 S:LEXSTA'>0 LEXDT=2900101
 ;   System is neither ICD or CPT, use 2960923/2970923
 I "^ICD^ICP^CPT^CPC^"'[LEXSYS D  Q LEXDT
 .S:LEXSTA>0 LEXDT=2960923 S:LEXSTA'>0 LEXDT=2970923
 ;   None of the Above
 S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 Q LEXDT
