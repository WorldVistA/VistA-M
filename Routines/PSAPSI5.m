PSAPSI5 ;BIR/LTL,JMB-Nightly Background Job - CONT'D ;7/23/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**14,25**; 10/24/97
 ;This routine gathers IV and unit dose dispensing data.
 ;
 ;References to ^PS(50.8 are covered by IA 771 (#771)
 ;Reference to ^PS(57.6 are covered by IA #772
 ;
SOL S PSAW=PSADT(3),PSADRUG(3)=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.7,+PSADRUG(2),0))
 F  S PSAW=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW)) Q:'PSAW  S PSAW(1)=PSAW D:$O(^PSD(58.8,"AB",PSAW,0))=PSALOC
 .S PSAQ=$G(PSAQ)+$P($G(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW,0)),"^",2)-$P($G(^(0)),"^",5)
 S:PSAQ ^TMP("PSA",$J,+PSADRUG,PSADT(4))=$G(^TMP("PSA",$J,+PSADRUG,PSADT(4)))+PSAQ S (PSAQ,PSAW)=0
 Q
EN ; Entry point Unit Dose dispensing, returns, extras, & pre-exchange
 Q  ;DAVE B (PSA*3*25)
 S X1=DT,X2=1 D C^%DTC S ^XTMP("PSAPL",0)=X
 G:$G(PSGRTN)="PSGPLF" PICKLST
 ;
 ;Call must have came from PSGAMSA then, instead of PSGPLF
 I $D(PSGY) S PSAQTY=PSGY
 ;drug stocked in Drug Acct Location?
 G:'+PSGDRG!('$D(^PSD(58.8,"C",+PSGDRG))) EXIT
 G:'$D(PSGWARD) EXIT
 ;DAVE B (PSA*3*14) Check for more than one pharmacy location
 ;associated with the Ward
 S PSALOC1=""
1 S PSALOC1=$O(^PSD(58.8,"AB",PSGWARD,PSALOC1)) I PSALOC1="" G EXIT
 I 'PSALOC1!('$D(^PSD(58.8,"ADISP","P",+PSALOC1)))!('+$P($G(^PSD(58.8,+PSALOC1,0)),"^",3)) G 1
 I +$G(^PSD(58.8,+PSALOC1,"I")),+^PSD(58.8,+PSALOC1,"I")'>DT G 1
 S PSAIPST=+$P($G(^PSD(58.8,PSALOC1,0)),"^",3)
 D NOW^%DTC
 S ^XTMP("PSAPL",+PSAIPST,+PSGDRG,+$S($D(PSGPLFDT):PSGPLFDT,1:$P(%,".")))=$G(^XTMP("PSAPL",+PSAIPST,+PSGDRG,+$S($D(PSGPLFDT):PSGPLFDT,1:$P(%,"."))))+$G(PSAQTY)
EXIT K PSGBK,PSADA,PSGRTN,PSALOC1,PSAQTY
 Q
PICKLST ;Pick List dispensing and returns.
 I '+D3!('$D(^PSD(58.8,"C",D3))) G EXIT
 S PSAQTY=$P($G(^PS(57.6,D0,1,D1,1,D2,1,D3,0)),"^",2)
 S PSALOC1=""
2 S PSALOC1=$O(^PSD(58.8,"AB",D1,PSALOC1)) I PSALOC1="" G EXIT
 I 'PSALOC1!('$D(^PSD(58.8,"ADISP","P",+PSALOC1)))!('+$P($G(^PSD(58.8,+PSALOC1,0)),"^",3)) G 2
 I +$G(^PSD(58.8,+PSALOC1,"I")) G 2
 S PSAIPST=+$P($G(^PSD(58.8,PSALOC1,0)),"^",3)
 S ^XTMP("PSAPL",+PSAIPST,+D3,+D0)=$G(^XTMP("PSAPL",+PSAIPST,+D3,+D0))+$G(PSAQTY)
 Q
