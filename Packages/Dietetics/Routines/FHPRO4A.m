FHPRO4A ; HISC/REL/RVD - Meal Distribution Report ;7/7/94  09:18 
 ;;5.5;DIETETICS;**3**;Jan 28, 2005
 ;RVD 5/23/05 - as part of AFP project.
Q1 D SES S P0=0,OLD="" I $P(FHPAR,"^",7)'="Y" S PG=0 D HDR1
 S K4="" F LL=0:0 S K4=$O(^TMP($J,"FH","T",K4)) Q:K4=""  F L1=0:0 S L1=$O(^TMP($J,"FH","T",K4,L1)) Q:L1<1  S N1=^(L1),Y0=^FH(114,L1,0) D S1
 K P D HDR2 Q
S1 I $P(FHPAR,"^",7)="Y",OLD'=$E(K4,1,2) S OLD=$E(K4,1,2),PG=0 D HDR1
 D:$Y>(IOSL-6) HDR1 S P=$P(Y0,"^",3) W !!,$P(Y0,"^",1)
 I $P(FHPAR,"^",7)'="Y" S Z=$P(Y0,"^",12) S:Z Z=$P(^FH(114.2,Z,0),"^",2) W:Z'="" " (",Z,")"
 W ?40,P K Q S P=$P(P," ",1),UNT=$S(P["EA":"EACH",P["FL":"GAL",1:"LB"),TOT=0
 S LL=41 F K=1:1:N S P0=P(K),N1=$G(^TMP($J,"FH","T",K4,L1,P0)),LL=LL+11 I N1 W ?LL,N1," por" S Q(K)=N1,TOT=TOT+N1
 W ?S2,TOT," por",!
 S LL=41 F K=1:1:N S LL=LL+11 I $G(Q(K)) S Y=P*Q(K) D UNT W ?LL,Y
 S Y=P*TOT D UNT W ?S2,Y Q
UNT I UNT="EACH" S Y=$J(Y+.999\1,0,0)_" EA" Q
 I UNT="LB" S P1=Y/16,U1="#" G:P1>.125 U1 S Y=P1*16+.5\1,U1="OZ" G U2
 S P1=Y/128 F P0=1:1:5 S Z=$P("1,4,8,16,128",",",P0) Q:(P1*Z)>.875
 S U1=$P("GL QT PT CP OZ"," ",P0),P1=Z*P1
U1 S Y="" S:P1#1>.875 P1=P1+1\1 S:P1'<1 Y=P1\1,P1=P1#1
 I P1>.125 S:Y'="" Y=Y_"-" S Y=Y_$S(P1<.375:"1/4",P1<.625:"1/2",1:"3/4")
U2 S Y=Y_" "_U1 Q
SES K N,P,S S PD="",N=0
 F P0=0:0 S P0=$O(^TMP($J,"FH",P0)) Q:P0<1  S Y=$P(^FH(119.72,P0,0),"^",4) S:Y="" Y=$E($P(^(0),"^",1),1,6) S S(Y_"~"_P0)=""
 S Y="" F  S Y=$O(S(Y)) Q:Y=""  S N=N+1,P(N)=$P(Y,"~",2),PD=PD_$J($P(Y,"~",1),6)_"     "
 K S S S2=52+$L(PD),S1=S2+8 S:S1<73 S1=73 Q
HDR1 S PG=PG+1 W @IOF,!,DTP,?(S1-35\2),"M E A L   D I S T R I B U T I O N   R E P O R T",?(S1-6),"Page ",PG
 W !,FHRETYP,?(S1-$L(FHP6)),FHP6
 W ! D:$P(FHPAR,"^",7)="Y" PRE W ?(S1-$L(TIM)\2),TIM
 W !!,"Recipe",?40,"Portion",?52,PD," TOTAL"
 S LN="",$P(LN,"-",S1+1)="" W !,LN Q
PRE S Z=$P(Y0,"^",12) S:Z Z=$P($G(^FH(114.2,Z,0)),"^",1)
 W:Z'="" Z Q
HDR2 W !!!,"*** Note: Does NOT include add-ons and specials!",! Q
