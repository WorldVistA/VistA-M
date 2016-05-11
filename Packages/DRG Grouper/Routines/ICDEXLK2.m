ICDEXLK2 ;SLC/KER - ICD Extractor - Lookup, SBR/Ask/One/Mul ;12/19/2014
 ;;18.0;DRG Grouper;**57,67,82**;Oct 20, 2000;Build 21
 ;               
 ; Global Variables
 ;    ^TMP(SUB,$J         SACC 2.3.2.5.1
 ;               
 ; External References
 ;    CLRMSG^DDS          ICR   5846
 ;    HLP^DDSMSG          ICR   5847
 ;    ^DIR                ICR  10026
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMADD^XLFDT       ICR  10103
 ;    $$UP^XLFSTR         ICR  10104
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     DDS,DIC,DICR,ICDCDT,ICDDIC0,ICDDICA,
 ;     ICDDICB,ICDDICN,ICDFMT,ICDISF,ICDOFND,
 ;     ICDOINP,ICDOREV,ICDOSEL,ICDOTIM,ICDOUPA
 ;     ICDOUT,ICDSYS,ICDVER,ICDX,INP1,INP2
 ;     
 Q
ASK ; Ask for Selection
 K X,Y N ANS S ICDOFND=+($G(ICDOFND)) Q:+ICDOFND'>0
 I ICDOFND=1,DIC(0)'["E" D  Q
 . K X,Y D X(1,SUB) S (ICDOFND,ICDOSEL,ICDOREV)=1
 . D Y($G(ROOT),+($G(^TMP(SUB,$J,"SEL",1))),$G(ICDCDT))
 . I +($G(Y))'>0,$L($G(INP)) S X=$G(INP) Q
 . I +($G(Y))>0 D:$G(DIC(0))'["F" SAV^ICDEXLK6(+($G(Y)),ROOT)
 I ICDOFND>1,DIC(0)'["E" D  Q
 . K Y S Y="-1^Selection not made" S ICDOSEL=0
 S:+ICDOFND=1 ANS=$$ONE S:+ICDOFND>1 ANS=$$MUL S ICDOSEL=0
 I ANS>0 D
 . D X(+ANS,SUB) S ICDOSEL=1
 . D Y($G(ROOT),+($G(^TMP(SUB,$J,"SEL",+ANS))),$G(ICDCDT))
 . I +($G(Y))'>0,$L($G(INP)) S X=$G(INP) Q
 . I +($G(Y))>0 D:$G(DIC(0))'["F" SAV^ICDEXLK6(+($G(Y)),ROOT)
 I ANS'>0 K INP,X,Y,^TMP(SUB,$J)
 Q
SBR ;   Space-Bar Return DIC(0) not contain "A"
 N SBI,SUB,OUT,ANS,SBS K Y S Y=-1 Q:'$L($G(ROOT))  Q:ROOT="^"  Q:'$L($G(FILE))
 S SBI=$$RET^ICDEXLK6($G(FILE)),SUB=$TR($G(ROOT),"^(","") K:$L(SUB) ^TMP(SUB,$J) Q:+SBI'>0
 S SBS=$P($G(@(ROOT_+SBI_",1)")),"^",1) Q:+SBS'>0  Q:+SBI>0&(+SBS>0)&(+($G(ICDSYS))>0)&(+($G(ICDSYS))'=+SBS)
 D FND^ICDEXLK5($G(ROOT),+SBI,$G(ICDCDT),$G(ICDSYS),$G(ICDVER),0,$G(ICDOUT))
 D SEL^ICDEXLK5(ROOT,0) Q:'$D(^TMP(SUB,$J,"SEL",1))  S ANS=$$ONE I ANS>0 D
 . D X(1,SUB) S (ICDOFND,ICDOSEL,ICDOREV)=1
 . D Y($G(ROOT),+($G(^TMP(SUB,$J,"SEL",1))),$G(ICDCDT))
 . I +($G(Y))'>0,$L($G(INP)) S X=$G(INP) Q
 . I +($G(Y))>0 D:$G(DIC(0))'["F" SAV^ICDEXLK6(+($G(Y)),ROOT)
 S:+Y>0&($L($P(Y,"^",2))) X=$P(Y,"^",2)
 I ANS'>0 K INP,X,Y,^TMP(SUB,$J) S X="",Y="-1^No user input"
 Q
