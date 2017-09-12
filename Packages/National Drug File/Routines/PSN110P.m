PSN110P ;BIR/DMA-check APD cross references in files 50.416 and 56 ; 24 Oct 2006  12:56 PM
 ;;4.0; NATIONAL DRUG FILE;**110**; 30 Oct 98;Build 4
 ;
 N DA,DIC,DIE,DINUM,DR,ID,ING,INT,INT1,K,K1,PSN,PSNID,X,X1,X2
 S DA=0 F  S DA=$O(^PS(50.416,DA)),ID="" Q:'DA  F  S ID=$O(^PS(50.416,DA,1,"B",ID)),K=0 Q:ID=""  F  S K=$O(^PS(50.416,DA,1,"B",ID,K)) Q:'K  I '$D(^PSNDF(50.68,$P(ID,"A",2),2,DA)) D
 .K ^PS(50.416,DA,1,"B",ID,K),^PS(50.416,DA,1,K),^PS(50.416,"APD",ID,DA) S X="^PS(56,""APD"","""_ID_""")" F  S X=$Q(@X) Q:$QS(X,3)'=ID  D
 ..S INT=^PS(56,$QS(X,5),0) I $P(INT,"^",2)=DA!($P(INT,"^",3)=DA) K @X,^PS(56,"APD",$QS(X,4),$QS(X,3),$QS(X,5)),^PS(56,"AI1",DA,$QS(X,5)),^PS(56,"AI2",DA,$QS(X,5))
 ;
 K ^TMP($J) M ^TMP($J)=@XPDGREF@("ING") K ^TMP("PSN",$J) M ^TMP("PSN",$J)=@XPDGREF@("PRI")
 S DA=0 F  S DA=$O(^PSNDF(50.68,DA)),K=0 Q:'DA  F  S K=$O(^PSNDF(50.68,DA,2,K)) Q:'K  I $D(^TMP($J,DA,K)) S PSNID=$P(^PSNDF(50.68,DA,0),"^",2)_"A"_DA K ^PSNDF(50.68,DA,2,K) D
 .S K1=0 F  S K1=$O(^PS(50.416,K,1,"B",PSNID,K1)) Q:'K1  K ^(K1),^PS(50.416,K,1,K1),^PS(50.416,"APD",PSNID,K) S X="^PS(56,""APD"","""_PSNID_""")" F  S X=$Q(@X) Q:$QS(X,3)'=PSNID  D
 ..S INT=^PS(56,$QS(X,5),0) I $P(INT,"^",2)=K!($P(INT,"^",3))=K K @X,^PS(56,"APD",$QS(X,4),$QS(X,3),$QS(X,5)),^PS(56,"AI1",K,$QS(X,5)),^PS(56,"AI2",K,$QS(X,5))
 S X="^TMP(""PSN"",$J)" F  S X=$Q(@X) Q:X'[("^TMP(""PSN"","_$J)  S PSN=$QS(X,3),ING=$QS(X,4),PSN=$P(^PSNDF(50.68,PSN,0),"^",2)_"A"_PSN D
 .S X1="^PS(56,""APD"","""_PSN_""")" F  S X1=$Q(@X1) Q:$QS(X1,3)'=PSN  S INT=$QS(X1,5),INT1=^PS(56,INT,0) I $P(INT1,"^",2)=ING!($P(INT1,"^",3)=ING) D
 ..K ^PS(56,"AI1",ING,INT),^PS(56,"AI2",ING,INT)
 ..K @X1,^PS(56,"APD",$QS(X1,4),$QS(X1,3),$QS(X1,5))
 ..S X2="^PS(56,""AE"")" F  S X2=$Q(@X2) Q:$QS(X2,3)'=ING  I $QS(X2,5)=INT K @X2 K ^PS(56,"AE",$QS(X2,4),$QS(X2,3),$QS(X2,5))
 ;
 ;ADD INGREDIENT TO CLONIDINE HCL 0.1MG TAB,UD
 S DA=444,DA(1)=13554,DIC="^PSNDF(50.68,"_DA(1)_",2,",DIC(0)="L",X=DA,DINUM=X D FILE^DICN S DIE=DIC,DR="1////0.1;2////20;" D ^DIE
 K DA,DIC,DIE,DINUM,DR,ID,ING,INT,INT1,K,K1,PSN,PSNID,X,X1,X2,^TMP($J),^TMP("PSN",$J)
 Q
