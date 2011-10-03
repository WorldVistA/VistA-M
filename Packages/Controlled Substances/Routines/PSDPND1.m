PSDPND1 ;BIR/JPW-Pharm Dispensing Report (cont'd) ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
PRINT ;print pharmacy disp log by date
 I SUM S PG=0 D SUMPRT G DONE
 S (PG,PSDOUT)=0
 K LN S $P(LN,"-",132)="" I '$D(^TMP("PSDND",$J)) D HDR W !!,?45,"****  NO DISPENSING DATA FOR THIS DISPENSING LOCATION  ****" G DONE
 D HDR S NUM="" F  S NUM=$O(^TMP("PSDND",$J,NUM)) Q:NUM=""!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  D
 .F PSD=0:0 S PSD=$O(^TMP("PSDND",$J,NUM,PSD)) Q:'PSD!(PSDOUT)  D:$Y+4>IOSL HDR Q:PSDOUT  S NODE=^TMP("PSDND",$J,NUM,PSD) W !,NUM,?15,$P(NODE,"^"),?58,$J($P(NODE,"^",3),6),?68,$P(NODE,"^",4),?86,$P(NODE,"^",2),?112,$P(NODE,"^",5)
 I $E(IOST,1,2)="C-",'PSDOUT W !!,"Press <RET> to return to display the summary totals" R X:DTIME
 D:'PSDOUT SUMPRT
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
 Q
HDR ;header for log
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 S PG=PG+1 W:$Y @IOF W !,?45,"Pharmacy Dispensing Report",?115,"Page: ",PG,!,?45,"Dispensing Vault: "_PSDSN,!,?45,$P(PSDATE,"^")_" to "_$P(PSDATE,"^",2)
 W !!,?58,"QUANTITY",?71,"DATE"
 W !,"DISP #",?15,"DRUG",?58,"DISPENSED",?71,"DISP",?86,"DISPENSED TO",?112,"DISPENSED BY"
 W !,LN,!
 Q
SUMPRT ;prt sum
 K LN S (PG,PSDOUT)=0,$P(LN,"-",80)=""
 I '$D(^TMP("PSDNDT",$J)) D SUMHDR W !!,?45,"****  NO DISPENSING DATA FOR THIS DISPENSING LOCATION  ****" Q
PRTSUM ;prints summary data
 D SUMHDR Q:PSDOUT
 S DRUG="" F  S DRUG=$O(^TMP("PSDNDT",$J,DRUG)) Q:DRUG=""  D:$Y+4>IOSL SUMHDR Q:PSDOUT  W !,?2,DRUG,?60,$J(+^TMP("PSDNDT",$J,DRUG),6),!
 Q
SUMHDR ;sum header
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,?25,"Pharmacy Dispensing Report",?70,"Page "_PG,!,?25,$P(PSDATE,"^")_" to "_$P(PSDATE,"^",2),!,?31,"** SUMMARY **",!!,"Dispensing Vault: ",PSDSN,!!
 W ?5,"DRUG",?57,"TOTAL DISPENSED",!,LN,!
 Q