ONE(X) ;   One Entry Found
 S:'$D(DDS) X=$$ONERS S:$D(DDS) X=$$ONESM S ICDOREV=1
 Q X
ONERS(X) ;     One Entry Found           Roll and Scroll
 N DIROUT,DIRUT,DIR,IEN,LN,LN2,ICDI,ICDPR,TEXT,TXT,TX,CT,Y S ICDOREV=1
 S TEXT=$G(^TMP(SUB,$J,"SEL",1)) Q:$G(DIC(0))'["E" 1
 S IEN=+TEXT,TEXT=$P(TEXT,U,2),TXT(1)=TEXT
 I $G(ICDFMT)=1!($G(ICDFMT)=2) D
 . K TX S TXT(1)=TEXT D PAR^ICDEX(.TXT,64) K TX2 F ICDI=2:1:8 D
 . . S:$L($G(TXT(ICDI))) TX2(1)=$G(TX2(1))_" "_$G(TXT(ICDI))
 . S TX(1)=$G(TXT(1)) I $D(TX2) D
 . . N SP S SP="          " D PAR^ICDEX(.TX2,54) S ICDI=0
 . . F  S ICDI=$O(TX2(ICDI)) Q:+ICDI'>0  D
 . . . N CT Q:'$L($G(TX2(ICDI)))
 . . . S CT=$O(TX(" "),-1)+1 S TX(CT)=SP_$G(TX2(ICDI))
 I $G(ICDFMT)'=1&($G(ICDFMT)'=2) D
 . K TX N ICDI D PAR^ICDEX(.TXT,64) S ICDI=0 F  S ICDI=$O(TXT(ICDI)) Q:+ICDI'>0  D
 . . N CT S CT=$O(TX(" "),-1)+1 S TX(CT)=$G(TXT(ICDI))
 S DIR("A",1)=" One match found",DIR("A",2)=" "
 S ICDI=0 F  S ICDI=$O(TX(ICDI)) Q:+ICDI'>0  D
 . Q:'$L($G(TX(ICDI)))  N CT S CT=$O(DIR("A"," "),-1)+1
 . S DIR("A",CT)=("     "_$G(TX(ICDI)))
 S CT=$O(DIR("A"," "),-1)+1,DIR("A",CT)=" ",DIR("A")="   OK?  "
 S DIR("B")="Yes",DIR(0)="YAO" W !
 S ICDPR="" I $L($G(DICR(2,1))),$L($G(DICR(1,1))) D
 . S ICDPR=DICR(1,1)_$C(34)_"B"_$C(34)_","_+IEN_")"
 I $L(ICDPR),$D(@ICDPR) D  Q 1
 . S LN=$O(DIR("A"," "),-1) I LN>0 N LN2 F LN2=1:1:(LN-1) W !,DIR("A",LN2)
 K DIROUT,DIRUT,DUOUT,DTOUT D ^DIR S:$D(DTOUT) ICDOTIM=1,Y=-1
 S:$D(DUOUT) ICDOUPA=1,Y=-1 S:$D(DIROUT) ICDOUPA=2,Y=-1
 Q:+Y>0 1
 Q -1
