FHMTK1C ; HISC/NCA/RVD - Print Tray Tickets ;4/13/95  13:45
 ;;5.5;DIETETICS;;Jan 28, 2005
PRT ; Print 3 person per page
START I $G(TABREC)="YES" QUIT
 S TL=0 D CHKH
 W !! S TL=TL+2 F N1=1:1:3 D
 .I 'MFLG S MEALDT=$S(MEAL="B":"Breakfast",MEAL="N":"Noon",1:"Evening")_" "_MDT
 .E  S MEALDT=$S(N1=1:"Breakfast",N1=2:"Noon",1:"Evening")_" "_MDT
 .I '$D(MM(0,N1)) Q
 .S MMMDT=$P(MM(0,N1),U,7) I MMMDT'="" S MEALDT=$S(MMMDT="B":"Breakfast",MMMDT="N":"Noon",1:"Evening")_" "_MDT
 .S MEALDT=$J("",40-$L(MEALDT)\2)_MEALDT
 .I $D(MM(0,N1)) W ?$S(N1=1:2,N1=2:45,1:88),MEALDT
 .Q
 W ! S TL=TL+1 F N1=1:1 Q:'$D(PP(N1))  W ! S TL=TL+1 F NBR=1:1:3 I $D(PP(N1,NBR)) W ?$S(NBR=1:2,NBR=2:45,1:88),PP(N1,NBR)
 ;W ! S TL=TL+1 F N1=1:1 Q:'$D(PP(N1))  W ! S TL=TL+1
 W ! S TL=TL+1
 F N1=1:1 Q:'$D(MM(N1))  D:(TL+2)'<($S(FHBOT="Y":LN-5,1:LN-3)) NXT W !! S TL=TL+2 F NBR=1:1:3 I $D(MM(N1,NBR)) W ?$S(NBR=1:2,NBR=2:45,1:88),MM(N1,NBR)
 I TL<LN F L1=TL:1:$S(FHBOT="Y":LN-2,1:LN) W !
 I FHBOT="Y" D HEAD W @IOF Q
 E  D FOOT
 W @IOF Q
NXT ; Print Next Page
 W !! S TL=TL+2 F NM=1:1:3 I $D(MM(0,NM)) W ?$S(NM=1:12,NM=2:57,1:100),"(More Items Next Pg)"
 I TL<LN F L1=TL:1:$S(FHBOT="Y":LN-2,1:LN) W !
 I FHBOT="Y" D HEAD W @IOF G N1
 E  D FOOT
N1 W @IOF S TL=0 D CHKH
 W !! S TL=TL+2 F XX=1:1:3 D
 .I 'MFLG S MEALDT=$S(MEAL="B":"Breakfast",MEAL="N":"Noon",1:"Evening")_" "_MDT
 .E  S MEALDT=$S(XX=1:"Breakfast",XX=2:"Noon",1:"Evening")_" "_MDT
 .I '$D(MM(0,XX)) Q
 .S MMMDT=$P(MM(0,XX),U,7) I MMMDT'="" S MEALDT=$S(MMMDT="B":"Breakfast",MMMDT="N":"Noon",1:"Evening")_" "_MDT
 .S MEALDT=$J("",40-$L(MEALDT)\2)_MEALDT
 .I $D(MM(0,XX)) W ?$S(XX=1:2,XX=2:45,1:88),MEALDT,"  (Cont.)"
 .W ! S TL=TL+1 Q
 Q
CHKH ; Check whether name header should be on bottom
 I FHBOT="Y" W ! S TL=TL+1 D FOOT W ! S TL=TL+1 Q
 E  D HEAD
 Q
HEAD F NM=1:1:3 W ! S TL=TL+1 F NBR=1:1:3 S X=$P($G(MM(0,NBR)),"^",NM) I X'="" D
 .S S1=$S(NBR=1:2,NBR=2:45,1:88) I NM=1 W ?S1,X Q
 .W ?(S1+38-$L(X)),X Q
 Q
FOOT W ! S TL=TL+1 F NBR=1:1:3 S S1=$S(NBR=1:2,NBR=2:45,1:88) W:$D(MM(0,NBR)) ?S1,HD
 Q
LIST ; Print Tabulated Recipe List for Service Points
 S PG=0 I 'MFLG D L1 Q
 F MEAL="B","N","E" D L1
 D:SUM SUM Q
 Q
