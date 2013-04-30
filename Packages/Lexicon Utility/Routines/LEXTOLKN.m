LEXTOLKN ;ISL/KER - Parse term into words ;07/17/2012
 ;;2.0;LEXICON UTILITY;**4,55,73,51**;Sep 23, 1996;Build 77
 ;               
 ; Global Variables
 ;    ^TMP("LEXTKN",$J    SACC 2.3.2.5.1
 ;               
 ; External References
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DA       Set and Killed by Fileman
 ;     LEXIDX   Set if parsing for indexing logic (LEXNDX*)
 ;     LEXLOOK  Set if parsing for Lookup logic (LEXA)
 ;     LEXLOW   Set of lower case is needed (LEXNDX2)
 ;               
 ; Returns ^TMP("LEXTKN",$J,#,WORD) containing words
 ;
 ; If LEXIDX is set, then the Excluded Words file is used 
 ; to selectively exclude words from the indexing process.
 ; 
 ; If LEXLOOK is set, then the Excluded Words file is used
 ; to selectively exclude words from the look-up process.
 ; 
 ; If LEXIDX and LEXLOOK do not exist then all words are 
 ; parsed and returned in the global array.
 ;
 ; This routine includes all of the functionality 
 ; introduced by patch LEX*2.0*51
 ; 
PT ; Entry point where DA is defined and X is unknown
 Q:'$D(DA)  S X=^LEX(757.01,DA,0)
PTX ; Entry point to parse string (X must exist)
 N LEXOK,LEXTOKS,LEXTOKS2,LEXTOKI,LEXTOKW,LEXTOLKN
 N LEXOKC,LEXOKN,LEXOKP,LEXTOKAA,LEXTOKAB,LEXTOKAC
 K ^TMP("LEXTKN",$J)
 Q:'$L($G(X))  S LEXTOKS=$TR(X,"-"," "),LEXTOKS=$TR(LEXTOKS,$C(9)," ")
 ; Remove leading blanks from string
 F LEXOKP=1:1:$L(LEXTOKS) Q:$E(LEXTOKS,LEXOKP)'[" "
 S LEXTOKS=$E(LEXTOKS,LEXOKP,$L(LEXTOKS))
 ; Remove trailing blanks from string
 F LEXOKP=$L(LEXTOKS):-1:1 Q:$E(LEXTOKS,LEXOKP)'[" "
 S LEXTOKS=$E(LEXTOKS,1,LEXOKP)
 ; Remove Punctuation (less slashes)
 S LEXTOKS=$TR(LEXTOKS,"?`~!@#$%^&*()_-+={}[]\:;,<>","                            ")
 ; Conditionally remove slashes
 S:$D(LEXIDX) LEXTOKS=$TR(LEXTOKS,"/"," ")
 S LEXTOKS=$TR(LEXTOKS,".","")
 S LEXTOKS=$TR(LEXTOKS,"""","")
 ; Swtich to UPPERCASE (lower case is not specified by LEXLOW)
 S:'$D(LEXLOW) LEXTOKS=$$UP^XLFSTR(LEXTOKS)
 ; Store in temporary array (based on space character)
 S LEXOKC=0 F LEXTOKI=1:1:$L(LEXTOKS," ") D
 . N LEXTOKW S LEXTOKW=$P(LEXTOKS," ",LEXTOKI) Q:LEXTOKW=""
 . I LEXTOKW'["/" D
 . . S LEXOKC=LEXOKC+1,LEXTOLKN(LEXOKC)=LEXTOKW
 . . S LEXTOLKN(0)=LEXOKC
 . I LEXTOKW["/"&('$D(^LEX(757.05,"B",LEXTOKW))) D  Q  ; PCH 4
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
 . ; Remove leading blanks
 . F LEXOKP=1:1:$L(LEXTOKW) Q:$E(LEXTOKW,LEXOKP)'[" "
 . S LEXTOKW=$E(LEXTOKW,LEXOKP,$L(LEXTOKW))
 . ; Remove trailing blanks
 . F LEXOKP=$L(LEXTOKW):-1:1 Q:$E(LEXTOKW,LEXOKP)'[" "
 . S LEXTOKW=$E(LEXTOKW,1,LEXOKP)
 . ; Apostrophy "S"
 . S (LEXTOKAA,LEXTOKAB,LEXTOKAC)=""
 . I LEXTOKW["'" D
 . . ; Standard Apostrophy "S"
 . . I $E(LEXTOKW,($L(LEXTOKW)-1),$L(LEXTOKW))["'S" D
 . . . S LEXTOKAA=$TR(LEXTOKW,"'",""),LEXTOKAB=$P(LEXTOKW,"'",1),LEXTOKAC=$P(LEXTOKW,"'",1)_$P(LEXTOKW,"'",2)
 . ; Pluralized/Apostrophy "S"
 . I '$L((LEXTOKAA_LEXTOKAB_LEXTOKAC)) I $E(LEXTOKW,$L(LEXTOKW))["S",$E(LEXTOKW,($L(LEXTOKW)-1))'["'" D
 . . N LEXTMP S LEXTMP=$E(LEXTOKW,1,($L(LEXTOKW)-1)) Q:'$L(LEXTMP)  S:$D(^LEX(757.01,"AWRD",LEXTMP)) LEXTOKAA=LEXTMP
 . I $L((LEXTOKAA_LEXTOKAB_LEXTOKAC)) D
 . . N LEXTMP S LEXTMP=$G(LEXTOKAA) S:'$L(LEXTMP) LEXTMP=$G(LEXTOKAB) S:$L($G(LEXTOKAB))>0&($L($G(LEXTOKAB))<$L(LEXTMP)) LEXTMP=LEXTOKAB
 . . S:'$L(LEXTMP) LEXTMP=$G(LEXTOKAC) I $L(LEXTMP),(LEXTOKAA_LEXTOKAB_LEXTOKAC)[LEXTMP S LEXTOKW=LEXTMP,(LEXTOKAA,LEXTOKAB,LEXTOKAC)=""
 . ; Apostrophies and spaces
 . S LEXTOKW=$TR(LEXTOKW,"'",""),LEXTOKW=$TR(LEXTOKW," ","")
 . ; Numeric only
 . I $D(LEXIDX) D
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"I")) LEXTOKW=""
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"B")) LEXTOKW=""
 . I $D(LEXLOOK) D
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"L")) LEXTOKW=""
 . . I LEXTOKW'="" S:$D(^LEX(757.04,"ACTION",LEXTOKW,"B")) LEXTOKW=""
 . I $D(LEXIDX),($L($G(LEXTOKAA))!($L($G(LEXTOKAB)))!($L($G(LEXTOKAC)))) D
 . . I $L(LEXTOKAA) S LEXOKN=+($G(LEXOKN))+1,^TMP("LEXTKN",$J,LEXOKN,LEXTOKAA)=""
 . . I $L(LEXTOKAB) S LEXOKN=+($G(LEXOKN))+1,^TMP("LEXTKN",$J,LEXOKN,LEXTOKAB)=""
 . . I $L(LEXTOKAC) S LEXOKN=+($G(LEXOKN))+1,^TMP("LEXTKN",$J,LEXOKN,LEXTOKAC)=""
 . I $D(LEXOKN),$D(LEXTOKW),LEXTOKW'="" D
 . . I $P($G(^LEX(757.05,+($O(^LEX(757.05,"B",LEXTOKW,0))),0)),"^",3)="R" D REP(LEXTOKW) Q
 . . S LEXOKN=+(LEXOKN)+1,^TMP("LEXTKN",$J,LEXOKN,LEXTOKW)=""
 . S LEXTOKW=""
 S ^TMP("LEXTKN",$J,0)=LEXOKN
EXIT ; Clean up and quit
 K LEXOK,LEXTOKI,LEXOKN,LEXOKP,LEXOKR,LEXTOKS,LEXTOKS2,LEXTOKW,LEXTOLKN
 Q
REP(X) ; Replace
 N LEXREP,LEXTXT,LEXREF,LEXFLG,LEXARY,LEXIN,LEXWITH,LEXI,LEXO
 S (LEXO,LEXFLG)=0,LEXIN=$G(X) Q:'$L(LEXIN)
 S:$D(LEXIDX)&'$D(LEXLOOK) LEXFLG=1
 S:'$D(LEXIDX)&$D(LEXLOOK) LEXFLG=2
 S:$D(LEXIDX)&$D(LEXLOOK) LEXFLG=3
 S LEXTXT=$P($G(^LEX(757.05,+($O(^LEX(757.05,"B",LEXIN,0))),0)),"^",2)
 S LEXWITH=$$WITH(LEXTXT,.LEXARY,LEXFLG)
 I LEXFLG=1 D
 . Q:$D(LEXLOOK)
 . S LEXOKN=+($G(LEXOKN))+1
 . S ^TMP("LEXTKN",$J,LEXOKN,LEXIN)="",LEXO=1
 I LEXWITH>0 D
 . N LEXI,LEXW S LEXI=0 F  S LEXI=$O(LEXARY(LEXI)) Q:+LEXI'>0  D
 . . S LEXW=$G(LEXARY(LEXI)) Q:'$L(LEXW)
 . . S LEXOKN=+($G(LEXOKN))+1
 . . S ^TMP("LEXTKN",$J,LEXOKN,LEXW)="",LEXO=1
 Q LEXO
WITH(X,LEXARY,Y) ; Parse Replacement Words (replace with)
 N LEXBEG,LEXEND,LEXCHR,LEXI,LEXNUM,LEXTXT,LEXWRD,LEXFLG
 S LEXTXT=$$UP^XLFSTR(X) S LEXFLG=+($G(Y))
 K LEXARY S LEXBEG=1 F LEXEND=1:1:$L(LEXTXT)+1 D
 . S LEXCHR=$E(LEXTXT,LEXEND)
 . I "~!@#$%&*()_+`-=[]{};'\:|,./?<> """[LEXCHR D
 . . S LEXWRD=$E(LEXTXT,LEXBEG,LEXEND-1),LEXBEG=LEXEND+1
 . . I $L(LEXWRD)>1,$L(LEXWRD)<31,'$$EWD(LEXWRD,LEXFLG) D
 . . . N LEXI S LEXI=$O(LEXARY(" "),-1)+1
 . . . S LEXARY(LEXI)=LEXWRD,LEXARY(0)=LEXI
 Q $G(LEXARY(0))
EWD(X,Y) ; Exclude from Replacement Words
 N LEXW,LEXF,LEXO S LEXW=$G(X),LEXF=+($G(Y)),LEXO=0
 I LEXF=1 S:$D(^LEX(757.04,"ACTION",LEXW,"I")) LEXO=1
 I LEXF=2 S:$D(^LEX(757.04,"ACTION",LEXW,"L")) LEXO=1
 I LEXF=3 D
 . S:$D(^LEX(757.04,"ACTION",LEXW,"I")) LEXO=1
 . S:$D(^LEX(757.04,"ACTION",LEXW,"L")) LEXO=1
 I LEXF>0 S:$D(^LEX(757.04,"ACTION",LEXW,"B")) LEXO=1
 Q LEXO
SH ; Show ^TMP global array
 N NN,NC S NN="^TMP(""LEXTKN"","_$J_")",NC="^TMP(""LEXTKN"","_$J_","
 F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  W !,NN,"=",@NN
 Q
