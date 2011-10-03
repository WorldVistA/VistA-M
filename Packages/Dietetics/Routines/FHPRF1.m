FHPRF1 ; HISC/REL/RVD - Calculate Total Forecast ;1/23/98  16:10
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;
 ;patch #5 - added screen for cancelled quest meals.
 ;
 S %DT="X",X="T" D ^%DT S DT=+Y
 D DIV^FHOMUTL G:'$D(FHSITE) KIL
D1 R !!,"Forecast Date: ",X:DTIME G:'$T!("^"[X) KIL S %DT="EX" D ^%DT G KIL:"^"[X,D1:Y<1 S D1=+Y
 S FHP=$O(^FH(119.71,0)) I FHP'<1,$O(^FH(119.71,FHP))<1 G R1
R0 R !!,"Select PRODUCTION FACILITY: ",X:DTIME G:'$T!("^"[X) KIL
 K DIC S DIC="^FH(119.71,",DIC(0)="EMQ" D ^DIC G:Y<1 R0 S FHP=+Y
R1 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="Q1^FHPRF1",FHLST="D1^FHP^FHSITE^FHSITENM" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process Census Forecast
 D Q2,Q3
 ;get outpatient data
 S FHD1SAV=D1
 S:'$G(FHSITE) FHSITE=""
 S:'$D(FHSITENM) FHSITENM="CONSOLIDATED"
 D GETSM^FHOMRBLD(D1,FHSITE,"","")
 D GETGM^FHOMRBL1(D1,FHSITE,"","")
 S D1=D1-.000001
 D GETRM^FHOMRBLD(D1,FHSITE,"","")
 D PROSG   ;process recurring, special and guest meal from "OP" node
 S D1=FHD1SAV
 G ^FHPRF1A
Q2 ; Calculate Service Point census forecast
 S X="T",%DT="X" D ^%DT S DT=+Y
 K ^TMP($J) S X=D1 D DOW^%DTC S DOW=Y+1 D BLD,DAT
 F W1=0:0 S W1=$O(^TMP($J,"W",W1)) Q:W1<1  D WRD S ^TMP($J,"W",W1)=S1
 K D,DC S X1=DT,X2=-1 D C^%DTC S D2=X
 F P0=0:0 S P0=$O(^TMP($J,"S",P0)) Q:P0<1  D ADD S ^TMP($J,P0)=S1
 Q
Q3 F P0=0:0 S P0=$O(^TMP($J,P0)) Q:P0<1  S S1=^(P0) D PER S ^TMP($J,P0)=S0
 F K=0:0 S K=$O(D(K)) Q:K<1  S ^TMP($J,0,K)=D(K)
 K D,^TMP($J,"W"),^TMP($J,"S") Q
WRD S (A,B,CT,S1,S2,S3,S4)=0 F K=1:1:9 S Y=$P($G(^DG(41.9,W1,"C",D(K),0)),"^",2) I Y S CT=CT+1,S0=10-K,S1=S1+S0,S2=S0*S0+S2,S3=S3+Y,S4=S0*Y+S4
 G:'CT W1 I CT=1 S S1=S3 G W1
 S S0=S1*S1/CT-S2,A=S1*S3/CT-S4/S0,B=S3/CT-(A*S1/CT)
 S A=$J(A,0,3),B=$J(B,0,2),S1=10*A+B
W1 S (N1,C2,C3)=0 F K=1:1:7 S Y0=$P($G(^DG(41.9,W1,"C",DC(K),0)),"^",2) I Y0 S N1=N1+1,C2=Y0-S1*(4-N1)+C2,C3=4-N1+C3 Q:N1=3
 I N1 S C2=C2/C3,S1=S1+C2
 S S1=$J(S1,0,0) Q
