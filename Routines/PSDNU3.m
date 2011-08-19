PSDNU3 ;BIR/JPW-Print NAOU Usage Report Summary Totals ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;prints data for stock drugs
 K LN S $P(LN,"-",80)="",(PG,PSDOUT)=0,%DT="",X="T" D ^%DT X ^DD("DD") S RPDT=Y
 I '$D(^TMP("PSDNU",$J)) D HDR W !!,?10,"*****  NO DATA AVAILABLE FOR THIS REPORT  *****" Q
 S JJ="" F  S JJ=$O(^TMP("PSDNUS",$J,JJ)) Q:JJ=""!(PSDOUT)  D HDR S KK="" F  S KK=$O(^TMP("PSDNUS",$J,JJ,KK)) D:KK="" NTOT Q:KK=""!(PSDOUT)  D TOT
 Q
HDR ;lists header information
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,"SUMMARY NAOU/DRUG USAGE REPORT  -  DATE: "_RPDT,?70,"PAGE: ",PG,!
 I ANS="N",$D(JJ) W "NAOU: ",JJ,!
 I ANS="D",$D(JJ) W "DRUG: ",JJ,!
 W "From ",$P(PSDATE,"^")," to ",$P(PSDATE,"^",2),!!
 W !,?2,"=> ",$S(ANS="D":"NAOU",1:"DRUG"),!,"TOTAL # OF ORDERS",?30,"TOTAL QUANTITY",!,LN,!
 Q
TOT Q:PSDOUT  I $Y+8>IOSL D HDR
 W !!,?2,"=> ",KK,!,$J(^TMP("PSDNUS",$J,JJ,KK),8),?34,$J(^TMP("PSDNUQ",$J,JJ,KK),6)
 Q
NTOT Q:PSDOUT  I $Y+6>IOSL D HDR
 W !!,?2,"=> ",KK
 W !!,$S(ANS="D":"DRUG",1:"NAOU")," Subtotal # of Orders: ",^TMP("PSDNUT",$J,JJ) W:ANS="D" "    Total Quantity: ",^TMP("PSDNUQT",$J,JJ)
 W !!,"Grand Total # of Orders: ",^TMP("PSDNUG",$J),!
 Q
