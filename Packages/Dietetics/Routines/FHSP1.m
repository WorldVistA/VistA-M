FHSP1 ; HISC/NCA - Consolidated Standing Orders List ;7/28/94  12:59 
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;11/09/05 - modified for SO patch
 ;if FHOPT=1, it's consolidated
 ;if FHOPT=2,it's print labels
 ;if FHOPT=3, it's tabulated 
E1 ; Set Consolidated List flag
 S FHOPT=1 G E3
E2 ; Set Print Label flag
 S FHOPT=2
E3 S FHP=$O(^FH(119.72,0)) I FHP'<1,$O(^FH(119.72,FHP))<1 G D2
D0 R !!,"Select SERVICE POINT (or ALL): ",X:DTIME G:'$T!("^"[X) KIL D:X="all" TR^FH I X="ALL" S FHP=0
 E  K DIC S DIC="^FH(119.72,",DIC(0)="EMQ" D ^DIC G:Y<1 D0 S FHP=+Y
D2 R !!,"Select Meal (B,N,E,or ALL): ",MEAL:DTIME G:'$T!(U[MEAL) KIL S X=MEAL D TR^FH S MEAL=X S:$P("ALL",MEAL,1)="" MEAL="A"
 I "BNEA"'[MEAL!(MEAL'?1U) W *7,!,"Enter B for Breakfast, N for Noon, E for Evening or ALL for all meals" G D2
 S D3="" G:FHOPT=2 D5
D3 R !!,"Consolidated List Only? Y//",X:DTIME G:'$T!(X="^") KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,"  Answer YES or NO" G D3
 S X=$E(X,1),D3=1 S:X="Y" D3=D3+1
D5 W ! K DIR,LABSTART S DIR(0)="NA^1:10",DIR("A")="If using laser label sheets, what row do you want to begin printing at? ",DIR("B")=1 D ^DIR
 Q:$D(DIRUT)  S LABSTART=Y
 W:'D3 !!,"Place Labels in Printer"
