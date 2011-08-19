PSAPSI3 ;BIR/LTL-Nightly Background Job ;8/7/97
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**12**; 10/24/97
 ;This is the entry point for the nightly job. It collects dispensing
 ;data in IV Solutions, Unit Dose, and Outpatient then purges old data.
 ;It calls ^PSAREORD that searches the pharmacy locations & master vaults
 ;for drug balances <= the reorder level IF the location/vault is
 ;maintaining reorder levels.
 ;
 ;References to ^PS(50.8, are covered by IA #270
 ;References to ^PS(52.6, are covered by IA #270-A
 ;References to ^PS(52.7, are covered by IA #270-B
 S PSALOC=0 F  S PSALOC=+$O(^PSD(58.8,"ADISP","P",PSALOC)) G:'PSALOC NEXT D:$O(^PSD(58.8,PSALOC,1,0)) LUP
NEXT D:$D(^TMP("PSA",$J)) ^PSAPSI1 K ^TMP("PSA",$J)
 ;Gets dispensed data in Unit Dose and Outpatient. Purge data.
 D ^PSAUDP,^PSAOP3,^PSAPUR D:$D(^XTMP("PSAPV",0)) XTMP
END K D3,PSA,PSADRUG,PSADT,PSAIV,PSAIV5,PSALOC,PSAQ,PSAW,PSGDRG,PSGPLFDT,PSGRTN,PSGWARD,PSGX,X,Y
 G ^PSAREORD
 Q
LUP D NOW^%DTC S PSADT=X,X="T-2" D ^%DT
 S (PSADT(2),PSADT(22))=Y,(PSADRUG,PSADT(3),PSAIV)=0
 ;If drug's inactivation date is after today, continue.
 F  S PSADRUG=+$O(^PSD(58.8,PSALOC,1,PSADRUG)) Q:'PSADRUG  D:$S($P($G(^PSD(58.8,PSALOC,1,PSADRUG,0)),U,14):$P($G(^(0)),U,14)>DT,1:1)  D:$D(^TMP("PSA",$J,PSADRUG)) ^PSAPSI1
 .;If last collection date is in file, set PSADT equal to it.
 .I $P($P($G(^PSD(58.8,PSALOC,1,PSADRUG,6)),U,3),",") S PSADT(2)=$P($P($G(^(6)),U,3),","),PSADT(3)=0,PSA(7)=1
 .;Quit if the drug is not in IV SOLUTIONS & IV ADDITIVES files.
 .Q:'$O(^PS(52.6,"AC",PSADRUG,0))&('$O(^PS(52.7,"AC",PSADRUG,0)))
 .;Set array = to DRUG file's drug that is linked to it.
 .S PSADRUG(1)=$O(^PS(52.6,"AC",PSADRUG,0)),PSAIV=0
 .S PSADRUG(2)=$O(^PS(52.7,"AC",PSADRUG,0))
 .S PSAW=PSADT(3)
 .F  S PSAIV=$O(^PS(50.8,PSAIV)) Q:'PSAIV  F PSADT(4)=PSADT(2):0 S PSADT(4)=$O(^PS(50.8,+PSAIV,2,PSADT(4))) Q:'PSADT(4)  D  D:$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.7,+PSADRUG(2),0)) SOL
 ..Q:'$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.6,+PSADRUG(1),0))
 ..S PSADRUG(3)=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.6,+PSADRUG(1),0))
 ..F  S PSAW=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW)) Q:'PSAW  S PSAW(1)=PSAW D
 ...I PSAW'=.5 Q:'$O(^PSD(58.8,"AB",PSAW,0))=PSALOC
 ...;If it is OP dispensing IVs to IV Rooms, quit if the pharmacy
 ...;location does not have an IV Room assigned to it or if it does not
 ...;have an OP site set up.
 ...I PSAW=.5 D OP Q
 ...S PSAQ=$G(PSAQ)+$P($G(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW,0)),U,2)-$P($G(^(0)),U,5)
 ..S:$G(PSAQ) ^TMP("PSA",$J,PSADRUG,PSADT(4))=$G(^TMP("PSA",$J,PSADRUG,PSADT(4)))+PSAQ S (PSAQ,PSAW)=0
 .S PSADT(2)=PSADT(22)
 Q
