FHADR5 ; HISC/NCA - Dietetic Encounter Percentage ;4/27/93  09:20
 ;;5.5;DIETETICS;;Jan 28, 2005
Q0 ; Calculate the Encounter Percentage
 K N,P,S,T2,T3,T4,T5 S (T2,T3,T4,T5)="",(CTN,NUM)=0
 F QR=1:1:4 S QTR=QR,PRE=FHYR_"0"_QTR_"00" D Q2^FHADRPT,Q1
 G EN2
Q1 Q:'SDT!('EDT)
 S X1=SDT\1-.0001,X2=EDT\1+.3 K T,P
Q2 S X1=$O(^FHEN("AT",X1)) I X1<1!(X1>X2) G ADD
 S K=0
Q3 ; Count the Encounter and Work Units
 S K=$O(^FHEN("AT",X1,K)) G:K="" Q2
 S X=$G(^FHEN(K,0)),TYP=$P(X,"^",4) G:'TYP Q3
 S UNT=$P(X,"^",8)
 S:'$D(T(TYP)) T(TYP)=0 S T(TYP)=T(TYP)+1
 S:'$D(P(TYP)) P(TYP)=0 S P(TYP)=P(TYP)+UNT
 G Q3
ADD F K=0:0 S K=$O(T(K)) Q:K<1  S TYP=$P($G(^FH(115.6,K,0)),"^",2) D A1
 Q
A1 ; S(TYP) contains encounters, and N(TYP) contains the Work Units for
 ; four quarters T2 contains Total Encounters and T4 contains
 ; total Work Units of last line, CTN is YTD final encounters and
 ; NUM is YTD Units, T3 contains YTD Total encounters for each category
 ; T5 contains the YTD Total Units for each category
 Q:TYP=""
 S:'$D(S(TYP)) S(TYP)=""
 S $P(S(TYP),"^",QTR)=$P(S(TYP),"^",QTR)+T(K),CTN=CTN+T(K)
 S $P(T2,"^",QTR)=$P(T2,"^",QTR)+T(K) S:'$D(T3(TYP)) T3(TYP)=0
 S T3(TYP)=T3(TYP)+T(K)
 S:'$D(N(TYP)) N(TYP)="" S $P(N(TYP),"^",QTR)=$P(N(TYP),"^",QTR)+P(K)
 S $P(T4,"^",QTR)=$P(T4,"^",QTR)+P(K) S:'$D(T5(TYP)) T5(TYP)=0
 S T5(TYP)=T5(TYP)+P(K),NUM=NUM+P(K)
 Q
EN2 ; Print the Encounters and Work Units
 D:$Y'<LIN HDR^FHADRPT D HDR
 S TIT=";"_$P(^DD(115.6,10,0),"^",3)
P1 S Z=0 F K=0:0 S Z=$O(S(Z)) Q:Z=""  S X=$F(TIT,";"_Z_":") S:X>0 X=$P($E(TIT,X,999),";",1) D P2
 S X="Total Encounters" D TOT Q
P2 W !,?2,X,?28 F I=1:1:4 D LP
 W $J($S(+T3(Z)'<1:T3(Z),1:""),5)_" ",$S(T5(Z):$J(T5(Z),7,0),1:$J("",7))
 W $S(NUM:$J(T5(Z)/NUM*100,6,1),1:$J("",6)) Q
LP W $J($S(+$P(S(Z),"^",I)'<1:$P(S(Z),"^",I),1:""),5)_" ",$S($P(N(Z),"^",I)'="":$J($P(N(Z),"^",I),7,0),1:$J("",7))
 W $S($P(T4,"^",I)'<1:$J($P(N(Z),"^",I)/$P(T4,"^",I)*100,6,1),1:$J("",6))_" "
 Q
TOT ; Print Last Line
 W !!,X,?28 F I=1:1:4 W $J($S($P(T2,"^",I):$P(T2,"^",I),1:""),5)_" ",$S($P(T4,"^",I):$J($P(T4,"^",I),7,0),1:$J("",7))_$J("",7)
 W ?108,$J($S(CTN:CTN,1:""),5)_" ",$S(NUM:$J(NUM,7,0),1:$J("",7))
 K N,P,S,T2,T3,T4,T5 Q
HDR ; Print Heading for Encounter Category Summary
 D:$Y'<(LIN-17) HDR^FHADRPT,HDR2^FHADR3A
 W !!!!,"CLINICAL ENCOUNTER CATEGORY SUMMARY"
 W !!,?35,"1st Qtr",?55,"2nd Qtr",?76,"3rd Qtr",?95,"4th Qtr",?116,"YTD"
 W !?36,"Work",?56,"Work",?76,"Work",?96,"Work",?116,"Work"
 W !,"Clinical Categories",?30,"Tot   Units   %     Tot   Units   %     Tot   Units   %     Tot   Units   %     Tot   Units   %",! Q
