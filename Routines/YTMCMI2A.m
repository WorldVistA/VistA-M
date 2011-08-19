YTMCMI2A ;ALB/ASF- MCMI2 REPORT; ;6/26/91  17:58
 ;;5.01;MENTAL HEALTH;;Dec 30, 1994
INP ;
 W !,"Was the MCMI2 taken by ",YSNM," administered as an ",!,"(I)npatient or (O)utpatient? "
 R Y:DTIME S YSTOUT='$T,YSUOUT=Y["^" G:YSTOUT!YSUOUT H^XUS S Y=$TR($E(Y_1),"io","IO") I "IO"'[Y W !,"Answer I for inpatient or O for outpatient",$C(7) G INP
 S YSMCMI2P=Y
EPIS ;
 W !,"Was the duration of the recent Axis I Episode: ",!,"1. Less than one week",!,"2. One to four weeks",!,"3. One to three months",!,"4. Three to twelve months",!,"5. Periodic; one to three years",!,"6. Continuous; one to "
 W "three years",!,"7. Periodic; three to seven years",!,"8. Continuous; three to seven years",!,"9. More than seven years",!,"0. Cannot categorize"
 R !,"Answer: ",Y:DTIME S YSTOUT='$T,YSUOUT=Y["^" G:YSTOUT!YSUOUT H^XUS S Y=$E(Y_"A") I Y'?1N W !,"Enter a number 0-9" G EPIS
 S YSMCMI2L=Y Q
F0 ;
 S R="",J=1
T0 ;
 S L=200,M=0,YSKK=1,YSTL=0 G:J=27 STND D RD
T1 ;
 I '$D(^YTT(601,YSTEST,"S",J,"K",YSKK,0)) S R=R_YSTL_"^",J=J+1 G T0
 S Y=^YTT(601,YSTEST,"S",J,"K",YSKK,0),P=1
T2 ;
 S YSIT=$P(Y,U,P) I YSIT="" S YSKK=YSKK+1 G T1
 S A=$P(Y,U,P+1),P=P+2
 S:$E(X,+YSIT-M)=A YSTL=YSTL+(+$P(YSIT,"(",2)) G T2
RD ;
 S X=^YTD(601.2,YSDFN,1,YSET,1,YSED,L\200) Q
STND ;
XX ;
 S X=($P(R,U,7)*1.5)+($P(R,U,12)*1.5)+($P(R,U,4)*1.6)+($P(R,U,5)*1.6)+($P(R,U,6)*1.6)+($P(R,U,13)*1.6)+$P(R,U,8)+$P(R,U,9)+$P(R,U,10)+$P(R,U,11),X=$J(X,3,0)
 S Y=^YTT(601,201,"S",1,YSSEX) F I=1:1 I X'>(+$P(Y,U,I)) S S=$P($P(Y,U,I),",",2) Q
 S S=S_"^",$P(R,U)=X F J=2:1:25 S X=^YTT(601,YSTEST,"S",J,YSSX),A=$P(R,U,J),S1=$P(X,U,A+1) S:S1="" S1=$P(X,U,$L(X,U)) S S=S_S1_U
 G ^YTMCMI2B
