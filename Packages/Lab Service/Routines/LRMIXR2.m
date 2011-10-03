LRMIXR2 ;SLC/BA - X-REF FOR DISPLAY SCREEN ^LAB(62.06,"AS", ; 8/5/87  10:40 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
ALT ;sets "AS" x-ref alternate screen when ALTERNATE SCREEN, ORGANISM (SCREEN), or SPECIMEN (SCREEN) is entered
 S K0=DA(1),K1=DA,J4=X I $L($P(^LAB(62.06,K0,0),U,2)) S J1=$P(^(0),U,2) I $D(^LAB(62.06,K0,3,K1,0)),$L($P(^(0),U,2)),$L($P(^(0),U,3)) S J2=$P(^(0),U,2),J3=$P(^(0),U,3) D SETUP
 K J1,J2,J3,J4,J9,K0,K1
 Q
ALTO ;sets "AS" x-ref alternate screen when ORGANISM (SCREEN) is entered
 S K0=DA(1),K1=DA,J2=X I $L($P(^LAB(62.06,K0,0),U,2)) S J1=$P(^(0),U,2) I $D(^LAB(62.06,K0,3,K1,0)),$L($P(^(0),U,3)) S J4=$P(^(0),U),J3=$P(^(0),U,3) D SETUP
 K J1,J2,J3,J4,J9,K0,K1
 Q
ALTS ;sets "AS" x-ref alternate screen when SPECIMEN (SCREEN) is entered
 S K0=DA(1),K1=DA,J3=X I $L($P(^LAB(62.06,K0,0),U,2)) S J1=$P(^(0),U,2) I $D(^LAB(62.06,K0,3,K1,0)),$L($P(^(0),U,2)) S J4=$P(^(0),U),J2=$P(^(0),U,2) D SETUP
 K J1,J2,J3,J4,J9,K0,K1
 Q
KALT ;kills "AS" x-ref alternate screen when ALTERNATE SCREEN, ORGANISM (SCREEN), or SPECIMEN (SCREEN) are deleted
 I $L($P(^LAB(62.06,DA(1),0),U,2)) S J1=$P(^(0),U,2) I $L($P(^LAB(62.06,DA(1),3,DA,0),U,2)),$L($P(^(0),U,3)) S J2=$P(^(0),U,2),J3=$P(^(0),U,3) D SWITCH K ^LAB(62.06,"AS",J1,J2,J3)
 K J1,J2,J3,J9 D ^LRMIXALL
 Q
BUGNODE ;sets "AS" x-ref when entering BUG NODE
 S K0=DA,J1=+X,^LAB(62.06,"AS",J1)=$P(^LAB(62.06,K0,0),U,6)
 S K1=0 F I=0:0 S K1=+$O(^LAB(62.06,K0,3,K1)) Q:K1<1  I $D(^(K1,0)),$L($P(^(0),U,2)),$L($P(^(0),U,3)) S J4=$P(^(0),U),J2=$P(^(0),U,2),J3=$P(^(0),U,3) D SETUP
 K J1,J2,J3,J4,J9,K0,K1
 Q
SETUP D SWITCH I '(J2="ANY"&(J3="ANY")) S ^LAB(62.06,"AS",J1,J2,J3)=J4
 Q
SWITCH S J9=$P(^LAB(61.2,J2,0),U),J2=$S(J9["UNKNOWN":"ANY",J9["GRAM POS":"GRAM POS",J9["GRAM NEG":"GRAM NEG",1:J2),J9=$P(^LAB(61,J3,0),U),J3=$S(J9["UNKNOWN":"ANY",1:J3)
 Q
