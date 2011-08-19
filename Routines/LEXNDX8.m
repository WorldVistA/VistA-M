LEXNDX8 ;ISL/KER - Set/kill indexes 757.02 ;01/03/2011
 ;;2.0;LEXICON UTILITY;**25,73**;Sep 23, 1996;Build 10
 ;                    
 ; Set and Kill Activation History
 ;   File 757.02, field 1
SAHC ;     Set new value when Code is Edited
 ;          ^DD(757.02,1,1,D0,1) = D SAHC^LEXNDX8
 N LEXCOD,LEXCODX,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 S LEXCODX=$G(X) Q:'$L(LEXCODX)  S LEXIEN=+($G(DA)) Q:+LEXIEN'>0
 S LEXSYS=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",3)) Q:LEXSYS'>0
 S LEXPRF=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",5))
 S LEXSYS=$E($G(^LEX(757.03,+LEXSYS,0)),1,3) Q:$L(LEXSYS)'=3
 I $D(^LEX(757.02,+LEXIEN,4,"B")) S LEXHIS=0 D  Q
 . F  S LEXHIS=$O(^LEX(757.02,+LEXIEN,4,LEXHIS)) Q:+LEXHIS=0  D
 . . N DA,X S DA=+LEXHIS,DA(1)=+LEXIEN D HDC
 . . S LEXCOD=LEXCODX Q:'$L($G(LEXCOD))  Q:'$L($G(LEXEFF))
 . . Q:'$L($G(LEXSTA))  D SHIS
 Q
KAHC ;   Kill old value when Code is Edited
 ;   ^DD(757.02,1,1,D0,2) = D KAHC^LEXNDX8
 N LEXCOD,LEXCODX,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 S LEXCODX=$G(X) Q:'$L(LEXCODX)  S LEXIEN=+($G(DA)) Q:+LEXIEN'>0
 S LEXSYS=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",3)) Q:LEXSYS'>0
 S LEXSYS=$E($G(^LEX(757.03,+LEXSYS,0)),1,3) Q:$L(LEXSYS)'=3
 S LEXPRF=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",5))
 I $D(^LEX(757.02,+LEXIEN,4,"B")) S LEXHIS=0 D  Q
 . F  S LEXHIS=$O(^LEX(757.02,+LEXIEN,4,LEXHIS)) Q:+LEXHIS=0  D
 . . N DA,X S DA=+LEXHIS,DA(1)=+LEXIEN D HDC
 . . S LEXCOD=LEXCODX Q:'$L($G(LEXCOD))  Q:'$L($G(LEXEFF))
 . . Q:'$L($G(LEXSTA))  D KHIS
 Q
 ;                    
 ;   File 757.28, field .01
SAHD ;   Set new value when Effective Date is Edited
 ;   ^DD(757.28,.01,1,D0,1) = D SAHD^LEXNDX8
 N LEXCOD,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 D HDC Q:'$L($G(LEXCOD))
 Q:'$L($G(LEXSTA))  S LEXEFF=+($G(X)) Q:+LEXEFF=0  D SHIS
 Q
KAHD ;   Kill old value when Effective Date is Edited
 ;   ^DD(757.28,.01,1,D0,2) = D KAHD^LEXIDX8
 N LEXCOD,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 D HDC Q:'$L($G(LEXCOD))
 Q:'$L($G(LEXSTA))  S LEXEFF=+($G(X)) Q:+LEXEFF=0  D KHIS
 Q
 ;                    
 ;   File 757.28 field 1
SAHS ;   Set new value when Status is Edited
 ;   ^DD(757.28,1,1,D0,1) = D SAHS^LEXNDX8
 N LEXCOD,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 D HDC Q:'$L($G(LEXCOD))  Q:+LEXEFF=0
 S LEXSTA=$G(X) Q:'$L(LEXSTA)  D SHIS
 Q
