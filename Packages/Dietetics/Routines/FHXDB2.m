FHXDB2 ; HISC/REL - Verify patient data base ;11/27/91  13:00 
 ;;5.5;DIETETICS;;Jan 28, 2005
 D ALL:PAT="A",INP:PAT="I" W !!,"***** D O N E *****",! Q
ALL W !!,"Verifying Patient data base ^FHPT for ALL Patients & Admissions",!
 F FHDFN=0:0 S FHDFN=$O(^FHPT(FHDFN)) Q:FHDFN<1  D PATNAME^FHOMUTL Q:DFN=""  D PAT F ADM=0:0 S ADM=$O(^FHPT(FHDFN,"A",ADM)) Q:ADM<1  D ADM
 Q
INP W !!,"Verifying Patient data base ^FHPT for Current Inpatients Only",!
 S WRD="" F M=0:0 S WRD=$O(^DPT("CN",WRD)) Q:WRD=""  F DFN=0:0 S DFN=$O(^DPT("CN",WRD,DFN)) Q:DFN<1  S FHZ115="P"_DFN D CHECK^FHOMDPA Q:FHDFN=""  D PAT S ADM=^DPT("CN",WRD,DFN) Q:ADM<1  D ADM
 Q
PAT S ERR=0
 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=+^(K,0) I '$D(^FH(115.2,X,0))#2 W !,$P(^DPT(DFN,0),"^",1)," - missing Food Preference ",X
 F K=0:0 S K=$O(^FHPT(FHDFN,"N",K)) Q:K<1  S X=^(K,0) D P1
 F K=0:0 S K=$O(^FHPT(FHDFN,"S",K)) Q:K<1  S X=$P(^(K,0),"^",2) I X,'$D(^FH(115.4,X,0))#2 W !,$P(^DPT(DFN,0),"^",1)," - missing Nutrition Status ",X
 Q
P1 S N=$P(X,"^",19) I N,'$D(^FH(115.4,N,0))#2 W !,$P(^DPT(DFN,0),"^",1)," - missing Nutrition Status ",N
 S N=$P(X,"^",20) I N,'$D(^FH(115.3,N,0))#2 W !,$P(^DPT(DFN,0),"^",1)," - missing Nutrition Classification ",N
 Q
ADM S ERR=0
 S N=$P(^FHPT(FHDFN,"A",ADM,0),"^",10) I N,'$D(^FH(119.4,N,0))#2 D HDR W !?5,"Isolation ",N," missing."
 S N=$P(^FHPT(FHDFN,"A",ADM,0),"^",8) I N,'$D(^FH(119.6,N,0))#2 D HDR W !?5,"Dietetic Ward ",N," missing."
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DI",K)) Q:K<1  S X=^(K,0) D DI
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"SF",K)) Q:K<1  S X=^(K,0) D SF
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"TF",K)) Q:K<1  F L=0:0 S L=$O(^FHPT(FHDFN,"A",ADM,"TF",K,"P",L)) Q:L<1  S N=+^(L,0) D TF
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"SP",K)) Q:K<1  S N=+$P(^(K,0),"^",2) D SP
 F K=0:0 S K=$O(^FHPT(FHDFN,"A",ADM,"DR",K)) Q:K<1  S N=+$P(^(K,0),"^",2) D DR
 Q
HDR Q:ERR  W !,$P(^DPT(DFN,0),"^",1),?40,"Admission: ",ADM S ERR=1 Q
DI F L=2:1:6 S N=$P(X,"^",L) I N,'$D(^FH(111,N,0))#2 D HDR W !?5,"Diet ",N," missing in Diet Order ",K
 S N=$P(X,"^",13) I N,'$D(^FH(116.2,N,0))#2 D HDR W !?5,"Prod. Diet ",N," missing in Diet Order ",K
 Q
SF F L=5:2:27 S N=$P(X,"^",L) I N,'$D(^FH(118,N,0))#2 D HDR W !?5,"Supp. Feeding Item ",N," missing from SF Order ",K
 S N=$P(X,"^",4) I N,'$D(^FH(118.1,N,0))#2 D HDR W !?5,"Supp. Feeding Menu ",N," missing from SF Order ",K
 Q
TF I '$D(^FH(118.2,N,0))#2 D HDR W !?5,"Tubefeeding Product ",N," missing from Tubefeeding Order ",K
 Q
SP I '$D(^FH(118.3,N,0))#2 D HDR W !?5,"Standing Order Item ",N," missing from Standing Order # ",K
 Q
DR I '$D(^FH(119.5,N,0))#2 D HDR W !?5,"Diet Consult ",N," missing from Consult Order # ",K
 Q
