RMPFDE ;DDC/KAW-DISPLAY REQUESTS FOR ELIGIBILITY DETERMINATION ;07/06/01   9:25 AM
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;**17,18**;07/06/01
 K RMPFX,RMPRVIEW
 S RMPFVFG=1
 D HEAD1
 D LIST
 G:$D(RMPFOUT) END
 G:$D(RMPRVIEW) RMPFDE
 D LISTOT
 I RMPFVFG D CONT
 G:$D(RMPRVIEW) RMPFDE
 ;G RMPFDE:$D(RMPFX)
END K DDH,DFN,DISYS,EL,RD,RX,TT,VA,VADM,VAERR,Y
 K RMPFOUT,RMPQOUT,I,%XX,%YY,Y Q
LIST ;;List active requests for eligibility determination
 ;; input: None
 ;;output: RMPFDS1
 S (RD,TT)=0 K RMPFS1,RMPFX
L1 S RD=$O(^RMPF(791810,"AF",RD)) Q:'RD
 S RX=0
L2 S RX=$O(^RMPF(791810,"AF",RD,RX)) G L1:'RX
 G L2:'$D(^RMPF(791810,RX,0))
 S DFN=$P(^(0),U,4)
 D DEM^VADPT S Y=RD
 D DD^%DT
 S EL=$P($G(^RMPF(791810,RX,2)),U,6)
 I EL,$D(^RMPF(791810.4,EL,0)) S EL=$P(^(0),U,1)
 S TT=TT+1,RMPFS1(TT)=RX
 I RMPFVFG,$Y>19 D  Q:$D(RMPFOUT)  Q:$D(RMPRVIEW)
 .D CONT
 .Q:$D(RMPFOUT)
 .D HEAD1
 I IOST?1"P-".E,$Y>(IOSL-5) D HEAD1
 W !,$J(TT,2),?4,Y,?24,$E(VADM(1),1,16),?43,$P(VADM(2),U,2),?56,$E(EL,1,24)
 G L2
LISTOT W !!,"Total Orders:  ",TT
 I IOST?1"P-".E W @IOF
 Q
HEAD1 W @IOF,!?17,"ROES ORDERS PENDING ELIGIBILITY DETERMINATION"
 W !,"Station: ",RMPFSTAP,?68,RMPFDAT
 W ! F I=1:1:80 W "-"
 W !?1,"#",?7,"Request Date",?26,"Patient Name"
 W ?47,"SSN",?58,"Proposed Eligibility"
 W !,"--",?4,"------------------",?24,"-----------------"
 W ?43,"-----------",?56,"------------------------"
 Q
CONT K RMPRVIEW
 F I=1:1 Q:$Y>19  W !
CONT1 W !!,"Type the number of the order to process, <P>rint or <RETURN> to continue: "
 D READ
 Q:$D(RMPFOUT)
 I $D(RMPFQUT) D  G CONT1
 .W !!,"Enter the number to the left of the order to select it for processing"
 .W !?9,"a <P> to print the list or",!?11,"<RETURN> to continue."
 Q:Y=""
 I "Pp"[Y D QUE Q
 I $D(RMPFS1(Y)) S RMPFX=RMPFS1(Y) D ^RMPFDE1 S RMPRVIEW=""
 Q
QUE W ! S %ZIS="NPQ" D ^%ZIS G END:POP
 I IO=IO(0),'$D(IO("S")) S RMPRVIEW="",RMPFVFG=1 G QUEE
 I $D(IO("S")) S %ZIS="",IOP=ION D ^%ZIS D  G QUEE
 .S RMPFVFG=0
 .D HEAD1,LIST,LISTOT
 .D ^%ZISC
 .S RMPRVIEW=""
 .S RMPFVFG=1
 S RMPFVFG=0
 S ZTRTN="PRINT^RMPFDE",ZTSAVE("RMPF*")=""
 S ZTIO=ION D ^%ZTLOAD
 D HOME^%ZIS S RMPRVIEW="",RMPFVFG=1
 W:$D(ZTSK) !!,"*** Request Queued ***" H 2
QUEE K %T,%ZIS,POP,ZTRTN,ZTSAVE,ZTIO,ZTSK Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q
PRINT D HEAD1,LIST,LISTOT Q
