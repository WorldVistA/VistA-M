FHXDB ; HISC/REL - Verify data base pointers ;5/14/93  15:50 
 ;;5.5;DIETETICS;;Jan 28, 2005
PAT R !!,"Verify Patient data (ALL, INPATIENTS, NONE): ",PAT:DTIME G:'$T!("^"[PAT) KIL S X=PAT D TR^FH S PAT=X I $P("ALL",PAT,1)'="",$P("INPATIENTS",PAT,1)'="",$P("NONE",PAT,1)'="" W *7,"  Enter A, I or N" G PAT
 S PAT=$E(PAT,1)
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP I POP G KIL
 I $D(IO("Q")) S FHPGM="Q1^FHXDB",FHLST="PAT" D EN2^FH G KIL
 U IO D Q1 D ^%ZISC K %ZIS,IOP G KIL
Q1 ; Process verifying pointer structures
 W:$E(IOST,1,2)="C-" @IOF W !!,"VERIFICATION OF DIETETIC POINTER STRUCTURES"
 W !!,"Verifying file 111 - Diets"
 F K=0:0 S K=$O(^FH(111,K)) Q:K<1  S N=$P(^(K,0),"^",5) I N,'$D(^FH(116.2,N,0))#2 W !?5,"Production diet ",N," missing from Diet ",K," - ",$P(^FH(111,K,0),"^",1)
 W !!,"Verifying file 112.6 - User Menu"
 F K=0:0 S K=$O(^FHUM(K)) Q:K<1  F L=0:0 S L=$O(^FHUM(K,1,L)) Q:L<1  D U0
 W !!,"Verifying file 115.2 - Food Preferences"
 F K=0:0 S K=$O(^FH(115.2,K)) Q:K<1  D FP
 W !!,"Verifying file 115.7 - Dietetic Encounters"
 F K=0:0 S K=$O(^FHEN(K)) Q:K<1  D EN
 W !!,"Verifying file 116.2 - Production Diets"
 F K=0:0 S K=$O(^FH(116.2,K)) Q:K<1  D P0
 W !!,"Verifying file 118 - Supplemental Feedings"
 F K=0:0 S K=$O(^FH(118,K)) Q:K<1  D:K'=1 S0
 W !!,"Verifying file 118.1 - Supplemental Feeding Menu"
 F K=0:0 S K=$O(^FH(118.1,K)) Q:K<1  D S1
 W !!,"Verifying file 118.2 - Tubefeeding"
 F K=0:0 S K=$O(^FH(118.2,K)) Q:K<1  D TF
 W !!,"Verifying file 119.6 - Dietetics Ward"
 F K=0:0 S K=$O(^FH(119.6,K)) Q:K<1  D W0
 G ^FHXDB1
S1 S X=$G(^FH(118.1,K,1))
 F L=1:2:23 S N=$P(X,"^",L) I N,'$D(^FH(118,N,0))#2 W !?5,"Supp. Feeding ",N," missing in Menu ",K," - ",$P(^FH(118,K,0),"^",1)
 Q
U0 F M=0:0 S M=$O(^FHUM(K,1,L,1,M)) Q:M<1  F N=0:0 S N=$O(^FHUM(K,1,L,1,M,1,N)) Q:N<1  S X=+^(N,0) I '$D(^FHNU(X,0))#2 W !?5,"Nutrient item ",X," missing in User Menu ",K," day ",L," meal ",M," - ",$P(^FHUM(K,0),"^",1)
 Q
FP S X=$P($G(^FH(115.2,K,0)),"^",4)
 I X,'$D(^FH(114,X,0))#2 W !?5,"Recipe ",X," missing in Food Preference ",K," - ",$P(^FH(115.2,K,0),"^",1)
 F L=0:0 S L=$O(^FH(115.2,K,"X",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(114,N,0))#2 W !?5,"Recipe ",N," missing in Excluded Food Preference ",K," - ",$P(^FH(115.2,K,0),"^",1)
 Q
EN S X=$P($G(^FHEN(K,0)),"^",4)
 I X,'$D(^FH(115.6,X,0))#2 W !?5,"Encounter Type ",X," missing in Dietetic Encounters ",K
 Q
W0 S X=^FH(119.6,K,0) F L=5,6 S N=$P(X,"^",L) I N,'$D(^FH(119.72,N,0))#2 W !?5,"Service Point ",N," missing in Ward File ",K," - ",$P(^FH(119.6,K,0),"^",1)
 S N=$P(X,"^",9) I N,'$D(^FH(119.74,N,0))#2 W !?5,"Supplemental Fdg. Site ",N," missing in Ward File ",K," - ",$P(^FH(119.6,K,0),"^",1)
 S N=$P(X,"^",8) I N,'$D(^FH(119.73,N,0))#2 W !?5,"Communication Office ",N," missing in Ward File ",K," - ",$P(^FH(119.6,K,0),"^",1)
 S N=$P(X,"^",15) I N,'$D(^FH(111,N,0))#2 W !?5,"Diet ",N," missing from Ward File ",K," - ",$P(^FH(119.6,K,0),"^",1)
 F L=0:0 S L=$O(^FH(119.6,K,"BN",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(118,N,0))#2 W !?5,"Supp. Feeding ",N,"missing in Ward File ",K," - ",$P(^FH(119.6,K,0),"^",1)
 Q
P0 F L=0:0 S L=$O(^FH(116.2,K,"R",L)) Q:L<1  S N=+^(L,0) I '$D(^FH(116.2,N,0))#2 W !?5,"Singular Production Diet ",N," missing in Prod. Diet ",K," - ",$P(^FH(116.2,K,0),"^",1)
 Q
S0 S X=$P($G(^FH(118,K,0)),"^",7)
 I '$D(^FH(114,+X,0))#2 W !?5,"Recipe ",X," missing in Supplemental Feeding ",K," - ",$P(^FH(118,K,0),"^",1)
 Q
TF S X=$P($G(^FH(118.2,K,0)),"^",7)
 I '$D(^FH(114,+X,0))#2 W !?5,"Recipe ",X," missing in Tubefeeding ",K," - ",$P(^FH(118.2,K,0),"^",1)
 Q
KIL G KILL^XUSCLEAN
