LRCAPAM0 ;SLC/FHS - INTRO FOR MOVE WKLD DATA FROM 64.1 TO 67.9;10/14/91 08:15
 ;;5.2;LAB SERVICE;**81,141**;Sep 27, 1994
 D ^LRPARAM I '$P($G(LRLABKY),U,2) W !!?10,"You do not have the proper Security Key ...   Aborted ",!! G END
 L +^LRO(67.9):1 I '$T W !!?5,"Someone else is editing this file",!! G END
 S LINE="PHASE 1 OF LMIP DATA COLLECTION" W !?(IOM-$L(LINE))/2,LINE
 S LINE="Extract Monthly Workload Data From ^LRO(64.1 and placing" W !?(IOM-$L(LINE))/2,LINE
 S LINE="the Totals into ^LRO(67.9 in preparation for data" W !?(IOM-$L(LINE))/2,LINE
 S LINE="transmission to National Data Base" W !?(IOM-$L(LINE))/2,LINE,!!
 K DIC,LINE S (LRPRI,LRIN)="",DIC="^LRO(64.1,",DIC(0)="AQNEZ"
IN D ^DIC G:$E(X)=U!(Y<1) END I Y>0 S LRIN=+Y
 S LRPRI=+$P($G(^XMB(1,1,"XUS")),U,17) I LRPRI,$L($G(^DIC(4,LRPRI,0)),U) S LRPRIN=$P(^(0),U)
 I 'LRPRI W !!?5,"Your Site is not defined in ^XMB(1,1,XUS) 17th Piece",!!,$C(7),!,"Process aborted ",! G END
DATE K %DT S %DT("A")="Begin with what date ",%DT="APEX" D ^%DT G:Y<1 END
 S LRDTS=Y
EDATE K %DT S %DT("A")="End with what date ",%DT="APEX" D ^%DT G:Y<1 END
 S LRDTE=Y S LREND=0
 I LRDTS>LRDTE S X=LRDTE,LRDTE=LRDTS,LRDTS=X
 S LRDTS=LRDTS-.9999,LRDTE=LRDTE+.9999
 S LRCHK=$O(^LRO(64.1,LRIN,1,LRDTS)) S:'LRCHK!(LRCHK>LRDTE) LREND=1 I $G(LREND) W !!?5,"No data for this date range ",!! G END
 W @IOF
 Q
END ;
 D END^LRCAPAM1 S LREND=1 Q
