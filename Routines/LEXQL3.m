LEXQL3 ;ISL/KER - Query - Lookup Code (CPT/MOD) ;10/30/2008
 ;;2.0;LEXICON UTILITY;**62**;Sep 23, 1996;Build 16
 ;               
 ; Global Variables
 ;    ^DIC(81.3,          ICR   4492
 ;    ^ICD0(              ICR   4485
 ;    ^ICD9(              ICR   4485
 ;    ^ICPT(              ICR   4489
 ;    ^TMP("LEXQL")       SACC 2.3.2.5.1
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$CPT^ICPTCOD       ICR   1995
 ;    $$MOD^ICPTMOD       ICR   1996
 ;    $$FMTE^XLFDT        ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;    LEXVDT              Versioning Date - If it does not exist
 ;                        in the environment, TODAY is used
 ;    LEXOC               Control $Order Variable
 ;    LEXTD               TODAY's Date
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
 S LEXO=LEXOC Q:'$L(LEXO)  Q:'$L($G(LEXCT))  N LEXIX F LEXIX="BA","C" D
 . Q:LEXIX="C"&(LEXOC?1N.NA)  S LEXO=LEXOC S:LEXIX="BA" LEXO=LEXO_" "
 . F  S LEXO=$O(^ICPT(LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXCT))'=LEXCT  D
 . . N LEXIEN S LEXIEN=0  F  S LEXIEN=$O(^ICPT(LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . S LEXIEN=+($G(LEXIEN)) Q:+LEXIEN'>0  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT,LEXCTY
 . . . S LEXC=$P($G(^ICPT(+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$CPT^ICPTCOD(LEXC,LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,3)),LEXS=$P(LEXT,U,7) Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S LEXE=$P(LEXT,U,6) I LEXE'?7N S:+LEXS'>0 LEXE=$P(LEXT,U,8) S:+LEXS>0 LEXE=$P(LEXT,U,9)
 . . . S LEXTS=$$STY(LEXC),LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)  S:LEXC?5N LEXCTY=3 S:LEXC'?5N LEXCTY=4
 . . . S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="Inactive" S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS
 . . . S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "))=LEXIEN_U_$$FT(LEXC,LEXN,LEXSS)
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_" "),2)=LEXIEN_U_$$FC(LEXC,LEXN,LEXSS)
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
 S LEXO=LEXOC Q:'$L(LEXO)  Q:'$L($G(LEXCT))  N LEXIX F LEXIX="BA","C" D
 . Q:LEXIX="C"&(LEXOC?1N.NA)  S LEXO=LEXOC S:LEXIX="BA" LEXO=LEXO_" "
 . F  S LEXO=$O(^DIC(81.3,LEXIX,LEXO)) Q:'$L(LEXO)  Q:$E(LEXO,1,$L(LEXCT))'=LEXCT  D
 . . N LEXIEN,LEXCT S (LEXCT,LEXIEN)=0  F  S LEXIEN=$O(^DIC(81.3,LEXIX,LEXO,LEXIEN)) Q:+LEXIEN'>0  D
 . . . S LEXIEN=+($G(LEXIEN)) Q:+LEXIEN'>0  N LEXT,LEXD,LEXC,LEXD,LEXN,LEXS,LEXE,LEXDS,LEXTN,LEXTS,LEXSS,LEXDT
 . . . S LEXC=$P($G(^DIC(81.3,+LEXIEN,0)),U,1) Q:'$L(LEXC)  S LEXD=$G(LEXVDT) S:LEXD'?7N LEXD=$G(LEXTD) S LEXT=$$MOD^ICPTMOD(LEXIEN,"I",LEXD)
 . . . S LEXC=$P(LEXT,U,2),LEXN=$$UP^XLFSTR($P(LEXT,U,3)),LEXS=$P(LEXT,U,7) Q:'$L(LEXC)  Q:'$L(LEXN)  Q:'$L(LEXS)
 . . . S LEXE=$P(LEXT,U,6) I LEXE'?7N S:+LEXS'>0 LEXE=$P(LEXT,U,8) S:+LEXS>0 LEXE=$P(LEXT,U,9)
 . . . S LEXTS=$$STY(LEXC),LEXTN=+LEXTS,LEXTS=$P(LEXTS,U,2) Q:'$L(LEXTS)  S LEXSS="" S:+LEXS'>0&($L($G(LEXE))) LEXSS="(Inactive)"
 . . . S LEXDS=LEXN S:$L(LEXSS) LEXDS=LEXDS_" "_LEXSS S LEXDT=LEXC,LEXDT=LEXDT_$J(" ",(8-$L(LEXDT)))_LEXDS S:$L(LEXTS) LEXDT=LEXDT_" ("_LEXTS_")"
 . . . S LEXCT=LEXCT+1 S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_LEXCT_" "))=LEXIEN_U_$$FT(LEXC,LEXN,$TR(LEXSS,"()",""))
 . . . S ^TMP("LEXQL",$J,"ADDLIST",(LEXTN_" "_LEXC_LEXCT_" "),2)=LEXIEN_U_$$FC(LEXC,LEXN,$TR(LEXSS,"()",""))
 Q
 ; Miscellaneous
SD(X) ;   Short Date
 Q $TR($$FMTE^XLFDT(+($G(X)),"5DZ"),"@"," ")
FT(X,Y,LEX) ;   Format Text First
 N LEXT,LEXC,LEXD,LEXS S LEXC=$G(X),LEXD=$G(Y),LEXS=$G(LEX) S LEXC=$G(LEXC) Q:'$L(LEXC) ""  S LEXT=$P($$STY(LEXC),U,2) Q:'$L(LEXT)  S LEXD=$G(LEXD) Q:'$L(LEXD) ""
 S LEXS=$G(LEXS),LEXT=$G(LEXT) S:$L(LEXD)&($L(LEXS)) LEXD=LEXD_" ("_LEXS_")" N LEXO S LEXO=LEXC
 S LEXO=LEXO_$J(" ",(8-$L(LEXO)))_$E(LEXD,1,54),LEXO=LEXO_$J(" ",(63-$L(LEXO)))_LEXT S X=LEXO
 Q X
FC(X,Y,LEX) ;   Format Code First
 N LEXO,LEXT,LEXC,LEXD,LEXS S LEXC=$G(X),LEXD=$G(Y),LEXS=$G(LEX) Q:'$L(LEXC) ""  S LEXT=$P($$STY(LEXC),"^",2)
 Q:'$L(LEXT) ""  Q:'$L(LEXD) ""  S LEXS=$G(LEXS),LEXO=LEXT_" "_LEXC_" " S LEXO=LEXO_$J(" ",(15-$L(LEXO))),LEXO=LEXO_" "_LEXD
 S:$L(LEXS) LEXO=$E(LEXO,1,59)_" ("_LEXS_")" S X=LEXO
 Q X
STY(X) ;   Short Type
 N LEXSO S LEXSO=$G(X) Q:$L(LEXSO)'>1 ""
 Q:$D(^ICD9("BA",(LEXSO_" "))) "1^ICD Dx"
 Q:$D(^ICD0("BA",(LEXSO_" "))) "2^ICD Op"
 Q:$D(^ICPT("BA",(LEXSO_" ")))&(LEXSO?5N) "3^CPT-4"
 Q:$D(^ICPT("BA",(LEXSO_" ")))&(LEXSO'?5N) "4^HCPCS"
 Q:$D(^DIC(81.3,"BA",(LEXSO_" "))) "5^CPT Mod"
 Q ""
LTY(X) ;   Long Type
 N LEXSO S LEXSO=$G(X) Q:$L(LEXSO)'>1 ""
 Q:$D(^ICD9("BA",(LEXSO_" "))) "1^ICD Diagnosis Code"
 Q:$D(^ICD0("BA",(LEXSO_" "))) "2^ICD Procedure Code"
 Q:$D(^ICPT("BA",(LEXSO_" ")))&(LEXSO?5N) "3^CPT Procedure Code"
 Q:$D(^ICPT("BA",(LEXSO_" ")))&(LEXSO'?5N) "4^HCPCS Procedure Code"
 Q:$D(^DIC(81.3,"BA",(LEXSO_" "))) "5^CPT Modifier Code"
 Q ""
DS(X) ;   Trim Dubble Space Character
 S X=$G(X) Q:X'["  " X  F  Q:X'["  "  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,299)
 Q X
CL ;   Clear
 K LEXVDT,LEXOC,LEXTD
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
PR(LEX,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC K ^UTILITY($J,"W") Q:'$D(LEX)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
