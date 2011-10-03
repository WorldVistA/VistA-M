FHORC3 ; HISC/REL - Consult Statistics ;5/17/93  14:54 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D DT G:U[X KIL
F0 R !!,"Break-down by Clinician? Y// ",X:DTIME G:'$T!(X=U) KIL S:X="" X="Y" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G F0
 S FHX1=X?1"Y".E,FHX2=0
F1 I FHX1 R !!,"List Individual Patient Consults? N// ",X:DTIME G:'$T!(X=U) KIL S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7," Answer YES or NO" G F1
 S:FHX1 FHX2=X?1"Y".E
 K IOP,%ZIS S %ZIS("A")="Print on Device: ",%ZIS="MQ" W ! D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHORC3",FHLST="EDT^SDT^FHX1^FHX2" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
Q1 ; Print Consult Statistics
 K D,^TMP($J) S X1=SDT\1-.0001,X2=EDT\1+.3
R1 S X1=$O(^FHPT("ADR",X1)) I X1<1!(X1>X2) G P1
 S FHDFN=0
R2 S FHDFN=$O(^FHPT("ADR",X1,FHDFN)) G:FHDFN="" R1 S ADM=0
R3 S ADM=$O(^FHPT("ADR",X1,FHDFN,ADM)) G:ADM="" R2 S DR=0
R4 S DR=$O(^FHPT("ADR",X1,FHDFN,ADM,DR)) G:DR="" R3
 S Y=^FHPT(FHDFN,"A",ADM,"DR",DR,0)
 S ST=$P(Y,"^",8) I ST'="C" G R4
 S D1=$P(Y,"^",5),D2=$P(Y,"^",2) G:'D2 R4
 S S1=$P(Y,"^",11) S:S1="F" D2=D2_"F"
 S:'$D(D(D2)) D(D2)=0 S D(D2)=D(D2)+1
 G R4:'FHX1,R4:'D1 I '$D(^TMP($J,D1)) S NAM=$P(^VA(200,D1,0),"^",1),^TMP($J,$E(NAM,1,30),D1)=""
 I '$D(^TMP($J,D1,D2)) S ^TMP($J,D1,D2)=0
 S ^TMP($J,D1,D2)=^TMP($J,D1,D2)+1 G:'FHX2 R4
 S (DTP,W1)=$P(Y,"^",1)\1 D DTP^FH I '$D(^TMP($J,D1,D2,W1)) S ^TMP($J,D1,D2,W1)=DTP,^(W1,0)=0
 S L=^TMP($J,D1,D2,W1,0)+1,^(0)=L
 S ^TMP($J,D1,D2,W1,L)=FHDFN G R4
P1 S DTP=SDT\1 D DTP^FH S DTE=DTP_" to " S DTP=EDT\1 D DTP^FH S DTE=DTE_DTP,PG=0 D HEAD W !?59,"Number        Units",!
 S NX="",(I1,I2)=0 F K=0:0 S NX=$O(D(NX)) Q:NX=""  S X=^FH(119.5,+NX,0),W1=$P(X,"^",$S(NX'["F":4,1:5)) W !,$P(X,"^",1) W:NX["F" " (FU)" W ?60,$J(D(NX),5,0),$J(D(NX)*W1,13,2) S I1=I1+D(NX),I2=D(NX)*W1+I2
 W !!,"T O T A L",?60,$J(I1,5,0),$J(I2,13,2),! Q:'FHX1  D HEAD
 S NX=":" F K=0:0 S NX=$O(^TMP($J,NX)) Q:NX=""  F D1=0:0 S D1=$O(^TMP($J,NX,D1)) Q:D1<1  D P2
 W ! Q
P2 D:$Y>55 HEAD W !!,NX S (I1,I2)=0
 S D2="" F L=0:0 S D2=$O(^TMP($J,D1,D2)) Q:D2=""  S D(0)=^(D2) D P3
 W !?3,"TOTAL CONSULTS",?63,$J(I1,5,0),$J(I2,10,2) Q
P3 S X=^FH(119.5,+D2,0),W1=$P(X,"^",$S(D2'["F":4,1:5)) D:$Y>58 HEAD W !?3,$P(X,"^",1) W:D2["F" " (FU)" W ?63,$J(D(0),5,0),$J(D(0)*W1,10,2) S I1=I1+D(0),I2=D(0)*W1+I2
 Q:'FHX2  S DTP=""
P4 S DTP=$O(^TMP($J,D1,D2,DTP)) Q:DTP=""  S D(0)=^(DTP),W1=0
P5 S W1=$O(^TMP($J,D1,D2,DTP,W1)) G:W1="" P4 S FHDFN=^(W1)
 D PATNAME^FHOMUTL I DFN="" Q
 S Y=$G(^DPT(DFN,0)) G:Y="" P5 D PID^FHDPA
 W !?6,D(0),?17,BID,?27,$P(Y,"^",1) G P5
DT ; Get From/To Dates
D1 S %DT="AEPX",%DT("A")="Starting Date: " W ! D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D1 S SDT=+Y
D2 S %DT="AEPX",%DT("A")=" Ending Date: " D ^%DT S:$D(DTOUT) X="^" Q:U[X  G:Y<1 D2 S EDT=+Y
 I EDT<SDT W *7,"  [End before Start?] " G D1
 Q
HEAD W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?17,"D I E T E T I C   C O N S U L T   U N I T S",?71,"Page ",PG
 W !!?(78-$L(DTE)\2),DTE,! Q
