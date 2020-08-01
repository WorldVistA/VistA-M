TIUCOPSU ;SLC/TDP - Pasted Text Search Utilities ;03/12/19  13:26
 ;;1.0;TEXT INTEGRATION UTILITIES;**290**;JUN 20,1997;Build 548
 ;
 ;   DBIA 10104  $$UP^XLFSTR
 ;   DBIA 10018  ^DIE
 ;
EN ;
 Q
 ;
SUB(SARY,PS) ;Determine next subscript in array
 N X
 ;I SARY'="F",SARY'="S",SARY'="P",SARY'="T" Q "ERR"
 I SARY'="T" Q "ERR"
 S X=""
 ;I SARY="F" S X=$O(F(PS,X),-1)+1 Q X
 ;I SARY="S" S X=$O(S(X),-1)+1 Q X
 ;I SARY="P" S X=$O(P(X),-1)+1 Q X
 I SARY="T" S X=$O(TMPARY(PS,X),-1)+1 Q $S(+X>0:X,1:1)
 Q X
TRIM(T,PUNC) ;Trim leading and trailing spaces and leading punctuation from input
 N BSPC,ESPC,TSPC
 S T=$G(T)
 I T="" Q T
 S PUNC=+PUNC
 I PUNC'=1 S PUNC=0
 N X,DN,EX
 S (BSPC,ESPC,TSPC,DN)=0
 F X=$L(T):-1:1 D  Q:DN=1
 . S EX=$E(T,X)
 . I EX=" " D  Q:DN=1
 .. S ESPC=ESPC+1
 .. I X=1 S T="",DN=1 Q
 .. I X>1 S T=$E(T,1,(X-1))
 . I EX'=" " S DN=1
 S DN=0
 I PUNC=1 D
 . F X=1:1:$L(T) D  Q:DN=1
 .. S EX=$E(T,1)
 .. I (EX=" ")!("!.?"[EX) D  Q:DN=1
 ... S BSPC=BSPC+1
 ... I 1=$L(T) S T="",DN=1 Q
 ... I 1<$L(T) S T=$E(T,2,$L(T))
 .. I EX'=" ","!.?"'[EX S DN=1
 I PUNC=0 D
 . F X=1:1:$L(T) D  Q:DN=1
 .. S EX=$E(T,1)
 .. I (EX=" ") D  Q:DN=1
 ... S BSPC=BSPC+1
 ... I 1=$L(T) S T="",DN=1 Q
 ... I 1<$L(T) S T=$E(T,2,$L(T))
 .. I EX'=" " S DN=1
 S TSPC=BSPC+ESPC
 Q T