KAHS ;   Kill old value when Status is Edited
 ;   ^DD(757.28,1,1,D0,2) = D KAHS^LEXIDX8
 N LEXCOD,LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXEFF,LEXHIS,LEXIEN,LEXNOD,LEXSTA,LEXSYS,LEXPRF
 D HDC Q:'$L($G(LEXCOD))  Q:+LEXEFF=0
 S LEXSTA=$G(X)  Q:'$L(LEXSTA)  D KHIS
 Q
 ;                    
HDC ;  Set Common Variables (Code, Status and Effective Date)
 S (LEXDDT,LEXDSYS,LEXDF,LEXDSTA,LEXCOD,LEXSTA,LEXEFF)=""  Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 Q:'$D(^LEX(757.02,+($G(DA(1))),4,+($G(DA)),0))
 S LEXCOD=$P($G(^LEX(757.02,+($G(DA(1))),0)),"^",2)
 S LEXPRF=+($P($G(^LEX(757.02,+($G(DA(1))),0)),"^",5))
 S LEXNOD=$G(^LEX(757.02,+($G(DA(1))),4,+($G(DA)),0))
 S LEXSTA=$P(LEXNOD,"^",2),LEXEFF=$P(LEXNOD,"^",1)
 S LEXSTA=$S(LEXSTA="A":1,LEXSTA="I":0,1:LEXSTA)
 S LEXDSYS=+($P($G(^LEX(757.02,+($G(DA(1))),0)),"^",3))
 S LEXDSYS=$E($G(^LEX(757.03,+LEXDSYS,0)),1,3)
 S LEXDSTA=$$DF(+($G(DA(1))),$G(LEXCOD))
 S LEXDSTA=$S(+LEXDSTA'>0:1,1:0)
 S LEXDDT=$$DDTBR(LEXDSYS,LEXDSTA)
 Q
DHDC ;  Set Default Common Variables (Code, Status and Effective Date)
 ;    0 node
 S LEXCOD=$G(LEXCODX),LEXSYS=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",3))
 S (LEXSYS,LEXDSYS)=$E($G(^LEX(757.03,+LEXSYS,0)),1,3)
 S LEXPRF=+($P($G(^LEX(757.02,+LEXIEN,0)),"^",5))
 S LEXSTA=$$DF(+($G(DA(1))),$G(LEXCOD))
 S (LEXSTA,LEXDSTA)=$S(+LEXSTA'>0:1,1:0)
 S LEXEFF=$$DDTBR(LEXSYS,LEXSTA)
 S LEXDDT=$$DDTBR(LEXDSYS,LEXDSTA)
 Q
SHIS ;  Set Index 
 ;  ^LEX(757.02,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(LEXCOD))  Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF)) 
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 Q:'$D(^LEX(757.02,+($G(DA(1))),4,+($G(DA)),0))
 K:$L($G(LEXDDT)) ^LEX(757.02,"ACT",(LEXCOD_" "),LEXSTA,LEXDDT,DA(1),0)
 S ^LEX(757.02,"ACT",(LEXCOD_" "),LEXSTA,LEXEFF,DA(1),DA)=""
 I +($G(LEXPRF))>0 D
 . K:$L($G(LEXDDT)) ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXDDT,DA(1),0)
 . S ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXEFF,DA(1),DA)=""
 Q
SDHIS ;  Set Default Index 
 ;  ^LEX(757.02,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(LEXCOD))  Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+($G(LEXIEN))'>0  Q:'$D(^LEX(757.02,+($G(LEXIEN)),0))
 S ^LEX(757.02,"ACT",(LEXCOD_" "),LEXSTA,LEXEFF,+LEXIEN,0)=""
 I +($G(LEXPRF))>0 D
 . S ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXEFF,+LEXIEN,0)=""
 Q
KHIS ;  Kill Index
 ;  ^LEX(757.02,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(LEXCOD))  Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+($G(DA(1)))'>0  Q:+($G(DA))'>0
 Q:'$D(^LEX(757.02,+($G(DA(1))),4,+($G(DA)),0))
 K ^LEX(757.02,"ACT",(LEXCOD_" "),LEXSTA,LEXEFF,DA(1),DA)
 I +($G(LEXPRF))>0 D
 . K:$L($G(LEXDDT)) ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXDDT,DA(1),0)
 . K ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXEFF,DA(1),DA)
 Q
