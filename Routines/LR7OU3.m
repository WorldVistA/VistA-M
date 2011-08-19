LR7OU3 ;slc/dcm - Match entries in file 60 to 64 ;8/11/97
 ;;5.2;LAB SERVICE;**121**;Sep 27, 1994
6 ;Find matches starting with file 60 ->64
 N X,IFN,IFN1,Y,Z,CTR,CTR1
 S IFN=0,CTR=0,CTR1=0 F  S IFN=$O(^LAB(60,IFN)) Q:IFN<1  S MATCH=0,X=^(IFN,0) D
 . S Y=$$A1($P(X,"^")) I $L(Y) W !,$P(X,"^")_" = "_Y,?60,"Match on name" S MATCH=1,CTR=CTR+1 Q
 . S Y=$$A1($$UPPER^LR7OU1($P(X,"^"))) I $L(Y) W !,$P(X,"^")_" = "_Y,?60,"Match on U-case name" S MATCH=1,CTR=CTR+1 Q
 . S IFN1=0 F  S IFN1=$O(^LAB(60,IFN,5,IFN1)) Q:IFN1<1  S Z=$P(^(IFN1,0),"^") D  Q:MATCH
 . . S Y=$$A1(Z) I $L(Y) W !,$P(X,"^")_" = "_Y,?60,"Synonym match "_Z S MATCH=1,CTR=CTR+1 Q
 . . S Y=$$A1($$UPPER^LR7OU1(Z)) I $L(Y) W !,$P(X,"^")_" = "_Y,?60,"Synonym U-case match "_Z S MATCH=1,CTR=CTR+1 Q
 . I 'MATCH S M=$P($P(X," ",1),",") S IFN1=$E(M,1,$L(M)-1) F  S IFN1=$O(^LAM("B",IFN1)) Q:IFN1=""!($P($P(IFN1," "),",")'=M)  S Z=$O(^(IFN1,0)) I Z D
 . . W !,$P(X,"^")_" ~ "_$P(^LAM(Z,0),"^"),?60,"Close match" S CTR1=CTR1+1,MATCH=1
 . I 'MATCH S M=$$UPPER^LR7OU1($P($P(X," ",1),",")) S IFN1=$E(M,1,$L(M)-1) F  S IFN1=$O(^LAM("B",IFN1)) Q:IFN1=""!($P($P(IFN1," "),",")'=M)  S Z=$O(^(IFN1,0)) I Z D
 . . W !,$P(X,"^")_" ~ "_$P(^LAM(Z,0),"^"),?60,"Close match" S CTR1=CTR1+1,MATCH=1
 . I 'MATCH W !,$P(X,"^"),?65,"NO MATCH"
 W !!,"TOTAL ENTRIES IN 64: "_$P(^LAM(0),"^",4),!,"TOTAL ENTRIES IN 60: "_$P(^LAB(60,0),"^",4),!,"TOTAL MATCHES: "_CTR,!,"TOTAL CLOSE MATCHES: "_CTR1
 Q
A1(X) ;Find matching item in file 64
 S X=$O(^LAM("B",X,0)) I X S X=$P(^LAM(X,0),"^")
 Q X
