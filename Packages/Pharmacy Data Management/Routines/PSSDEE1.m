PSSDEE1 ;BIR/WRT-PDM match routine ;09/01/98
 ;;1.0;PHARMACY DATA MANAGEMENT;**15,20,34,38,68,90**;9/30/97
 ;
 ;Reference to $$PSJDF^PSNAPIS(P1,P3) supported by DBIA #2531
 ;
DSPY S FLGMTH=0 I $D(^PSDRUG(DA,"ND")) I $P(^PSDRUG(DA,"ND"),"^",2)]"" W !!,?5,"points to ",$P(^("ND"),"^",2)," in the National Drug file.",! S NDE=^PSDRUG(DA,"ND"),PC1=$P(NDE,"^",1),PC3=$P(NDE,"^",3),FLGMTH=1 D GETDF
 I $D(^PSDRUG(DA,2)),$P(^PSDRUG(DA,2),"^",1)]"" S PSSOITM=$P(^PSDRUG(DA,2),"^",1) I $D(^PS(50.7,PSSOITM,0)) S PTR=$P(^PS(50.7,PSSOITM,0),"^",2),OLDDF=$P(^PS(50.606,PTR,0),"^",1)
 Q
GETDF S DA=PC1,K=PC3,X=$$PSJDF^PSNAPIS(DA,K),OLDDF=$P(X,"^",2),DA=DISPDRG
 Q
MESSAGE ; REMATCH PROMPT
 I $D(^PSDRUG(DA,"ND")) W:$P(^PSDRUG(DA,"ND"),"^",2)]"" !!,"This drug has already been matched and classified with the National Drug",!,"file." D PART2
 I $D(^PSDRUG(DA,3)) W:$P(^PSDRUG(DA,3),"^",1)=1 !,"This drug has also been marked to transmit to CMOP.",!,"If you choose to rematch it, the drug will be marked NOT TO TRANSMIT to CMOP.",!
 I $D(^PSDRUG(DA,"ND")) W:$P(^PSDRUG(DA,"ND"),"^",2)']"" !!,"This drug has been manually classed but not matched (merged with NDF)."
 Q
RSET S:$D(^PSDRUG(DA,"ND")) PSNID=$P(^PSDRUG(DA,"ND"),"^",10)
 S PSNP=$G(^PSDRUG(DA,"I")) I PSNP,PSNP<DT W !,"This drug cannot be matched because it has an INACTIVE date.",! Q:$D(^PSDRUG(DA,"I"))
 S DA=DISPDRG D:$D(^PSDRUG(DA,"ND")) SETNULL  S:$D(^PSDRUG(DA,3)) $P(^PSDRUG(DA,3),"^",1)=0 K:$D(^PSDRUG("AQ",DA)) ^PSDRUG("AQ",DA) I $D(PSNID),PSNID]"" K ^PSDRUG("AQ1",PSNID,DA) K PSNID
 D ^PSSREF Q
SETNULL S ZXZX=$P(^PSDRUG(DA,"ND"),"^",2),$P(^PSDRUG(DA,"ND"),"^",1)="",$P(^PSDRUG(DA,"ND"),"^",2)="",$P(^PSDRUG(DA,"ND"),"^",3)="",$P(^PSDRUG(DA,"ND"),"^",4)="",$P(^PSDRUG(DA,"ND"),"^",5)="",$P(^PSDRUG(DA,"ND"),"^",10)="" D NULL1
 Q
NULL1 I ZXZX]"" S ZXZX=$E(ZXZX,1,30) I $D(^PSDRUG("VAPN",ZXZX,DA)) K ^PSDRUG("VAPN",ZXZX,DA) K ZXZX
 Q
PART2 W:$P(^PSDRUG(DA,"ND"),"^",2)]"" " In addition, if the dosage form changes as a result of rematching,",!,"you will have to match/rematch to Orderable Item."
 Q
ORDITM I FLGKY'=1 I $D(^PSDRUG(DISPDRG,2)) S APU=$P(^PSDRUG(DISPDRG,2),"^",3) I (APU["O")!(APU["I")!(APU["U")!(APU["X") D OICK
 Q
OICK I ^XMB("NETNAME")'["CMOP-",$D(^PS(59.7,1,80)),$P(^PS(59.7,1,80),"^",2)>1 D OIMESS S PSIEN=DISPDRG,PSNAME=$P(^PSDRUG(DISPDRG,0),"^",1),PSMASTER=1 D MAS^PSSPOIMN K PSIEN,PSNAME,PSMASTER
 Q
OIKILL I $D(FLGNDF),FLGNDF=1,$D(PSDRUG(DISPDRG,2)),$P(^PSDRUG(DISPDRG,2),"^",1)]"" D KMTCH
 Q
