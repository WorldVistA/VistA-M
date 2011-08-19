PSOPST68 ;BIR/RTR-Find Pending orders with no priority ;06/12/01
 ;;7.0;OUTPATIENT PHARMACY;**68**;DEC 1997
 ;External reference to ^PSDRUG supported by DBIA 221
 ;External reference to ^PS(50.7 supported by DBIA 2223
 ;External reference ^PS(50.606 supported by DBIA 2174
 ;
 N PSOLOGD,PSOPNPAT,PSOPLOC,PSOPNIN,PSOPNPRI,PSOCOUNT,PSOAORL,PSOAORIN,PSOPNAME,PSOPDIN,PSONOW,X
 K ^TMP("PSOCHECK",$J),^TMP("PSOMAILX",$J)
 S PSOCOUNT=4,^TMP("PSOMAILX",$J,4)=" "
 D NOW^%DTC S PSONOW=%
 ;loop on AD x-ref, to find oldest orders first
 S PSOLOGD=0 F  S PSOLOGD=$O(^PS(52.41,"AD",PSOLOGD)) Q:'PSOLOGD!(PSOLOGD>PSONOW)  F PSOPLOC=0:0 S PSOPLOC=$O(^PS(52.41,"AD",PSOLOGD,PSOPLOC)) Q:'PSOPLOC  F PSOPNIN=0:0 S PSOPNIN=$O(^PS(52.41,"AD",PSOLOGD,PSOPLOC,PSOPNIN)) Q:'PSOPNIN  D
 .S PSOPNPAT=$P($G(^PS(52.41,PSOPNIN,0)),"^",2) Q:'PSOPNPAT
 .I $D(^TMP("PSOCHECK",$J,PSOPNPAT)) Q
 .S ^TMP("PSOCHECK",$J,PSOPNPAT)=""
 .;loop on AOR x-ref, see if patient has an order without a priority
 .F PSOAORL=0:0 S PSOAORL=$O(^PS(52.41,"AOR",PSOPNPAT,PSOAORL)) Q:'PSOAORL  F PSOAORIN=0:0 S PSOAORIN=$O(^PS(52.41,"AOR",PSOPNPAT,PSOAORL,PSOAORIN)) Q:'PSOAORIN  D
 ..S PSOPNPRI=$P($G(^PS(52.41,PSOAORIN,0)),"^",3)
 ..I $P($G(^PS(52.41,PSOAORIN,0)),"^",14)'="" Q
 ..I PSOPNPRI'="NW",PSOPNPRI'="RNW",PSOPNPRI'="RF" Q
 ..S PSOPDIN=+$P($G(^PS(52.41,PSOAORIN,0)),"^",2)
 ..I PSOPDIN'=PSOPNPAT Q
 ..S PSOPNAME=$P($G(^DPT(PSOPDIN,0)),"^")
 ..;set mail message with pat.name, drug/ord. item
 ..S X="" I +$P($G(^PS(52.41,PSOPNIN,0)),"^",9) S X=$P($G(^PSDRUG(+$P($G(^PS(52.41,PSOPNIN,0)),"^",9),0)),"^")
 ..I X]"" S X="; DRUG: "_X I $O(^PS(52.41,PSOPNIN,1,0))
 ..E  S X="; ORD.ITEM: "_$P($G(^PS(50.7,+$P($G(^PS(52.41,PSOPNIN,0)),"^",8),0)),"^")_" "_$P(^PS(50.606,$P(^(0),"^",2),0),"^")
 ..S PSOCOUNT=PSOCOUNT+1,^TMP("PSOMAILX",$J,PSOCOUNT)="PATIENT NAME: "_$G(PSOPNAME)_X
END ;
 ;send mail message
 S ^TMP("PSOMAILX",$J,1)="A search was done for Pending Outpatient orders",^TMP("PSOMAILX",$J,2)="with no priority assigned. Please review Pending",^TMP("PSOMAILX",$J,3)="orders for the following patients."
 I PSOCOUNT=4 S ^TMP("PSOMAILX",$J,5)="None were found in the search."
 K XMY
 S XMDUZ="PSO*7*68 OUTPATIENT PENDING ORDERS",XMSUB="ORDERS WITHOUT PRIORITY SEARCH"
 S XMY(DUZ)=""
 S XMTEXT="^TMP(""PSOMAILX"",$J," N DIFROM D ^XMD K XMSUB,XMTEXT,XMY,XMDUZ
 K ^TMP("PSOCHECK",$J)
 K ^TMP("PSOMAILX",$J)
 Q
