LEXXMC ;ISL/KER - Convert Text to Mix Case ;10/10/2017
 ;;2.0;Lexicon Utility;**103,114**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^LEX(757.07          SACC 1.3
 ;               
 ; External References
 ;    None
 ;               
 ; Replaces Integrated Control Registration #5781 $$MIX^LEXXM(X)
 ; (released in LEX*2.0*80, Jun 17, 2014) which converts UPPERCASE
 ; to Mix Case Text.
 ; 
 ; Old API                    New API
 ; $$MIX^LEXXM(X)             $$MIX^LEXXMC(X)
 ; Hard Coded Rules           Database of Rules
 ; Extremely hard to update   Update in Quarterly patch
 ; Rules in LEXXM*            Rules in ^LEX(757.07)
 ; 
 ; The old API $$MIX^LEXXM will be re-directed to $$MIX^LEXXMC
 ;
MIX(TEXT) ; Mixed Case Expression
 ;
 ;   Input
 ;
 ;     TEXT     Text, any case (Required)
 ;
 ;   Output
 ;
 ;     $$MIX    Text, Mixed Case
 ;               
 N AAA,ABR,AFTER,AR,ARRAY,ARY,ASC,BEFORE,C,CAS,CC,CCTR,CH,CHR,COND,CT,CTL,CUR,DIFF,EXEC,EXP,FULL,HA,HN,I,L,LD,LEX,LEX2
 N LEXR1,LEXR2,LEXT,LEXW,ND,NPT,NXT,OIEN,ORG,OUT,P1,P2,PC,PPT,PRE,PS,PSN,REP,RP,RUL,RULE,S,SPC,ST,TA,TC,TEST,TIEN,TK
 N TKN,TOKEN,TR,TRUE,TXT,UEX,WI,WIT,WT,X,Y K:$D(TOKEN) RULE,FULL Q:'$L($G(TEXT)) ""
 S TEXT=$$DBLS($TR($G(TEXT),"""","'")),TEXT=$$CTL($G(TEXT)),TEXT=$$SPELL(TEXT),(ORG,EXP)=$$IEEG($G(TEXT))
 I '$L($G(EXP)) S TEXT=ORG Q $TR(TEXT,"""","'")
 ;  Save Before Expression
 S BEFORE=ORG,UEX=$$UP(ORG)
 ;  Parse
 K TA D PR(EXP,.TA)
 ;  Loop through Words
 S TC=0 F  S TC=$O(TA(TC)) Q:+TC'>0  D
 . N CUR,CTL,PRE,NXT,PPT,NPT,TIEN,TRUE S TRUE=0
 . ;     Current Word
 . S CUR=$G(TA(TC)),CTL=$$UP(CUR) Q:'$L(CTL)
 . ;     Previous Word
 . S PRE=$G(TA((TC-1)))
 . ;     Next Word
 . S NXT=$G(TA((TC+1)))
 . ;     Previous Punctuation
 . S PPT=$O(TA((TC-1),"B"," "),-1)
 . S PPT=$S(+PPT>0:$G(TA((TC-1),"B",+PPT)),1:"")
 . ;     Special condition for the letter S and ' or (
 . S:CTL="S" PPT=$G(TA((TC-1),"B",1))
 . ;     Next Punctuation
 . S NPT=$G(TA(TC,"B",1))
 . ;     Token IEN
 . S TIEN=$O(^LEX(757.07,"B",CTL,0))
 . ;     Token not found, use mask/mix case
 . I '$D(^LEX(757.07,"B",CTL))!(TIEN'>0) D  Q
 . . D TOK S:+($G(TRUE))>0&($L($G(OUT))) TA(TC)=OUT S:+($G(TRUE))'>0 TA(TC)=$$MX(CUR)
 . D DSP1
 . I +($G(TRUE))'>0,+($G(TIEN))>0 D
 . . ;     Loop through Rules
 . . N AAA,OIEN,OUT S OUT=CUR
 . . S (OIEN,TRUE)=0 F  S OIEN=$O(^LEX(757.07,TIEN,1,OIEN)) Q:OIEN'>0  Q:TRUE>0  D  Q:TRUE>0
 . . . Q:+($G(TRUE))>0  N COND,CCTR,CAS,SPC S CCTR=0
 . . . S CAS=$P($G(^LEX(757.07,+TIEN,1,+OIEN,0)),"^",2)
 . . . S SPC=$P($G(^LEX(757.07,+TIEN,1,+OIEN,0)),"^",3)
 . . . S:$G(CAS)="S" TA(TC,"S")=""
 . . . ;       1st Condition - Based on Expression
 . . . D EXP Q:+($G(TRUE))>0
 . . . ;       2nd Condition - Based on Previous Word
 . . . D PRE Q:+($G(TRUE))>0
 . . . ;       3rd Condition - Based on Next Word
 . . . D NXT Q:+($G(TRUE))>0
 . . . ;       No Conditions
 . . . D NON Q:+($G(TRUE))>0
 . . . ;       Token
 . . . D TOK Q:+($G(TRUE))>0
 . . ;     Default Mix Case
 . . S:TRUE'>0&(OUT=CUR) OUT=$$MX(CUR)
 . . D DSP4("END")
 . . S TA(TC)=OUT
 ;  Special Conditions - Pre-Assmebly
 D PREA
 ;  Assemble After Expression
 D ASEM,DSP2
 S TEXT=$G(AFTER) S:'$L(TEXT) TEXT=ORG S TEXT=$$PS(TEXT)
 Q $TR(TEXT,"""","'")
 ;
EXP ; Expression Rules
 ;   
 ;   Example:   If an expression contains the words "OPERATING
 ;              ROOM" then the word "OR" will be in uppercase.
 Q:'$L($G(CUR))  Q:'$L($G(CAS))  Q:'$L($G(SPC))  Q:+($G(TIEN))'>0  Q:+($G(OIEN))'>0  Q:'$L($G(EXP))
 N COND S COND=$G(^LEX(757.07,+($G(TIEN)),1,+($G(OIEN)),1)) S:$L(COND) CCTR=+($G(CCTR))+1
 I $L($G(EXP)),$L(COND) D  Q:+($G(TRUE))>0
 . N EXEC,X S X=$$UP($G(EXP)) X COND S TRUE=$T
 . I +($G(TRUE))>0 S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 . D DSP3("EXP")
 Q
 ;
PRE ; Previous Word Rules
 ;   
 ;   Example:   If the previous word is numeric or "PER" 
 ;              then the word "OZ" will be in lower case.
 Q:'$L($G(CUR))  Q:'$L($G(CAS))  Q:'$L($G(SPC))  Q:+($G(TIEN))'>0  Q:+($G(OIEN))'>0  Q:'$L(($G(PRE)_$G(PPT)))
 N COND S COND=$G(^LEX(757.07,+($G(TIEN)),1,+($G(OIEN)),2)) S:$L(COND) CCTR=+($G(CCTR))+1
 I $L($G(PRE)),$L(COND) D  Q:TRUE>0
 . N EXEC,X S X=$$UP($G(PRE)) X COND S TRUE=$T
 . I +($G(TRUE))>0 S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 . D DSP3("PRE")
 I $L($G(PPT)),$L(COND) D  Q:TRUE>0
 . N EXEC,X S X=$G(PPT) X COND S TRUE=$T
 . I +($G(TRUE))>0 S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 . D DSP3("PPT")
 Q
 ;
NXT ; Next Word Rules
 ;
 ;   Example:   If the next word contains "POSITIVE" or
 ;              "NEGATIVE" then the word "ABL" will be 
 ;              in uppercase.
 Q:'$L($G(CUR))  Q:'$L($G(CAS))  Q:'$L($G(SPC))  Q:+($G(TIEN))'>0  Q:+($G(OIEN))'>0
 N COND S COND=$G(^LEX(757.07,+($G(TIEN)),1,+($G(OIEN)),3)) S:$L(COND) CCTR=+($G(CCTR))+1
 Q:'$L(($G(NXT)_$G(NPT)))  I $L($G(NXT)),$L(COND) D  Q:TRUE>0
 . N EXEC,X S X=$$UP($G(NXT)) X COND S TRUE=$T
 . I +($G(TRUE))>0 S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 . D DSP3("NXT")
 I $L($G(NPT)),$L(COND) D  Q:TRUE>0
 . N EXEC,X S X=$G(NPT) X COND S TRUE=$T
 . I +($G(TRUE))>0 S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 . D DSP3("NPT")
 Q
 ;
NON ; No Rules (default)
 ;
 ;   Example:   If the rules for the expression, the previous
 ;              word and the next word fail (false) and there
 ;              is a default case value then that case will 
 ;              be used.
 ;             
 ;                U   UPPERCASE      COPD
 ;                L   lower case     between
 ;                M   Mixed Case     Diabetes
 ;                S   Special Case   IgE
 Q:+($G(TRUE))>0  Q:+($G(CCTR))>0  Q:'$L($G(CUR))  Q:'$L($G(CAS))  Q:'$L($G(SPC))
 N EXEC S OUT=$$CAS($G(CUR),$G(CAS),$G(SPC))
 S TRUE=1 D DSP3("NON")
 Q
 ;
TOK ; Token/Word Rules
 ;
 ;   Examples:  If a word is an ordinal number (1st, 2nd, etc.)
 ;              then the word will be in lower case.
 ;             
 ;              If a word is alpha numeric then the word will
 ;              be in upper case.
 ;             
 ;              If a word is preceded or followed by a dash "-"
 ;              then the word will be upper case.
 Q:+($G(TRUE))>0  Q:'$L($G(CUR))
 N AAA,CAS,COND,OIEN,SPC,TIEN,HA,HN,CH S (HA,HN)=0,AAA=$$RP("*",$L(CUR)) Q:AAA'["*"
 F CH=1:1:$L(CUR) S:$E(CUR,CH)?1A HA=1 S:$E(CUR,CH)?1N HN=1
 S TIEN=$O(^LEX(757.07,"B",AAA,0)) I TIEN'>0,HA>0,HN>0 S OUT=$$UP(CUR),TRUE=1 Q
 Q:TIEN'>0  S (TRUE,OIEN)=0
 F  S OIEN=$O(^LEX(757.07,TIEN,1,OIEN)) Q:+OIEN'>0  Q:TRUE>0  D  Q:TRUE>0
 . N COND,CAS,EXEC,SPC S CAS=$P($G(^LEX(757.07,+TIEN,1,+OIEN,0)),"^",2),SPC=$P($G(^LEX(757.07,+TIEN,1,+OIEN,0)),"^",3)
 . S COND=$G(^LEX(757.07,+TIEN,1,+OIEN,1)),X=$$UP(CUR)
 . I $L(COND) X COND S TRUE=$T
 . I TRUE>0 S OUT=$$CAS(CUR,CAS,SPC)
 . D DSP3("TOK")
 Q
 ; Displays used for testing Case Rules
DSP1 ;   Display Components
 Q:'$D(TEST)  Q:$D(TOKEN)  Q:$D(ARRAY)  Q:'$D(FULL)
 W !!,"CUR:  ",$G(CUR),!,"PRE:  ",$G(PRE),!,"NXT:  ",$G(NXT),!,"PPT:  ",$G(PPT),!,"NPT:  ",$G(NPT) N FULL,DIFF,ARRAY
 Q
DSP2 ;   Display Changes (Differences)
 Q:'$D(TEST)  N EXEC I $D(FULL),$D(ARRAY) D
 . N AR S AR="TA(0)" F  S AR=$Q(@AR) Q:'$L(AR)!($E(AR,1,2)'="TA")  W AR,"=",@AR,!
 I '$D(DIFF),'$D(ARRAY) W !!,"Before:  ",BEFORE,!,"After:   ",AFTER
 I $D(DIFF),'$D(ARRAY),BEFORE'=AFTER W !!,"Before:  ",BEFORE,!,"After:   ",AFTER
 W:$D(ARRAY) !,AFTER N ARRAY,DIFF,FULL,TEST
 Q
DSP3(X) ;   Display Conditions #1
 Q:'$D(TEST)  Q:'$D(RULE)  Q:$D(TOKEN)
 W !!,"X:     ",$G(X),!,"CUR:   ",$G(CUR),!,"CAS:   ",$G(CAS),!,"SPC:   ",$G(SPC),!,"TRUE:  ",$G(PPT),!,"OUT:   ",$G(OUT),!
 N TEST,RULE,TOKEN
 Q
DSP4(X) ;   Display Conditions #2
 Q:'$D(TEST)  Q:'$D(RULE)  Q:$D(TOKEN)  W !!,"X:     ",$G(X),!,"TRUE:  ",$G(PPT),!,"OUT:   ",$G(OUT),!
 N TEST,RULE,TOKEN
 Q
 ; 
 ; Spelling
SPELL(X) ;   Known Spelling Errors
 F Y="Pe-ripheral^Peripheral","us-ing^using","Intralu-minal^Intraluminal","Ap-proach^Approach","Endo-scopic^Endoscopic" S:$$SP(X,Y)>0 X=$$SW(X,Y)
 F Y="Technolo-gy^Technology","CR (E)St^CREST","CR(E)St^CREST" S:$$SP(X,Y)>0 X=$$SW(X,Y)
 Q X
SP(X,Y) ;   Contains Spelling Error
 Q:'$L($G(X)) 0  S Y=$P($G(Y),"^",1) Q:'$L($G(Y)) 0
 Q:$$UP^XLFSTR(X)[$$UP^XLFSTR(Y) 1
 Q 0
SW(X,Y) ;   Swap Spelling
 N TXT,RP,WT S TXT=$G(X),RP=$G(Y),WT=$P(RP,"^",2),RP=$P(RP,"^",1) S X=TXT Q:'$L(RP) X  Q:'$L(WT) X
 S RP=$$UP^XLFSTR($E(RP,1))_$$LOW^XLFSTR($E(RP,2,$L(RP))) S WT=$$UP^XLFSTR($E(WT,1))_$$LOW^XLFSTR($E(WT,2,$L(WT)))
 F  Q:TXT'[RP  S TXT=$P(TXT,RP,1)_WT_$P(TXT,RP,2,4000)
 S RP=$$UP^XLFSTR(RP),WT=$$UP^XLFSTR(WT) F  Q:TXT'[RP  S TXT=$P(TXT,RP,1)_WT_$P(TXT,RP,2,4000)
 S RP=$$LOW^XLFSTR(RP),WT=$$LOW^XLFSTR(WT) F  Q:TXT'[RP  S TXT=$P(TXT,RP,1)_WT_$P(TXT,RP,2,4000)
 S X=TXT
 Q X
 ; 
 ; Assembly
PREA ;   Pre-assembly
 N Y,TC S TC=0 F  S TC=$O(TA(TC)) Q:+TC'>0  D
 . I $$UP($G(TA(TC)))="PRE" S:$G(TA(TC,"B",1))="-"&($E($G(TA((TC+1))),1)?1U) TA(TC)=$$MX($G(TA(TC)))
 Q:'$L($G(UEX))  F Y="ACTINIUM^Actinium","ALUMINUM^Aluminum","ANTIMONY^Antimony","ARSENIC^Arsenic","BARIUM^Barium","BERYLLIUM^Beryllium","BISMUTH^Bismuth" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="BROMINE^Bromine","BUDESONIDE^Budesonide","CADMIUM^Cadmium","CALCIUM^Calcium","CARBON^Carbon","CESIUM^Cesium","CHLORINE^Chlorine" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="CHROMIUM^Chromium","COBALT^Cobalt","COPPER^Copper","GALLIUM^Gallium","GERMANIUM^Germanium","HAFNIUM^Hafnium","INDIUM^Indium" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="IODINE^Iodine","IRIDIUM^Iridium","KRYPTON^Krypton","LEAD^Lead","LUTETIUM^Lutetium","MANGANESE^Manganese","MERCURY^Mercury","NICKEL^Nickel" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="OSMIUM^Osmium","OXYGEN^Oxygen","PLATINUM^Platinum","POTASSIUM^Potassium","RADON^Radon","RHODIUM^Rhodium","RUBIDIUM^Rubidium","RUTHENIUM^Ruthenium" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="SELENIUM^Selenium","SILICON^Silicon","SILVER^Silver","SODIUM^Sodium","STRONTIUM^Strontium","SULFUR^Sulfur","TANTALUM^Tantalum","THALLIUM^Thallium" D:UEX[$P(Y,"^",1) PRES(Y)
 F Y="THORIUM^Thorium","TITANIUM^Titanium","TUNGSTEN^Tungsten","URANIUM^Uranium","VANADIUM^Vanadium","XENON^Xenon","YTTRIUM^Yttrium","ZIRCONIUM^Zirconium" D:UEX[$P(Y,"^",1) PRES(Y)
 Q
PRES(X) ;   Pre-assembly Swap text
 N RP,WI,TC S RP=$P($G(X),"^",1),WI=$P($G(X),"^",2) Q:'$L(RP)  S TC=0 F  S TC=$O(TA(TC)) Q:+TC'>0  D
 . N X S X=$G(TA(TC)) Q:X'[RP  Q:$L(X)'>3  F  Q:X'[RP  S X=$P(X,RP,1)_WI_$P(X,RP,2,4000)
 . S TA(TC)=X
 Q
ASEM ;   Final Assembly
 S AFTER="" S TC=0 F  S TC=$O(TA(TC)) Q:+TC'>0  D
 . S AFTER=AFTER_$G(TA(TC))
 . N CC S CC=0 F  S CC=$O(TA(TC,"B",CC)) Q:+CC'>0  D
 . . S AFTER=AFTER_$G(TA(TC,"B",CC))
 S:'$D(TA(1,"S")) AFTER=$$UP($E(AFTER,1))_$E(AFTER,2,$L(AFTER))
 F Y="CR (E)St^CR(E)ST","CR (E)ST^CREST","CR(E)ST^CREST","  ^ ","Vertebra (E)^Vertebra(e)" I AFTER[$P(Y,"^",1) D
 . N RP,WI S RP=$P($G(Y),"^",1),WI=$P($G(Y),"^",2) Q:'$L(RP)
 . F  Q:AFTER'[RP  S AFTER=$P(AFTER,RP,1)_WI_$P(AFTER,RP,2,4000)
 I $E(AFTER,$L(AFTER))="a",$E(AFTER,($L(AFTER)-1))=" " D
 . S AFTER=$E(AFTER,1,($L(AFTER)-2))_" A"
 Q
 ;
 ; Miscellaneous
IEEG(X) ;   I.E. and E.G.
 S X=$G(X) N TK F TK="IE^ie","I.E.^ie","I.E^ie","I.e.^ie","I.e^ie","i.e.^ie","i.e^ie","E.G.^eg","E.G^eg","E.g.^eg","E.g^eg","e.g.^eg","e.g^eg" D
 . N RP,WI S RP=$P(TK,"^",1),WI=$P(TK,"^",2) F  Q:X'[RP  S X=$P(X,RP,1)_WI_$P(X,RP,2,4000)
 Q X
AABR(X) ;   Abbreviation
 N TIEN,OIEN,ABR,TKN S TIEN=+($G(X)),ABR="",OIEN=0
 S TKN=$P($G(^LEX(757.07,+TIEN,0)),"^",1) Q:$E(TKN,1)="*" 0  Q:$E(TKN,1)?1N 0  Q:$L(TKN)'>1 0
 F  S OIEN=$O(^LEX(757.07,+TIEN,1,OIEN)) Q:+OIEN'>0  D
 . N ND,CAS,RUL S ND=$G(^LEX(757.07,+TIEN,1,+OIEN,0)),CAS=$P(ND,"^",2) Q:CAS="L"
 . S RUL=$G(^LEX(757.07,+TIEN,1,+OIEN,1)) Q:$L(RUL)
 . S RUL=$G(^LEX(757.07,+TIEN,1,+OIEN,2)) Q:$L(RUL)
 . S RUL=$G(^LEX(757.07,+TIEN,1,+OIEN,3)) Q:$L(RUL)
 . S ABR=ABR_CAS
 S X=0 S:ABR["U"!(ABR["S") X=1
 Q X
PR(X,ARY) ;   Parse Expression into Tokens
 N CTL,EXP,CUR,PRE,TC,CT,OUT,P1,ST,P2,PC S EXP=$G(X) K ARY
 S CTL="^ ^!^@^#^$^%^^^&^*^(^)^_^+^-^=^{^}^|^[^]^\^:^""^;^'^<^>^?^,^.^/^"
 S (CUR,PRE)="",TC=1,CT=0,(OUT,P1,ST,P2)="" F PC=1:1:$L(EXP) D
 . N CHR S (CUR,CHR)=$E(EXP,PC)
 . I CTL'[("^"_CHR_"^") D  Q
 . . S ARY(+TC)=$G(ARY(+TC))_CHR S PRE=CUR
 . I CTL[("^"_CHR_"^") D  Q
 . . N CC,NXT S CC=$O(ARY(+TC,"B"," "),-1)+1
 . . S ARY(+TC,"B",CC)=CHR
 . . S NXT=$E(EXP,(PC+1))
 . . I $L(NXT),CTL'[("^"_NXT_"^") S TC=TC+1
 . . S PRE=CUR
 S TC=0 F  S TC=$O(ARY(TC)) Q:+TC'>0  D
 . N TKN S TKN=$G(ARY(TC)) S:$L(TKN) ARY(TC,"O")=TKN
 Q
 ;
CAS(X,Y,S) ;   Case
 S X=$G(X),Y=$G(Y),S=$G(S)
 S:Y="L" X=$$LO(X) S:Y="U" X=$$UP(X) S:Y="M" X=$$MX(X) S:Y="S" X=S
 Q X
MX(X) ;   Mix Case
 Q $$UP($E($G(X),1))_$$LO($E($G(X),2,$L($G(X))))
PS(X) ;   Period Space
 S X=$G(X) Q:$D(A5ALEX) X I X[". " F I=1:1:($L(X,". ")-1) D
 . N LD,TR,PS S PS=". ",LD=$P(X,PS,1,I),TR=$$TM($P(X,PS,(I+1),$L(X)))
 . S X=LD_". "_$$UP($E($G(TR),1))_$E($G(TR),2,$L($G(TR)))
 N A5ALEX
 Q X
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
LO(X) ;   Lower Case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
TM(X,Y) ;   Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
RP(X,Y) ;   Repeat
 N C,L S C=$G(X),L=+($G(Y)) Q:$L(C)*L>245 ""  S X="",$P(X,C,$G(L)+1)=""
 Q X
CTL(X) ;   Remove/Replace Control Characters
 S X=$G(X) Q:'$L(X) ""  N OUT,PSN,CHR,ASC,REP,WIT
 ;     Curved Apostrophe
 F CHR=145,146 S REP=$C(CHR),WIT="'" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter e
 F CHR=130,136,137,138 S REP=$C(CHR),WIT="e" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter c 
 F CHR=128,135 S REP=$C(CHR),WIT="c" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter u 
 F CHR=129,151,163 S REP=$C(CHR),WIT="u" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter a 
 F CHR=131,132,133,134,143,145,160,166 S REP=$C(CHR),WIT="a" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter i
 F CHR=139,140,141 S REP=$C(CHR),WIT="i" S X=$$CTLR(X,REP,WIT)
 ;     Accented letter o 
 F CHR=147,148,149,153,162 S REP=$C(CHR),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     En dash
 S REP=$C(150),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     Inverted exclamation mark
 S REP=$C(161),WIT="a" S X=$$CTLR(X,REP,WIT)
 ;     Currency sign
 S REP=$C(164),WIT="a" S X=$$CTLR(X,REP,WIT)
 ;     Section Sing (double S)
 S REP=$C(167),WIT="c" S X=$$CTLR(X,REP,WIT)
 ;     Spacing diaeresis - umlaut
 S REP=$C(168),WIT="e" S X=$$CTLR(X,REP,WIT)
 ;     Copyright sign
 S REP=$C(169),WIT="e" S X=$$CTLR(X,REP,WIT)
 ;     Left double angle quotes
 S REP=$C(171),WIT="e" S X=$$CTLR(X,REP,WIT)
 ;     Pilcrow sign - paragraph sign
 S REP=$C(182),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     Spacing cedilla
 S REP=$C(184),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     One Fourth Fraction
 S REP=$C(188),WIT="u" S X=$$CTLR(X,REP,WIT)
 ;     Small letter a with circumflex
 S REP=$C(226),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     HTML En Dash
 S REP=$C(8211),WIT="o" S X=$$CTLR(X,REP,WIT)
 ;     Extended ASCII Vowels
 S REP=$C(142),WIT="Z" S X=$$CTLR(X,REP,WIT)
 S REP=$C(156),WIT="oe" S X=$$CTLR(X,REP,WIT)
 S REP=$C(158),WIT="z" S X=$$CTLR(X,REP,WIT)
 S REP=$C(159),WIT="Y" S X=$$CTLR(X,REP,WIT)
 F CHR=192,193,194,195,196,197 S REP=$C(CHR),WIT="A" S X=$$CTLR(X,REP,WIT)
 S REP=$C(198),WIT="AE" S X=$$CTLR(X,REP,WIT)
 S REP=$C(199),WIT="C" S X=$$CTLR(X,REP,WIT)
 F CHR=200,201,202,203 S REP=$C(CHR),WIT="E" S X=$$CTLR(X,REP,WIT)
 F CHR=204,205,206,207 S REP=$C(CHR),WIT="I" S X=$$CTLR(X,REP,WIT)
 S REP=$C(208),WIT="ETH" S X=$$CTLR(X,REP,WIT)
 S REP=$C(209),WIT="N" S X=$$CTLR(X,REP,WIT)
 F CHR=210,211,212,213,214,216 S REP=$C(CHR),WIT="O" S X=$$CTLR(X,REP,WIT)
 F CHR=217,218,219,220 S REP=$C(CHR),WIT="U" S X=$$CTLR(X,REP,WIT)
 S REP=$C(221),WIT="Y" S X=$$CTLR(X,REP,WIT)
 F CHR=154,223 S REP=$C(CHR),WIT="s" S X=$$CTLR(X,REP,WIT)
 F CHR=224,225,226,227,228,229 S REP=$C(CHR),WIT="a" S X=$$CTLR(X,REP,WIT)
 S REP=$C(230),WIT="ae" S X=$$CTLR(X,REP,WIT)
 S REP=$C(231),WIT="c" S X=$$CTLR(X,REP,WIT)
 F CHR=232,233,234,235 S REP=$C(CHR),WIT="e" S X=$$CTLR(X,REP,WIT)
 F CHR=236,237,238,239 S REP=$C(CHR),WIT="i" S X=$$CTLR(X,REP,WIT)
 S REP=$C(240),WIT="eth" S X=$$CTLR(X,REP,WIT)
 S REP=$C(241),WIT="n" S X=$$CTLR(X,REP,WIT)
 F CHR=242,243,244,245,246,248 S REP=$C(CHR),WIT="o" S X=$$CTLR(X,REP,WIT)
 F CHR=249,250,251,252 S REP=$C(CHR),WIT="u" S X=$$CTLR(X,REP,WIT)
 F CHR=253,255 S REP=$C(CHR),WIT="y" S X=$$CTLR(X,REP,WIT)
 ;     All others (remove)
 S OUT="" F PSN=1:1:$L(X) S CHR=$E(X,PSN),ASC=$A(CHR) S:ASC>31&(ASC<127) OUT=OUT_CHR
 ;     Uppercase leading character
 S X=$$UP^XLFSTR($E(OUT,1))_$E(OUT,2,$L(OUT))
 Q X
DBLS(X) ;   Double Space/Special Characters
 S X=$G(X) Q:(X'["  ")&(X'["^") X
 F  S X=$P(X,"  ",1)_" "_$P(X,"  ",2,300) Q:X'["  "
 F  S X=$P(X,"^",1)_" "_$P(X,"^",2,300) Q:X'["^"
 F  Q:$E(X,1)'=" "  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=" "  S X=$E(X,1,($L(X)-1))
 Q X
CTLR(LEX,X,Y) ;   Control Character Replace
 N LEXT,LEXR1,LEXR2,LEX2,LEXW S LEXT=$G(LEX) Q:'$L(LEXT) ""  S LEXR1=$G(X) S X=LEXT Q:'$L(LEXR1) X  Q:LEXT'[LEXR1 X
 S LEXW=$G(Y),LEXR2=$C(195)_LEXR1
 I LEXT[LEXR2 F  Q:LEXT'[LEXR2  S LEXT=$P(LEXT,LEXR2,1)_LEXW_$P(LEXT,LEXR2,2,4000)
 I LEXT[LEXR1 F  Q:LEXT'[LEXR1  S LEXT=$P(LEXT,LEXR1,1)_LEXW_$P(LEXT,LEXR1,2,4000)
 S X=LEXT
 Q X
