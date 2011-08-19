DGPTFM7 ;ALB/MJK - Display Phys. MPCR mvts ; 11/30/06 8:31am
 ;;5.3;Registration;**78,590,594,683,729**;Aug 13, 1993;Build 59
 ;
EN ; entry pt to display MPCR screen
 ; -- PTF and DGPTFMT must be defined
 ;
 S DGMAX=7,DGPTIFN=PTF,DGTOT=0 G BYPASS:DGPTFMT<2
 D FDT^DGPTUTL S DGFMTDT=Y
 F NODE=535,"M" F I=0:0 S I=$O(^DGPT(DGPTIFN,NODE,I)) Q:'I  I $D(^(I,0)) S Y=$S($P(^(0),U,10):$P(^(0),U,10),1:DT+.2359),^UTILITY($J,"DGCDR",Y)=NODE_U_I,^UTILITY($J,"DG"_NODE,Y)=I
 S P=$S('$D(^DGPT(DGPTIFN,0)):DGFMTDT+1,$P(^(0),U,2)>DGFMTDT:$P(^(0),U,2),1:DGFMTDT)
 F I=0:0 S I=$O(^UTILITY($J,"DGCDR",I)) Q:'I  I I>DGFMTDT S DGTOT=DGTOT+1,^(I)=^(I)_"^"_P,P=I
BYPASS S (DGC,DGLDT)=0
LOOP ;
 D HEADER:$Y>(IOSL-15) S DGLAST("DT")=DGLDT,DGLAST("C")=DGC
 I DGPTFMT<2 W !!,"  MPCR information not required for this admission."
 F DGLDT=DGLDT:0 S DGLDT=$O(^UTILITY($J,"DGCDR",DGLDT)) Q:'DGLDT  I DGLDT>DGFMTDT S X=^(DGLDT) D PRT I 'DGPR Q:'(DGC#DGMAX)!(DGC=DGTOT)
 I DGPR D KILL Q
 W:DGC<DGTOT !,"...more movements available"
 F I=$Y:1:18 W !
 ;
 K X S $P(X,"-",81)="" W X
 I $D(DGBRCH) G @DGBRCH
 W !,"Enter <RET> to ",$S(DGC'<DGTOT:"go to MAS screen",1:"display more MPCR information"),!,"      '^N'  to go to screen N,  or '^' to abort: <",$S(DGC'<DGTOT:"MAS",1:"RET"),">// " R X:DTIME S:'$T X="^",DGPTOUT=""
 I X="^" D KILL G Q^DGPTF
 I X="",DGC<DGTOT G LOOP
 S:X="" X="^MAS"
 I X?1"^".E D KILL S DGPTSCRN="CDR" G ^DGPTFJ
 ;
HELP ; -- screen help
 I DGC<DGTOT W !,"Press return to see more MPCR information"
 I DGC'<DGTOT W !,"Press return to go to the 'MAS' screen"
 W !,"        '^'  to stop the display"
 W !,"        '^N' to jump to screen #N (appears in upper right of screen '<N>')"
 R !!,"Enter <RET>: ",X:DTIME
 S DGC=DGLAST("C"),DGLDT=DGLAST("DT") G LOOP
 ;
KILL ; -- kill off locals
 K ^UTILITY($J,"DGCDR"),^("DG535"),^("DGM"),DGCDR,DGC,DGI0,DGICDR,DGLDT,DGLVE,DGPASS,DG5SP,DG5CDR,DGMSP,DGMCDR,DGMDRG,DGMAX,DGTOT,DGWARD,DGPTIFN,DGLAST,DGFMTDT,DGLDTE,DGCDR0,DGM0,DGMTY,P,I
 Q
 ;
HEADER ;
 I DGPR D HEAD^DGPTFMO
 I 'DGPR W @IOF,HEAD,?72 S Z="<MPCR>" D Z^DGPTFM
 W !?23,"Rec",?38,"Losing Ward",?54,"PTF"
 W !?4,"Losing Date",?23,"Type",?28,"Ward/DRG",?38,"MPCR/Spec",?54,"MPCR/Spec",?68,"Lve/Pas/ Los"
 W !,"--------------------------------------------------------------------------------"
 Q
 ;
PRT ; -- collect 501 and 535 data and then print
 ; 
 I $P(X,U)="M" S DGMTY=501,(Z,DGM0)=^DGPT(DGPTIFN,"M",+$P(X,U,2),0),DGMDRG=$S($D(^("P")):$P(^("P"),U),1:""),Y=+$O(^UTILITY($J,"DG535",DGLDT-.0000001)),DGCDR0=$S('$D(^(Y)):"",$D(^DGPT(DGPTIFN,535,+^(Y),0)):^(0),1:"")
 ;
 I $P(X,U)="535" S DGMTY=535,(Z,DGCDR0)=^DGPT(DGPTIFN,535,+$P(X,U,2),0),Y=+$O(^UTILITY($J,"DGM",DGLDT-.0000001)),DGM0=$S('$D(^(Y)):"",$D(^DGPT(DGPTIFN,"M",+^(Y),0)):^(0),1:""),DGMDRG=""
 ;
 N DGLOS S X1=DGLDT,X2=$P(X,U,3) D ^%DTC S X=X-$P(Z,U,3),DGLOS=$J($S(X>0:X,1:1),4)
 S DGC=DGC+1,DGLVE=$J($P(Z,U,3),3),DGPASS=$J($P(Z,U,4),3)
 S Y=DGLDT X ^DD("DD") S DGLDTE=Y
 ;S DGMSP=$E($S($D(^DIC(42.4,+$P(DGM0,U,2),0)):$P(^(0),U),1:"UNKNOWN"),1,14),DGMCDR=$J(+$P(DGM0,U,16),7,2)
 ;S DG5SP=$E($S($D(^DIC(42.4,+$P(DGCDR0,U,2),0)):$P(^(0),U),1:"UNKNOWN"),1,14),DG5CDR=$J(+$P(DGCDR0,U,16),7,2)
 I $D(^DIC(42.4,+$P(DGM0,U,2),0)) D
 . S DGMSP=$P(^DIC(42.4,+$P(DGM0,U,2),0),"^",2)
 . I DGMSP="" S DGMSP=$P(^DIC(42.4,+$P(DGM0,U,2),0),"^")
 . S DGMSP=$E(DGMSP,1,14)
 E  S DGMSP="UNKNOWN"
 S DGMCDR=$J(+$P(DGM0,U,16),7,2)
 I $D(^DIC(42.4,+$P(DGCDR0,U,2),0)) D
 . S DG5SP=$P(^DIC(42.4,+$P(DGCDR0,U,2),0),"^",2)
 . I DG5SP="" S DG5SP=$P(^DIC(42.4,+$P(DGCDR0,U,2),0),"^")
 . S DGMSP=$E(DGMSP,1,14)
 E  S DG5SP="UNKNOWN"
 S DG5CDR=$J(+$P(DGCDR0,U,16),7,2)
 S DGWARD=$E($S($D(^DIC(42,+$P(DGCDR0,U,6),0)):$P(^(0),U),1:"UNKNOWN"),1,8)
 ;
 W !,$J(DGC,3),?4,DGLDTE,?23,DGMTY,?28,DGWARD,?38,DG5CDR,?54,DGMCDR,?68,DGLVE,"/",DGPASS,"/",DGLOS,!?28,DGMDRG,?38,DG5SP,?54,DGMSP
 Q
 ;
INQ ; -- entry point for inquire option
 ;
 S:'$D(DC) DC=0 S PTF=D0,DGPR=1 D EN,KILL K PTF Q:$Y<(IOSL-15)
 I $E(IOST,1)="C" W *7 R X:DTIME I X=U S DN=0 Q
 W @IOF,! X:$D(^UTILITY($J,2)) ^(2) W ! F %=1:1:IOM W "_"
 W !,"("_$P(^DPT(+^DGPT(D0,0),0),U,1)_")",!
 Q
DT I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))," " W:Y#100 $J(Y#100\1,2),"," W Y\10000+1700 W:Y#1 "  ",$E(Y_0,9,10),":",$E(Y_"000",11,12)
 Q
 ;
