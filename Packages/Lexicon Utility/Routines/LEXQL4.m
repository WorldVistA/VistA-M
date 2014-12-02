LEXQL4 ;ISL/KER - Query - Lookup Code (CPT/MOD) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^DIC(81.3)          ICR   4492
 ;    ^ICPT(              ICR   4489
 ;    ^ICPT("BA")         ICR   4489
 ;    ^TMP("LEXQL")       SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$CPTD^ICPTCOD      ICR   1995
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$MOD^ICPTMOD       ICR   1996
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXVDT              Version Date - default TODAY
 ;    LEXTT               Text String
 ;    LEXTO               $Order Text Variable
 ;    LEXCT               Code String
 ;    LEXCO               $Order Text Variable
 ;    LEXTD               TODAY's Date
 ;    LEXTKNS             Local Array of Tolkens
 ;    LEXTTK              Total # Tolkens
 ;               
 Q
CP ; $$CPT^ICPTCOD(CODE,DATE)
 ; 
 ;     1  IEN of code in ^ICPT         1-6
 ;     2  CPT Code (.01)               5
 ;     3  Versioned Short Name (#61)   1-28
 ;     6  Effective Date (#60)         10 (external)
 ;     7  Status (#60)                 6-8 (external)
 ;     8  Inactivation Date (#60)      10 (external)
 ;     9  Activation Date (#60)        10 (external)
 ;
 Q:'$L($G(LEXTT))  Q:'$L($G(LEXTO))  Q:'$L($G(LEXCT))  Q:'$L($G(LEXCO))
 S LEXCT=$$VI(LEXCT)
 S LEXCO=$E(LEXCT,1,($L(LEXCT)-1))_$C(($A($E(LEXCT,$L(LEXCT)))-1))_"~"
 N LEXNUM D PUR N LEXIX F LEXIX="BA","C" D
 . N LEXO,LEXOC Q:LEXIX="C"&(LEXTT?1N.NP)
 . S LEXO=$S(LEXIX="BA":($G(LEXCO)_" "),1:$G(LEXTO)) Q:'$L(LEXO)
 . S LEXOC=$S(LEXIX="BA":$G(LEXCT),1:$G(LEXTT)) Q:'$L(LEXOC)
 . F  S LEXO=$O(^ICPT(LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXOC))'=LEXOC  D
 . . N LEXIEN S LEXIEN=0  F  S LEXIEN=$O(^ICPT(LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . N LEXOK S LEXOK=1 S:$O(LEXTKNS(0))>0&($G(LEXIX)="C") LEXOK=0
 . . . I $G(LEXIX)="C"&($O(LEXTKNS(0))>0) D
 . . . . N LEXN,LEXT,LEXC S (LEXC,LEXN)=0 F  S LEXN=$O(LEXTKNS(LEXN)) Q:+LEXN'>0  D
 . . . . . S LEXT="" F  S LEXT=$O(LEXTKNS(LEXN,LEXT)) Q:'$L(LEXT)  D
 . . . . . . N LEXOT,LEXKT,LEXF S LEXF=0,LEXOT=$E(LEXT,1,($L(LEXT)-1))_$C(($A($E(LEXT,$L(LEXT)))-1))_"~"
 . . . . . . F  S LEXOT=$O(^ICPT(LEXIX,LEXOT)) Q:'$L(LEXOT)  Q:$E(LEXOT,1,$L(LEXT))'=LEXT  D
 . . . . . . . S:$D(^ICPT(LEXIX,LEXOT,LEXIEN)) LEXF=1
 . . . . . . S:LEXF LEXC=LEXC+1
 . . . . S:+LEXC>0&(+LEXC=+($G(LEXTTK))) LEXOK=1
 . . . I $G(LEXIX)="C"&($O(LEXNUM(0))>0) D
 . . . . N LEXD,LEXC,LEXF,LEXN,LEXO S LEXO=$$CPTD^ICPTCOD(+LEXIEN,"LEXD") S (LEXC,LEXF,LEXN)=0
 . . . . F  S LEXN=$O(LEXNUM(LEXN)) Q:+LEXN'>0  D
 . . . . . S LEXC=LEXC+1
 . . . . . N LEXI S LEXI=0 F  S LEXI=$O(LEXD(LEXI)) Q:+LEXI'>0  D
 . . . . . . N LEXT S LEXT=$G(LEXD(LEXI)) S:LEXT[LEXN LEXF=LEXF+1
 . . . . I LEXC>0&(LEXC'=LEXF) S LEXOK=0
 . . . Q:'LEXOK  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT
 . . . S LEXC=$P($G(^ICPT(+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$CPT^ICPTCOD(LEXC,LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,3)),LEXS=$P(LEXT,U,7)
 . . . Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S LEXE=$P(LEXT,U,6) I LEXE'?7N S:+LEXS'>0 LEXE=$P(LEXT,U,8) S:+LEXS>0 LEXE=$P(LEXT,U,9)
 . . . S LEXTS=$$STY^LEXQL2(LEXC)
 . . . S LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)
 . . . S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="Inactive" S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS
 . . . S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "))=LEXIEN_U_$$FT^LEXQL2(LEXC,LEXN,LEXSS)
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "),2)=LEXIEN_U_$$FC^LEXQL2(LEXC,LEXN,LEXSS)
 Q
CM ; $$MOD(CODE,FORMAT,DATE)
 ;
 ;     1  IEN of code in ^DIC(81.3,    1-3
 ;     2  Modifier (.01)               2
 ;     3  Versioned Name (61)          1-60
 ;     6  Effective Date (60)          10 (external)
 ;     7  Status (60)                  6-8 (external)
 ;     8  Inactivation Date (60)       10 (external)
 ;     9  Activation Date (60)         10 (external)
 ;            
 Q:'$L($G(LEXTT))  Q:'$L($G(LEXTO))  Q:'$L($G(LEXCT))  Q:'$L($G(LEXCO))
 N LEXIX F LEXIX="BA" D
 . N LEXO,LEXOC Q:LEXIX="C"&(LEXTT?1N.NP)
 . S LEXO=$S(LEXIX="BA":($G(LEXCO)_" "),1:$G(LEXTO)) Q:'$L(LEXO)
 . S LEXOC=$S(LEXIX="BA":$G(LEXCT),1:$G(LEXTT)) Q:'$L(LEXOC)
 . F  S LEXO=$O(^DIC(81.3,LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXOC))'=LEXOC  D
 . . N LEXIEN S LEXIEN=0  F  S LEXIEN=$O(^DIC(81.3,LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . N LEXOK S LEXOK=1 S:$O(LEXTKNS(0))>0&($G(LEXIX)="C") LEXOK=0
 . . . Q:'LEXOK  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT
 . . . S LEXC=$P($G(^DIC(81.3,+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$MOD^ICPTMOD(LEXIEN,"I",LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,3)),LEXS=$P(LEXT,U,7) Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S LEXE=$P(LEXT,U,6) I LEXE'?7N S:+LEXS'>0 LEXE=$P(LEXT,U,8) S:+LEXS>0 LEXE=$P(LEXT,U,9)
 . . . S LEXTS=$$STY^LEXQL2(LEXC),LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)  S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="(Inactive)"
 . . . S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S LEXCT=LEXCT+1 S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_LEXCT_" "))=LEXIEN_U_$$FT^LEXQL2(LEXC,LEXN,$TR(LEXSS,"()",""))
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_LEXCT_" "),2)=LEXIEN_U_$$FC^LEXQL2(LEXC,LEXN,$TR(LEXSS,"()",""))
 Q
VI(X) ;   Verify Input
 N LEX,LEXIO,LEXIC,LEXUC,LEXUO S LEX=$G(X) Q:'$L(LEX) ""  Q:$L(LEX)'>1 $$UP^XLFSTR(LEX)
 S LEXIC=$G(LEX),LEXIO=$E(LEX,1,($L(LEX)-1))_$C(($A($E(LEX,$L(LEX)))-1))_"~ "
 S LEXUC=$$UP^XLFSTR(LEXIC),LEXUO=$$UP^XLFSTR(LEXIO)
 ; 81 CPT
 I $E($O(^ICPT("BA",LEXIO)),1,$L(LEXIC))=LEXIC Q LEXIC
 I $E($O(^ICPT("BA",LEXUO)),1,$L(LEXUC))=LEXUC Q LEXUC
 ; 81.3 CPT Modifier
 I $E($O(^DIC(81.3,"BA",LEXIO)),1,$L(LEXIC))=LEXIC Q LEXIC
 I $E($O(^DIC(81.3,"BA",LEXUO)),1,$L(LEXUC))=LEXUC Q LEXUC
 Q LEX
PUR ; Purge for CPT
 N LEXL,LEXN,LEXC S (LEXC,LEXL)=0 F  S LEXL=$O(LEXTKNS(LEXL)) Q:+LEXL'>0  D
 . S LEXN="" F  S LEXN=$O(LEXTKNS(LEXL,LEXN)) Q:'$L(LEXN)  D
 . . S LEXOK=$$NOT(LEXN) S:LEXN?1N.N LEXNUM(LEXN)="" S:LEXOK>0 LEXC=LEXC+1
 . . K:'LEXOK LEXTKNS(LEXL,LEXN)
 S LEXTTK=LEXC
 Q
NOT(X) ; Word not to use
 N LEXF,LEXN S LEXF=0 S:$E(X,1)?1N LEXF=1
 S LEXN="^AND^THE^THEN^FOR^FROM^OTHER^" S:LEXN[("^"_X_"^") LEXF=1
 S LEXN="^THAN^WITH^THEIR^SOME^THIS^INCLUDING^ALL^" S:LEXN[("^"_X_"^") LEXF=1
 S LEXN="^OTHERWISE^SPECIFIED^ANY^NOT^ONLY^EACH^MORE^" S:LEXN[("^"_X_"^") LEXF=1
 S LEXN="^ONE^TWO^LESS^PROCEDURES^WITH^OUT^TYPE^AREA^" S:LEXN[("^"_X_"^") LEXF=1
 S LEXN="^EXCEPT^INVOLVING^SAME^PER^DAYS^BUT^ALA^III^" S:LEXN[("^"_X_"^") LEXF=1
 S LEXN="^EXCEPT^NUMBERS^UNLESS^" S:LEXN[("^"_X_"^") LEXF=1
 S:$E(X,1)?1N LEXF=1
 Q:LEXF>0 0
 Q 1
