FHDCR1C ; HISC/NCA/RVD - Print Diet Cards (cont.) ;5/10/95  13:02
 ;;5.5;DIETETICS;;Jan 28, 2005
PRT ; Print 2 person page
 N NBR
 S TL=0 D CHKH
 W !! S TL=TL+2 F N1=1:1:2 I $D(^TMP($J,0,N1)) W ?$S(N1=1:2,1:65),MEALDT
 W ! S TL=TL+1 F N1=1:1 Q:'$D(PP(N1))  W ! S TL=TL+1 F NBR=1:1:2 I $D(PP(N1,NBR)) W ?$S(NBR=1:2,1:65),PP(N1,NBR)
 W ! S TL=TL+1
 F N1=1:1 Q:'$D(^TMP($J,"MP",N1))  D:(TL+2)'<($S(FHBOT="Y":LN-5,1:LN-3)) NXT W !! S TL=TL+2 F NBR=1:1:2 D
 .S S1=$S(NBR=1:2,1:65)
 .I $D(^TMP($J,"MP",N1,NBR)) W ?S1,^TMP($J,"MP",N1,NBR)
 .Q
 I TL<LN F L1=TL:1:$S(FHBOT="Y":LN-2,1:LN) W !
 I FHBOT="Y" D HEAD W @IOF Q
 E  D FOOT
 W @IOF Q
NXT ; Print Next Page
 W !! S TL=TL+2 F NM=1:1:2 I $D(^TMP($J,0,NM)) W ?$S(NM=1:20,1:80),"(More Items Next Pg)"
 I TL<LN F L1=TL:1:$S(FHBOT="Y":LN-2,1:LN) W !
 I FHBOT="Y" D HEAD G N1
 E  D FOOT
N1 W @IOF S TL=0 D CHKH
 W !! S TL=TL+2 F XX=1:1:2 I $D(^TMP($J,0,XX)) W ?$S(XX=1:2,1:65),MEALDT,"  (Cont.)"
 W ! S TL=TL+1
 Q
CHKH ; Check whether name header should be on bottom
 I FHBOT="Y" W ! S TL=TL+1 D FOOT W ! S TL=TL+1 Q
 E  D HEAD
 Q
HEAD F NM=1:1:3 W ! S TL=TL+1 F NBR=1:1:2 S X=$P($G(^TMP($J,0,NBR)),"^",NM) I X'="" D
 .S S1=$S(NBR=1:2,1:65) I NM=1 W ?S1,X Q
 .W ?(S1+56-$L(X)),X Q
 Q
FOOT W ! S TL=TL+1 F NBR=1:1:2 S S1=$S(NBR=1:2,1:65) W:$D(^TMP($J,0,NBR)) ?S1,HD
 Q