ONESM(X) ;     One Entry Found           ScreenMan
 N DIROUT,DIRUT,ANS,CODE,ICDMENU,IEN,ITEM,TEXT,VST S ICDOREV=1
 S ITEM=$G(^TMP(SUB,$J,"SEL",1)) Q:'$L(ITEM) -1
 S IEN=+ITEM,TEXT=$P(ITEM,U,2) S CODE=$$CODEC^ICDEX(+($G(FILE)),IEN)
 S VST=$$VST^ICDEX(+($G(FILE)),IEN,ICDCDT)
 I $L(CODE),$L(VST) S TEXT=CODE,TEXT=TEXT_$J(" ",(9-$L(TEXT)))_VST
 Q:'$L(TEXT) -1 S ICDMENU(1)=("     "_$G(TEXT)),ICDMENU(2)="   OK? Yes//  "
 S ICDMENU="ICDMENU" D HLP^DDSMSG(.ICDMENU) S ICDOREV=1
 R ANS:300 S X="" S:'$T ICDOTIM=1 S:'$L(ANS) ANS="Y" S:$G(ANS)["^" ICDOUPA=1
 S:$G(ANS)["^^" ICDOUPA=2 S:$G(ICDOTIM)=1 X="^^" S:$G(ICDOUPA)=1 X="^"
 S:$G(ICDOUPA)=2 X="^^" D CLRMSG^DDS Q:X["^" X
 S ANS=$E(ANS,1) S X=$S("^Y^y^"[("^"_ANS_"^"):1,1:-1)
 Q X
MUL(X) ;   Multiple Entries Found
 S:'$D(DDS) X=$$MULRS S:$D(DDS) X=$$MULSM
 Q X
MULRS(X) ;     Multiple Entries Found    Roll and Scroll
 Q:+($G(EXIT))>0 "^^"  N ENT,EXIT,IEN,ITEM,LEN,MAX,ROOT,SEL,TEXT,TOT,Y
 Q:$G(DIC(0))'["E" -1  S ROOT=$G(DIC),LEN=+($G(ICDDICN)) S:+LEN'>0 LEN=5
 S (MAX,ENT,SEL,EXIT)=0,U="^",TOT=$G(^TMP(SUB,$J,"SEL",0))
 S SEL=0 G:+TOT=0 MULQ W:+TOT>1 !!," ",TOT," matches found"
 F ENT=1:1:TOT Q:((SEL>0)&(SEL<ENT+1))  Q:EXIT  D  Q:EXIT
 . N ITEM,IEN,TEXT S ITEM=$G(^TMP(SUB,$J,"SEL",ENT))
 . S IEN=+ITEM,TEXT=$P(ITEM,U,2) Q:'$L(TEXT)
 . S MAX=ENT W:ENT#LEN=1 ! D MULRSW S:ENT=TOT ICDOREV=1
 . W:ENT#LEN=0 ! S:ENT#LEN=0 SEL=$$MULRSS(MAX,ENT) S:SEL["^" EXIT=1
 I ENT#LEN'=0,+SEL=0 W ! S SEL=$$MULRSS(MAX,ENT) S:SEL["^" EXIT=1
 G MULQ
 Q X
MULRSW ;       Write Multiple          Roll and Scroll
 Q:+($G(IEN))'>0  Q:'$L($G(ROOT))  Q:'$L($G(TEXT))
 N ICDI,IND,NR,TAB,TX2,TXT,Y,RT,LEN S (TAB,IND)=8
 S RT=$$ROOT^ICDEX(ROOT)
 S:+($G(ICDOUT))<3 IND=18 W !,$J(ENT,5),".",?TAB
 S:$G(DIC(0))["S"&($G(IND))>7 IND=TAB
 I +($G(ICDISF))'>0,$L($G(DIC("W"))) D  Q
 . N Y,NR D Y(ROOT,IEN,ICDCDT)
 . S NR=$G(@(RT_+IEN_",0)"))
 . W $P(NR,"^",1),"  " X DIC("W") Q
 I +($G(ICDISF))'>0,$D(DIC("W")),DIC("W")="" D  Q
 . W $P($G(@(RT_+IEN_",0)")),"^",1)
 I +($G(ICDOUT))<3 D  Q
 . N ICDI,LEN S TXT(1)=TEXT D PAR^ICDEX(.TXT,64) K TX2 F ICDI=2:1:8 D
 . . S:$L($G(TXT(ICDI))) TX2(1)=$G(TX2(1))_" "_$G(TXT(ICDI))
 . W $G(TXT(1)) I $D(TX2) D
 . . N LEN S LEN=54 S:$G(DIC(0))["S" LEN=64
 . . S:$G(DIC(0))["S" IND=TAB
 . . D PAR^ICDEX(.TX2,LEN) S ICDI=0
 . . F  S ICDI=$O(TX2(ICDI)) Q:+ICDI'>0  W !,?IND,$G(TX2(ICDI))
 S TXT(1)=TEXT
 D PAR^ICDEX(.TXT,64) S ICDI=0 F  S ICDI=$O(TXT(ICDI)) Q:+ICDI'>0  D
 . Q:'$L($G(TXT(ICDI)))  W:ICDI>1 ! W ?IND,$G(TXT(ICDI))
 Q
MULRSS(LEX,LS) ;       Select Multiple         Roll and Scroll
 Q:+($G(EXIT))>0 "^^"  N DTOUT,DUOUT,DIRUT,DIROUT,DIR,DIRB,HLP
 N LAST,MAX,NEXT,RAN,X,Y S MAX=+($G(LEX)),LAST=+($G(LS)) Q:MAX=0 -1
 S RAN=" Select 1-"_MAX_":  ",NEXT=$O(^TMP(SUB,$J,"SEL",+LAST))
 S:+NEXT>0 DIR("A")=" Press <RETURN> for more, '^' to exit, or"_RAN
 S:+NEXT'>0 DIR("A")=RAN
 S HLP="    Answer must be from 1 to "_MAX_", or <Return> to continue"
 S DIR("PRE")="S:X[""?"" X=""??"""
 S (DIR("?"),DIR("??"))="^D MULRSSH^ICDEXLK2"
 S DIR(0)="NAO^1:"_MAX_":0" K DIROUT,DIRUT,DUOUT,DTOUT D ^DIR
 S:$D(DTOUT) ICDOTIM=1,EXIT=1,Y=-1,X="^^" S:$D(DUOUT) ICDOUPA=1,Y=-1,X="^"
 S:$D(DIROUT) ICDOUPA=2,Y=-1,X="^^" S LEX=+Y S:$D(DTOUT)!(X[U) LEX=U
 Q LEX
MULRSSH ;       Select Multiple Help    Roll and Scroll
 I $L($G(HLP)) W !,$G(HLP) Q
 Q
MULSM(X) ;     Multiple Entries Found    ScreenMan
 Q:+($G(EXIT))>0 "^^"  N CODE,CTR,ENT,EXIT,ICDMENU,IEN,ITEM,LEN
 N MAX,ROOT,SEL,TEXT,TOT,VST,Y S ROOT=$G(DIC),(MAX,ENT,SEL,EXIT)=0
 S U="^",LEN=3,TOT=$G(^TMP(SUB,$J,"SEL",0)),SEL=0 G:+TOT=0 MULQ
 S CTR=0 F ENT=1:1:TOT Q:((SEL>0)&(SEL<ENT+1))  Q:EXIT  D  Q:EXIT
 . N ITEM,IEN,TEXT,CODE,VST S ITEM=$G(^TMP(SUB,$J,"SEL",ENT))
 . S IEN=+ITEM,TEXT=$P(ITEM,U,2) S CODE=$$CODEC^ICDEX(+($G(FILE)),IEN)
 . S VST=$$VST^ICDEX(+($G(FILE)),IEN,ICDCDT)
 . I $L(CODE),$L(VST) S TEXT=CODE,TEXT=TEXT_$J(" ",(9-$L(TEXT)))_VST
 . Q:'$L(TEXT)  S MAX=ENT D MULSMW S:ENT=TOT ICDOREV=1
 . S:ENT#LEN=0 SEL=$$MULSMS(MAX,ENT) S:SEL["^" EXIT=1
 K:$D(DUOUT) ICDMENU
 I ENT#LEN'=0,+SEL=0,'EXIT D
 . Q:+($G(ICDOUPA))>0  S SEL=$$MULSMS(MAX,ENT) S:SEL["^" EXIT=1
 I EXIT>0 D  G MULQ
 . D CLRMSG^DDS K ICDMENU S:$L($G(DICR("1"))) DICR("1")="^^" S:$L($G(ICDOINP)) ICDOINP="^^"
 D CLRMSG^DDS
 G MULQ
MULSMW ;       Write Multiple          ScreenMan
 Q:+($G(ENT))'>0  Q:'$L($G(TEXT))  N CTR S CTR=$O(ICDMENU(" "),-1)+1
 S ICDMENU(CTR)=$J(ENT,3)_"."_"  "_$G(TEXT)
 Q
MULSMS(LEX,LS) ;       Select Multiple         ScreenMan
 Q:+($G(EXIT))>0 "^^"  N DIROUT,DUOUT,DTOUT,DIRUT,ANS,CTR,LAST,MAX,PMT,X
 Q:'$D(ICDMENU) "^" S MAX=+($G(LEX)),LAST=+($G(LS)) Q:MAX=0 -1
 S PMT=" Select 1-"_MAX_", <RETURN> for more or '^' to exit:  "
 S CTR=$O(ICDMENU(" "),-1)+1,ICDMENU(CTR)=PMT
 S ICDMENU="ICDMENU" D HLP^DDSMSG(.ICDMENU)
 K ICDMENU R ANS:300 S X="" S:'$T ICDOTIM=1,X="^^"
 S:ANS["^" ICDOUPA=1,X="^" S:ANS["^^" ICDOUPA=2,X="^^" Q:X["^" X
 D CLRMSG^DDS S ANS=+ANS Q:ANS'>0 ""  Q:ANS>MAX ""  S X=ANS
 Q X
MULQ ;     Quit Multiple
 S X=+($G(SEL)) Q:X'>0 -1
 Q X
 ;
INP(X,VER,CDT) ; Get User Input
 Q:$G(DIC(0))'["A" ""  N DIROUT,DIRUT,DUOUT,DTOUT,DIR,DIRA,DIRB,SBR,SBT,FILE,ROOT
 S VER=+($G(VER)),CDT=+($G(CDT))
 S FILE=$G(X) Q:"^80^80.1^"'[("^"_FILE_"^") ""  S ROOT=$$ROOT^ICDEX(FILE)
 S:$L($G(ICDDICB)) DIRB=ICDDICB S:$L($G(ICDDICA)) DIRA=ICDDICA
 S:'$L($G(DIRA))&(FILE=80) DIRA=" Select ICD Diagnosis:  "
 S:'$L($G(DIRA))&(FILE=80.1) DIRA=" Select Procedure:  "
 S:'$L($G(DIRA)) DIRA=" Select ICD Text or Code:  "
 S SBT="",SBR=$$RET^ICDEXLK6($G(FILE))
 I SBR>0,VER>0,CDT?7N,$L(ROOT) D
 . N CODE,SYS,STA
 . S CODE=$G(@(ROOT_+SBR_",0)"))
 . S SYS=$P($G(@(ROOT_+SBR_",1)")),"^",1)
 . S STA=$$STATCHK^ICDEX(CODE,CDT,SYS)
 . S:STA'>0 SBR=0
 S:+SBR>0 SBT=$$LD^ICDEX(FILE,+SBR,$G(ICDCDT))
 S:$L($G(DIRB)) DIR("B")=DIRB
 S:$L($G(DIRA)) DIR("A")=DIRA W:'$L($G(DIRB)) !
 S DIR("PRE")="S X=$$INPRE^ICDEXLK2($G(X))"
 S (DIR("?"),DIR("??"))="^D INPH^ICDEXLK2($G(FILE))"
 S DIR("?")="^D INPH^ICDEXLK2($G(FILE))"
 S DIR("??")="^D INPH2^ICDEXLK2($G(FILE))"
 N Y S DIR(0)="FAO^0:245"
 K X,DIROUT,DIRUT,DUOUT,DTOUT D ^DIR
 S:$G(X)="@"&($G(Y)="") Y=$G(X)
 S:$D(DTOUT) ICDOTIM=1 S:$D(DUOUT) ICDOUPA=1 S:$D(DIROUT) ICDOUPA=2
 Q:$G(ICDOUPA)=1 "^"  Q:$G(ICDOUPA)=2 "^^"  Q:$G(ICDOTIM)>0 "^^"
 I '$L(X) S (X,ICDX,INP,INP1,INP2)="",Y=-1 Q X
 S:X=""&('$L($G(DIR("B")))) X="^" S:X["^"&(X'["^^") X="^" S:X["^^" X="^^" Q:X["^" X
 I $E(X,1)=" ",$L(SBT),+SBR>0 S X=("`"_+SBR) Q X
 W:$G(DIC(0))'["Q"&($E(X,1)'=" ")&('$D(DDS)) !
 S X=$$UP^XLFSTR($$TM(Y))
 Q X
INPH(X) ;   Input Help
 N FILE,TYPE,TMP,TXT S FILE=$G(X)
 S TYPE=$S(FILE=80:"Diagnosis ",FILE=80.1:"Procedure ",1:"")
 I '$L($G(TYPE)) D  Q
 . S TMP="Enter a term (2-245 characters in length) or a code."
 . I +($G(VER))>0 S TMP=TMP_"  Only active codes will be considered for selection."
 . S TXT(1)=TMP D PA^ICDEXLK6(.TXT,66)
 . S TMP=0 F  S TMP=$O(TXT(TMP)) Q:+TMP'>0  W !,?4,$G(TXT(TMP))
 S TMP="Enter a "_TYPE_"(2-245 characters in length) or a "_TYPE_"code."
 I +($G(VER))>0 S TMP=TMP_"  Only active "_TYPE_"codes will be considered for selection."
 S TXT(1)=TMP D PA^ICDEXLK6(.TXT,66)
 S TMP=0 F  S TMP=$O(TXT(TMP)) Q:+TMP'>0  W !,?4,$G(TXT(TMP))
 Q
INPH2(X) ;   Input Help
 N FILE,TYPE,TMP,TXT S FILE=$G(X)
 S TYPE=$S(FILE=80:"Diagnosis ",FILE=80.1:"Procedure ",1:"")
 I '$L($G(TYPE)) D  Q
 . S TMP="Enter a term (2-245 characters in length), a code or code fragment,"
 . S TMP=TMP_" phrase, or an accent grave character (`) followed by the"
 . S TMP=TMP_" IEN to select a specific entry"
 . I $G(ICDDIC0)'["F" D
 . . S TMP=TMP_", or press space bar and Enter/Return key to do a subsequent lookup of the same entry"
 . S TMP=TMP_"." I +($G(VER))>0 D
 . . S TMP=TMP_"  Only active codes will be considered for selection."
 . S TXT(1)=TMP D PA^ICDEXLK6(.TXT,66)
 . S TMP=0 F  S TMP=$O(TXT(TMP)) Q:+TMP'>0  W !,?4,$G(TXT(TMP))
 S TMP="Enter a "_TYPE_"name"
 S TMP=TMP_" (2-245 characters in length), a "_TYPE_"code or code fragment,"
 S TMP=TMP_" one or more keywords sufficient to select a "_TYPE
 S TMP=TMP_" name, or an accent grave character (`) followed by the"
 S TMP=TMP_" IEN to select a specific entry"
 I $G(ICDDIC0)'["F" D
 . S TMP=TMP_", or press space bar and Enter/Return key to do a subsequent lookup of the same entry"
 S TMP=TMP_"." I +($G(VER))>0 D
 . S TMP=TMP_"  Only active "_TYPE_"codes will be considered for selection."
 S TXT(1)=TMP D PA^ICDEXLK6(.TXT,66)
 S TMP=0 F  S TMP=$O(TXT(TMP)) Q:+TMP'>0  W !,?4,$G(TXT(TMP))
 Q
INPRE(X) ;   Input Pre-Processing
 Q:'$L($G(X)) ""  N IN,IN1,IN2 S IN=$G(X)
 Q:IN["??" "??"  Q:IN["?" "?"
 S IN1=$E(IN,1),IN2=$E(IN,2,$L(IN))
 I IN1["`",IN2?1N.N,$L($G(ROOT)) D  Q X
 . Q:IN1="`"&(IN2?1N.N)&($D(@(ROOT_+IN2_",0)")))  S X="??"
 I $L($G(ROOT)) I IN1=" ",'$L(IN2) D  Q:$E(X,1)="`"!($E(X,1)="?") X
 . N FI,CODE,SYS,STA,ND,SB,OUT S FI=$$FILE^ICDEX(ROOT)
 . Q:+FI'>0  S SB=$$RET^ICDEXLK6($G(FILE))
 . I SB>0,+($G(VER))'>0 S X="`"_+SB Q
 . I SB>0,+($G(VER))>0,+($G(CDT))?7N,$L(ROOT) D
 . . N CODE,SYS,STA
 . . S CODE=$G(@(ROOT_+SB_",0)")) Q:'$L(CODE)
 . . S SYS=$P($G(@(ROOT_+SB_",1)")),"^",1) Q:+SYS'>0
 . . S STA=$$STATCHK^ICDEX(CODE,CDT,SYS)
 . . S:STA'>0 SB=0 S:+SB>0 X="`"_+SB S:+SB'>0 X="??"
 Q X
 ;            
 ; Miscellaneous
OUT(X,Y,FMT,ARY) ;   Output Array
 K ARY N FILE,TERM,ROOT,IEN S ROOT=$G(X),IEN=+($G(Y)) Q:'$L(ROOT)
 Q:"^ICD9(^ICD0(^"'[("^"_$E(ROOT,2,$L(ROOT))_"^")
 S FILE=$$FILE^ICDEX(ROOT) Q:"^80^80.1^"'[("^"_FILE_"^")
 S FMT=+($G(FMT)) S:FMT'>0 FMT=1 S:FMT>4 FMT=1 Q:'$D(@(ROOT_IEN_",0)"))
 I +($G(FMT))=1!(+($G(FMT))=3) S TERM=$$SD^ICDEX(FILE,IEN,CDT)
 I +($G(FMT))=2!(+($G(FMT))=4) S TERM=$$LD^ICDEX(FILE,IEN,CDT)
 Q:'$L(TERM)  Q:$P(TERM,"^",1)=-1  S ARY(1)=TERM Q:+($G(FMT))=1!(+($G(FMT))=3)
 D:+($G(FMT))=2 PAR^ICDEX(.ARY,60) D:+($G(FMT))=4 PAR^ICDEX(.ARY,70)
 Q
TM(X,Y) ;   Trim Y
 S Y=$G(Y) S:'$L(Y) Y=" "
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
X(SEL,SUB) ;   Set X
 K X N IEN S SEL=+($G(SEL)),SUB=$G(SUB) Q:'$L(SUB)
 S IEN=$G(^TMP(SUB,$J,"SEL",+SEL)) Q:+IEN'>0  S X=+IEN
 Q
Y(ROOT,IEN,CDT,FMT) ;   Set Y
 ;
 ; Input
 ; 
 ;    ROOT  Global Root (DIC) or File Number
 ;    IEN   Internal Entry Number
 ;    CDT   Versioning Date (default TODAY)
 ;    FMT   Format of Output
 ;            0  Standard Fileman Y   IEN ^ CODE
 ;            1  Expanded Y as if DIC(0) contained a "Z" 
 ; Output
 ;
 ;    Y     IEN ^ Code           Fileman
 ;    
 ;    If DIC(0) contains "Z" or input parameter FMT > 0
 ;    
 ;       Y(0)     0 Node (Code)        Fileman
 ;       Y(0,0)   .01 Field (Code)     Fileman
 ;       Y(0,1)   $$ICDDX or $$ICDOP   Non-Fileman
 ;       Y(0,2)   Long Description     Non-Fileman
 ;       
 N CODE,NODE0,FILE,SHORT,FDAT,LONG,ICD10 K Y S Y=-1
 S:+($G(ICDOFND))>0&(+($G(ICDOSEL))'>0) Y="-1^No selection made"
 S IEN=+($G(IEN)),ROOT=$G(ROOT),CDT=+($G(CDT))
 S:CDT'?7N CDT=$$DT^XLFDT S ICD10=+($$IMP^ICDEX(30))
 S ROOT=$$ROOT^ICDEX(ROOT) Q:'$L(ROOT)
 S FILE=$$FILE^ICDEX(ROOT) Q:+FILE'>0
 S NODE0=$G(@(ROOT_+IEN_",0)")) Q:'$L(NODE0)
 S CODE=$$CODEC^ICDEX(FILE,IEN) Q:'$L(CODE)
 S SHORT=$$SD^ICDEX(FILE,IEN,CDT) Q:'$L(SHORT)
 S FMT=+($G(FMT)) I $P(SHORT,"^",1)=-1 D  Q:'$L(SHORT)
 . S SHORT=$$SD^ICDEX(FILE,IEN,ICD10)
 . S:$P(SHORT,"^",1)=-1 SHORT="" Q:'$L(SHORT)
 . S SHORT=SHORT_" (Pending - "_$$FMTE^XLFDT($$IMP^ICDEX(30))_")"
 S Y=+IEN_"^"_CODE
 S:$G(DIC(0))["Z"!(+FMT>0) Y(0)=NODE0
 S CODE=$P(NODE0,"^",1) Q:'$L(CODE)
 S:FILE=80 FDAT=$$ICDDX^ICDEX(CODE,CDT,,"E")
 S:FILE=80.1 FDAT=$$ICDOP^ICDEX(CODE,CDT,,"E")
 S LONG=$$LD^ICDEX(ROOT,IEN,CDT)
 S:$G(DIC(0))["Z"!(+FMT>0) Y(0,0)=CODE
 S:$L(FDAT)&($L(LONG))&($G(DIC(0))["Z")!(+FMT>0) Y(0,1)=FDAT,Y(0,2)=LONG
 Q
SH ;   Show TMP
 N SUB,NN,NC S SUB="ICD9" S:'$D(^TMP(SUB)) SUB="ICD0" Q:'$D(^TMP(SUB))
 S NN="^TMP("""_SUB_""","_$J_")",NC="^TMP("""_SUB_""","_$J_","
 W:'$D(@NN) ! Q:'$D(@NN)  F  S NN=$Q(@NN) Q:'$L(NN)!(NN'[NC)  W !,NN,"=",@NN
 W !
 Q
