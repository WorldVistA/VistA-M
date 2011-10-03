PSGWADE ;BHAM ISC/PTD,CML-Enter AMIS Data for All Drugs in All AOUs ; 02/13/90 10:19
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
 D NOW^%DTC S PSGWDT=$P(%,".") W !!,"You must enter ""^"" at any prompt to quit.",!,"Press <RETURN> at any prompt to skip that drug.",!!,"If the conversion number is ""1"", then YOU MUST",!,"KEY IN ""1""; no defaults are assumed!",!!
 ;BUILD UTILITY GLOBAL: ORDERED BY TYPE, DRUG NAME, & DRUG NUMBER
 W "I need to gather some information now.",!,"This may take a little while........."
AOU K ^TMP("PSGW",$J),^TMP("PSGWDN",$J) S PSGWFLG=1,PSGWRET=0 F PSGWAOU=0:0 S PSGWAOU=$O(^PSI(58.1,PSGWAOU)) G:'PSGWAOU LOOP^PSGWADE1 D XREF
 ;
XREF F PSGWDR=0:0 S PSGWDR=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDR)) Q:'PSGWDR  F PSGWITM=0:0 S PSGWITM=$O(^PSI(58.1,PSGWAOU,1,"B",PSGWDR,PSGWITM)) Q:'PSGWITM  D BUILD
 Q
 ;
BUILD I $P(^PSI(58.1,PSGWAOU,1,PSGWITM,0),"^",10)="Y",$P(^(0),"^",3)="" S $P(^(0),"^",10)=""
 I $P(^PSI(58.1,PSGWAOU,1,PSGWITM,0),"^",3)'="" Q:$P(^(0),"^",3)'>PSGWDT
 I '$O(^PSI(58.1,PSGWAOU,1,PSGWITM,2,0)) S K=9999 D SETGL Q
 F PSGWTY=0:0 S PSGWTY=$O(^PSI(58.1,PSGWAOU,1,PSGWITM,2,PSGWTY)) Q:'PSGWTY  S K=PSGWTY D SETGL S ^TMP("PSGWDN",$J,PSGWNM)=""
 Q
 ;
SETGL I '$O(^PSDRUG(PSGWDR,0)) S DIK="^PSI(58.1,"_PSGWAOU_",1,",DA=PSGWITM,DA(1)=PSGWAOU D ^DIK K DIK Q
 I $O(^PSDRUG(PSGWDR,0)) S PSGWNM=$S($P(^PSDRUG(PSGWDR,0),"^")'="":$P(^(0),"^"),1:"ZZNAME MISSING") S ^TMP("PSGW",$J,K,PSGWNM,PSGWDR)="" Q
 ;
