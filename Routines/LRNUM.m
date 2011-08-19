LRNUM ;SLC/BA-NUMERIC INPUT TRANSFORM ;2/6/91  08:55
 ;;5.2;LAB SERVICE;**153,221,386**;Sep 27, 1994;Build 1
BEGIN Q:X="pending"
 S LRLOW=$P(Q9,","),LRHIGH=$P(Q9,",",2),LRDEC=$P(Q9,",",3),Q8="" S:"<>"[$E(X,1) Q8=$E(X,1),X=$E(X,2,99) S Q1=$P(X,"."),Q2=$E($P(X,".",2),1,99) D CHECK
END K LRLOW,LRHIGH,LRDEC,Q1,Q2,Q8,Q9
 Q
CHECK I $L(Q1),Q1'="-",Q1'="-0",+Q1'=Q1 K X Q
 I $L(Q2),Q2'?1N.N K X Q
 I $L(Q2)>LRDEC K X Q
 I X>LRHIGH!(X<LRLOW)!($L(X,".")>2)!(X["..")!(X["-"&(+X=0)) K X Q
 S X=Q8_X
 Q
COM ;expands lab description from LRMISTF1, dd
 S LRMIN=$P(Q9,","),LRMAX=$P(Q9,",",2),LRSCN=$P(Q9,",",3) D COMCHK
 K LRMIN,LRMAX,LRSCN,Q1,Q2,Q8,Q9
 Q
COMCHK I $L(X)>LRMAX!($L(X)<LRMIN)!(X'?.ANP) K X Q
 N LRL,LRS,LRZ,LRY
 S LRS="" D COMCHK1 Q:'$D(X)  I '$D(LRNOECHO) N LRX S LRX="  ("_$E(LRS,1,$L(LRS)-1)_")" D EN^DDIOL(LRX) ; LRNOECHO SET IN LRVR4 TO PREVENT ECHO WHEN STUFFING COMMENTS.
 S X=LRS
 K LRMAX,LRMIN,LRSCN
 Q
COMCHK1 F I=1:1 Q:$P(X," ",I,99)=""  S LRZ=$P(X," ",I),Y="" D:LRZ]"" SWITCH S LRL=$L(LRS)+$L(LRZ) S:LRL'>LRMAX LRS=LRS_LRZ_" " I LRL>LRMAX D  K X Q
 . N LRJ,LRX
 . S LRX=" ... TOO LONG ... Expanded text is limited to "_LRMAX_" characters."
 . F LRJ=$C(7),LRZ,LRX D EN^DDIOL(LRJ)
 S LRS=$TR(LRS,";","-") ; Strip ";" - FileMan uses ";" to parse DR string.
 Q
SWITCH Q:$G(LRNOEXPD)
 S LRY=0 F  S LRY=$O(^LAB(62.5,"B",LRZ,LRY)) Q:LRY<1  I $L($P($G(^LAB(62.5,LRY,0)),U,4)),LRSCN[$P(^(0),U,4) S LRZ=$P(^LAB(62.5,LRY,0),U,2) Q:'$L($G(^(9)))  S LRY=$P(X," ",I-1),LRY=$E(LRY,$L(LRY)) S:LRY>1 LRZ=^(9)
 Q
PN ;checks for positive or negative entry from LRMISTF1
 I "PN"'[X!($L(X)'=1) K X W $C(7),!,"Enter 'N' for NEGATIVE or 'P' for POSITIVE" Q
 W "  (",$S(X="P":"POSITIVE",1:"NEGATIVE"),")"
 Q
AFS ;checks for acid fast stain entry from LRMISTF1
 I '(X="DP"!(X="DN")!(X="CP")!(X="CN")) K X W $C(7),!,"Enter 'DP' for DIRECT POSITIVE, 'DN' for DIRECT NEGATIVE,",!,"'CP' for CONCENTRATE POSITIVE, or 'CN' for CONCENTRATE NEGATIVE" Q
 W "  (",$S(X="DP":"DIRECT POSITIVE",X="DN":"DIRECT NEGATIVE",X="CP":"CONCENTRATE POSITIVE",1:"CONCENTRATE NEGATIVE"),")"
 Q