KMTCH S DIE="^PSDRUG(",DR="2.1///"_"@" D ^DIE D  D CKIV
 .;S PSSINSTX=$O(^PS(59.7,0)) I $P($G(^PS(59.7,+$G(PSSINSTX),80)),"^",3)<2 K PSSINSTX Q
 .K PSSINSTX W !!,"Deleting Local Possible Dosages.." K ^PSDRUG(DISPDRG,"DOS2")
 Q
OIMESS W !!,"** You are NOW in the ORDERABLE ITEM matching for the dispense drug. **",!
 Q
CKIV K ^TMP($J,"SOL"),^TMP($J,"ADD") ;D SOLIO
 ;D ADDIO
 Q
SOLIO I $D(^PS(52.7,"AC",DISPDRG)) F BBC=0:0 S BBC=$O(^PS(52.7,"AC",DISPDRG,BBC)) Q:'BBC  S SOLITM=$P(^PS(52.7,BBC,0),"^",11) I SOLITM]"" I $D(^PS(52.7,"AOI",SOLITM,BBC)) D SOLIO1
 Q
SOLIO1 S IVDFPTR=$P(^PS(50.7,SOLITM,0),"^",2),IVDF=$P(^PS(50.606,IVDFPTR,0),"^",1),SOLNM=$P(^PS(52.7,BBC,0),"^",1) D CP
 Q
CP I IVDF'=NEWDF S ^TMP($J,"SOL",BBC)=SOLNM I $P(^PS(52.7,BBC,0),"^",11)]"" S DA=BBC,DIE="^PS(52.7,",DR="9///"_"@" D ^DIE
 Q
SOLMESS ;I FLG3=1,PSSANS'["I",$D(^TMP($J,"SOL")) W !,"You have SOLUTIONS that need to rematched to ORDERABLE ITEM." F NUM=0:0 S NUM=$O(^TMP($J,"SOL",NUM)) Q:'NUM  S ENTRY=NUM D SOI^PSSVIDRG K ^TMP($J,"SOL",NUM)
 Q
ADDIO I $D(^PS(52.6,"AC",DISPDRG)) F BBC=0:0 S BBC=$O(^PS(52.6,"AC",DISPDRG,BBC)) Q:'BBC  S ADDITM=$P(^PS(52.6,BBC,0),"^",11) I ADDITM]"",$D(^PS(52.6,"AOI",ADDITM,BBC)) D ADDIO1
 Q
ADDIO1 S IVDFPTR=$P(^PS(50.7,ADDITM,0),"^",2),IVDF=$P(^PS(50.606,IVDFPTR,0),"^",1),ADDNM=$P(^PS(52.6,BBC,0),"^",1) D CP1
 Q
CP1 I IVDF'=NEWDF S ^TMP($J,"ADD",BBC)=ADDNM I $P(^PS(52.6,BBC,0),"^",11)]"" S DA=BBC,DIE="^PS(52.6,",DR="15///"_"@" D ^DIE
 Q
ADDMESS ;I FLG3=1,PSSANS'["I",$D(^TMP($J,"ADD")) W !!,"You have ADDITIVES that need to rematched to ORDERABLE ITEM." F NUM=0:0 S NUM=$O(^TMP($J,"ADD",NUM)) Q:'NUM  S ENTRY=NUM D ADDOI^PSSVIDRG K ^TMP($J,"ADD",NUM)
 Q
ADDMESS1 ;I FLG3=0,$D(^TMP($J,"ADD")) W !!,"The following ADDITIVES need to rematched to ORDERABLE ITEM, however you do",!,"not have the ""PSJI MGR"" IV key. These must be matched before they made be used.",! D MESSA
 Q
MESSA F NUM=0:0 S NUM=$O(^TMP($J,"ADD",NUM)) Q:'NUM  W !?3,$P(^TMP($J,"ADD",NUM),"^")
 Q
SOLMESS1 ;I FLG3=0,$D(^TMP($J,"SOL")) W !!,"The following SOLUTIONS need to rematched to ORDERABLE ITEM, however you do",!,"not have the ""PSJI MGR"" IV key. These must be matched before they may be used.",! D MESSS
 Q
MESSS F NUM=0:0 S NUM=$O(^TMP($J,"SOL",NUM)) Q:'NUM  W !?3,$P(^TMP($J,"SOL",NUM),"^")
 Q
ADDMESS2 ;I FLG3=1,PSSANS["I",$D(^TMP($J,"ADD")) W !!,"The following ADDITIVES need to rematched to ORDERABLE ITEM.",!,"These must be matched before they made be used.",! D MESSA
 Q
SOLMESS2 ;I FLG3=1,PSSANS["I",$D(^TMP($J,"SOL")) W !!,"The following SOLUTIONS need to rematched to ORDERABLE ITEM.",!,"These must be matched before they may be used.",! D MESSS
 Q
