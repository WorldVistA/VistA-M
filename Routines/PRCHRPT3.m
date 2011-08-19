PRCHRPT3 ;BOISE/TKW-SUPPLEMENT TO PRCHRPT2--ACTUAL PRINT OF FPDS REPORTS ;8JUL1986/7:20 AM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN S PRCHPAGE=0,PRCHDY=99 S ^TMP($J,"TOTAL")="** REPORT TOTAL **"
 I PRCHRPT=1 S N="BREAKOUT CODE",PRCHRFLG="B",PRCHKEY=-1 D RD1 S X=^TMP($J,"TOTAL") D PRTT
 I PRCHRPT=1 S N="TYPE CODE",PRCHRFLG="T",PRCHPAGE=0,PRCHDY=99,PRCHKEY=-1,^TMP($J,"TOTAL")="** REPORT TOTAL **" D RD1 S X=^TMP($J,"TOTAL") D PRTT Q
 I PRCHRPT=2 S N="P.O.NUMBER",PRCHPONO=-1 D RD2 S X=^TMP($J,"TOTAL") D PRTT Q
 I PRCHRPT=3 S N="CONTRACT NO.",PRCHRFLG="C",PRCHKEY=-1 D RD1 S X=^TMP($J,"TOTAL") D PRTT Q
 I PRCHRPT=4 S N="",X=^TMP($J),PRCHKEY="" D PRT1 Q
 I PRCHRPT=5 S N="FUND CONTROL POINT",PRCHRFLG="F",PRCHKEY=-1 S (PRCHOTCT,PRCHLTOT,PRCHTTOT)=0 D
 . D RD1
 . W !?30,"----------",?45,"---------",?65,"------------"
 . W !?15,"TOTALS",?35,PRCHOTCT,?50,PRCHLTOT,?68,PRCHTTOT
 . K PRCHOTCT,PRCHLTOT,PRCHTTOT Q
 Q
RD1 ; READ REPORT FILE ^TMP AND PRINT REPORT
 S PRCHKEY=$O(^TMP($J,"R",PRCHRFLG,PRCHKEY)) Q:PRCHKEY=""  S X=^(PRCHKEY) D  D PRT1
 . S PRCHOTCT=PRCHOTCT+$P(X,U,2)
 . S PRCHLTOT=PRCHLTOT+$P(X,U,3)
 . S PRCHTTOT=PRCHTTOT+$P(X,U,4)
 S $P(^TMP($J,"TOTAL"),U,2)=$P(^TMP($J,"TOTAL"),U,2)+$P(X,U,2),$P(^("TOTAL"),U,3)=$P(^("TOTAL"),U,3)+$P(X,U,3),$P(^("TOTAL"),U,4)=$P(^("TOTAL"),U,4)+$P(X,U,4)
 G RD1
RD2 ; READ ^TMP FILE FOR REPORT BY P.O.NUMBER
 S PRCHPONO=$O(^TMP($J,"R",PRCHPONO)) Q:'PRCHPONO  S X=^(PRCHPONO) D PRT2
 S $P(^TMP($J,"TOTAL"),U,2)=$P(^TMP($J,"TOTAL"),U,2)+1,$P(^("TOTAL"),U,3)=$P(^("TOTAL"),U,3)+$P(X,U,2)
 S I=0,PRCHTOT=0 F K=1:1 S I=$O(^TMP($J,"R",PRCHPONO,"C",I)) Q:I=""  S X=^(I),PRCHTOT=PRCHTOT+$P(X,U,2) D PRT3 S $P(^("TOTAL"),U,4)=$P(^TMP($J,"TOTAL"),U,4)+$P(X,U,2)
 I K>2 D:PRCHDY>(IOSL-4) HDR W ?57,"*TOTAL*",?66,$J(PRCHTOT,11,2),! S PRCHDY=PRCHDY+1
 W ! S PRCHDY=PRCHDY+1 G RD2
PRT1 D:PRCHDY>(IOSL-6) HDR W PRCHKEY,?3,$P(X,U,1) I $L($P(X,U,1))>27 W ! S PRCHDY=PRCHDY+1
 W ?30,$J($P(X,U,2),8),?45,$J($P(X,U,3),8),?66,$J($P(X,U,4),11,2),!! S PRCHDY=PRCHDY+2 Q
PRT2 D:PRCHDY>(IOSL-6) HDR W $P(PRCHPONO,"-",2),?12,"P.O.DATE:",$P(X,U,1),?45,$J($P(X,U,2),8),! S PRCHDY=PRCHDY+1 Q
PRT3 D:PRCHDY>(IOSL-4) HDR W:K=1 ?18,"CONTRACTS:" W ?30,I
 W ?66,$J($P(X,U,2),11,2),! S PRCHDY=PRCHDY+1 Q
PRTT ; PRINT REPORT GRAND TOTALS
 D:PRCHDY>(IOSL-7) HDR W !!!,?8,$P(X,U,1)
 W ?30,$J($P(X,U,2),8),?45,$J($P(X,U,3),8),?66,$J($P(X,U,4),11,2),! Q
HDR S PRCHPAGE=PRCHPAGE+1 W @IOF,"PROCUREMENT & ACCOUNTING TRANSACTIONS STATISTICS",?51,PRCHPDAT,?74,"PAGE ",PRCHPAGE,!
 W "CONTROL POINTS/MONTH FOR STATION: ",PRC("SITE")
 W "      P.O.DATES "_PRCHPFR_" - "_PRCHPTO,!!
 W ?45,"LINE/ITEM",!,N,?30,"P.O.COUNT",?47,"TOTAL",?65,"TOTAL AMOUNT",!
 F J=0:1:(IOM-2) W "-"
 W !! S PRCHDY=6 Q
DEL2237 ; The option Delete 2237 Request from Worksheet file is being de-
 ; activated.  It is no longer needed, as the 2237s with status of
 ; Returned to Service by PPM or by P&C no longer appear on the 
 ; Outstanding 2237 Report.  This Delete option was removing the
 ; 2237 from file 443,but leaving the approving e-sig info in file 
 ; file 410, making inaccessable to A&MM and to the service.
 W !!,"This option has been de-activated, as it is no longer needed."
 W !,"Instead of deleting the 2237, return it to the service.  2237s"
 W !,"returned to the service no longer appear on the Outstanding 2237"
 W !,"Report."
 Q
