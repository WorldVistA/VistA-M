FHASN71 ; HISC/NCA - Print Status Average (cont.) ;9/28/95  10:52
 ;;5.5;DIETETICS;;Jan 28, 2005
Q0 ; Process Screening all patients
 K S,DWRD S TOT=""
 F WRD=0:0 S WRD=$O(^FH(119.6,WRD)) Q:WRD<1  F LST=0:0 S LST=$O(^FH(119.6,WRD,"W",LST)) Q:LST<1  S X=+$G(^(LST,0)) S:'$D(DWRD(X)) DWRD(X)=WRD
 F FHDFN=0:0 S FHDFN=$O(^FHPT(FHDFN)) Q:FHDFN<1  I $D(^FHPT(FHDFN,0)) K N S ND=0 D Q1,CALC
 G P0
Q1 ; Tabulate status
 D PATNAME^FHOMUTL I DFN="" Q
 S DGT=EDT+1,DGT=DGT+.0000001,(DGA1,DG1,DGXFR0)="" D ^DGPMSTAT Q:DGA1=""!(DG1="")
 S ADM=DGA1,XX=$G(^DGPM(ADM,0)),DISC=$P(XX,"^",17) S:DISC'="" DISC=$P($G(^DGPM(DISC,0)),"^",1)
 Q:'$D(^FHPT(FHDFN,"A",ADM,0))
 S MW1=$S($P(DG1,"^",1):$P(DG1,"^",1),1:0),W1=$S($D(DWRD(+MW1)):$G(DWRD(+MW1)),1:0)
 I '$D(^FH(119.6,+W1,0)) S MWRD=$P($G(^DIC(42,+MW1,0)),"^",1) S DW1=$O(^FH(119.6,"B",MWRD,0)) Q:DW1<1  S W1=+DW1
 S WD=$P($G(^FH(119.6,+W1,0)),"^",2) S:'WD WD=0
 I '$D(^FHPT(FHDFN,"S",0)) D Q2 Q
 D NS I '$D(^TMP($J,"FHNS")) D Q2 Q
 S NX="" F X4=0:0 S X4=$O(^TMP($J,"FHNS",X4)) Q:X4<1  S X5=$G(^(X4,0)),NX=X4 D CHK
 Q
