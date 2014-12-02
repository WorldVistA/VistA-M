LEX10CS2 ;ISL/KER - ICD-10 Code Set (cont) ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP(LEXSUB,$J,     SACC 2.3.2.5.1
 ;    ^YSD(627.7,         ICR   1612
 ;    ^ICPT(              ICR   4489
 ;               
 ; External References
 ;    $$CODEABA^ICDEX     ICR   5747
 ;    $$ROOT^ICDEX        ICR   5747
 ;    $$CODEN^ICPTCOD     ICR   1995
 ;    $$DT^XLFDT          ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
CODELIST(X,LEXSPEC,LEXSUB,LEXD,LEXL,LEXF) ; Wild Card Search for Codes
 ;
 ; Input
 ;
 ;   X           Coding System (Required)
 ;   LEXSPEC     Search Specification (Required)
 ;                 First 2 characters alpha-numeric
 ;                 May contain a "?" wildcard in any position
 ;                 May contain a "*" wildcard in last position
 ;                 
 ;   LEXSUB      Global Subscript in the calling applications
 ;               namespace to be used in the output ^TMP
 ;               global array (Optional, default "CODELIST")
 ;               
 ;                 ^TMP(LEXSUB,$J, ...
 ;                 
 ;   LEXD        Search Date (Optional)
 ;   LEXL        List Length (Optional, Default 30)
 ;   LEXF        Output Flag (Optional)
 ;                 0 or Null brief output
 ;                 1 detailed output
 ;
 ; Output
 ;
 ;   ^TMP(LEXSUB,$J)   Output Array containing the codes found
 ;
 ;       LEXF = 0 or not passed
 ;
 ;       ^TMP(LEXSUB,$J,0)=Total n
 ;       ^TMP(LEXSUB,$J,1)=Code 1
 ;       ^TMP(LEXSUB,$J,2)=Code 2
 ;       ^TMP(LEXSUB,$J,n)=Code n
 ;
 ;       LEXF > 0
 ;
 ;       ^TMP(LEXSUB,$J,0)=Total n
 ;       ^TMP(LEXSUB,$J,1)=Code 1
 ;       ^TMP(LEXSUB,$J,1,1)=Code 1 ^ date
 ;       ^TMP(LEXSUB,$J,1,2)=Expression 1 IEN ^ Expression 1
 ;       ^TMP(LEXSUB,$J,1,"MSG")=Message (unversioned only)
 ;       ^TMP(LEXSUB,$J,2)=Code 1
 ;       ^TMP(LEXSUB,$J,2,1)=Code 2 ^ date
 ;       ^TMP(LEXSUB,$J,2,2)=Expression 2 IEN ^ Expression 2
 ;       ^TMP(LEXSUB,$J,2,"MSG")=Message (unversioned only)
 ;       ^TMP(LEXSUB,$J,n)=Code n
 ;       ^TMP(LEXSUB,$J,n,1)=Code n ^ date
 ;       ^TMP(LEXSUB,$J,n,2)=Expression n IEN ^ Expression n
 ;       ^TMP(LEXSUB,$J,n,"MSG")=Message (unversioned only)
 ;
 ;   $$CODELIST
 ;
 ;     A variable defining success/error conditions
 ;
 ;        Positive number for success
 ;        Negative number for error or condition
 ;
 ;          "-1^Coding system not specified"
 ;          "-2^Invalid coding system/source abbreviation"
 ;          "-3^No search specification"
 ;          "-4^Insufficient search specification"
 ;          "-5^Invalid search specification"
 ;          "-6^Number of matches exceeds specified limit"
 ;
 N LEX,LEXAI,LEXC,LEXCLIS,LEXCODE,LEXEFF,LEXEI,LEXEX,LEXEXC,LEXEXIT
 N LEXEXP,LEXFLG,LEXHIS,LEXI,LEXLEN,LEXND,LEXO,LEXOK,LEXR,LEXSI,LEXUN
 N LEXSP,LEXSRC,LEXSS,LEXTOT,LEXVDT S LEXTOT=0
 Q:'$L($G(X)) "-1^Coding system not specified"
 S LEXEXC=0,LEXSRC=$$SRC($G(X))
 Q:LEXSRC'>0 "-2^Invalid coding system/source abbreviation"
 S LEXSPEC=$$UP^XLFSTR($G(LEXSPEC))
 I LEXSRC=30 D
 . I $L(LEXSPEC)=4,$E(LEXSPEC,3)="*",$E(LEXSPEC,4)="." S LEXSPEC=$E(LEXSPEC,1,3)
 . I $L(LEXSPEC)=3,$E(LEXSPEC,3)'="*" S LEXSPEC=LEXSPEC_"."
 . I $L(LEXSPEC)>3,LEXSPEC'["." S LEXSPEC=$E(LEXSPEC,1,3)_"."_$E(LEXSPEC,4,$L(LEXSPEC))
 Q:'$L(LEXSPEC) "-3^No search specification"
 S LEXR=$P(LEXSPEC,"*",1),LEXR=$P(LEXR,"?",1)
 Q:$L(LEXR)'>1 "-4^Insufficient search specification"
 S LEXEXIT=0,LEXOK=1 F LEXI=1,2 D
 . S:$E(LEXSPEC,LEXI)'?1A&($E(LEXSPEC,LEXI)'?1N) LEXOK=0
 Q:'LEXOK "-5^Invalid search specification, first two characters must be alpha numeric"
 I LEXSPEC["*",$L($TR($P(LEXSPEC,"*",2,299),".","")) S LEXOK=0
 Q:'LEXOK "-5^Invalid search specification, trailing wildcard character ""*"""
 S LEXSS=$G(LEXSUB) S:'$L(LEXSS) LEXSS="CODELIST" S LEXVDT=$G(LEXD)
 S LEXUN=$S(LEXVDT?7N:0,1:1)
 S LEXLEN=$G(LEXL) S:+LEXLEN'>0 LEXLEN=5000000
 S LEXFLG=+($G(LEXF))
 S LEXO=$E(LEXR,1,($L(LEXR)-1))_$C($A($E(LEXR,$L(LEXR)))-1)_"~"
 S LEXEX=$S($E(LEXSPEC,$L(LEXSPEC))="*":0,1:1),LEXSP=$TR(LEXSPEC,"*","")
 S LEXEXIT=0 F  S LEXO=$O(^LEX(757.02,"CODE",LEXO)) D  Q:LEXEXIT
 . S:'$L(LEXO)!($E(LEXO,1,$L(LEXR))'=LEXR) LEXEXIT=1 Q:LEXEXIT
 . S LEXC=$TR(LEXO," ","") Q:LEXEX&($L(LEXSP)'=$L(LEXC))
 . S LEXOK=1 F LEXI=1:1:$L(LEXSP) D
 . . Q:$E(LEXSPEC,LEXI)="?"  Q:$E(LEXSPEC,LEXI)="*"
 . . S:$E(LEXC,LEXI)'=$E(LEXSPEC,LEXI) LEXOK=0
 . Q:'LEXOK  S LEXSI=0
 . F  S LEXSI=$O(^LEX(757.02,"CODE",LEXO,LEXSI)) Q:+LEXSI'>0  D
 . . N LEXAI,LEXCODE,LEXEFF,LEXEI,LEXEXP,LEXHIS,LEXND,LEXVAR,LEXMSG
 . . S LEXND=$G(^LEX(757.02,+LEXSI,0))
 . . Q:$P(LEXND,"^",3)'=LEXSRC  Q:$P(LEXND,"^",5)'=1
 . . I LEXVDT?7N S LEXEFF=$O(^LEX(757.02,+LEXSI,4,"B",(LEXVDT+.001)),-1) Q:LEXEFF'?7N
 . . I LEXVDT?7N S LEXHIS=$O(^LEX(757.02,+LEXSI,4,"B",LEXEFF," "),-1) Q:LEXHIS'?1N.N
 . . I LEXVDT'?7N S LEXEFF=$O(^LEX(757.02,+LEXSI,4,"B",(9999999+.001)),-1) Q:LEXEFF'?7N
 . . I LEXVDT'?7N S LEXHIS=$O(^LEX(757.02,+LEXSI,4,"B",LEXEFF," "),-1) Q:LEXHIS'?1N.N
 . . I LEXVDT?7N Q:$P($G(^LEX(757.02,+LEXSI,4,+LEXHIS,0)),"^",2)'=1
 . . S LEXEI=+LEXND,LEXEXP=$P($G(^LEX(757.01,+LEXEI,0)),"^",1)
 . . S LEXCODE=$P(LEXND,"^",2) Q:'$L(LEXCODE)  Q:+LEXEI'>0  Q:'$L(LEXEXP)
 . . S LEXMSG="" S:LEXUN>0 LEXMSG=$$MSG(LEXCODE)
 . . S LEXAI=$O(^TMP(LEXSS,$J," "),-1)+1
 . . S LEXTOT=LEXTOT+1 I LEXAI>LEXLEN S LEXEXC=1 Q
 . . S LEXVAR="" S:$L(LEXCODE)&(+LEXSRC>0) LEXVAR=$$VAR(LEXCODE,LEXSRC)
 . . S ^TMP(LEXSS,$J,0)=LEXAI
 . . S ^TMP(LEXSS,$J,LEXAI)=LEXCODE
 . . S:+LEXFLG>0 ^TMP(LEXSS,$J,LEXAI,1)=LEXVAR_"^"_LEXCODE_"^"_LEXEFF
 . . S:+LEXFLG>0 ^TMP(LEXSS,$J,LEXAI,2)=LEXEI_"^"_LEXEXP
 . . S:$L($G(LEXMSG)) ^TMP(LEXSS,$J,LEXAI,"MSG")=$G(LEXMSG)
 N LEXICON S X="1^"_+($G(^TMP(LEXSS,$J,0))) I +LEXEXC>0 D
 . I +($G(LEXTOT))>+($G(LEXLEN)) D
 . . S LEXTOT=$S(+($G(LEXTOT))>0:("("_+($G(LEXTOT))_") "),1:"")
 . . S LEXLEN=$S(+($G(LEXLEN))>0:(" ("_+($G(LEXLEN))_")"),1:"")
 . E  S (LEXTOT,LEXLEN)=""
 . S X="-6^Number "_$G(LEXTOT)_"of matches "
 . S X=X_"exceeds specified limit"_$G(LEXLEN)
 Q X
SRC(X) ; Source
 N LEXS S LEXS=$G(X) Q:'$L(LEXS) -1
 Q:LEXS?1N.N&($D(^LEX(757.03,+LEXS,0))) +LEXS
 Q:$D(^LEX(757.03,"B",LEXS)) $O(^LEX(757.03,"B",LEXS,0))
 Q:$D(^LEX(757.03,"ASAB",$E(LEXS,1,3))) $O(^LEX(757.03,"ASAB",$E(LEXS,1,3),0))
 Q -1
VAR(X,Y) ; Variable Pointer for code X and system Y
 N LEXCODE,LEXI,LEXIEN,LEXO,LEXRT,LEXSYS,LEXT,LEXVAR S LEXCODE=$G(X),LEXSYS=$G(Y) S LEXVAR=""
 I "^1^30^"[("^"_LEXSYS_"^") D  S X=LEXVAR Q X
 . S LEXRT=$$ROOT^ICDEX(80),LEXIEN=$$CODEABA^ICDEX(LEXCODE,80,LEXSYS)
 . S:+($G(LEXIEN))>0&(LEXRT["^") LEXVAR=+($G(LEXIEN))_";"_$TR(LEXRT,"^","")
 I "^2^31^"[("^"_LEXSYS_"^") D  S X=LEXVAR Q X
 . S LEXRT=$$ROOT^ICDEX(80.1),LEXIEN=$$CODEABA^ICDEX(LEXCODE,80.1,LEXSYS)
 . S:+($G(LEXIEN))>0&(LEXRT["^") LEXVAR=+($G(LEXIEN))_";"_$TR(LEXRT,"^","")
 I "^3^4^"[("^"_LEXSYS_"^") D  S X=LEXVAR Q X
 . S LEXRT="^ICPT(",LEXIEN=$$CODEN^ICPTCOD(LEXCODE)
 . S:+($G(LEXIEN))>0 LEXVAR=+($G(LEXIEN))_";"_$TR(LEXRT,"^","")
 I "^5^6^"[("^"_LEXSYS_"^") D  S X=LEXVAR Q X
 . N LEXT,LEXI,LEXIEN,LEXRT S LEXVAR=""
 . S LEXRT=" ^YSD(627.7,",LEXT=$S(LEXSYS=5:"3R",LEXSYS=6:4,1:"") Q:+LEXT'>0
 . S LEXI=0 F  S LEXI=$O(^YSD(627.7,"B",LEXCODE,LEXI)) Q:+LEXI=0  D
 . . Q:$P($G(^YSD(627.7,LEXI,0)),"^",2)'=LEXT  S LEXIEN=LEXI
 . S:+($G(LEXIEN))>0 LEXVAR=+($G(LEXIEN))_";"_$TR(LEXRT,"^","")
 S X=LEXVAR
 Q X
MSG(X) ; Message for Unversioned Search
 N LEXCODE,LEXIA,LEXAC,LEXPD,LEXTD S LEXTD=$$DT^XLFDT,LEXCODE=$TR(X," ","")
 S:$G(LEXCDT)?7N&($G(LEXCDT)'=LEXTD) LEXTD=$G(LEXCDT)
 I $G(LEXCDT)="" S:$G(LEXVDT)?7N&($G(LEXVDT)'=LEXTD) LEXTD=$G(LEXVDT)
 Q:'$L(LEXCODE) ""  Q:'$D(^LEX(757.02,"ACT",(LEXCODE_" "))) ""
 S LEXIA=$O(^LEX(757.02,"ACT",(LEXCODE_" "),2,(LEXTD+.0001)),-1)
 S LEXAC=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3,(LEXTD-.0001)),-1)
 S LEXPD=$O(^LEX(757.02,"ACT",(LEXCODE_" "),3,(LEXTD)))
 I LEXIA?7N,LEXAC?7N,LEXIA>LEXAC D  Q X
 . S X="Inactive "_$$FMTE^XLFDT(LEXIA,"5Z")
 I LEXAC'=LEXTD,LEXPD?7N,LEXPD>LEXTD D  Q X
 . S X="Pending "_$$FMTE^XLFDT(LEXPD,"5Z")
 Q ""
