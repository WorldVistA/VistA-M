FHMTK21 ; HISC/NCA - List Diet Patterns (cont.) ;5/1/95  11:46
 ;;5.5;DIETETICS;;Jan 28, 2005
L1 ; List the Diet Pattern(s)
 K ^TMP($J) D NOW^%DTC S DTP=% D DTP^FH S PG=0,RES="" D HDR
 I ANS'?1"Y".E S MP=+FHDA,X=$G(^FH(111.1,MP,0)) D L2 G PRT
 F MP=0:0 S MP=$O(^FH(111.1,MP)) Q:MP<1  S X=$G(^(MP,0)) D L2
 G PRT
L2 S PD=$P(X,"^",7) Q:'PD
 S NAM=$P(X,"^",1),FHPD=$P($G(^FH(116.2,PD,0)),"^",1),NM=$P(X,"^",8),SF=$P($G(^FH(118.1,+NM,0)),"^",1)
 S P0=$P($G(^FH(116.2,PD,0)),"^",6),P0=$S('P0:99,P0<10:"0"_P0,1:P0)
 S P0=P0_"~"_FHPD
 S:'$D(^TMP($J,"FHPD",P0)) ^TMP($J,"FHPD",P0)=PD S M0=NAM
 S ^TMP($J,"FHO",PD,M0)=MP_"^"_SF
 F MEAL="B","N","E" D L3
 F MEAL="BS","NS","ES" D L5
 F R1=0:0 S R1=$O(^FH(111.1,MP,"RES",R1)) Q:R1<1  S FP=$G(^(R1,0)) D
 .Q:$P(FP,"^",2)=""
 .S K1=99_R1,K1=K1_"~"_$E($P($G(^FH(115.2,+FP,0)),"^",1),1,30)
 .F MEAL="B","N","E" I $P(FP,"^",2)[MEAL S ^TMP($J,"FHFP",MP,MEAL,K1)=""
 .Q
 Q
L3 ; Get Diet pattern in print order
 S LP=0
L4 S LP=$O(^FH(111.1,MP,MEAL,LP)) Q:LP<1  S R1=$G(^(LP,0))
 S K1=$P($G(^FH(114.1,+R1,0)),"^",3)
 S K1=$S('K1:99,K1<10:"0"_K1,1:K1)
 S K1=K1_"~"_$E($P($G(^FH(114.1,+R1,0)),"^",1),1,15)
 S ^TMP($J,"FHMP",MP,MEAL,K1)=$P(R1,"^",2)_"^"_+R1
 G L4
L5 ; Get Standing Orders associated with Diet pattern
 S LP=0
L6 S LP=$O(^FH(111.1,MP,MEAL,LP)) Q:LP<1  S R1=$G(^(LP,0))
 S K1=99_LP,K1=K1_"~"_$E($P($G(^FH(118.3,+R1,0)),"^",1),1,30)
 S ^TMP($J,"FHMP",MP,$E(MEAL,1),K1)=$P(R1,"^",2)_"^"_+R1
 G L6
PRT ; Print Diet Pattern
 S P0="" F  S P0=$O(^TMP($J,"FHPD",P0)) Q:P0=""!(RES="^")  S PD=+$G(^(P0)),M0="" F  S M0=$O(^TMP($J,"FHO",PD,M0)) Q:M0=""  S MP=+$G(^(M0)),SF=$P($G(^(M0)),"^",2) D P1,P2 Q:RES="^"
 Q
P1 K MM S CTR=0 F MEAL="B","N","E" S N1=0,CTR=CTR+1 D
 .S NX="" F  S NX=$O(^TMP($J,"FHMP",MP,MEAL,NX)) Q:NX=""  S QTY=$G(^(NX)) D
 ..S QTY=$S(QTY="":1,1:+QTY),N1=N1+1
 ..S PAD=$E("    ",1,4-$L(QTY)),MM(N1,CTR)=PAD_QTY_" "_$E($P(NX,"~",2),1,21)
 ..;S MM(N1,CTR)=$S(QTY#1>0:$J(QTY,3,1),1:QTY_"  ")_" "_$E($P(NX,"~",2),1,21)
 ..Q
 .S R1="" F  S R1=$O(^TMP($J,"FHFP",MP,MEAL,R1)) Q:R1=""  S N1=N1+1,MM(N1,CTR)=$J("",4)_$E($P(R1,"~",2),1,21)
 .Q
 Q
P2 I $Y'<(IOSL-8) D HDR Q:RES="^"
 W !!,"Production Diet: ",$P(P0,"~",2),!,"Diet Order: ",M0
 W !,"Associated Supp. Fdgs. Menu: ",$E(SF,1,30),!
 W ! F N1=1:1 W ! Q:'$D(MM(N1))!(RES="^")  F CTR=1:1:3 I $D(MM(N1,CTR)) D  Q:RES="^"
 .I $Y'<(IOSL-6) D HDR Q:RES="^"
 .W ?$S(CTR=1:0,CTR=2:27,1:54),MM(N1,CTR) Q
 Q
HDR D PAUSE Q:RES="^"  W:'($E(IOST,1,2)'="C-"&'PG) @IOF
 S PG=PG+1 W !,DTP,?23,"D I E T   P A T T E R N   L I S T",?73,"Page ",PG
 W !,"-------------------------------------------------------------------------------",!
 W ! F CT=1:1:3 W ?$S(CT=1:8,CT=2:38,1:63),$S(CT=1:"BREAKFAST",CT=2:"NOON",1:"EVENING")
 W ! Q
PAUSE ; Check to pause for reading
 I PG,IOST?1"C-".E R !!,"Press RETURN to continue or ""^"" to exit. ",RES:DTIME S:'$T!(RES["^") RES="^" Q:RES="^"  I "^"'[RES W !,"Enter Return or ""^""." G PAUSE
 Q
