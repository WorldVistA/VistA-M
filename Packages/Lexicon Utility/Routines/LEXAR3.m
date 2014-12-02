LEXAR3 ;ISL/KER - Look-up Response (Help, Def, MAX) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**73,80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXHIT")      SACC 2.3.2.5.1
 ;    ^TMP("LEXSCH")      SACC 2.3.2.5.1
 ;    ^UTILITY($J         ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;    $$IMP^ICDEX         ICR   5747
 ;    $$DT^XLFDT          ICR  10103
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     LEXLL   List Length NEWed in LEXAR
 ;     LEXUR   User's Response NEWed in LEXAR
 ;     LEXVDT  Versioning Date NEWed in LEXAR
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
 Q:+($G(LEX))'>0  Q:+($G(LEXLL))'>0  I +($G(LEX))=1 D EXT2 Q
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
DH ; Display Help
 N LEXI S LEXI=0
 F  S LEXI=$O(LEX("HLP",LEXI)) Q:+LEXI=0  W !,"  ",LEX("HLP",LEXI)
 Q
DA ; Display List
 Q
 N LEXI S LEXI=0
 F  S LEXI=$O(LEX("LIST",LEXI)) Q:+LEXI=0  W !,"  ",LEX("LIST",LEXI)
 Q
DEF(LEXIEN) ; Definition Help LEX("HLP",
 N LEXR,LEXLN,LEXMC,LEXTY,LEXC
 S (LEXR,LEXIEN)=+($G(LEXIEN))
 S LEXTY=$P($G(^LEX(757.01,LEXIEN,1)),"^",2)
 D:$D(LEX("LIST")) LST^LEXAR Q:LEXIEN'>0
 N LEXLN,LEXMC,LEXC S (LEXLN,LEXC)=0 K LEX("HLP")
 I '$D(^LEX(757.01,LEXIEN,3,1)),LEXTY'=1 D
 . S LEXIEN=+($G(^LEX(757.01,LEXIEN,1)))
 . S LEXIEN=+($G(^LEX(757,LEXIEN,0)))
 I $D(^LEX(757.01,LEXIEN,0)),$L($G(^LEX(757.01,LEXIEN,3,1,0))) D
 . S LEXC=1,LEX("HLP",LEXC)=$G(^LEX(757.01,LEXIEN,0)) S LEXC=LEXC+1
 . S LEX("HLP",LEXC)="",LEXC("HLP",0)=LEXC
 . F  S LEXLN=$O(^LEX(757.01,LEXIEN,3,LEXLN)) Q:+LEXLN=0  D
 . . S LEXC=LEXC+1 S LEX("HLP",LEXC)=^LEX(757.01,LEXIEN,3,LEXLN,0)
 . . S LEX("HLP",0)=LEXC
 I '$D(LEX("HLP")) D
 . K LEX("HLP")
 . S LEX("HLP",1)="No definition found"
 . I $L($G(^LEX(757.01,LEXR,0))) D
 . . N LEXEXP S LEXEXP=$G(^LEX(757.01,LEXR,0)) Q:'$L(LEXEXP)
 . . S LEX("HLP",1)=LEX("HLP",1)_" found for "_$C(34)_LEXEXP_$C(34)
 . S:'$L($G(^LEX(757.01,LEXR,0))) LEX("HLP",1)="No definition found"
 D:$D(LEX("LIST")) LST^LEXAR
 Q
 ;
QMH(X) ; Question Mark Help (system sensitive)
 K LEX N LEX2,LEX3,LEX4,LEXA,LEXC,LEXCT,LEXD,LEXEX,LEXF,LEXFIL,LEXHDT
 N LEXI,LEXIDT,LEXLEN,LEXO,LEXOK,LEXP,LEXS,LEXSP,LEXT,LEXU,LEXX,LEXY,Y
 S LEXHDT=$G(LEXVDT) S:LEXHDT'?7N LEXHDT=$G(^TMP("LEXSCH",$J,"VDT",0))
 S:LEXHDT'?7N LEXHDT=$G(DT) S:LEXHDT'?7N LEXHDT=$$DT^XLFDT
 S LEXFIL=$G(^TMP("LEXSCH",$J,"FIL",0))
 S LEXY=$$HSYS^LEXHLP2(LEXFIL,LEXHDT),LEXIDT=$$IMP^ICDEX("10D")
 S:$L(LEXY,"/")>2 LEXY=LEXY_" etc" S LEXX=$G(X),(LEX2,LEX3,LEX4)=""
 S (LEXC,LEXS,LEXEX)="",LEXF=0 D:LEXX["??" HTXT
 I LEXX["??"&($L(LEX2))&($L(LEX3))&($L(LEX4)) D
 . S:$L(LEXC)&($L(LEXS))&($L(LEXEX)) LEXF=1
 S LEXOK=0 I LEXHDT?7N,LEXIDT?7N,LEXHDT<LEXIDT D
 . I LEXFIL["$$"&(LEXFIL["ONE^") D
 . . D:LEXFIL["$$10P"&(LEXFIL'["$$10D") N10P^LEXHLP2
 . . D:LEXFIL'["$$10P"&(LEXFIL["$$10D") N10D^LEXHLP2
 . . D:LEXFIL["$$10P"&(LEXFIL["$$10D") N10^LEXHLP2
 . I LEXFIL["$$SO^LEXU" D
 . . D:LEXFIL["10P"&(LEXFIL'["10D") N10P^LEXHLP2
 . . D:LEXFIL'["10P"&(LEXFIL["10D") N10D^LEXHLP2
 . . D:LEXFIL["10P"&(LEXFIL["10D") N10^LEXHLP2
 I 'LEXOK,LEXX["?"&(LEXX'["^") D
 . N LEXP,LEXSP,LEXI,LEXCT S LEXSP="      "
 . K LEXP S LEXP(1)="Enter a ""free text"" term.  "
 . S LEXP(1)=LEXP(1)_"Best results occur using two to four full "
 . S LEXP(1)=LEXP(1)_"or partial words without a suffix"
 . S:LEXF>0 LEXP(2)="(i.e., """_LEX2_""", """_LEX3_""", """_LEX4_""")"
 . D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 . F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . . S LEX("HLP",LEXCT)=LEXSP_LEXT
 . S LEXCT=$O(LEX("HLP"," "),-1)+1
 . S LEX("HLP",LEXCT)="  or  "
 . K LEXP S LEXP(1)="Enter a classification code "
 . S:$L(LEXY) LEXP(1)=LEXP(1)_"("_LEXY_") "
 . S LEXP(1)=LEXP(1)_"to find the term associated with the code."
 . I LEXF>0 D
 . . S LEXP(2)="Example; a lookup of "_LEXS_" code "_LEXC_" "
 . . S LEXP(2)=LEXP(2)_"returns one and only one term.  "
 . . S LEXP(2)=LEXP(2)_"That term is the preferred term for the code "
 . . S LEXP(2)=LEXP(2)_LEXC_", """_LEXEX_""""
 . D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 . F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . . S LEX("HLP",LEXCT)=LEXSP_LEXT
 . S LEXCT=$O(LEX("HLP"," "),-1)+1
 . S LEX("HLP",LEXCT)="  or  "
 . K LEXP S LEXP(1)="Enter a classification code "
 . S:$L(LEXY) LEXP(1)=LEXP(1)_"("_LEXY_") "
 . S LEXP(1)=LEXP(1)_"followed by a plus sign (+) to retrieve "
 . S LEXP(1)=LEXP(1)_"all terms associated with the code."
 . I LEXF>0 D
 . . S LEXP(2)="Example; a lookup of "_LEXS_" code "_LEXC
 . . S LEXP(2)=LEXP(2)_"+ returns all terms that are linked to "
 . . S LEXP(2)=LEXP(2)_"the code "_LEXC_"."
 . D PR(.LEXP,70) S LEXCT=$O(LEX("HLP"," "),-1),LEXI=0
 . F  S LEXI=$O(LEXP(LEXI)) Q:+LEXI'>0  D
 . . N LEXT S LEXT=$G(LEXP(LEXI)),LEXCT=LEXCT+1
 . . S LEX("HLP",LEXCT)=LEXSP_LEXT
 S LEXC=$O(LEX("HLP"," "),-1) I LEXC>0 D
 . S LEX=0,LEX("HLP",0)=LEXC S:$L($G(LEXX)) LEX("NAR")=$G(LEXX)
 Q
HTXT ;   Help Text (expanded)
 N LEXF,LEXOK,LEXU
 S LEXOK=0,LEXU=$G(LEXX) S LEXF=$G(^TMP("LEXSCH",$J,"FIL",0))
 S (LEX2,LEX3,LEX4,LEXC,LEXS,LEXEX)="",LEXOK=0 D:'$L(LEXF) HICD^LEXHLP2
 Q:LEXOK  D:LEXF["$$DX^LEXU" HICD^LEXHLP2  Q:LEXOK
 I LEXF["$$"&(LEXF["ONE^") D  Q:LEXOK
 . D:LEXF["$$10P"&(LEXF'["$$10D") H10P^LEXHLP2 D:LEXF["$$10D" H10D^LEXHLP2 Q:LEXOK
 . D:LEXF["$$CPC"&(LEXF'["$$CPT") HCPC^LEXHLP2 D:LEXF["$$CPT" HCPT^LEXHLP2 Q:LEXOK
 I LEXF["$$SO^LEXU" D  Q:LEXOK
 . D:LEXF["10P"&(LEXF'["10D") H10P^LEXHLP2 D:LEXF["10D" H10D^LEXHLP2 Q:LEXOK
 . D:LEXF["CPC"&(LEXF'["CPT") HCPC^LEXHLP2 D:LEXF["CPT" HCPT^LEXHLP2 Q:LEXOK
 . D:LEXF["SCC" HSCC^LEXHLP2 Q:LEXOK  D:LEXF["DS3"!(LEXF["DS4") HDS4^LEXHLP2 Q:LEXOK
 . D:LEXF["OMA"&(LEXF'["NAN") HOMA^LEXHLP2 D:LEXF["NAN" HNAN^LEXHLP2 Q:LEXOK
 D HICD^LEXHLP2
 Q
 ; 
 ; Miscellaneous
SA ;   Show Array
 N LEXI S LEXI=0 F  S LEXI=$O(LEX("HLP",LEXI)) Q:+LEXI'>0  D
 . W !,LEX("HLP",LEXI)
 Q
PR(LEXA,X) ;   Parse Array
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC
 K ^UTILITY($J,"W") Q:'$D(LEXA)  S LEXLEN=+($G(X))
 S:+LEXLEN'>0 LEXLEN=79 S LEXC=$O(LEXA(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0
 F  S LEXI=$O(LEXA(LEXI)) Q:+LEXI=0  S X=$G(LEXA(LEXI)) D ^DIWP
 K LEXA S (LEXC,LEXI)=0
 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEXA(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," ")
 . S LEXC=LEXC+1
 S:$L(LEXC) LEXA=LEXC K ^UTILITY($J,"W")
 Q
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
