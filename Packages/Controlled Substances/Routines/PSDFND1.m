PSDFND1 ;BIR/JPW-Pharm Filled Not Delivered Report ; 2 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
SUMPRT ;prints summary
 K LN S (PG,PSDOUT)=0,$P(LN,"-",80)=""
 I '$D(^TMP("PSDFNDT",$J)) D SUMHDR W !!,?45,"****  NO PENDING DELIVERIES FOR THIS DISPENSING LOCATION  ****",! Q
PRTSUM ;prints summary data for filled not delivered log
 D SUMHDR Q:PSDOUT
 S DRUG="" F  S DRUG=$O(^TMP("PSDFNDT",$J,DRUG)) Q:DRUG=""  D:$Y+4>IOSL SUMHDR Q:PSDOUT  W !,?2,DRUG,?60,$J(+^TMP("PSDFNDT",$J,DRUG),6),!
 Q
SUMHDR ;lists summary header information
 I $E(IOST,1,2)="C-",PG W ! K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,?25,"Narcotics Filled Not Delivered Report",?70,"Page "_PG,!,?36,RPDT,!,?35,"** SUMMARY **",!!,"Dispensing Vault: ",PSDSN,!!
 W !,?58,"TOTAL FILLED",!,?5,"DRUG",?58,"NOT DISPENSED",!,LN,!
 Q
