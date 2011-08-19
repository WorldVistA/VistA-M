LEXA ;ISA/FJF/KER - Look-up (Silent) ;01/03/2011
 ;;2.0;LEXICON UTILITY;**3,4,6,19,25,36,38,43,55,73**;Sep 23, 1996;Build 10
 ;
 ; External References
 ;   ^TMP(               SACC 2.3.2.5.1
 ;   ^VA(200,            ICR  10060
 ;   ^DIM                ICR  10016
 ;   $$DT^XLFDT          ICR  10103
 ;   $$UP^XLFSTR         ICR  10104
 ;                   
 ; Look-up  D LOOK^LEXA(LEXX,LEXAP,LEXLL,LEXSUB,lexvdt)
 ;                   
 ;         LEXX      User Input
 ;         LEXAP     Application
 ;         LEXLL     Selection List Length
 ;         LEXSUB    Mode/Subset (file 757.2)
 ;         LEXVDT    Date to use for retrieving/displaying codes
 ;         LEXXSR    Source (file 757.14)
 ;         LEXXCT    Category (file 757.13)
 ;                   
 ; 1.  Search parameters ^TMP("LEXSCH",$J,PAR)=VALUE
 ; 2.  Expressions found ^TMP("LEXFND",$J,FQ,IEN)=DT
 ; 3.  Review List       ^TMP("LEXHITS",$J,#)=IEN^DT
 ; 4.  Display List      LEX("LIST",#)
 ;                   
 ;         LEX("LIST",0)=LAST^TOTAL
 ;         LEX("LIST",#)=IEN^DT
 ;                   
LOOK(LEXX,LEXAP,LEXLL,LEXSUB,LEXVDT,LEXXSR,LEXXCT) ; Search for LEXX
 I $G(LEXVDT)="" S LEXVDT=$$DT^XLFDT
 I $L($G(^TMP("LEXSCH",$J,"VDT",0))) S LEXVDT=^TMP("LEXSCH",$J,"VDT",0)
 K DIERR,LEX
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 K ^TMP("LEXSCH",$J,"EXC"),^TMP("LEXSCH",$J,"EXM")
 K:+$G(^TMP("LEXSCH",$J,"ADF",0))=0 ^TMP("LEXSCH",$J)
 I $D(DIC(0)) D
 .S:DIC(0)["L" DIC(0)=$P(DIC(0),"L",1)_$P(DIC(0),"L",2)
 .S:DIC(0)["I" DIC(0)=$P(DIC(0),"I",1)_$P(DIC(0),"I",2)
 S LEXQ=1,LEXX=$G(LEXX)
 I LEXX=""!(LEXX["^") D EN^LEXAR("^",$G(LEXVDT)) K LEXAP D EXIT Q
 N LEXSC S LEXSC=$$CAT($G(LEXXCT),$G(LEXXSR))
 N LEXXCT,LEXXSR S:+($P(LEXSC,"^",1))>0 LEXXCT=+($P(LEXSC,"^",1)) S:+($P(LEXSC,"^",2))>0 LEXXSR=+($P(LEXSC,"^",2))
 S LEXAP=$$UP^XLFSTR($G(LEXAP))
 S LEXLL=+$G(LEXLL)
 S LEXSUB=$G(LEXSUB)
 S ^TMP("LEXSCH",$J,"APP",0)=+$$AP^LEXDFN2($G(LEXAP))
 S:^TMP("LEXSCH",$J,"APP",0)=0 ^TMP("LEXSCH",$J,"APP",0)=1
 S:LEXSUB="" LEXSUB=^TMP("LEXSCH",$J,"APP",0)
 S:$L($G(DIC("S"))) ^TMP("LEXSCH",$J,"FIL",0)=DIC("S")
 S:LEXLL=0 LEXLL=5
 S ^TMP("LEXSCH",$J,"LEN",0)=LEXLL
X ; Search for X
 I '$L($G(LEXX)) D  D EXIT Q
 .S LEX("ERR",0)=$G(LEX("ERR",0))+1
 .S LEX("ERR",LEX("ERR",0))="User input LEXX missing or invalid"
APP ; Application
 I +$G(^TMP("LEXSCH",$J,"APP",0))=0!('$D(^LEXT(757.2,+$G(^TMP("LEXSCH",$J,"APP",0)),0))) D  D EXIT Q
 .S LEX("ERR",0)=$G(LEX("ERR",0))+1
 .S LEX("ERR",LEX("ERR",0))="Calling application identification LEXAP missing or invalid"
USR ; User
 I +$G(DUZ)=0!('$D(^VA(200,+$G(DUZ),0))) D  D EXIT Q
 .S LEX("ERR",0)=$G(LEX("ERR",0))+1
 .S LEX("ERR",LEX("ERR",0))="User identification DUZ missing or invalid"
 N LEXFND,LEXISCD
 S (LEXFND,LEXISCD)=0
 S ^TMP("LEXSCH",$J,"USR",0)=+$G(DUZ)
 S ^TMP("LEXSCH",$J,"NAR",0)=LEXX
 S ^TMP("LEXSCH",$J,"SCH",0)=$$UP^XLFSTR(LEXX)
DEF ; Defaults                     CONFIG^LEXSET
 N LEXFIL,LEXDSP,LEXFILR S:$L($G(DIC("S"))) LEXFIL=DIC("S")
 I '$L($G(LEXFIL)),$L($G(^TMP("LEXSCH",$J,"FIL",0))) S LEXFIL=^TMP("LEXSCH",$J,"FIL",0)
 N LEXNS,LEXSS
 S LEXNS=$$NS^LEXDFN2(LEXAP)
 S LEXSS=$$MD^LEXDFN2(LEXSUB)
 I +$G(^TMP("LEXSCH",$J,"ADF",0))=0 D CONFIG^LEXSET(LEXNS,LEXSS,$G(LEXVDT))
 I '$L($G(LEXFIL)),$L($G(^TMP("LEXSCH",$J,"FIL",0))) S LEXFIL=^TMP("LEXSCH",$J,"FIL",0)
 S:$L($G(LEXFIL)) LEXFIL=$$FIL(LEXFIL)
 S LEXFIL=$G(LEXFIL)
 K ^TMP("LEXFND",$J),^TMP("LEXHIT",$J)
 D MAN
 I $D(LEX("ERR")) D EXIT Q
 D SETUP^LEXAM($G(^TMP("LEXSCH",$J,"VOC",0)))
 I $D(LEX("ERR")) D EXIT Q
LK ; Look-up
HLP ; Look-up Help                 ADDL^LEXAL
 I (LEXX["?"&($P(LEXX,"?",2)'?1N.N))!(LEXX["??") D  I $D(LEX("HLP")) D EXIT Q
 .D QMH^LEXAR3(LEXX)
IEN ; Look-up by IEN               ADDL^LEXAL PCH 4
 I ^TMP("LEXSCH",$J,"NAR",0)?1"`"1N.N D  I $D(LEX("LIST")) D EXIT Q
 .N LEXE,LEXUN
 .S LEXE=+$E(^TMP("LEXSCH",$J,"NAR",0),2,$L(^TMP("LEXSCH",$J,"NAR",0))) Q:LEXE=0
 .S LEXUN=+$G(^TMP("LEXSCH",$J,"UNR",0))
 .Q:'$D(^LEX(757.01,LEXE,0))
 .D ADDL^LEXAL(LEXE,$$DES^LEXASC(LEXE),$$SO^LEXASO(LEXE,$G(^TMP("LEXSCH",$J,"DIS",0)),1,$G(LEXVDT)))
 .I $D(^TMP("LEXFND",$J)) D BEG^LEXAL
 .I LEXUN>0,$L($G(^TMP("LEXSCH",$J,"NAR",0))) S LEX("NAR")=$G(^TMP("LEXSCH",$J,"NAR",0))
 .I LEXUN>0,$L($G(^LEX(757.01,+$G(LEXE),0))) S LEX("NAR")=$G(^LEX(757.01,+$G(LEXE),0))
SCT ; Look-up by Shortcuts         EN^LEXASC  
 I +$G(^TMP("LEXSCH",$J,"SCT",0)),$D(^LEX(757.41,^TMP("LEXSCH",$J,"SCT",0))) D
 .S LEXFND=$$EN^LEXASC(^TMP("LEXSCH",$J,"SCH",0),^TMP("LEXSCH",$J,"SCT",0),$G(LEXVDT))
 I +LEXFND D EXIT Q
CODE ; Look-up by Code              EN^LEXABC
 S LEXFND=$$EN^LEXABC(^TMP("LEXSCH",$J,"SCH",0),$G(LEXVDT))
 I +LEXFND D EXIT Q
 I +LEXFND'>0,+($G(LEXISCD))>0 D EXIT Q
 ; if code is found but it is inactive
 ;I +$P(LEXFND,"^",2)'=-1 S LEX=0 D EXIT Q
EXACT ; Look-up Exact Match          EN^LEXAB
 S LEXFND=$$EN^LEXAB(^TMP("LEXSCH",$J,"SCH",0),$G(LEXVDT))
 K:+LEXFND=0 ^TMP("LEXFND",$J)
 K ^TMP("LEXHIT",$J)
KEYWRD ; Look-up by word              EN^LEXALK
 D EN^LEXALK
EXIT ; Clean-up and quit
 K LEXQ,LEXDICS,LEXFIL,LEXFILR,LEXDSP,LEXSHOW,LEXSHCT,LEXSUB
 K LEXOVR,LEXUN,LEXLKFL,LEXLKGL,LEXLKIX,LEXLKSH,LEXTKNS,LEXTKN
 K LEXI Q:$D(LEX("HLP"))
 D:$D(LEX("ERR")) CLN
 I $D(LEX),+$G(LEX)=0,'$D(LEX("LIST")),$L($G(LEXX)) D
 .N LEXC,LEXF,LEXV
 .S LEXC=1
 .S LEXF=$G(^TMP("LEXSCH",$J,"FIL",0))
 .S LEXV=$G(^TMP("LEXSCH",$J,"VOC",0))
 .D:+$G(^TMP("LEXSCH",$J,"UNR",0))>0 EN^LEXAR(LEXX,$G(LEXVDT))
 .S:'$D(LEX("NAR")) LEX("NAR")=LEXX
 .S LEX=0
 .S:'$D(LEX("HLP")) LEX("HLP",LEXC)="    A suitable term could not be found based on user input"
 .S:LEXF="I 1" LEXF=""
 .I $L(LEXF)!(LEXV'="WRD"),'$D(LEX("HLP")) D
 ..S LEX("HLP",LEXC)=$G(LEX("HLP",LEXC))_" and "
 ..S LEXC=LEXC+1
 ..S LEX("HLP",LEXC)="    current user defaults"
 ..S LEX("HLP",0)=LEXC
 .S:'$D(LEX("HLP")) LEX("HLP",LEXC)=$G(LEX("HLP",LEXC))_"."
 Q
CLN ; Clean
 K LEXQ,LEXTKNS,LEXTKN,LEXI
 K ^TMP("LEXSCH",$J),^TMP("LEXHIT",$J),^TMP("LEXFND",$J)
 Q
MAN ; Mandatory variables
 N LEXERR
 F LEXERR="SCH","VOC","APP","USR" D
 .I '$L($G(^TMP("LEXSCH",$J,LEXERR,0))) D
 ..S LEX("ERR",0)=$G(LEX("ERR",0))+1
 ..S LEX("ERR",LEX("ERR",0))="Mandatory variable ^TMP(""LEXSCH"",$J,"""_LEXERR_""",0) missing or invalid"
 Q
CAT(X,Y) ; Source Category
 N LEX,LEXC,LEXI,LEXO,LEXS,LEXU S (X,LEX)=$G(X) Q:'$L(X) ""  Q:X?1N.N&('$D(^LEX(757.13,+X,0))) ""
 S (LEXS,Y)=$G(Y) S:$L(LEXS) LEXS=$$SRC(LEXS) I X?1N.N,$D(^LEX(757.13,+X,0)) S X=+X S:+LEXS>0 X=X_"^"_+LEXS Q X
 S LEXU=$$UP^XLFSTR(LEX),(X,LEXC)=+($O(^LEX(757.13,"C",LEXU,0))) Q:'$D(^LEX(757.13,"C",LEXU)) ""
 I +LEXC>0,LEXC=+($O(^LEX(757.13,"C",LEXU," "),-1)) S X=+LEXC S:+LEXS>0 X=X_"^"_+LEXS Q X
 S LEXO="",LEXI=0 F  S LEXI=$O(^LEX(757.13,"C",LEXU,LEXI)) Q:+LEXI'>0  D  Q:+LEXO>0
 . S:$P($G(^LEX(757.13,LEXI,4)),"^",1)=LEXS LEXO=LEXI
 S X="" S:+LEXO>0 X=+LEXO S:+LEXO>0&(+LEXS>0) X=X_"^"_+LEXS
 Q X
SRC(X) ; Source
 N LEX,LEXU S (LEX,X)=$TR($G(X),"`","") Q:'$L(LEX) ""  Q:X?1N.N&('$D(^LEX(757.14,+X,0))) ""  Q:X?1N.N&($D(^LEX(757.14,+X,0))) +X
 S LEXU=$$UP^XLFSTR(LEX),X=$O(^LEX(757.14,"B",LEX,0)) Q:+X>0 +X  S X=$O(^LEX(757.14,"B",LEXU,0)) Q:+X>0 +X
 Q ""
FIL(X) ; Validate Filter
 S X=$G(X) N DIC Q:'$L(X) X D ^DIM S:'$D(X) X=""
 Q X
 ;                   
 ; D INFO^LEXA(IEN,DATE)
 ;                   
 ;    IEN   Internal Entry Number in file 757.01
 ;    DATE  Optional - retrieves codes active on a specified date
 ;               
 ; Returns array LEX("SEL") or null
 ;                   
 ;    LEX("SEL","EXP")   Expressions Concepts/Synonyms/Variants
 ;    LEX("SEL","SIG")   Expression definition
 ;    LEX("SEL","SRC")   Classification Codes
 ;    LEX("SEL"."STY")   Semantic Class/Semantic Types
 ;    LEX("SEL","VAS")   VA Classification Sources
 ;                   
INFO(X,LEXVDT) ; Get Information about a Term
 K LEX("SEL") S X=+$G(X) Q:X=0  Q:'$D(^LEX(757.01,X,0))
 N LEXD S LEXD=$G(LEXVDT) S:+LEXD'>0 LEXD=$$DT^XLFDT
 N LEXVDT S LEXVDT=LEXD D SET^LEXAR4(X,LEXVDT)
 Q
