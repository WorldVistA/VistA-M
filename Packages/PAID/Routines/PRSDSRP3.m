PRSDSRP3 ;HISC/GWB-SALARY REPORT PRINT ;6/10/93  08:54
 ;;4.0;PAID;;Sep 21, 1995
ASKDEV K %ZIS,IOP S %ZIS="QM",%ZIS("B")="" D ^%ZIS I POP K %ZIS Q
 I $D(IO("Q")) S ZTIO=ION,ZTDESC="PAID SALARY REPORT",ZTRTN="START^PRSDSRP3" D ^%ZTLOAD W:$D(ZTSK) !,"Request Queued!" D EXIT Q
 U IO D START
 D:$E(IOST,1)'="C" ^%ZISC
 Q
START D NOW^%DTC S Y=$J(%,"",4) D DD^%DT S PRNTDT=Y
 S $P(DASHES,"-",80)="-",PAGE=0,FIRST="1ST",PRTC=1
 S SITE=$G(^DD("SITE")) S:SITE'="" SITE=" FOR "_SITE
 S (SALTL,SALPRJTL)=0
 S CCORG="" F  S CCORG=$O(^PRSP(454.1,"B",CCORG)) Q:CCORG=""  S CCORGIEN=0,CCORGIEN=$O(^PRSP(454.1,"B",CCORG,CCORGIEN)) I $D(^PRSP(454.1,CCORGIEN)),^PRSP(454.1,CCORGIEN,6)'="" D WRITE Q:PRTC=0
 G:PRTC=0 EXIT
 W !,DASHES
 I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP G:PRTC=0 EXIT D HDR
 W !,?23,"TOTAL",?32,$J($FN(SALTL,",",2),12),?54,$J($FN(SALPRJTL,",",2),14)
 I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP G:PRTC=0 EXIT D HDR
 W !,DASHES
 I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP G:PRTC=0 EXIT D HDR
 W ! I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP G:PRTC=0 EXIT D HDR
EXIT I $D(ZTQUEUED) S ZTREQ="@" D KILL^XUSCLEAN Q
WRITE I FIRST="1ST" S Y=$P(^PRSP(454.1,CCORGIEN,0),U,3) D DD^%DT S COMPDT=Y D HDR S FIRST=""
 S SAL=$P(^PRSP(454.1,CCORGIEN,6),U,1)
 S SALPRJ=$P(^PRSP(454.1,CCORGIEN,6),U,2)
 S SALTL=SALTL+SAL,SALPRJTL=SALPRJTL+SALPRJ
 W !,$P(^PRSP(454.1,CCORGIEN,0),U,1),?32,$J($FN(SAL,",",2),12),?54,$J($FN(SALPRJ,",",2),14)
 I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP Q:PRTC=0  D HDR
 W !,DASHES
 I $Y>(IOSL-4) D:$E(IOST,1)="C" PRTC^PRSDSRP Q:PRTC=0  D HDR
 Q
HDR W:$Y>0 @IOF S PAGE=PAGE+1
 W !,"SALARY REPORT",SITE,?44,"COMPILATION DATE: ",COMPDT
 W !,"PAGE: ",PAGE,?50,"PRINT DATE: ",PRNTDT
 W !!
 W !,"SERVICE NAME",?34,"SALARY YTD",?52,"PROJECTED SALARY"
 W !,DASHES,!,DASHES
 Q
