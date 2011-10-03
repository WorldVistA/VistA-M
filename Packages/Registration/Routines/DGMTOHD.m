DGMTOHD ;ALB/CAW - Hardship reivew date ;4/26/93
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;
EN ; 
 I '$$RANGE^DGMTUTL G ENQ
 W !! S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D MAIN G ENQ
 S Y=$$QUE
ENQ ;
 D:'$D(ZTQUEUED) ^%ZISC
 K DGBEG,DGC,DGEND,DG,DGLINE,DGPAGE,DGMT0,VA,VAERR Q
 ;
MAIN ;
 S DG=0 U IO
 S DGPAGE=0,$P(DGLINE,"-",IOM+1)=""
 D HDR
 F  S DG=$O(^DGMT(408.31,"AE",1,DG)) Q:'DG  S DGMT0=^DGMT(408.31,DG,0) D
 .Q:$P(DGMT0,U,21)>DGEND!($P(DGMT0,U,21)<DGBEG)
 .D CHK
 .W !,?5,$P($G(^DPT($P(DGMT0,U,2),0)),U),?50,$$PID($P(DGMT0,U,2)),?65,$$FDATE^DGMTUTL($P(DGMT0,U,21))
 I '$D(DGMT0) W !,"No review dates found between selected date range."
 D CLOSE^DGMTUTL
MAINQ Q
 ;
PID(DFN) ;function to return pid
 ;INPUT -  DFN
 ;OUTPUT - PID or UNKNOWN
 D PID^VADPT6
 Q $S(VA("PID")]"":VA("PID"),1:"UNKNOWN")
 ;
HDR ; Header
 S DGC(1)="Hardship Review Date(s)"
 S DGC(2)="Date Range: "_$$FDATE^DGMTUTL(DGBEG)_" to "_$$FDATE^DGMTUTL(DGEND) D NOW^%DTC S DGC(3)="Run Date: "_$E($$FTIME^DGMTUTL(%),1,18)
 W:$E(IOST,1,2)["C-" @IOF F I=1:1:3 W !?(IOM-$L(DGC(I))/2),DGC(I)
 S DGPAGE=DGPAGE+1 W !?68,"Page ",DGPAGE,!,DGLINE,!
 W !?5,"Patient Name",?50," Patient ID ",?65,"Review Date"
 W !?5,"------------",?50,"------------",?65,"-----------",!
 Q
CHK ;Check to pause on screen
 I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE S DGP=Y D:DGP HDR I 'DGP S DGSTOP=1 Q
 I $E(IOST,1,2)="P-",($Y+5)>IOSL D HDR Q
 Q
PAUSE ;
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Hardship Review Output",ZTRTN="MAIN^DGMTOHD"
 F X="DGBEG","DGEND" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