KDHIS ;  Kill Default Index
 ;  ^LEX(757.02,"ACT",<code>,<status>,<date>,<ien>,<history>)
 Q:'$L($G(LEXCOD))  Q:'$L($G(LEXSTA))  Q:'$L($G(LEXEFF))
 Q:+($G(LEXIEN))'>0  Q:'$D(^LEX(757.02,+($G(LEXIEN)),0))
 K ^LEX(757.02,"ACT",(LEXCOD_" "),LEXSTA,LEXEFF,+LEXIEN,0)
 I +($G(LEXPRF))>0 D
 . K ^LEX(757.02,"ACT",(LEXCOD_" "),(+LEXSTA+2),LEXDDT,+LEXIEN,0)
 Q
DF(X,CODE) ; Default Status
 N LEXI,LEXDF,LEXNF,LEXL,LEXEFF,LEXC,LEXO,LEXND,LEXSRC
 S LEXI=+($G(X)) Q:+LEXI'>0 ""
 S LEXND=$G(^LEX(757.02,+LEXI,0)),LEXSRC=$P(LEXND,"^",3)
 S LEXEFF=$O(^LEX(757.02,+LEXI,4,"B"," "),-1)
 S LEXL=$O(^LEX(757.02,+LEXI,4,"B",+LEXEFF,0))
 S LEXL=$P($G(^LEX(757.02,+LEXI,4,+LEXL,0)),"^",2)
 S LEXC=$G(CODE) S:'$L(LEXC) LEXC=$P($G(^LEX(757.02,LEXI,0)),U,2)
 S LEXDF='+$$STATCHK^LEXSRC2(LEXC,,,LEXSRC)
 S LEXO=$P($G(^LEX(757.02,LEXI,0)),U,2)
 S LEXNF=$S(+LEXL=1:"",1:LEXDF)
 S X=LEXNF
 Q X
DDTBR(SYS,STA) ; Default Date Business Rules
 ; Input:
 ;   SYS - System
 ;   STA - Status
 ; Output:
 ;   If Status = 1 (Active)
 ;      If SYS = ICD/ICP  use October 1, 1978      2781001
 ;      If SYS = CPT/CPC  use January 1, 1989      2890101
 ;      If SYS is not listed above, use            2960923
 ;   If Status = 0 (Inactive)
 ;      If SYS = ICD/ICP  use October 2, 1978      2791001
 ;      If SYS = CPT/CPC  use January 2, 1989      2900101
 ;      If SYS is not listed above, use            2960924
 N LEXSTA,LEXSYS,LEXDT
 S LEXSTA=+($G(STA)),LEXSYS=$G(SYS),LEXDT=0
 S:$L(LEXSYS)=3&("^ICD^ICP^CPT^CPC^"'[LEXSYS) LEXSTA=1
 ;   No System, use Lexicon Release Date
 I $L(LEXSYS)'=3 D  Q LEXDT
 . S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 ;   System is ICD, use 2781001/2791001
 I LEXSYS="ICD"!(LEXSYS="ICP") D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2781001 S:LEXSTA'>0 LEXDT=2791001
 ;   System is CPT, use 2890101/2900101
 I LEXSYS="CPT"!(LEXSYS="CPC") D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2890101 S:LEXSTA'>0 LEXDT=2900101
 ;   System is neither ICD or CPT, use 2960923/2970923
 I "^ICD^ICP^CPT^CPC^"'[LEXSYS D  Q LEXDT
 . S:LEXSTA>0 LEXDT=2960923 S:LEXSTA'>0 LEXDT=2970923
 ;   None of the Above
 S:+LEXSTA>0 LEXDT=2960923 S:+LEXSTA'>0 LEXDT=2970923
 Q LEXDT
