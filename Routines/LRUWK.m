LRUWK ;REG/AVAMC - WORKLOAD UTILITY ;8/20/93  06:57
 ;;5.2;LAB SERVICE;;Sep 27, 1994
X S LRT=$O(^LAB(60,"B",X,0)) G:'LRT OUT Q:$D(X("NOCODES"))
 F B=0:0 S B=$O(^LAB(60,LRT,9,B)) Q:'B  S LRT(B)=""
 Q:$D(LRT)=11
OUT W $C(7),!!,"Must have test in LAB TEST file (#60) called",!,"'",X,"'" W:'$D(X("NOCODES")) " with VERIFY WKLD CODES." K X S J=1 Q
 ;
A S LRT=$O(^LAB(60,"B",X,0)) G:'LRT OUT F B=0:0 S B=$O(^LAB(60,LRT,9.1,B)) Q:'B  S LRT(B)=""
 I $D(LRT)'=11 D OUT W " with ACCESSION WKLD CODES."
 Q
W W $C(7),!!,"Must have entry in WKLD CODE file (#64) called",!,"'",X,"'"," with WKLD CODE: ",Y K X,Y Q
 Q