PR K IOP S %ZIS="MQ",%ZIS("A")="Select "_$S('D3:"LABEL",1:"LIST")_" Printer: " W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHSP1",FHLST="D3^FHOPT^FHP^MEAL^LABSTART" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Print Standing Orders List or Labels
 K ^TMP($J),C,D,N S (CHK,N1,PG)=0 D NOW^%DTC S NOW=%,DT=%\1
 S COUNT=0,LINE=1,DTP=NOW D DTP^FH S DTR=DTP
 I FHOPT=2 S LAB=$P($G(^FH(119.9,1,"D",IOS,0)),"^",2) S:'LAB LAB=1
 S FHMLSAV=MEAL
 I MEAL="A" S MEAL="B" D Q2 S MEAL="N" D Q2 S MEAL="E"
 D Q2
 I $G(LAB)>2 D DPLL^FHLABEL Q
 F L=1:1:$S('D3:18,1:1) W !
 Q
Q2 S T0=NOW\1_$S(MEAL="B":".07",MEAL="N":".11",1:".17"),TT=0
 F W1=0:0 S W1=$O(^FH(119.6,W1)) Q:W1<1  D DP I DP'="" D P0 F FHDFN=0:0 S FHDFN=$O(^FHPT("AW",W1,FHDFN)) Q:FHDFN<1  S ADM=^FHPT("AW",W1,FHDFN) D ADD
 ;check and include outpatient stnading orders.
 D ADDO
 ;
 G:FHOPT=2 ^FHSP11
 S DTP=DT D DTP^FH S DTE=DTP_" "_$S(MEAL="B":"Break",MEAL="N":"Noon",1:"Even")
 G:D3=2 CON
 K S F K=0:0 S K=$O(D(K)) Q:K=""  S X=$G(^FH(119.72,K,0)),N2=$P(X,"^",1),N3=$P(X,"^",4) S:N3="" N3=$E(N2,1,6) S S(N3,K)=$E(N3,1,6)
 S A1="" F  S A1=$O(S(A1)) Q:A1=""  F K=0:0 S K=$O(S(A1,K)) Q:K=""  S N2=$G(S(A1,K)) D LST
 K C,D,N Q
ADD Q:ADM<1
 D CHK I K2 F K2=0:0 S K2=$O(^FHPT("ASP",FHDFN,ADM,K2)) Q:K2<1  S Y=^FHPT(FHDFN,"A",ADM,"SP",K2,0) D A1
 Q
 ;
A1 D PATNAME^FHOMUTL I DFN="" Q
 S Y=$P(Y,"^",2,3)_"^"_$P(Y,"^",8) Q:Y?."^"  I FHOPT=2 S Y=Y_"^"_IS,RM=$G(^DPT(DFN,.101)),WRD=P0_$E(WRDN,1,27-$L(RM))_"/"_RM,^TMP($J,"SOL",SP,WRD,FHDFN,K2)=Y Q
 S FHORD=$P(Y,"^",1),M1=$P(Y,"^",2)
 I FHORD,M1[MEAL S:'$D(N(FHORD,SP)) N(FHORD,SP)=0 S Q=$P(Y,"^",3),N(FHORD,SP)=N(FHORD,SP)+$S(Q:Q,1:1) S:'$D(C(MEAL,SP)) C(MEAL,SP)=0 I TT'=FHDFN S C(MEAL,SP)=C(MEAL,SP)+1,TT=FHDFN
 Q
CHK S K2=0,X1=$G(^FHPT(FHDFN,"A",ADM,0)),FHORD=$P(X1,"^",2),IS=$P(X1,"^",10),X1=$P(X1,"^",3) G:FHORD<1 C1
 I IS S IS=$P($G(^FH(119.4,IS,0)),"^",3) S:IS'="N" IS=""
 I X1>1,X1'>T0 G C2
C0 I '$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)) G C2
 S X1=$P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",8) I X1="" G C1
 S:X1="D" X1="T" Q:'$D(S(X1))  S:DP[X1 K2=1 S:K2 SP=S(X1)
C1 K FHORD,A1,K,X1 Q
C2 S A1=0 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"AC",K)) Q:K<1!(K>T0)  S A1=K
 G:'A1 C1 S FHORD=$P(^FHPT(FHDFN,"A",ADM,"AC",A1,0),"^",2) G:FHORD'<1 C0 K ^FHPT(FHDFN,"A",ADM,"AC",A1) G C2
 ;
DP K S S DP=""
 F L=5,6 S X=$P($G(^FH(119.6,W1,0)),"^",L) I X=FHP!('FHP) S:X S($E("TC",L-4))=X,D(X)="",DP=DP_$E("TC",L-4)
 Q
P0 S X=^FH(119.6,W1,0),P0=$P(X,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0),WRDN=$P(X,"^",1) Q
 ;
LST D HDR1 S NX="" F  S NX=$O(^FH(118.3,"B",NX)) Q:NX=""  F KK=0:0 S KK=$O(^FH(118.3,"B",NX,KK)) Q:KK<1  S Z=$G(N(KK,K)) D:$Y>(IOSL-6) HDR1 I Z W !?(80-30\2),$J(Z,6)," ",$P(^FH(118.3,KK,0),"^",1)
 S N1=N1+$G(C(MEAL,K))
 D PP S N1=0 Q
CON K S S L1=36
 F K=0:0 S K=$O(D(K)) Q:K=""  S X=^FH(119.72,K,0),N2=$P(X,"^",1),N3=$P(X,"^",4) S:N3="" N3=$E(N2,1,6) S S(N3,K)=$J(N3,8),L1=L1+8
 S:L1<80 L1=80 D HDR
 S NX="" F  S NX=$O(^FH(118.3,"B",NX)) Q:NX=""  F KK=0:0 S KK=$O(^FH(118.3,"B",NX,KK)) Q:KK<1  I $D(N(KK)) D SOR
 W !!,"# OF PATIENTS",?31
 S X="" F  S X=$O(S(X)) Q:X=""  F K=0:0 S K=$O(S(X,K)) Q:K=""  S Z=$G(C(MEAL,K)) W $S(Z:$J(Z,6),1:$J("",6)),"  " S N1=N1+Z
 W $S(N1:$J(N1,6),1:$J("",6))
 S N1=0 K C,D,N Q
SOR D:$Y>(IOSL-6) HDR
 W !,$P($G(^FH(118.3,KK,0)),"^",1),?31
 S Z1=0,X="" F  S X=$O(S(X)) Q:X=""  F K=0:0 S K=$O(S(X,K)) Q:K=""  S Z=$G(N(KK,K)) W $S(Z:$J(Z,6),1:$J("",6)),"  " S Z1=Z1+Z
 W $S(Z1:$J(Z1,6),1:$J("",6))
 Q
PP W !!?(80-21\2),"**** PATIENTS = ",N1," ****",! Q
HDR ; Header for Consolidated List
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1
 W !,DTR,?(L1-11),"Page ",PG,!!?(L1-55\2),"C O N S O L I D A T E D   S T A N D I N G   O R D E R S",!!?(L1-$L(DTE)\2),DTE,!!?29
 S X="" F  S X=$O(S(X)) Q:X=""  F K=0:0 S K=$O(S(X,K)) Q:K=""  W S(X,K)
 W "   TOTAL",! Q
HDR1 ; Header for Standing Order List
 W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !,DTR,?69,"Page ",PG,!!?20,"S T A N D I N G   O R D E R S   L I S T"
 W !?(80-$L(N2)\2),N2,!?(80-$L(DTE)\2),DTE,! Q
 ;
ADDO ;process outpatient STANDING ORDER for consolidated, print labels and tabulated reports.
 S IS=""
 F FHI=0:0 S FHI=$O(^FHPT("ASPO",FHI)) Q:FHI'>0  F FHJ=0:0 S FHJ=$O(^FHPT("ASPO",FHI,FHJ)) Q:FHJ'>0  D
 .S FHOPDAT=^FHPT(FHI,"OP",FHJ,0)
 .S FHDATE=$P(FHOPDAT,U,1)
 .Q:$P(FHOPDAT,U,15)="C"
 .Q:FHDATE'=DT
 .S RM="",RMIEN=$P(FHOPDAT,U,18) I $G(RMIEN),$D(^DG(405.4,RMIEN,0)) S RM=$E($P(^DG(405.4,RMIEN,0),U,1),1,10)
 .S FHLOC=$P(FHOPDAT,U,3)
 .F K2=0:0 S K2=$O(^FHPT("ASPO",FHI,FHJ,K2)) Q:K2'>0  D
 ..S Y=^FHPT(FHI,"OP",FHJ,"SP",K2,0),(SP,WRD)="***"
 ..Q:$P(Y,U,6)   ;quit if cancelled.
 ..S (FHLODAT,FHSER1,FHSER2,FHSERV,FHSRFLG,WRDN,P0)=""
 ..I $G(FHLOC),$D(^FH(119.6,FHLOC,0)) S FHLODAT=^FH(119.6,FHLOC,0)
 ..I FHLODAT'="" S WRDN=$P(FHLODAT,U,1),FHSER1=$P(FHLODAT,U,5),FHSER2=$P(FHLODAT,U,6),P0=$P(FHLODAT,"^",4),P0=$S(P0<1:99,P0<10:"0"_P0,1:P0)
 ..I $G(FHSER1) S SP=FHSER1
 ..I SP="***",$G(FHSER2) S SP=FHSER2
 ..I $G(FHP),$G(FHSER1),FHP=FHSER1 S FHSRFLG=1
 ..I $G(FHP),$G(FHSER2),FHP=FHSER2 S FHSRFLG=1
 ..I $G(FHP),'$G(FHSRFLG) Q
 ..S FHMLOUT=$P(FHOPDAT,U,4)
 ..I MEAL'=FHMLOUT Q
 ..S FHDFN=FHI,ADM=FHJ
 ..S Y=$P(Y,"^",2,3)_"^"_$P(Y,"^",8) Q:Y?."^"
 ..I FHOPT=2 S Y=Y_"^"_IS,WRD=P0_$E(WRDN,1,20-$L(RM))_"/"_RM,^TMP($J,"SOL",SP,WRD,FHDFN,K2)=Y Q
 ..S FHORD=$P(Y,"^",1),M1=$P(Y,"^",2)
 ..I FHOPT=1,FHORD,M1[MEAL S:'$D(N(FHORD,SP)) N(FHORD,SP)=0 S Q=$P(Y,"^",3),N(FHORD,SP)=N(FHORD,SP)+$S(Q:Q,1:1) S:'$D(C(MEAL,SP)) C(MEAL,SP)=0 I TT'=FHDFN S C(MEAL,SP)=C(MEAL,SP)+1,TT=FHDFN
 ..I FHOPT=3,FHORD,M1[MEAL S:'$D(N(FHORD)) N(FHORD)=0 S Q=$P(Y,"^",3),N(FHORD)=N(FHORD)+$S(Q:Q,1:1)
 Q
 ;
KIL K ^TMP($J) G KILL^XUSCLEAN
 ;
EVNT Q:FHCNSOF=0  S:'$D(FHDTP) FHDTP=""
 I $D(FHDT1) S DTP=FHDT1 D DTP^FH S FHDTP=DTP
 I $D(FHDT2) S DTP=FHDT2 D DTP^FH S:FHDTP'=DTP FHDTP=FHDTP_" to "_DTP
 S FHACT="O",FHTXT="Outpatient Standing Order: "_NUM_" "_$P($G(^FH(118.3,SP,0)),U,1)_" ("_FHALML_"), "_FHLOCN_", "_FHDTP D OPFILE^FHORX
 Q