ADD S (S1,CT)=0 F W1=0:0 S W1=$O(^TMP($J,"S",P0,W1)) Q:W1<1  S Z=^(W1),T0=$G(^TMP($J,"W",W1)),CT=CT+T0,S1=Z*T0/100+S1
 S S1=$J(S1,0,0)
 I '$D(^FH(119.72,P0,"C",D1,0)) S ^(0)=D1 I '$D(^FH(119.72,P0,"C",0)) S ^(0)="^119.722DA^^"
 I D1'<DT S C2=$P(^FH(119.72,P0,"C",D1,0),"^",3),$P(^(0),"^",2,5)=CT_"^"_C2_"^"_S1_"^"_DT
 Q:'$D(^FH(119.72,P0,"C",DT,0))  S C2=0
 F W1=0:0 S W1=$O(^TMP($J,"S",P0,W1)) Q:W1<1  S C2=C2+$P($G(^DG(41.9,W1,"C",D2,0)),"^",2)
 S:C2 $P(^FH(119.72,P0,"C",DT,0),"^",3)=C2 Q
PER S S0=0 F K=0:0 S K=$O(^FH(119.72,P0,"A",K)) Q:K<1  S Z=$P($G(^(K,0)),"^",DOW+1),Z=$J(Z*S1/100,0,0) I Z S ^TMP($J,P0,K)=Z,S0=S0+Z,D(K)=$G(D(K))+Z
 Q
DAT ; Build list of dates
 K D,DC S X1=D1,X2=-1 D C^%DTC S D2=X
 F K=1:1:9 S X1=D2,X2=-7 D C^%DTC S D(K)=X,D2=X
 S D2=D1 F K=1:1:7 S X1=D2,X2=-1 D C^%DTC S DC(K)=X,D2=X
 Q
BLD ; Build list of MAS wards and %'s for each Service Point
 K ^TMP($J,"S"),^TMP($J,"W")
 F P0=0:0 S P0=$O(^FH(119.72,P0)) Q:P0<1  S X=$G(^(P0,0)) I $P(X,"^",3)=FHP,$G(^FH(119.72,P0,"I"))'="Y" S ^TMP($J,"S",P0)=""
 ;F K1=0:0 S K1=$O(^FH(119.6,K1)) Q:K1<1  S X=$G(^(K1,0)) D B1
 F K1=0:0 S K1=$O(^FH(119.6,K1)) Q:K1<1  S X=$G(^(K1,0)) D B1:($P(X,U,8)=FHSITE!(FHSITE=0))
 Q
B1 S Z=$P(X,"^",5) I Z,$D(^TMP($J,"S",Z)) S Z1=$P(X,"^",17) S:$P(X,"^",7) Z1=Z1+$P(X,"^",19) S:'Z1 Z1=100 D B2
 S Z=$P(X,"^",6) I Z,$D(^TMP($J,"S",Z)) S Z1=$P(X,"^",18) S:Z1="" Z1=100 D B2
 Q
B2 F L2=0:0 S L2=$O(^FH(119.6,K1,"W",L2)) Q:L2<1  S ZW=+$G(^(L2,0)) I ZW S ^TMP($J,"W",ZW)="",^TMP($J,"S",Z,ZW)=Z1
 Q
 ;
PROSG ;process outpatient data from ^tmp($j global
 S FHPLNM=""
 S:$G(FHSITE) FHPLNM=$P($G(^FH(119.73,FHSITE,0)),U,1)
RECUR ;recurring meals
 S FHDT=D1+.999999
 S FHTMPS="^TMP($J,""OP"",""R"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>FHDT)  D
 ..S (FHPDIET,FHLOC,FHSER,FHDIET)="***"
 ..S FHIJKDAT=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..Q:$P(FHIJKDAT,U,19)="C"   ;quit if status is cancelled.
 ..S FHDIET=$P(FHIJKDAT,U,3),FHDIET=$O(^FH(111,"B",FHDIET,0))
 ..I $G(FHDIET),$D(^FH(111,FHDIET,0)) S FHPDIET=$P(^FH(111,FHDIET,0),U,5)
 ..S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 ..S:$G(FHLOC) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,5)
 ..S:'$G(FHSER) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,6)
 ..S:'$G(FHSER) FHSER=$O(^FH(119.72,0))
 ..I $D(^FH(119.72,FHSER,0)),$P(^FH(119.72,FHSER,0),U,3)'=FHP Q
 ..S:$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=^TMP($J,FHSER)+1
 ..S:'$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=1
 ..I $D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=^TMP($J,FHSER,FHPDIET)+1
 ..I '$D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=1
 ..I $D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=^TMP($J,0,FHPDIET)+1
 ..I '$D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=1
 ;
