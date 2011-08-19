DGPMGL1 ;ALB/MRL/LM/MJK - G&L ENTRY POINT CONT.; 1 FEB 89
 ;;5.3;Registration;;Aug 13, 1993
 ;
 Q
 ;  Continuation from DGPMGL
A S REM=0 I BS!(GL) S Y=LD X:Y]"" ^DD("DD") W !!,"LAST BED STATUS REPORT TOTALS EXIST FOR ",Y
 I TSR,TSRI]"",TSLD S Y=TSLD X:Y]"" ^DD("DD") W !!,"LAST TREATING SPECIALTY REPORT TOTALS EXIST FOR ",Y
 S X1=DT,X2=-1 D C^%DTC S YD=X
 ;  Updating last date G&L generated
 I LD'=YD S X1=LD,X2=1 D C^%DTC S (LD,Y)=X X ^DD("DD")
 I LD=YD S LD=DT
 K ^UTILITY($J)
 S DD=Y
 ;
WHEN ;  Asking when to print report/s
 W !!,"PRINT REPORT",$S(GL&BS:"S",1:"")," FOR WHICH DATE: ",DD,"// " R X:DTIME
 G Q:X["^"!('$T) S:X="" X=DD S %DT="EPX" D ^%DT G WHEN:Y<0
 S (RD,X1)=+Y,X2=-1 D C^%DTC S PD=X
 I Y<DGPM("G") S Y=+DGPM("G") X ^DD("DD") W !!,"EARLIEST DATE ALLOWED IS ",Y,".",*7 G WHEN
 I Y>DT S Y=DT X ^DD("DD") W !!,"CHOOSE A DATE ON OR BEFORE ",Y,".",*7 G WHEN
 I Y<LD S X1=Y,X2=-1 D C^%DTC
 I '$D(^DG(41.9,WD,"C",X,0)) W !!,"NO TOTALS EXIST FOR PREVIOUS DAY!!",*7 G WHEN
 I RD=DT,BS W !!," * BED STATUS REPORT WILL NOT BE CALCULATED...TODAY'S ACTIVITY IS INCOMPLETE! *",*7 S BS=0
 I RD=DT,TSR W !!," * THE TSR WILL NOT PRINT...TODAY'S ACTIVITY IS INCOMPLETE! *",*7 S TSR=0
 I 'GL,'BS,'TSR G WHEN
 I TSR I TSRI]"" I RD<TSRI S Y=+TSRI X ^DD("DD") W !!,"EARLIEST DATE FOR TREATING SPECIALTY REPORT IS ",Y,".",*7,!!,"TREATING SPECIALTY REPORT WILL NOT BE PRINTED FOR THE DATE SELECTED!" I 'BS,'GL G WHEN
 I RD=YD,$D(^DG(43,1,"NOT")),$P(^("NOT"),"^",8) D ^DGABUL ;  Transmit Overdue Absence Bulletin
ADC I BS D ^DGPMGL2
 I 'BS&('TSR) S RC=0 D ^DGPMGL2
 I BS!(TSR) D RC I $D(%) G:%=-1 Q^DGPMGL I '$D(RCCK) G:%=2 Q^DGPMGL
 W !!,"Note: This output should be printed at a column width of 132.",!
 S %ZIS="QM" D ^%ZIS G Q:POP!(IO="") I $D(IO("Q")) K IO("Q") D QUE G Q
 U IO
 ;
GO D CLEAN^DGPMGLG
 D NOW^%DTC S Y=$E(%,1,12) X ^DD("DD") S DGNOW=Y ; used to print date/time of report
 D:$D(RC) UP43^DGPMBSR,^DGPMBSR D ^DGPMGLG
 S DIE="^DG(43,",DA=1,DR="54////@;55////@;56////@" D ^DIE
Q G DONE^DGPMGLG
 ;
RC ;  G&L corrections
 S RC=$S($P(DGPM("G"),"^",7)>+DGPM("G"):$P(DGPM("G"),"^",7),1:+DGPM("G")),CD=$O(^DGS(43.5,"AGL",RC-1))
 I CD,CD'>RD S Y=CD X ^DD("DD") W !!,"G&L corrections exist from ",Y,"."
 S X1=DT,X2=-7 D C^%DTC S LW=X ; Last Week
 I CD>LW,CD'>RD S RC=CD,%=1 W !,"SINCE G&L CORRECTIONS ARE RECENT (WITHIN LAST WEEK) RECALCULATION WILL OCCUR",!,"AUTOMATICALLY AS THE "_$S('TSR:"BED STATUS REPORT",'BS:"TREATING SPECIALTY REPORT",1:"BSR AND TSR")_" IS COMPUTED!" G RCQ
 I $O(^DIC(42,"AGL",0)) S WD=$O(^DIC(42,"AGL",$O(^(0)),0)) I '$D(^DG(41.9,WD,"C",RD,0)) S RC=RD,%=1 G RCQ
 ;
RC1 D RCCK^DGPMBSAR ;  Check for ReCalc already running
 I '$D(RCCK) I $P(DGPM("GLS"),"^",5) I $D(%) I %=2!(%=-1) Q
 I $D(RCR) S RC=0 Q
 W !!,"Recalculate BSR" W:TSR "/TSR" W " Totals" S %=2 D YN^DICN G RCQ:%=-1
 I % S RC=$S(%=2:0,'CD:RD,CD<RD:CD,1:RD) G RCQ
 I '% W !?4,"Answer YES to recalculate totals to insure accurancy or NO to simply print",!?4,"report with existing CENSUS file totals." G RC1
RCQ K LW Q
 ;
QUE S ZTIO=ION_";"_$S($D(IOST)#2:IOST,1:"")_";"_$S($D(IOM)#2:IOM,1:"")_";"_$S($D(IOSL)#2:IOSL,1:""),ZTDESC=$S(GL&(BS):"G&L AND BSR",GL:"G&L",1:"BSR")_" GENERATION",ZTRTN="GO^DGPMGL1"
 F I="DUZ","DIV","RD","TSR","TSRI","BS","GL","DGPM(""G"")","DGPM(""GL"")","DUZ","REM","PD","RC","RM","SS","MT","TS","CP","OS","SNM","VN","SF","TSD" S ZTSAVE(I)=""
 D ^%ZTLOAD Q
 ;
VAR ;  REM=Recalc Patient Days  ;  LD=Last Date G&L was run  ;  YD=YesterDay  ;
 ;  RD=Report Date  ;  PD=Previous Date ; CD= Correction Date ;
 ;  RC=ReCalc from date  ;
