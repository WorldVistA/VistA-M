LRMIXPD ;SLC/BA - LAB DESCRIPTIONS ;2/6/91  08:23 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EXPND ;expands lab description  from LRMISTF1
 I $L(X)>68!($L(X)<1)!(X'?.ANP) K X Q
 S %S="" D CHECK Q:'$D(X)  W "  (",$E(%S,1,$L(%S)-1),")" S X=%S
 K %L,%S,%Z
 Q
CHECK F I=1:1 Q:$P(X," ",I,99)=""  S %Z=$P(X," ",I),Y="" D:%Z]"" SWITCH S %L=$L(%S)+$L(%Z) S:%L'>68 %S=%S_%Z_" " I %L>68 W $C(7),!," ... TOO LONG ... Expanded text is limited to 68 characters." K X Q
 Q
SWITCH S Y=0 F  S Y=$O(^LAB(62.5,"B",%Z,Y)) Q:Y<1  I LRSCREEN[$P(^LAB(62.5,Y,0),U,4) S %Z=$P(^LAB(62.5,Y,0),U,2) Q:'$D(^(9))  S Y=$P(X," ",I-1),Y=$E(Y,$L(Y)) S:Y>1 %Z=^(9) Q
 Q
PN ;checks for positive or negative entry from LRMISTF1
 I "PN"'[X!($L(X)'=1) K X W $C(7),!,"Enter 'N' for NEGATIVE or 'P' for POSITIVE" Q
 W "  (",$S(X="P":"POSITIVE",1:"NEGATIVE"),")"
 Q
