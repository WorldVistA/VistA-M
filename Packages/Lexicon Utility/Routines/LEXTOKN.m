LEXTOKN ;ISL/KER - Parse term into words ;04/21/2014
 ;;2.0;LEXICON UTILITY;**80**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^TMP("LEXTKN")      SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ;               
 ; External References
 ;    $$SW^LEXTOKN2
 ;    ORD^LEXTOKN2
 ;    ST^LEXTOKN2
 ;    $$UP^XLFSTR
 ;               
 ; Lexicon files accessed
 ;    ^LEX(757.01         Expression File
 ;    ^LEX(757.04         Excluded Words
 ;    ^LEX(757.05         Replacement Words
 ;    
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DA       Set and Killed by Fileman
 ;     LEXIDX   Set if parsing for indexing logic (LEXNDX*)
 ;     LEXLOOK  Set if parsing for Lookup logic (LEXA)
 ;     LEXLOW   Set of lower case is needed (LEXNDX2)
 ;               
 ; Returns ^TMP("LEXTKN",$J,#,WORD) containing words
 ; 
 ; Special variables:
 ; 
 ; LEXIDX    If set, then the Excluded Words file is used 
 ;           to selectively exclude words from the indexing
 ;           process and both singular and plural forms are
 ;           indexed.
 ; 
 ; LEXLOOK   If set, then the Excluded Words file is used
 ;           to selectively exclude words from the look-up
 ;           process and only singular forms are used when
 ;           one is found.
 ; 
 ; If LEXIDX or LEXLOOK exist, then LEXLOW is ignored.
 ; 
 ; If LEXIDX and LEXLOOK do not exist then ALL words are 
 ; parsed and returned in the global array.
 ;
PT ; Entry point where DA is defined and X is unknown
 Q:'$D(DA)  S X=^LEX(757.01,DA,0)
PTX ; Entry point to parse string (X must exist)
 N LEXOK,LEXTOKS,LEXTOKS2,LEXTOKI,LEXTOKW,LEXTOLKN
 N LEXOKC,LEXOKN,LEXOKP,LEXTOKAA,LEXTOKAB,LEXTOKAC
 ;   Prevent lowercase indexing and lookup
 I $D(LEXIDX)!($D(LEXLOOK)) K LEXLOW
 K ^TMP("LEXTKN",$J) Q:'$L($G(X))  S X=$$SW^LEXTOKN2($G(X))
 S LEXTOKS=$TR(X,"-"," "),LEXTOKS=$TR(LEXTOKS,$C(9)," ")
 ;   Remove leading blanks from string
 F LEXOKP=1:1:$L(LEXTOKS) Q:$E(LEXTOKS,LEXOKP)'[" "
 S LEXTOKS=$E(LEXTOKS,LEXOKP,$L(LEXTOKS))
 ;   Remove trailing blanks from string
 F LEXOKP=$L(LEXTOKS):-1:1 Q:$E(LEXTOKS,LEXOKP)'[" "
 S LEXTOKS=$E(LEXTOKS,1,LEXOKP)
 ;   Remove Punctuation (less slashes)
 S LEXTOKS=$TR(LEXTOKS,"?`~!@#$%^&*()_-+={}[]\:;,<>","                            ")
 ;   Conditionally remove slashes
 S:$D(LEXIDX) LEXTOKS=$TR(LEXTOKS,"/"," ")
 S:$E($P(LEXTOKS,".",2),1)'?1N LEXTOKS=$TR(LEXTOKS,"."," ")
 S LEXTOKS=$TR(LEXTOKS,"""","")
 ;   Swtich to UPPERCASE (lower case is not specified by LEXLOW)
 S:'$D(LEXLOW) LEXTOKS=$$UP^XLFSTR(LEXTOKS)
 ;   Store in temporary array (based on space character)
 S LEXOKC=0 F LEXTOKI=1:1:$L(LEXTOKS," ") D
 . N LEXTOKW S LEXTOKW=$P(LEXTOKS," ",LEXTOKI) Q:LEXTOKW=""
 . I LEXTOKW'["/" D
 . . S LEXOKC=LEXOKC+1,LEXTOLKN(LEXOKC)=LEXTOKW
 . . S LEXTOLKN(0)=LEXOKC
 . I LEXTOKW["/"&('$D(^LEX(757.05,"B",LEXTOKW))) D  Q
 . . N LEXP S LEXP=0 F  S LEXP=LEXP+1 Q:$P(LEXTOKW,"/",LEXP)=""  D
 . . . S LEXOKC=LEXOKC+1,LEXTOLKN(LEXOKC)=$P(LEXTOKW,"/",LEXP)
 . . . S LEXTOLKN(0)=LEXOKC
 . I LEXTOKW["/"&($D(^LEX(757.05,"B",LEXTOKW))) D
 . . N LEXOKR S LEXOKR=$O(^LEX(757.05,"B",LEXTOKW,0))
 . . I $P($G(^LEX(757.05,LEXOKR,0)),U,3)="R" D
 . . . S LEXOKC=LEXOKC+1,LEXTOLKN(LEXOKC)=LEXTOKW
 . . . S LEXTOLKN(0)=LEXOKC
 K LEXOKC,LEXOKR
 I +($G(LEXTOLKN(0)))=0 K LEXTOLKN S ^TMP("LEXTKN",$J,0)=0 G EXIT
 S LEXTOKW="",LEXOKN=0 F LEXTOKI=1:1:LEXTOLKN(0) D
 . S LEXTOKW=$G(LEXTOLKN(LEXTOKI))
 . ;   Remove leading blanks
 . F LEXOKP=1:1:$L(LEXTOKW) Q:$E(LEXTOKW,LEXOKP)'[" "
 . S LEXTOKW=$E(LEXTOKW,LEXOKP,$L(LEXTOKW))
 . ;   Remove trailing blanks
 . F LEXOKP=$L(LEXTOKW):-1:1 Q:$E(LEXTOKW,LEXOKP)'[" "
 . S LEXTOKW=$E(LEXTOKW,1,LEXOKP)
 . ;   Apostrophy "S"
 . I $E(LEXTOKW,($L(LEXTOKW)-1),$L(LEXTOKW))["'S" S LEXTOKW=$E(LEXTOKW,1,($L(LEXTOKW)-2))
 . ;   Apostrophies and spaces
 . S LEXTOKW=$TR(LEXTOKW,"'",""),LEXTOKW=$TR(LEXTOKW," ","")
 . ;   Excluded Words
 . ;     Exclude from Indexing
 . I $D(LEXIDX) D
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"I")) LEXTOKW=""
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"B")) LEXTOKW=""
 . ;     Exclude from Lookup
 . I $D(LEXLOOK) D
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"L")) LEXTOKW=""
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"B")) LEXTOKW=""
 . I $D(LEXOKN),$L($G(LEXTOKW)) D
 . . ;   Replacement Words
 . . I $P($G(^LEX(757.05,+($O(^LEX(757.05,"B",LEXTOKW,0))),0)),"^",3)="R" D REP(LEXTOKW) Q
 . . I '$D(^TMP("LEXTKN",$J,"B",LEXTOKW)) D
 . . . S LEXOKN=$O(^TMP("LEXTKN",$J," "),-1)+1
 . . . S ^TMP("LEXTKN",$J,LEXOKN,LEXTOKW)=""
 . . . S ^TMP("LEXTKN",$J,"B",LEXTOKW)=""
 . S LEXTOKW=""
 S LEXOKC=0 F  S LEXOKC=$O(^TMP("LEXTKN",$J,LEXOKC)) Q:+LEXOKC'>0  D
 . S LEXTOKW="" F  S LEXTOKW=$O(^TMP("LEXTKN",$J,LEXOKC,LEXTOKW)) Q:'$L(LEXTOKW)  D
 . . N LEXSIN S LEXSIN=$$SIN(LEXTOKW) Q:'$L(LEXSIN)
 . . I $D(LEXIDX) D
 . . . S LEXI=$O(^TMP("LEXTKN",$J," "),-1)+1
 . . . S ^TMP("LEXTKN",$J,LEXI,LEXSIN)="",^TMP("LEXTKN",$J,"B",LEXSIN)=""
 . . I $D(LEXLOOK) D
 . . . K ^TMP("LEXTKN",$J,LEXOKC,LEXTOKW),^TMP("LEXTKN",$J,"B",LEXTOKW)
 . . . S ^TMP("LEXTKN",$J,LEXOKC,LEXSIN)="",^TMP("LEXTKN",$J,"B",LEXSIN)=""
 S (LEXOKN,LEXOKC)=0 F  S LEXOKC=$O(^TMP("LEXTKN",$J,LEXOKC)) Q:+LEXOKC'>0  S LEXOKN=LEXOKN+1
 S ^TMP("LEXTKN",$J,0)=LEXOKN
 K ^TMP("LEXTKN",$J,"B")
EXIT ; Clean up and quit PTX
 K LEXOK,LEXTOKI,LEXOKN,LEXOKP,LEXOKR,LEXTOKS,LEXTOKS2,LEXTOKW,LEXTOLKN
 Q
 ; 
 ; Miscellaneous
ORD ;   Reorder Global Array
 D ORD^LEXTOKN2
 Q
REP(X) ;   Replace
 N LEXREP,LEXTXT,LEXREF,LEXFLG,LEXARY,LEXIN,LEXWITH,LEXI,LEXO
 S (LEXO,LEXFLG)=0,LEXIN=$G(X) Q:'$L(LEXIN)
 S:$D(LEXIDX)&'$D(LEXLOOK) LEXFLG=1
 S:'$D(LEXIDX)&$D(LEXLOOK) LEXFLG=2
 S:$D(LEXIDX)&$D(LEXLOOK) LEXFLG=3
 S LEXTXT=$P($G(^LEX(757.05,+($O(^LEX(757.05,"B",LEXIN,0))),0)),"^",2)
 S LEXWITH=$$WITH(LEXTXT,.LEXARY,LEXFLG)
 I LEXFLG=1 D
 . Q:$D(LEXLOOK)  Q:'$L(LEXIN)
 . I '$D(^TMP("LEXTKN",$J,"B",LEXIN)) D
 . . S LEXOKN=+($G(LEXOKN))+1
 . . S ^TMP("LEXTKN",$J,LEXOKN,LEXIN)="",LEXO=1
 . . S ^TMP("LEXTKN",$J,"B",LEXIN)=""
 I LEXWITH>0 D
 . N LEXI,LEXW S LEXI=0 F  S LEXI=$O(LEXARY(LEXI)) Q:+LEXI'>0  D
 . . S LEXW=$G(LEXARY(LEXI)) Q:'$L(LEXW)
 . . I '$D(^TMP("LEXTKN",$J,"B",LEXW)) D
 . . . S LEXOKN=+($G(LEXOKN))+1
 . . . S ^TMP("LEXTKN",$J,LEXOKN,LEXW)="",LEXO=1
 . . . S ^TMP("LEXTKN",$J,"B",LEXW)=""
 Q LEXO
WITH(X,LEX,Y) ;   Parse Replacement Words (replace with)
 N LEXBEG,LEXEND,LEXCHR,LEXI,LEXNUM,LEXTXT,LEXWRD,LEXFLG
 S LEXTXT=$$UP^XLFSTR(X) S LEXFLG=+($G(Y))
 K LEX S LEXBEG=1 F LEXEND=1:1:$L(LEXTXT)+1 D
 . S LEXCHR=$E(LEXTXT,LEXEND)
 . I "~!@#$%&*()_+`-=[]{};'\:|,./?<> """[LEXCHR D
 . . S LEXWRD=$E(LEXTXT,LEXBEG,LEXEND-1),LEXBEG=LEXEND+1
 . . I $L(LEXWRD)>1,$L(LEXWRD)<31,'$$EWD(LEXWRD,LEXFLG) D
 . . . N LEXI S LEXI=$O(LEX(" "),-1)+1
 . . . S LEX(LEXI)=LEXWRD,LEX(0)=LEXI
 Q $G(LEX(0))
EWD(X,Y) ;   Exclude from Replacement Words
 N LEXW,LEXF,LEXO S LEXW=$G(X),LEXF=+($G(Y)),LEXO=0
 I LEXF=1 S:$D(^LEX(757.04,"ACTION",LEXW,"I")) LEXO=1
 I LEXF=2 S:$D(^LEX(757.04,"ACTION",LEXW,"L")) LEXO=1
 I LEXF=3 D
 . S:$D(^LEX(757.04,"ACTION",LEXW,"I")) LEXO=1
 . S:$D(^LEX(757.04,"ACTION",LEXW,"L")) LEXO=1
 I LEXF>0 S:$D(^LEX(757.04,"ACTION",LEXW,"B")) LEXO=1
 Q LEXO
SIN(X) ;   Singular
 N LEXTMP,LEXI,LEXPW,LEXPC,LEXNW,LEXNC,LEXT
 N LEXT S LEXT=$G(X) Q:$L(LEXT)'>4 ""  Q:$E(LEXT,$L(LEXT))'="S" ""
 S (X,LEXTMP)=$E(LEXT,1,($L(LEXT)-1)) Q:$D(LEXIDX) X  S X="",LEXTMP=$E(LEXT,1,($L(LEXT)-1))
 S LEXPW=$O(^LEX(757.01,"AWRD",LEXTMP),-1) S LEXNW=$O(^LEX(757.01,"AWRD",LEXTMP))
 S LEXPC="" I $E(LEXPW,$L(LEXTMP))=$E(LEXTMP,$L(LEXTMP)) S LEXPC=$E(LEXPW,($L(LEXTMP)+1))
 S LEXNC="" I $E(LEXNW,$L(LEXTMP))=$E(LEXTMP,$L(LEXTMP)) S LEXNC=$E(LEXNW,($L(LEXTMP)+1))
 S X="" I $L((LEXPC_LEXNC)),((LEXPC="S")!(LEXNC="S")) S X=LEXTMP
 I $L(LEXT)>4,$E(LEXT,$L(LEXT))="S",$E(LEXT,($L(LEXT)-1))'="S",$D(LEXLOOK) D
 . N LEXTMP S LEXTMP=$E(LEXT,1,($L(LEXT)-1))
 . I $L($G(LEXNW))>0,$L($G(LEXNW))=$L($G(LEXT)),$D(^LEX(757.01,"AWRD",LEXNW)) Q
 . S:$D(^LEX(757.01,"AWRD",LEXTMP)) X=LEXTMP
 Q X
ST ;   Show ^TMP global array
 N DA,LEXIDX,LEXLOOK,LEXLOW D ST^LEXTOKN2
 Q
