PSDAMIS4 ;BIR/JPW-Print NAOU AMIS Summary Totals ; 1 Sept 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;prints data for stock drugs
 K LN S $P(LN,"-",80)="",(PG,PSDOUT)=0,%DT="",X="T" D ^%DT X ^DD("DD") S RPDT=Y
 I '$D(^TMP("PSDAMIS",$J)) D HDR W !!,?10,"*****  NO DATA AVAILABLE FOR THIS REPORT  *****" Q
 S JJ="" F  S JJ=$O(^TMP("PSDAMISS",$J,JJ)) D:JJ="" GTOT Q:JJ=""!(PSDOUT)  D HDR Q:PSDOUT  S KK="" F  S KK=$O(^TMP("PSDAMISS",$J,JJ,KK)) D:KK="" NTOT Q:KK=""!(PSDOUT)  D TOT
 Q
HDR ;lists header information
 Q:PSDOUT
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,"SUMMARY NAOU/DRUG USAGE REPORT  -  DATE: "_RPDT,?70,"PAGE: ",PG,!
 I ANS="N",$D(JJ) W "NAOU: ",JJ,!
 I ANS="D",$D(JJ) W "DRUG: ",JJ,!
 W "From ",$P(PSDATE,"^")," to ",$P(PSDATE,"^",2),!!
 W !,?2,"=> ",$S(ANS="D":"NAOU",1:"DRUG"),!,"TOTAL # OF ORDERS",?30,"TOTAL QUANTITY",?60,"TOTAL COST",!,LN,!
 Q
TOT Q:PSDOUT  I $Y+8>IOSL D HDR Q:PSDOUT
 W !!,?2,"=> ",KK,!,$J(^TMP("PSDAMISS",$J,JJ,KK),8),?30,$J(^TMP("PSDAMISQ",$J,JJ,KK),8),?60,$J(^TMP("PSDAMISC",$J,JJ,KK),8,2)
 Q
NTOT Q:PSDOUT  I $Y+8>IOSL D HDR Q:PSDOUT
 W !!,?2,"=> ",KK
 W !!,$S(ANS="D":"DRUG",1:"NAOU")," Subtotals: ",!,"Number of Orders: ",?30,$J(^TMP("PSDAMIST",$J,JJ),8),! W:ANS="D" "Total Quantity: ",?30,$J(^TMP("PSDAMISQT",$J,JJ),8),!
 W "Total Cost of Orders: ",?60,$J(^TMP("PSDAMISCN",$J,JJ),8,2)
 W !,"Average Cost of Orders: ",?60,$S(+^TMP("PSDAMIST",$J,JJ):$J((^TMP("PSDAMISCN",$J,JJ)/^TMP("PSDAMIST",$J,JJ)),8,2),1:$J("0.00",8,2)),!
 Q
GTOT ;grand totals
 Q:PSDOUT  D HDR Q:PSDOUT
 W !,"Grand Totals by Dispensing Site: ",PSDSN,!
 S PSDSN="" F  S PSDSN=$O(^TMP("PSDAMISVG",$J,PSDSN)) Q:PSDSN=""!PSDOUT  D  Q:PSDOUT
 .I $Y+6>IOSL D HDR Q:PSDOUT
 .W !,"Number of Orders: ",?30,$J(^TMP("PSDAMISVG",$J,PSDSN),6),!,"Cost of Orders: ",?60,$J(^TMP("PSDAMISCVG",$J,PSDSN),8,2),!
 .W "Average Cost Per Order: ",?60,$S(+^TMP("PSDAMISVG",$J,PSDSN):$J((^TMP("PSDAMISCVG",$J,PSDSN)/^TMP("PSDAMISVG",$J,PSDSN)),8,2),1:$J("0.00",8,2)),!
 D HDR Q:PSDOUT
 W !!,"Grand Totals: ",!,"Number of Orders: ",?30,$J(^TMP("PSDAMISG",$J),8),!,"Cost of Orders: ",?60,$J(^TMP("PSDAMISCG",$J),8,2),!
 W "Average Cost Per Order: ",?60,$J((^TMP("PSDAMISCG",$J)/^TMP("PSDAMISG",$J)),8,2),!
 Q
