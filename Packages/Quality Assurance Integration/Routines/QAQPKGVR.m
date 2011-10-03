QAQPKGVR ;HISC/DAD-QM PACKAGES RUNNING AT YOUR SITE ;12/7/94  08:14
 ;;1.7;QM Integration Module;;07/25/1995
 K %ZIS S %ZIS="QM" W ! D ^%ZIS G:POP EXIT I $D(IO("Q")) S ZTRTN="ENTSK^QAQPKGVR",ZTDESC="QM packages installed report" D ^%ZTLOAD G EXIT
ENTSK ;
 S QAQVER=$S($D(^QA(740,1,"VER"))#2:^("VER"),1:""),QAQQUIT=0,PAGE=1,%DT="",X="T" D ^%DT X ^DD("DD") S TODAY=Y K QAQPKG,UNDL S $P(UNDL,"-",81)=""
 F QA=1:1 S PKG=$P($T(PKG+QA),";;",2) Q:PKG=""  S VER=$P(QAQVER,"^",QA),QAQPKG(PKG)=$S(VER:"Version "_VER,1:"Not installed")
 U IO D HDR S PKG=""
 F  S PKG=$O(QAQPKG(PKG)) Q:PKG=""!QAQQUIT  W !!,PKG,?40,QAQPKG(PKG) D:$Y>(IOSL-6) HEAD
EXIT ;
 W ! D ^%ZISC
 K %DT,%ZIS,DIR,PAGE,PKG,QA,QAQPKG,QAQQUIT,QAQVER,TODAY,UNDL,VER,X,Y,ZTDESC,ZTRTN
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
HEAD ;
 I $E(IOST)="C" K DIR S DIR(0)="E" D ^DIR S QAQQUIT=$S(Y'>0:1,1:0) Q:QAQQUIT
HDR W:($E(IOST)="C")!(PAGE>1) @IOF
 W !,UNDL,!?14,"QM Packages Installed at Your Site as of ",TODAY,?72,"Page: ",PAGE,!,UNDL S PAGE=PAGE+1
 Q
PKG ;;PACKAGE NAMES - in same order as ^QA(740,1,"VER") node pieces
 ;;Occurrence Screen
 ;;Clinical Monitoring System
 ;;Survey Generator
 ;;Credentials Tracking
 ;;QM Integration Module
 ;;Incident Reporting
 ;;Patient Representative
