DGMTOPYT ;ALB/CAW - Means Test with Previous Year Threshold ;8/14/92
 ;;5.3;Registration;**33**;Aug 13, 1993
 ;
EN ; 
 I '$$RANGE^DGMTUTL("P") G ENQ
 W !! S %ZIS="PMQ" D ^%ZIS I POP G ENQ
 I '$D(IO("Q")) D MAIN G ENQ
 S Y=$$QUE
ENQ ;
 D:'$D(ZTQUEUED) ^%ZISC
 K DFN,DGBEG,DGC,DGDATE,DGDFN,DGEND,DGIEN,DGLINE,DGPAGE,DGP,DGPAT,DGPT,DGSTOP,DGTST,VA,VAERR,^TMP("DGMTO",$J)
 Q
 ;
QUE() ; -- que job
 ; return: did job que [ 1|yes   0|no ]
 ;
 K ZTSK,IO("Q")
 S ZTDESC="Previous Year Threshold Output",ZTRTN="MAIN^DGMTOPYT"
 F X="DGBEG","DGEND" S ZTSAVE(X)=""
 D ^%ZTLOAD W:$D(ZTSK) "   (Task: ",ZTSK,")"
 Q $D(ZTSK)
 ;
MAIN ;
 S DGDATE=DGBEG-.1,(DGIEN,DGSTOP,DGPAGE,DGPT)=0,$P(DGLINE,"-",IOM+1)=""
 D HDR
 F  S DGDATE=$O(^DGMT(408.31,"AP",1,DGDATE)) Q:'DGDATE!(DGDATE>DGEND)  F  S DGIEN=$O(^DGMT(408.31,"AP",1,DGDATE,DGIEN)) Q:'DGIEN  D  Q:DGSTOP
 .Q:'$G(^DGMT(408.31,DGIEN,"PRIM"))
 .S DGDFN=$P(^DGMT(408.31,DGIEN,0),U,2),DGTST=$P(^DGMT(408.31,DGIEN,0),U)
 .S DFN=DGDFN D PID^VADPT
 .S ^TMP("DGMTO",$J,$P(^DPT(DGDFN,0),U))=DGDFN_"^"_VA("PID")_"^"_DGTST
 D PRNT
 D CLOSE^DGMTUTL
 Q
HDR ; Header
 S DGC(1)="Means Test Using Previous Years Threshold"
 S DGC(2)="Date Range: "_$$FDATE^DGMTUTL(DGBEG)_" to "_$$FDATE^DGMTUTL(DGEND) D NOW^%DTC S DGC(3)="Run Date: "_$E($$FTIME^DGMTUTL(%),1,18)
 W:$E(IOST,1,2)["C-" @IOF F I=1:1:3 W !?(IOM-$L(DGC(I))/2),DGC(I)
 S DGPAGE=DGPAGE+1 W !?68,"Page ",DGPAGE,!,DGLINE,!
 W !?5,"Patient Name",?50," Patient ID ",?65,"Date of Test"
 W !?5,"------------",?50,"------------",?65,"------------",!
 Q
PRNT ;Print patients
 U IO I '$D(^TMP("DGMTO",$J)) W !,"NO MEANS TEST WITH PREVIOUS YEARS THRESHOLD" Q
 F  S DGPT=$O(^TMP("DGMTO",$J,DGPT)) Q:DGPT=""  S DGPAT=^(DGPT) D  Q:DGSTOP
 .W !,?5,$P(^DPT(+DGPAT,0),U),?50,$P(DGPAT,U,2),?65,$$FDATE^DGMTUTL($P(DGPAT,U,3))
 .D CHK
 Q
 ;
CHK ;Check to pause on screen
 I ($Y+5)>IOSL,$E(IOST,1,2)="C-" D PAUSE S DGP=Y D:DGP HDR I 'DGP S DGSTOP=1 Q
 I $E(IOST,1,2)="P-",($Y+5)>IOSL D HDR Q
 Q
PAUSE ;
 W ! S DIR(0)="E" D ^DIR K DIR W !
 Q
 ;