SPEC ;special meals
 S FHTMPS="^TMP($J,""OP"",""S"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>FHDT)  D
 ..S (FHPDIET,FHLOC,FHSER,FHDIET)="***"
 ..S FHIJKDAT=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..S FHDIET=$P(FHIJKDAT,U,4),FHDIET=$O(^FH(111,"B",FHDIET,0))
 ..S:$D(^FH(111,FHDIET,0)) FHPDIET=$P(^FH(111,FHDIET,0),U,5)
 ..S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 ..S:$G(FHLOC) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,5)
 ..S:'$G(FHSER) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,6)
 ..S:'$G(FHSER) FHSER=$O(^FH(119.72,0))
 ..I $D(^FH(119.72,FHSER,0)),$P(^FH(119.72,FHSER,0),U,3)'=FHP Q
 ..S:$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=^TMP($J,FHSER)+1
 ..S:'$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=1
 ..I $D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=^TMP($J,FHSER,FHPDIET)+1
 ..I '$D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=1
 ..I $D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=^TMP($J,0,FHPDIET)+1
 ..I '$D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=1
 ;
GUEST ;guest meals
 S FHTMPS="^TMP($J,""OP"",""G"")"
 S FHN="" F  S FHN=$O(@FHTMPS@(FHN)) Q:FHN=""  S FHI="" F  S FHI=$O(@FHTMPS@(FHN,FHI)) Q:FHI=""  S FHJ="" F  S FHJ=$O(@FHTMPS@(FHN,FHI,FHJ)) Q:FHJ=""  D
 .I (FHPLNM'=""),(FHN'=FHPLNM) Q
 .F FHK=0:0 S FHK=$O(@FHTMPS@(FHN,FHI,FHJ,FHK)) Q:(FHK'>0)!(FHK>FHDT)  D
 ..S (FHPDIET,FHLOC,FHSER,FHDIET)="***"
 ..S FHIJKDAT=@FHTMPS@(FHN,FHI,FHJ,FHK)
 ..Q:$P(FHIJKDAT,U,7)="C"
 ..S FHDIET=$P($G(^FH(119.9,1,0)),U,2)   ;default diet from 119.9
 ..S FHDIETN=$P(FHIJKDAT,U,6)  ;diet from guest meal
 ..S:$D(^FH(119.6,"B",FHI)) FHLOC=$O(^FH(119.6,"B",FHI,0))
 ..S:$G(FHLOC) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,5)
 ..S:'$G(FHSER) FHSER=$P($G(^FH(119.6,FHLOC,0)),U,6)
 ..S:'$G(FHSER) FHSER=$O(^FH(119.72,0))
 ..I $D(^FH(119.72,FHSER,0)),$P(^FH(119.72,FHSER,0),U,3)'=FHP Q
 ..S:$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=^TMP($J,FHSER)+1
 ..S:'$D(^TMP($J,FHSER)) ^TMP($J,FHSER)=1
 ..I $G(FHDIETN),($D(^FH(111,FHDIETN,0))) D
 ...S FHPDIET=$P(^FH(111,FHDIETN,0),U,5)
 ..I $D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=^TMP($J,FHSER,FHPDIET)+1
 ..I '$D(^TMP($J,FHSER,FHPDIET)) D
 ...S ^TMP($J,FHSER,FHPDIET)=1
 ..I $D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=^TMP($J,0,FHPDIET)+1
 ..I '$D(^TMP($J,0,FHPDIET)) S ^TMP($J,0,FHPDIET)=1
 Q
 ;
KIL K ^TMP($J) G KILL^XUSCLEAN