CHK ; Check if inpat with ADM
 I $P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) D GADM G:'$D(^FHPT(FHDFN,"A",ADM,0)) Q2 G:$P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999) Q2
 I DISC,$P(X5,"^",1)>DISC D GADM Q:'$D(^FHPT(FHDFN,"A",ADM,0))  Q:DISC&($P(X5,"^",1)>DISC)
 S S1=$P(X5,"^",2),D1=$P(X5,"^",3)
 S W1=$S($P(X5,"^",6)'="":$P(X5,"^",6),1:W1) S:'W1 W1=0 S WD=$P($G(^FH(119.6,+W1,0)),"^",2) S:'WD WD=0
 I S1,S1<5 G Q3
Q2 ; Unclassified
 S S1=5,D1=WD
Q3 ; Set Classification
 S X=$S(SRT="W":W1,1:D1) S:'$D(N(X)) N(X)="" S $P(N(X),"^",S1)=$P(N(X),"^",S1)+1,ND=ND+1
 Q
GADM ; Get next ADM for pat
 D PATNAME^FHOMUTL I DFN="" Q
 S NX=$O(^DGPM("ATID1",DFN,NX)) Q:NX=""  S ADM=+$O(^(NX,0)),XX=$G(^DGPM(ADM,0)),DISC=$P(XX,"^",17) S:DISC'="" DISC=$P($G(^DGPM(DISC,0)),"^",1)
 Q:'$D(^FHPT(FHDFN,"A",ADM,0))  Q:$P(X5,"^",1)<$S($D(^FHPT(FHDFN,"A",ADM,0)):$P(^(0),"^",1),1:9999999)
 S W1=$S($P(XX,"^",6):$P(XX,"^",6),1:0),WD=$P($G(^FH(119.6,+W1,0)),"^",2) S:'WD WD=0
 Q
NS ; Nutrition Status in inverse date order
 K ^TMP($J,"FHNS") S FHX1=9999999-(EDT+.3),FHX2=9999999-(SDT+.0001),ZZ=""
 F XX=FHX1:0 S XX=$O(^FHPT(FHDFN,"S",XX)) Q:XX<1!(XX>FHX2)  S X=$G(^(XX,0)) D STOR
 I '$D(^TMP($J,"FHNS")) S XX=FHX1,FHX1=$O(^FHPT(FHDFN,"S",FHX1)) Q:FHX1=""  S X=$G(^(FHX1,0)) D STOR
 Q
STOR ; Store Nutrition Status by inverse date
 I ZZ'=($P(X,"^",1)\1) S ^TMP($J,"FHNS",XX,0)=X
 S ZZ=$P(X,"^",1)\1
 Q
CALC ; Calculate Average
 I $G(N(0))'="" S L=0 D C1
 F L=0:0 S L=$O(N(L)) Q:L<1  D C1
 Q
C1 F K=1:1:5 D
 .S X=$S(ND:$P(N(L),"^",K)/ND,1:"")
 .S X=$J(X,0,0) S:'$D(S(L)) S(L)=""
 .S $P(S(L),"^",K)=$P(S(L),"^",K)+X
 .S $P(S(L),"^",6)=$P(S(L),"^",6)+X
 .S $P(TOT,"^",K)=$P(TOT,"^",K)+X
 .S $P(TOT,"^",6)=$P(TOT,"^",6)+X
 .Q
 Q
P0 ; Print summary
 S DTP=SDT D DTP^FH S DTE=DTP_" to " S DTP=EDT D DTP^FH S DTE=DTE_DTP
 D NOW^%DTC S (NOW,DTP)=% D DTP^FH S PG=0,LN="",$P(LN,"-",100)="" D HDR
 K ^TMP($J) F W1=0:0 S W1=$O(S(W1)) Q:W1=""  D P1
 S NAM="" F W1=0:0 S NAM=$O(^TMP($J,NAM)) Q:NAM=""  S D1=^(NAM) D P2
 I $G(S(0))'="" S D1=$G(S(0)) W ! D
 .W ?16,"UNKNOWN",?48
 .F K=1:1:5 S X=$P(D1,"^",K) W $S(X:$J(X,7),1:$J("",7)) S X=$S($P(D1,"^",6):X/$P(D1,"^",6)*100,1:"") W $S(X:$J(X,5,0),1:$J("",5))
 .S X=$P(D1,"^",6) W $S(X:$J(X,7),1:$J("",7)) Q
 W !?16,LN,!?16,"Grand Total",?48 F K=1:1:5 S X=$P(TOT,"^",K) W $S(X:$J(X,7),1:$J("",7)) S X=$S($P(TOT,"^",6):X/$P(TOT,"^",6)*100,1:"") W $S(X:$J(X,5,0),1:$J("",5))
 S X=$P(TOT,"^",6) W $S(X:$J(X,7),1:$J("",7))
 W ! Q
P1 I SRT="W" S NAM=$P($G(^FH(119.6,+W1,0)),"^",1)
 E  S NAM=$P($G(^VA(200,+W1,0)),"^",1)
 Q:NAM=""  S ^TMP($J,NAM_"~"_W1)=S(W1) Q
P2 D:$Y>(IOSL-8) HDR W !?16,$P(NAM,"~",1),?48
 F K=1:1:5 S X=$P(D1,"^",K) W $S(X:$J(X,7),1:$J("",7)) S X=$S($P(D1,"^",6):X/$P(D1,"^",6)*100,1:"") W $S(X:$J(X,5,0),1:$J("",5))
 S X=$P(D1,"^",6) W $S(X:$J(X,7),1:$J("",7))
 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?16,DTP,!!?42,"N U T R I T I O N   S T A T U S   A V E R A G E",?109,"Page ",PG
 W !!?(132-$L(DTE)\2),DTE
 W !!?16,$S(SRT="C":"CLINICIAN",1:"WARD"),?54,"I    %     II    %    III    %     IV    %    UNC    %  TOTAL",!?16,LN,! Q
