LRMIXR3 ;SLC/BA - ANTIBIOTIC INTERPRETATION ^LAB(62.06,"AI", X-REF ; 4/4/87  21:05 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ALT ;sets "AI" x-ref alternate interpretation when ALTERNATE INTERPRETATION, ORGANISM (INTRP), or SPECIMEN (INTRP) is entered
 S K0=DA(2),K1=DA(1),K2=DA,J4=X I $L($P(^LAB(62.06,K0,0),U,2)) S J0=$P(^(0),U,2),J1=$P(^LAB(62.06,K0,1,K1,0),U) I $D(^LAB(62.06,K0,1,K1,2,K2,0)),$L($P(^(0),U,2)),$L($P(^(0),U,3)) S J2=$P(^(0),U,2),J3=$P(^(0),U,3) D SETUP
 K J0,J1,J2,J3,J4,J9,K0,K1,K2
 Q
ALTO ;sets "AI" x-ref alternate interpretation when ORGANISM (INTRP) is entered
 S K0=DA(2),K1=DA(1),K2=DA,J2=X I $L($P(^LAB(62.06,K0,0),U,2)) S J0=$P(^(0),U,2),J1=$P(^LAB(62.06,K0,1,K1,0),U) I $D(^LAB(62.06,K0,1,K1,2,K2,0)),$L($P(^(0),U,3)) S J3=$P(^(0),U,3),J4=$P(^(0),U) D SETUP
 K J0,J1,J2,J3,J4,K0,K1,K2
 Q
ALTS ;sets "AI" x-ref alternate interpretation when SPECIMEN (INTRP) is entered
 S K0=DA(2),K1=DA(1),K2=DA,J3=X I $L($P(^LAB(62.06,K0,0),U,2)) S J0=$P(^(0),U,2),J1=$P(^LAB(62.06,K0,1,K1,0),U) I $D(^LAB(62.06,K0,1,K1,2,K2,0)),$L($P(^(0),U,2)) S J2=$P(^(0),U,2),J4=$P(^(0),U) D SETUP
 K J0,J1,J2,J3,J4,K0,K1,K2
 Q
KALT ;kills "AI" x-ref alternate interpretation when ALTERNATE INTERPRETATION, ORGANISM (INTRP), or SPECIMEN (INTRP) are deleted
 I $L($P(^LAB(62.06,DA(2),0),U,2)) S J0=$P(^(0),U,2),J1=$P(^LAB(62.06,DA(2),1,DA(1),0),U) I $L($P(^LAB(62.06,DA(2),1,DA(1),2,DA,0),U,2)),$L($P(^(0),U,3)) S J2=$P(^(0),U,2),J3=$P(^(0),U,3) D SWITCH K ^LAB(62.06,"AI",J0,J1,J2,J3)
 K J0,J1,J2,J3
 Q
BUGNODE ;sets "AI" x-ref when entering BUG NODE
 S K0=DA,J0=+X,^LAB(62.06,"AI",J0)=K0_U_$P(^LAB(62.06,K0,0),U,5)
 S K1=0 F I=0:0 S K1=+$O(^LAB(62.06,K0,1,K1)) Q:K1<1  I $D(^(K1,0)),$L($P(^(0),U)) S J1=$P(^(0),U),^LAB(62.06,"AI",+X,J1)=$P(^(0),U,2) D RESULT
 K K0,K1,K2,J0,J1,J2,J3,J9
 Q
RESULT S K2=0 F I=0:0 S K2=+$O(^LAB(62.06,K0,1,K1,2,K2)) Q:K2<1  I $D(^(K2,0)),$L($P(^(0),U,2)),$L($P(^(0),U,3)) S J2=$P(^(0),U,2),J3=$P(^(0),U,3),J4=$P(^(0),U) D SETUP
 Q
SETUP D SWITCH S ^LAB(62.06,"AI",J0,J1,J2,J3)=J4
 Q
SWITCH S J9=$P(^LAB(61.2,J2,0),U),J2=$S(J9["UNKNOWN":"ANY",J9["GRAM POS":"GRAM POS",J9["GRAM NEG":"GRAM NEG",1:J2),J9=$P(^LAB(61,J3,0),U),J3=$S(J9["UNKNOWN":"ANY",1:J3)
 Q
