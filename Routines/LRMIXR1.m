LRMIXR1 ;SLC/BA - X-REF FOR ANTIBIOTIC INTERPRETATION ^LAB(62.06,"AJ") ; 8/5/87  10:40 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
KINT ;kills "AJ" x-ref and then resets it when INTERPRETATION is deleted
 S K0=DA(1) D KILL
 Q
KAINT ;kills "AJ" x-ref and then resets it when ALTERNATE INTERPRETATION is deleted
 S K0=DA(2) D KILL
 Q
KILL I $L($P(^LAB(62.06,K0,0),U,2)) S K9=+$P(^(0),U,2) K ^LAB(62.06,"AJ",K9,X) D SET
 K K0 S K9=DA(1) N DA,X
 S DA=K9 S X=$P($G(^LAB(62.06,+DA,0)),U,2) D ^LRMIXALL
 Q
BUGNODE ;sets "AJ" x-ref when entering BUG NODE 
 S K0=DA,K9=+X I K9'<2 D SET
 Q
SET S K1=0 F I=0:0 S K1=+$O(^LAB(62.06,K0,1,K1)) Q:K1<1  I $D(^(K1,0)),$L($P(^(0),U,2)) S ^LAB(62.06,"AJ",K9,$P(^(0),U,2))="" D ALT
 K K0,K1,K2,K9
 Q
ALT S K2=0 F I=0:0 S K2=+$O(^LAB(62.06,K0,1,K1,2,K2)) Q:K2<1  I $D(^(K2,0)),$L($P(^(0),U)),$L($P(^(0),U,2)),$L($P(^(0),U,3)) S ^LAB(62.06,"AJ",K9,$P(^(0),U))=""
 Q
