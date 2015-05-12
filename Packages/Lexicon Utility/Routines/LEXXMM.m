LEXXMM ;ISL/KER - Convert Text to Mix Case (Misc) ;12/19/2014
 ;;2.0;General Lexicon Utilities;**80,86**;Sep 23, 1996;Build 1
 ;               
 ; Global Variables
 ;    ^UTILITY($J)        ICR  10011
 ;               
 ; External References
 ;    ^DIWP               ICR  10011
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     ALL,LOW checked but not used
 ;                 
EW(X) ; Exported Word
 N WRD,CNT,IMC,EXP,IEN,WU,WM,ORG,SCR,TTL,WL S ORG=$G(X) Q:'$L(ORG)  S (WRD,WU)=$$UP(ORG),WM=$$MX(ORG),WL=$$LO(ORG)
 S TTL="Supplemental Word",SCR="SUP" D EW2 S TTL="Lowercase",SCR="LOW" D EW2 S TTL="Mixed Case",SCR="MIX" D EW2
 S TTL="Uppercase",SCR="UPP" D EW2 S TTL="Special Case",SCR="SPC" D EW2
 Q
EW2 ;   Exported Word Indexed
 Q:'$L($G(WRD))  N CNT,CT,EXP,I,IEN,IMC,MA,MIX,UPP
 I $D(^LEX(757.01,"AWRD",WRD)) D  Q
 . N CNT,IMC S (CNT,IMC)=0 F  S IMC=$O(^LEX(757.01,"AWRD",WRD,IMC)) Q:+IMC'>0  D
 . . N IEN,EXP S EXP=$P($G(^LEX(757.01,+IMC,0)),"^",1) Q:'$L(EXP)
 . . S IEN=0 F  S IEN=$O(^LEX(757.01,"AWRD",WRD,IMC,IEN)) Q:+IEN'>0  D
 . . . N CT,EXP,I,MA,MIX,UPP S EXP=$P($G(^LEX(757.01,+IEN,0)),"^",1) Q:'$L(EXP)  S MIX=$$MIX^LEXXM(EXP),UPP=$$UP(EXP) D EW3
 I $D(^LEX(757.01,"AEXC",WRD)) D
 . Q:SCR="SUP"  Q:SCR="LOW"&('$D(ALL))
 . N CNT,IMC S (CNT,IMC)=0 F  S IMC=$O(^LEX(757.01,"AEXC",WRD,IMC)) Q:+IMC'>0  D
 . . N IEN,EXP,CT,EXP,I,MA,MIX,UPP S EXP=$P($G(^LEX(757.01,+IMC,0)),"^",1) Q:'$L(EXP)
 . . Q:'$L(EXP)  S IEN=IMC,MIX=$$MIX^LEXXM(EXP),UPP=$$UP(EXP) D EW3
 N ALL
 Q
EW3 ;   Exported word is Special/Lower/Upper/Mixed case
 Q:+IEN'>0  Q:'$L($G(TTL))  Q:'$L($G(WRD))  Q:'$L($G(SCR))  N OUT
 I SCR="SUP",UPP'[$$UP(WRD),$D(^LEX(757.01,+IEN,5,"B",WRD)) S OUT=MIX D EW4
 I SCR="LOW",UPP[$$UP(WRD),MIX[WL,MIX'[WU,MIX'[WM S OUT=MIX D EW4
 I SCR="MIX",UPP[$$UP(WRD),MIX[WM,MIX'[WU,MIX'[WL S OUT=MIX D EW4
 I SCR="UPP",UPP[$$UP(WRD),MIX[WU,MIX'[WM,MIX'[WL S OUT=MIX D EW4
 I SCR="SPC",UPP[$$UP(WRD),MIX'[WU,MIX'[WM,MIX'[WL S OUT=MIX D EW4
 Q
EW4 ;   Exported Word Display
 Q:+IEN'>0  Q:'$L($G(TTL))  Q:'$L($G(OUT))
 N I,CT,OA S CT=0 S CNT=CNT+1 W:CNT=1 !!,TTL,! W !,IEN S OA(1)=OUT D PR(.OA,70)
 S I=0 F  S I=$O(OA(I)) Q:+I'>0  I $L($G(OA(I))) S CT=CT+1 W:CT>1 ! W ?9,$G(OA(I))
 Q
 ;                 
QWIC ; Create AEXC Index
 N BEG,CHR,DA,END,IEN,TXT,WD,WRD
 N IEN S IEN=0 F  S IEN=$O(^LEX(757.01,IEN)) Q:+IEN'>0  D
 . N BEG,END,TXT,DA S TXT=$P($G(^LEX(757.01,+IEN,0)),"^",1) Q:'$L(TXT)
 . S DA=+($G(IEN)),BEG=1 F END=1:1:$L(TXT)+1 D
 . . N CHR S CHR=$E(TXT,END) I "~!@#$%&*()_+`-=[]{};'\:|,./?<> """[CHR D
 . . . N WRD S WRD=$E(TXT,BEG,(END-1)),BEG=END+1 I $L(WRD)>0,$L(WRD)<31 D
 . . . . N WD S WD=$$UP(WRD) S:$L(WD) ^LEX(757.01,"AEXC",WD,DA)=""
 Q
PR(LEX,X) ; Parse Array LEX in X Length Strings (default 79)
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,LEXI,LEXLEN,LEXC,Z K ^UTILITY($J,"W") Q:'$D(LEX)
 S LEXLEN=+($G(X)) S:+LEXLEN'>0 LEXLEN=79 S LEXC=+($G(LEX)) S:+($G(LEXC))'>0 LEXC=$O(LEX(" "),-1) Q:+LEXC'>0
 S DIWL=1,DIWF="C"_+LEXLEN S LEXI=0 F  S LEXI=$O(LEX(LEXI)) Q:+LEXI=0  S X=$G(LEX(LEXI)) D ^DIWP
 K LEX S (LEXC,LEXI)=0 F  S LEXI=$O(^UTILITY($J,"W",1,LEXI)) Q:+LEXI=0  D
 . S LEX(LEXI)=$$TM($G(^UTILITY($J,"W",1,LEXI,0))," "),LEXC=LEXC+1
 S:$L(LEXC) LEX=LEXC K ^UTILITY($J,"W")
 Q
 ;                 
 ; Swap
SW1(X) ;   Switch Text (before setting case)
 N TXT,SWAP,WITH S TXT=$G(X) Q:'$L(TXT) TXT
 S SWAP="I.E.",WITH="IE",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="E.G.",WITH="EG",TXT=$$SWAP(TXT,SWAP,WITH)
 S X=TXT
 Q X
SW2(X) ;   Switch Text (after setting case)
 N TXT,SWAP,WITH S TXT=$G(X) Q:'$L(TXT) TXT
 S SWAP="(S)",WITH="(s)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP=" (E)",WITH="(e)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="(E)",WITH="(e)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP=" A ",WITH=" a ",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="Class a",WITH="Clas A",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="Type a",WITH="Type A",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="'S",WITH="'s",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="mg Diet",WITH="MG Diet",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="LO-Fat",WITH="Lo-Fat",TXT=$$SWAP(TXT,SWAP,WITH)
 S X=$G(TXT)
 Q X
SW3(X) ;   Switch Text (after assembling string)
 N TXT,C1,C2,SWAP,WITH,PIE S TXT=$G(X) Q:'$L(TXT) TXT
 S SWAP=" (S)",WITH="(s)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="(S)",WITH="(s)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP=" (E)",WITH="(e)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="(E)",WITH="(e)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="CR(e)St",WITH="CR(E)ST",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="CR(e),St",WITH="CR(E)ST",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP="'S",WITH="'s",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP=" (Only)",WITH=" (only)",TXT=$$SWAP(TXT,SWAP,WITH) S SWAP="(Only)",WITH="(only)",TXT=$$SWAP(TXT,SWAP,WITH)
 S SWAP=" (Each)",WITH=" (each)",TXT=$$SWAP(TXT,SWAP,WITH) S SWAP="(Each)",WITH="(each)",TXT=$$SWAP(TXT,SWAP,WITH)
 F PIE=1:1 Q:'$L($P(TXT,"&",PIE))  D
 . N P1,P2 S P1=$P(TXT,"&",1,PIE) Q:'$L(P1)  S P2=$P(TXT,"&",(PIE+1),$L(TXT,"&")) Q:'$L(P2)  S:P1[" "&($E(P2,1)'=" ") TXT=$$TM(P1)_"&"_$$TM(P2)
 S X=TXT Q:$D(LOW) X  S C1=$E(X,1),C2=$E(X,2),C1=C1?1U,C2=C2?1U
 S:(C1+C2)'=1 X=$TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(X,2,$L(X))
 N LOW
 Q X
SWAP(X,A,B) ;   Swap text "A" for text "B" in text "X"
 N TXT,SWAP,WITH S TXT=$G(X),SWAP=$G(A),WITH=$G(B) Q:'$L(TXT) TXT  Q:'$L(SWAP) TXT  Q:TXT'[SWAP TXT  Q:SWAP=WITH TXT  Q:WITH[SWAP TXT
 F  Q:TXT'[SWAP  S (X,TXT)=$P(TXT,SWAP,1)_WITH_$P(TXT,SWAP,2,299)
 Q X
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X),Y=$G(Y) Q:$L(Y)&(X'[Y) X  S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
 ;                 
 ; Case
IG(X) ;   Ignore Case
 N IN,XU,CHR,TMP S IN=$G(X),XU=$$UP(IN),CHR=$E(XU,1),TMP="TYPE "_XU,TMP=$$MIX^LEXXM(TMP),TMP=$E(TMP,6,$L(TMP)) Q:TMP=IN 1
 Q 0
IL(X) ;   Is Lowercase
 Q:'$L($G(X)) 0  Q:$E($G(X),1)'?1A 0  N CH,I,WD S WD=$G(X),X=1 F I=1:1 S CH=$E(WD,I) Q:'$L(CH)  S:CH?1U X=0 Q:'X
 Q X
IU(X) ;   Is Uppercase
 Q:'$L($G(X)) 0  Q:$E($G(X),1)'?1A 0  N CH,I,WD S WD=$G(X),X=1 F I=1:1 S CH=$E(WD,I) Q:'$L(CH)  S:CH?1L X=0 Q:'X
 Q X
IM(X) ;   Is Mixed Case
 Q:'$L($G(X)) 0  Q:$E($G(X),1)'?1A 0  N CH,I,WD S WD=$G(X),X=1 F I=1:1 S CH=$E(WD,I) Q:'$L(CH)  S:I=1&(CH'?1U) X=0 S:I>1&(CH?1U) X=0 Q:'X
 Q X
IS(X) ;   Is Special Case
 Q:$L($G(X))'>1 0  Q:$E($G(X),1)'?1A 0  N CH,PC,WD,I S WD=$G(X),X=0 F I=2:1 S CH=$E(WD,I),PC=$E(WD,(I-1)) Q:'$L(CH)  S:CH?1U&(PC?1L) X=1 Q:X>0
 Q X
LO(X) ;   Lower Case
 Q $TR(X,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
UP(X) ;   Uppercase
 Q $TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
MX(X) ;   Mix Case Term
 Q $TR($E(X,1),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$TR($E(X,2,$L(X)),"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
MIX(X) ;   Mixed Case Word
 N IN,XU,CHR,TMP S IN=$G(X),XU=$$UP(IN),CHR=$E(XU,1),TMP="TYPE "_XU,TMP=$$MIX^LEXXM(TMP),TMP=$E(TMP,6,$L(TMP)) S X=TMP
 Q X
