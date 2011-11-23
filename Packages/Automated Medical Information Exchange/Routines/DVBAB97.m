DVBAB97 ;ALB/SPH - CAPRI CONVERSION OF DVBCENQ2 FOR SUPPORT ;09/11/00
 ;;2.7;AMIE;**35**;Apr 10, 1995
 ;
 S ZMSG(DVBABCNT)=" >>> Future C&P Appointments <<<",DVBABCNT=DVBABCNT+1
 S ZMSG(DVBABCNT)="",DVBABCNT=DVBABCNT+1
 ;
FA S CT=0 W ! I $O(^DPT(DFN,"S",DT-.1))="" S ZMSG(DVBABCNT)="No future C & P appointments found.",DVBABCNT=DVBABCNT+1 G EXIT
 K PRT F FA=DT-.1:0 S FA=$O(^DPT(DFN,"S",FA)) Q:FA=""  S L=^(FA,0),C=+L S YY=$P(L,U,2) I YY'="N"&(YY'="C")&(YY'="NA")&(YY'="CA")&(YY'="PC")&(YY'="PCA") D FA1
 ;S ZMSG(DVBABCNT)="No future C&P appointments found.",DVBABCNT=DVBABCNT+1 G EXIT
 G EXIT
 ;
FA1 S DVBCX=$P(^DPT(DFN,"S",FA,0),U,16) I $D(^SD(409.1,+DVBCX,0)) Q:$P(^(0),U,1)'["COMPENSATION"  ;compensation and pension exams only
 S ZMSG(DVBABCNT)=$$FMTE^XLFDT(FA,"5DZ")_"  "_$J(+$E(FA_"00",9,10)_":"_$E(FA_"0000",11,12),6)_"  "_$E($P($S($D(^SC(C,0)):^(0),1:""),"^"),1,21)_"  ",DVBABCNT=DVBABCNT+1 D CAL S PRT=1
 Q
 ;
EXIT S ZMSG(DVBABCNT)="",DVBABCNT=DVBABCNT+1
 K YY,CT,FA,L,C,DVBCX,DATE,DVBCLNE W !!! Q
 ;
CONT ;I IOST?1"C-".E W !!,"Press [RETURN] to continue  " R ANS:DTIME
 Q
 ;
HDR ;W ?(80-$L(DVBCLNE)\2),DVBCLNE,!!?0,"Date",?12,"Time",?18,"Clinic",?43,"  Lab",?56,"  X-Ray",?69,"  EKG",!?0 F I=0:1:79 W "-"
 Q
 ;
CAL F J=3:1:5 I $P(L,U,J)]"" S DATE(J)=$E($P(L,U,J),4,7),DATE(J)=$E(DATE(J),1,2)_"/"_$E(DATE(J),3,4)_" ",TIME(J)=$P($P(L,U,J),".",2) D CAL1
 Q
 ;
CAL1 S:TIME(J)=1 TIME(J)=10 S TIME(J)=$S($L(TIME(J))=2:TIME(J)_"00",$L(TIME(J))=3:TIME(J)_"0",1:TIME(J)),DATE(J)=DATE(J)_TIME(J)
 I $D(DATE(3)) S DATE(3)=$E(DATE(3),1,6)_$E(DATE(3),7,8)_":"_$E(DATE(3),9,10) W:$D(DATE(3)) ?42,DATE(3)
 I $D(DATE(4)) S DATE(4)=$E(DATE(4),1,6)_$E(DATE(4),7,8)_":"_$E(DATE(4),9,10) W:$D(DATE(4)) ?55,DATE(4)
 I $D(DATE(5)) S DATE(5)=$E(DATE(5),1,6)_$E(DATE(5),7,8)_":"_$E(DATE(5),9,10) W:$D(DATE(5)) ?68,DATE(5)
 I IOST?1"C-".E,$Y>18 D CONT,HDR
 I IOST?1"P-".E,$Y>45 D HDR
 K DATE,CONT
 Q
