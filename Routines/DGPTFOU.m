DGPTFOU ;ALB/JDS - PTF REPORTS ;31 MAR 87  13:00
 ;;5.3;Registration;;Aug 13, 1993
 ;
1 ;CODING REPORT
 I '$D(DGRTY) S Y=1 D RTY^DGPTUTL
 K IOP S Z="^RELEASED^CLOSED^TRANSMITTED^ALL"
 R !,"Print which PTF Status(es):",!?2,"(R)ELEASED,(T)RANSMITTED,(C)LOSED or (A)LL: ALL// ",X:DTIME G Q:'$T!(X[U) I X="" S X="A" W X
 D IN^DGHELP
 I %=-1 W !!?12,"CHOOSE FROM:",!?12,"R - to include only Released records in report",!?12,"C - to include only Closed records",!?12,"T - to include only Transmitted records",!?12,"A - for All of the above",! G 1
 S DGSTAT=X
BY S Z="^RELEASED^TRANSMISSION^CLOSE OUT^"_$S(DGRTY=1:"DISCHARGE",1:"PTF CENSUS DATE")
 W !!,"By ",$S(DGSTAT="R":"(R)ELEASE",DGSTAT="T":"(T)RANSMISSION",1:"(C)LOSE OUT")," or"
 W:DGRTY=1 " (D)ISCHARGE DATE RANGE: DISCHARGE//"
 W:DGRTY=2 " (P)TF CENSUS DATE: PTF CENSUS DATE//"
 R X:DTIME G Q:'$T!(X[U) I X="" S X=$S(DGRTY=1:"D",1:"P") W X
 D IN^DGHELP I %=-1 D HELP1 G BY
 S DGSORT=X,DGSORT1="?"
 I DGRTY=2,DGSORT="P" D CEN^DGPTUTL S:+DGCN0 DIC("B")=+DGCN0 S DIC="^DG(45.86,",DIC(0)="AEMQZ" W ! D ^DIC K DIC G Q:Y<0 S DGSORT1=+Y(0)
 S FR=$S(DGSTAT="T":3,DGSTAT="R":2,1:1)_","_DGSORT1,TO=$S(DGSTAT="R":2,DGSTAT="C":1,1:3)_","_DGSORT1
 S BY="+#STATUS,@"_$S(DGSORT="D"!(DGSORT="P"):"70",DGSTAT="T":7.4,DGSTAT="R":7.3,1:7.2),FLDS=$S(DGRTY=2:"[DGPT CENSUS CODING REPORT]",1:"[DGCODING REPORT]"),L=0,DIC="^DGPT("
 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)="_+DGRTY,DHD=$P(DGRTY0,U)_" CODING REPORT"
 W ! D EN1^DIP,Q Q
 ;
2 ;CODING CLERK REPORT
 I '$D(DGRTY) S Y=1 D RTY^DGPTUTL
 K IOP S Z="^CLOSED^RELEASED"
 R !,"Print by [C]lose Out or [R]elease Date: C// ",X:DTIME G Q:'$T!(X[U) I X="" S X="C" W X
 D IN^DGHELP I %=-1 W !,"ENTER:",!," 'C' to limit by range of Close out Dates",!," 'R' to limit by range of Release dates",! G 2
 S DGSORT=X,BY="+CODING CLERK,.01,@"_$S(DGSORT="C":"7.2",1:"7.3"),FR="?,?",TO=FR,FLDS=$S(DGRTY=2:"[DGPT CENSUS CODING REPORT]",1:"[DGCODING REPORT]"),DHD=$P(DGRTY0,U)_" PRODUCTIVITY REPORT",L=0,DIC="^DGPT("
 S DIS(0)="I $D(^DGPT(D0,0)),$P(^(0),U,11)="_+DGRTY
 D EN1^DIP
Q K %,%X,%Y,AD,BY,D0,DA,DC,DCC,DD0,DFN,DFN1,DFN2,DGD0,DHD,DHT,DI,DIC,DIE,DIS,DIS2,DJ,DLP,DN,DP,DR,DX,DY,FLDS,FR,I1,L,PR,PTF,TDD,TO,TY,X,Z,DGRTY,DGRTY0,DGSORT,DGSORT1,DGCN,DGCN0
 Q
 ;
3 ;PTF UPDATE (obsolete)
 Q
 ;
4 ;COMPREHENSIVE REPORT BY PATIENT
 K IOP W !,"In PTF file sort by any field criteria",!
 S DIC="^DGPT(",FLDS="[DGPTF]" G EN1^DIP
HELP1 W !!?12,"CHOOSE FROM:"
 I DGRTY=1 W !?12,"D - to select a range of discharge dates to have report sorted by"
 I DGRTY=2 W !?12,"P - to select all census record for a specific PTF census date"
 W !?12,$S(DGSTAT="R":"R",DGSTAT="T":"T",1:"C")," - to select a range of ",$S(DGSTAT="R":"release",DGSTAT="T":"transmission",1:"close out")
 W " dates to sort by" Q
