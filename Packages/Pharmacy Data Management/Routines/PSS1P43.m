PSS1P43 ;BIR/DMA-fix bad interaction names ; 03/15/01 12:52
 ;;1.0; PHARMACY DATA MANAGEMENT;**43**;9/30/97
 ;
 ;Reference to ^PS(56 supported by DBIA #2133
 ;Reference to ^PS(50.416 supported by DBIA #2196
 ;
 S DA=0 F  S DA=$O(^PS(56,DA)) Q:'DA  S X=^(DA,0) D
 .K PSN,PSNN
 .S NAM=$P(X,"^"),PSN=$P(X,"^",2),PSN=$P(^PS(50.416,PSN,0),"^"),PSNN(PSN)="",PSN=$P(X,"^",3),PSN=$P(^PS(50.416,PSN,0),"^"),PSNN(PSN)=""
 .S NA1="",NA1=$O(PSNN(""))_"/"_$O(PSNN($O(PSNN(""))))
 .I NA1'=NAM W "." S DIE="^PS(56,",DR=".01////"_NA1 D ^DIE
 K DA,DIE,DR,NA1,NAM,PSN,PSNN,X
 Q
