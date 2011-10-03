FHSEL3 ; HISC/REL/NCA - Print Tabulated Preferences ;1/23/98  16:11
 ;;5.5;DIETETICS;;Jan 28, 2005
 K S S S1=38
 F K=0:0 S K=$O(D(K)) Q:K=""  S X=^FH(119.72,K,0),N2=$P(X,"^",1),N3=$P(X,"^",4) S:N3="" N3=$E(N2,1,6) S S(N3,K)=$J(N3,8),S1=S1+8
 S:S1<80 S1=80
 F Z=0:0 S Z=$O(^TMP($J,"P",Z)) Q:Z<1  D C1
 S DTP=NOW D DTP^FH S H1=DTP,X=TIM D DOW^%DTC S DOW=Y+1 D SES,HDR
 I $D(^TMP($J,"L")) S TP="L" W !!?(S1-9\2),"L I K E S",! D L0
 I $D(^TMP($J,"D")) S TP="D" W !!?(S1-15\2),"D I S L I K E S",! D L0
KIL W ! Q
L0 S CHK="" I 'SRT S LNOD="0" D L1 Q
 S LNOD="0" F L1=0:0 S LNOD=$O(^TMP($J,TP,LNOD)) Q:LNOD=""  D L1
 Q
L1 S X1=""
L2 S X1=$O(^TMP($J,TP,LNOD,X1)) Q:X1=""
 D:$Y>(IOSL-6) HDR I SRT,CHK'=LNOD W !!,"Prod. Diet: ",LNOD,! S CHK=LNOD
 W !,$P(X1,"~",1),?31 S TOT=0
 S K1="" F  S K1=$O(S(K1)) Q:K1=""  F SP=0:0 S SP=$O(S(K1,SP)) Q:SP=""  S N1=$G(^TMP($J,TP,LNOD,X1,SP)) W $J($S('N1:"",1:N1),6),"  " S TOT=TOT+N1
 W $J($S(TOT:TOT,1:""),6)
 G L2
SES S (PD,Y)="",P0=0
 S P0="" F  S P0=$O(S(P0)) Q:P0=""  F K=0:0 S K=$O(S(P0,K)) Q:K<1  S Y=$G(S(P0,K)),PD=PD_Y
 S PD=PD_"   TOTAL"
 Q
C1 S X=$G(^FH(115.2,Z,0)),TP=$P(X,"^",2)
 I TP="L" S X1=+$P(X,"^",4) G C3:D3,C31
 Q:TP'="D"  S PD="" F LL=0:0 S PD=$O(^TMP($J,"P",Z,PD)) Q:PD=""  D C2:D3,C22:'D3
 Q
C2 F KK=0:0 S KK=$O(^FH(115.2,Z,"X",KK)) Q:KK<1  S X1=+^(KK,0) D C21
 Q
C21 S X3=$O(^FH(116.1,FHX1,"RE","B",X1,0)) Q:X3<1
 S X1=$P(^FH(114,X1,0),"^",1)_"~"_X1
 F CAT=0:0 S CAT=$O(^FH(116.1,FHX1,"RE",X3,"R",CAT)) Q:CAT<1  S X=$P($G(^(CAT,0)),"^",2) D
 .Q:X'[PD
 .F SP=0:0 S SP=$O(^TMP($J,"P",Z,PD,SP)) Q:SP<1  D C4
 .Q
 Q
C22 S X1=$P(^FH(115.2,Z,0),"^",1)_"~"_Z
 F SP=0:0 S SP=$O(^TMP($J,"P",Z,PD,SP)) Q:SP<1  D C4
 Q
C3 S X3=$O(^FH(116.1,FHX1,"RE","B",X1,0)) I X3<1 K ^TMP($J,"P",Z) Q
 S X1=$P(^FH(114,X1,0),"^",1)_"~"_X1
 S PD="" F LL=0:0 S PD=$O(^TMP($J,"P",Z,PD)) Q:PD=""  D
 .F CAT=0:0 S CAT=$O(^FH(116.1,FHX1,"RE",X3,"R",CAT)) Q:CAT<1  S X=$P($G(^(CAT,0)),"^",2) D
 ..Q:X'[PD
 ..F SP=0:0 S SP=$O(^TMP($J,"P",Z,PD,SP)) Q:SP<1  D C4
 ..Q
 .Q
 Q
C31 S X1=$P(^FH(115.2,Z,0),"^",1)_"~"_Z
 S PD="" F LL=0:0 S PD=$O(^TMP($J,"P",Z,PD)) Q:PD=""  F SP=0:0 S SP=$O(^TMP($J,"P",Z,PD,SP)) Q:SP<1  D C4
 Q
C4 I $D(^TMP($J,"P",Z,PD,SP)) S X2=^(SP),CODE=$O(^FH(116.2,"C",PD,0)),CODE=$P($G(^FH(116.2,+CODE,0)),"^",1),LNOD=$S(SRT:$E(CODE,1,18),1:"0") S:'$D(^TMP($J,TP,LNOD,X1,SP)) ^TMP($J,TP,LNOD,X1,SP)=0 S ^(SP)=^(SP)+X2
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,H1,?(S1-29\2),"M E A L   P R E F E R E N C E S",?(S1-8),"Page ",PG
 I D3 W !!?(S1-14\2),"MENU SPECIFIC"
 S DTP=TIM\1 D DTP^FH S X=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR","^",DOW)_"DAY  "_DTP_"  "_$S(MEAL="B":"BREAKFAST",MEAL="N":"NOON",1:"EVENING")
 W:D3 ! W !?(S1+2-$L(X)\2),X
 W !! W $S('D3:"Preference",1:"Recipe"),?29,PD,!
 S LN="",$P(LN,"-",S1+1)="" W !,LN Q