SOL S PSAW=PSADT(3),PSADRUG(3)=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,"AC",52.7,+PSADRUG(2),0))
 F  S PSAW=$O(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW)) Q:'PSAW  S PSAW(1)=PSAW D:$O(^PSD(58.8,"AB",PSAW,0))=PSALOC
 .S PSAQ=$G(PSAQ)+$P($G(^PS(50.8,+PSAIV,2,+PSADT(4),2,+PSADRUG(3),3,PSAW,0)),U,2)-$P($G(^(0)),U,5)
 S:$G(PSAQ) ^TMP("PSA",$J,PSADRUG,PSADT(4))=$G(^TMP("PSA",$J,PSADRUG,PSADT(4)))+PSAQ S (PSAQ,PSAW)=0
 Q
OP ;
 S PSAIV5=+$O(^PSD(58.8,"AIV",PSALOC,0)) Q:'PSAIV5!('+$P($G(^PSD(58.8,PSALOC,0)),"^",10))
 ;
 ;DAVE B (PSA*3*12) removed !(PSAFND=PSALOC) on next line.
 S PSAFND=0 F  S PSAFND=$O(^PSD(58.8,"AB",PSAW,0)) Q:'PSAFND  I PSAFND=PSALOC S PSAQ=$G(PSAQ)+$P($G(^PS(50.8,+PSAIV,2,+PSAADT(4),2,+PSADRUG(3),3,PSAW,0)),"^",2)-$P($G(^(0)),"^",5)
 Q
 ;
XTMP ;If the XTMP global is going to be deleted in 4 days, sent a warning
 ;mail msg to holders of PSA ORDERS.
 S PSAEND=+$P(^XTMP("PSAPV",0),"^") Q:'PSAEND
 S X1=PSAEND,X2=DT D ^%DTC Q:X>4  S PSADAYS=X,(PSACNT,PSACTRL)=0
 F  S PSACTRL=$O(^XTMP("PSAPV",PSACTRL)) Q:PSACTRL=""  S:$D(^XTMP("PSAPV",PSACTRL,"IN")) PSACNT=PSACNT+1
 Q:'PSACNT
 I PSACNT>1 D
 .S ^TMP("PSAXTMP",$J,1)="There are "_PSACNT_" invoices that have been uploaded and not processed. If these"
 .S ^TMP("PSAXTMP",$J,2)="invoices are not processed in four calendar days or if more invoices are not"
 .S ^TMP("PSAXTMP",$J,3)="uploaded in four calendar days, the "_PSACNT_" invoices will be deleted."
 I PSACNT=1 D
 .S ^TMP("PSAXTMP",$J,1)="There is 1 invoice that has been uploaded and not processed. If this"
 .S ^TMP("PSAXTMP",$J,2)="invoice is not processed in four calendar days or if more invoices"
 .S ^TMP("PSAXTMP",$J,3)="are not uploaded in four calendar days, the invoice will be deleted."
 S XMDUZ="Drug Accountability System",XMSUB="Unprocessed Invoice"_$S(PSACNT>1:"s",1:"")_" Due to Expire in "_PSADAYS_" day"_$S(PSADAYS>1:"s",1:""),XMTEXT="^TMP(""PSAXTMP"",$J,"
 S PSADUZ=0 F  S PSADUZ=+$O(^XUSEC("PSA ORDERS",PSADUZ)) Q:'PSADUZ  S XMY(PSADUZ)=""
 G:'$D(XMY) QUIT D ^XMD
QUIT K ^TMP("PSAXTMP",$J),PSACNT,PSACTRL,PSADAYS,PSADUZ,X,X1,X2,XMDUZ,XMSUB,XMTEXT,XMY
 Q