L1 S:LS(MEAL)<80 LS(MEAL)=80 S MEALDT=$S(MEAL="B":"Breakfast",MEAL="N":"Noon",1:"Evening")_" "_MDT,PG=PG+1
 W:$E(IOST,1,2)="C-" @IOF W !,HD,!!!?(LS(MEAL)-42\2),"T A B U L A T E D   R E C I P E   L I S T",?(LS(MEAL)-8),"Page ",PG
 W !!?(LS(MEAL)-$L(MEALDT)\2),MEALDT,!!,$S(ALL:"ALL",FHP:$P($G(^FH(119.73,FHP,0)),"^",1),1:$P($G(^FH(119.6,+W1,0)),"^",1)),!
 W !!,"R E C I P E S",?29
 S X="" F  S X=$O(DP(MEAL,X)) Q:X=""  F K=0:0 S K=$O(DP(MEAL,X,K)) Q:K=""  W $P(DP(MEAL,X,K),"^",1)
 W "      Total",!
 S X8="" F  S X8=$O(^TMP($J,"CTR",MEAL,X8)) Q:X8=""  W !!,$P(X8,"~",3),?31 D PRO
 S TOT=0 W !!!,"TOTAL RECIPES",?31 S X="" F  S X=$O(DP(MEAL,X)) Q:X=""  D
 .F K=0:0 S K=$O(DP(MEAL,X,K)) Q:K<1  D
 ..S Z=$G(P(MEAL,X,K)),TOT=TOT+Z
 ..I 'Z W $J("",8)_"  " Q
 ..;W $S(Z#1>0:$J(Z,8,1),1:$J(Z,6)_"  ")_"  " Q
 ..W $S(Z#1>0:$J(Z,8,2),1:$J(Z,8))_"  " Q
 .Q
 ;W $S(TOT#1>0:$J(TOT,9,1),1:$J(TOT,7)) W:MFLG @IOF Q
 W $S(TOT#1>0:$J(TOT,9,2),1:$J(TOT,9)) W:MFLG @IOF Q
PRO S FTOT=0,X="" F  S X=$O(DP(MEAL,X)) Q:X=""  D
 .F K=0:0 S K=$O(DP(MEAL,X,K)) Q:K<1  D
 ..S Z=$G(^TMP($J,"CTR",MEAL,X8,K)),FTOT=FTOT+Z,P(MEAL,X,K)=P(MEAL,X,K)+Z
 ..I 'Z W $J("",8)_"  " Q
 ..;W $S(Z#1>0:$J(Z,8,1),1:$J(Z,6)_"  ")_"  " Q
 ..W $S(Z#1>0:$J(Z,8,2),1:$J(Z,8))_"  " Q
 .Q
 ;W $S(FTOT#1>0:$J(FTOT,9,1),1:$J(FTOT,7)_"  ")
 W $S(FTOT#1>0:$J(FTOT,9,2),1:$J(FTOT,9)_"  ")
 Q
SUM S:SL<80 SL=80 S MEALDT="All Meals "_MDT S PG=0 D HDR
 S X8="" F  S X8=$O(^TMP($J,"TOT",X8)) Q:X8=""  D
 .I $Y>LN W @IOF D HDR
 .W !!,$P(X8,"~",3),?31 D PR1 Q
 S TOT=0 W !!!,"TOTAL RECIPES",?31 S X="" F  S X=$O(TP(X)) Q:X=""  D
 .F K=0:0 S K=$O(TP(X,K)) Q:K<1  D
 ..S Z=$G(T1(X,K)),TOT=TOT+Z
 ..I 'Z W $J("",8)_"  " Q
 ..;W $S(Z#1>0:$J(Z,8,1),1:$J(Z,6)_"  ")_"  " Q
 ..W $S(Z#1>0:$J(Z,8,2),1:$J(Z,8))_"  " Q
 .Q
 ;W $S(TOT#1>0:$J(TOT,9,1),1:$J(TOT,7)) Q
 W $S(TOT#1>0:$J(TOT,9,2),1:$J(TOT,9)) Q
PR1 S FTOT=0,X="" F  S X=$O(TP(X)) Q:X=""  D
 .F K=0:0 S K=$O(TP(X,K)) Q:K<1  D
 ..S Z=$G(^TMP($J,"TOT",X8,K)),FTOT=FTOT+Z,T1(X,K)=T1(X,K)+Z
 ..I 'Z W $J("",8)_"  " Q
 ..;W $S(Z#1>0:$J(Z,8,1),1:$J(Z,6)_"  ")_"  " Q
 ..W $S(Z#1>0:$J(Z,8,2),1:$J(Z,8))_"  " Q
 .Q
 ;W $S(FTOT#1>0:$J(FTOT,9,1),1:$J(FTOT,7)_"  ")
 W $S(FTOT#1>0:$J(FTOT,9,2),1:$J(FTOT,9)_"  ")
 Q
HDR ; Consolidated Recipe List Heading
 S PG=PG+1 W !,HD,!!!?(SL-48\2),"C O N S O L I D A T E D   R E C I P E   L I S T",?(SL-8),"Page ",PG
 W !!?(SL-$L(MEALDT)\2),MEALDT,!!,$S(ALL:"ALL",FHP:$P($G(^FH(119.73,FHP,0)),"^",1),1:$P($G(^FH(119.6,+W1,0)),"^",1)),!
 W !!,"R E C I P E S",?29
 S X="" F  S X=$O(TP(X)) Q:X=""  F K=0:0 S K=$O(TP(X,K)) Q:K=""  W $P(TP(X,K),"^",1)
 W "      Total",! Q
