FHXIN ; HISC/REL - Create FHPT File ;2/23/00  09:54
 ;;5.5;DIETETICS;;Jan 28, 2005
 S U="^" D DT^DICRW
 I '$D(^FH(119.9,1,0)) W !!,"Set up initial Site Parameter File" K DIC,DD,DO D SITE^FH S DIC="^FH(119.9,",DIC(0)="L",DLAYGO=119.9,X=SITE(1),DINUM=1 D FILE^DICN K DIC,DLAYGO,DINUM
 I $P(^FH(115.6,0),"^",3)<50 S $P(^(0),"^",3)=50
R6 K ADM,FHDFN,DFN,DIC,DINUM,DMAX,KK,KKK,WRD,X,Y Q
EN1 S WRD=""
F1 S WRD=$O(^DPT("CN",WRD)) I WRD="" W !!,"  ... done." K ADM,D,FHDFN,DFN,I,WRD,X,Y Q
 S DFN=""
F2 S DFN=$O(^DPT("CN",WRD,DFN)) G:DFN="" F1 S ADM=^(DFN) G:ADM<1 ERR
 G:'$D(^DGPM(ADM,0)) ERR S X=$P(^(0),"^",1)
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 I '$D(^FHPT(FHDFN)) S ^FHPT(FHDFN,0)="P"_DFN,$P(^FHPT(FHDFN,0),U,3)=DFN,$P(^FHPT(0),"^",3)=FHDFN,$P(^FHPT(0),"^",4)=$P(^(0),"^",4)+1
 I '$D(^FHPT(FHDFN,"A",0)) S ^FHPT(FHDFN,"A",0)="^115.01^^"
 I $D(^FHPT(FHDFN,"A",ADM)) S $P(^(ADM,0),"^",1)=X G F2
 S $P(^FHPT(FHDFN,"A",0),"^",3)=ADM,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 S ^FHPT(FHDFN,"A",ADM,0)=X_"^^^^^^^^^^^" D WRD^FHWADM G F2
ERR W !!,"Error for FHDFN ",FHDFN," - Admission not Found" G F2
