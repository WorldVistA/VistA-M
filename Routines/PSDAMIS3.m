PSDAMIS3 ;BIR/JPW-Print NAOU AMIS Report by NAOU ; 1 Sept 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
EN ;entry for printing data
 I SUM D ^PSDAMIS4 G DONE
PRINT ;prints data for stock drugs
 K LN S $P(LN,"-",80)="",(PG,PSDOUT)=0,%DT="",X="T" D ^%DT X ^DD("DD") S RPDT=Y
 I '$D(^TMP("PSDAMIS",$J)) D HDR W !!,?10,"*****  NO DATA AVAILABLE FOR THIS REPORT  *****" G DONE
 S NAOU="" F  S NAOU=$O(^TMP("PSDAMIS",$J,NAOU)) D:NAOU="" GTOT Q:NAOU=""!(PSDOUT)  D HDR S PSDR="" F  S PSDR=$O(^TMP("PSDAMIS",$J,NAOU,PSDR)) D:PSDR="" NTOT Q:PSDR=""!(PSDOUT)  W !,?2,"=> ",PSDR,!! D  G:PSDOUT DONE
 .S NUM="" F  S NUM=$O(^TMP("PSDAMIS",$J,NAOU,PSDR,NUM)) D:NUM="" TOT Q:NUM=""!(PSDOUT)  F JJ=0:0 S JJ=$O(^TMP("PSDAMIS",$J,NAOU,PSDR,NUM,JJ)) Q:'JJ!(PSDOUT)  D  Q:PSDOUT
 ..S NODE=^TMP("PSDAMIS",$J,NAOU,PSDR,NUM,JJ),DATE=$E(JJ,4,5)_"/"_$E(JJ,6,7)_"/"_$E(JJ,2,3)
 ..I $Y+8>IOSL D HDR Q:PSDOUT  W !,?2,"=> ",PSDR,!!
 ..W NUM,?15,DATE,?25,$J($P(NODE,"^"),6),?44,$J($P(NODE,"^",2),8,2),!
DONE I $E(IOST)'="C" W @IOF
 I $E(IOST,1,2)="C-",'PSDOUT W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu" D ^DIR K DIR
END ;
 K %,%DT,%H,%I,%ZIS,ALL,ANS,COST,DA,DATE,DIR,DIROUT,DIRUT,DTOUT,DUOUT,FLAG,IO("Q"),JJ,JJ1,KK,LOC,LN
 K NAOU,NAOUN,NODE,NUM,NURS,QTY,PG,POP,PSD,PSDATE,PSDED,PSDOUT,PSDPN,PSDR,PSDRN,PSDS,PSDSD,PSDSN,PSDT,RPDT,SUM,X,Y
 K ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 K ^TMP("PSDAMIS",$J),^TMP("PSDAMIST",$J),^TMP("PSDAMISG",$J),^TMP("PSDAMISQ",$J),^TMP("PSDAMISS",$J),^TMP("PSDAMISC",$J),^TMP("PSDAMISCN",$J),^TMP("PSDAMISCG",$J)
 K ^TMP("PSDAMISVG",$J),^TMP("PSDAMISCVG",$J)
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@"
 Q
HDR ;lists header information
 Q:PSDOUT
 I $E(IOST,1,2)="C-",PG K DA,DIR S DIR(0)="E" D ^DIR K DIR I 'Y S PSDOUT=1 Q
 W:$Y @IOF S PG=PG+1 W !,"NAOU/DRUG AMIS REPORT  -  DATE: "_RPDT,?70,"PAGE: ",PG,!
 W:$G(NAOU)]"" "NAOU: ",NAOU,!
 W "From ",$P(PSDATE,"^")," to ",$P(PSDATE,"^",2),!!
 W !,?2,"=> DRUG",!,?16,"DATE",!,"DISP #",?15,"FILLED",?25,"QUANTITY",?40,"COST PER ORDER",!,LN,!
 Q
TOT Q:PSDOUT  W !,"---------",?25,"----------",!,?3,^TMP("PSDAMISS",$J,NAOU,PSDR),?25,$J(^TMP("PSDAMISQ",$J,NAOU,PSDR),6),?44,$J(^TMP("PSDAMISC",$J,NAOU,PSDR),8,2),?60,"** Drug Totals **",!
 W "=========",?25,"=========",?40,"=============",!
 Q
NTOT ;print naou subtotals
 Q:PSDOUT  I $Y+8>IOSL D HDR Q:PSDOUT
 W:$D(FLAG) !,?5,"** ",NAOU,"  **",!
 W:'$D(FLAG) !,"NAOU Subtotals: " W !,"Number of Orders: ",?25,$J(^TMP("PSDAMIST",$J,NAOU),6)
 W !,"Total Cost of Orders: ",?44,$J(^TMP("PSDAMISCN",$J,NAOU),8,2)
 W !,"Average Cost Per Order: ",?44,$S(+^TMP("PSDAMIST",$J,NAOU):$J((^TMP("PSDAMISCN",$J,NAOU)/^TMP("PSDAMIST",$J,NAOU)),8,2),1:$J("0.00",8,2)),!
 Q
GTOT ;grand total
 Q:PSDOUT
 D HDR Q:PSDOUT  S FLAG=1 W !!,?35,"NAOU Subtotals Summary",!!
 S NAOU="" F  S NAOU=$O(^TMP("PSDAMIST",$J,NAOU)) Q:NAOU=""  D NTOT Q:PSDOUT
 D HDR Q:PSDOUT
 W !,"Grand Totals by Dispensing Site: ",PSDSN,!
 S PSDSN="" F  S PSDSN=$O(^TMP("PSDAMISVG",$J,PSDSN)) Q:PSDSN=""!PSDOUT  D  Q:PSDOUT
 .I $Y+6>IOSL D HDR Q:PSDOUT
 .W !,"Number of Orders: ",?25,$J(^TMP("PSDAMISVG",$J,PSDSN),6),!,"Cost of Orders: ",?44,$J(^TMP("PSDAMISCVG",$J,PSDSN),8,2),!
 .W "Average Cost Per Order: ",?44,$S(+^TMP("PSDAMISVG",$J,PSDSN):$J((^TMP("PSDAMISCVG",$J,PSDSN)/^TMP("PSDAMISVG",$J,PSDSN)),8,2),1:$J("0.00",8,2)),!
 D HDR Q:PSDOUT
 W !,"Grand Totals: ",!,"Number of Orders: ",?25,$J(^TMP("PSDAMISG",$J),6),!,"Cost of Orders: ",?44,$J(^TMP("PSDAMISCG",$J),8,2),!
 W "Average Cost Per Order: ",?44,$J((^TMP("PSDAMISCG",$J)/^TMP("PSDAMISG",$J)),8,2),!
 Q
